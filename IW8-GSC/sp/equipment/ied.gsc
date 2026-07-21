/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\ied.gsc
***********************************************/

precache(var_0) {
  precachemodel("offhand_vm_cellphone_old");
  level.g_effect["IED_explode"] = loadfx("vfx/iw8/level/highway/ied_explosion");
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::iedfiremain);
}

iedfiremain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0.targetname = "offhand_ied";

  if(var_0.classname != "script_model")
    var_0 waittill("missile_stuck", var_1);

  var_0 thread ieddetonationlogic(self, 25, 35);
}

ieddetonationlogic(var_0, var_1, var_2) {
  self endon("detonated");
  self makeunusable();
  self.interact = iedcreatecursor(var_1, var_2);
  self.interact waittill("trigger");
  var_3 = self.origin;
  self.interact delete();
  level.player notify("triggeredIED", var_3);

  if(iedcanplaydetonategesture())
    ieddetonategesture();

  thread ieddetonate(var_3, var_0);
}

iedcanplaydetonategesture() {
  if(level.player playerads() == 1)
    return 0;

  if(level.player isreloading())
    return 0;

  return 1;
}

ieddetonate(var_0, var_1) {
  level notify("level_iedDetonated");
  self notify("detonated");
  self delete();
  var_1 notify("detonatedIED", var_0);
  iedplaydetonateeffects(var_0);

  if(distancesquared(level.player.origin, var_0) <= 10000) {
    level.player shellshock("default_nosound", 3.0);
    level.player scripts\sp\utility::do_damage(300, var_0);
  }

  var_2 = 100;
  var_3 = var_2 * var_2;
  var_4 = getaiarray();

  foreach(var_6 in var_4) {
    var_7 = distancesquared(var_0, var_6.origin);

    if(var_7 > 360000) {
      continue;
    }
    if(var_7 > 160000) {
      var_6 notify("flashbang", (0, 0, 0), 1, 1, var_1, "allies");
      continue;
    }

    if(istrue(var_6.magic_bullet_shield)) {
      var_8 = isPlayer(var_1) && scripts\engine\utility::is_equal(var_1.team, var_6.team) && var_7 <= var_3;

      if(var_8) {
        var_6 scripts\common\ai::stop_magic_bullet_shield();

        if(isDefined(level.aigibfunction))
          var_1[[level.aigibfunction]](var_6, var_6 getEye(), "MOD_RIFLE_BULLET");

        scripts\sp\friendlyfire::missionfail(0);
        return;
      } else {
        var_6 notify("flashbang", (0, 0, 0), 1, 1, var_1, "allies");
        continue;
      }
    }

    if(isDefined(level.aigibfunction) && randomint(100) < 100) {
      var_1[[level.aigibfunction]](var_6, var_6 getEye(), "MOD_RIFLE_BULLET");
      continue;
    }

    playFX(level.g_effect["vfx_gib_explode"], var_6.origin);
    var_6 scripts\sp\utility::do_damage(var_6.health + 9999, var_6.origin, var_1, undefined, "MOD_EXPLOSIVE", "iw8_sh_oscar12");
  }

  var_10 = distance(level.player.origin, var_0);
  var_11 = var_10 / 13397;
  wait(var_11);
  var_12 = scripts\engine\math::normalize_value(0, 15000, var_10);
  var_13 = scripts\engine\math::factor_value(0.05, 0.32, var_12);
  earthquake(var_13, 1.2, var_0, 15000);
  playrumbleonposition("damage_heavy", var_0);
}

iedplaydetonateeffects(var_0) {
  if(soundexists("weap_ied_activated"))
    level.player playSound("weap_ied_activated");

  playFX(level.g_effect["IED_explode"], var_0);
  physicsexplosionsphere(var_0, 400, 200.0, 150);

  if(soundexists("weap_ied_expl_trans"))
    thread scripts\engine\utility::play_sound_in_space("weap_ied_expl_trans", var_0);
}

ieddetonategesture() {
  var_0 = spawn("script_model", level.player.origin);
  var_0 setModel("offhand_vm_cellphone_old");
  var_0 notsolid();
  var_0 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  var_1 = level.player getgestureanimlength("ges_hod_phone_detonate");
  var_0 scripts\engine\utility::delaycall(var_1, ::delete);
  level.player scripts\engine\sp\utility::player_gesture_force("ges_hod_phone_detonate");
  wait 0.5;
}

iedcreatecursor(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_2.origin + (0, 0, 10);
  var_2 linkTo(self);
  var_2 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"WEAPON/LABEL_DETONATE", var_1, 50000, 50000, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, var_0);
  return var_2;
}

iedcursorlogic(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0.cursor_hint_ent endon("death");
  self endon("detonated");

  for(;;) {
    if(distancesquared(level.player.origin, self.origin) <= 5625)
      var_0.cursor_hint_ent setHintString("^2Pickup");
    else
      var_0.cursor_hint_ent setHintString("^1Detonate");

    waitframe();
  }
}