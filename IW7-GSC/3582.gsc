/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3582.gsc
*********************************************/

setrewind() {
  thread func_13A62();
}

unsetrewind(var_0) {
  self notify("rewindUnset");
  if(!scripts\mp\utility::istrue(var_0) && !scripts\mp\utility::istrue(level.broshotrunning)) {
    self setscriptablepartstate("jet_pack", "neutral", 0);
    self setscriptablepartstate("teamColorPins", "teamColorPins", 0);
  }

  if(self.loadoutarchetype == "archetype_scout") {
    self setscriptablepartstate("rewindIdle", "neutral", 0);
  }

  thread func_E163();
}

func_10DEB() {
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_rewind", undefined, 0.75);
  if(self.health < self.maxhealth) {
    scripts\mp\missions::func_D991("ch_scout_damaged_rewind");
  }

  self.isrewinding = 1;
  self getweaponrankxpmultiplier();
  self setscriptablepartstate("jet_pack", "off", 0);
  self setscriptablepartstate("teamColorPins", "off", 0);
  self setscriptablepartstate("rewindStartFlash", "active", 0);
  self setscriptablepartstate("rewindIdle", "active", 0);
  self motionblurhqenable();
  applytempeffects();
}

func_637E(var_0) {
  func_E4D5();
  func_E4C7();
  self setscriptablepartstate("rewindIdle", "neutral", 0);
  if(!scripts\mp\utility::istrue(level.broshotrunning)) {
    self playershow();
    if(!scripts\mp\utility::istrue(var_0)) {
      self setscriptablepartstate("jet_pack", "neutral", 0);
      self setscriptablepartstate("teamColorPins", "teamColorPins", 0);
      self setscriptablepartstate("rewindEndFlash", "active", 0);
    }
  }

  thread func_E163();
}

func_E163() {
  self.isrewinding = undefined;
  self motionblurhqdisable();
  removetempeffects();
}

func_13A62() {
  self endon("disconnect");
  self endon("rewindUnset");
  self notify("watchForRewind");
  self endon("watchForRewind");
  for(;;) {
    var_0 = spawnStruct();
    childthread func_13A66(var_0);
    childthread func_13A64(var_0);
    childthread func_13A63(var_0);
    childthread func_13A65(var_0);
    self waittill("rewindBeginRace");
    waittillframeend;
    if(isDefined(var_0.var_6ACF)) {
      if(isplayer(self)) {
        scripts\mp\hud_message::showerrormessage("MP_REWIND_FAILED");
      }

      scripts\mp\supers::refundsuper();
    } else if(isDefined(var_0.var_10DE6) && isDefined(var_0.var_4E59)) {
      scripts\mp\supers::refundsuper();
    } else if(isDefined(var_0.var_637B)) {
      self notify("rewind_success");
      func_637E();
    } else if(isDefined(var_0.var_10DE6)) {
      self notify("rewind_success");
      func_10DEB();
    }

    self notify("rewindEndRace");
  }
}

func_13A66(var_0) {
  self endon("rewindEndRace");
  self waittill("rewindStart");
  var_0.var_10DE6 = 1;
  self notify("rewindBeginRace");
}

func_13A64(var_0) {
  self endon("rewindEndRace");
  self waittill("rewindEnd");
  var_0.var_637B = 1;
  self notify("rewindBeginRace");
}

func_13A63(var_0) {
  self endon("rewindEndRace");
  self waittill("death");
  var_0.var_4E59 = 1;
  self notify("rewindBeginRace");
}

func_13A65(var_0) {
  self endon("rewindEndRace");
  self waittill("rewindFailed");
  var_0.var_6ACF = 1;
  self notify("rewindBeginRace");
}

func_E4D5() {
  if(scripts\mp\utility::isanymlgmatch()) {
    self.health = int(min(self.maxhealth, self.health + 25));
    return;
  }

  var_0 = self.maxhealth - self.health;
  self.health = self.maxhealth;
}

func_E4C7() {
  var_0 = self getweaponslistprimaries();
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = scripts\mp\utility::getweapongroup(var_3);
    if(var_4 == "super" || var_4 == "weapon_mg" || var_4 == "killstreak" || var_4 == "gamemode" || var_4 == "other") {
      var_1[var_1.size] = var_3;
      continue;
    }

    if(scripts\mp\weapons::isaxeweapon(var_3) || scripts\mp\weapons::isknifeonly(var_3)) {
      var_1[var_1.size] = var_3;
      continue;
    }

    if(getsubstr(var_3, 0, 7) == "deploy_") {
      var_1[var_1.size] = var_3;
      continue;
    }

    if(scripts\mp\weapons::isaltmodeweapon(var_3)) {
      var_5 = 0;
      var_6 = scripts\mp\utility::getweaponattachmentsbasenames(var_3);
      foreach(var_8 in var_6) {
        if(getsubstr(var_8, 0, 2) == "gl") {
          var_5 = 1;
          break;
        }
      }

      if(var_5) {
        continue;
      }

      if(self isalternatemode(var_3, 1)) {
        var_3 = getsubstr(var_3, 4, var_3.size);
      }

      var_1[var_1.size] = var_3;
      continue;
    }
  }

  var_1 = scripts\engine\utility::array_remove_duplicates(var_1);
  foreach(var_3 in var_1) {
    var_0 = scripts\engine\utility::array_remove(var_0, var_3);
  }

  foreach(var_3 in var_0) {
    var_14 = 0;
    if(scripts\mp\utility::getweaponrootname(var_3) == "iw7_fmg") {
      var_14 = self isalternatemode(var_3, 1);
    } else if(issubstr(var_3, "akimbo")) {
      var_14 = 1;
    }

    if(var_14) {
      var_15 = self getweaponammoclip(var_3, "left") + self getweaponammoclip(var_3, "right") + self getweaponammostock(var_3);
      var_15 = int(max(var_15, weaponstartammo(var_3)));
      var_10 = weaponclipsize(var_3);
      var_11 = int(max(0, var_15 - var_10 * 2));
      self setweaponammoclip(var_3, var_10, "left");
      self setweaponammoclip(var_3, var_10, "right");
      self setweaponammostock(var_3, var_11);
      continue;
    }

    var_15 = self getweaponammoclip(var_3) + self getweaponammostock(var_3);
    var_15 = int(max(var_15, weaponstartammo(var_3)));
    var_10 = weaponclipsize(var_3);
    var_11 = int(max(0, var_15 - var_10));
    self setweaponammoclip(var_3, var_10);
    self setweaponammostock(var_3, var_11);
  }
}

applytempeffects() {
  if(scripts\mp\utility::istrue(self.rewind_appliedtempeffects)) {
    return;
  }

  self.rewind_appliedtempeffects = 1;
  var_0 = self getcurrentweapon();
  if(var_0 == "briefcase_bomb_mp") {
    self takeweapon(var_0);
  }

  scripts\engine\utility::allow_weapon_switch(0);
  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_ads(0);
  scripts\mp\utility::giveperk("specialty_blindeye");
  scripts\mp\utility::giveperk("specialty_spygame");
  scripts\mp\utility::giveperk("specialty_coldblooded");
  scripts\mp\utility::giveperk("specialty_noscopeoutline");
  scripts\mp\utility::giveperk("specialty_no_target");
  thread applytempeffectscleanup();
}

removetempeffects() {
  if(!scripts\mp\utility::istrue(self.rewind_appliedtempeffects)) {
    return;
  }

  self.rewind_appliedtempeffects = undefined;
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\engine\utility::allow_usability(1);
  scripts\engine\utility::allow_ads(1);
  scripts\mp\utility::removeperk("specialty_blindeye");
  scripts\mp\utility::removeperk("specialty_spygame");
  scripts\mp\utility::removeperk("specialty_coldblooded");
  scripts\mp\utility::removeperk("specialty_noscopeoutline");
  scripts\mp\utility::removeperk("specialty_no_target");
}

applytempeffectscleanup() {
  self endon("disconnect");
  self endon("rewindUnset");
  self notify("applyTempEffectsCleanup");
  self endon("applyTempEffectsCleanup");
  self waittill("death");
  self.rewind_appliedtempeffects = undefined;
}