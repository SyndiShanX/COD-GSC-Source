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

function callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = self;

  if(!isDefined(var_14.agent_type)) {
    return;
  }

  if(!isDefined(var_12)) {
    var_12 = var_5;
  }

  if(!isDefined(var_13)) {
    var_13 = var_2;
  }

  if(var_4 != "MOD_SUICIDE") {
    if(is_friendly_damage(var_14, var_0)) {
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_14;
  }

  var_15 = should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_14);

  if(!var_15) {
    return;
  }

  var_3 |= 4;
  var_16 = var_2;
  var_17 = var_12.basename;
  var_18 = var_12.classname;
  var_19 = is_suicide_bomber();
  var_20 = istrue(var_1.inlaststand);
  var_21 = var_4 == "MOD_MELEE";
  var_22 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_23 = isDefined(var_1) && isPlayer(var_1);
  var_24 = isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_25 = isDefined(var_14.unittype) && var_14.unittype == "juggernaut";
  var_26 = var_22 && scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1);
  var_27 = var_4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_8) && var_8 == "none" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE";
  var_28 = var_4 == "MOD_FIRE";
  var_29 = var_23 && _hasperk(var_1, "specialty_bulletdamage");
  var_30 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_31 = var_30 && var_4 == "MOD_CRUSH";
  var_32 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && !isDefined(var_1.owner);
  var_33 = var_32 && var_4 == "MOD_CRUSH";
  var_34 = 0;
  var_35 = 0;

  if((var_23 || var_24) && istrue(var_14.invulnerable) && var_4 != "MOD_SUICIDE") {
    return;
  }

  if(var_25) {
    if(var_21) {
      var_2 = 0;
    } else {
      var_2 *= 0.3;

      if(var_17 == "thermite_ap_mp" || var_17 == "thermite_proj_cp") {
        var_2 *= 15;
      }

      if(var_17 == "cruise_proj_mp") {
        var_2 = self.health + 1000;
      }
    }

    if(var_31) {
      var_36 = ["atv"];

      if(scripts\engine\utility::array_contains(var_36, var_1.vehiclename)) {
        var_1 dodamage(10000, var_1.origin, var_14);
      } else {
        playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
        var_2 = self.health + 1000;
      }
    }
  } else if(var_23) {
    if(var_17 == "throwingknife_mp") {
      var_2 = self.health + 1000;
    }

    if((var_17 == "tur_bradley_mp" || var_17 == "tur_bradley_ks_mp") && var_4 == "MOD_PROJECTILE") {
      var_2 = self.health + 1000;
    }
  }

  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    if(ref_132EB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
      return;
    }

    if(var_8 == "shield" && (var_4 == "MOD_GRENADE" || var_4 == "MOD_PROJECTILE") && var_2 > 175) {
      var_2 *= 0.05;
      var_8 = "torso_lower";
    }
  }

  if(var_19) {
    if(var_17 == "emp_drone_player_mp") {
      var_2 = self.health + 1000;
    }
  }

  if(var_31) {
    playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
  }

  if(var_33) {
    if(istrue(self.trial_target_think_func)) {
      var_2 = 0;
      var_14 notify("veh_crush_damage", var_1);
    }
  }

  if(var_23) {
    var_14.damaged_by_player = 1;

    if(var_26) {
      if(var_25) {
        var_2 = bink_save_hack(var_2, var_5, var_18, var_4, var_1);
      }
    }

    if(var_29) {
      var_2 *= 2;
    }

    if(var_27) {
      var_37 = var_2 * 2.5;

      if(isDefined(level.explosivedamagemod)) {
        var_37 *= level.explosivedamagemod;
      }

      var_2 += var_37;
    }

    if(var_28) {
      var_2 += var_2 * 3.5;
    }

    if(var_21 && !var_25) {
      if(istrue(var_14.immune_to_melee_damage)) {
        var_2 = 0;
        var_14 notify("melee_hit_on_melee_immune", var_1);
      } else {
        var_2 = 150;

        if(issubstr(var_17, "iw8_knife_mp")) {
          var_2 = 350;
        }

        if(issubstr(var_17, "iw8_me_")) {
          var_2 = 350;
        } else if(isDefined(var_12.muzzle)) {
          if(issubstr(var_12.muzzle, "muzzlemelee")) {
            var_2 = 350;
          }

          if(issubstr(var_12.muzzle, "bayonet")) {
            var_2 = 350;
          }
        }
      }
    }

    if(var_22) {
      if(!var_26) {
        if(!isDefined(level.bullet_damage_scalar)) {
          level.bullet_damage_scalar = 1;
        }

        var_2 *= level.bullet_damage_scalar;
      }

      var_2 *= 1;
    }

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_38 = isDefined(var_12) && scripts\mp\utility\weapon::iskillstreakweapon(var_12.basename);
      var_39 = scripts\mp\damage::cac_modified_damage(var_14, var_1, var_2, var_4, var_12, var_6, var_7, var_8, var_0, 0, var_3, var_38, var_13);
      var_2 = var_39[0];
      var_34 = var_39[1];
      var_35 = var_39[2];

      if(scripts\mp\damage::armorvest_washit(var_1) || scripts\mp\damage::helmet_washit(var_1)) {
        var_3 |= level.ss_circletick;
        var_1 playsoundtoplayer("hit_marker_3d_armor", var_1);
      }

      if(scripts\mp\damage::armorvest_wasbroke(var_1) || scripts\mp\damage::helmet_wasbroke(var_1)) {
        var_3 |= level.sr_next_ammo_restock_time;
        var_1 playsoundtoplayer("hit_marker_3d_armor_break", var_1);
      }

      if(isDefined(level.ref_11FFB)) {
        var_3 |= [[level.ref_11FFB]](var_14);
      }
    }
  }

  if(isDefined(var_17) && var_17 == "tur_bradley_mp" && isDefined(var_4) && var_4 == "MOD_PROJECTILE_SPLASH") {
    var_2 *= 2;
  }

  if(var_23 || var_24 || var_31) {
    if(isDefined(var_12)) {
      if(var_24) {
        var_1 = var_1.owner;
      }

      binoculars_onstateupdatefunc(self, var_1, var_0, var_12, var_2, var_6, var_7, var_8, var_9, var_4);
    }

    if(var_2 >= var_14.health) {
      if(var_12.basename == "none") {
        if(isDefined(var_0) && isDefined(var_0.weapon_name)) {
          var_12 = getcompleteweaponname(var_0.weapon_name);
        }
      }

      var_40 = spawnStruct();
      var_40.einflictor = var_0;
      var_40.eattacker = var_1;
      var_40.idamage = var_2;
      var_40.idflags = var_3;
      var_40.smeansofdeath = var_4;
      var_40.sweapon = var_5;
      var_40.vpoint = var_6;
      var_40.vdir = var_7;
      var_40.shitloc = var_8;
      var_40.timeoffset = var_9;
      var_40.modelindex = var_10;
      var_40.partname = var_11;
      var_40.objweapon = var_12;
    }
  }

  var_2 = int(min(var_2, var_14.maxhealth));

  if(is_flashbang(var_17, var_12, var_0) && var_4 == "MOD_GRENADE_SPLASH") {
    var_14 notify("flashbang", var_8, 1, undefined, var_1, "allies");
  }

  if(is_gas(var_17) && var_4 == "MOD_GRENADE_SPLASH") {
    var_14 notify("flashbang", var_8, 1, undefined, var_1, "allies");
  }

  if(isDefined(var_14.unittype) && isDefined(level.agent_funcs[var_14.unittype]) && isDefined(level.agent_funcs[var_14.unittype]["on_damaged_finished"])) {
    var_14[[level.agent_funcs[var_14.unittype]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11, var_34, var_35);
    return;
  }

  var_14[[level.agent_funcs[var_14.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11, var_34, var_35);
}

function callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(var_4 == "MOD_SUICIDE") {
    return;
  }

  process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_7, var_7, var_8, var_9, self, var_13, var_14);
  var_3 = 0;

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

function callbacksoldieragentgametypekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  deactivateagent();

  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](var_1, var_4);
  }

  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.marked_for_death)) {
    self.marked_for_death = undefined;
  }

  if(isDefined(self.isinlaststand)) {
    var_9 = spawnStruct();
    var_9.einflictor = var_0;
    var_9.eattacker = var_1;
    var_9.idamage = var_2;
    var_9.smeansofdeath = var_3;
    var_9.sweapon = var_4;
    var_9.vdir = var_5;
    var_9.shitloc = var_6;
    var_9.timeoffset = var_7;
    var_9.deathanimduration = var_8;
    GscBinSkip1(0x74, self.isinlaststand, var_9);
  }

  if(isPlayer(var_2)) {
    thread handle_death_sounds(level, var_2, self);
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc)) {
    level thread[[level.removefromtargetmarkeronkillfunc]](self);
  }

  var_10 = 0;
  process_damage_feedback(var_1, var_2, var_3, var_10, var_4, var_5, var_6, var_6, var_7, var_8, self, 0, 0);
}

function is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return true;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team) {
      return true;
    }
  }

  return false;
}

function should_do_damage_checks(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    return false;
  } else if(var_0 != var_5 && isDefined(var_0.team) && var_0.team == var_5.team) {
    return false;
  } else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](var_0, var_1, var_2, var_3, var_4, var_5)) {
    return false;
  }

  return true;
}

function is_suicide_bomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function bink_save_hack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;

  switch (var_2) {
    case "rifle":
      var_5 = min(var_0, 84);
      break;
    case "smg":
      var_5 = min(var_0, 110);
      break;
    case "mg":
      var_5 = min(var_0, 105);
      break;
    case "spread":
      var_5 = min(var_0, 84);
      break;
    case "pistol":
      var_5 = min(var_0, 75);
      break;
    case "sniper":
      var_5 = min(var_0, 130);
      break;
    default:
      var_5 = var_0;
      break;
  }

  return var_0;
}

function binoculars_onstateupdatefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0.attackerdata)) {
    var_0.attackerdata = [];
  }

  if(!isDefined(var_1.guid) && (isagent(var_1) || isPlayer(var_1))) {
    var_1.guid = var_1 scripts\mp\utility\player::getuniqueid();
  }

  if(!isDefined(var_1.guid)) {
    return;
  }

  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hitcount = 1;
  } else {
    var_0.attackerdata[var_1.guid].hitcount++;
  }

  if(scripts\mp\utility\weapon::iscacprimaryweapon(var_3) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_3)) {
    var_0.attackerdata[var_1.guid].diddamagewithprimary = 1;
  }

  if(isDefined(var_9) && var_9 != "MOD_MELEE") {
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;
  }

  var_10 = scripts\mp\utility\weapon::getequipmenttype(var_3.basename);

  if(isDefined(var_10)) {
    if(var_10 == "lethal") {
      var_0.attackerdata[var_1.guid].diddamagewithlethalequipment = 1;
    }

    if(var_10 == "tactical") {
      var_0.attackerdata[var_1.guid].diddamagewithtacticalequipment = 1;
    }
  }

  var_0.attackerdata[var_1.guid].damage += var_4;
  var_0.attackerdata[var_1.guid].weapon = createheadicon(var_3);
  var_0.attackerdata[var_1.guid].objweapon = var_3;
  var_0.attackerdata[var_1.guid].vpoint = var_5;
  var_0.attackerdata[var_1.guid].vdir = var_6;
  var_0.attackerdata[var_1.guid].shitloc = var_7;
  var_0.attackerdata[var_1.guid].psoffsettime = var_8;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
  var_0.attackerdata[var_1.guid].attackerent = var_1;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon)) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
    return;
  }

  if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon())) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
    return;
  }

  var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

function is_flashbang(var_0, var_1, var_2) {
  if(isDefined(var_1.underbarrel)) {
    var_3 = scripts\mp\utility\weapon::attachmentmap_tobase(var_1.underbarrel);

    if(var_3 == "glflash" || var_3 == "glconc") {
      return true;
    }
  }

  return var_0 == "flash_grenade_mp";
}

function is_gas(var_0) {
  return var_0 == "gas_mp";
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

  foreach(var_1 in level.characters) {
    if(isDefined(var_1.attackers)) {
      foreach(var_3 in var_1.attackers) {
        if(var_3 == self) {
          var_1.attackers[var_4] = undefined;
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
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      var_0 = 1;

      while(var_1 < level.participants.size - 1) {
        level.participants[var_1] = level.participants[var_1 + 1];
        var_1++;
      }

      level.participants[var_1] = undefined;
      break;
    }
  }
}

function removefromcharactersarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      var_0 = 1;

      while(var_1 < level.characters.size - 1) {
        level.characters[var_1] = level.characters[var_1 + 1];
        var_1++;
      }

      level.characters[var_1] = undefined;
      break;
    }
  }
}

function handle_death_sounds(var_0, var_1, var_2) {
  if(!scripts\engine\utility::isbulletdamage(var_2)) {
    return;
  }

  if(isDefined(var_1.deathsound) && soundexists(var_1.deathsound)) {
    playsoundatpos(var_1.origin, var_1.deathsound);
  }

  var_3 = var_1;

  if(var_2 == "MOD_HEAD_SHOT") {
    var_3 playsoundtoplayer("bullet_impact_headshot", var_0);
    var_3 playsoundtoteam("bullet_impact_headshot_npc", var_0.team, var_0);
    return;
  }

  var_3 playsoundtoplayer("mp_kill_alert", var_0);
  var_3 playsoundtoteam("mp_hit_alert_final_npc", var_0.team, var_0);
}

function process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = isDefined(var_1) && isDefined(var_1.classname) && isDefined(var_1.classname) && !isDefined(var_1.gunner) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");
  var_14 = undefined;

  if(!isDefined(var_11)) {
    var_11 = 0;
  }

  if(!isDefined(var_12)) {
    var_12 = 0;
  }

  if(var_13 && isDefined(var_1.gunner)) {
    var_14 = var_1.gunner;
  } else if(isDefined(var_1) && isDefined(var_1.owner)) {
    var_14 = var_1.owner;
  } else {
    var_14 = var_1;
  }

  var_15 = scripts\engine\utility::isbulletdamage(var_4);
  var_16 = scripts\engine\utility::ter_op(var_15 && scripts\mp\utility\weapon::isprimaryweapon(var_5), "standardspread", "standard");
  var_17 = 0;

  if(isDefined(var_1) && isDefined(var_1.class) && var_1.class == "engineer") {
    if(isDefined(var_4) && scripts\engine\utility::isbulletdamage(var_4)) {
      var_17 = 1;
    }
  }

  if(isDefined(var_14) && var_14 != var_10 && var_2 + var_11 + var_12 > 0 && (!isDefined(var_8) || var_8 != "shield")) {
    var_18 = !isalive(var_10) || isagent(var_10) && var_2 >= var_10.health;

    if(self.asm.archetype == "soldier_lw_br") {
      var_18 = !isalive(var_10);
    }

    if(istrue(self.ref_14693)) {
      var_18 = !isalive(var_10);
    }

    if(istrue(var_10.isjuggernaut)) {
      var_16 = "hitjuggernaut";
    } else if(var_10 scripts\mp\heavyarmor::hasheavyarmor() || var_10 scripts\mp\heavyarmor::hasheavyarmorinvulnerability() || scripts\mp\damage::heavyarmorvest_washit(var_1)) {
      var_16 = "hitarmorheavy";
    } else if(var_3 &level.idflags_stun) {
      var_16 = "stun";
    } else if(scripts\mp\utility\damage::istacticaldamage(var_5, var_4) && _hasperk(var_10, "specialty_stun_resistance") && !_hasperk(var_10, "penalty_stun_more")) {
      var_16 = "hittacresist";
    } else if(isexplosivedamagemod(var_4) && _hasperk(var_10, "specialty_blastshield") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_1, var_10, var_5, var_4, var_0, var_8)) {
      var_16 = "hitblastshield";
    } else if(scripts\mp\utility\damage::hashealthshield(var_10)) {
      var_16 = "hitarmorlight";
    } else if(scripts\mp\damage::armorvest_wasbroke(var_1)) {
      var_16 = "hitarmorlightbreak";
    } else if(scripts\mp\damage::helmet_wasbroke(var_1)) {
      var_16 = "hithelmetlightbreak";
    } else if(scripts\mp\damage::armorvest_washit(var_1)) {
      var_16 = "hitarmorlight";
    } else if(scripts\mp\damage::helmet_washit(var_1)) {
      var_16 = "hithelmetlight";
    } else if(var_11 > 0) {
      var_16 = "hitarmorlight";
    } else if(_hasperk(var_10, "specialty_pistoldeath") && isDefined(var_10.inlaststand) && var_10.inlaststand == 1 && !var_10.hasshownlaststandicon) {
      var_10.hasshownlaststandicon = 1;
      var_16 = "hitlaststand";
    }

    if(isDefined(var_10.playerforcespawn) && var_10.playerforcespawn.size > 1) {
      var_16 = "cp_relic_buff";
    }

    var_19 = "standard";

    if(var_16 == "hitarmorlightbreak") {
      if(var_19 == "standardspread") {
        var_19 = "standardspreadarmor";
      } else {
        var_19 = "standardarmor";
      }
    }

    var_20 = weaponclass(var_5);
    var_21 = var_20 == "spread";
    var_22 = !var_21 && scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1);
    var_23 = 1;
    var_24 = var_4 == "MOD_MELEE";
    var_25 = "" + gettime();

    if(!var_24 && var_21 && isDefined(var_14.pelletdmg) && isDefined(var_14.pelletdmg[var_25]) && isDefined(var_14.pelletdmg[var_25][var_10.guid]) && var_14.pelletdmg[var_25][var_10.guid] > 1) {
      if(var_18) {
        var_24 = 1;
      } else {
        var_23 = 0;
      }
    }

    var_26 = undefined;

    if(var_10.health <= var_2) {
      var_26 = 1;
    }

    if(self.asm.archetype == "soldier_lw_br") {
      var_26 = var_10.health <= 0;
    }

    if(istrue(self.ref_14693)) {
      var_26 = var_10.health <= 0;
    }

    var_22 = scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1);

    if(var_23) {
      if(isDefined(var_1)) {
        if(isDefined(var_1.owner)) {
          var_1.owner thread scripts\mp\damagefeedback::updatedamagefeedback(var_16, var_26, var_22, var_19);
          return;
        }

        var_1 thread scripts\mp\damagefeedback::updatedamagefeedback(var_16, var_26, var_22, var_19);
        return;
      }

      return;
    }

    return;
  }
}

function _hasperk(var_0) {
  var_1 = self.perks;

  if(!isDefined(var_1)) {
    return false;
  }

  if(isDefined(var_1[var_0])) {
    return true;
  }

  return false;
}

function ref_132EB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_12.basename;
  var_14 = 0;

  if(isDefined(var_0) && (issubstr(var_13, "thermite") || isDefined(var_12.magazine) && issubstr(var_12.magazine, "boltfire") || isDefined(var_0.weapon_name) && issubstr(var_0.weapon_name, "incendiary"))) {
    var_14 = 1;
    var_15 = var_8 == "shield";

    if(var_15) {
      var_16 = scripts\engine\trace::create_character_contents();
      var_17 = vectorNormalize(var_7);
      var_18 = var_6 - var_17 * 12;
      var_19 = var_6 + var_17 * 12;
      var_20 = scripts\engine\trace::ray_trace_detail(var_18, var_19, undefined, var_16);

      if(var_20["fraction"] > 0 && var_20["fraction"] < 1) {
        var_21 = var_6 - self.origin;
        var_21 = (var_21[0], var_21[1], 0);

        if(vectordot(var_21, var_20["normal"]) < 0) {
          var_15 = 0;
        }
      } else {
        var_15 = 0;
      }
    }

    if(var_15) {
      var_22 = var_0 getlinkedparent();

      if(isDefined(var_22) && var_22 == self) {
        self.clearspaceforscriptableinstance = 1;
        self.ref_13B2A = 0;
      }
    } else if(var_8 != "none") {
      self.clearspaceforscriptableinstance = undefined;
      self.ref_13B2A = undefined;
    }
  }

  if(var_8 == "shield") {
    if(var_14) {
      return true;
    }
  } else if(var_8 == "none" && isDefined(var_0)) {
    var_23 = var_0 getlinkedparent();

    if(istrue(self.clearspaceforscriptableinstance) && var_14 && isDefined(var_23) && var_23 == self) {
      if(!isDefined(self.ref_13B2C)) {
        self.ref_13B2C = [var_0];
      } else if(!scripts\engine\utility::array_contains(self.ref_13B2C, var_0)) {
        self.ref_13B2C[self.ref_13B2C.size] = var_0;
      }

      self.ref_13B2A++;
      return true;
    } else if(issubstr(var_13, "molotov")) {
      var_24 = var_0.origin - self.origin;
      var_25 = vectorNormalize((var_24[0], var_24[1], 0));
      var_24 = vectorNormalize(var_24);

      if(vectordot(anglesToForward(self.angles), var_25) > 0.5 && -0.98 < var_24[2] && var_24[2] < 0.98) {
        return true;
      }
    }
  }

  if(var_4 == "MOD_MELEE") {
    if(isDefined(var_1)) {
      var_26 = vectorNormalize(var_1.origin - self.origin);
    } else {
      var_26 = vectorNormalize(var_7 - self.origin);
    }

    var_27 = anglesToForward(self.angles);

    if(vectordot(var_27, var_26) > 0.5) {
      return true;
    }
  }

  return false;
}