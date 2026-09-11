/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\gestures.gsc
***********************************************/

function enter_demeanor_normal() {
  thread set_demeanor_code_think("normal");
  thread demeanor_exit_func_wait(&exit_demeanor_normal);
}

function exit_demeanor_normal() {}

function enter_demeanor_relaxed() {
  thread set_demeanor_code_think("relaxed", "iw8_ges_demeanor_relaxed");
  thread demeanor_exit_func_wait(&exit_demeanor_relaxed);
}

function enter_demeanor_green_beam() {
  thread set_demeanor_code_think("relaxed", "iw8_ges_green_laser_demeanor_relaxed");
  thread demeanor_exit_func_wait(&exit_demeanor_relaxed);
}

function exit_demeanor_relaxed() {}

function enter_demeanor_safe(var0) {
  thread set_demeanor_code_think("relaxed", "iw8_ges_demeanor_safe");
  thread demeanor_exit_func_wait(&exit_demeanor_safe);
}

function exit_demeanor_safe(var0) {}

function safe_zoom_think() {
  self endon("entering_new_demeanor");
  self endon("death");
  self.gestures.safedefaultfov = getdvarint("MRNKTKLLKP");
  GscBinSkip4(0x35);
}

function safe_zoom_in_listen() {
  level.player notifyonplayercommand("safe_zoom_pressed", "+toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_pressed", "+ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_pressed", "+speed_throw");

  for(;;) {
    self waittill("safe_zoom_pressed");
    self modifybasefov(self.gestures.safedefaultfov - 9, 0.14);
  }
}

function safe_zoom_out_listen() {
  level.player notifyonplayercommand("safe_zoom_released", "-toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_released", "-ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_released", "-speed_throw");

  for(;;) {
    self waittill("safe_zoom_released");
    self modifybasefov(self.gestures.safedefaultfov, 0.1);
  }
}

function safe_zoom_end_think() {
  self endon("death");
  self waittill("entering_new_demeanor");
  self modifybasefov(self.gestures.safedefaultfov, 0.1);
}

function demeanor_exit_func_wait(var0) {
  self waittill("entering_new_demeanor");
  self[[var0]]();
}

function set_demeanor_code_think(var0, var1) {
  self endon("entering_new_demeanor");
  self endon("death");

  for(;;) {
    if(isDefined(var1)) {
      var2 = self setdemeanorviewmodel(var0, var1);
    } else {
      var2 = self setdemeanorviewmodel(var0);
    }

    if(var2) {
      break;
    }

    wait 0.05;
  }
}

function player_gestures_input_disable(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  self endon("death");

  if(!isDefined(var13)) {
    var13 = "gesture";
  }

  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  if(isDefined(var1) && var1 == 1) {
    if(level.player getstance() == "prone") {
      scripts\engine\sp\utility::blend_movespeedscale(0, 0, "gesture");
      thread player_gestures_prone_getup_think(var0, var13);

      if(!isDefined(self.gestures.restrictingpronespeed)) {
        self.gestures.restrictingpronespeed = 0;
      }

      self.gestures.restrictingpronespeed++;
    } else {
      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      scripts\common\utility::allow_prone(0, var13);
    }

    self.gestures.restrictingpronemovement = 1;
  }

  if(isDefined(var2) && var2 == 1) {
    if(!isDefined(self.gestures.restrictingmantle)) {
      self.gestures.restrictingmantle = 0;
    }

    self.gestures.restrictingmantle++;
    scripts\common\utility::allow_mantle(0, var13);
  }

  if(isDefined(var3) && var3 == 1) {
    if(!isDefined(self.gestures.restrictingsprint)) {
      self.gestures.restrictingsprint = 0;
    }

    self.gestures.restrictingsprint++;
    scripts\common\utility::allow_sprint(0, var13);
  }

  if(isDefined(var4) && var4 == 1) {
    if(!isDefined(self.gestures.restrictingfire)) {
      self.gestures.restrictingfire = 0;
    }

    self.gestures.restrictingfire++;
    scripts\common\utility::allow_fire(0, var13);
  }

  if(isDefined(var5) && var5 == 1) {
    if(!isDefined(self.gestures.restrictingreload)) {
      self.gestures.restrictingreload = 0;
    }

    self.gestures.restrictingreload++;
    scripts\common\utility::allow_reload(0, var13);
  }

  if(isDefined(var6) && var6 == 1) {
    if(!isDefined(self.gestures.restrictingweaponswitch)) {
      self.gestures.restrictingweaponswitch = 0;
    }

    self.gestures.restrictingweaponswitch++;
    scripts\common\utility::allow_weapon_switch(0, var13);
  }

  if(isDefined(var7) && var7 == 1) {
    if(!isDefined(self.gestures.restrictingads)) {
      self.gestures.restrictingads = 0;
    }

    self.gestures.restrictingads++;
    scripts\common\utility::allow_ads(0, var13);
  }

  if(isDefined(var8) && var8 == 1) {
    if(!isDefined(self.gestures.restrictingwallrun)) {
      self.gestures.restrictingwallrun = 0;
    }

    self.gestures.restrictingwallrun++;
    scripts\common\utility::allow_wallrun(0, var13);
  }

  if(isDefined(var9) && var9 == 1) {
    if(!isDefined(self.gestures.restrictingdoublejump)) {
      self.gestures.restrictingdoublejump = 0;
    }

    self.gestures.restrictingdoublejump++;
    scripts\common\utility::allow_doublejump(0, var13);
  }

  if(isDefined(var10) && var10 == 1) {
    if(!isDefined(self.gestures.restrictingmeleeattack)) {
      self.gestures.restrictingmeleeattack = 0;
    }

    self.gestures.restrictingmeleeattack++;
    scripts\common\utility::allow_melee(0, var13);
  }

  if(isDefined(var11) && var11 == 1) {
    if(!isDefined(self.gestures.restrictingoffhandweapons)) {
      self.gestures.restrictingoffhandweapons = 0;
    }

    self.gestures.restrictingoffhandweapons++;
    scripts\common\utility::allow_offhand_weapons(0, var13);
  }

  jumpiffalse(isDefined(var12)) LOC_00000353;
  wait var12;
  goto LOC_0000037f;
}

function player_gestures_input_enable(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  if(isDefined(var0) && var0 > 0) {
    if(isDefined(self.gestures.restrictingpronespeed) && self.gestures.restrictingpronespeed > 0) {
      if(isDefined(level.player.movespeedscale) && level.player.movespeedscale == 0) {
        self.gestures.restrictingpronespeed--;

        if(self.gestures.restrictingpronespeed <= 0) {
          scripts\engine\sp\utility::blend_movespeedscale(1, 0, "gesture");
        }
      }
    }

    if(isDefined(self.gestures.restrictingpronestance) && self.gestures.restrictingpronestance > 0) {
      self.gestures.restrictingpronestance--;
      scripts\common\utility::allow_prone(1, var11);
    }
  }

  if(isDefined(var1) && var1 == 1) {
    scripts\common\utility::allow_mantle(1, var11);
  }

  if(isDefined(var2) && var2 == 1) {
    scripts\common\utility::allow_sprint(1, var11);
  }

  if(isDefined(var3) && var3 == 1) {
    scripts\common\utility::allow_fire(1, var11);
  }

  if(isDefined(var4) && var4 == 1) {
    scripts\common\utility::allow_reload(1, var11);
  }

  if(isDefined(var5) && var5 == 1) {
    scripts\common\utility::allow_weapon_switch(1, var11);
  }

  if(isDefined(var6) && var6 == 1) {
    scripts\common\utility::allow_ads(1, var11);
  }

  if(isDefined(var7) && var7 == 1) {
    scripts\common\utility::allow_wallrun(0, var11);
  }

  if(isDefined(var8) && var8 == 1) {
    scripts\common\utility::allow_doublejump(0, var11);
  }

  if(isDefined(var9) && var9 == 1) {
    scripts\common\utility::allow_melee(1, var11);
  }

  if(isDefined(var10) && var10 == 1) {
    scripts\common\utility::allow_offhand_weapons(1, var11);
    return;
  }
}

function player_gestures_prone_getup_think(var0, var1) {
  self endon("death");
  self endon(var0 + "gesture_stopped_internal");
  var2 = 1;

  while(var2) {
    if(self getstance() != "prone") {
      waittillframeend();

      if(isDefined(level.player.movespeedscale) && level.player.movespeedscale == 0) {
        self.gestures.restrictingpronespeed--;

        if(self.gestures.restrictingpronespeed <= 0) {
          scripts\engine\sp\utility::blend_movespeedscale(1, 0, "gesture");
        }
      }

      if(!isDefined(self.gestures.restrictingpronestance)) {
        self.gestures.restrictingpronestance = 0;
      }

      self.gestures.restrictingpronestance++;
      scripts\common\utility::allow_prone(0, var1);
      var2 = 0;
    }

    wait 0.05;
  }
}