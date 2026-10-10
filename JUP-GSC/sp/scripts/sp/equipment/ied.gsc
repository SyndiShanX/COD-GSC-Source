/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\ied.gsc
***********************************************/

#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\friendlyfire;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace ied;

function precache(offhand) {
  precachemodel("offhand_vm_cellphone_old");
  level.g_effect["IED_explode"] = loadfx("vfx/iw8/level/highway/ied_explosion");
  registeroffhandfirefunc(offhand, &iedfiremain);
}

function iedfiremain(ied, weapon) {
  if(!isDefined(ied)) {
    return;
  }

  ied.targetname = "offhand_ied";

  if(ied.classname != "script_model") {
    ied waittill("missile_stuck", stuckto);
  }

  ied thread ieddetonationlogic(self, 25, 35);
}

function ieddetonationlogic(attacker, var_a5d2db5617eb9a05, var_ccea305d816855aa) {
  self endon("detonated");
  self makeunusable();
  self.interact = iedcreatecursor(var_a5d2db5617eb9a05, var_ccea305d816855aa);
  self.interact waittill("trigger");
  origin = self.origin;
  self.interact delete();
  level.player notify("triggeredIED", origin);

  if(iedcanplaydetonategesture()) {
    ieddetonategesture();
  }

  thread ieddetonate(origin, attacker);
}

function iedcanplaydetonategesture() {
  if(level.player playerads() == 1) {
    return false;
  }

  if(level.player isreloading()) {
    return false;
  }

  return true;
}

function ieddetonate(origin, attacker) {
  level notify("level_iedDetonated");
  self notify("detonated");
  self delete();
  attacker notify("detonatedIED", origin);
  iedplaydetonateeffects(origin);

  if(distancesquared(level.player.origin, origin) <= 10000) {
    level.player shellshock("default_nosound", 3);
    level.player do_damage(300, origin);
  }

  var_fa48e1a11dfa38ed = 100;
  var_99294d212b573d4a = var_fa48e1a11dfa38ed * var_fa48e1a11dfa38ed;
  aiarray = getaiarray();

  foreach(ai in aiarray) {
    distancesq = distancesquared(origin, ai.origin);

    if(distancesq > 360000) {
      continue;
    }

    if(distancesq > 160000) {
      ai notify("flashbang", (0, 0, 0), 1, 1, attacker, "allies");
      continue;
    }

    if(istrue(ai.magic_bullet_shield)) {
      var_fa1a63cd9f6ecca2 = isPlayer(attacker) && is_equal(attacker.team, ai.team) && distancesq <= var_99294d212b573d4a;

      if(var_fa1a63cd9f6ecca2) {
        ai scripts\common\ai::stop_magic_bullet_shield();

        if(isDefined(level.aigibfunction)) {
          attacker[[level.aigibfunction]](ai, ai getEye(), "MOD_RIFLE_BULLET");
        }

        scripts\sp\friendlyfire::missionfail(0);
        return;
      } else {
        ai notify("flashbang", (0, 0, 0), 1, 1, attacker, "allies");
        continue;
      }
    }

    if(isDefined(level.aigibfunction) && randomint(100) < 100) {
      attacker[[level.aigibfunction]](ai, ai getEye(), "MOD_RIFLE_BULLET");
      continue;
    }

    playFX(level.g_effect["vfx_gib_explode"], ai.origin);
    ai do_damage(ai.health + 9999, ai.origin, attacker, undefined, "MOD_EXPLOSIVE", "iw8_sh_oscar12");
  }

  distancetoplayer = distance(level.player.origin, origin);
  sounddelay = distancetoplayer / 13397;
  wait sounddelay;
  distancefactor = math::normalize_value(0, 15000, distancetoplayer);
  intensity = math::factor_value(0.05, 0.32, distancefactor);
  earthquake(intensity, 1.2, origin, 15000);
  playrumbleonposition("damage_heavy", origin);
}

function iedplaydetonateeffects(origin) {
  if(soundexists("ied_activated")) {
    level.player playSound("ied_activated");
  }

  playFX(level.g_effect["IED_explode"], origin);
  physicsexplosionsphere(origin, 400, 200, 150);

  if(soundexists("ied_expl_trans")) {
    thread play_sound_in_space("ied_expl_trans", origin);
  }
}

function ieddetonategesture() {
  var_d7ce16ba0556f168 = spawn("script_model", level.player.origin);
  var_d7ce16ba0556f168 setModel("offhand_vm_cellphone_old");
  var_d7ce16ba0556f168 notsolid();
  var_d7ce16ba0556f168 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  gesturelength = level.player getgestureanimlength("ges_hod_phone_detonate");
  var_d7ce16ba0556f168 delaycall(gesturelength, &delete);
  level.player player_gesture_force("ges_hod_phone_detonate");
  wait 0.5;
}

function iedcreatecursor(var_a5d2db5617eb9a05, var_ccea305d816855aa) {
  interact = spawn_tag_origin();
  interact.origin += (0, 0, 10);
  interact linkTo(self);
  interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"WEAPON/LABEL_DETONATE", var_ccea305d816855aa, 50000, 50000, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, var_a5d2db5617eb9a05);
  return interact;
}

function iedcursorlogic(interact) {
  self endon("death");
  interact endon("death");
  interact.cursor_hint_ent endon("death");
  self endon("detonated");

  while(true) {
    if(distancesquared(level.player.origin, self.origin) <= 5625) {
      interact.cursor_hint_ent setHintString("^2Pickup");
    } else {
      interact.cursor_hint_ent setHintString("^1Detonate");
    }

    waitframe();
  }
}