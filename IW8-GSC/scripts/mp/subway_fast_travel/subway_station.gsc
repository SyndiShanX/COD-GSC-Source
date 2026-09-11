/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\subway_fast_travel\subway_station.gsc
************************************************************/

function register_ai_damage_callbacks() {
  level.agent_funcs["actor_enemy_lw_base_br"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_base_br"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_base_br"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_base_juggernaut"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["actor_enemy_lw_br"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_br"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_br"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["actor_enemy_lw_br_brute"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_br_brute"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_br_brute"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["actor_enemy_lw_br_juggernaut"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["actor_enemy_lw_br_juggernaut"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_br_juggernaut"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
}

function callbacksoldieragentdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  var14 = self;

  if(!isDefined(var14.agent_type)) {
    return;
  }

  if(!isDefined(var12)) {
    var12 = var5;
  }

  if(!isDefined(var13)) {
    var13 = var2;
  }

  if(var4 != "MOD_SUICIDE") {
    if(is_friendly_damage(var14, var0)) {
      return;
    }
  }

  if(!isDefined(var1)) {
    var1 = var14;
  }

  var15 = should_do_damage_checks(var1, var2, var4, var5, var8, var14);

  if(!var15) {
    return;
  }

  var3 |= 4;
  var16 = var2;
  var17 = var12.basename;
  var18 = var12.classname;
  var19 = is_suicide_bomber();
  var20 = istrue(var1.inlaststand);
  var21 = var4 == "MOD_MELEE";
  var22 = scripts\engine\utility::isbulletdamage(var4) || var4 == "MOD_EXPLOSIVE_BULLET" && var8 != "none";
  var23 = isDefined(var1) && isPlayer(var1);
  var24 = isDefined(var1.owner) && isPlayer(var1.owner);
  var25 = isDefined(var14.unittype) && var14.unittype == "juggernaut";
  var26 = var22 && scripts\mp\utility\damage::isheadshot(var8, var4, var1);
  var27 = var4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var8) && var8 == "none" || var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE_SPLASH" || var4 == "MOD_PROJECTILE" || var4 == "MOD_PROJECTILE_SPLASH" || var4 == "MOD_GRENADE";
  var28 = var4 == "MOD_FIRE";
  var29 = var23 && _hasperk(var1, "specialty_bulletdamage");
  var30 = isDefined(var1.classname) && var1.classname == "script_vehicle" && isDefined(var1.owner) && isPlayer(var1.owner);
  var31 = var30 && var4 == "MOD_CRUSH";
  var32 = isDefined(var1.classname) && var1.classname == "script_vehicle" && !isDefined(var1.owner);
  var33 = var32 && var4 == "MOD_CRUSH";
  var34 = 0;
  var35 = 0;

  if((var23 || var24) && istrue(var14.invulnerable) && var4 != "MOD_SUICIDE") {
    return;
  }

  if(var25) {
    if(var21) {
      var2 = 0;
    } else {
      var2 *= 0.3;

      if(var17 == "thermite_ap_mp" || var17 == "thermite_proj_cp") {
        var2 *= 15;
      }

      if(var17 == "cruise_proj_mp") {
        var2 = self.health + 1000;
      }
    }

    if(var31) {
      var36 = ["atv"];

      if(scripts\engine\utility::array_contains(var36, var1.vehiclename)) {
        var1 dodamage(10000, var1.origin, var14);
      } else {
        playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
        var2 = self.health + 1000;
      }
    }
  } else if(var23) {
    if(var17 == "throwingknife_mp") {
      var2 = self.health + 1000;
    }

    if((var17 == "tur_bradley_mp" || var17 == "tur_bradley_ks_mp") && var4 == "MOD_PROJECTILE") {
      var2 = self.health + 1000;
    }
  }

  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    if(ref_132eb(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12)) {
      return;
    }

    if(var8 == "shield" && (var4 == "MOD_GRENADE" || var4 == "MOD_PROJECTILE") && var2 > 175) {
      var2 *= 0.05;
      var8 = "torso_lower";
    }
  }

  if(var19) {
    if(var17 == "emp_drone_player_mp") {
      var2 = self.health + 1000;
    }
  }

  if(var31) {
    playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
  }

  if(var33) {
    if(istrue(self.trial_target_think_func)) {
      var2 = 0;
      var14 notify("veh_crush_damage", var1);
    }
  }

  if(var23) {
    var14.damaged_by_player = 1;

    if(var26) {
      if(var25) {
        var2 = bink_save_hack(var2, var5, var18, var4, var1);
      }
    }

    if(var29) {
      var2 *= 2;
    }

    if(var27) {
      var37 = var2 * 2.5;

      if(isDefined(level.explosivedamagemod)) {
        var37 *= level.explosivedamagemod;
      }

      var2 += var37;
    }

    if(var28) {
      var2 += var2 * 3.5;
    }

    if(var21 && !var25) {
      if(istrue(var14.immune_to_melee_damage)) {
        var2 = 0;
        var14 notify("melee_hit_on_melee_immune", var1);
      } else {
        var2 = 150;

        if(issubstr(var17, "iw8_knife_mp")) {
          var2 = 350;
        }

        if(issubstr(var17, "iw8_me_")) {
          var2 = 350;
        } else if(isDefined(var12.muzzle)) {
          if(issubstr(var12.muzzle, "muzzlemelee")) {
            var2 = 350;
          }

          if(issubstr(var12.muzzle, "bayonet")) {
            var2 = 350;
          }
        }
      }
    }

    if(var22) {
      if(!var26) {
        if(!isDefined(level.bullet_damage_scalar)) {
          level.bullet_damage_scalar = 1;
        }

        var2 *= level.bullet_damage_scalar;
      }

      var2 *= 1;
    }

    if(scripts\mp\utility\game::getgametype() == "br") {
      var38 = isDefined(var12) && scripts\mp\utility\weapon::iskillstreakweapon(var12.basename);
      var39 = scripts\mp\damage::cac_modified_damage(var14, var1, var2, var4, var12, var6, var7, var8, var0, 0, var3, var38, var13);
      var2 = var39[0];
      var34 = var39[1];
      var35 = var39[2];

      if(scripts\mp\damage::armorvest_washit(var1) || scripts\mp\damage::helmet_washit(var1)) {
        var3 |= level.ss_circletick;
        var1 playsoundtoplayer("hit_marker_3d_armor", var1);
      }

      if(scripts\mp\damage::armorvest_wasbroke(var1) || scripts\mp\damage::helmet_wasbroke(var1)) {
        var3 |= level.sr_next_ammo_restock_time;
        var1 playsoundtoplayer("hit_marker_3d_armor_break", var1);
      }

      if(isDefined(level.ref_11ffb)) {
        var3 |= [[level.ref_11ffb]](var14);
      }
    }
  }

  if(isDefined(var17) && var17 == "tur_bradley_mp" && isDefined(var4) && var4 == "MOD_PROJECTILE_SPLASH") {
    var2 *= 2;
  }

  if(var23 || var24 || var31) {
    if(isDefined(var12)) {
      if(var24) {
        var1 = var1.owner;
      }

      binoculars_onstateupdatefunc(self, var1, var0, var12, var2, var6, var7, var8, var9, var4);
    }

    if(var2 >= var14.health) {
      if(var12.basename == "none") {
        if(isDefined(var0) && isDefined(var0.weapon_name)) {
          var12 = getcompleteweaponname(var0.weapon_name);
        }
      }

      var40 = spawnStruct();
      var40.einflictor = var0;
      var40.eattacker = var1;
      var40.idamage = var2;
      var40.idflags = var3;
      var40.smeansofdeath = var4;
      var40.sweapon = var5;
      var40.vpoint = var6;
      var40.vdir = var7;
      var40.shitloc = var8;
      var40.timeoffset = var9;
      var40.modelindex = var10;
      var40.partname = var11;
      var40.objweapon = var12;
    }
  }

  var2 = int(min(var2, var14.maxhealth));

  if(is_flashbang(var17, var12, var0) && var4 == "MOD_GRENADE_SPLASH") {
    var14 notify("flashbang", var8, 1, undefined, var1, "allies");
  }

  if(is_gas(var17) && var4 == "MOD_GRENADE_SPLASH") {
    var14 notify("flashbang", var8, 1, undefined, var1, "allies");
  }

  if(isDefined(var14.unittype) && isDefined(level.agent_funcs[var14.unittype]) && isDefined(level.agent_funcs[var14.unittype]["on_damaged_finished"])) {
    var14[[level.agent_funcs[var14.unittype]["on_damaged_finished"]]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11, var34, var35);
    return;
  }

  var14[[level.agent_funcs[var14.agent_type]["on_damaged_finished"]]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11, var34, var35);
}

function callbacksoldieragentgametypedamagefinished(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  if(var4 == "MOD_SUICIDE") {
    return;
  }

  process_damage_feedback(var0, var1, var2, var3, var4, var5, var7, var7, var8, var9, self, var13, var14);
  var3 = 0;

  if(!isDefined(self.painsound)) {
    return;
  }

  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound)) {
      self playSound(self.painsound);
    }

    self.next_dmg_sound = gettime() + 500;
    return;
  }
}

function callbacksoldieragentgametypekilled(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  deactivateagent();

  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](var1, var4);
  }

  if(isDefined(var3) && var3 == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.marked_for_death)) {
    self.marked_for_death = undefined;
  }

  if(isDefined(self.isinlaststand)) {
    var9 = spawnStruct();
    var9.einflictor = var0;
    var9.eattacker = var1;
    var9.idamage = var2;
    var9.smeansofdeath = var3;
    var9.sweapon = var4;
    var9.vdir = var5;
    var9.shitloc = var6;
    var9.timeoffset = var7;
    var9.deathanimduration = var8;
    GscBinSkip1(0x74, self.isinlaststand, var9);
  }

  if(isPlayer(var2)) {
    thread handle_death_sounds(level, var2, self);
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc)) {
    level thread[[level.removefromtargetmarkeronkillfunc]](self);
  }

  var10 = 0;
  process_damage_feedback(var1, var2, var3, var10, var4, var5, var6, var6, var7, var8, self, 0, 0);
}

function is_friendly_damage(var0, var1) {
  if(isDefined(var1)) {
    if(isDefined(var1.team) && var1.team == var0.team) {
      return true;
    }

    if(isDefined(var1.owner) && isDefined(var1.owner.team) && var1.owner.team == var0.team) {
      return true;
    }
  }

  return false;
}

function should_do_damage_checks(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    return false;
  } else if(var0 != var5 && isDefined(var0.team) && var0.team == var5.team) {
    return false;
  } else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](var0, var1, var2, var3, var4, var5)) {
    return false;
  }

  return true;
}

function is_suicide_bomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function bink_save_hack(var0, var1, var2, var3, var4) {
  var5 = var0;

  switch (var2) {
    case "rifle":
      var5 = min(var0, 84);
      break;
    case "smg":
      var5 = min(var0, 110);
      break;
    case "mg":
      var5 = min(var0, 105);
      break;
    case "spread":
      var5 = min(var0, 84);
      break;
    case "pistol":
      var5 = min(var0, 75);
      break;
    case "sniper":
      var5 = min(var0, 130);
      break;
    default:
      var5 = var0;
      break;
  }

  return var0;
}

function binoculars_onstateupdatefunc(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var0.attackerdata)) {
    var0.attackerdata = [];
  }

  if(!isDefined(var1.guid) && (isagent(var1) || isPlayer(var1))) {
    var1.guid = var1 scripts\mp\utility\player::getuniqueid();
  }

  if(!isDefined(var1.guid)) {
    return;
  }

  if(!isDefined(var0.attackerdata[var1.guid])) {
    var0.attackers[var1.guid] = var1;
    var0.attackerdata[var1.guid] = spawnStruct();
    var0.attackerdata[var1.guid].damage = 0;
    var0.attackerdata[var1.guid].attackerent = var1;
    var0.attackerdata[var1.guid].firsttimedamaged = gettime();
    var0.attackerdata[var1.guid].hitcount = 1;
  } else {
    var0.attackerdata[var1.guid].hitcount++;
  }

  if(scripts\mp\utility\weapon::iscacprimaryweapon(var3) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var3)) {
    var0.attackerdata[var1.guid].diddamagewithprimary = 1;
  }

  if(isDefined(var9) && var9 != "MOD_MELEE") {
    var0.attackerdata[var1.guid].didnonmeleedamage = 1;
  }

  var10 = scripts\mp\utility\weapon::getequipmenttype(var3.basename);

  if(isDefined(var10)) {
    if(var10 == "lethal") {
      var0.attackerdata[var1.guid].diddamagewithlethalequipment = 1;
    }

    if(var10 == "tactical") {
      var0.attackerdata[var1.guid].diddamagewithtacticalequipment = 1;
    }
  }

  var0.attackerdata[var1.guid].damage += var4;
  var0.attackerdata[var1.guid].weapon = createheadicon(var3);
  var0.attackerdata[var1.guid].objweapon = var3;
  var0.attackerdata[var1.guid].vpoint = var5;
  var0.attackerdata[var1.guid].vdir = var6;
  var0.attackerdata[var1.guid].shitloc = var7;
  var0.attackerdata[var1.guid].psoffsettime = var8;
  var0.attackerdata[var1.guid].smeansofdeath = var9;
  var0.attackerdata[var1.guid].attackerent = var1;
  var0.attackerdata[var1.guid].lasttimedamaged = gettime();

  if(isDefined(var2) && !isPlayer(var2) && isDefined(var2.primaryweapon)) {
    var0.attackerdata[var1.guid].sprimaryweapon = var2.primaryweapon;
    return;
  }

  if(isDefined(var1) && isPlayer(var1) && !nullweapon(var1 getcurrentprimaryweapon())) {
    var0.attackerdata[var1.guid].sprimaryweapon = createheadicon(var1 getcurrentprimaryweapon());
    return;
  }

  var0.attackerdata[var1.guid].sprimaryweapon = undefined;
}

function is_flashbang(var0, var1, var2) {
  if(isDefined(var1.underbarrel)) {
    var3 = scripts\mp\utility\weapon::attachmentmap_tobase(var1.underbarrel);

    if(var3 == "glflash" || var3 == "glconc") {
      return true;
    }
  }

  return var0 == "flash_grenade_mp";
}

function is_gas(var0) {
  return var0 == "gas_mp";
}

function deactivateagent() {
  if(scripts\mp\utility\entity::isgameparticipant(self)) {
    removefromparticipantsarray();
  }

  removefromcharactersarray();
  self.isactive = 0;
  self.hasdied = 0;
  self.marked_by_hybrid = undefined;
  self.mortartarget = undefined;
  self.owner = undefined;
  self.connecttime = undefined;
  self.waitingtodeactivate = undefined;
  self.is_burning = undefined;
  self.is_electrified = undefined;
  self.stun_hit = undefined;
  self.targetname = undefined;
  self.script_noteworthy = undefined;
  self.script_linkname = undefined;
  self.script_linkto = undefined;
  self.target = undefined;
  self.mutations = undefined;

  foreach(var1 in level.characters) {
    if(isDefined(var1.attackers)) {
      foreach(var3 in var1.attackers) {
        if(var3 == self) {
          var1.attackers[var4] = undefined;
        }
      }
    }
  }

  if(isDefined(self.headmodel)) {
    self.headmodel = undefined;
  }

  scripts\mp\mp_agent::deactivateagent();
  self notify("disconnect");
}

function removefromparticipantsarray() {
  var0 = 0;

  for(var1 = 0; var1 < level.participants.size; var1++) {
    if(level.participants[var1] == self) {
      var0 = 1;

      while(var1 < level.participants.size - 1) {
        level.participants[var1] = level.participants[var1 + 1];
        var1++;
      }

      level.participants[var1] = undefined;
      break;
    }
  }
}

function removefromcharactersarray() {
  var0 = 0;

  for(var1 = 0; var1 < level.characters.size; var1++) {
    if(level.characters[var1] == self) {
      var0 = 1;

      while(var1 < level.characters.size - 1) {
        level.characters[var1] = level.characters[var1 + 1];
        var1++;
      }

      level.characters[var1] = undefined;
      break;
    }
  }
}

function handle_death_sounds(var0, var1, var2) {
  if(!scripts\engine\utility::isbulletdamage(var2)) {
    return;
  }

  if(isDefined(var1.deathsound) && soundexists(var1.deathsound)) {
    playsoundatpos(var1.origin, var1.deathsound);
  }

  var3 = var1;

  if(var2 == "MOD_HEAD_SHOT") {
    var3 playsoundtoplayer("bullet_impact_headshot", var0);
    var3 playsoundtoteam("bullet_impact_headshot_npc", var0.team, var0);
    return;
  }

  var3 playsoundtoplayer("mp_kill_alert", var0);
  var3 playsoundtoteam("mp_hit_alert_final_npc", var0.team, var0);
}

function process_damage_feedback(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = isDefined(var1) && isDefined(var1.classname) && isDefined(var1.classname) && !isDefined(var1.gunner) && (var1.classname == "script_vehicle" || var1.classname == "misc_turret" || var1.classname == "script_model");
  var14 = undefined;

  if(!isDefined(var11)) {
    var11 = 0;
  }

  if(!isDefined(var12)) {
    var12 = 0;
  }

  if(var13 && isDefined(var1.gunner)) {
    var14 = var1.gunner;
  } else if(isDefined(var1) && isDefined(var1.owner)) {
    var14 = var1.owner;
  } else {
    var14 = var1;
  }

  var15 = scripts\engine\utility::isbulletdamage(var4);
  var16 = scripts\engine\utility::ter_op(var15 && scripts\mp\utility\weapon::isprimaryweapon(var5), "standardspread", "standard");
  var17 = 0;

  if(isDefined(var1) && isDefined(var1.class) && var1.class == "engineer") {
    if(isDefined(var4) && scripts\engine\utility::isbulletdamage(var4)) {
      var17 = 1;
    }
  }

  if(isDefined(var14) && var14 != var10 && var2 + var11 + var12 > 0 && (!isDefined(var8) || var8 != "shield")) {
    var18 = !isalive(var10) || isagent(var10) && var2 >= var10.health;

    if(self.asm.archetype == "soldier_lw_br") {
      var18 = !isalive(var10);
    }

    if(istrue(self.ref_14693)) {
      var18 = !isalive(var10);
    }

    if(istrue(var10.isjuggernaut)) {
      var16 = "hitjuggernaut";
    } else if(var10 scripts\mp\heavyarmor::hasheavyarmor() || var10 scripts\mp\heavyarmor::hasheavyarmorinvulnerability() || scripts\mp\damage::heavyarmorvest_washit(var1)) {
      var16 = "hitarmorheavy";
    } else if(var3 &level.idflags_stun) {
      var16 = "stun";
    } else if(scripts\mp\utility\damage::istacticaldamage(var5, var4) && _hasperk(var10, "specialty_stun_resistance") && !_hasperk(var10, "penalty_stun_more")) {
      var16 = "hittacresist";
    } else if(isexplosivedamagemod(var4) && _hasperk(var10, "specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var1, var10, var5, var4, var0, var8)) {
      var16 = "hitblastshield";
    } else if(scripts\mp\utility\damage::hashealthshield(var10)) {
      var16 = "hitarmorlight";
    } else if(scripts\mp\damage::armorvest_wasbroke(var1)) {
      var16 = "hitarmorlightbreak";
    } else if(scripts\mp\damage::helmet_wasbroke(var1)) {
      var16 = "hithelmetlightbreak";
    } else if(scripts\mp\damage::armorvest_washit(var1)) {
      var16 = "hitarmorlight";
    } else if(scripts\mp\damage::helmet_washit(var1)) {
      var16 = "hithelmetlight";
    } else if(var11 > 0) {
      var16 = "hitarmorlight";
    } else if(_hasperk(var10, "specialty_pistoldeath") && isDefined(var10.inlaststand) && var10.inlaststand == 1 && !var10.hasshownlaststandicon) {
      var10.hasshownlaststandicon = 1;
      var16 = "hitlaststand";
    }

    if(isDefined(var10.playerforcespawn) && var10.playerforcespawn.size > 1) {
      var16 = "cp_relic_buff";
    }

    var19 = "standard";

    if(var16 == "hitarmorlightbreak") {
      if(var19 == "standardspread") {
        var19 = "standardspreadarmor";
      } else {
        var19 = "standardarmor";
      }
    }

    var20 = weaponclass(var5);
    var21 = var20 == "spread";
    var22 = !var21 && scripts\mp\utility\damage::isheadshot(var8, var4, var1);
    var23 = 1;
    var24 = var4 == "MOD_MELEE";
    var25 = "" + gettime();

    if(!var24 && var21 && isDefined(var14.pelletdmg) && isDefined(var14.pelletdmg[var25]) && isDefined(var14.pelletdmg[var25][var10.guid]) && var14.pelletdmg[var25][var10.guid] > 1) {
      if(var18) {
        var24 = 1;
      } else {
        var23 = 0;
      }
    }

    var26 = undefined;

    if(var10.health <= var2) {
      var26 = 1;
    }

    if(self.asm.archetype == "soldier_lw_br") {
      var26 = var10.health <= 0;
    }

    if(istrue(self.ref_14693)) {
      var26 = var10.health <= 0;
    }

    var22 = scripts\mp\utility\damage::isheadshot(var8, var4, var1);

    if(var23) {
      if(isDefined(var1)) {
        if(isDefined(var1.owner)) {
          var1.owner thread scripts\mp\damagefeedback::updatedamagefeedback(var16, var26, var22, var19);
          return;
        }

        var1 thread scripts\mp\damagefeedback::updatedamagefeedback(var16, var26, var22, var19);
        return;
      }

      return;
    }

    return;
  }
}

function _hasperk(var0) {
  var1 = self.perks;

  if(!isDefined(var1)) {
    return false;
  }

  if(isDefined(var1[var0])) {
    return true;
  }

  return false;
}

function ref_132eb(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = var12.basename;
  var14 = 0;

  if(isDefined(var0) && (issubstr(var13, "thermite") || isDefined(var12.magazine) && issubstr(var12.magazine, "boltfire") || isDefined(var0.weapon_name) && issubstr(var0.weapon_name, "incendiary"))) {
    var14 = 1;
    var15 = var8 == "shield";

    if(var15) {
      var16 = scripts\engine\trace::create_character_contents();
      var17 = vectorNormalize(var7);
      var18 = var6 - var17 * 12;
      var19 = var6 + var17 * 12;
      var20 = scripts\engine\trace::ray_trace_detail(var18, var19, undefined, var16);

      if(var20["fraction"] > 0 && var20["fraction"] < 1) {
        var21 = var6 - self.origin;
        var21 = (var21[0], var21[1], 0);

        if(vectordot(var21, var20["normal"]) < 0) {
          var15 = 0;
        }
      } else {
        var15 = 0;
      }
    }

    if(var15) {
      var22 = var0 getlinkedparent();

      if(isDefined(var22) && var22 == self) {
        self.clearspaceforscriptableinstance = 1;
        self.ref_13b2a = 0;
      }
    } else if(var8 != "none") {
      self.clearspaceforscriptableinstance = undefined;
      self.ref_13b2a = undefined;
    }
  }

  if(var8 == "shield") {
    if(var14) {
      return true;
    }
  } else if(var8 == "none" && isDefined(var0)) {
    var23 = var0 getlinkedparent();

    if(istrue(self.clearspaceforscriptableinstance) && var14 && isDefined(var23) && var23 == self) {
      if(!isDefined(self.ref_13b2c)) {
        self.ref_13b2c = [var0];
      } else if(!scripts\engine\utility::array_contains(self.ref_13b2c, var0)) {
        self.ref_13b2c[self.ref_13b2c.size] = var0;
      }

      self.ref_13b2a++;
      return true;
    } else if(issubstr(var13, "molotov")) {
      var24 = var0.origin - self.origin;
      var25 = vectorNormalize((var24[0], var24[1], 0));
      var24 = vectorNormalize(var24);

      if(vectordot(anglesToForward(self.angles), var25) > 0.5 && -0.98 < var24[2] && var24[2] < 0.98) {
        return true;
      }
    }
  }

  if(var4 == "MOD_MELEE") {
    if(isDefined(var1)) {
      var26 = vectorNormalize(var1.origin - self.origin);
    } else {
      var26 = vectorNormalize(var7 - self.origin);
    }

    var27 = anglesToForward(self.angles);

    if(vectordot(var27, var26) > 0.5) {
      return true;
    }
  }

  return false;
}