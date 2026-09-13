/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_suppression_rounds.gsc
**********************************************************/

_id_D0930F871341093C() {
  level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_subscribe(::_id_07DA2A2F573CF8D9, level);
  level.onweapondroppickedup scripts\cp_mp\utility\callback_group::callback_subscribe(::_id_AFC54FC21DFDC776, level);
}

_id_55AAE48E013652FA() {
  _id_F4E6D9AFE1E11685 = self.lastnormalweaponobj;
  _id_8DE014639F689574 = nullweapon();

  if(scripts\mp\utility\weapon::ismeleeonly(_id_F4E6D9AFE1E11685) || scripts\mp\utility\weapon::issuperweapon(_id_F4E6D9AFE1E11685) || _id_2669878CF5A1B6BC::iskillstreakweapon(_id_F4E6D9AFE1E11685) || scripts\mp\utility\weapon::isgamemodeweapon(_id_F4E6D9AFE1E11685) || scripts\mp\utility\weapon::issinglehitweapon(_id_F4E6D9AFE1E11685.basename) || _id_2669878CF5A1B6BC::isminigunweapon(_id_F4E6D9AFE1E11685) || !_id_A364B6E4DC3CC30A(_id_F4E6D9AFE1E11685) || _id_F4E6D9AFE1E11685.basename == "iw8_lm_dblmg_mp" || _id_F4E6D9AFE1E11685.basename == "iw9_me_fists_mp") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");

    return 0;
  }

  result = scripts\mp\supers\super_stoppingpower::stoppingpower_cancelreload();

  if(!istrue(result))
    return 0;

  _id_ED3C1A651B014773(_id_F4E6D9AFE1E11685);
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_suppression_rounds", 0);
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "equipment_deployed");
  return 1;
}

_id_B2D2056EE8B00689() {}

_id_A364B6E4DC3CC30A(objweapon) {
  if(!self isalternatemode(objweapon))
    return 1;

  underbarrel = objweapon.underbarrel;
  return scripts\mp\weapons::isattachmentselectfire(objweapon, underbarrel);
}

_id_ED3C1A651B014773(_id_F4E6D9AFE1E11685) {
  self endon("death_or_disconnect");
  level endon("game_ended");

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
      _id_FB3893B4CBDDC190 = clipammo * 2;

      if(isakimbo)
        _id_FB3893B4CBDDC190 = _id_FB3893B4CBDDC190 * 2;

      _id_588EAA2556C4172C(self, weaponobj, _id_FB3893B4CBDDC190);

      if(1) {
        if(isakimbo) {
          clipammo = self getweaponammoclip(weaponobj, "left") + self getweaponammoclip(weaponobj, "right");
          stockammo = self getweaponammostock(weaponobj);
          _id_7474313B0EF773B4 = clipammo + stockammo;
          _id_2AA9CAEF99C9AF77 = int(min(weaponmaxammo(weaponobj), _id_7474313B0EF773B4 + _id_FB3893B4CBDDC190));
          self setweaponammostock(weaponobj, _id_2AA9CAEF99C9AF77);
          self setweaponammoclip(weaponobj, 0, "left");
          self setweaponammoclip(weaponobj, 0, "right");
        } else {
          clipammo = self getweaponammoclip(weaponobj);
          stockammo = self getweaponammostock(weaponobj);
          _id_7474313B0EF773B4 = clipammo + stockammo;
          maxammo = weaponmaxammo(weaponobj);
          _id_AED95A39B937C353 = _id_7474313B0EF773B4 + _id_FB3893B4CBDDC190;
          _id_C88113BFEDD68CF0 = int(_id_AED95A39B937C353 - maxammo);
          _id_5B3F7D686C59AB97 = int(min(maxammo, _id_AED95A39B937C353));

          if(weaponobj.basename == "iw8_lm_dblmg_mp")
            self setweaponammoclip(weaponobj, clipammo + _id_FB3893B4CBDDC190);
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

  thread _id_3C8A31CA9D26E8A3(_id_F4E6D9AFE1E11685, stockammo, _id_C88113BFEDD68CF0);
  return 1;
}

_id_3C8A31CA9D26E8A3(weaponobj, stockammo, _id_C88113BFEDD68CF0) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    if(self getcurrentprimaryweapon() != weaponobj) {
      break;
    }

    _id_B971E09CE070BD58 = self getweaponammoclip(weaponobj);

    if(_id_B971E09CE070BD58 > 0) {
      thread scripts\mp\hud_message::showsplash("suppression_rounds_activated", undefined, self);

      if(_id_C88113BFEDD68CF0 > 0)
        self setweaponammostock(weaponobj, stockammo + _id_C88113BFEDD68CF0);

      break;
    }

    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
}

_id_588EAA2556C4172C(player, objweapon, _id_045ACD1D2458698A) {
  _id_2468893FC27DE6F6 = spawnStruct();
  _id_2468893FC27DE6F6.player = player;
  _id_2468893FC27DE6F6.objweapon = objweapon;
  _id_2468893FC27DE6F6.rounds = _id_045ACD1D2458698A;
  _id_2468893FC27DE6F6._id_6D8006AF92216F09 = 0;
  _id_2468893FC27DE6F6.kills = 0;
  _id_404622FAFF469EF4(player, _id_2468893FC27DE6F6);
}

_id_2AB57FFD17E456DC() {
  _id_23CC182D2553796A = self._id_096A36C88EB0E59B;

  foreach(perk in _id_23CC182D2553796A)
  scripts\mp\utility\perk::giveperk(perk);
}

_id_D086A58C4A276AB7() {
  _id_23CC182D2553796A = self._id_096A36C88EB0E59B;

  foreach(perk in _id_23CC182D2553796A) {
    if(scripts\mp\utility\perk::_hasperk(perk))
      scripts\mp\utility\perk::removeperk(perk);
  }
}

_id_78A297C602BCF14B() {
  _id_23CC182D2553796A = self._id_096A36C88EB0E59B;

  if(!isDefined(_id_23CC182D2553796A))
    return 0;

  _id_C81D87C234523F81 = 1;

  foreach(perk in _id_23CC182D2553796A) {
    if(!scripts\mp\utility\perk::_hasperk(perk)) {
      _id_C81D87C234523F81 = 0;
      break;
    }
  }

  return _id_C81D87C234523F81;
}

_id_404622FAFF469EF4(player, _id_2468893FC27DE6F6) {
  if(!isDefined(player._id_2468893FC27DE6F6))
    player._id_2468893FC27DE6F6 = [];

  if(!isDefined(player._id_096A36C88EB0E59B))
    player._id_096A36C88EB0E59B = ["specialty_bulletsuppress", "specialty_bulletpenetration", "specialty_armorpiercingks", "specialty_fastreload"];

  id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(_id_2468893FC27DE6F6.objweapon);
  _id_42D837D1BF3797D3 = player._id_2468893FC27DE6F6[id];

  if(isDefined(_id_42D837D1BF3797D3))
    _id_42D837D1BF3797D3 thread _id_D00D87BD624BE09B();

  player._id_2468893FC27DE6F6[id] = _id_2468893FC27DE6F6;
  _id_2468893FC27DE6F6 thread _id_FF064EF6BE86CAFD();
  _id_2468893FC27DE6F6 thread _id_B62388FEECC84E15();
  _id_2468893FC27DE6F6 thread _id_3228D2697DAB3222();
  _id_2468893FC27DE6F6 thread _id_6831E37D3D71C426();
  _id_2468893FC27DE6F6 thread _id_0F12640F75796066();
  player thread _id_1A941C69EE952E0D();
}

_id_1DA49FB6441F8AB2() {
  _id_2468893FC27DE6F6 = _id_8343403D68C45F63(self getcurrentweapon());
  return isDefined(_id_2468893FC27DE6F6) && istrue(_id_2468893FC27DE6F6._id_6D8006AF92216F09);
}

_id_07DA2A2F573CF8D9(_id_614411B9142BD852, _id_2CA201D5906CDBA5, weaponobj) {
  if(!isDefined(_id_614411B9142BD852) || !isDefined(_id_2CA201D5906CDBA5)) {
    return;
  }
  _id_2468893FC27DE6F6 = _id_2CA201D5906CDBA5 _id_8343403D68C45F63(weaponobj);
  _id_614411B9142BD852._id_2468893FC27DE6F6 = _id_2468893FC27DE6F6;
}

_id_AFC54FC21DFDC776(_id_614411B9142BD852, _id_480F8576BE141BB4, weaponobj) {
  if(!isDefined(_id_614411B9142BD852._id_2468893FC27DE6F6)) {
    return;
  }
  _id_2468893FC27DE6F6 = _id_614411B9142BD852._id_2468893FC27DE6F6;
  _id_2468893FC27DE6F6.player = _id_480F8576BE141BB4;
  _id_2468893FC27DE6F6._id_6D8006AF92216F09 = 0;
  _id_2468893FC27DE6F6.kills = 0;
  _id_404622FAFF469EF4(_id_480F8576BE141BB4, _id_2468893FC27DE6F6);
}

_id_8343403D68C45F63(objweapon) {
  if(!isDefined(objweapon))
    return undefined;

  if(!isDefined(self._id_2468893FC27DE6F6))
    return undefined;

  id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(objweapon);
  return self._id_2468893FC27DE6F6[id];
}

_id_6831E37D3D71C426() {
  self endon("suppressionRounds_removeAPR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    if(_id_8E06333F166199E3(self.player getcurrentweapon())) {
      if(!self._id_6D8006AF92216F09) {
        self.player _id_2AB57FFD17E456DC();
        self._id_6D8006AF92216F09 = 1;
      }
    } else if(self._id_6D8006AF92216F09) {
      self.player _id_D086A58C4A276AB7();
      self._id_6D8006AF92216F09 = 0;
    }

    self.player waittill("weapon_change");
  }

  thread _id_D00D87BD624BE09B();
}

_id_0F12640F75796066() {
  self endon("suppressionRounds_removeAPR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("weapon_fired", objweapon);

    if(_id_8E06333F166199E3(objweapon)) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  self.player thread _id_15338821A605345D(self.objweapon);
  thread _id_D00D87BD624BE09B();
}

_id_15338821A605345D(objweapon) {
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

_id_D00D87BD624BE09B() {
  self notify("suppressionRounds_removeAPR");

  if(isDefined(self.player)) {
    if(self._id_6D8006AF92216F09)
      self.player _id_D086A58C4A276AB7();

    _id_014FF80858876E74();
  }
}

_id_860D63C693C454F5() {
  self notify("suppressionRounds_removeAPR");

  if(isDefined(self.player))
    _id_014FF80858876E74();
}

_id_014FF80858876E74() {
  if(isDefined(self.player._id_2468893FC27DE6F6)) {
    id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(self.objweapon);
    _id_2468893FC27DE6F6 = self.player._id_2468893FC27DE6F6[id];

    if(isDefined(_id_2468893FC27DE6F6) && _id_2468893FC27DE6F6 == self)
      self.player._id_2468893FC27DE6F6[id] = undefined;

    if(isDefined(self.player.super) && isDefined(self.player.super._id_DB8424389DCBBE9B)) {
      self.player scripts\cp_mp\challenges::_id_D997435895422ECC("super_suppression_rounds", 3, self.player.super._id_DB8424389DCBBE9B);
      self.player.super._id_DB8424389DCBBE9B = undefined;
    }

    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["super_suppression_rounds"].id, self.kills, 0);
  }
}

_id_8F9A9C04E9E4B5AF(weaponobj) {
  if(isDefined(weaponobj)) {
    id = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(weaponobj);
    _id_2468893FC27DE6F6 = self._id_2468893FC27DE6F6[id];

    if(isDefined(_id_2468893FC27DE6F6)) {
      scripts\mp\utility\stats::incpersstat("suppressionRoundsKills", 1);
      scripts\mp\supers::combatrecordsuperkill("super_suppression_rounds");
      _id_2468893FC27DE6F6.kills++;
    }
  }
}

_id_8E06333F166199E3(objweapon) {
  _id_C1711FE638727118 = self.player getammotype(self.objweapon);
  _id_49A4190715712F10 = self.player getammotype(objweapon);
  _id_9438D6B1D63250F7 = _id_C1711FE638727118 == _id_49A4190715712F10;
  return issameweapon(objweapon, self.objweapon, 1) && _id_9438D6B1D63250F7;
}

_id_FF064EF6BE86CAFD() {
  self.player endon("disconnect");
  self endon("suppressionRounds_removeAPR");
  self.player waittill("death");
  thread _id_D00D87BD624BE09B();
}

_id_B62388FEECC84E15() {
  self.player endon("disconnect");
  self endon("suppressionRounds_removeAPR");
  level waittill("game_ended");
  thread _id_D00D87BD624BE09B();
}

_id_3228D2697DAB3222() {
  self.player endon("disconnect");
  self endon("suppressionRounds_removeAPR");
  self.player waittill("all_perks_cleared");
  thread _id_860D63C693C454F5();
}

_id_8F57FB80F166C568() {
  self.player endon("death_or_disconnect");
  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self.player scripts\engine\utility::waittill_any_3("weapon_fired", "weapon_change", "suppressionRounds_removeAPR");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
}

_id_1A941C69EE952E0D() {
  self endon("death_or_disconnect");
  _id_3B64EB40368C1450::set("suppressionRounds", "sprint", 0);
  wait 0.4;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("suppressionRounds");
}