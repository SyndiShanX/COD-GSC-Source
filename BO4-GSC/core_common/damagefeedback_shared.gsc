/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\damagefeedback_shared.gsc
*************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\killstreaks_util;

#namespace damagefeedback;

autoexec __init__system__() {
  system::register(#"damagefeedback", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
}

on_player_connect() {}

should_play_sound(mod) {
  if(!isDefined(mod)) {
    return false;
  }

  switch (mod) {
    case #"mod_melee_weapon_butt":
    case #"mod_crush":
    case #"mod_hit_by_object":
    case #"mod_grenade_splash":
    case #"mod_melee_assassinate":
    case #"mod_melee":
      return false;
  }

  return true;
}

play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
  if(sessionmodeiscampaigngame()) {
    hitalias = hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
  }

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    hitalias = hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);
  }

  if(sessionmodeiszombiesgame()) {
    hitalias = hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc);
  }

  return hitalias;
}

hit_alert_sfx_cp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
  hitalias = undefined;
  suffix = "";

  if(should_play_sound(mod)) {
    if(isDefined(level.growing_hitmarker) && isDefined(victim)) {
      damagestage = damage_feedback_get_stage(victim);
    }

    if(damage_feedback_get_dead(victim, mod, weapon, damagestage)) {
      suffix = "_kill";
    }

    if(isDefined(victim.archetype) && victim.archetype == #"robot") {
      hitalias = #"chr_hitmarker_robot";
    } else if(isDefined(victim.archetype) && (victim.archetype == #"human" || victim.archetype == #"human_riotshield" || victim.archetype == #"human_rpg" || victim.archetype == #"civilian")) {
      hitalias = #"chr_hitmarker_human";
    } else if(isbot(victim)) {
      hitalias = #"chr_hitmarker_human";
    } else if(isplayer(victim)) {
      hitalias = #"chr_hitmarker_human";
    }

    if(isDefined(hitalias)) {
      hitalias += suffix;
    }
  }

  return hitalias;
}

hit_alert_sfx_mp(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags) {
  hitalias = undefined;

  if(!isDefined(weapon)) {
    return;
  }

  if(should_play_sound(mod)) {
    if(isDefined(weapon.hitsound) && weapon.hitsound != "") {
      hitalias = weapon.hitsound;
    } else if(weapon.grappleweapon) {
      hitalias = #"hash_671bc9a2de453f2e";
    } else if(weapon.name == #"snowball") {
      hitalias = #"mpl_hit_alert_snow";
    } else if(weapon.name == #"waterballoon") {
      hitalias = #"hash_1fd605562fb1fd3a";
    } else if(isvehicle(victim)) {
      hitalias = #"hash_2ce81d103e923201";
    } else if(isDefined(victim) && isDefined(victim.victimsoundmod)) {
      switch (victim.victimsoundmod) {
        case #"safeguard_robot":
          hitalias = #"mpl_hit_alert_escort";
          break;
        case #"vehicle":
          hitalias = #"hash_2ce81d103e923201";
          break;
        default:
          hitalias = #"mpl_hit_alert";
          break;
      }
    } else if(isDefined(inflictor) && isDefined(inflictor.soundmod)) {
      switch (inflictor.soundmod) {
        case #"player":
          if(isDefined(idflags) && idflags&2048 && isDefined(victim)) {
            if(isDefined(victim.var_426947c4)) {
              hitalias = #"mpl_hit_alert_armor_broke";
            } else if(sessionmodeiswarzonegame()) {
              hitalias = #"mpl_hit_alert_armor_hit";
            } else {
              hitalias = #"mpl_hit_alert";
            }
          } else if(isDefined(victim) && isDefined(victim.isaiclone) && victim.isaiclone) {
            hitalias = #"mpl_hit_alert_clone";
          } else if(isDefined(victim) && isDefined(victim.isaiclone) && victim.isaiclone) {
            hitalias = #"mpl_hit_alert_clone";
          } else if(isDefined(victim) && isDefined(victim.var_342564dd) && victim.var_342564dd) {
            hitalias = #"mpl_hit_alert_rad";
          } else if(isDefined(victim) && isplayer(victim) && isDefined(victim.carryobject) && isDefined(victim.carryobject.hitsound) && isDefined(perkfeedback) && perkfeedback == "armor") {
            hitalias = victim.carryobject.hitsound;
          } else if(mod == "MOD_BURNED") {
            hitalias = #"mpl_hit_alert_burn";
          } else if(isDefined(fatal) && fatal) {
            if(weapons::isheadshot(shitloc, mod)) {
              hitalias = #"hash_616dd8ea01d089ac";
            } else {
              hitalias = #"hash_31e38d8520839566";
            }
          } else if(weapons::isheadshot(shitloc, mod)) {
            hitalias = #"hash_29ca1afa9209bfc6";
          } else if(mod == "MOD_MELEE_WEAPON_BUTT") {} else if(shitloc === "riotshield") {
            hitalias = #"prj_bullet_impact_shield";
          } else {
            hitalias = #"hash_205c83ac75849f80";
          }

          break;
        case #"heatwave":
          hitalias = #"mpl_hit_alert_heatwave";
          break;
        case #"heli":
          hitalias = #"mpl_hit_alert_air";
          break;
        case #"hpm":
          hitalias = #"mpl_hit_alert_hpm";
          break;
        case #"taser_spike":
          hitalias = #"mpl_hit_alert_taser_spike";
          break;
        case #"straferun":
        case #"dog":
          break;
        case #"firefly":
          hitalias = #"mpl_hit_alert_firefly";
          break;
        case #"drone_land":
          hitalias = #"mpl_hit_alert_air";
          break;
        case #"mini_turret":
          hitalias = #"mpl_hit_alert_quiet";
          break;
        case #"raps":
          hitalias = #"mpl_hit_alert_air";
          break;
        case #"default_loud":
          hitalias = #"mpl_hit_heli_gunner";
          break;
        default:
          hitalias = #"mpl_hit_alert";
          break;
      }
    } else if(mod == "MOD_BURNED" || mod == "MOD_DOT") {
      hitalias = #"mpl_hit_alert_burn";
    } else {
      hitalias = #"mpl_hit_alert";
    }
  } else if(mod === "MOD_MELEE_WEAPON_BUTT") {
    if(fatal === 1) {
      hitalias = #"hash_27781beb722b7488";
    }
  } else if(isDefined(inflictor) && isDefined(inflictor.owner) && isDefined(inflictor.owner.soundmod)) {
    if(inflictor.owner.soundmod == #"player" && isDefined(idflags) && idflags&2048 && isDefined(victim)) {
      if(isDefined(victim.var_426947c4)) {
        hitalias = #"mpl_hit_alert_armor_broke";
      }
    }
  }

  if(isDefined(weapon.hitsound) && weapon.hitsound != "") {
    hitalias = weapon.hitsound;
  }

  return hitalias;
}

hit_alert_sfx_zm(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
  hitalias = undefined;
  return hitalias;
}

function_34fbafdc(weapon, mod) {
  if(isDefined(weapon) && isDefined(weapon.var_965cc0b3) && weapon.var_965cc0b3) {
    return true;
  }

  if(isDefined(weapon) && weapon === level.shockrifleweapon && mod === "MOD_DOT") {
    return true;
  }

  return false;
}

update(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags, var_594a2d34) {
  if(!isplayer(self)) {
    return;
  }

  if(isDefined(self.nohitmarkers) && self.nohitmarkers) {
    return 0;
  }

  if(isDefined(weapon) && weapon.statname == #"recon_car" && isDefined(victim) && isDefined(victim.owner) && inflictor === victim.owner) {
    return;
  }

  if(isDefined(weapon) && isDefined(weapon.nohitmarker) && weapon.nohitmarker) {
    return;
  }

  if(!isDefined(self.lasthitmarkertime)) {
    self.lasthitmarkertimes = [];
    self.lasthitmarkertime = 0;
    self.lasthitmarkeroffsettime = 0;
  }

  if(isDefined(psoffsettime) && isDefined(victim)) {
    victim_id = victim getentitynumber();

    if(!isDefined(self.lasthitmarkertimes[victim_id])) {
      self.lasthitmarkertimes[victim_id] = 0;
    }

    if(self.lasthitmarkertime == gettime()) {
      if(self.lasthitmarkertimes[victim_id] === psoffsettime && fatal !== 1) {
        return;
      }
    }

    self.lasthitmarkeroffsettime = psoffsettime;
    self.lasthitmarkertimes[victim_id] = psoffsettime;
  } else if(self.lasthitmarkertime == gettime()) {
    return;
  }

  self.lasthitmarkertime = gettime();
  hitalias = play_hit_alert_sfx(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc, fatal, idflags);

  if(isDefined(victim) && isDefined(victim.isaiclone) && victim.isaiclone || shitloc === "riotshield") {
    self playhitmarker(hitalias);
    return;
  }

  damagestage = 1;

  if(isDefined(level.growing_hitmarker) && isDefined(victim) && (sessionmodeiscampaigngame() || isplayer(victim))) {
    damagestage = damage_feedback_get_stage(victim, fatal);
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

  if(isDefined(victim) && isDefined(victim.var_8ac0d510) && victim.var_8ac0d510 && var_594a2d34) {
    return;
  }

  var_32f65675 = 0;

  if(isDefined(victim) && damagestage == 5 && isDefined(level.var_b1ad0b64) && !(isDefined(level.skiplaststand) && level.skiplaststand) && !(isDefined(victim.laststand) && victim.laststand) && isplayer(victim)) {
    var_32f65675 = 1;
  }

  if(isvehicle(victim) && !(isDefined(victim.var_22b9bee1) && victim.var_22b9bee1)) {
    is_vehicle = 1;
  }

  is_dead = damagestage == 5;

  if(isDefined(victim) && victim.archetype === #"robot") {
    is_vehicle = 1;
  }

  if(isDefined(inflictor) && isDefined(victim)) {
    is_friendly = !victim util::isenemyteam(inflictor.team);
  }

  self playhitmarker(hitalias, damagestage, perkfeedback, is_dead, var_594a2d34, is_vehicle, var_32f65675, is_friendly);

  if(isDefined(inflictor) && isplayer(inflictor)) {
    inflictor playrumbleonentity("hitmarker_rumble");
  }

  if(isDefined(perkfeedback)) {
    if(isDefined(self.hud_damagefeedback_additional)) {
      switch (perkfeedback) {
        case #"flakjacket":
          self.hud_damagefeedback_additional setshader(#"damage_feedback_flak", 24, 48);
          break;
        case #"tacticalmask":
          self.hud_damagefeedback_additional setshader(#"damage_feedback_tac", 24, 48);
          break;
        case #"armor":
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

  if(isDefined(self.hud_damagefeedback) && isDefined(level.growing_hitmarker) && isDefined(victim) && (sessionmodeiscampaigngame() || isplayer(victim))) {
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

damage_feedback_get_stage(victim, fatal) {
  if(!isDefined(victim) || !isDefined(victim.maxhealth) || victim.maxhealth <= 0) {
    return 1;
  }

  var_7d71342b = victim.health / victim.maxhealth;

  if(isDefined(victim.laststand) && victim.laststand) {
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

damage_feedback_get_dead(victim, mod, weapon, stage) {
  return stage == 5 && (mod == "MOD_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || mod == "MOD_HEAD_SHOT" || mod == "MOD_BURNED" || mod == "MOD_DOT" || mod == "MOD_MELEE_WEAPON_BUTT") && !weapon.isheavyweapon && !killstreaks::is_killstreak_weapon(weapon);
}

damage_feedback_growth(victim, mod, weapon) {
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

kill_hitmarker_fade() {
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

update_override(icon, sound, additional_icon) {
  if(!isplayer(self)) {
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

dodamagefeedback(weapon, einflictor, idamage, smeansofdeath) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(isDefined(weapon.nohitmarker) && weapon.nohitmarker) {
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
      if(istacticalhitmarker(weapon, smeansofdeath, idamage)) {
        return false;
      }
    }
  }

  return true;
}

istacticalhitmarker(weapon, smeansofdeath, idamage) {
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