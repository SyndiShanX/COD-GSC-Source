/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\mp_agent_damage.gsc
***********************************************/

register_ai_damage_callbacks() {
  level.agent_funcs["actor_enemy_lw_base_br"]["on_damaged"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_base_br"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_base_br"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["on_damaged"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["gametype_on_damage_finished"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["gametype_on_killed"] = ::callbacksoldieragentgametypekilled;
  level._id_238D7505B0146B84 = scripts\mp\damage::addattacker;
}

callbacksoldieragentdamaged(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_E851FFA44B7E0D54 = self;

  if(!isDefined(_id_E851FFA44B7E0D54.agent_type)) {
    return;
  }
  if(!isDefined(objweapon))
    objweapon = sweapon;

  if(smeansofdeath != "MOD_SUICIDE") {
    if(is_friendly_damage(_id_E851FFA44B7E0D54, einflictor))
      return;
  }

  if(!isDefined(eattacker))
    eattacker = _id_E851FFA44B7E0D54;

  _id_99466D795331383A = should_do_damage_checks(eattacker, idamage, smeansofdeath, sweapon, shitloc, _id_E851FFA44B7E0D54);

  if(!_id_99466D795331383A) {
    return;
  }
  idflags = idflags | 4;
  _id_A95F61E7118777D1 = idamage;
  _id_5C3F9357F11D2223 = objweapon.basename;
  _id_C0B9C9A4FA4EEF84 = objweapon.classname;
  _id_EAC756C4A01AA740 = is_suicide_bomber();
  isinlaststand = istrue(eattacker.inlaststand);
  ismeleedamage = smeansofdeath == "MOD_MELEE";
  _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";
  _id_379485F96865DB6D = isDefined(eattacker) && isPlayer(eattacker);
  _id_7543D4FE49C53684 = isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  isjuggernaut = isDefined(_id_E851FFA44B7E0D54.unittype) && _id_E851FFA44B7E0D54.unittype == "juggernaut";
  headshot = _id_A3192D2F80ED4FF8 && scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);
  _id_93DDA441E5C43170 = smeansofdeath == "MOD_EXPLOSIVE_BULLET" && (isDefined(shitloc) && shitloc == "none") || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE";
  _id_F6FCAAA9C3B578A5 = smeansofdeath == "MOD_FIRE";
  _id_417D44697DD9A40F = _id_379485F96865DB6D && eattacker _hasperk("specialty_bulletdamage");
  _id_B4A897B1262EA17C = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  _id_F3B5D704CA2A9B3D = _id_B4A897B1262EA17C && smeansofdeath == "MOD_CRUSH";
  _id_B2F70B31E5B3822F = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && !isDefined(eattacker.owner);
  _id_565D1EE9D540FA9E = _id_B2F70B31E5B3822F && smeansofdeath == "MOD_CRUSH";

  if((_id_379485F96865DB6D || _id_7543D4FE49C53684) && istrue(_id_E851FFA44B7E0D54.invulnerable) && smeansofdeath != "MOD_SUICIDE") {
    return;
  }
  if(isjuggernaut) {
    if(ismeleedamage)
      idamage = 0;
    else {
      idamage = idamage * 0.3;

      if(_id_5C3F9357F11D2223 == "thermite_ap_mp" || _id_5C3F9357F11D2223 == "thermite_proj_cp")
        idamage = idamage * 15;

      if(_id_5C3F9357F11D2223 == "cruise_proj_mp")
        idamage = self.health + 1000;
    }

    if(_id_F3B5D704CA2A9B3D) {
      _id_AC1EB7A473848892 = ["atv"];

      if(scripts\engine\utility::array_contains(_id_AC1EB7A473848892, eattacker.vehiclename))
        eattacker dodamage(10000, eattacker.origin, _id_E851FFA44B7E0D54);
      else {
        playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
        idamage = self.health + 1000;
      }
    }
  } else if(_id_379485F96865DB6D) {
    if(_id_5C3F9357F11D2223 == "throwingknife_mp" || _id_5C3F9357F11D2223 == "shuriken_mp" || _id_5C3F9357F11D2223 == "throwstar_mp")
      idamage = self.health + 1000;

    if(_id_5C3F9357F11D2223 == "iw9_tur_light_tank_mp" && smeansofdeath == "MOD_PROJECTILE")
      idamage = self.health + 1000;
  }

  if(istrue(self.bhasriotshieldattached)) {
    if(shouldblockdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon)) {
      return;
    }
    if(shitloc == "shield" && (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_PROJECTILE") && idamage > 175) {
      idamage = idamage * 0.05;
      shitloc = "torso_lower";
    }
  }

  if(_id_EAC756C4A01AA740) {
    if(_id_5C3F9357F11D2223 == "emp_drone_player_mp")
      idamage = self.health + 1000;
  }

  if(_id_F3B5D704CA2A9B3D)
    playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");

  if(_id_565D1EE9D540FA9E) {
    if(istrue(self.invuln_to_veh_crush)) {
      idamage = 0;
      _id_E851FFA44B7E0D54 notify("veh_crush_damage", eattacker);
    }
  }

  if(_id_379485F96865DB6D) {
    _id_E851FFA44B7E0D54.damaged_by_player = 1;

    if(headshot) {
      if(isjuggernaut)
        idamage = adjust_damage_based_on_weaponclass(idamage, sweapon, _id_C0B9C9A4FA4EEF84, smeansofdeath, eattacker);
    }

    if(_id_417D44697DD9A40F)
      idamage = idamage * 2;

    if(_id_93DDA441E5C43170) {
      _id_B8693BB74A2FBC11 = idamage * 2.5;

      if(isDefined(level.explosivedamagemod))
        _id_B8693BB74A2FBC11 = _id_B8693BB74A2FBC11 * level.explosivedamagemod;

      idamage = idamage + _id_B8693BB74A2FBC11;
    }

    if(_id_F6FCAAA9C3B578A5)
      idamage = idamage + idamage * 3.5;

    if(ismeleedamage && !isjuggernaut) {
      if(istrue(_id_E851FFA44B7E0D54.immune_to_melee_damage)) {
        idamage = 0;
        _id_E851FFA44B7E0D54 notify("melee_hit_on_melee_immune", eattacker);
      } else {
        idamage = 150;

        if(issubstr(_id_5C3F9357F11D2223, "iw8_knife_mp"))
          idamage = 350;

        if(issubstr(_id_5C3F9357F11D2223, "iw8_me_"))
          idamage = 350;
        else if(isDefined(objweapon.muzzle)) {
          if(issubstr(objweapon.muzzle, "muzzlemelee"))
            idamage = 350;

          if(issubstr(objweapon.muzzle, "bayonet"))
            idamage = 350;
        }
      }
    }

    if(_id_A3192D2F80ED4FF8) {
      if(!headshot) {
        if(!isDefined(level.bullet_damage_scalar))
          level.bullet_damage_scalar = 1;

        idamage = idamage * level.bullet_damage_scalar;
      }

      idamage = idamage * 1;
    }
  }

  if(isDefined(_id_5C3F9357F11D2223) && _id_5C3F9357F11D2223 == "iw9_tur_light_tank_mp" && isDefined(smeansofdeath) && smeansofdeath == "MOD_PROJECTILE_SPLASH")
    idamage = idamage * 2;

  if(_id_379485F96865DB6D || _id_7543D4FE49C53684 || _id_F3B5D704CA2A9B3D) {
    if(isDefined(eattacker) && isPlayer(eattacker)) {
      _id_BA9DC00E6D5896DC = int(min(idamage, self.health));
      scripts\mp\damage::_id_F9237EC4A57B0FF9(eattacker, _id_BA9DC00E6D5896DC, idamage, undefined, objweapon, shitloc);
    }

    if(isDefined(objweapon)) {
      if(_id_7543D4FE49C53684)
        eattacker = eattacker.owner;

      scripts\mp\damage::addattacker(self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath);
    }

    if(idamage >= _id_E851FFA44B7E0D54.health) {
      if(objweapon.basename == "none") {
        if(isDefined(einflictor) && isDefined(einflictor.weapon_name))
          objweapon = makeweapon(einflictor.weapon_name);
      }

      _id_4D8D96D547DF2E9F = spawnStruct();
      _id_4D8D96D547DF2E9F.einflictor = einflictor;
      _id_4D8D96D547DF2E9F.eattacker = eattacker;
      _id_4D8D96D547DF2E9F.idamage = idamage;
      _id_4D8D96D547DF2E9F.idflags = idflags;
      _id_4D8D96D547DF2E9F.smeansofdeath = smeansofdeath;
      _id_4D8D96D547DF2E9F.sweapon = sweapon;
      _id_4D8D96D547DF2E9F.vpoint = vpoint;
      _id_4D8D96D547DF2E9F.vdir = vdir;
      _id_4D8D96D547DF2E9F.shitloc = shitloc;
      _id_4D8D96D547DF2E9F.timeoffset = timeoffset;
      _id_4D8D96D547DF2E9F.modelindex = modelindex;
      _id_4D8D96D547DF2E9F.partname = partname;
      _id_4D8D96D547DF2E9F.objweapon = objweapon;
    }
  }

  idamage = int(min(idamage, _id_E851FFA44B7E0D54.maxhealth));

  if(is_flashbang(_id_5C3F9357F11D2223, objweapon, einflictor) && smeansofdeath == "MOD_GRENADE_SPLASH")
    _id_E851FFA44B7E0D54 notify("flashbang", shitloc, 1, undefined, eattacker, "allies");

  if(is_gas(_id_5C3F9357F11D2223) && smeansofdeath == "MOD_GRENADE_SPLASH")
    _id_E851FFA44B7E0D54 notify("flashbang", shitloc, 1, undefined, eattacker, "allies");

  if(isDefined(_id_E851FFA44B7E0D54.unittype) && isDefined(level.agent_funcs[_id_E851FFA44B7E0D54.unittype]) && isDefined(level.agent_funcs[_id_E851FFA44B7E0D54.unittype]["on_damaged_finished"]))
    _id_E851FFA44B7E0D54[[level.agent_funcs[_id_E851FFA44B7E0D54.unittype]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname);
  else
    _id_E851FFA44B7E0D54[[level.agent_funcs[_id_E851FFA44B7E0D54.agent_type]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname);
}

callbacksoldieragentgametypedamagefinished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname) {
  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }
  process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, vdir, shitloc, timeoffset, self);
  idflags = 0;

  if(!isDefined(self.painsound)) {
    return;
  }
  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound))
      self playSound(self.painsound);

    self.next_dmg_sound = gettime() + 500;
  }
}

callbacksoldieragentgametypekilled(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(level.spawnloopupdatefunc))
    [[level.spawnloopupdatefunc]](eattacker, objweapon);

  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }
  if(istrue(self.marked_for_death))
    self.marked_for_death = undefined;

  if(isDefined(self.death_info_func)) {
    _id_4D8D96D547DF2E9F = spawnStruct();
    _id_4D8D96D547DF2E9F.einflictor = einflictor;
    _id_4D8D96D547DF2E9F.eattacker = eattacker;
    _id_4D8D96D547DF2E9F.idamage = idamage;
    _id_4D8D96D547DF2E9F.smeansofdeath = smeansofdeath;
    _id_4D8D96D547DF2E9F.sweapon = objweapon;
    _id_4D8D96D547DF2E9F.vdir = vdir;
    _id_4D8D96D547DF2E9F.shitloc = shitloc;
    _id_4D8D96D547DF2E9F.timeoffset = timeoffset;
    _id_4D8D96D547DF2E9F.deathanimduration = deathanimduration;
    thread[[self.death_info_func]](_id_4D8D96D547DF2E9F);
  }

  _id_8AB5C5C115A5359F = isDefined(eattacker) && isPlayer(eattacker);
  _id_0C611D3B6A31F919 = isDefined(eattacker) && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  iskillstreakweapon = _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename);
  isvehicleweapon = scripts\mp\utility\weapon::isvehicleweapon(objweapon.basename);
  _id_3B5AFCFEED8FB9CF = undefined;

  if(_id_8AB5C5C115A5359F)
    _id_3B5AFCFEED8FB9CF = eattacker;
  else if(_id_0C611D3B6A31F919)
    _id_3B5AFCFEED8FB9CF = eattacker.owner;

  if(isDefined(_id_3B5AFCFEED8FB9CF)) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(level._id_41F4BC9EE8C7C9C6)) {
      foreach(_id_6640C2677653D96F in level._id_41F4BC9EE8C7C9C6._id_7BA7458B5FC820F7) {
        if(isDefined(_id_6640C2677653D96F.funcs["onAIKilled"])) {
          foreach(_id_B8EBE3F71A08AB40 in level._id_41F4BC9EE8C7C9C6._id_8E0F287A7B13DA80) {
            if(_id_6640C2677653D96F.ref == _id_B8EBE3F71A08AB40.type.ref)
              _id_B8EBE3F71A08AB40[[_id_6640C2677653D96F.funcs["onAIKilled"]]](_id_3B5AFCFEED8FB9CF, self);
          }
        }
      }
    }

    if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "zxp" && self.category == "zombies") {
      _id_3B5AFCFEED8FB9CF._id_72052C14FF62F1D0++;
      _id_3B5AFCFEED8FB9CF _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("zombieKills", _id_3B5AFCFEED8FB9CF._id_72052C14FF62F1D0);
    }

    if(!istrue(level.disablestattracking)) {
      _id_642470E1ABC1BBF9 = spawnStruct();
      _id_642470E1ABC1BBF9.hitloc = shitloc;
      _id_3B5AFCFEED8FB9CF scripts\mp\events::_id_B7F154368ABBE463(self, objweapon, smeansofdeath, einflictor, _id_642470E1ABC1BBF9);
      scripts\mp\events::_id_3E2FF5954AACAA33(objweapon, smeansofdeath, einflictor);
      thread scripts\cp_mp\challenges::_id_5A0AE8BC2B80C0C0(einflictor, _id_3B5AFCFEED8FB9CF, idamage, smeansofdeath, objweapon, shitloc, _id_3B5AFCFEED8FB9CF.modifiers);
      _id_6A8EC730B2BFA844::_id_AFF49E563A741F1E(self, _id_3B5AFCFEED8FB9CF, objweapon);
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.weaponname = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(objweapon);
      _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "ai_agent_kills";
      _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = 1;
      _id_7E2C53B0BCF117D9.variantid = getweaponvariantindex(objweapon);
      _id_7E2C53B0BCF117D9.weaponobj = objweapon;
      _id_3B5AFCFEED8FB9CF _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);

      if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["ads"]))
        _id_3B5AFCFEED8FB9CF thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_7E2C53B0BCF117D9.fullweaponname, 1, "ai_ads_kills");

      if(smeansofdeath == "MOD_HEAD_SHOT" || scripts\mp\events::_id_632BDD4591097AEF(shitloc))
        _id_3B5AFCFEED8FB9CF thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_7E2C53B0BCF117D9.fullweaponname, 1, "ai_headshots");
    }

    _id_3B5AFCFEED8FB9CF thread _id_E6D4CD6D0EBC07E1(self, einflictor, objweapon);
    level thread handle_death_sounds(_id_3B5AFCFEED8FB9CF, self, smeansofdeath);

    if(!iskillstreakweapon && !isvehicleweapon && !_id_3B5AFCFEED8FB9CF scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
      _id_3B5AFCFEED8FB9CF thread scripts\mp\events::killeventtextpopup("stat_EF9582D72160F199", 0);

      if(level._id_0F1F253AEE175FF4 > 0) {
        if(!isDefined(_id_3B5AFCFEED8FB9CF.pers["agentsKillstreakCount"]))
          _id_3B5AFCFEED8FB9CF.pers["agentsKillstreakCount"] = 1;
        else
          _id_3B5AFCFEED8FB9CF.pers["agentsKillstreakCount"]++;

        if(_id_3B5AFCFEED8FB9CF.pers["agentsKillstreakCount"] == level._id_0F1F253AEE175FF4) {
          if(_id_3B5AFCFEED8FB9CF scripts\cp_mp\utility\player_utility::_isalive()) {
            event = "stat_EF9582D72160F199";
            points = scripts\mp\rank::getscoreinfovalue(event);
            _id_3B5AFCFEED8FB9CF scripts\mp\killstreaks\killstreaks::givestreakpoints(event, 1, points);
          }

          _id_3B5AFCFEED8FB9CF.pers["agentsKillstreakCount"] = 0;
        }
      }

      if(isDefined(_id_3B5AFCFEED8FB9CF.modifiers)) {
        if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["oneshotkill"]))
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D3BB96C8BD6EFD71");

        if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["gunbutt"]))
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_020FBB2528F21BD3");

        if(smeansofdeath == "MOD_MELEE") {
          if(objweapon.basename == "iw9_me_fists_mp")
            _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D3DD8A69E4A03838");
        }

        if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["headshot"]))
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FC56E889052D3823");

        if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["pointblank"]))
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A4EE120BD3F61B35");

        if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["longshot"]))
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_9501A62017D709D3");

        if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["backstab"])) {
          if(objweapon.basename == "iw8_knife_mp")
            _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_ACEEE63CB46A233A");
        }

        if(_id_3B5AFCFEED8FB9CF ismantling())
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_86C2B3D1FA522F2B");

        if(scripts\mp\utility\weapon::isthrowingknife(objweapon.basename))
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_123320811BF44B63");

        if(istrue(_id_3B5AFCFEED8FB9CF.modifiers["launcher_impact"]))
          _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E13C7899C2EED171");
      }
    }

    if(isvehicleweapon && isDefined(_id_3B5AFCFEED8FB9CF.vehicle) && isDefined(_id_3B5AFCFEED8FB9CF.vehicle._id_8BB6B9B919C2C19D))
      _id_3B5AFCFEED8FB9CF thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6D65A58E1DE667E1");

    if(isDefined(self.attackers)) {
      foreach(player in self.attackers) {
        if(!isDefined(scripts\mp\utility\damage::_validateattacker(player))) {
          continue;
        }
        if(player == _id_3B5AFCFEED8FB9CF) {
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

          if(attackerdata.damage >= 35)
            _id_54351D786449EE9E = 1;

          if(attackerdata.damage >= 70)
            _id_54351D786449EE9E = 2;
        }

        player thread scripts\mp\gamescore::processassist(self, _id_907BB577FE481752, _id_54351D786449EE9E);

        if(isDefined(player.super)) {
          if(player.super.staticdata.ref == "super_battlerage")
            player _id_19FD5B5D73D44C18::_id_3F783A5ACA22152D();
        }
      }
    }
  }

  if(smeansofdeath == "MOD_CRUSH" && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle")
    playsoundatpos(self.origin + (0, 0, 18), "vehicle_body_hit");

  if(isDefined(level.removefromtargetmarkeronkillfunc))
    level thread[[level.removefromtargetmarkeronkillfunc]](self);

  idflags = 0;
  process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, shitloc, timeoffset, self);
}

is_friendly_damage(agent, attacker) {
  if(isDefined(attacker) && isDefined(agent) && isDefined(agent.team)) {
    if(isDefined(attacker.team) && attacker.team == agent.team)
      return 1;

    if(isDefined(attacker.owner) && isDefined(attacker.owner.team) && attacker.owner.team == agent.team)
      return 1;
  }

  return 0;
}

should_do_damage_checks(eattacker, idamage, smeansofdeath, sweapon, shitloc, victim) {
  if(!isDefined(sweapon))
    return 0;
  else if(eattacker != victim && isDefined(eattacker.team) && eattacker.team == victim.team)
    return 0;
  else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](eattacker, idamage, smeansofdeath, sweapon, shitloc, victim))
    return 0;

  return 1;
}

is_suicide_bomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

adjust_damage_based_on_weaponclass(idamage, sweapon, weaponclass, type, attacker) {
  _id_702BFC08FABD86CB = idamage;

  switch (weaponclass) {
    case "rifle":
      _id_702BFC08FABD86CB = min(idamage, 84);
      break;
    case "smg":
      _id_702BFC08FABD86CB = min(idamage, 110);
      break;
    case "mg":
      _id_702BFC08FABD86CB = min(idamage, 105);
      break;
    case "spread":
      _id_702BFC08FABD86CB = min(idamage, 84);
      break;
    case "pistol":
      _id_702BFC08FABD86CB = min(idamage, 75);
      break;
    case "sniper":
      _id_702BFC08FABD86CB = min(idamage, 130);
      break;
    default:
      _id_702BFC08FABD86CB = idamage;
      break;
  }

  return idamage;
}

is_flashbang(weaponname, objweapon, inflictor) {
  return weaponname == "flash_grenade_mp";
}

is_gas(weaponname) {
  return weaponname == "gas_mp";
}

handle_death_sounds(attacker, victim, smeansofdeath) {
  if(!scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    return;
  }
  if(isDefined(victim.deathsound) && soundexists(victim.deathsound))
    playsoundatpos(victim.origin, victim.deathsound);

  ent = victim;

  if(smeansofdeath == "MOD_HEAD_SHOT") {
    ent playsoundtoplayer("bullet_impact_headshot", attacker);
    ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
  } else {
    ent playsoundtoplayer("mp_kill_alert", attacker);
    ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);
  }
}

process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim) {
  _id_168973EAF883AEA1 = isDefined(eattacker) && isDefined(eattacker.classname) && isDefined(eattacker.classname) && !isDefined(eattacker.gunner) && (eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model");
  _id_91EBB035A259E76A = undefined;

  if(_id_168973EAF883AEA1 && isDefined(eattacker.gunner))
    _id_91EBB035A259E76A = eattacker.gunner;
  else if(isDefined(eattacker) && isDefined(eattacker.owner))
    _id_91EBB035A259E76A = eattacker.owner;
  else
    _id_91EBB035A259E76A = eattacker;

  isbulletdamage = scripts\engine\utility::isbulletdamage(smeansofdeath);
  _id_CDCEDB142F61B43E = scripts\engine\utility::ter_op(isbulletdamage && scripts\mp\utility\weapon::isprimaryweapon(sweapon), "standardspread", "standard");
  _id_59AD6A29257C9F49 = 0;

  if(isDefined(eattacker) && isDefined(eattacker.class) && eattacker.class == "engineer") {
    if(isDefined(smeansofdeath) && scripts\engine\utility::isbulletdamage(smeansofdeath))
      _id_59AD6A29257C9F49 = 1;
  }

  if(isDefined(_id_91EBB035A259E76A) && _id_91EBB035A259E76A != victim && idamage > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    _id_4FFE32F42D51A763 = !isalive(victim) || isagent(victim) && idamage >= victim.health;

    if(istrue(victim.isjuggernaut))
      _id_CDCEDB142F61B43E = "hitjuggernaut";
    else if(idflags &level.idflags_stun)
      _id_CDCEDB142F61B43E = "stun";
    else if(scripts\mp\utility\damage::istacticaldamage(sweapon, smeansofdeath) && victim _hasperk("specialty_stun_resistance"))
      _id_CDCEDB142F61B43E = "hittacresist";
    else if(isexplosivedamagemod(smeansofdeath) && victim _hasperk("specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(eattacker, victim, sweapon, smeansofdeath, einflictor, shitloc))
      _id_CDCEDB142F61B43E = "hitblastshield";
    else if(victim _hasperk("specialty_pistoldeath") && isDefined(victim.inlaststand) && victim.inlaststand == 1 && !victim.hasshownlaststandicon) {
      victim.hasshownlaststandicon = 1;
      _id_CDCEDB142F61B43E = "hitlaststand";
    }

    if(isDefined(victim.focus_fire_attackers) && victim.focus_fire_attackers.size > 1)
      _id_CDCEDB142F61B43E = "cp_relic_buff";

    _id_B98146816886D3C4 = "standard";
    _id_0DD6BF5F9DBA888C = weaponclass(sweapon);
    isspreadweapon = _id_0DD6BF5F9DBA888C == "spread";
    headshot = !isspreadweapon && scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);
    _id_14B8F2EEBA6A3E78 = 1;
    _id_62CF84636D4CEF2C = smeansofdeath == "MOD_MELEE";
    _id_748DFD5F88E890D1 = "" + gettime();

    if(!_id_62CF84636D4CEF2C && isspreadweapon && isDefined(_id_91EBB035A259E76A.pelletdmg) && isDefined(_id_91EBB035A259E76A.pelletdmg[_id_748DFD5F88E890D1]) && isDefined(_id_91EBB035A259E76A.pelletdmg[_id_748DFD5F88E890D1][victim.guid]) && _id_91EBB035A259E76A.pelletdmg[_id_748DFD5F88E890D1][victim.guid] > 1) {
      if(_id_4FFE32F42D51A763)
        _id_62CF84636D4CEF2C = 1;
      else
        _id_14B8F2EEBA6A3E78 = 0;
    }

    _id_D7198CEB7D51DB5B = undefined;

    if(victim.health <= idamage)
      _id_D7198CEB7D51DB5B = 1;

    headshot = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);

    if(istrue(_id_D7198CEB7D51DB5B)) {
      if(isDefined(eattacker)) {
        if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
          eattacker.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199", sweapon, undefined, undefined, self, undefined, undefined, 1, undefined, 1);
        else if(isPlayer(eattacker)) {
          _id_4B5A99C16ABFDFB1 = undefined;

          if(isDefined(self._id_47BDE44B1ACEC603)) {
            _id_6AA094BD7B024408 = getdvarint(_func_2EF675C13CA1C4AF("dvar_D3EFDA60F4581524", self._id_47BDE44B1ACEC603), 0);

            if(_id_6AA094BD7B024408 > 0)
              _id_4B5A99C16ABFDFB1 = _id_6AA094BD7B024408;
            else
              _id_4B5A99C16ABFDFB1 = getdvarint("dvar_DFCAD66B7BA8DA13", 500);
          }

          eattacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199", sweapon, undefined, _id_4B5A99C16ABFDFB1, self, undefined, undefined, 1, undefined, 1);

          if(isDefined(self._id_47BDE44B1ACEC603) && scripts\cp_mp\utility\game_utility::_id_934AC55AA85CE574() && isDefined(eattacker.team)) {
            foreach(player in scripts\mp\utility\teams::getteamdata(eattacker.team, "players")) {
              if(isDefined(player)) {
                if(player != eattacker)
                  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199", undefined, undefined, _id_4B5A99C16ABFDFB1, self, undefined, undefined, 1, undefined, 1);

                if(!isDefined(player._id_6AA094BD7B024408))
                  player._id_6AA094BD7B024408 = 0;

                player._id_6AA094BD7B024408 = player._id_6AA094BD7B024408 + _id_4B5A99C16ABFDFB1;
              }
            }
          }

          if(smeansofdeath == "MOD_EXECUTION")
            eattacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_40C5F8104D76CC15");
        }
      }
    }

    if(istrue(_id_14B8F2EEBA6A3E78)) {
      if(isDefined(eattacker)) {
        if(isDefined(eattacker.owner))
          eattacker.owner thread _id_5762AC2F22202BA2::updatedamagefeedback(_id_CDCEDB142F61B43E, _id_D7198CEB7D51DB5B, headshot);
        else
          eattacker thread _id_5762AC2F22202BA2::updatedamagefeedback(_id_CDCEDB142F61B43E, _id_D7198CEB7D51DB5B, headshot);
      }
    }
  }

  if(isDefined(level._id_484F1A4BDB5CDA1E) && isDefined(eattacker)) {
    if(isDefined(eattacker.owner))
      eattacker = eattacker.owner;

    level[[level._id_484F1A4BDB5CDA1E]](eattacker, victim);
  }
}

_hasperk(perkname) {
  perks = self.perks;

  if(!isDefined(perks))
    return 0;

  if(isDefined(perks[perkname]))
    return 1;

  return 0;
}

shouldblockdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_5C3F9357F11D2223 = objweapon.basename;
  _id_83A06097F54C024B = 0;

  if(isDefined(einflictor) && (issubstr(_id_5C3F9357F11D2223, "thermite") || isDefined(objweapon.magazine) && issubstr(objweapon.magazine, "boltfire") || isDefined(einflictor.weapon_name) && issubstr(einflictor.weapon_name, "incendiary"))) {
    _id_83A06097F54C024B = 1;
    _id_35AF7DAE0105A3E3 = shitloc == "shield";

    if(_id_35AF7DAE0105A3E3) {
      contents = scripts\engine\trace::create_character_contents();
      _id_759CADFD4D74BFFD = vectorNormalize(vdir);
      startpos = vpoint - _id_759CADFD4D74BFFD * 12;
      endpos = vpoint + _id_759CADFD4D74BFFD * 12;
      results = scripts\engine\trace::ray_trace_detail(startpos, endpos, undefined, contents);

      if(results["fraction"] > 0 && results["fraction"] < 1) {
        _id_1B4FD8D84CA96180 = vpoint - self.origin;
        _id_1B4FD8D84CA96180 = (_id_1B4FD8D84CA96180[0], _id_1B4FD8D84CA96180[1], 0);

        if(vectordot(_id_1B4FD8D84CA96180, results["normal"]) < 0)
          _id_35AF7DAE0105A3E3 = 0;
      } else
        _id_35AF7DAE0105A3E3 = 0;
    }

    if(_id_35AF7DAE0105A3E3) {
      parent = einflictor getlinkedparent();

      if(isDefined(parent) && parent == self) {
        self.bhasthermitestucktoshield = 1;
        self.thermitestuckpains = 0;
      }
    } else if(shitloc != "none") {
      self.bhasthermitestucktoshield = 0;
      self.thermitestuckpains = undefined;
    }
  }

  if(shitloc == "shield") {
    if(_id_83A06097F54C024B)
      return 1;
  } else if(shitloc == "none" && isDefined(einflictor)) {
    _id_AFCDB89D9C3E8439 = einflictor getlinkedparent();

    if(self.bhasthermitestucktoshield && _id_83A06097F54C024B && isDefined(_id_AFCDB89D9C3E8439) && _id_AFCDB89D9C3E8439 == self) {
      if(!isDefined(self.thermitestucktoshield))
        self.thermitestucktoshield = [einflictor];
      else if(!scripts\engine\utility::array_contains(self.thermitestucktoshield, einflictor))
        self.thermitestucktoshield[self.thermitestucktoshield.size] = einflictor;

      self.thermitestuckpains++;
      return 1;
    } else if(issubstr(_id_5C3F9357F11D2223, "molotov")) {
      _id_289CB9FCBD6AA7C8 = einflictor.origin - self.origin;
      _id_8B5B7D7C1E6793DE = vectorNormalize((_id_289CB9FCBD6AA7C8[0], _id_289CB9FCBD6AA7C8[1], 0));
      _id_289CB9FCBD6AA7C8 = vectorNormalize(_id_289CB9FCBD6AA7C8);

      if(vectordot(anglesToForward(self.angles), _id_8B5B7D7C1E6793DE) > 0.5 && -0.98 < _id_289CB9FCBD6AA7C8[2] && _id_289CB9FCBD6AA7C8[2] < 0.98)
        return 1;
    }
  }

  if(smeansofdeath == "MOD_MELEE") {
    if(isDefined(eattacker))
      _id_392A20AB0D4853FB = vectorNormalize(eattacker.origin - self.origin);
    else
      _id_392A20AB0D4853FB = vectorNormalize(vpoint - self.origin);

    _id_C4182E9C211FF588 = anglesToForward(self.angles);

    if(vectordot(_id_C4182E9C211FF588, _id_392A20AB0D4853FB) > 0.5)
      return 1;
  }

  return 0;
}

_id_42BAA3BB97D2D1D7(player, _id_A3732517126407B2, idamage, vpoint, _id_ECBB293AAA7A43B0) {
  idamage = int(clamp(idamage, 0, 1000000));
  player setclientomnvar("ui_dmg_num_amount", idamage);
  player setclientomnvar("ui_dmg_num_x", int(vpoint[0]));
  player setclientomnvar("ui_dmg_num_y", int(vpoint[1]));
  player setclientomnvar("ui_dmg_num_z", int(vpoint[2]));
  player setclientomnvar("ui_dmg_num_state", _id_A3732517126407B2);
  player setclientomnvar("ui_dmg_num_element", _id_ECBB293AAA7A43B0);
}

_id_C54B2CC2E762C201(eattacker, _id_11467C69AA950E0A, shitloc, smeansofdeath, sweapon, idamage, vpoint, _id_DA71C7321BC0A0F6, _id_B1468C561460431E) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(sweapon);

  if(!isDefined(level._id_1A2B600A06EC21F4._id_DDAED03EBCC9CCF9)) {
    return;
  }
  weaponclass = tablelookup(level._id_1A2B600A06EC21F4._id_DDAED03EBCC9CCF9, 4, _id_AB501F397D3CD312, 1);
  _id_A3732517126407B2 = 1;
  _id_C9C7E8D091B092ED = 0;

  if(istrue(_id_DA71C7321BC0A0F6))
    _id_A3732517126407B2 = 4;
  else {
    if(isDefined(_id_B1468C561460431E) && isDefined(_id_11467C69AA950E0A._id_691B16F55274B1C5) && isarray(_id_11467C69AA950E0A._id_691B16F55274B1C5) && istrue(_id_11467C69AA950E0A._id_691B16F55274B1C5[_id_B1468C561460431E]))
      _id_C9C7E8D091B092ED = 1 + level._id_7843C346BAFF928F[_id_B1468C561460431E];

    if(_id_11467C69AA950E0A scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker) && weaponclass != "weapon_projectile")
      _id_A3732517126407B2 = 2;
  }

  if(shitloc == "none" && smeansofdeath != "MOD_MELEE") {
    _id_DAF8775C1297460F = scripts\engine\utility::_id_53C4C53197386572(_id_11467C69AA950E0A._id_2BE88729DA6FDBC5, (0, 0, 12));

    if(isalive(_id_11467C69AA950E0A)) {
      _id_E4C943D63E229D1C = scripts\engine\utility::_id_53C4C53197386572(_id_11467C69AA950E0A._id_52DCDBA485E7CEEB, "j_head");
      vpoint = _id_11467C69AA950E0A gettagorigin(_id_E4C943D63E229D1C) + _id_DAF8775C1297460F;
    } else
      vpoint = _id_11467C69AA950E0A.origin + _id_DAF8775C1297460F;
  }

  thread _id_7A6BBB24289296E7(eattacker, _id_A3732517126407B2, idamage, vpoint, _id_C9C7E8D091B092ED);
}

_id_7A6BBB24289296E7(player, _id_A3732517126407B2, idamage, vpoint, _id_ECBB293AAA7A43B0) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!isDefined(player._id_A0F98FFC22B158E3))
    player._id_A0F98FFC22B158E3 = 0;

  if(!isDefined(_id_ECBB293AAA7A43B0))
    _id_ECBB293AAA7A43B0 = 0;

  player._id_A0F98FFC22B158E3++;
  wait(0.05 * player._id_A0F98FFC22B158E3);
  _id_42BAA3BB97D2D1D7(player, _id_A3732517126407B2, idamage, vpoint, _id_ECBB293AAA7A43B0);
  player._id_A0F98FFC22B158E3--;
}

_id_E6D4CD6D0EBC07E1(victim, einflictor, objweapon) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentAgentKills");
  self endon("updateRecentAgentKills");

  if(!isDefined(self._id_05431D89A36B0936))
    self._id_05431D89A36B0936 = 0;

  self._id_05431D89A36B0936++;
  _id_366B0ECC2F28AEAD = undefined;

  if(isDefined(objweapon)) {
    if(isDefined(objweapon.basename) && objweapon.basename == "none") {
      if(isDefined(einflictor) && isDefined(einflictor.weapon_name))
        _id_366B0ECC2F28AEAD = einflictor.weapon_name;
    } else
      _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
  }

  scripts\mp\utility\script::bufferednotify("update_rapid_agent_kill_buffered", self._id_05431D89A36B0936, _id_366B0ECC2F28AEAD);
  wait 4.0;
  self._id_05431D89A36B0936 = 0;
}