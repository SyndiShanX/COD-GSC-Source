/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\ied.gsc
***********************************************/

function precache(var0) {
  precachemodel("offhand_vm_cellphone_old");
  level.g_effect["IED_explode"] = loadfx("vfx/iw8/level/highway/ied_explosion");
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &iedfiremain);
}

function iedfiremain(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var0.targetname = "offhand_ied";

  if(var0.classname != "script_model") {
    var0 waittill("missile_stuck", var1);
  }

  thread ieddetonationlogic(var0, self, 25);
}

function ieddetonationlogic(var0, var1, var2) {
  self endon("detonated");
  self makeunusable();
  self.interact = iedcreatecursor(var1, var2);
  self.interact waittill("trigger");
  var3 = self.origin;
  self.interact delete();
  level.player notify("triggeredIED", var3);

  if(iedcanplaydetonategesture()) {
    ieddetonategesture();
  }

  thread ieddetonate(var3, var0);
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

function ieddetonate(var0, var1) {
  level notify("level_iedDetonated");
  self notify("detonated");
  self delete();
  var1 notify("detonatedIED", var0);
  iedplaydetonateeffects(var0);

  if(distancesquared(level.player.origin, var0) <= 10000) {
    level.player shellshock("default_nosound", 3);
    level.player scripts\sp\utility::do_damage(300, var0);
  }

  var2 = 100;
  var3 = var2 * var2;
  var4 = getaiarray();

  foreach(var6 in var4) {
    var7 = distancesquared(var0, var6.origin);

    if(var7 > 360000) {
      continue;
    }

    if(var7 > 160000) {
      var6 notify("flashbang", (0, 0, 0), 1, 1, var1, "allies");
      continue;
    }

    if(istrue(var6.magic_bullet_shield)) {
      var8 = isPlayer(var1) && scripts\engine\utility::is_equal(var1.team, var6.team) && var7 <= var3;

      if(var8) {
        var6 scripts\common\ai::stop_magic_bullet_shield();

        if(isDefined(level.aigibfunction)) {
          var1[[level.aigibfunction]](var6, var6 getEye(), "MOD_RIFLE_BULLET");
        }

        scripts\sp\friendlyfire::missionfail(0);
        return;
      } else {
        var6 notify("flashbang", (0, 0, 0), 1, 1, var1, "allies");
        continue;
      }
    }

    if(isDefined(level.aigibfunction) && randomint(100) < 100) {
      var1[[level.aigibfunction]](var6, var6 getEye(), "MOD_RIFLE_BULLET");
      continue;
    }

    playFX(level.g_effect["vfx_gib_explode"], var6.origin);
    var6 scripts\sp\utility::do_damage(var6.health + 9999, var6.origin, var1, undefined, "MOD_EXPLOSIVE", "iw8_sh_oscar12");
  }

  var10 = distance(level.player.origin, var0);
  var11 = var10 / 13397;
  wait var11;
  var12 = scripts\engine\math::normalize_value(0, 15000, var10);
  var13 = scripts\engine\math::factor_value(0.05, 0.32, var12);
  earthquake(var13, 1.2, var0, 15000);
  playrumbleonposition("damage_heavy", var0);
}

function iedplaydetonateeffects(var0) {
  if(soundexists("weap_ied_activated")) {
    level.player playSound("weap_ied_activated");
  }

  playFX(level.g_effect["IED_explode"], var0);
  physicsexplosionsphere(var0, 400, 200, 150);

  if(soundexists("weap_ied_expl_trans")) {
    thread scripts\engine\utility::play_sound_in_space("weap_ied_expl_trans", var0);
    return;
  }
}

function ieddetonategesture() {
  var0 = spawn("script_model", level.player.origin);
  var0 setModel("offhand_vm_cellphone_old");
  var0 notsolid();
  var0 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  var1 = level.player getgestureanimlength("ges_hod_phone_detonate");
  var0 scripts\engine\utility::delaycall(var1, &delete);
  level.player scripts\engine\sp\utility::player_gesture_force("ges_hod_phone_detonate");
  wait 0.5;
}

function iedcreatecursor(var0, var1) {
  var2 = scripts\engine\utility::spawn_tag_origin();
  var2.origin += (0, 0, 10);
  var2 linkTo(self);
  var2 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"WEAPON/LABEL_DETONATE", var1, 50000, 50000, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, var0);
  return var2;
}

function iedcursorlogic(var0) {
  self endon("death");
  var0 endon("death");
  var0.cursor_hint_ent endon("death");
  self endon("detonated");

  for(;;) {
    if(distancesquared(level.player.origin, self.origin) <= 5625) {
      var0.cursor_hint_ent setHintString("^2Pickup");
    } else {
      var0.cursor_hint_ent setHintString("^1Detonate");
    }

    waitframe();
  }
}