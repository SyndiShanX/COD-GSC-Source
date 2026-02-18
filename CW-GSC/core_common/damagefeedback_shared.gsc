/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\damagefeedback_shared.gsc
*************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapon_utils;
#namespace damagefeedback;

function private autoexec __init__system__() {
  system::register(#"damagefeedback", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_connect(&on_player_connect);
}

function on_player_connect() {}

function should_play_sound(mod) {
  if(!isDefined(mod)) {
    return false;
  }

  switch (mod) {
    case # "mod_melee_weapon_butt":
    case # "mod_crush":
    case # "mod_hit_by_object":
    case # "mod_grenade_splash":
    case # "mod_melee_assassinate":
    case # "mod_melee":
      return false;
  }

  return true;
}

function play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
  if(sessionmodeiscampaigngame()) {
    hitalias = hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal);
  }

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    hitalias = hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
  }

  if(sessionmodeiszombiesgame()) {
    hitalias = hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
  }

  return hitalias;
}

function hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal) {
  hitalias = undefined;
  suffix = "";

  if(should_play_sound(weapon)) {
    if(isPlayer(self)) {
      if(self isinvehicle() && !is_true(level.var_95b5c0fe)) {
        return hitalias;
      }
    }

    if(is_true(fatal)) {
      suffix = "_fatal";
    } else {
      suffix = "_nf";
    }

    if(weapons::isheadshot(victim, shitloc, weapon)) {
      hitalias = # "hash_7049f87709615569";
    } else {
      hitalias = # "hash_66f38123cad3a33b";
    }

    if(isDefined(hitalias)) {
      hitalias += suffix;
    }

    if(isvehicle(psoffsettime)) {
      hitalias = # "hash_2ce81d103e923201";
    }
  }

  return hitalias;
}

function hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
  hitalias = undefined;

  if(!isDefined(victim)) {
    return;
  }

  if(isDefined(inflictor) && inflictor === "MOD_EXECUTION") {
    return # "hash_58d3709b34454b17";
  }

  if(is_true(fatal) && victim.name == # "inventory_hero_flamethrower") {
    hitalias = # "hash_bb326e71044938c";
    return hitalias;
  }

  if(isDefined(victim.hitsound) && victim.hitsound != "") {
    hitalias = victim.hitsound;
    return hitalias;
  }

  if(victim.var_965cc0b3) {
    if(is_true(fatal)) {
      hitalias = # "hash_6d7fa87ddd50800";
    } else {
      hitalias = # "hash_644a18cd873e501d";
    }
  }

  if(should_play_sound(inflictor)) {
    if(isDefined(victim.hitsound) && victim.hitsound != "") {
      hitalias = victim.hitsound;
    } else if(victim.grappleweapon) {
      hitalias = # "hash_671bc9a2de453f2e";
    } else if(victim.name == # "snowball") {
      hitalias = # "mpl_hit_alert_snow";
    } else if(victim.name == # "waterballoon") {
      hitalias = # "hash_1fd605562fb1fd3a";
    } else if(isvehicle(psoffsettime)) {
      hitalias = # "hash_2ce81d103e923201";
    } else if(isDefined(psoffsettime) && isDefined(psoffsettime.victimsoundmod)) {
      switch (psoffsettime.victimsoundmod) {
        case # "safeguard_robot":
          hitalias = # "mpl_hit_alert_escort";
          break;
        case # "vehicle":
          hitalias = # "hash_2ce81d103e923201";
          break;
        default:
          hitalias = # "mpl_hit_alert";
          break;
      }
    } else if(isDefined(perkfeedback) && isDefined(perkfeedback.soundmod)) {
      switch (perkfeedback.soundmod) {
        case # "player":
          if(isDefined(idflags) && idflags & 2048 && isDefined(psoffsettime)) {
            if(isDefined(psoffsettime.var_426947c4)) {
              if(weapons::isheadshot(victim, shitloc, inflictor)) {
                hitalias = # "hash_6b219a0cac330e0b";
              } else {
                hitalias = # "mpl_hit_alert_armor_broke";
              }
            } else {
              hitalias = # "mpl_hit_alert_armor_hit";
            }
          } else if(isDefined(psoffsettime) && is_true(psoffsettime.isaiclone)) {
            hitalias = # "mpl_hit_alert_clone";
          } else if(isDefined(psoffsettime) && is_true(psoffsettime.isaiclone)) {
            hitalias = # "mpl_hit_alert_clone";
          } else if(isDefined(psoffsettime) && is_true(psoffsettime.var_342564dd)) {
            hitalias = # "mpl_hit_alert_rad";
          } else if(isDefined(psoffsettime) && isPlayer(psoffsettime) && isDefined(psoffsettime.carryobject) && isDefined(psoffsettime.carryobject.hitsound) && isDefined(weapon) && weapon == "armor") {
            hitalias = psoffsettime.carryobject.hitsound;
          } else if(inflictor == "MOD_BURNED") {
            hitalias = # "mpl_hit_alert_burn";
          } else if(is_true(fatal)) {
            if(weapons::isheadshot(victim, shitloc, inflictor)) {
              hitalias = # "hash_616dd8ea01d089ac";
            } else {
              hitalias = # "hash_31e38d8520839566";
            }
          } else if(weapons::isheadshot(victim, shitloc, inflictor)) {
            hitalias = # "hash_29ca1afa9209bfc6";
          } else if(inflictor == "MOD_MELEE_WEAPON_BUTT") {} else if(shitloc === "riotshield") {
            hitalias = # "prj_bullet_impact_shield";
          } else {
            hitalias = # "hash_205c83ac75849f80";
          }

          break;
        case # "heatwave":
          hitalias = # "mpl_hit_alert_heatwave";
          break;
        case # "heli":
          hitalias = # "mpl_hit_alert_air";
          break;
        case # "hpm":
          hitalias = # "mpl_hit_alert_hpm";
          break;
        case # "taser_spike":
          hitalias = # "mpl_hit_alert_taser_spike";
          break;
        case # "straferun":
        case # "dog":
          break;
        case # "firefly":
          hitalias = # "mpl_hit_alert_firefly";
          break;
        case # "drone_land":
          hitalias = # "mpl_hit_alert_air";
          break;
        case # "mini_turret":
          hitalias = # "mpl_hit_alert_quiet";
          break;
        case # "raps":
          hitalias = # "mpl_hit_alert_air";
          break;
        case # "default_loud":
          hitalias = # "mpl_hit_heli_gunner";
          break;
        default:
          hitalias = # "mpl_hit_alert";
          break;
      }
    } else if(inflictor == "MOD_BURNED" || inflictor == "MOD_DOT") {
      hitalias = # "mpl_hit_alert_burn";
    } else {
      hitalias = # "hash_205c83ac75849f80";

      if(is_true(fatal)) {
        hitalias = # "hash_31e38d8520839566";
      }
    }
  } else if(inflictor === "MOD_MELEE_WEAPON_BUTT") {
    if(fatal === 1) {
      hitalias = # "hash_27781beb722b7488";
    }
  } else if(isDefined(perkfeedback) && isDefined(perkfeedback.owner) && isDefined(perkfeedback.owner.soundmod)) {
    if(perkfeedback.owner.soundmod == # "player" && isDefined(idflags) && idflags & 2048 && isDefined(psoffsettime)) {
      if(isDefined(psoffsettime.var_426947c4)) {
        hitalias = # "mpl_hit_alert_armor_broke";
      }
    }
  }

  return hitalias;
}

function hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
  hitalias = undefined;

  if(!isDefined(victim)) {
    return;
  }

  if(isDefined(victim.hitsound) && victim.hitsound != "") {
    hitalias = victim.hitsound;
    return hitalias;
  }

  if(victim.var_965cc0b3) {
    hitalias = # "hash_644a18cd873e501d";
  }

  if(should_play_sound(perkfeedback)) {
    if(isDefined(victim.hitsound) && victim.hitsound != "") {
      hitalias = victim.hitsound;
    } else if(isvehicle(psoffsettime)) {
      hitalias = # "hash_2ce81d103e923201";
    } else if(isDefined(weapon) && isDefined(weapon.soundmod)) {
      switch (weapon.soundmod) {
        case # "player":
          if(isDefined(idflags) && idflags & 2048 && isDefined(psoffsettime)) {
            if(isDefined(psoffsettime.var_426947c4)) {
              if(weapons::isheadshot(victim, shitloc, perkfeedback)) {
                hitalias = # "hash_6b219a0cac330e0b";
              } else {
                hitalias = # "mpl_hit_alert_armor_broke";
              }
            } else {
              hitalias = # "mpl_hit_alert_armor_hit";
            }
          } else if(psoffsettime.aitype === "spawner_bo5_abom") {
            if(shitloc != "head") {
              hitalias = # "hash_1b935b754d624965";
            }
          } else if(perkfeedback == "MOD_BURNED") {
            hitalias = # "mpl_hit_alert_burn";
          } else if(is_true(fatal)) {
            if(weapons::isheadshot(victim, shitloc, perkfeedback)) {
              hitalias = # "hash_616dd8ea01d089ac";
            } else {
              hitalias = # "hash_31e38d8520839566";
            }
          } else if(weapons::isheadshot(victim, shitloc, perkfeedback)) {
            hitalias = # "hash_29ca1afa9209bfc6";
          } else if(perkfeedback == "MOD_MELEE_WEAPON_BUTT") {} else if(shitloc === "riotshield") {
            hitalias = # "prj_bullet_impact_shield";
          } else {
            hitalias = # "hash_205c83ac75849f80";
          }

          break;
        default:
          hitalias = # "mpl_hit_alert";
          break;
      }
    } else if(perkfeedback == "MOD_BURNED" || perkfeedback == "MOD_DOT") {
      hitalias = # "mpl_hit_alert_burn";
    } else {
      hitalias = # "hash_205c83ac75849f80";

      if(is_true(fatal)) {
        hitalias = # "hash_31e38d8520839566";
      }
    }
  } else if(perkfeedback === "MOD_MELEE_WEAPON_BUTT") {
    if(fatal === 1) {
      hitalias = # "hash_27781beb722b7488";
    }
  } else if(isDefined(weapon) && isDefined(weapon.owner) && isDefined(weapon.owner.soundmod)) {
    if(weapon.owner.soundmod == # "player" && isDefined(idflags) && idflags & 2048 && isDefined(psoffsettime)) {
      if(isDefined(psoffsettime.var_426947c4)) {
        hitalias = # "mpl_hit_alert_armor_broke";
      }
    }
  }

  return hitalias;
}

function function_34fbafdc(weapon, mod) {
  if(isDefined(weapon) && isDefined(weapon.var_965cc0b3) && weapon.var_965cc0b3) {
    return true;
  }

  if(isDefined(weapon) && weapon === level.shockrifleweapon && mod === "MOD_DOT") {
    return true;
  }

  return false;
}

function update(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags, var_594a2d34) {
  if(!isPlayer(self)) {
    return;
  }

  if(is_true(self.nohitmarkers)) {
    return;
  }

  if(isDefined(weapon) && weapon.statname == # "recon_car" && isDefined(victim) && isDefined(victim.owner) && inflictor === victim.owner) {
    return;
  }

  if(isDefined(weapon) && is_true(weapon.nohitmarker)) {
    return;
  }

  if(!isDefined(self.lasthitmarkertime)) {
    self.lasthitmarkertimes = [];
    self.lasthitmarkertime = 0;
    self.lasthitmarkeroffsettime = 0;
    self.var_1ead243c = 0;
  }

  if(isDefined(psoffsettime) && isDefined(victim)) {
    victim_id = victim getentitynumber();

    if(!isDefined(self.lasthitmarkertimes[victim_id])) {
      self.lasthitmarkertimes[victim_id] = 0;
    }

    if(self.lasthitmarkertime == gettime()) {
      if(self.lasthitmarkertimes[victim_id] === psoffsettime && fatal !== 1 && perkfeedback === undefined) {
        return;
      }
    }

    self.lasthitmarkeroffsettime = psoffsettime;
    self.lasthitmarkertimes[victim_id] = psoffsettime;
  } else if(self.lasthitmarkertime == gettime()) {
    return;
  }

  damagestage = 1;

  if(self.lasthitmarkertime >= gettime() - 1000) {
    damagestage = self.var_1ead243c + 1;

    if(damagestage > 2) {
      damagestage = 1;
    }
  }

  self.var_1ead243c = damagestage;
  self.lasthitmarkertime = gettime();
  hitalias = play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);

  if(isDefined(victim) && is_true(victim.isaiclone) || shitloc === "riotshield") {
    self playhitmarker(hitalias);
    return;
  }

  if(isDefined(victim) && (sessionmodeiszombiesgame() || sessionmodeiscampaigngame() || isPlayer(victim))) {
    if(victim.health <= 0 || is_true(fatal)) {
      damagestage = 5;
    }
  }

  if((mod === "MOD_DOT" || mod === "MOD_DOT_SELF") && !isDefined(self.var_dbffaa32) && damagestage != 5) {
    return;
  }

  if(!isDefined(var_594a2d34)) {
    var_594a2d34 = function_34fbafdc(weapon, mod);

    if(isDefined(self.viewlockedentity) && isvehicle(self.viewlockedentity) && self.usingvehicle) {
      var_594a2d34 = 0;
    }
  }

  if(isDefined(victim) && is_true(victim.var_8ac0d510) && var_594a2d34) {
    return;
  }

  var_32f65675 = 0;

  if(isDefined(victim) && damagestage == 5 && isDefined(level.skiplaststand) && !is_true(level.skiplaststand) && !is_true(victim.laststand) && isPlayer(victim)) {
    var_32f65675 = 1;
  }

  if(isvehicle(victim) && !is_true(victim.var_22b9bee1)) {
    is_vehicle = 1;
  }

  is_dead = damagestage == 5;

  if(isDefined(victim) && victim.archetype === # "robot") {
    is_vehicle = 1;
  }

  is_vehicle = isDefined(victim.var_48d842c3) ? victim.var_48d842c3 : is_vehicle;

  if(isDefined(victim) && self != victim) {
    is_friendly = !victim util::isenemyteam(self.team);

    if(isDefined(victim.spyRole) && victim.spyRole == 2) {
      is_friendly = 0;
    }
  }

  var_57f3fd02 = isDefined(inflictor) && isPlayer(inflictor);
  self playhitmarker(hitalias, damagestage, perkfeedback, is_dead, var_594a2d34, is_vehicle, var_32f65675, is_friendly, var_57f3fd02);

  if(isDefined(perkfeedback)) {
    if(isDefined(self.hud_damagefeedback_additional)) {
      switch (perkfeedback) {
        case # "flakjacket":
          self.hud_damagefeedback_additional setshader(#"damage_feedback_flak", 24, 48);
          break;
        case # "tacticalmask":
          self.hud_damagefeedback_additional setshader(#"damage_feedback_tac", 24, 48);
          break;
        case # "armor":
          self.hud_damagefeedback_additional setshader(#"damage_feedback_armor", 24, 48);
          break;
      }

      self.hud_damagefeedback_additional.alpha = 1;
      self.hud_damagefeedback_additional fadeovertime(1);
      self.hud_damagefeedback_additional.alpha = 0;
    }
  } else if(isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback setshader(#"damage_feedback", 24, 48);
  }

  if(isDefined(self.hud_damagefeedback) && isDefined(level.growing_hitmarker) && isDefined(victim) && (sessionmodeiscampaigngame() || isPlayer(victim))) {
    self thread damage_feedback_growth(victim, mod, weapon);
    return;
  }

  if(isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback.x = -12;
    self.hud_damagefeedback.y = -12;
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }
}

function damage_feedback_get_stage(victim, fatal) {
  if(!isDefined(victim) || !isDefined(victim.maxhealth) || victim.maxhealth <= 0) {
    return 1;
  }

  var_7d71342b = victim.health / victim.maxhealth;

  if(is_true(victim.laststand)) {
    if(fatal === 1) {
      return 5;
    }

    return 1;
  }

  if(var_7d71342b > 0.74) {
    return 1;
  }

  if(var_7d71342b > 0.49) {
    return 2;
  }

  if(var_7d71342b > 0.24) {
    return 3;
  }

  if(victim.health > 0) {
    return 4;
  }

  return 5;
}

function damage_feedback_get_dead(victim, mod, weapon, stage) {
  return stage == 5 && (mod == "MOD_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || mod == "MOD_IMPACT" || mod == "MOD_HEAD_SHOT" || mod == "MOD_BURNED" || mod == "MOD_DOT" || mod == "MOD_MELEE_WEAPON_BUTT") && !weapon.isheavyweapon && !killstreaks::is_killstreak_weapon(weapon);
}

function damage_feedback_growth(victim, mod, weapon) {
  if(isDefined(self.hud_damagefeedback)) {
    stage = damage_feedback_get_stage(victim);
    self.hud_damagefeedback.x = -11 + -1 * stage;
    self.hud_damagefeedback.y = -11 + -1 * stage;
    size_x = 22 + 2 * stage;
    size_y = size_x * 2;
    self.hud_damagefeedback setshader(#"damage_feedback", size_x, size_y);

    if(damage_feedback_get_dead(victim, mod, weapon, stage)) {
      self.hud_damagefeedback setshader(#"damage_feedback_glow_orange", size_x, size_y);
      self thread kill_hitmarker_fade();
      return;
    }

    self.hud_damagefeedback setshader(#"damage_feedback", size_x, size_y);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }
}

function kill_hitmarker_fade() {
  if(!isDefined(self.hud_damagefeedback)) {
    return;
  }

  self notify(#"kill_hitmarker_fade");
  self endon(#"kill_hitmarker_fade", #"disconnect");
  self.hud_damagefeedback.alpha = 1;
  wait 0.25;
  self.hud_damagefeedback fadeovertime(0.3);
  self.hud_damagefeedback.alpha = 0;
}

function update_override(icon, sound, additional_icon) {
  if(!isPlayer(self)) {
    return;
  }

  self playlocalsound(sound);

  if(isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback setshader(icon, 24, 48);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }

  if(isDefined(self.hud_damagefeedback_additional)) {
    if(!isDefined(additional_icon)) {
      self.hud_damagefeedback_additional.alpha = 0;
      return;
    }

    self.hud_damagefeedback_additional setshader(additional_icon, 24, 48);
    self.hud_damagefeedback_additional.alpha = 1;
    self.hud_damagefeedback_additional fadeovertime(1);
    self.hud_damagefeedback_additional.alpha = 0;
  }
}

function dodamagefeedback(weapon, einflictor, idamage, smeansofdeath) {
  if(!isDefined(einflictor)) {
    return false;
  }

  if(is_true(einflictor.nohitmarker)) {
    return false;
  }

  if(level.allowhitmarkers == 0) {
    return false;
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_MELEE_ASSASSINATE") {
    return false;
  }

  if(level.allowhitmarkers == 1) {
    if(isDefined(smeansofdeath) && isDefined(idamage)) {
      if(istacticalhitmarker(einflictor, smeansofdeath, idamage)) {
        return false;
      }
    }
  }

  return true;
}

function istacticalhitmarker(weapon, smeansofdeath, idamage) {
  if(weapons::is_grenade(weapon)) {
    if("Smoke Grenade" == weapon.offhandclass) {
      if(smeansofdeath == "MOD_GRENADE_SPLASH") {
        return true;
      }
    } else if(idamage == 1) {
      return true;
    }
  }

  return false;
}