/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_juggernaut.gsc
***********************************************/

init() {
  level.activejuggernauts = [];
  level._id_ED61C38F5C8BB414 = ["pristine", "damaged"];
  level._id_13819795C6EE9FF8 = ["helmet", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];
}

jugg_makejuggernaut(juggconfig, streakinfo) {
  if(!jugg_canresolvestance(juggconfig))
    return 0;

  self.isjuggernaut = 1;
  self.can_revive = 0;
  self.streakinfo = streakinfo;
  self._id_7269DEEBA689CD65 = 1;
  self clearhudtutorialmessage();
  _id_56E7CF38A4910BA2 = _id_12E2FB553EC1605E::getoperatorcustomization();
  juggcontext = spawnStruct();
  juggcontext.juggconfig = juggconfig;
  juggcontext.prevhealth = self.health;
  juggcontext.prevmaxhealth = self.maxhealth;
  juggcontext.prevclothtype = self.clothtype;
  juggcontext._id_AAAC4CD2DA0AA927 = self._id_400EF51562606E7A;
  juggcontext.prevbody = _id_56E7CF38A4910BA2[0];
  juggcontext.prevhead = _id_56E7CF38A4910BA2[1];
  juggcontext.prevviewmodel = self getcustomizationviewmodel();
  juggcontext.prevspeedscale = self.playerstreakspeedscale;
  juggcontext.prevsuit = self.suit;
  juggcontext.prevstartingweap = scripts\cp\utility::getvalidtakeweapon();
  juggcontext.maskomnvar = "ui_gas_mask_juggernaut";
  juggcontext._id_CCEF760095A8D026 = scripts\engine\utility::ter_op(isDefined(juggconfig._id_CCEF760095A8D026), juggconfig._id_CCEF760095A8D026, 100);
  juggcontext._id_033A458EBB314026 = scripts\engine\utility::ter_op(isDefined(juggconfig._id_033A458EBB314026), juggconfig._id_033A458EBB314026, 100);
  juggcontext._id_6517BCADB9E33B21 = scripts\engine\utility::ter_op(isDefined(juggconfig._id_6517BCADB9E33B21), juggconfig._id_6517BCADB9E33B21, 100);
  juggcontext._id_98C8EB9D039DFAA2 = scripts\engine\utility::ter_op(isDefined(juggconfig._id_98C8EB9D039DFAA2), juggconfig._id_98C8EB9D039DFAA2, 100);
  juggcontext._id_6493D470BCAF2469 = scripts\engine\utility::ter_op(isDefined(juggconfig._id_6493D470BCAF2469), juggconfig._id_6493D470BCAF2469, 100);
  juggcontext._id_FE7B1A75B71D65B5 = scripts\engine\utility::ter_op(isDefined(juggconfig._id_FE7B1A75B71D65B5), juggconfig._id_FE7B1A75B71D65B5, 100);
  juggcontext._id_CCDC04703862490A = scripts\engine\utility::ter_op(isDefined(juggconfig._id_CCDC04703862490A), juggconfig._id_CCDC04703862490A, 100);
  juggcontext._id_196A36E4DE8891F5 = scripts\engine\utility::ter_op(isDefined(juggconfig._id_196A36E4DE8891F5), juggconfig._id_196A36E4DE8891F5, 100);
  juggcontext._id_B74A139EF1F10A8A = scripts\engine\utility::ter_op(isDefined(juggconfig._id_B74A139EF1F10A8A), juggconfig._id_B74A139EF1F10A8A, 100);
  juggcontext._id_5F7BA6B850DED645 = ["execution_mp_juggernaut_01", "execution_mp_juggernaut_02", "execution_mp_juggernaut_03"];
  self._id_0A23031C04DF01BF = ::_id_4217F11FFB352425;
  self.disabletakecoverwarning = 1;

  if(!istrue(streakinfo._id_CA56839B2E00EDCE)) {
    juggconfig.maxhealth = 3000;
    self.playerstreakspeedscale = juggconfig.movespeedscalar;
  } else {
    juggconfig.maxhealth = 400;
    self.playerstreakspeedscale = juggconfig._id_9A0CEA8101A4F35C;
  }

  self.jugg_health = juggconfig.maxhealth - juggcontext.prevmaxhealth;
  self.maxhealth = juggconfig.maxhealth;
  self.health = self.maxhealth;

  if(istrue(level.relic_vampire) || istrue(level.relic_healthpacks)) {
    _id_1DAB4A6BAD01C509 = self getentitynumber();
    _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerMaxHealth", self.maxhealth);
  }

  jugg_handlestancechange(juggconfig);

  if(isDefined(juggconfig.classstruct) && !istrue(streakinfo._id_CA56839B2E00EDCE))
    _id_F14F648C7F449690(juggcontext, juggconfig, 1);
  else {
    juggconfig.allows["reload"] = 0;
    juggconfig.allows["weapon_pickup"] = 0;
    juggconfig.allows["offhand_weapons"] = 0;
    juggconfig.allows["slide"] = 0;
    juggconfig.allows["supers"] = 0;
    juggconfig.allows["prone"] = 0;
    juggconfig.allows["killstreaks"] = 0;
    juggconfig.allows["usability"] = 0;
    self setclientomnvar("ui_assault_suit_on", 1);
    self._id_CA56839B2E00EDCE = 1;
    _id_07C40FA80892A721::_id_AC7803D45979135C(self._id_8790C077C95DB752);
  }

  thread start_regen_early();
  jugg_toggleallows(juggconfig.allows, 0);
  scripts\cp\utility::allow_player_basejumping(0, "juggernaut");
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  _id_12E2FB553EC1605E::updatemovespeedscale();

  if(istrue(streakinfo._id_CA56839B2E00EDCE)) {
    if(soundexists("cp_assault_suit_on"))
      self playlocalsound("cp_assault_suit_on");

    if(_id_531CB1BE084314F7::playercanplaynotcriticalgesture())
      self forceplaygestureviewmodel("ges_magma_gas_mask_on");

    wait 0.338;
  }

  if(isDefined(juggconfig.classstruct) && !istrue(streakinfo._id_CA56839B2E00EDCE)) {
    jugg_setModel();
    scripts\cp\utility\player::_setsuit(juggconfig.suit);
    self.suit = juggconfig.suit;
    self setclothtype(juggconfig.clothtype);
  } else {
    self setclothtype("vestheavy");
    _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
    _id_12E2FB553EC1605E::setcharactermodels("body_sp_opforce_shadow_company_elite_3_1", "head_sp_opforce_shadow_company_elite_1_1", "mp_vm_arms_jugg_aq_iw9_1_1");
  }

  jugg_enableoverlay(juggcontext);
  _id_6AFA1766E507E9D6();

  if(juggconfig.infiniteammo && !istrue(streakinfo._id_CA56839B2E00EDCE))
    thread infiniteammothread(juggconfig.infiniteammoupdaterate);

  self.juggcontext = juggcontext;
  self notify("juggernaut_start");
  self notify("munitions_used", "juggernaut");
  thread carryobjects_onjuggernaut();

  if(!istrue(streakinfo._id_CA56839B2E00EDCE))
    thread jugg_watchmusictoggle();

  thread jugg_watchfordeath();
  thread jugg_watchforgameend();
  thread jugg_watchfordisconnect();
  thread jugg_watchforfire();
  thread jugg_watchherodrop();
  thread _id_5B7C34DBC50C3C4E();
  thread jugg_watchfordamage();
  thread jugg_watchearlyexit();

  if(!istrue(streakinfo._id_CA56839B2E00EDCE))
    thread jugg_watchfordoors();

  thread _id_8E8605E7B6739834();
  thread jugg_watchoverlaydamagestates(juggcontext);
  thread jugg_watchforoverlayexecutiontoggle(juggcontext);
  return 1;
}

_id_F14F648C7F449690(juggcontext, juggconfig, _id_B69F99A7A0012317) {
  if(istrue(_id_B69F99A7A0012317)) {
    jugg_strip_old_weapons(self, juggcontext);
    scripts\cp\cp_loadout::assign_loadout_weapons(self, juggconfig.classstruct);
  }

  self giveweapon(self.starting_weapon);
  self setweaponammoclip(self.starting_weapon, weaponclipsize(self.starting_weapon));
  self setweaponammostock(self.starting_weapon, weaponmaxammo(self.starting_weapon));
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.starting_weapon);
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

_id_5B7C34DBC50C3C4E() {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  _id_8E6B2DE818370BAA(level._id_13819795C6EE9FF8, "pristine");
}

_id_1E84EEB2A6F4129D(index) {
  return level._id_13819795C6EE9FF8[index];
}

_id_59469CC44CA7FA81() {
  _id_BE4F784126F5409D = "pristine";

  for(;;) {
    _id_D131F91D9BEA09F3 = getdvarint("dvar_AE2C4F86FFAF24DB", 0);

    if(!_id_D131F91D9BEA09F3) {
      waitframe();
      continue;
    }

    _id_1649908C7CE1A12D = _id_1E84EEB2A6F4129D(_id_D131F91D9BEA09F3 - 1);

    if(_id_BE4F784126F5409D == "pristine") {
      _id_BE4F784126F5409D = "damaged";

      if(_id_1649908C7CE1A12D == "helmet")
        _id_BE4F784126F5409D = "off";
    } else
      _id_BE4F784126F5409D = "pristine";

    _id_8E6B2DE818370BAA(_id_1649908C7CE1A12D, _id_BE4F784126F5409D);
    setDvar("dvar_AE2C4F86FFAF24DB", 0);
    waitframe();
  }
}

_id_354F191D8B1EC22D(index) {
  return level._id_ED61C38F5C8BB414[index];
}

_id_5E9C6B97E4C3C059() {
  juggcontext = self.juggcontext;
  juggconfig = juggcontext.juggconfig;

  for(;;) {
    _id_5E13789652EC8A23 = getdvarint("dvar_63BF655A03B825EB", 0);

    if(!_id_5E13789652EC8A23) {
      waitframe();
      continue;
    }

    _id_BE4F784126F5409D = _id_354F191D8B1EC22D(_id_5E13789652EC8A23 - 1);
    _id_F05A031DC1DF54DF = "head_health";
    _id_5AA83DB0E5D721DB = _id_BE4F784126F5409D;

    if(_id_BE4F784126F5409D == "damaged")
      _id_5AA83DB0E5D721DB = "destroyed";

    _id_8E6B2DE818370BAA(_id_F05A031DC1DF54DF, _id_5AA83DB0E5D721DB);
    _id_27058B2D51DCF191 = "helmet";
    _id_E0AAD72B2CB25382 = _id_BE4F784126F5409D;

    if(_id_BE4F784126F5409D == "damaged")
      _id_E0AAD72B2CB25382 = "off";

    _id_8E6B2DE818370BAA(_id_27058B2D51DCF191, _id_E0AAD72B2CB25382);
    _id_3D1C10F919CD5AF0 = ["torso_upper_health", "torso_lower_health", "right_upper_arm_health", "right_lower_arm_health", "left_upper_arm_health", "left_lower_arm_health", "right_leg_health", "left_leg_health", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];
    _id_8E6B2DE818370BAA(_id_3D1C10F919CD5AF0, _id_BE4F784126F5409D);

    if(_id_BE4F784126F5409D == "pristine") {
      juggcontext._id_46AD94F231CD4EF3["head_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_CCEF760095A8D026), juggconfig._id_CCEF760095A8D026, 100);
      juggcontext._id_46AD94F231CD4EF3["torso_upper_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_033A458EBB314026), juggconfig._id_033A458EBB314026, 100);
      juggcontext._id_46AD94F231CD4EF3["torso_lower_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_6517BCADB9E33B21), juggconfig._id_6517BCADB9E33B21, 100);
      juggcontext._id_46AD94F231CD4EF3["right_upper_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_98C8EB9D039DFAA2), juggconfig._id_98C8EB9D039DFAA2, 100);
      juggcontext._id_46AD94F231CD4EF3["right_lower_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_6493D470BCAF2469), juggconfig._id_6493D470BCAF2469, 100);
      juggcontext._id_46AD94F231CD4EF3["left_upper_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_FE7B1A75B71D65B5), juggconfig._id_FE7B1A75B71D65B5, 100);
      juggcontext._id_46AD94F231CD4EF3["left_lower_arm_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_CCDC04703862490A), juggconfig._id_CCDC04703862490A, 100);
      juggcontext._id_46AD94F231CD4EF3["right_leg_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_196A36E4DE8891F5), juggconfig._id_196A36E4DE8891F5, 100);
      juggcontext._id_46AD94F231CD4EF3["left_leg_health"] = scripts\engine\utility::ter_op(isDefined(juggconfig._id_B74A139EF1F10A8A), juggconfig._id_B74A139EF1F10A8A, 100);
    } else {
      juggcontext._id_46AD94F231CD4EF3["head_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["torso_upper_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["torso_lower_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["right_upper_arm_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["right_lower_arm_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["left_upper_arm_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["left_lower_arm_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["right_leg_health"] = undefined;
      juggcontext._id_46AD94F231CD4EF3["left_leg_health"] = undefined;
    }

    setDvar("dvar_63BF655A03B825EB", 0);
    waitframe();
  }
}

_id_6AFA1766E507E9D6() {
  _id_E56A42F6A435E1BA = ["helmet", "neckguard", "backpack", "shoulderpad_r", "shoulderpad_l", "forearmpad_r", "forearmpad_l", "qamis", "thighpad_r", "thighpad_l"];

  foreach(part in _id_E56A42F6A435E1BA)
  self setscriptablepartstate(part, "pristine", 0);
}

_id_28BDA29E7DB3B4EA() {
  _id_E56A42F6A435E1BA = ["helmet", "neckguard", "backpack", "shoulderpad_r", "shoulderpad_l", "forearmpad_r", "forearmpad_l", "qamis", "thighpad_r", "thighpad_l"];

  foreach(part in _id_E56A42F6A435E1BA)
  self setscriptablepartstate(part, "off", 0);
}

jugg_modifyfalldamage() {
  if(istrue(self._id_CA56839B2E00EDCE)) {
    return;
  }
  if(self isskydiving())
    self skydive_interrupt();

  self notify("perform_hero_drop");
  return 0;
}

_id_C186DD6DB0BE730D(damage) {
  if(!istrue(self._id_CA56839B2E00EDCE)) {
    return;
  }
  if(self isskydiving())
    self skydive_interrupt();

  if(damage < 200)
    damage = int(damage / 3);

  return damage;
}

carryobjects_onjuggernaut() {
  waittillframeend;
  scripts\cp\challenges_cp::_id_15C867E400749A3B();

  if(isDefined(self.carryobject))
    self switchtoweapon("iw9_lm_dblmg2_cp");
}

jugg_strip_old_weapons(player, juggcontext) {
  player scripts\cp\utility::store_weapons_status();
  player scripts\cp\cp_accessories::clearplayeraccessory();
  player takeallweapons();
}

jugg_watchmusictoggle() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  _id_0ADFB98EEAB072EA = 0;
  self notifyonplayercommand("toggle_music", "+actionslot 3");
  self notifyonplayercommand("toggle_music", "killstreak_wheel");
  _id_E5C8D9D7E001AF68 = makeweapon("ks_gesture_jugg_music_mp");
  _id_8E47447445C817E5 = weaponfiretime(_id_E5C8D9D7E001AF68);

  if(!isDefined(self.musicplaying)) {
    _id_AA73BA383F8079EA = self getjuggdefaultmusicenabled();
    self.musicplaying = _id_AA73BA383F8079EA;
  }

  if(!istrue(self.musicplaying))
    self setscriptablepartstate("juggernaut", "neutral", 0);
  else
    self setscriptablepartstate("juggernaut", "music", 0);

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
      self setscriptablepartstate("juggernaut", "music", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
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

_id_4217F11FFB352425(damage, shitloc, smeansofdeath, attacker) {
  _id_1F48003B8E69560C = _id_C0AA811F7B45687C(shitloc, smeansofdeath, attacker);

  if(!isDefined(_id_1F48003B8E69560C)) {
    if(isDefined(attacker) && isDefined(shitloc) && isPlayer(attacker)) {}

    return;
  }

  _id_B47072BCD58C0C99(_id_1F48003B8E69560C, damage);
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

jugg_setherodropscriptable(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
  juggconfig.herodrop = 0;
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

jugg_watchforgameend() {
  self endon("juggernaut_end");
  juggcontext = self.juggcontext;
  level waittill("game_ended");
  self.maxhealth = juggcontext.prevmaxhealth;
  self.health = juggcontext.prevhealth;
  jugg_disableoverlay(juggcontext);
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
    self.streakinfo.shots_fired++;
  }
}

jugg_removejuggernaut() {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.streakinfo._id_CA56839B2E00EDCE)) {
    if(soundexists("cp_assault_suit_off"))
      self playlocalsound("cp_assault_suit_off");

    if(soundexists("cp_assault_suit_on"))
      self stoplocalsound("cp_assault_suit_on");

    if(_id_531CB1BE084314F7::playercanplaynotcriticalgesture())
      self forceplaygestureviewmodel("ges_magma_gas_mask_off");

    wait 0.521;
  }

  self notify("juggernaut_end_damage");
  self notify("juggernaut_end");
  juggcontext = self.juggcontext;
  juggconfig = juggcontext.juggconfig;
  self.musicplaying = undefined;
  self._id_0A23031C04DF01BF = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;

    if(istrue(level.relic_vampire) || istrue(level.relic_healthpacks)) {
      _id_1DAB4A6BAD01C509 = self getentitynumber();
      _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerMaxHealth", self.maxhealth);
    }

    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
    jugg_toggleallows(juggconfig.allows, 1);

    if(isDefined(juggconfig.classstruct))
      _id_12E2FB553EC1605E::respawnitems_assignrespawnitems(juggcontext.respawnitems);

    foreach(perk, _id_97282C14346A7FCF in juggconfig.perks)
    scripts\cp\utility::_unsetperk(perk);

    if(juggconfig.infiniteammo)
      stopinfiniteammothread();
  }

  jugg_restoremodel(juggcontext);
  self.playerstreakspeedscale = juggcontext.prevspeedscale;
  _id_12E2FB553EC1605E::updatemovespeedscale();
  _id_28BDA29E7DB3B4EA();
  scripts\cp\utility\player::_setsuit(juggcontext.prevsuit);
  self.suit = juggcontext.prevsuit;

  if(isDefined(self.prevclothtype))
    self setclothtype(juggcontext.prevclothtype);

  if(!istrue(self.streakinfo._id_CA56839B2E00EDCE)) {
    self takeallweapons();
    scripts\cp\utility::restore_weapons_status();
  } else {
    self setclientomnvar("ui_assault_suit_on", 0);
    scripts\cp\utility::_id_98F7CA3781DAC77C(self, "assault_suit");
    self._id_CA56839B2E00EDCE = 0;
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution))
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);

  if(scripts\cp\utility::is_specops_gametype() || scripts\cp\utility::_id_A3577E8E6C88A56B() || scripts\cp\utility::_id_F620E996A1D7D81A()) {
    if(isDefined(self.loadoutaccessorydata) && isDefined(self.loadoutaccessoryweapon) && self.loadoutaccessoryweapon != "none")
      scripts\cp\cp_accessories::giveplayeraccessory(self.loadoutaccessorydata, self.loadoutaccessoryweapon, self.loadoutaccessorylogic);
  } else if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none")
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);

  jugg_disableoverlay(juggcontext);
  self setscriptablepartstate("juggernaut", "neutral", 0);

  if(!scripts\cp\utility::is_raid_gamemode())
    scripts\cp\utility::allow_player_basejumping(1, "juggernaut");

  self.damageshieldexpiretime = gettime() + 3000;
  self.isjuggernaut = undefined;
  self.can_revive = 1;
  self.juggcontext = undefined;
  self.disabletakecoverwarning = undefined;
  self.jugg_health = undefined;
  self._id_5D43389756907528 = undefined;
  thread start_regen_early();
  self.streakinfo = undefined;
  self notify("stop_hostagecarrier_watching_for_doors");
  self notify("juggernaut_end");
}

start_regen_early() {
  wait 0.1;
  self notify("force_regeneration");
  _id_0372301AF73968CB::_id_019B9BB9CEF6A2D3();
}

infiniteammothread(waittime, weapons) {
  self endon("death_or_disconnect");
  self endon("stop_infinite_ammo_thread");

  if(!isDefined(waittime))
    waittime = level.framedurationseconds;

  for(;;) {
    if(!_id_74502A9E0EF1F19C::player_has_minigun(self)) {
      wait(waittime);
      continue;
    }

    if(!isDefined(weapons))
      weapons = self.equippedweapons;

    foreach(weapon in weapons) {
      self givemaxammo(weapon);
      self setweaponammoclip(weapon, weaponclipsize(weapon));
    }

    wait(waittime);
  }
}

stopinfiniteammothread() {
  self notify("stop_infinite_ammo_thread");
}

jugg_createconfig(_id_D493BD7620FA1AF0, _id_ED0B84B88196CCA6) {
  config = spawnStruct();
  config.maxhealth = 3000;
  config.startinghealth = config.maxhealth;
  config.movespeedscalar = -0.2;
  config._id_9A0CEA8101A4F35C = -0.0;
  config.forcetostand = 1;
  config.suit = "iw9_juggernaut_mp";
  config.infiniteammo = 1;
  config.infiniteammoupdaterate = undefined;
  config.classstruct = jugg_getdefaultclassstruct();
  config.allows = [];
  config.allows["stick_kill"] = 1;
  config.allows["one_hit_melee_victim"] = 1;
  config.allows["flashed"] = 1;
  config.allows["stunned"] = 1;
  config.allows["prone"] = 1;
  config.allows["health_regen"] = 1;
  config.allows["supers"] = 1;
  config.allows["killstreaks"] = 1;
  config.allows["slide"] = 1;
  config.allows["execution_victim"] = 1;
  config.allows["cough_gesture"] = 1;
  config.allows["offhand_throwback"] = 1;
  config.perks = [];
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

    if(!istrue(level.disablemount)) {
      _id_3B64EB40368C1450::set("juggernaut", "mount_top", 0);
      _id_3B64EB40368C1450::set("juggernaut", "mount_side", 0);
    }

    if(!istrue(self.streakinfo._id_CA56839B2E00EDCE))
      _id_3B64EB40368C1450::set("juggernaut", "weapon_switch", 0);

    _id_3B64EB40368C1450::set("juggernaut", "vehicle_use", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("juggernaut");
}

jugg_getdefaultclassstruct() {
  classstruct = _id_12E2FB553EC1605E::loadout_getclassstruct();
  classstruct.loadoutarchetype = "archetype_assault";
  classstruct.loadoutprimary = "iw9_lm_dblmg2_cp";
  classstruct.loadoutsecondary = "none";
  return classstruct;
}

jugg_watchfordeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  self waittill("last_stand");
  thread jugg_removejuggernaut();
}

jugg_watchfordamage() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  self endon("juggernaut_early_exit");
  self waittill("juggernaut_end_damage");

  if(!istrue(self._id_E180981362944A17))
    thread jugg_removejuggernaut();
}

jugg_watchearlyexit() {
  self endon("disconnect");
  self endon("juggernaut_end");
  self.owner = self;
  thread scripts\cp\utility::allowridekillstreakplayerexit();
  self waittill("killstreakExit");

  if(istrue(self.no_jugg_early_exit))
    thread jugg_watchearlyexit();
  else {
    self notify("juggernaut_early_exit");
    thread jugg_removejuggernaut();
  }
}

jugg_watchfordoors() {
  self endon("disconnect");
  self endon("juggernaut_end");
  self endon("stop_hostagecarrier_watching_for_doors");
  self.owner = self;
  scripts\cp\utility::watch_and_open_scriptable_doors_in_radius();
}

_id_8E8605E7B6739834() {
  self endon("disconnect");
  self endon("juggernaut_end");
  _id_4F0FC1C36324AFFB = squared(300);

  for(;;) {
    wait 0.2;
    _id_5231B925A8261FCA = 0;

    if(isDefined(level._id_C0DF98E7900066B7)) {
      foreach(entity in level._id_C0DF98E7900066B7) {
        if(isDefined(entity.radius)) {
          if(distance(self.origin, entity.origin) < float(entity.radius))
            _id_5231B925A8261FCA = 1;

          continue;
        }

        if(!isDefined(entity)) {
          _id_5231B925A8261FCA = 0;
          continue;
        }

        if(distancesquared(self.origin, entity.origin) < _id_4F0FC1C36324AFFB) {
          _id_5231B925A8261FCA = 1;
          break;
        }
      }
    }

    foreach(player in level.players) {
      if(istrue(player.inlaststand) || isDefined(player.dogtag)) {
        if(distancesquared(self.origin, player.origin) < _id_4F0FC1C36324AFFB)
          _id_5231B925A8261FCA = 1;
      }
    }

    if(_id_5231B925A8261FCA) {
      self._id_5D43389756907528 = 1;
      continue;
    }

    self._id_5D43389756907528 = undefined;
  }
}

_id_91ED8C25C9B88686() {
  if(!isDefined(level._id_C0DF98E7900066B7))
    level._id_C0DF98E7900066B7 = [];

  level._id_C0DF98E7900066B7[level._id_C0DF98E7900066B7.size] = self;
}

_id_84BAE1E96A725EC5(delay) {
  if(isDefined(delay))
    wait(delay);

  level._id_C0DF98E7900066B7 = scripts\engine\utility::array_remove(level._id_C0DF98E7900066B7, self);
}

jugg_getjuggmodels() {
  models = [];
  models["body"] = "body_sp_opforce_aq_jugg_basebody";
  models["head"] = "head_sp_opforce_aq_jugg";
  models["view"] = "mp_vm_arms_jugg_aq_iw9_1_1";
  return models;
}

jugg_setModel() {
  models = jugg_getjuggmodels();
  bodymodelname = models["body"];
  headmodelname = models["head"];
  _id_41BD2EEDA1C033D2 = models["view"];
  _id_12E2FB553EC1605E::setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2);
}

jugg_restoremodel(juggcontext) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self setcustomization(juggcontext.prevbody, juggcontext.prevhead);
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
    _id_12E2FB553EC1605E::setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2);
  }
}

jugg_needtochangestance(juggconfig) {
  _id_8A867002DF857D70 = 0;
  _id_6497396FB64EA3B9 = self getstance();

  switch (_id_6497396FB64EA3B9) {
    case "stand":
      _id_8A867002DF857D70 = 0;
      break;
    case "crouch":
      if(juggconfig.forcetostand || !juggconfig.allowcrouch) {
        _id_8A867002DF857D70 = 1;
        break;
      }

      break;
    case "prone":
      if(juggconfig.forcetostand || !juggconfig.allowprone) {
        _id_8A867002DF857D70 = 1;
        break;
      }

      break;
  }

  return _id_8A867002DF857D70;
}

jugg_canresolvestance(juggconfig) {
  return 1;
}

jugg_handlestancechange(juggconfig) {
  if(jugg_needtochangestance(juggconfig))
    self setstance("stand");
}

jugg_enableoverlay(juggcontext) {
  self notify("jugg_mask_on");

  if(!isDefined(self.juggoverlaystatelabel) && !isDefined(self.juggoverlaystate)) {
    self.juggoverlaystatelabel = "mask_on";
    self.juggoverlaystate = 1;
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
  self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
  thread _id_AE8C964EB2EF2486(juggcontext);
}

_id_AE8C964EB2EF2486(juggcontext) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  _id_EA0A3076FB747A79 = self.juggoverlaystate;

  for(;;) {
    if(self _meth_C1092F42B6BBE490() && self playerads() <= 0.75) {
      jugg_disableoverlay(juggcontext, 1);
      _id_EA0A3076FB747A79 = 0;
      wait 0.1;
      continue;
    }

    if(!isDefined(self.juggoverlaystatelabel) && !isDefined(self.juggoverlaystate)) {
      self.juggoverlaystatelabel = "mask_on";
      self.juggoverlaystate = 1;
    }

    if(_id_EA0A3076FB747A79 != self.juggoverlaystate) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
      self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
      _id_EA0A3076FB747A79 = self.juggoverlaystate;
    }

    self setclientomnvar("ui_jugg_overlay_third_person", 0);
    wait 0.1;
    continue;
  }
}

jugg_watchoverlaydamagestates(juggcontext) {
  self endon("juggernaut_end");
  self endon("death or disconnect");
  level endon("game_ended");
  juggcontext = self.juggcontext;
  startinghealth = self.jugg_health;
  _id_4EB5162696BAFF69 = startinghealth - startinghealth * 0.1;
  _id_5C8E464293ED834C = startinghealth - startinghealth * 0.35;
  _id_EED2946CC87372BB = startinghealth - startinghealth * 0.6;
  _id_1F9CEBCA13994806 = startinghealth - startinghealth * 0.85;
  _id_654EBA19046746E8 = 1;
  _id_EA0A3076FB747A79 = _id_654EBA19046746E8;
  _id_4F287978D27B5156 = "mask_on";

  for(;;) {
    scripts\engine\utility::waittill_any_3("damage", "jugg_health_regen", "jugg_damage");

    if(self.jugg_health <= _id_1F9CEBCA13994806) {
      _id_4F287978D27B5156 = "mask_damage_critical";
      _id_654EBA19046746E8 = 5;
    } else if(self.jugg_health <= _id_EED2946CC87372BB) {
      _id_4F287978D27B5156 = "mask_damage_high";
      _id_654EBA19046746E8 = 4;
    } else if(self.jugg_health <= _id_5C8E464293ED834C) {
      _id_4F287978D27B5156 = "mask_damage_med";
      _id_654EBA19046746E8 = 3;
    } else if(self.jugg_health <= _id_4EB5162696BAFF69) {
      _id_4F287978D27B5156 = "mask_damage_low";
      _id_654EBA19046746E8 = 2;
    } else {
      _id_4F287978D27B5156 = "mask_on";
      _id_654EBA19046746E8 = 1;
    }

    self.juggoverlaystatelabel = _id_4F287978D27B5156;
    self.juggoverlaystate = _id_654EBA19046746E8;

    if(_id_EA0A3076FB747A79 != _id_654EBA19046746E8) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
      wait 0.1;
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", _id_4F287978D27B5156);
      self setclientomnvar(juggcontext.maskomnvar, _id_654EBA19046746E8);
      _id_EA0A3076FB747A79 = _id_654EBA19046746E8;
    }
  }
}

jugg_watchforoverlayexecutiontoggle(juggcontext) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("juggernaut_end");
  _id_2BF9392CAB435CDF = 0;

  for(;;) {
    if(!self isinexecutionattack()) {
      if(istrue(_id_2BF9392CAB435CDF)) {
        scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
        self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
        _id_2BF9392CAB435CDF = 0;
      }

      waitframe();
      continue;
    }

    if(!istrue(_id_2BF9392CAB435CDF)) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
      self setclientomnvar(juggcontext.maskomnvar, 0);
      _id_2BF9392CAB435CDF = 1;
    }

    waitframe();
  }
}

jugg_disableoverlay(juggcontext, _id_C953EE526F4BB69F) {
  if(!istrue(_id_C953EE526F4BB69F)) {
    _id_C953EE526F4BB69F = 0;
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  }

  self setclientomnvar(juggcontext.maskomnvar, 0);
  self setclientomnvar("ui_jugg_overlay_third_person", _id_C953EE526F4BB69F);
  self.juggoverlaystatelabel = undefined;
  self.juggoverlaystate = undefined;
}

jugg_getmovespeedscalar() {
  return -0.2;
}