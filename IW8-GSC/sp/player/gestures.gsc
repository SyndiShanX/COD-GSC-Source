/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\gestures.gsc
***********************************************/

enter_demeanor_normal() {
  thread set_demeanor_code_think("normal");
  thread demeanor_exit_func_wait(::exit_demeanor_normal);
}

exit_demeanor_normal() {}

enter_demeanor_relaxed() {
  thread set_demeanor_code_think("relaxed", "iw8_ges_demeanor_relaxed");
  thread demeanor_exit_func_wait(::exit_demeanor_relaxed);
}

enter_demeanor_green_beam() {
  thread set_demeanor_code_think("relaxed", "iw8_ges_green_laser_demeanor_relaxed");
  thread demeanor_exit_func_wait(::exit_demeanor_relaxed);
}

exit_demeanor_relaxed() {}

enter_demeanor_safe(var_0) {
  thread set_demeanor_code_think("relaxed", "iw8_ges_demeanor_safe");
  thread demeanor_exit_func_wait(::exit_demeanor_safe);
}

exit_demeanor_safe(var_0) {}

safe_zoom_think() {
  self endon("entering_new_demeanor");
  self endon("death");
  self.gestures.safedefaultfov = getdvarint("MRNKTKLLKP");
  childthread safe_zoom_in_listen();
  childthread safe_zoom_out_listen();
  thread safe_zoom_end_think();
}

safe_zoom_in_listen() {
  level.player notifyonplayercommand("safe_zoom_pressed", "+toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_pressed", "+ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_pressed", "+speed_throw");

  for(;;) {
    self waittill("safe_zoom_pressed");
    self modifybasefov(self.gestures.safedefaultfov - 9, 0.14);
  }
}

safe_zoom_out_listen() {
  level.player notifyonplayercommand("safe_zoom_released", "-toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_released", "-ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_released", "-speed_throw");

  for(;;) {
    self waittill("safe_zoom_released");
    self modifybasefov(self.gestures.safedefaultfov, 0.1);
  }
}

safe_zoom_end_think() {
  self endon("death");
  self waittill("entering_new_demeanor");
  self modifybasefov(self.gestures.safedefaultfov, 0.1);
}

demeanor_exit_func_wait(var_0) {
  self waittill("entering_new_demeanor");
  self[[var_0]]();
}

set_demeanor_code_think(var_0, var_1) {
  self endon("entering_new_demeanor");
  self endon("death");

  for(;;) {
    if(isDefined(var_1))
      var_2 = self setdemeanorviewmodel(var_0, var_1);
    else
      var_2 = self setdemeanorviewmodel(var_0);

    if(var_2) {
      break;
    }

    wait 0.05;
  }
}

player_gestures_input_disable(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("death");

  if(!isDefined(var_13))
    var_13 = "gesture";

  if(!isDefined(self.gestures))
    self.gestures = spawnStruct();

  if(isDefined(var_1) && var_1 == 1) {
    if(level.player getstance() == "prone") {
      scripts\engine\sp\utility::blend_movespeedscale(0.0, 0, "gesture");
      thread player_gestures_prone_getup_think(var_0, var_13);

      if(!isDefined(self.gestures.restrictingpronespeed))
        self.gestures.restrictingpronespeed = 0;

      self.gestures.restrictingpronespeed++;
    } else {
      if(!isDefined(self.gestures.restrictingpronestance))
        self.gestures.restrictingpronestance = 0;

      self.gestures.restrictingpronestance++;
      scripts\common\utility::allow_prone(0, var_13);
    }

    self.gestures.restrictingpronemovement = 1;
  }

  if(isDefined(var_2) && var_2 == 1) {
    if(!isDefined(self.gestures.restrictingmantle))
      self.gestures.restrictingmantle = 0;

    self.gestures.restrictingmantle++;
    scripts\common\utility::allow_mantle(0, var_13);
  }

  if(isDefined(var_3) && var_3 == 1) {
    if(!isDefined(self.gestures.restrictingsprint))
      self.gestures.restrictingsprint = 0;

    self.gestures.restrictingsprint++;
    scripts\common\utility::allow_sprint(0, var_13);
  }

  if(isDefined(var_4) && var_4 == 1) {
    if(!isDefined(self.gestures.restrictingfire))
      self.gestures.restrictingfire = 0;

    self.gestures.restrictingfire++;
    scripts\common\utility::allow_fire(0, var_13);
  }

  if(isDefined(var_5) && var_5 == 1) {
    if(!isDefined(self.gestures.restrictingreload))
      self.gestures.restrictingreload = 0;

    self.gestures.restrictingreload++;
    scripts\common\utility::allow_reload(0, var_13);
  }

  if(isDefined(var_6) && var_6 == 1) {
    if(!isDefined(self.gestures.restrictingweaponswitch))
      self.gestures.restrictingweaponswitch = 0;

    self.gestures.restrictingweaponswitch++;
    scripts\common\utility::allow_weapon_switch(0, var_13);
  }

  if(isDefined(var_7) && var_7 == 1) {
    if(!isDefined(self.gestures.restrictingads))
      self.gestures.restrictingads = 0;

    self.gestures.restrictingads++;
    scripts\common\utility::allow_ads(0, var_13);
  }

  if(isDefined(var_8) && var_8 == 1) {
    if(!isDefined(self.gestures.restrictingwallrun))
      self.gestures.restrictingwallrun = 0;

    self.gestures.restrictingwallrun++;
    scripts\common\utility::allow_wallrun(0, var_13);
  }

  if(isDefined(var_9) && var_9 == 1) {
    if(!isDefined(self.gestures.restrictingdoublejump))
      self.gestures.restrictingdoublejump = 0;

    self.gestures.restrictingdoublejump++;
    scripts\common\utility::allow_doublejump(0, var_13);
  }

  if(isDefined(var_10) && var_10 == 1) {
    if(!isDefined(self.gestures.restrictingmeleeattack))
      self.gestures.restrictingmeleeattack = 0;

    self.gestures.restrictingmeleeattack++;
    scripts\common\utility::allow_melee(0, var_13);
  }

  if(isDefined(var_11) && var_11 == 1) {
    if(!isDefined(self.gestures.restrictingoffhandweapons))
      self.gestures.restrictingoffhandweapons = 0;

    self.gestures.restrictingoffhandweapons++;
    scripts\common\utility::allow_offhand_weapons(0, var_13);
  }

  if(isDefined(var_12))
    wait(var_12);
  else {
    self waittill("gesture_stopped", var_14);

    if(var_14 != var_0) {
      for(;;) {
        if(!self isgestureplaying(var_0)) {
          break;
        }

        wait 0.05;
      }
    }
  }

  self notify(var_0 + "gesture_stopped_internal");
  player_gestures_input_enable(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_13);
}

player_gestures_input_enable(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self.gestures))
    self.gestures = spawnStruct();

  if(isDefined(var_0) && var_0 > 0) {
    if(isDefined(self.gestures.restrictingpronespeed) && self.gestures.restrictingpronespeed > 0) {
      if(isDefined(level.player.movespeedscale) && level.player.movespeedscale == 0.0) {
        self.gestures.restrictingpronespeed--;

        if(self.gestures.restrictingpronespeed <= 0)
          scripts\engine\sp\utility::blend_movespeedscale(1.0, 0, "gesture");
      }
    }

    if(isDefined(self.gestures.restrictingpronestance) && self.gestures.restrictingpronestance > 0) {
      self.gestures.restrictingpronestance--;
      scripts\common\utility::allow_prone(1, var_11);
    }
  }

  if(isDefined(var_1) && var_1 == 1)
    scripts\common\utility::allow_mantle(1, var_11);

  if(isDefined(var_2) && var_2 == 1)
    scripts\common\utility::allow_sprint(1, var_11);

  if(isDefined(var_3) && var_3 == 1)
    scripts\common\utility::allow_fire(1, var_11);

  if(isDefined(var_4) && var_4 == 1)
    scripts\common\utility::allow_reload(1, var_11);

  if(isDefined(var_5) && var_5 == 1)
    scripts\common\utility::allow_weapon_switch(1, var_11);

  if(isDefined(var_6) && var_6 == 1)
    scripts\common\utility::allow_ads(1, var_11);

  if(isDefined(var_7) && var_7 == 1)
    scripts\common\utility::allow_wallrun(0, var_11);

  if(isDefined(var_8) && var_8 == 1)
    scripts\common\utility::allow_doublejump(0, var_11);

  if(isDefined(var_9) && var_9 == 1)
    scripts\common\utility::allow_melee(1, var_11);

  if(isDefined(var_10) && var_10 == 1)
    scripts\common\utility::allow_offhand_weapons(1, var_11);
}

player_gestures_prone_getup_think(var_0, var_1) {
  self endon("death");
  self endon(var_0 + "gesture_stopped_internal");
  var_2 = 1;

  while(var_2) {
    if(self getstance() != "prone") {
      waittillframeend;

      if(isDefined(level.player.movespeedscale) && level.player.movespeedscale == 0.0) {
        self.gestures.restrictingpronespeed--;

        if(self.gestures.restrictingpronespeed <= 0)
          scripts\engine\sp\utility::blend_movespeedscale(1.0, 0, "gesture");
      }

      if(!isDefined(self.gestures.restrictingpronestance))
        self.gestures.restrictingpronestance = 0;

      self.gestures.restrictingpronestance++;
      scripts\common\utility::allow_prone(0, var_1);
      var_2 = 0;
    }

    wait 0.05;
  }
}