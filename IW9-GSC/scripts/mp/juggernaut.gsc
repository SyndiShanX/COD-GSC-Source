/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\juggernaut.gsc
***********************************************/

init() {
  level.activejuggernauts = [];
  level._id_ED61C38F5C8BB414 = ["pristine", "damaged"];
  level._id_13819795C6EE9FF8 = ["helmet", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];
}

jugg_makejuggernaut(juggconfig, streakinfo) {
  _id_7A377F8D3F83484D = _id_A5AF0A72AC912A3D(juggconfig);

  if(!isDefined(_id_7A377F8D3F83484D)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/JUGG_CANNOT_BECOME");
    return 0;
  }

  _id_8A867002DF857D70 = _id_7A377F8D3F83484D != self getstance();
  self.isjuggernaut = 1;
  scripts\mp\battlechatter_mp::disablebattlechatter(self);
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
  juggcontext = spawnStruct();
  juggcontext.juggconfig = juggconfig;
  juggcontext.prevhealth = self.health;
  juggcontext.prevmaxhealth = self.maxhealth;
  juggcontext.prevbody = self getcustomizationbody();
  juggcontext.prevhead = self getcustomizationhead();
  juggcontext.prevviewmodel = self getcustomizationviewmodel();
  juggcontext.prevspeedscale = self.playerstreakspeedscale;
  juggcontext.prevsuit = self.suit;
  juggcontext.prevclothtype = self.clothtype;
  juggcontext._id_AAAC4CD2DA0AA927 = self.operatorcustomization._id_400EF51562606E7A;
  juggcontext.maskomnvar = "ui_gas_mask_juggernaut";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution))
    juggcontext._id_1FA2A9CA3621008A = self.operatorcustomization.execution;

  juggcontext._id_46AD94F231CD4EF3 = [];
  juggcontext._id_46AD94F231CD4EF3["head_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_CCEF760095A8D026), juggconfig._id_CCEF760095A8D026, 100);
  juggcontext._id_46AD94F231CD4EF3["torso_upper_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_033A458EBB314026), juggconfig._id_033A458EBB314026, 100);
  juggcontext._id_46AD94F231CD4EF3["torso_lower_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_6517BCADB9E33B21), juggconfig._id_6517BCADB9E33B21, 100);
  juggcontext._id_46AD94F231CD4EF3["right_upper_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_98C8EB9D039DFAA2), juggconfig._id_98C8EB9D039DFAA2, 100);
  juggcontext._id_46AD94F231CD4EF3["right_lower_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_6493D470BCAF2469), juggconfig._id_6493D470BCAF2469, 100);
  juggcontext._id_46AD94F231CD4EF3["left_upper_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_FE7B1A75B71D65B5), juggconfig._id_FE7B1A75B71D65B5, 100);
  juggcontext._id_46AD94F231CD4EF3["left_lower_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_CCDC04703862490A), juggconfig._id_CCDC04703862490A, 100);
  juggcontext._id_46AD94F231CD4EF3["right_leg_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_196A36E4DE8891F5), juggconfig._id_196A36E4DE8891F5, 100);
  juggcontext._id_46AD94F231CD4EF3["left_leg_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_B74A139EF1F10A8A), juggconfig._id_B74A139EF1F10A8A, 100);
  juggcontext._id_5F7BA6B850DED645 = ["execution_mp_juggernaut_01", "execution_mp_juggernaut_02", "execution_mp_juggernaut_03"];
  self._id_0A23031C04DF01BF = ::_id_4217F11FFB352425;
  self.maxhealth = juggconfig.maxhealth;
  self.health = juggconfig.startinghealth;
  self._id_59651A2893429638 = 0;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(isDefined(level.clearbrinventory))
    self[[level.clearbrinventory]]();

  if(isDefined(juggconfig.classstruct)) {
    respawnitems = scripts\mp\class::respawnitems_saveplayeritemstostruct();
    juggcontext.respawnitems = respawnitems;
    juggcontext.prevclass = self.lastclass;
    juggcontext.prevclassstruct = self.classstruct;
    scripts\mp\class::loadout_updateclass(juggconfig.classstruct, "juggernaut");
    scripts\mp\class::preloadandqueueclassstruct(juggconfig.classstruct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "juggernaut", 0, 1);
  }

  self.lastdroppableweaponobj = undefined;

  foreach(perk, _id_97282C14346A7FCF in juggconfig.perks)
  scripts\mp\utility\perk::giveperk(perk);

  if(istrue(self.pickedupcoreminigun)) {
    _id_3B64EB40368C1450::_id_588F2307A3040610("fakeJugg");
    self.pickedupcoreminigun = undefined;
  }

  jugg_toggleallows(juggconfig.allows, 0);
  self skydive_setbasejumpingstatus(0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  jugg_setModel();
  self.playerstreakspeedscale = juggconfig.movespeedscalar;
  scripts\mp\weapons::updatemovespeedscale();
  self.juggcontext = juggcontext;
  scripts\mp\utility\player::_setsuit(juggconfig.suit);
  self setclothtype(juggconfig.clothtype);
  self _meth_8ABE5A968CC3C220(juggconfig._id_400EF51562606E7A);
  jugg_enableoverlay(juggcontext);
  scripts\cp_mp\utility\killstreak_utility::_id_3F55C1FB553A4775(self);

  if(getdvarint("dvar_4F7DA19A233D6916", 0))
    _id_551E4A3BB31658BC(juggcontext.juggconfig.execution);

  if(juggconfig.infiniteammo)
    thread scripts\mp\utility\weapon::infiniteammothread(juggconfig.infiniteammoupdaterate, undefined, 1);
  else {
    _id_8CAC01EF5BCB1816 = self getweaponslistall();

    foreach(weapon in _id_8CAC01EF5BCB1816) {
      if(!_id_0A585B2993726D3B(juggconfig, weapon.basename)) {
        continue;
      }
      self setweaponammoclip(weapon, weaponclipsize(weapon));

      if(jugg_canreload()) {
        self givemaxammo(weapon);
        thread jugg_managestockammo(weapon);
      }
    }
  }

  self.streakinfo = streakinfo;
  self notify("juggernaut_start");
  thread scripts\mp\gameobjects::onjuggernaut();
  thread jugg_watchmusictoggle();
  thread jugg_watchfordeath();
  thread jugg_watchforgameend();
  thread jugg_watchfordisconnect();
  thread jugg_watchforfire();
  thread jugg_watchherodrop();
  thread _id_5B7C34DBC50C3C4E();
  thread jugg_watchoverlaydamagestates(self.juggcontext);
  thread jugg_watchforoverlayexecutiontoggle();
  thread _id_24B195A997FE1263();

  if(jugg_canparachute()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
    self skydive_cutparachuteon();
  }

  if(isDefined(level.addjuggfunctionality))
    self[[level.addjuggfunctionality]]();

  if(_id_8A867002DF857D70)
    self setstance(_id_7A377F8D3F83484D);

  _id_6A5D3BF7A5B7064A::onexitdeathsdoor(1);
  jugg_addtoactivejugglist();
  _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(2, "juggernautEquipped");
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "become_juggernaut");
  return 1;
}

jugg_removejuggernaut() {
  if(!isDefined(self)) {
    return;
  }
  self notify("juggernaut_end");
  juggcontext = self.juggcontext;
  juggconfig = juggcontext.juggconfig;
  self.musicplaying = undefined;
  self._id_0A23031C04DF01BF = undefined;
  self._id_59651A2893429638 = undefined;
  jugg_disableoverlay(juggcontext);
  jugg_toggleallows(juggconfig.allows, 1);
  scripts\cp_mp\utility\killstreak_utility::_id_17576A4CDCD447A7(self);

  if(scripts\mp\utility\player::isreallyalive(self)) {
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

    if(isDefined(juggconfig.classstruct)) {
      scripts\mp\class::respawnitems_assignrespawnitems(juggcontext.respawnitems);
      scripts\mp\class::giveloadout(self.team, juggcontext.prevclass, 0, 1, 1);
    }

    foreach(perk, _id_97282C14346A7FCF in juggconfig.perks)
    scripts\mp\utility\perk::removeperk(perk);
  }

  if(juggconfig.infiniteammo)
    scripts\mp\utility\weapon::stopinfiniteammothread();

  jugg_restoremodel(juggcontext);
  self.playerstreakspeedscale = juggcontext.prevspeedscale;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\player::_setsuit(juggcontext.prevsuit);
  self setclothtype(juggcontext.prevclothtype);
  self _meth_8ABE5A968CC3C220(juggcontext._id_AAAC4CD2DA0AA927);
  self setscriptablepartstate("juggernaut", "neutral", 0);

  if(isDefined(juggcontext._id_1FA2A9CA3621008A))
    scripts\cp_mp\execution::_giveexecution(juggcontext._id_1FA2A9CA3621008A);

  if(jugg_canparachute()) {
    self skydive_setbasejumpingstatus(0);
    self skydive_setdeploymentstatus(0);
    self skydive_cutparachuteoff();
  }

  self.isjuggernaut = 0;
  self.juggcontext = undefined;
  self.streakinfo = undefined;
  scripts\mp\battlechatter_mp::enablebattlechatter(self);
}

jugg_createconfig(_id_D493BD7620FA1AF0, _id_ED0B84B88196CCA6) {
  config = spawnStruct();
  config.maxhealth = 3000;
  config.startinghealth = config.maxhealth;
  config.movespeedscalar = -0.2;
  config.maxvehicledamagedivisor = 5;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    config.maxvehicledamagedivisor = 3;

  config.forcetostand = 1;
  config.suit = "iw9_juggernaut_mp";
  config.infiniteammo = 0;
  config.infiniteammoupdaterate = undefined;
  config.classstruct = jugg_getdefaultclassstruct();
  config.allows = [];
  config.allows["stick_kill"] = 1;
  config.allows["health_regen"] = 1;
  config.allows["one_hit_melee_victim"] = 1;
  config.allows["flashed"] = 1;
  config.allows["stunned"] = 1;
  config.allows["prone"] = 1;
  config.allows["equipment_primary"] = 1;
  config.allows["equipment_secondary"] = 1;
  config.allows["supers"] = 1;
  config.allows["killstreaks"] = 1;
  config.allows["slide"] = 1;
  config.allows["weapon_pickup"] = 1;
  config.allows["execution_victim"] = 1;
  config.allows["cough_gesture"] = 1;
  config.allows["offhand_throwback"] = 1;
  config.perks = [];
  config.perks["specialty_stun_resistance"] = 1;
  config.perks["specialty_sharp_focus"] = 1;
  config.perks["specialty_melee_resist"] = 1;
  config.perks["specialty_blastshield"] = 1;
  config.perks["specialty_armorpiercing"] = 1;
  return config;
}

jugg_toggleallows(allows, _id_9BBACB179DEA3237) {
  if(!_id_9BBACB179DEA3237) {
    foreach(_id_F36A1AE440B2A250, used in allows) {
      if(used) {
        _id_F36A1AE440B2A250 = tolower(_id_F36A1AE440B2A250);
        _id_3B64EB40368C1450::set("juggernaut", _id_F36A1AE440B2A250, 0);
      }
    }
  }

  if(!istrue(level.disablemount)) {
    if(!_id_9BBACB179DEA3237) {
      _id_3B64EB40368C1450::set("juggernaut", "mount_top", 0);
      _id_3B64EB40368C1450::set("juggernaut", "mount_side", 0);
    } else
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("juggernaut");
  }
}

jugg_getdefaultclassstruct() {
  classstruct = scripts\mp\class::loadout_getclassstruct();
  classstruct.loadoutarchetype = "archetype_assault";
  classstruct.loadoutprimary = "iw9_minigunksjugg_mp";
  classstruct.loadoutsecondary = "iw9_pi_golf18_mp";
  return classstruct;
}

jugg_watchmusictoggle() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  _id_0ADFB98EEAB072EA = 0;

  if(!isbot(self) && !isagent(self)) {
    self notifyonplayercommand("toggle_music", "+actionslot 3");
    self notifyonplayercommand("toggle_music", "killstreak_wheel");
  }

  _id_E5C8D9D7E001AF68 = makeweapon("ks_gesture_jugg_music_mp");
  _id_8E47447445C817E5 = weaponfiretime(_id_E5C8D9D7E001AF68);

  if(!isDefined(self.musicplaying)) {
    _id_AA73BA383F8079EA = self getjuggdefaultmusicenabled();
    self.musicplaying = _id_AA73BA383F8079EA;
  }

  if(!istrue(self.musicplaying))
    self setscriptablepartstate("juggernaut", "neutral", 0);
  else if(isDefined(level.music_style) && level.music_style == "mexico")
    self setscriptablepartstate("juggernaut", "music_mx", 0);
  else
    self setscriptablepartstate("juggernaut", "music", 0);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    self setclientomnvar("ui_enable_juggernaut_music", istrue(self.musicplaying));

  for(;;) {
    self waittill("toggle_music");

    if(self isonladder() || self ismantling()) {
      continue;
    }
    self giveandfireoffhand(_id_E5C8D9D7E001AF68);
    self playsoundonmovingent("mp_jugg_mus_toggle_foley");
    self playlocalsound("mp_jugg_mus_toggle_button");
    _id_6E79FBF50C8EA64F = 0.2;

    if(istrue(self.musicplaying))
      _id_6E79FBF50C8EA64F = 0.65;

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_6E79FBF50C8EA64F);

    if(istrue(self.musicplaying)) {
      self.musicplaying = 0;
      self setscriptablepartstate("juggernaut", "neutral", 0);
    } else {
      self.musicplaying = 1;

      if(isDefined(level.music_style) && level.music_style == "mexico")
        self setscriptablepartstate("juggernaut", "music_mx", 0);
      else
        self setscriptablepartstate("juggernaut", "music", 0);
    }

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      self setclientomnvar("ui_enable_juggernaut_music", istrue(self.musicplaying));

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

jugg_watchfordeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  childthread jugg_removejuggernaut();
}

jugg_watchforgameend() {
  self endon("disconnect");
  self endon("juggernaut_end");
  juggcontext = self.juggcontext;
  level waittill("game_ended");
  self.maxhealth = juggcontext.prevmaxhealth;
  self.health = juggcontext.prevhealth;
  jugg_disableoverlay(juggcontext);
  self setscriptablepartstate("juggernaut", "neutral", 0);
}

jugg_watchfordisconnect() {
  self endon("juggernaut_end");
  juggcontext = self.juggcontext;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;
  }
}

jugg_watchforfire() {
  self endon("juggernaut_end");

  for(;;) {
    self waittill("weapon_fired");

    if(isDefined(self.streakinfo) && isDefined(self.streakinfo.shots_fired))
      self.streakinfo.shots_fired++;
  }
}

jugg_getjuggmodels() {
  models = [];
  models["body"] = "body_sp_opforce_aq_jugg_basebody";
  models["head"] = "head_sp_opforce_aq_jugg";
  _id_5C3A750620DB3A3F = "mp_vm_arms_jugg_aq_iw9_1_1";

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1)
    _id_5C3A750620DB3A3F = "mp_vm_arms_jugg_shadow_iw9_1_1";

  models["view"] = _id_5C3A750620DB3A3F;
  return models;
}

jugg_setModel() {
  models = jugg_getjuggmodels();

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  bodymodelname = models["body"];
  headmodelname = models["head"];
  _id_41BD2EEDA1C033D2 = models["view"];
  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);
  self attach(headmodelname, "", 1);
  self.headmodel = headmodelname;
}

jugg_restoremodel(juggcontext) {
  self.operatorcustomization = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self setcustomization(juggcontext.prevbody, juggcontext.prevhead);
    scripts\mp\teams::setcharactermodels(juggcontext.prevbody, juggcontext.prevhead, juggcontext.prevviewmodel);
  }
}

_id_A5AF0A72AC912A3D(juggconfig) {
  _id_7A377F8D3F83484D = undefined;
  _id_6497396FB64EA3B9 = self getstance();

  if(_id_6497396FB64EA3B9 != "stand") {
    _id_D906346CAB6E17C8 = !istrue(juggconfig.forcetostand) && !isDefined(juggconfig.allows["crouch"]) || istrue(juggconfig.allowcrouch);
    _id_6900F3419D3C4DD0 = !istrue(juggconfig.forcetostand) && !isDefined(juggconfig.allows["prone"]) || istrue(juggconfig.allowprone);
    contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 0);

    if(!_id_D906346CAB6E17C8 && !_id_6900F3419D3C4DD0)
      _id_7A377F8D3F83484D = "stand";
    else if(_id_6497396FB64EA3B9 == "crouch") {
      if(!_id_D906346CAB6E17C8) {
        _id_775BD34DFD0C192F = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::getstancetop("stand"), self, contentoverride);

        if(_id_775BD34DFD0C192F)
          _id_7A377F8D3F83484D = "stand";
      } else
        _id_7A377F8D3F83484D = "crouch";
    } else if(_id_6497396FB64EA3B9 == "prone") {
      if(!_id_6900F3419D3C4DD0) {
        if(_id_D906346CAB6E17C8) {
          _id_2030158F5EB8B187 = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::getstancetop("crouch"), self, contentoverride);

          if(_id_2030158F5EB8B187)
            _id_7A377F8D3F83484D = "crouch";
        } else {
          _id_775BD34DFD0C192F = scripts\engine\trace::ray_trace_passed(self.origin, scripts\mp\utility\player::getstancetop("stand"), self, contentoverride);

          if(_id_775BD34DFD0C192F)
            _id_7A377F8D3F83484D = "stand";
        }
      } else
        _id_7A377F8D3F83484D = "prone";
    }
  } else
    _id_7A377F8D3F83484D = "stand";

  return _id_7A377F8D3F83484D;
}

jugg_watchoverlaydamagestates(juggcontext) {
  self endon("juggernaut_end");
  self endon("death or disconnect");
  level endon("game_ended");
  startinghealth = self.health;
  _id_4EB5162696BAFF69 = startinghealth - startinghealth * 0.1;
  _id_5C8E464293ED834C = startinghealth - startinghealth * 0.35;
  _id_EED2946CC87372BB = startinghealth - startinghealth * 0.6;
  _id_1F9CEBCA13994806 = startinghealth - startinghealth * 0.85;
  _id_654EBA19046746E8 = 1;
  _id_EA0A3076FB747A79 = _id_654EBA19046746E8;
  _id_4F287978D27B5156 = "mask_on";

  for(;;) {
    scripts\engine\utility::waittill_any_2("damage", "jugg_health_regen");

    if(self.health <= _id_1F9CEBCA13994806) {
      _id_4F287978D27B5156 = "mask_damage_critical";
      _id_654EBA19046746E8 = 5;
    } else if(self.health <= _id_EED2946CC87372BB) {
      _id_4F287978D27B5156 = "mask_damage_high";
      _id_654EBA19046746E8 = 4;
    } else if(self.health <= _id_5C8E464293ED834C) {
      _id_4F287978D27B5156 = "mask_damage_med";
      _id_654EBA19046746E8 = 3;
    } else if(self.health <= _id_4EB5162696BAFF69) {
      _id_4F287978D27B5156 = "mask_damage_low";
      _id_654EBA19046746E8 = 2;
    } else {
      _id_4F287978D27B5156 = "mask_on";
      _id_654EBA19046746E8 = 1;
    }

    if(_id_EA0A3076FB747A79 != _id_654EBA19046746E8) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", _id_4F287978D27B5156);
      self setclientomnvar(juggcontext.maskomnvar, _id_654EBA19046746E8);
      _id_EA0A3076FB747A79 = _id_654EBA19046746E8;
      self.juggoverlaystatelabel = _id_4F287978D27B5156;
      self.juggoverlaystate = _id_654EBA19046746E8;
    }
  }
}

jugg_watchforoverlayexecutiontoggle() {
  self endon("juggernaut_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  juggcontext = self.juggcontext;
  _id_2BF9392CAB435CDF = 0;

  for(;;) {
    if(!self isinexecutionattack()) {
      if(istrue(_id_2BF9392CAB435CDF)) {
        jugg_enableoverlay(juggcontext);
        _id_2BF9392CAB435CDF = 0;

        if(getdvarint("dvar_4F7DA19A233D6916", 0))
          _id_551E4A3BB31658BC("random");
      }

      waitframe();
      continue;
    }

    if(!istrue(_id_2BF9392CAB435CDF)) {
      jugg_disableoverlay(juggcontext, 1);
      _id_2BF9392CAB435CDF = 1;
    }

    waitframe();
  }
}

_id_E657BB1FE2EF34A8() {
  juggcontext = self.juggcontext;
  _id_F58302A7CF2E40E4 = self._id_3BE02516D5F4BFF0;
  _id_986A24725E33212A = [];

  foreach(execution in juggcontext._id_5F7BA6B850DED645) {
    if(isDefined(_id_F58302A7CF2E40E4) && execution == _id_F58302A7CF2E40E4) {
      continue;
    }
    _id_986A24725E33212A[_id_986A24725E33212A.size] = execution;
  }

  _id_BF6A09A02219215D = _id_986A24725E33212A[randomint(_id_986A24725E33212A.size)];

  if(!isDefined(_id_BF6A09A02219215D))
    _id_BF6A09A02219215D = _id_F58302A7CF2E40E4;

  return _id_BF6A09A02219215D;
}

_id_551E4A3BB31658BC(executionref) {
  juggcontext = self.juggcontext;
  _id_329DD2016317E381 = executionref;

  if(!isDefined(_id_329DD2016317E381) || executionref == "random")
    _id_329DD2016317E381 = _id_E657BB1FE2EF34A8();

  scripts\cp_mp\execution::_giveexecution(_id_329DD2016317E381);
  self._id_3BE02516D5F4BFF0 = _id_329DD2016317E381;
}

_id_24B195A997FE1263() {
  self endon("disconnect");
  self endon("juggernaut_end");
  config = self.juggcontext.juggconfig;
  _id_350710EA016EAC45 = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845(config.classstruct.loadoutsecondary);
  _id_51AB77B2BA57C5DD = 0;

  for(;;) {
    if(self _meth_E40102956C887F7C()) {
      if(!istrue(_id_51AB77B2BA57C5DD)) {
        scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_350710EA016EAC45, undefined, undefined, 1);
        self switchtoweaponimmediate(_id_350710EA016EAC45);
        _id_51AB77B2BA57C5DD = 1;
      }
    } else if(istrue(_id_51AB77B2BA57C5DD)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_350710EA016EAC45);
      self switchtoweaponimmediate(jugg_getminigunweapon());
      _id_51AB77B2BA57C5DD = 0;
    }

    wait 0.05;
  }
}

jugg_enableoverlay(juggcontext, forcereset) {
  self notify("jugg_mask_on");

  if(!isDefined(self.juggoverlaystatelabel) && !isDefined(self.juggoverlaystate) || istrue(forcereset)) {
    self.juggoverlaystatelabel = "mask_on";
    self.juggoverlaystate = 1;
  }

  self setclientomnvar("ui_assault_suit_on", 0);
  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
  self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
}

jugg_disableoverlay(juggcontext, _id_A2C3DD1BE38A2035) {
  self notify("jugg_mask_off");

  if(!istrue(_id_A2C3DD1BE38A2035)) {
    self.juggoverlaystatelabel = undefined;
    self.juggoverlaystate = undefined;
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  self setclientomnvar(juggcontext.maskomnvar, 0);
}

jugg_getmovespeedscalar() {
  return -0.2;
}

jugg_getminigunweapon() {
  _id_791C14FBD0F3282D = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845(self.juggcontext.juggconfig.classstruct.loadoutprimary);
  return _id_791C14FBD0F3282D;
}

jugg_canreload() {
  return istrue(self.juggcontext.juggconfig.usereload);
}

jugg_canuseweaponpickups() {
  return istrue(self.juggcontext.juggconfig.useweaponpickups);
}

jugg_managestockammo(weapon) {
  self endon("juggernaut_end");
  level endon("game_ended");
  stockammo = self getweaponammostock(weapon);
  thread jugg_watchmanualreload(weapon, stockammo);
  thread jugg_watchammo(weapon, stockammo);

  for(;;) {
    self waittill("minigun_restock");
    self setweaponammostock(weapon, stockammo);
  }
}

jugg_watchmanualreload(weapon, _id_81C05719BD3DC08F) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");

  for(;;) {
    if(self reloadbuttonPressed()) {
      _id_9938D9499DF221D6 = self getweaponammostock(weapon);

      if(_id_9938D9499DF221D6 < _id_81C05719BD3DC08F)
        self notify("minigun_restock");
    }

    waitframe();
  }
}

jugg_watchammo(weapon, _id_81C05719BD3DC08F) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");

  for(;;) {
    _id_A3254571B0C90796 = self getweaponammoclip(weapon);

    if(_id_A3254571B0C90796 == 0) {
      _id_9938D9499DF221D6 = self getweaponammostock(weapon);

      if(_id_9938D9499DF221D6 < _id_81C05719BD3DC08F)
        self notify("minigun_restock");
    }

    waitframe();
  }
}

jugg_addtoactivejugglist() {
  if(!isDefined(level.activejuggernauts))
    level.activejuggernauts = [];

  level.activejuggernauts[level.activejuggernauts.size] = self;
  thread jugg_watchforremovejugg();
}

jugg_watchforremovejugg() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(["juggernaut_end", "disconnect"]);
  jugg_removefromactivejugglist();
}

jugg_removefromactivejugglist() {
  if(!isDefined(self))
    level.activejuggernauts = scripts\engine\utility::array_removeundefined(level.activejuggernauts);
  else
    level.activejuggernauts = scripts\engine\utility::array_remove(level.activejuggernauts, self);
}

jugg_watchherodrop() {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  juggconfig = self.juggcontext.juggconfig;
  juggconfig.herodrop = 0;

  for(;;) {
    thread _id_12928F267A4A789C(juggconfig);
    self waittill("perform_hero_drop");

    if(!istrue(juggconfig.herodrop)) {
      juggconfig.herodrop = 1;
      self radiusdamage(self.origin, 300, 2000, 500, self, "MOD_CRUSH");
      thread jugg_setherodropscriptable(juggconfig);
    }
  }
}

_id_12928F267A4A789C(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  self endon("perform_hero_drop");
  level endon("game_ended");
  _id_5DB2A98E8BF08146 = 0;
  _id_87BD779B6EB7EBB5 = 0.5;
  _id_696CA80DCDB269F8 = _id_87BD779B6EB7EBB5;
  _id_29C3E7E659EBD38C = getdvarint("bg_fallDamageMinHeight");

  if(!isDefined(_id_29C3E7E659EBD38C))
    _id_29C3E7E659EBD38C = 225;

  for(;;) {
    if(_id_BA71F6475F1C75D9()) {
      _id_696CA80DCDB269F8 = _id_696CA80DCDB269F8 - level.framedurationseconds;

      if(_id_696CA80DCDB269F8 <= 0) {
        _id_696CA80DCDB269F8 = 0;

        if(!istrue(_id_5DB2A98E8BF08146)) {
          _id_C2D7296C1D69DC0F = scripts\engine\trace::ray_trace_passed(self.origin, self.origin - (0, 0, _id_29C3E7E659EBD38C), self);

          if(istrue(_id_C2D7296C1D69DC0F)) {
            _id_5DB2A98E8BF08146 = 1;
            self setscriptablepartstate("heroDiveVfx", "falling", 0);
          }
        }
      }
    } else if(istrue(_id_5DB2A98E8BF08146) && !istrue(juggconfig.herodrop)) {
      _id_5DB2A98E8BF08146 = 0;
      _id_696CA80DCDB269F8 = _id_87BD779B6EB7EBB5;
      self setscriptablepartstate("heroDiveVfx", "off", 0);
    }

    waitframe();
  }
}

_id_BA71F6475F1C75D9() {
  if(self ismantling())
    return 0;

  if(self isonladder())
    return 0;

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
    return 0;

  if(!self isonground()) {
    if(self isparachuting())
      return 0;

    if(self _meth_E40102956C887F7C())
      return 0;

    return 1;
  }

  return 0;
}

jugg_setherodropscriptable(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
  juggconfig.herodrop = 0;
}

jugg_modifyfalldamage() {
  if(self isskydiving())
    self skydive_interrupt();

  self notify("perform_hero_drop");
  return 0;
}

jugg_modifyvehicletoplayerdamage(_id_F2C6D9B76591B40B, meansofdeath) {
  maxhealth = self.maxhealth;
  config = self.juggcontext.juggconfig;
  _id_5528888BDD4C85D6 = 0.5;
  _id_DB8996C1C1E56963 = 10;

  if(isDefined(meansofdeath) && isexplosivedamagemod(meansofdeath)) {
    _id_5528888BDD4C85D6 = 7;
    _id_DB8996C1C1E56963 = config.maxvehicledamagedivisor;
  }

  _id_CFC4CBFD4BF876C2 = _id_F2C6D9B76591B40B * _id_5528888BDD4C85D6;
  _id_5ECB2F54E00C220E = maxhealth / _id_DB8996C1C1E56963;
  _id_702BFC08FABD86CB = scripts\mp\utility\script::roundup(min(_id_5ECB2F54E00C220E, _id_CFC4CBFD4BF876C2));
  return int(_id_702BFC08FABD86CB);
}

jugg_modifyherodroptoplayerdamage(_id_F2C6D9B76591B40B) {
  return int(_id_F2C6D9B76591B40B / 2);
}

jugg_canparachute() {
  canparachute = 0;
  _id_68B25F2410254F22 = 0;

  if(_id_68B25F2410254F22 || scripts\mp\utility\game::gametypesupportsbasejumping() && scripts\mp\utility\game::mapsupportsbasejumping())
    canparachute = 1;

  return canparachute;
}

_id_8E6B2DE818370BAA(parts, state) {
  if(!isDefined(state)) {
    return;
  }
  _id_3D1C10F919CD5AF0 = [];

  if(isarray(parts))
    _id_3D1C10F919CD5AF0 = scripts\engine\utility::array_combine(_id_3D1C10F919CD5AF0, parts);
  else
    _id_3D1C10F919CD5AF0[_id_3D1C10F919CD5AF0.size] = parts;

  foreach(part in _id_3D1C10F919CD5AF0)
  self setscriptablepartstate(part, state, 0);
}

_id_4217F11FFB352425(damage, shitloc, smeansofdeath, attacker) {
  _id_1F48003B8E69560C = _id_C0AA811F7B45687C(shitloc, smeansofdeath, attacker);

  if(!isDefined(_id_1F48003B8E69560C)) {
    if(isDefined(attacker) && isDefined(shitloc) && isPlayer(attacker)) {}

    return;
  }

  _id_B47072BCD58C0C99(_id_1F48003B8E69560C, damage);
}

_id_C0AA811F7B45687C(shitloc, smeansofdeath, attacker) {
  _id_1F48003B8E69560C = undefined;

  if(scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "head_health";
  else if(scripts\cp_mp\utility\damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "torso_upper_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_77ED09D75C0C7165(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "torso_lower_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_24278EB0EC1E2953(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "right_upper_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_BF1EFC7185168448(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "right_lower_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_82850161196DF912(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "left_upper_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_D7395809E0049A49(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "left_lower_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_C0BD16DEEB47765B(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "right_leg_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_F15A47528FFFCE28(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "left_leg_health";

  return _id_1F48003B8E69560C;
}

_id_B47072BCD58C0C99(part, damage) {
  if(isDefined(self.juggcontext._id_5F03CAD2B199E1BC))
    self[[self.juggcontext._id_5F03CAD2B199E1BC]](part, damage);

  if(isDefined(self.juggcontext._id_46AD94F231CD4EF3[part])) {
    self.juggcontext._id_46AD94F231CD4EF3[part] = self.juggcontext._id_46AD94F231CD4EF3[part] - damage;

    if(part == "head_health") {
      if(self.juggcontext._id_46AD94F231CD4EF3[part] <= 0) {
        self.juggcontext._id_46AD94F231CD4EF3[part] = undefined;
        _id_8E6B2DE818370BAA(part, "destroyed");
      } else if(self.juggcontext._id_46AD94F231CD4EF3[part] <= 50)
        _id_8E6B2DE818370BAA(part, "damaged");
    } else if(self.juggcontext._id_46AD94F231CD4EF3[part] <= 0) {
      self.juggcontext._id_46AD94F231CD4EF3[part] = undefined;
      _id_8E6B2DE818370BAA(part, "damaged");
    }
  }
}

_id_5B7C34DBC50C3C4E() {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  _id_8E6B2DE818370BAA(level._id_13819795C6EE9FF8, "pristine");
}

_id_0A585B2993726D3B(config, weaponref) {
  if(!isDefined(weaponref) || weaponref == "none")
    return 0;

  if(isDefined(config.classstruct.loadoutprimary) && weaponref == config.classstruct.loadoutprimary)
    return 1;

  if(isDefined(config.classstruct.loadoutsecondary) && weaponref == config.classstruct.loadoutsecondary)
    return 1;

  return 0;
}