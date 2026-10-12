/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\mp_agent_damage.gsc
***********************************************/

#using scripts\anim\animselector;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\pmc_missions;
#using scripts\mp\rank;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace mp_agent_damage;

function register_ai_damage_callbacks() {
  level.agent_funcs["actor_enemy_lw_base_br"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_base_br"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_base_br"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.var_238d7505b0146b84 = &scripts\mp\damage::addattacker;
}

function callbacksoldieragentdamaged(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  evictim = self;

  if(!isDefined(evictim.agent_type)) {
    return;
  }

  if(!isDefined(objweapon)) {
    objweapon = sweapon;
  }

  if(smeansofdeath != "MOD_SUICIDE") {
    if(is_friendly_damage(evictim, einflictor)) {
      if(getdvarint(@ "g_debugdamage") != 0) {
        println("<dev string:x1c>");
      }

      return;
    }
  }

  if(!isDefined(eattacker)) {
    eattacker = evictim;
  }

  shoulddodamage = should_do_damage_checks(eattacker, idamage, smeansofdeath, sweapon, shitloc, evictim);

  if(!shoulddodamage) {
    if(getdvarint(@ "g_debugdamage") != 0) {
      println("<dev string:x33>");
    }

    return;
  }

  idflags |= 4;
  initial_damage = idamage;
  weaponbasename = objweapon.basename;
  weaponclassname = objweapon.classname;
  issuicidebomber = is_suicide_bomber();
  isinlaststand = istrue(eattacker.inlaststand);
  ismeleedamage = smeansofdeath == "MOD_MELEE";
  bulletdamage = isbulletdamage(smeansofdeath) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";
  isplayerdamage = isDefined(eattacker) && isPlayer(eattacker);
  var_7543d4fe49c53684 = isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  isjuggernaut = isDefined(evictim.unittype) && evictim.unittype == "juggernaut";
  headshot = bulletdamage && isheadshot(shitloc, smeansofdeath, eattacker);
  isexplosive = smeansofdeath == "MOD_EXPLOSIVE_BULLET" && isDefined(shitloc) && shitloc == "none" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE";
  isfire = smeansofdeath == "MOD_FIRE";
  var_417d44697dd9a40f = isplayerdamage && eattacker _hasperk("specialty_bulletdamage");
  var_b4a897b1262ea17c = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  var_f3b5d704ca2a9b3d = var_b4a897b1262ea17c && smeansofdeath == "MOD_CRUSH";
  var_b2f70b31e5b3822f = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && !isDefined(eattacker.owner);
  var_565d1ee9d540fa9e = var_b2f70b31e5b3822f && smeansofdeath == "MOD_CRUSH";

  if((isplayerdamage || var_7543d4fe49c53684) && istrue(evictim.invulnerable) && smeansofdeath != "MOD_SUICIDE") {
    if(getdvarint(@ "g_debugdamage") != 0) {
      println("<dev string:x53>");
    }

    return;
  }

  if(isjuggernaut) {
    if(ismeleedamage) {
      idamage = 0;
    } else {
      idamage *= 0.3;

      if(weaponbasename == "thermite_ap_mp" || weaponbasename == "thermite_proj_cp") {
        idamage *= 15;
      }

      if(weaponbasename == "cruise_proj_mp") {
        idamage = self.health + 1000;
      }
    }

    if(var_f3b5d704ca2a9b3d) {
      var_ac1eb7a473848892 = ["atv"];

      if(array_contains(var_ac1eb7a473848892, eattacker.vehiclename)) {
        eattacker dodamage(10000, eattacker.origin, evictim);
      } else {
        playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
        idamage = self.health + 1000;
      }
    }
  } else if(isplayerdamage) {
    if(weaponbasename == "throwingknife_mp" || weaponbasename == "shuriken_mp" || weaponbasename == "throwstar_mp") {
      idamage = self.health + 1000;
    }

    if(weaponbasename == "iw9_tur_light_tank_mp" && smeansofdeath == "MOD_PROJECTILE") {
      idamage = self.health + 1000;
    }
  }

  if(istrue(self.bhasriotshieldattached)) {
    if(shouldblockdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon)) {
      return;
    }

    if(shitloc == "shield" && (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_PROJECTILE") && idamage > 175) {
      idamage *= 0.05;
      shitloc = "torso_lower";
    }
  }

  if(issuicidebomber) {
    if(weaponbasename == "emp_drone_player_mp") {
      idamage = self.health + 1000;
    }
  }

  if(var_f3b5d704ca2a9b3d) {
    playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
  }

  if(var_565d1ee9d540fa9e) {
    if(istrue(self.invuln_to_veh_crush)) {
      idamage = 0;
      evictim notify("veh_crush_damage", eattacker);
    }
  }

  if(isplayerdamage) {
    evictim.damaged_by_player = 1;

    if(headshot) {
      if(isjuggernaut) {
        idamage = adjust_damage_based_on_weaponclass(idamage, sweapon, weaponclassname, smeansofdeath, eattacker);
      }
    }

    if(var_417d44697dd9a40f) {
      idamage *= 2;
    }

    if(isexplosive) {
      increase = idamage * 2.5;

      if(isDefined(level.explosivedamagemod)) {
        increase *= level.explosivedamagemod;
      }

      idamage += increase;
    }

    if(isfire) {
      idamage += idamage * 3.5;
    }

    if(ismeleedamage && !isjuggernaut) {
      if(istrue(evictim.immune_to_melee_damage)) {
        idamage = 0;
        evictim notify("melee_hit_on_melee_immune", eattacker);
      } else {
        idamage = 150;

        if(issubstr(weaponbasename, "iw8_knife_mp")) {
          idamage = 350;
        }

        if(issubstr(weaponbasename, "iw8_me_")) {
          idamage = 350;
        } else if(isDefined(objweapon.muzzle)) {
          if(issubstr(objweapon.muzzle, "muzzlemelee")) {
            idamage = 350;
          }

          if(issubstr(objweapon.muzzle, "bayonet")) {
            idamage = 350;
          }
        }
      }
    }

    if(bulletdamage) {
      if(!headshot) {
        if(!isDefined(level.bullet_damage_scalar)) {
          level.bullet_damage_scalar = 1;
        }

        idamage *= level.bullet_damage_scalar;
      }

      idamage *= 1;
    }
  }

  if(isDefined(weaponbasename) && weaponbasename == "iw9_tur_light_tank_mp" && isDefined(smeansofdeath) && smeansofdeath == "MOD_PROJECTILE_SPLASH") {
    idamage *= 2;
  }

  if(isplayerdamage || var_7543d4fe49c53684 || var_f3b5d704ca2a9b3d) {
    if(isDefined(eattacker) && isPlayer(eattacker)) {
      var_ba9dc00e6d5896dc = int(min(idamage, self.health));
      scripts\mp\damage::function_f9237ec4a57b0ff9(eattacker, var_ba9dc00e6d5896dc, idamage, undefined, objweapon, shitloc);
    }

    if(isDefined(objweapon)) {
      if(var_7543d4fe49c53684) {
        eattacker = eattacker.owner;
      }

      scripts\mp\damage::addattacker(self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath);
    }

    if(idamage >= evictim.health) {
      if(objweapon.basename == "none") {
        if(isDefined(einflictor) && isDefined(einflictor.weapon_name)) {
          objweapon = makeweapon(einflictor.weapon_name);
        }
      }

      var_4d8d96d547df2e9f = spawnStruct();
      var_4d8d96d547df2e9f.einflictor = einflictor;
      var_4d8d96d547df2e9f.eattacker = eattacker;
      var_4d8d96d547df2e9f.idamage = idamage;
      var_4d8d96d547df2e9f.idflags = idflags;
      var_4d8d96d547df2e9f.smeansofdeath = smeansofdeath;
      var_4d8d96d547df2e9f.sweapon = sweapon;
      var_4d8d96d547df2e9f.vpoint = vpoint;
      var_4d8d96d547df2e9f.vdir = vdir;
      var_4d8d96d547df2e9f.shitloc = shitloc;
      var_4d8d96d547df2e9f.timeoffset = timeoffset;
      var_4d8d96d547df2e9f.modelindex = modelindex;
      var_4d8d96d547df2e9f.partname = partname;
      var_4d8d96d547df2e9f.objweapon = objweapon;
    }
  }

  scripts\cp_mp\utility\weapon_utility::function_c9e5c511b923a42f(idamage, eattacker, evictim, smeansofdeath, shitloc, einflictor, vpoint);

  idamage = int(min(idamage, evictim.maxhealth));

  if(is_flashbang(weaponbasename, objweapon, einflictor) && smeansofdeath == "MOD_GRENADE_SPLASH") {
    evictim notify("flashbang", shitloc, 1, undefined, eattacker, "allies");
  }

  if(is_gas(weaponbasename) && smeansofdeath == "MOD_GRENADE_SPLASH") {
    evictim notify("flashbang", shitloc, 1, undefined, eattacker, "allies");
  }

  if(getdvarint(@ "g_debugdamage") != 0 && idamage != initial_damage) {
    println("<dev string:x65>" + idamage);
  }

  if(isDefined(evictim.unittype) && isDefined(level.agent_funcs[evictim.unittype]) && isDefined(level.agent_funcs[evictim.unittype]["on_damaged_finished"])) {
    evictim[[level.agent_funcs[evictim.unittype]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname);
    return;
  }

  assert(isDefined(level.agent_funcs[evictim.agent_type]["<dev string:x7c>"]));
  evictim[[level.agent_funcs[evictim.agent_type]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname);
}

function private function_2587e7c010a44740() {
  if(!isDefined(level.var_3749fd90367bc366)) {
    level.var_3749fd90367bc366 = 1;

    if(isusingmatchrulesdata()) {
      level.var_3749fd90367bc366 = getmatchrulesdata("commonOption", "aiKilledScoreEventsEnabled");
    }
  }

  return level.var_3749fd90367bc366;
}

function callbacksoldieragentgametypedamagefinished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname) {
  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }

  process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, vdir, shitloc, timeoffset, self);
  idflags = 0;

  if(!isDefined(self.painsound)) {
    return;
  }

  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound)) {
      self playSound(self.painsound);
    }

    self.next_dmg_sound = gettime() + 500;
  }
}

function callbacksoldieragentgametypekilled(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](eattacker, objweapon);
  }

  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.marked_for_death)) {
    self.marked_for_death = undefined;
  }

  if(isDefined(self.death_info_func)) {
    var_4d8d96d547df2e9f = spawnStruct();
    var_4d8d96d547df2e9f.einflictor = einflictor;
    var_4d8d96d547df2e9f.eattacker = eattacker;
    var_4d8d96d547df2e9f.idamage = idamage;
    var_4d8d96d547df2e9f.smeansofdeath = smeansofdeath;
    var_4d8d96d547df2e9f.sweapon = objweapon;
    var_4d8d96d547df2e9f.vdir = vdir;
    var_4d8d96d547df2e9f.shitloc = shitloc;
    var_4d8d96d547df2e9f.timeoffset = timeoffset;
    var_4d8d96d547df2e9f.deathanimduration = deathanimduration;
    thread[[self.death_info_func]](var_4d8d96d547df2e9f);
  }

  isplayerattacker = isDefined(eattacker) && isPlayer(eattacker);
  var_c611d3b6a31f919 = isDefined(eattacker) && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  var_4057c6ccc0529d32 = eattacker scripts\mp\utility\killstreak::isjuggernaut();
  iskillstreakweapon = var_4057c6ccc0529d32 || scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename);
  isvehicleweapon = scripts\mp\utility\weapon::isvehicleweapon(objweapon.basename);
  playerattacker = undefined;

  if(isplayerattacker) {
    playerattacker = eattacker;
  } else if(var_c611d3b6a31f919) {
    playerattacker = eattacker.owner;
  }

  if(isDefined(playerattacker)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(level.contractmanager)) {
      foreach(contract in level.contractmanager.contractdata) {
        if(isDefined(contract.funcs["onAIKilled"])) {
          foreach(task in level.contractmanager.currenttasks) {
            if(contract.ref == task.type.ref) {
              task[[contract.funcs["onAIKilled"]]](playerattacker, self);
            }
          }
        }
      }
    }

    if(!istrue(level.disablestattracking)) {
      if(!istrue(level.var_4a486ba98909b396)) {
        deathdata = spawnStruct();
        deathdata.hitloc = shitloc;
        playerattacker scripts\mp\events::function_b7f154368abbe463(self, objweapon, smeansofdeath, einflictor, deathdata);
      }

      scripts\mp\events::function_3e2ff5954aacaa33(objweapon, smeansofdeath, einflictor);

      if(istrue(level.supportsai)) {
        victimstruct = scripts\cp_mp\challenges::function_137b512700167b00(playerattacker, self);
        level thread scripts\cp_mp\challenges::onagentkilled(einflictor, playerattacker, idamage, smeansofdeath, objweapon, shitloc, playerattacker.modifiers, undefined, self.team, victimstruct);
      }

      scripts\mp\pmc_missions::onaikill(self, playerattacker, objweapon);
      fullweaponname = getcompleteweaponname(objweapon);

      if(isDefined(playerattacker.modifiers) && istrue(playerattacker.modifiers["ads"])) {
        playerattacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(fullweaponname, 1, "ai_ads_kills");
      }

      if(smeansofdeath == "MOD_HEAD_SHOT" || scripts\mp\events::function_632bdd4591097aef(shitloc)) {
        playerattacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(fullweaponname, 1, "ai_headshots");
      }
    }

    playerattacker thread updaterecentagentkills(self, einflictor, objweapon);
    level thread handle_death_sounds(playerattacker, self, smeansofdeath);

    if(!iskillstreakweapon && !isvehicleweapon && !playerattacker scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
      playerattacker thread scripts\mp\events::killeventtextpopup(#"kill", 0);

      if(level.agentskillstreakcount > 0) {
        if(!isDefined(playerattacker.pers["agentsKillstreakCount"])) {
          playerattacker.pers["agentsKillstreakCount"] = 1;
        } else {
          playerattacker.pers["agentsKillstreakCount"]++;
        }

        if(playerattacker.pers["agentsKillstreakCount"] == level.agentskillstreakcount) {
          if(playerattacker scripts\cp_mp\utility\player_utility::_isalive()) {
            event = #"kill";
            points = scripts\mp\rank::getscoreinfovalue(event);
            playerattacker scripts\mp\killstreaks\killstreaks::givestreakpoints(event, 1, points);
          }

          playerattacker.pers["agentsKillstreakCount"] = 0;
        }
      }

      if(isDefined(playerattacker.modifiers) && function_2587e7c010a44740()) {
        if(istrue(playerattacker.modifiers["oneshotkill"])) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"one_shot_kill");
        }

        if(istrue(playerattacker.modifiers["gunbutt"])) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"gun_butt");
        }

        if(smeansofdeath == "MOD_MELEE") {
          if(objweapon.basename == "iw9_me_fists_mp") {
            playerattacker thread scripts\mp\utility\points::doscoreevent(#"fist_kill");
          }
        }

        if(istrue(playerattacker.modifiers["headshot"])) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"headshot");
          playerattacker thread scripts\mp\events::killeventtextpopup(#"headshot", 0);
        }

        if(istrue(playerattacker.modifiers["pointblank"])) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"pointblank");
        }

        if(istrue(playerattacker.modifiers["longshot"])) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"longshot");
        }

        if(istrue(playerattacker.modifiers["backstab"])) {
          if(objweapon.basename == "iw8_knife_mp") {
            playerattacker thread scripts\mp\utility\points::doscoreevent(#"backstab");
          }
        }

        if(playerattacker ismantling()) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"mantle_kill");
        }

        if(scripts\mp\utility\weapon::isthrowingknife(objweapon.basename)) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"throwingknife_kill");
        }

        if(istrue(playerattacker.modifiers["launcher_impact"])) {
          playerattacker thread scripts\mp\utility\points::doscoreevent(#"hash_e13c7899c2eed171");
        }
      }
    }

    if(isvehicleweapon && isDefined(playerattacker.vehicle) && isDefined(playerattacker.vehicle.combo)) {
      playerattacker thread scripts\mp\utility\points::doscoreevent(#"combo");
    }

    if(isDefined(self.attackers)) {
      foreach(player in self.attackers) {
        if(!isDefined(_validateattacker(player))) {
          continue;
        }

        if(player == playerattacker) {
          continue;
        }

        if(self == player) {
          continue;
        }

        if(isDefined(level.assists_disabled)) {
          continue;
        }

        bonusmagnitude = 0;
        assistweapon = undefined;

        if(isDefined(self.attackerdata)) {
          attackerdata = self.attackerdata[player.guid];

          if(isDefined(attackerdata)) {
            assistweapon = attackerdata.objweapon;
          }

          if(attackerdata.damage >= 35) {
            bonusmagnitude = 1;
          }

          if(attackerdata.damage >= 70) {
            bonusmagnitude = 2;
          }
        }

        player thread scripts\mp\gamescore::processassist(self, assistweapon, bonusmagnitude);

        if(isDefined(player.super)) {
          if(player.super.staticdata.ref == "super_battlerage") {
            player scripts\mp\equipment\battlerage::function_3f783a5aca22152d();
          }
        }
      }
    }
  }

  if(smeansofdeath == "MOD_CRUSH" && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle") {
    playsoundatpos(self.origin + (0, 0, 18), "vehicle_body_hit");
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc)) {
    level thread[[level.removefromtargetmarkeronkillfunc]](self);
  }

  idflags = 0;
  process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, shitloc, timeoffset, self);
}

function is_friendly_damage(agent, attacker) {
  if(isDefined(attacker) && isDefined(agent) && isDefined(agent.team)) {
    if(isDefined(attacker.team) && attacker.team == agent.team) {
      return true;
    }

    if(isDefined(attacker.owner) && isDefined(attacker.owner.team) && attacker.owner.team == agent.team) {
      return true;
    }
  }

  return false;
}

function should_do_damage_checks(eattacker, idamage, smeansofdeath, sweapon, shitloc, victim) {
  if(!isDefined(sweapon)) {
    return false;
  } else if(eattacker != victim && isDefined(eattacker.team) && eattacker.team == victim.team) {
    return false;
  } else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](eattacker, idamage, smeansofdeath, sweapon, shitloc, victim)) {
    return false;
  }

  return true;
}

function is_suicide_bomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function adjust_damage_based_on_weaponclass(idamage, sweapon, weaponclass, type, attacker) {
  modifieddamage = idamage;

  switch (weaponclass) {
    case #"hash_8cdaf2e4ecfe5b51":
      modifieddamage = min(idamage, 84);
      break;
    case #"hash_900cb96c552c5e8e":
      modifieddamage = min(idamage, 110);
      break;
    case #"hash_fa24dff6bd60a12d":
      modifieddamage = min(idamage, 105);
      break;
    case #"hash_690c0d6a821b42e":
      modifieddamage = min(idamage, 84);
      break;
    case #"hash_719417cb1de832b6":
      modifieddamage = min(idamage, 75);
      break;
    case #"hash_6191aaef9f922f96":
      modifieddamage = min(idamage, 130);
      break;
    default:
      modifieddamage = idamage;
      break;
  }

  return idamage;
}

function is_flashbang(weaponname, objweapon, inflictor) {
  return weaponname == "flash_grenade_mp";
}

function is_gas(weaponname) {
  return weaponname == "gas_mp";
}

function handle_death_sounds(attacker, victim, smeansofdeath) {
  if(!isbulletdamage(smeansofdeath)) {
    return;
  }

  if(isDefined(victim.deathsound) && soundexists(victim.deathsound)) {
    playsoundatpos(victim.origin, victim.deathsound);
  }

  ent = victim;

  if(smeansofdeath == "MOD_HEAD_SHOT") {
    ent playsoundtoplayer("bullet_impact_headshot", attacker);
    ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
    return;
  }

  ent playsoundtoplayer("mp_kill_alert", attacker);
  ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);
}

function process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim) {
  var_168973eaf883aea1 = isDefined(eattacker) && isDefined(eattacker.classname) && isDefined(eattacker.classname) && !isDefined(eattacker.gunner) && (eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model");
  damager = undefined;

  if(var_168973eaf883aea1 && isDefined(eattacker.gunner)) {
    damager = eattacker.gunner;
  } else if(isDefined(eattacker) && isDefined(eattacker.owner)) {
    damager = eattacker.owner;
  } else {
    damager = eattacker;
  }

  isbulletdamage = isbulletdamage(smeansofdeath);
  typehit = ter_op(isbulletdamage && scripts\mp\utility\weapon::isprimaryweapon(sweapon), "standardspread", "standard");
  var_59ad6a29257c9f49 = 0;

  if(isDefined(eattacker) && isDefined(eattacker.class) && eattacker.class == "engineer") {
    if(isDefined(smeansofdeath) && isbulletdamage(smeansofdeath)) {
      var_59ad6a29257c9f49 = 1;
    }
  }

  if(isDefined(damager) && damager != victim && idamage > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    waskilled = !isalive(victim) || isagent(victim) && idamage >= victim.health;

    if(istrue(victim.isjuggernaut)) {
      if(istrue(victim.isjuggernautrecon)) {
        typehit = "hitjuggernautrecon";
      } else {
        typehit = "hitjuggernaut";
      }
    } else if(idflags & 16) {
      typehit = "stun";
    } else if(istacticaldamage(sweapon, smeansofdeath) && victim _hasperk("specialty_stun_resistance")) {
      typehit = "hittacresist";
    } else if(isexplosivedamagemod(smeansofdeath) && victim _hasperk("specialty_blastshield") && !damage_should_ignore_blast_shield(eattacker, victim, sweapon, smeansofdeath, einflictor, shitloc)) {
      typehit = "hitblastshield";
    } else if(victim _hasperk("specialty_pistoldeath") && isDefined(victim.inlaststand) && victim.inlaststand == 1 && !victim.hasshownlaststandicon) {
      victim.hasshownlaststandicon = 1;
      typehit = "hitlaststand";
    }

    if(isDefined(victim.focus_fire_attackers) && victim.focus_fire_attackers.size > 1) {
      typehit = "cp_relic_buff";
    }

    hitmarkertype = "standard";
    weapclass = weaponclass(sweapon);
    isspreadweapon = weapclass == "spread";
    headshot = !isspreadweapon && isheadshot(shitloc, smeansofdeath, eattacker);
    allowdamagefeedback = 1;
    suppressaudio = smeansofdeath == "MOD_MELEE";
    timestring = "" + gettime();

    if(!suppressaudio && isspreadweapon && isDefined(damager.pelletdmg) && isDefined(damager.pelletdmg[timestring]) && isDefined(damager.pelletdmg[timestring][victim.guid]) && damager.pelletdmg[timestring][victim.guid] > 1) {
      if(waskilled) {
        suppressaudio = 1;
      } else {
        allowdamagefeedback = 0;
      }
    }

    killingblow = undefined;

    if(victim.health <= idamage) {
      killingblow = 1;
    }

    headshot = isheadshot(shitloc, smeansofdeath, eattacker);

    if(istrue(killingblow)) {
      if(isDefined(eattacker)) {
        if(isDefined(eattacker.owner) && isPlayer(eattacker.owner)) {
          if(function_2587e7c010a44740()) {
            eattacker.owner thread scripts\mp\utility\points::doscoreevent(#"kill", sweapon, undefined, undefined, self, undefined, undefined, 1, undefined, 1);
          }
        } else if(isPlayer(eattacker)) {
          xpoverride = undefined;

          if(isDefined(self.bossname)) {
            bossxp = getdvarint(hashcat(@ "hash_d3efda60f4581524", self.bossname), 0);

            if(bossxp > 0) {
              xpoverride = bossxp;
            } else {
              xpoverride = getdvarint(@ "hash_dfcad66b7ba8da13", 500);
            }
          }

          if(function_2587e7c010a44740()) {
            eattacker thread scripts\mp\utility\points::doscoreevent(#"kill", sweapon, undefined, xpoverride, self, undefined, undefined, 1, undefined, 1);
          }

          if(isDefined(self.bossname) && function_934ac55aa85ce574() && isDefined(eattacker.team)) {
            foreach(player in scripts\mp\utility\teams::getteamdata(eattacker.team, "players")) {
              if(isDefined(player)) {
                if(player != eattacker && function_2587e7c010a44740()) {
                  player thread scripts\mp\utility\points::doscoreevent(#"kill", undefined, undefined, xpoverride, self, undefined, undefined, 1, undefined, 1);
                }

                if(!isDefined(player.bossxp)) {
                  player.bossxp = 0;
                }

                player.bossxp += xpoverride;
              }
            }
          }

          if(smeansofdeath == "MOD_EXECUTION") {
            eattacker thread scripts\mp\utility\points::doscoreevent(#"execution");
          }
        }
      }
    }

    if(istrue(allowdamagefeedback)) {
      if(isDefined(eattacker)) {
        if(isDefined(eattacker.owner)) {
          eattacker.owner thread updatedamagefeedback(typehit, killingblow, headshot);
        } else {
          eattacker thread updatedamagefeedback(typehit, killingblow, headshot);
        }
      }
    }
  }

  if(isDefined(level.var_484f1a4bdb5cda1e) && isDefined(eattacker)) {
    if(isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    }

    level[[level.var_484f1a4bdb5cda1e]](eattacker, victim);
  }
}

function _hasperk(perkname) {
  perks = self.perks;

  if(!isDefined(perks)) {
    return false;
  }

  if(isDefined(perks[perkname])) {
    return true;
  }

  return false;
}

function shouldblockdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  weaponbasename = objweapon.basename;
  bthermite = 0;

  if(isDefined(einflictor) && (issubstr(weaponbasename, "thermite") || isDefined(objweapon.magazine) && issubstr(objweapon.magazine, "boltfire") || isDefined(einflictor.weapon_name) && issubstr(einflictor.weapon_name, "incendiary"))) {
    bthermite = 1;
    var_35af7dae0105a3e3 = shitloc == "shield";

    if(var_35af7dae0105a3e3) {
      contents = scripts\engine\trace::create_character_contents();
      dirnormalized = vectorNormalize(vdir);
      startpos = vpoint - dirnormalized * 12;
      endpos = vpoint + dirnormalized * 12;
      results = scripts\engine\trace::ray_trace_detail(startpos, endpos, undefined, contents);

      if(results["fraction"] > 0 && results["fraction"] < 1) {
        metopoint = vpoint - self.origin;
        metopoint = (metopoint[0], metopoint[1], 0);

        if(vectordot(metopoint, results["normal"]) < 0) {
          var_35af7dae0105a3e3 = 0;
        }
      } else {
        var_35af7dae0105a3e3 = 0;
      }
    }

    if(var_35af7dae0105a3e3) {
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
    if(bthermite) {
      if(getdvarint(@ "g_debugdamage") != 0) {
        println("<dev string:x93>");
      }

      return true;
    }
  } else if(shitloc == "none" && isDefined(einflictor)) {
    inflictorparent = einflictor getlinkedparent();

    if(self.bhasthermitestucktoshield && bthermite && isDefined(inflictorparent) && inflictorparent == self) {
      if(!isDefined(self.thermitestucktoshield)) {
        self.thermitestucktoshield = [einflictor];
      } else if(!array_contains(self.thermitestucktoshield, einflictor)) {
        self.thermitestucktoshield[self.thermitestucktoshield.size] = einflictor;
      }

      assert(isDefined(self.thermitestuckpains));

      if(getdvarint(@ "g_debugdamage") != 0) {
        println("<dev string:xaf>");
      }

      self.thermitestuckpains++;
      return true;
    } else if(issubstr(weaponbasename, "molotov")) {
      var_289cb9fcbd6aa7c8 = einflictor.origin - self.origin;
      var_8b5b7d7c1e6793de = vectorNormalize((var_289cb9fcbd6aa7c8[0], var_289cb9fcbd6aa7c8[1], 0));
      var_289cb9fcbd6aa7c8 = vectorNormalize(var_289cb9fcbd6aa7c8);

      if(vectordot(anglesToForward(self.angles), var_8b5b7d7c1e6793de) > 0.5 && -0.98 < var_289cb9fcbd6aa7c8[2] && var_289cb9fcbd6aa7c8[2] < 0.98) {
        if(getdvarint(@ "g_debugdamage") != 0) {
          println("<dev string:xcf>");
        }

        return true;
      }
    }
  }

  if(smeansofdeath == "MOD_MELEE") {
    if(isDefined(eattacker)) {
      metodamage = vectorNormalize(eattacker.origin - self.origin);
    } else {
      metodamage = vectorNormalize(vpoint - self.origin);
    }

    meforward = anglesToForward(self.angles);

    if(vectordot(meforward, metodamage) > 0.5) {
      if(getdvarint(@ "g_debugdamage") != 0) {
        println("<dev string:xf3>");
      }

      return true;
    }
  }

  return false;
}

function function_42baa3bb97d2d1d7(player, var_a3732517126407b2, idamage, vpoint, ielement) {
  idamage = int(clamp(idamage, 0, 1000000));
  player setclientomnvar("ui_dmg_num_amount", idamage);
  player setclientomnvar("ui_dmg_num_x", int(vpoint[0]));
  player setclientomnvar("ui_dmg_num_y", int(vpoint[1]));
  player setclientomnvar("ui_dmg_num_z", int(vpoint[2]));
  player setclientomnvar("ui_dmg_num_element", ielement);
  player setclientomnvar("ui_dmg_num_state", var_a3732517126407b2);
  player setclientomnvar("ui_dmg_num_notify", gettime());
}

function function_73075c88c97d2d50() {
  return isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_83ace700ff20678c) || getdvarint(@ "hash_8a8ff6ed00ccc7a", 0);
}

function function_9db5f6f105cde5da() {
  return isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_34f596a1ce19ca) || getdvarint(@ "hash_550484f2b30cf121", 0);
}

function function_87c3b43d00319847() {
  return isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_fe33630e0f09e5df) || getdvarint(@ "hash_1661f35e34f544eb", 0);
}

function function_c54b2cc2e762c201(eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_feef4b237a6beb07) {
  if(!function_73075c88c97d2d50()) {
    return;
  }

  var_768d659419360f70 = sweapon.var_9d7facbe889e667c;
  var_67f0b952bd068395 = 0;

  if(isDefined(var_768d659419360f70) && isDefined(level.weaponmetadata)) {
    weaponmetadata = level.weaponmetadata[var_768d659419360f70];

    if(isDefined(weaponmetadata)) {
      var_67f0b952bd068395 = weaponmetadata.var_67f0b952bd068395;
    }
  }

  if(istrue(var_67f0b952bd068395)) {
    return;
  }

  weapongroup = scripts\mp\utility\weapon::getweapongroup(sweapon);
  var_a3732517126407b2 = 1;
  var_c9c7e8d091b092ed = 0;

  if(istrue(isimmnue)) {
    var_a3732517126407b2 = 4;
  } else if(istrue(var_feef4b237a6beb07)) {
    var_a3732517126407b2 = 3;
  } else {
    if(isDefined(selement) && isDefined(etargethit.elementalweakness) && isarray(etargethit.elementalweakness) && istrue(etargethit.elementalweakness[selement])) {
      var_c9c7e8d091b092ed = level.var_7843c346baff928f[selement];
    }

    if(istrue(biscritical) && weapongroup != "weapon_projectile") {
      var_a3732517126407b2 = 2;
    }
  }

  if(shitloc == "none" && smeansofdeath != "MOD_MELEE") {
    usedoffset = default_to(etargethit.var_2be88729da6fdbc5, (0, 0, 12));

    if(isent(etargethit) && isalive(etargethit)) {
      usedtag = default_to(etargethit.var_52dcdba485e7ceeb, "j_head");
      vpoint = etargethit gettagorigin(usedtag) + usedoffset;
    } else {
      vpoint = etargethit.origin + usedoffset;
    }
  }

  thread function_7a6bbb24289296e7(eattacker, var_a3732517126407b2, idamage, vpoint, var_c9c7e8d091b092ed);
}

function function_7a6bbb24289296e7(player, var_a3732517126407b2, idamage, vpoint, ielement) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!isDefined(player.var_a0f98ffc22b158e3)) {
    player.var_a0f98ffc22b158e3 = 0;
  }

  if(!isDefined(ielement)) {
    ielement = 0;
  }

  player.var_a0f98ffc22b158e3++;
  wait 0.05 * player.var_a0f98ffc22b158e3;
  function_42baa3bb97d2d1d7(player, var_a3732517126407b2, idamage, vpoint, ielement);
  player.var_a0f98ffc22b158e3--;
}

function updaterecentagentkills(victim, einflictor, objweapon) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentAgentKills");
  self endon("updateRecentAgentKills");

  if(!isDefined(self.var_5431d89a36b0936)) {
    self.var_5431d89a36b0936 = 0;
  }

  self.var_5431d89a36b0936++;
  fullweaponstring = undefined;

  if(isDefined(objweapon)) {
    if(isDefined(objweapon.basename) && objweapon.basename == "none") {
      if(isDefined(einflictor) && isDefined(einflictor.weapon_name)) {
        fullweaponstring = einflictor.weapon_name;
      }
    } else {
      fullweaponstring = getcompleteweaponname(objweapon);
    }
  }

  bufferednotify("update_rapid_agent_kill_buffered", self.var_5431d89a36b0936, fullweaponstring);
  wait 4;
  self.var_5431d89a36b0936 = 0;
}