/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_stoppingpower.gsc
*****************************************************/

stoppingpower_init() {
  level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_subscribe(::stoppingpower_onweaponcreated, level);
  level.onweapondroppickedup scripts\cp_mp\utility\callback_group::callback_subscribe(::stoppingpower_onweaponpickedup, level);
}

stoppingpower_beginuse() {
  _id_F4E6D9AFE1E11685 = self.lastnormalweaponobj;
  _id_8DE014639F689574 = nullweapon();

  if(scripts\mp\utility\weapon::ismeleeonly(_id_F4E6D9AFE1E11685) || scripts\mp\utility\weapon::issuperweapon(_id_F4E6D9AFE1E11685) || _id_2669878CF5A1B6BC::iskillstreakweapon(_id_F4E6D9AFE1E11685) || scripts\mp\utility\weapon::isgamemodeweapon(_id_F4E6D9AFE1E11685) || scripts\mp\utility\weapon::issinglehitweapon(_id_F4E6D9AFE1E11685.basename) || !stoppingpower_isvalidprimaryoralt(_id_F4E6D9AFE1E11685) || _id_F4E6D9AFE1E11685.basename == "iw8_lm_dblmg_mp" || _id_F4E6D9AFE1E11685.basename == "iw9_me_fists_mp") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");

    return 0;
  }

  result = stoppingpower_cancelreload();

  if(!istrue(result))
    return 0;

  if(self isalternatemode(_id_F4E6D9AFE1E11685)) {
    _id_8DE014639F689574 = _id_F4E6D9AFE1E11685;
    _id_F4E6D9AFE1E11685 = _id_F4E6D9AFE1E11685 getnoaltweapon();
  } else
    _id_8DE014639F689574 = _id_F4E6D9AFE1E11685 getaltweapon();

  _id_12A372E8CAA042BB = [];
  stockammo = 0;
  _id_C88113BFEDD68CF0 = 0;

  if(!isnullweapon(_id_8DE014639F689574))
    _id_12A372E8CAA042BB[_id_12A372E8CAA042BB.size] = _id_8DE014639F689574;

  _id_12A372E8CAA042BB[_id_12A372E8CAA042BB.size] = _id_F4E6D9AFE1E11685;

  foreach(weaponobj in _id_12A372E8CAA042BB) {
    isakimbo = 0;

    if(weaponobj._id_318338AA880DFAC6)
      isakimbo = 1;

    if(issameweapon(weaponobj, _id_F4E6D9AFE1E11685, 0)) {
      clipammo = scripts\mp\weapons::getammooverride(weaponobj);
      _id_971F8E0ABBCAFAB8 = clipammo * 1;

      if(isakimbo)
        _id_971F8E0ABBCAFAB8 = _id_971F8E0ABBCAFAB8 * 2;

      thread stoppingpower_givehcr(self, weaponobj, _id_971F8E0ABBCAFAB8);

      if(1) {
        if(isakimbo) {
          clipammo = self getweaponammoclip(weaponobj, "left") + self getweaponammoclip(weaponobj, "right");
          stockammo = self getweaponammostock(weaponobj);
          _id_7474313B0EF773B4 = clipammo + stockammo;
          _id_2AA9CAEF99C9AF77 = int(min(weaponmaxammo(weaponobj), _id_7474313B0EF773B4 + _id_971F8E0ABBCAFAB8));
          self setweaponammostock(weaponobj, _id_2AA9CAEF99C9AF77);
          self setweaponammoclip(weaponobj, 0, "left");
          self setweaponammoclip(weaponobj, 0, "right");
        } else {
          clipammo = self getweaponammoclip(weaponobj);
          stockammo = self getweaponammostock(weaponobj);
          _id_7474313B0EF773B4 = clipammo + stockammo;
          maxammo = weaponmaxammo(weaponobj);
          _id_AED95A39B937C353 = _id_7474313B0EF773B4 + _id_971F8E0ABBCAFAB8;
          _id_C88113BFEDD68CF0 = int(_id_AED95A39B937C353 - maxammo);
          _id_5B3F7D686C59AB97 = int(min(maxammo, _id_AED95A39B937C353));

          if(weaponobj.basename == "iw8_lm_dblmg_mp")
            self setweaponammoclip(weaponobj, clipammo + _id_971F8E0ABBCAFAB8);
          else {
            self setweaponammoclip(weaponobj, 0);

            if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
              _id_E074B618E47255FE = _id_5B3F7D686C59AB97 - stockammo;
              _id_724736FCF0FB6604::br_give_weapon_ammo(weaponobj, _id_E074B618E47255FE);
            } else
              self setweaponammostock(weaponobj, _id_5B3F7D686C59AB97);
          }
        }
      }
    }
  }

  thread stoppingpower_waitforreload(_id_F4E6D9AFE1E11685, stockammo, _id_C88113BFEDD68CF0);
  return 1;
}

stoppingpower_isvalidprimaryoralt(objweapon) {
  if(!self isalternatemode(objweapon))
    return 1;

  underbarrel = objweapon.underbarrel;
  return scripts\mp\weapons::isattachmentselectfire(objweapon, underbarrel);
}

stoppingpower_waitforreload(weaponobj, stockammo, _id_C88113BFEDD68CF0) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    if(self getcurrentprimaryweapon() != weaponobj) {
      break;
    }

    _id_B971E09CE070BD58 = self getweaponammoclip(weaponobj);

    if(_id_B971E09CE070BD58 > 0) {
      thread scripts\mp\hud_message::showsplash("stopping_power_loaded");

      if(_id_C88113BFEDD68CF0 > 0)
        self setweaponammostock(weaponobj, stockammo + _id_C88113BFEDD68CF0);

      break;
    }

    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
}

stoppingpower_givehcr(player, objweapon, _id_045ACD1D2458698A) {
  hcrdata = spawnStruct();
  hcrdata.player = player;
  hcrdata.objweapon = objweapon;
  hcrdata.rounds = _id_045ACD1D2458698A;
  hcrdata.gavehcr = 0;
  hcrdata.kills = 0;
  stoppingpower_givehcrdata(player, hcrdata);
}

stoppingpower_givehcrdata(player, hcrdata) {
  if(!isDefined(player.hcrdata))
    player.hcrdata = [];

  id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(hcrdata.objweapon);
  _id_500DF980161B0D67 = player.hcrdata[id];

  if(isDefined(_id_500DF980161B0D67))
    _id_500DF980161B0D67 thread stoppingpower_removehcr();

  player.hcrdata[id] = hcrdata;
  hcrdata thread stoppingpower_clearhcrondeath();
  hcrdata thread stoppingpower_clearhcrongameended();
  hcrdata thread stoppingpower_clearhcronperkscleared();
  hcrdata thread stoppingpower_givefastreload();
  player thread stoppingpower_breaksprint();
  hcrdata thread stoppingpower_watchhcrweaponchange();
  hcrdata thread stoppingpower_watchhcrweaponfire();
}

stoppingpower_onweaponcreated(_id_614411B9142BD852, _id_2CA201D5906CDBA5, weaponobj) {
  if(!isDefined(_id_614411B9142BD852) || !isDefined(_id_2CA201D5906CDBA5)) {
    return;
  }
  hcrdata = _id_2CA201D5906CDBA5 stoppingpower_getweaponhcrdata(weaponobj);
  _id_614411B9142BD852.hcrdata = hcrdata;
}

stoppingpower_onweaponpickedup(_id_614411B9142BD852, _id_480F8576BE141BB4, weaponobj) {
  if(!isDefined(_id_614411B9142BD852.hcrdata)) {
    return;
  }
  hcrdata = _id_614411B9142BD852.hcrdata;
  hcrdata.player = _id_480F8576BE141BB4;
  hcrdata.gavehcr = 0;
  hcrdata.kills = 0;
  stoppingpower_givehcrdata(_id_480F8576BE141BB4, hcrdata);
}

stoppingpower_getweaponhcrdata(objweapon) {
  if(!isDefined(objweapon))
    return undefined;

  if(!isDefined(self.hcrdata))
    return undefined;

  id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(objweapon);
  return self.hcrdata[id];
}

stoppingpower_cancelreload() {
  self endon("death_or_disconnect");
  self cancelreload();
  wait 0.05;
  return 1;
}

stoppingpower_watchhcrweaponchange() {
  self endon("stoppingPower_removeHCR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    if(stoppingpower_ishcrweapon(self.player getcurrentweapon())) {
      if(!self.gavehcr) {
        self.player scripts\mp\utility\perk::giveperk("specialty_bulletdamage");
        self.gavehcr = 1;
      }
    } else if(self.gavehcr) {
      self.player scripts\mp\utility\perk::removeperk("specialty_bulletdamage");
      self.gavehcr = 0;
    }

    self.player waittill("weapon_change");
  }

  thread stoppingpower_removehcr();
}

stoppingpower_watchhcrweaponfire() {
  self endon("stoppingPower_removeHCR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("weapon_fired", objweapon);

    if(stoppingpower_ishcrweapon(objweapon)) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  self.player thread stoppingpower_tracklastcrossbowshot(self.objweapon);
  thread stoppingpower_removehcr();
}

stoppingpower_tracklastcrossbowshot(objweapon) {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);

  if(_id_AB501F397D3CD312 != "iw9_dm_crossbow") {
    return;
  }
  self.lastcrossbowhadstoppingpower = 1;
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(2, "weapon_fired", "weapon_change");
  self.lastcrossbowhadstoppingpower = undefined;
}

stoppingpower_removehcr() {
  self notify("stoppingPower_removeHCR");

  if(isDefined(self.player)) {
    if(self.gavehcr)
      self.player scripts\mp\utility\perk::removeperk("specialty_bulletdamage");

    stoppingpower_clearhcrdata();
  }
}

stoppingpower_loadoutchangeremovehcr() {
  self notify("stoppingPower_removeHCR");

  if(isDefined(self.player))
    stoppingpower_clearhcrdata();
}

stoppingpower_clearhcrdata() {
  if(isDefined(self.player.hcrdata)) {
    id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(self.objweapon);
    hcrdata = self.player.hcrdata[id];

    if(hcrdata == self)
      self.player.hcrdata[id] = undefined;

    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["super_support_box"].id, self.kills, 0);
  }
}

stoppingpower_onkill(weaponobj) {
  if(isDefined(weaponobj)) {
    id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(weaponobj);
    hcrdata = self.hcrdata[id];

    if(isDefined(hcrdata)) {
      scripts\mp\utility\stats::incpersstat("stoppingPowerKills", 1);
      scripts\mp\supers::combatrecordsuperkill("super_support_box");
      hcrdata.kills++;
    }
  }
}

stoppingpower_ishcrweapon(objweapon) {
  _id_4DE6BC49EAA87870 = self.player getammotype(self.objweapon);
  _id_49A4190715712F10 = self.player getammotype(objweapon);
  _id_9438D6B1D63250F7 = _id_4DE6BC49EAA87870 == _id_49A4190715712F10;
  return issameweapon(objweapon, self.objweapon, 1) && _id_9438D6B1D63250F7;
}

stoppingpower_clearhcrondeath() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  self.player waittill("death");
  thread stoppingpower_removehcr();
}

stoppingpower_clearhcrongameended() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  level waittill("game_ended");
  thread stoppingpower_removehcr();
}

stoppingpower_clearhcronperkscleared() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  self.player waittill("all_perks_cleared");
  thread stoppingpower_loadoutchangeremovehcr();
}

stoppingpower_givefastreload() {
  self.player endon("death_or_disconnect");
  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self.player scripts\engine\utility::waittill_any_3("weapon_fired", "weapon_change", "stoppingPower_removeHCR");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
}

stoppingpower_breaksprint() {
  self endon("death_or_disconnect");
  _id_3B64EB40368C1450::set("stoppingPower", "sprint", 0);
  wait 0.4;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("stoppingPower");
}