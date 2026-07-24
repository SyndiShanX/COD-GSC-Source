/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3657.gsc
**************************************/

_id_660C() {
  thread _id_F34E("normal");
  thread _id_51E0(::_id_694B);
}

_id_694B() {}

_id_660D() {
  thread _id_F34E("relaxed");
  thread _id_51E0(::_id_694C);
}

_id_694C() {}

_id_660E(var_0) {
  thread _id_F34E("safe");

  if(!isDefined(var_0) || var_0 == 0) {
    thread scripts\sp\utility::_id_2B76(0.8, 0.2);
    self._id_77C1._id_51E5 = 1;
  }

  self _meth_80D8(0.7, 0.7);
  thread _id_EA1E();
  scripts\engine\utility::allow_melee(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::allow_doublejump(0);
  scripts\engine\utility::allow_wallrun(0);
  scripts\engine\utility::allow_ads(0);
  thread _id_51E0(::_id_694D);
}

_id_694D(var_0) {
  if(isDefined(self._id_77C1._id_51E5) && self._id_77C1._id_51E5 == 1) {
    thread scripts\sp\utility::_id_2B77(0.2);
    self._id_77C1._id_51E5 = 0;
  }

  self _meth_80A6();
  scripts\engine\utility::allow_melee(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_doublejump(1);
  scripts\engine\utility::allow_wallrun(1);
  scripts\engine\utility::allow_ads(1);
}

_id_660B() {
  self _meth_846C("safe", "ges_demeanor_magboots");
  thread _id_51E0(::_id_694A);
}

_id_694A() {}

_id_EA1E() {
  self endon("entering_new_demeanor");
  self endon("death");
  self._id_77C1._id_EA1F = getdvarint("cg_fov");
  childthread _id_EA1C();
  childthread _id_EA1D();
  thread _id_EA1B();
}

_id_EA1C() {
  level.player notifyonplayercommand("safe_zoom_pressed", "+toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_pressed", "+ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_pressed", "+speed_throw");

  for(;;) {
    self waittill("safe_zoom_pressed");
    self _meth_81DE(self._id_77C1._id_EA1F - 9, 0.14);
  }
}

_id_EA1D() {
  level.player notifyonplayercommand("safe_zoom_released", "-toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_released", "-ads_akimbo_accessible");
  level.player notifyonplayercommand("safe_zoom_released", "-speed_throw");

  for(;;) {
    self waittill("safe_zoom_released");
    self _meth_81DE(self._id_77C1._id_EA1F, 0.1);
  }
}

_id_EA1B() {
  self endon("death");
  self waittill("entering_new_demeanor");
  self _meth_81DE(self._id_77C1._id_EA1F, 0.1);
}

_id_51E0(var_0) {
  self waittill("entering_new_demeanor");
  self[[var_0]]();
}

_id_F34E(var_0) {
  self endon("entering_new_demeanor");
  self endon("death");

  for(;;) {
    var_1 = self _meth_846C(var_0);

    if(var_1) {
      break;
    }

    wait 0.05;
  }
}

_id_D092(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self endon("death");

  if(!isDefined(self._id_77C1))
    self._id_77C1 = spawnStruct();

  if(isDefined(var_1) && var_1 == 1) {
    if(level.player getstance() == "prone") {
      if(isDefined(self._id_77C1._id_DA82)) {} else if(isDefined(level.player._id_BCF5))
        self._id_77C1._id_DA82 = level.player._id_BCF5;
      else
        self._id_77C1._id_DA82 = 1.0;

      scripts\sp\utility::_id_2B76(0.0);
      thread _id_D094(var_0);

      if(!isDefined(self._id_77C1._id_E2F4))
        self._id_77C1._id_E2F4 = 0;

      self._id_77C1._id_E2F4++;
    } else {
      if(!isDefined(self._id_77C1._id_E2F5))
        self._id_77C1._id_E2F5 = 0;

      self._id_77C1._id_E2F5++;
      scripts\engine\utility::allow_prone(0);
    }

    self._id_77C1._id_E2F3 = 1;
  }

  if(isDefined(var_2) && var_2 == 1) {
    if(!isDefined(self._id_77C1._id_E2F0))
      self._id_77C1._id_E2F0 = 0;

    self._id_77C1._id_E2F0++;
    scripts\engine\utility::allow_mantle(0);
  }

  if(isDefined(var_3) && var_3 == 1) {
    if(!isDefined(self._id_77C1._id_E2F7))
      self._id_77C1._id_E2F7 = 0;

    self._id_77C1._id_E2F7++;
    scripts\engine\utility::allow_sprint(0);
  }

  if(isDefined(var_4) && var_4 == 1) {
    if(!isDefined(self._id_77C1._id_E2EF))
      self._id_77C1._id_E2EF = 0;

    self._id_77C1._id_E2EF++;
    scripts\engine\utility::allow_fire(0);
  }

  if(isDefined(var_5) && var_5 == 1) {
    if(!isDefined(self._id_77C1._id_E2F6))
      self._id_77C1._id_E2F6 = 0;

    self._id_77C1._id_E2F6++;
    scripts\engine\utility::allow_reload(0);
  }

  if(isDefined(var_6) && var_6 == 1) {
    if(!isDefined(self._id_77C1._id_E2F9))
      self._id_77C1._id_E2F9 = 0;

    self._id_77C1._id_E2F9++;
    scripts\engine\utility::allow_weapon_switch(0);
  }

  if(isDefined(var_7) && var_7 == 1) {
    if(!isDefined(self._id_77C1._id_E2ED))
      self._id_77C1._id_E2ED = 0;

    self._id_77C1._id_E2ED++;
    scripts\engine\utility::allow_ads(0);
  }

  if(isDefined(var_8) && var_8 == 1) {
    if(!isDefined(self._id_77C1._id_E2F8))
      self._id_77C1._id_E2F8 = 0;

    self._id_77C1._id_E2F8++;
    scripts\engine\utility::allow_wallrun(0);
  }

  if(isDefined(var_9) && var_9 == 1) {
    if(!isDefined(self._id_77C1._id_E2EE))
      self._id_77C1._id_E2EE = 0;

    self._id_77C1._id_E2EE++;
    scripts\engine\utility::allow_doublejump(0);
  }

  if(isDefined(var_10) && var_10 == 1) {
    if(!isDefined(self._id_77C1._id_E2F1))
      self._id_77C1._id_E2F1 = 0;

    self._id_77C1._id_E2F1++;
    scripts\engine\utility::allow_melee(0);
  }

  if(isDefined(var_11) && var_11 == 1) {
    if(!isDefined(self._id_77C1._id_E2F2))
      self._id_77C1._id_E2F2 = 0;

    self._id_77C1._id_E2F2++;
    scripts\engine\utility::allow_offhand_weapons(0);
  }

  if(isDefined(var_12))
    wait(var_12);
  else {
    self waittill("gesture_stopped", var_13);

    if(var_13 != var_0) {
      for(;;) {
        if(!self isgestureplaying(var_0)) {
          break;
        }

        wait 0.05;
      }
    }
  }

  self notify(var_0 + "gesture_stopped_internal");
  _id_D093(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_D093(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(self._id_77C1))
    self._id_77C1 = spawnStruct();

  if(isDefined(var_0) && var_0 > 0) {
    if(isDefined(self._id_77C1._id_E2F4) && self._id_77C1._id_E2F4 > 0) {
      if(isDefined(level.player._id_BCF5) && level.player._id_BCF5 == 0.0) {
        self._id_77C1._id_E2F4--;

        if(self._id_77C1._id_E2F4 <= 0) {
          scripts\sp\utility::_id_2B76(self._id_77C1._id_DA82);
          self._id_77C1._id_DA82 = undefined;
        }
      }
    }

    if(isDefined(self._id_77C1._id_E2F5) && self._id_77C1._id_E2F5 > 0) {
      self._id_77C1._id_E2F5--;
      scripts\engine\utility::allow_prone(1);
    }
  }

  if(isDefined(var_1) && var_1 == 1)
    scripts\engine\utility::allow_mantle(1);

  if(isDefined(var_2) && var_2 == 1)
    scripts\engine\utility::allow_sprint(1);

  if(isDefined(var_3) && var_3 == 1)
    scripts\engine\utility::allow_fire(1);

  if(isDefined(var_4) && var_4 == 1)
    scripts\engine\utility::allow_reload(1);

  if(isDefined(var_5) && var_5 == 1)
    scripts\engine\utility::allow_weapon_switch(1);

  if(isDefined(var_6) && var_6 == 1)
    scripts\engine\utility::allow_ads(1);

  if(isDefined(var_7) && var_7 == 1)
    scripts\engine\utility::allow_wallrun(1);

  if(isDefined(var_8) && var_8 == 1)
    scripts\engine\utility::allow_doublejump(1);

  if(isDefined(var_9) && var_9 == 1)
    scripts\engine\utility::allow_melee(1);

  if(isDefined(var_10) && var_10 == 1)
    scripts\engine\utility::allow_offhand_weapons(1);
}

_id_D094(var_0) {
  self endon("death");
  self endon(var_0 + "gesture_stopped_internal");
  var_1 = 1;

  while(var_1) {
    if(self getstance() != "prone") {
      waittillframeend;

      if(isDefined(level.player._id_BCF5) && level.player._id_BCF5 == 0.0) {
        self._id_77C1._id_E2F4--;

        if(self._id_77C1._id_E2F4 <= 0) {
          scripts\sp\utility::_id_2B76(self._id_77C1._id_DA82);
          self._id_77C1._id_DA82 = undefined;
        }
      }

      if(!isDefined(self._id_77C1._id_E2F5))
        self._id_77C1._id_E2F5 = 0;

      self._id_77C1._id_E2F5++;
      scripts\engine\utility::allow_prone(0);
      var_1 = 0;
    }

    wait 0.05;
  }
}