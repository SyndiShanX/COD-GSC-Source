/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perkfunctions.gsc
***********************************************/

sethealer() {
  thread radialhealer();
}

radialhealer() {
  self endon("unset_healer");
  self endon("disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  self.teammateswithhealperk = [];

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      players = scripts\mp\utility\player::getplayersinradius(self.origin, 350, self.team, self);

      foreach(player in players) {
        if(player scripts\mp\utility\perk::_hasperk("specialty_healer")) {
          continue;
        }
        if(self.team == player.team && player scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(player.healer)) {
          _id_3BBF59C5B0A18AF5 = player getentitynumber();

          if(self.teammateswithhealperk.size == 0)
            scripts\mp\hud_message::showmiscmessage("healing_players");

          player.healer = self;
          self.teammateswithhealperk[_id_3BBF59C5B0A18AF5] = 1;
          player scripts\mp\utility\perk::giveperk("specialty_regenfaster");
          player scripts\mp\utility\perk::giveperk("specialty_regen_delay_reduced");
          player scripts\mp\hud_message::showmiscmessage("in_healing_range");
          givehealedoverlay(player);
          thread healerperkteammatewatcher(player);
          thread healerperkteammatedestructor(player);
        }
      }
    }

    wait 0.3;
  }
}

healerperkteammatewatcher(player) {
  level endon("game_ended");
  self endon("unset_healer");
  self endon("death_or_disconnect");
  player endon("death_or_disconnect");

  for(;;) {
    _id_472935042B6EFF85 = 400;

    if(distancesquared(self.origin, player.origin) > _id_472935042B6EFF85 * _id_472935042B6EFF85 || player.team != self.team) {
      player notify("out_of_healing_range");
      return;
    }

    _id_3BBF59C5B0A18AF5 = player getentitynumber();

    if(player.health < player.maxhealth && player.healedoverlay.alpha == player.healedoverlay.lowalpha)
      player thread healedoverlayfade(player.healedoverlay, self, player.healedoverlay.highalpha);
    else if(player.health == player.maxhealth)
      player thread healedoverlayfade(player.healedoverlay, self, player.healedoverlay.lowalpha);

    wait 0.1;
  }
}

healerperkteammatedestructor(player) {
  level endon("game_ended");
  _id_3BBF59C5B0A18AF5 = player getentitynumber();
  scripts\engine\utility::waittill_any_ents(self, "unset_healer", self, "death_or_disconnect", player, "death_or_disconnect", player, "out_of_healing_range");

  if(isDefined(player)) {
    player scripts\mp\utility\perk::removeperk("specialty_regenfaster");
    player scripts\mp\utility\perk::removeperk("specialty_regen_delay_reduced");
    player.healer = undefined;
    player scripts\mp\hud_message::showmiscmessage("out_of_healing_range");
  }

  if(isDefined(self)) {
    self.teammateswithhealperk[_id_3BBF59C5B0A18AF5] = undefined;

    if(self.teammateswithhealperk.size == 0)
      scripts\mp\hud_message::showmiscmessage("no_healing_players");
  }
}

unsethealer() {
  self notify("unset_healer");
}

givehealedoverlay(player) {
  healedoverlay = newclienthudelem(player);
  healedoverlay.x = 0;
  healedoverlay.y = 0;
  healedoverlay setshader("overlay_healer", 640, 480);
  healedoverlay.alignx = "left";
  healedoverlay.aligny = "top";
  healedoverlay.horzalign = "fullscreen";
  healedoverlay.vertalign = "fullscreen";
  healedoverlay.alpha = 0;
  healedoverlay.lowalpha = 0;
  healedoverlay.highalpha = 0.75;
  player.healedoverlay = healedoverlay;
  player thread healedoverlayfade(healedoverlay, self, healedoverlay.lowalpha);
  player thread healedoverlaydestructor(healedoverlay, self);
}

healedoverlayfade(healedoverlay, healer, _id_3C6834588DE16243) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("out_of_healing_range");
  healer endon("death_or_disconnect");
  healer endon("unset_healer");
  healedoverlay fadeovertime(0.5);
  healedoverlay.alpha = _id_3C6834588DE16243;
}

healedoverlaydestructor(healedoverlay, healer) {
  scripts\engine\utility::waittill_any_ents(level, "game_ended", healer, "unset_healer", healer, "death_or_disconnect", self, "death_or_disconnect", self, "out_of_healing_range");

  if(isDefined(healedoverlay)) {
    healedoverlay fadeovertime(1);
    healedoverlay.alpha = 0;
    wait 1;
    healedoverlay destroy();
  }
}

setbreacher() {
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 1);
}

unsetbreacher() {
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 0);
}

setoffhandprovider() {
  thread offhandproviderthread();
}

offhandproviderthread() {
  level endon("game_ended");
  self endon("unset_offhand_provider");
  self endon("death_or_disconnect");

  for(;;) {
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 144, self.team, self);

    foreach(player in players) {
      if(!isDefined(player.ohpequipmentrefills))
        player.ohpequipmentrefills = [];

      if(player equipmentusedbyslot("primary") == 0 && player equipmentusedbyslot("secondary") == 0) {
        continue;
      }
      if(!isDefined(player.ohpequipmentrefills[self getentitynumber()]) && player scripts\cp_mp\utility\player_utility::_isalive()) {
        player.ohpequipmentrefills[self getentitynumber()] = 1;
        _id_A9E766F674FA786B = player refillequipment();

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A9E766F674FA786B["primary"]; _id_AC0E594AC96AA3A8++)
          player thread ohpequipmentfillednotification(self.name, player scripts\mp\equipment::getcurrentequipment("primary"));

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A9E766F674FA786B["secondary"]; _id_AC0E594AC96AA3A8++)
          player thread ohpequipmentfillednotification(self.name, player scripts\mp\equipment::getcurrentequipment("secondary"));

        thread ohpallowuseonplayerdeath(player);
        player playsoundtoplayer("scavenger_pack_pickup", player);
      }
    }

    wait 0.1;
  }
}

ohpallowuseonplayerdeath(player) {
  level endon("game_ended");
  player endon("disconnect");
  entnum = self getentitynumber();
  scripts\engine\utility::waittill_any_ents_return(self, "disconnect", player, "death");
  player.ohpequipmentrefills[entnum] = undefined;
}

unsetoffhandprovider() {
  self notify("unset_offhand_provider");
}

refillequipment() {
  _id_7BAD5D0B3AB39F16 = [];
  _id_7BAD5D0B3AB39F16["primary"] = equipmentusedbyslot("primary", 1);
  _id_7BAD5D0B3AB39F16["secondary"] = equipmentusedbyslot("secondary", 1);
  return _id_7BAD5D0B3AB39F16;
}

equipmentusedbyslot(slot, refill) {
  if(!isDefined(refill))
    refill = 0;

  eq = scripts\mp\equipment::getcurrentequipment(slot);
  _id_33C15FD1027524F5 = getequipmentstartammo(slot);
  _id_0BD0EAD7AE63D86D = scripts\mp\equipment::getequipmentammo(eq);

  if(refill && _id_33C15FD1027524F5 - _id_0BD0EAD7AE63D86D > 0)
    scripts\mp\equipment::incrementequipmentammo(eq, _id_33C15FD1027524F5 - _id_0BD0EAD7AE63D86D);

  return _id_33C15FD1027524F5 - _id_0BD0EAD7AE63D86D;
}

getequipmentstartammo(slot) {
  eq = scripts\mp\equipment::getcurrentequipment(slot);
  _id_33C15FD1027524F5 = scripts\mp\equipment::getequipmentstartammo(eq);

  if(slot == "primary" && scripts\mp\utility\perk::_hasperk("specialty_extra_deadly"))
    _id_33C15FD1027524F5 = scripts\mp\equipment::getequipmentmaxammo(eq);

  if(slot == "secondary" && scripts\mp\utility\perk::_hasperk("specialty_extra_tactical"))
    _id_33C15FD1027524F5 = scripts\mp\equipment::getequipmentmaxammo(eq);

  return _id_33C15FD1027524F5;
}

ohpequipmentfillednotification(_id_F35666FACE73A0B9, _id_2EB789D043254817) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.munitionsnotifications))
    self.munitionsnotifications = [];

  _id_A61C75B156FC1EE0 = self.munitionsnotifications.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A61C75B156FC1EE0; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 < 2) {
      thread movenotificationup(self.munitionsnotifications[_id_AC0E594AC96AA3A8]);
      continue;
    }

    _id_4930CBCE302555B1 = self.munitionsnotifications[_id_AC0E594AC96AA3A8];
    self.munitionsnotifications[_id_AC0E594AC96AA3A8] = undefined;
    _id_4930CBCE302555B1 notify("delete_icon_elem");
  }

  _id_BA8D59C006AB07C1 = 620;
  _id_BA8D58C006AB058E = 360;
  x = 352.0;
  y = 264.0;
  _id_5B6A2597D526BD27 = newclienthudelem(self);
  _id_5B6A2597D526BD27.x = x;
  _id_5B6A2597D526BD27.y = y;
  _id_5B6A2597D526BD27.alignx = "right";
  _id_5B6A2597D526BD27.aligny = "top";
  _id_5B6A2597D526BD27.sort = 2;
  _id_5B6A2597D526BD27.alpha = 0;
  _id_58907637F9A8D293 = scripts\mp\equipment::getequipmenttableinfo(_id_2EB789D043254817);

  if(isDefined(_id_58907637F9A8D293))
    _id_5B6A2597D526BD27 setshader(_id_58907637F9A8D293.image, 25, 25);

  _id_5B6A2597D526BD27 fadeovertime(0.15);
  _id_5B6A2597D526BD27 moveovertime(0.35);
  _id_5B6A2597D526BD27.alpha = 1;
  _id_5B6A2597D526BD27.x = _id_BA8D59C006AB07C1;
  _id_5B6A2597D526BD27.y = _id_BA8D58C006AB058E;
  self.munitionsnotifications = scripts\engine\utility::array_insert(self.munitionsnotifications, _id_5B6A2597D526BD27, 0);
  _id_5B6A2597D526BD27 endon("delete_icon_elem");
  thread ohpcleanupnotificationondeath(_id_5B6A2597D526BD27);
  _id_5B6A2597D526BD27.isanimating = 1;
  wait 0.35;
  _id_5B6A2597D526BD27.isanimating = 0;
  wait 3;
  _id_5B6A2597D526BD27 fadeovertime(0.5);
  _id_5B6A2597D526BD27.alpha = 0;
  wait 0.5;
  _id_5B6A2597D526BD27 notify("delete_icon_elem");
}

ohpcleanupnotificationondeath(_id_5B6A2597D526BD27) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(self, "death_or_disconnect", _id_5B6A2597D526BD27, "delete_icon_elem");

  if(isDefined(self))
    self.munitionsnotifications = scripts\engine\utility::array_remove(self.munitionsnotifications, _id_5B6A2597D526BD27);

  _id_5B6A2597D526BD27 destroy();
}

movenotificationup(_id_5B6A2597D526BD27) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_5B6A2597D526BD27 endon("delete_icon_elem");

  if(!istrue(_id_5B6A2597D526BD27.isanimating))
    _id_5B6A2597D526BD27 moveovertime(0.35);

  _id_5B6A2597D526BD27.y = _id_5B6A2597D526BD27.y - 25;
  wait 0.35;
}

setoverkillpro() {}

unsetoverkillpro() {}

setempimmune() {}

unsetempimmune() {}

setautospot() {
  if(!isPlayer(self)) {
    return;
  }
  autospotadswatcher();
  autospotdeathwatcher();
}

autospotdeathwatcher() {
  self waittill("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  self autospotoverlayoff();
}

unsetautospot() {
  if(!isPlayer(self)) {
    return;
  }
  self notify("endAutoSpotAdsWatcher");
  self autospotoverlayoff();
}

autospotadswatcher() {
  self endon("death_or_disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  spotter = 0;

  for(;;) {
    waitframe();

    if(self isusingturret()) {
      self autospotoverlayoff();
      continue;
    }

    _id_5711E9F53C0BEC85 = self playerads();

    if(_id_5711E9F53C0BEC85 < 1 && spotter) {
      spotter = 0;
      self autospotoverlayoff();
    }

    if(_id_5711E9F53C0BEC85 < 1 && !spotter) {
      continue;
    }
    if(_id_5711E9F53C0BEC85 == 1 && !spotter) {
      spotter = 1;
      self autospotoverlayon();
    }
  }
}

setregenfaster() {}

unsetregenfaster() {}

timeoutregenfaster() {
  self.hasregenfaster = undefined;
  scripts\mp\utility\perk::removeperk("specialty_regenfaster");
  self setclientdvar("ui_regen_faster_end_milliseconds", 0);
  self notify("timeOutRegenFaster");
}

sethardshell() {
  self.shellshockreduction = 0.25;
}

unsethardshell() {
  self.shellshockreduction = 0;
}

setsharpfocus() {
  thread monitorsharpfocus();
}

monitorsharpfocus() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_monitorSharpFocus");

  for(;;) {
    updatesharpfocus();
    self waittill("weapon_change");
  }
}

updatesharpfocus() {
  _id_DD515FCF025B2E79 = self.currentweapon;
  scale = undefined;
  _id_6651DEF69449C4A3 = scripts\mp\utility\weapon::weapongetflinchtype(_id_DD515FCF025B2E79);

  if(_id_6651DEF69449C4A3 == 4)
    scale = 1;
  else if(_id_6651DEF69449C4A3 == 3)
    scale = 1;
  else if(_id_6651DEF69449C4A3 == 1)
    scale = 1;
  else
    scale = 1;

  scripts\mp\weapons::updateviewkickscale(scale);
}

unsetsharpfocus() {
  self notify("stop_monitorSharpFocus");
  scripts\mp\weapons::updateviewkickscale(1.0);
}

updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }
  scale = undefined;
  _id_6651DEF69449C4A3 = scripts\mp\utility\weapon::weapongetflinchtype(self.currentweapon);

  if(_id_6651DEF69449C4A3 == 4)
    scale = 1;
  else if(_id_6651DEF69449C4A3 == 3)
    scale = 1;
  else if(_id_6651DEF69449C4A3 == 1)
    scale = 1;
  else
    scale = 1;

  scripts\mp\weapons::updateviewkickscale(scale);
}

ammodisabling_run(victim, _id_83685EA651F09717) {
  victim notify("disablingRun");
  victim endon("disablingRun");
  victim endon("disconnect");
  level endon("game_ended");

  if(!isDefined(victim.disabledspeedmod)) {
    victim.disabledspeedmod = -0.05;
    victim scripts\mp\weapons::updatemovespeedscale();
    victim ammodisabling_impair();
  }

  if(_id_83685EA651F09717)
    timer = 1.1;
  else
    timer = 0.8;

  _id_0F1A9809EED7E8F0 = gettime();

  if(!isDefined(victim._id_0329BC9067B9F8AC) || _id_0F1A9809EED7E8F0 - victim._id_0329BC9067B9F8AC > 800.0 || _id_83685EA651F09717) {
    if(_id_83685EA651F09717)
      duration = 1.1;
    else
      duration = 0.8;

    victim shellshock("chargemode_mp", duration);
    victim._id_0329BC9067B9F8AC = _id_0F1A9809EED7E8F0;
  }

  while(isalive(victim) && timer > 0) {
    timer = timer - level.framedurationseconds;
    waitframe();
  }

  victim ammodisabling_impairend();
  victim.disabledspeedmod = undefined;
  victim._id_0329BC9067B9F8AC = undefined;
  victim scripts\mp\weapons::updatemovespeedscale();
}

ammodisabling_impair() {
  _id_3B64EB40368C1450::set("ammoDisabling", "jog", 0);
  _id_3B64EB40368C1450::set("ammoDisabling", "sprint", 0);
  _id_3B64EB40368C1450::set("ammoDisabling", "slide", 0);
  _id_3B64EB40368C1450::set("ammoDisabling", "allow_jump", 0);
}

ammodisabling_impairend() {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ammoDisabling");
}

setviewkickoverride() {
  self.overrideviewkickscale = 0.5;
  self.overrideviewkickscaledmr = 0.5;
  self.overrideviewkickscalesniper = 0.5;
  self.overrideviewkickscalepistol = 0.5;
  scripts\mp\weapons::updateviewkickscale();
}

unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.overrideviewkickscaledmr = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  scripts\mp\weapons::updateviewkickscale();
}

setaffinityspeedboost() {
  self.weaponaffinityspeedboost = 0.08;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetaffinityspeedboost() {
  self.weaponaffinityspeedboost = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

setaffinityextralauncher() {
  self.weaponaffinityextralauncher = 1;
  primary = _id_2669878CF5A1B6BC::buildweapon(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid);
  _id_D7B9856A19F9B6B5 = _id_2669878CF5A1B6BC::buildweapon(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.loadoutsecondaryvariantid);

  if(scripts\mp\utility\weapon::getweapongroup(primary.basename) == "weapon_projectile")
    self setweaponammoclip(primary, weaponclipsize(primary));

  if(scripts\mp\utility\weapon::getweapongroup(_id_D7B9856A19F9B6B5.basename) == "weapon_projectile")
    self setweaponammoclip(_id_D7B9856A19F9B6B5, weaponclipsize(_id_D7B9856A19F9B6B5));
}

unsetaffinityextralauncher() {
  self.weaponaffinityextralauncher = undefined;
}

setdoubleload() {
  self endon("death_or_disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    weapons = self getweaponslist("primary");

    foreach(weapon in weapons) {
      _id_7EF185D0CBFCE036 = self getweaponammoclip(weapon);
      clipsize = weaponclipsize(weapon);
      _id_2A83DF6C49112D96 = clipsize - _id_7EF185D0CBFCE036;
      _id_70D8543518EE27D2 = self getweaponammostock(weapon);

      if(_id_7EF185D0CBFCE036 != clipsize && _id_70D8543518EE27D2 > 0) {
        if(_id_7EF185D0CBFCE036 + _id_70D8543518EE27D2 >= clipsize) {
          self setweaponammoclip(weapon, clipsize);
          self setweaponammostock(weapon, _id_70D8543518EE27D2 - _id_2A83DF6C49112D96);
          continue;
        }

        self setweaponammoclip(weapon, _id_7EF185D0CBFCE036 + _id_70D8543518EE27D2);

        if(_id_70D8543518EE27D2 - _id_2A83DF6C49112D96 > 0) {
          self setweaponammostock(weapon, _id_70D8543518EE27D2 - _id_2A83DF6C49112D96);
          continue;
        }

        self setweaponammostock(weapon, 0);
      }
    }
  }
}

unsetdoubleload() {
  self notify("endDoubleLoad");
}

setmarksman(power) {
  return;

  if(!isDefined(power))
    power = 10;
  else
    power = int(power) * 2;

  scripts\mp\utility\weapon::setrecoilscale(power);
  self.recoilscale = power;
}

unsetmarksman() {
  return;
  scripts\mp\utility\weapon::setrecoilscale(0);
  self.recoilscale = 0;
}

setfastcrouch() {
  thread watchfastcrouch();
}

watchfastcrouch() {
  self endon("death_or_disconnect");
  self endon("fastcrouch_unset");

  for(;;) {
    _id_D4020A6F1CA2F526 = (self getstance() == "crouch" || self getstance() == "prone") && !self issprintsliding();

    if(!isDefined(self.fastcrouchspeedmod)) {
      if(_id_D4020A6F1CA2F526) {
        self.fastcrouchspeedmod = 0.25;
        scripts\mp\weapons::updatemovespeedscale();
      }
    } else if(!_id_D4020A6F1CA2F526) {
      self.fastcrouchspeedmod = undefined;
      scripts\mp\weapons::updatemovespeedscale();
    }

    waitframe();
  }
}

unsetfastcrouch() {
  self notify("fastcrouch_unset");

  if(isDefined(self.fastcrouchspeedmod)) {
    self.fastcrouchspeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

setrshieldradar() {
  self endon("unsetRShieldRadar");
  wait 0.75;
  self makeportableradar();
  thread setrshieldradar_cleanup();
}

setrshieldradar_cleanup() {
  self endon("unsetRShieldRadar");
  self waittill("death_or_disconnect");

  if(isDefined(self))
    unsetrshieldradar();
}

unsetrshieldradar() {
  self clearportableradar();
  self notify("unsetRShieldRadar");
}

setrshieldscrambler() {
  self makescrambler();
  thread setrshieldscrambler_cleanup();
}

setrshieldscrambler_cleanup() {
  self endon("unsetRShieldScrambler");
  self waittill("death_or_disconnect");

  if(isDefined(self))
    unsetrshieldscrambler();
}

unsetrshieldscrambler() {
  self clearscrambler();
  self notify("unsetRShieldScrambler");
}

setstunresistance(power) {
  if(!isDefined(power))
    power = 4;

  power = int(power);

  if(power == 10)
    self.stunscalar = 0;
  else
    self.stunscalar = power / 10;
}

unsetstunresistance() {
  self.stunscalar = 1;
}

applystunresistence(attacker, victim, time) {
  if(victim scripts\mp\utility\perk::_hasperk("specialty_stun_resistance") && attacker != victim) {
    if(isDefined(victim.stunscalar) && isDefined(time))
      time = time * victim.stunscalar;

    _id_C52FFAED35E604DD = scripts\engine\utility::ter_op(isDefined(attacker.owner), attacker.owner, attacker);
    _id_F2AE11D4D6442540 = scripts\engine\utility::ter_op(isDefined(victim.owner), victim.owner, victim);

    if(isPlayer(_id_C52FFAED35E604DD) && _id_C52FFAED35E604DD != victim)
      attacker _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(_id_C52FFAED35E604DD, _id_F2AE11D4D6442540))) {
      victim scripts\cp_mp\challenges::resistedstun(_id_C52FFAED35E604DD);
      scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_tac_resist");
    }
  } else if(!istrue(victim _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("stunned")))
    time = 0.0;

  if(victim scripts\mp\utility\game::ismatchstartprotected())
    time = time * 0.1;

  return time;
}

setweaponlaser() {
  if(isagent(self)) {
    return;
  }
  self endon("unsetWeaponLaser");
  wait 0.5;
  thread setweaponlaser_internal();
}

unsetweaponlaser() {
  self notify("unsetWeaponLaser");

  if(isDefined(self.perkweaponlaseron) && self.perkweaponlaseron)
    scripts\mp\utility\weapon::disableweaponlaser();

  self.perkweaponlaseron = undefined;
  self.perkweaponlaseroffforswitchstart = undefined;
}

setweaponlaser_waitforlaserweapon(weapon) {
  weapon = getweaponbasename(weapon);

  for(;;) {
    if(isDefined(weapon) && (weapon == "iw6_kac_mp" || weapon == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", objweapon);
    weapon = objweapon.basename;
  }
}

setweaponlaser_internal() {
  self endon("death_or_disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  weapon = self getcurrentweapon();

  for(;;) {
    setweaponlaser_waitforlaserweapon(weapon);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      scripts\mp\utility\weapon::enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1.0);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change");

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      scripts\mp\utility\weapon::disableweaponlaser();
    }
  }
}

setweaponlaser_monitorweaponswitchstart(_id_57052F010A23838F) {
  self endon("weapon_change");

  for(;;) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(_id_57052F010A23838F);
  }
}

setweaponlaser_onweaponswitchstart(_id_57052F010A23838F) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    scripts\mp\utility\weapon::disableweaponlaser();
  }

  wait(_id_57052F010A23838F);
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    scripts\mp\utility\weapon::enableweaponlaser();
  }
}

setweaponlaser_monitorads() {
  self endon("weapon_change");

  for(;;) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self playerads() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          scripts\mp\utility\weapon::disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        scripts\mp\utility\weapon::enableweaponlaser();
      }
    }

    waitframe();
  }
}

setsteadyaimpro() {
  self setaimspreadmovementscale(0.5);
}

unsetsteadyaimpro() {
  self notify("end_SteadyAimPro");
  self setaimspreadmovementscale(1.0);
}

perkusedeathtracker() {
  self endon("disconnect");
  self waittill("death");
  self._useperkenabled = undefined;
}

setendgame() {
  if(isDefined(self.endgame)) {
    return;
  }
  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth") * 4;
  self.health = self.maxhealth;
  self.endgame = 1;
  self.attackertable[0] = "";
  self visionsetnakedforplayer("end_game", 5);
  thread endgamedeath(7);
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

unsetendgame() {
  self notify("stopEndGame");
  self.endgame = undefined;
  scripts\mp\utility\player::restorebasevisionset(1);

  if(!isDefined(self.endgametimer)) {
    return;
  }
  self.endgametimer scripts\mp\hud_util::destroyelem();
  self.endgameicon scripts\mp\hud_util::destroyelem();
}

endgamedeath(duration) {
  self endon("death_or_disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait(duration + 1);
  scripts\mp\utility\damage::_suicide();
}

setsaboteur() {
  self.objectivescaler = 1.2;
}

unsetsaboteur() {
  self.objectivescaler = 1;
}

setcombatspeed() {
  self endon("death_or_disconnect");
  self endon("unsetCombatSpeed");
  self.incombatspeed = 0;
  unsetcombatspeedscalar();

  for(;;) {
    self waittill("damage", dmg, attacker);

    if(!isDefined(attacker.team)) {
      continue;
    }
    if(level.teambased && attacker.team == self.team) {
      continue;
    }
    if(self.incombatspeed) {
      continue;
    }
    setcombatspeedscalar();
    self.incombatspeed = 1;
    thread endofspeedwatcher();
  }
}

endofspeedwatcher() {
  self notify("endOfSpeedWatcher");
  self endon("endOfSpeedWatcher");
  self endon("death_or_disconnect");
  self waittill("healed");
  unsetcombatspeedscalar();
  self.incombatspeed = 0;
}

setcombatspeedscalar() {
  if(self.weaponspeed <= 0.8)
    self.combatspeedscalar = 1.4;
  else if(self.weaponspeed <= 0.9)
    self.combatspeedscalar = 1.3;
  else
    self.combatspeedscalar = 1.2;

  scripts\mp\weapons::updatemovespeedscale();
}

unsetcombatspeedscalar() {
  self.combatspeedscalar = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetcombatspeed() {
  unsetcombatspeedscalar();
  self notify("unsetCombatSpeed");
}

setlightweight() {
  if(!isDefined(self.cranked)) {
    self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
    scripts\mp\weapons::updatemovespeedscale();
  }
}

unsetlightweight() {
  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

setblackbox() {}

unsetblackbox() {}

setsteelnerves() {
  scripts\mp\utility\perk::giveperk("specialty_bulletaccuracy");
  scripts\mp\utility\perk::giveperk("specialty_holdbreath");
}

unsetsteelnerves() {
  scripts\mp\utility\perk::removeperk("specialty_bulletaccuracy");
  scripts\mp\utility\perk::removeperk("specialty_holdbreath");
}

setdelaymine() {}

unsetdelaymine() {}

setlocaljammer() {
  if(scripts\cp_mp\emp_debuff::is_empd())
    self makescrambler();
}

unsetlocaljammer() {
  self clearscrambler();
}

setthermal() {
  self thermalvisionon();
}

unsetthermal() {
  self thermalvisionoff();
}

setonemanarmy() {
  thread onemanarmyweaponchangetracker();
}

unsetonemanarmy() {
  self notify("stop_oneManArmyTracker");
}

onemanarmyweaponchangetracker() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");

  for(;;) {
    self waittill("weapon_change", objweapon);

    if(objweapon.basename != "onemanarmy_mp") {
      continue;
    }
    thread selectonemanarmyclass();
  }
}

isonemanarmymenu(menu) {
  if(menu == game["menu_onemanarmy"])
    return 1;

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && menu == game["menu_onemanarmy_defaults_splitscreen"])
    return 1;

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && menu == game["menu_onemanarmy_custom_splitscreen"])
    return 1;

  return 0;
}

selectonemanarmyclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_3B64EB40368C1450::set("one_man_army", "weapon_switch", 0);
  _id_3B64EB40368C1450::set("one_man_army", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("one_man_army", "usability", 0);
  thread closeomamenuondeath();
  self waittill("menuresponse", menu, classname);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("one_man_army");

  if(classname == "back" || !isonemanarmymenu(menu) || scripts\mp\utility\player::isusingremote()) {
    currentweapon = self getcurrentweapon();

    if(currentweapon.basename == "onemanarmy_mp") {
      _id_3B64EB40368C1450::set("one_man_army", "weapon_switch", 0);
      _id_3B64EB40368C1450::set("one_man_army", "offhand_weapons", 0);
      _id_3B64EB40368C1450::set("one_man_army", "usability", 0);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(scripts\mp\utility\inventory::getlastweapon());
      self waittill("weapon_change");
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("one_man_army");
    }

    return;
  }

  thread giveonemanarmyclass(classname);
}

closeomamenuondeath() {
  self endon("menuresponse");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("one_man_army");
}

giveonemanarmyclass(classname) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\perk::_hasperk("specialty_omaquickchange")) {
    _id_6C684605FBBF1781 = 3.0;
    scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc");
  } else {
    _id_6C684605FBBF1781 = 6.0;
    scripts\cp_mp\utility\player_utility::playplayerandnpcsounds(self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc");
  }

  thread omausebar(_id_6C684605FBBF1781);
  _id_3B64EB40368C1450::set("one_man_army", "weapon_switch", 0);
  _id_3B64EB40368C1450::set("one_man_army", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("one_man_army", "usability", 0);
  wait(_id_6C684605FBBF1781);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("one_man_army");
  scripts\mp\class::giveloadout(self.pers["team"], classname);

  if(isDefined(self.carryflag))
    self attach(self.carryflag, "J_spine4", 1);

  self notify("changed_kit");
  level notify("changed_kit");
  scripts\mp\rank::tryresetrankxp();
}

omausebar(duration) {
  self endon("disconnect");
  _id_B15BCCA3144FD7DD = scripts\mp\hud_util::createprimaryprogressbar();
  _id_721E3650DE671DA6 = scripts\mp\hud_util::createprimaryprogressbartext();
  _id_721E3650DE671DA6 settext(&"MPUI_CHANGING_KIT");
  _id_B15BCCA3144FD7DD scripts\mp\hud_util::updatebar(0, 1 / duration);

  for(waitedtime = 0; waitedtime < duration && isalive(self) && !level.gameended; waitedtime = waitedtime + 0.05)
    wait 0.05;

  _id_B15BCCA3144FD7DD scripts\mp\hud_util::destroyelem();
  _id_721E3650DE671DA6 scripts\mp\hud_util::destroyelem();
}

setafterburner() {
  self energy_setrestorerate(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 600, 1000));
  self energy_setresttimems(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 750, 750));
}

unsetafterburner() {
  self energy_setrestorerate(0, 400);
  self energy_setresttimems(0, 900);
}

setfreefall() {}

unsetfreefall() {}

settacticalinsertion() {
  scripts\mp\equipment::giveequipment("equip_tac_insert", "secondary");
}

unsettacticalinsertion() {}

setpainted(attacker) {
  if(isPlayer(self)) {
    outlinetime = 0.5;

    if(!scripts\mp\utility\perk::_hasperk("specialty_engineer") && !scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      self.painted = 1;
      id = scripts\mp\utility\outline::outlineenableforplayer(self, attacker, "outline_nodepth_orange", "perk");
      thread watchpainted(id, outlinetime);
      thread watchpaintedagain(id);
    }
  }
}

watchpainted(id, timeout) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(timeout, "death");
  self.painted = 0;
  scripts\mp\utility\outline::outlinedisable(id, self);
  self notify("painted_end");
}

watchpaintedagain(id) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("painted_again", "painted_end");
  scripts\mp\utility\outline::outlinedisable(id, self);
}

ispainted() {
  return isDefined(self.painted) && self.painted;
}

setassists() {}

unsetassists() {}

setrefillgrenades() {
  if(isDefined(self.primarygrenade))
    self givemaxammo(self.primarygrenade);

  if(isDefined(self.secondarygrenade))
    self givemaxammo(self.secondarygrenade);
}

unsetrefillgrenades() {}

setrefillammo() {
  if(isDefined(self.primaryweapon))
    self givemaxammo(self.primaryweapon);

  if(isDefined(self.secondaryweapon))
    self givemaxammo(self.secondaryweapon);
}

unsetrefillammo() {}

setcomexp() {}

unsetcomexp() {}

settagger() {
  thread settaggerinternal();
}

settaggerinternal() {
  self endon("death_or_disconnect");
  self endon("unsetTagger");
  level endon("game_ended");

  for(;;) {
    self waittill("eyesOn");
    _id_804646EF19A59C8C = self getplayerssightingme();

    foreach(_id_6EE5484560EC747C in _id_804646EF19A59C8C) {
      if(level.teambased && _id_6EE5484560EC747C.team == self.team) {
        continue;
      }
      if(isalive(_id_6EE5484560EC747C) && _id_6EE5484560EC747C.sessionstate == "playing") {
        if(!isDefined(_id_6EE5484560EC747C.perkoutlined))
          _id_6EE5484560EC747C.perkoutlined = 0;

        if(!_id_6EE5484560EC747C.perkoutlined)
          _id_6EE5484560EC747C.perkoutlined = 1;

        _id_6EE5484560EC747C thread outlinewatcher(self);
      }
    }
  }
}

outlinewatcher(victim) {
  self endon("death_or_disconnect");
  self endon("eyesOff");
  level endon("game_ended");

  for(;;) {
    _id_2811CDF4BB4D6F6B = 1;
    _id_804646EF19A59C8C = victim getplayerssightingme();

    foreach(_id_6EE5484560EC747C in _id_804646EF19A59C8C) {
      if(_id_6EE5484560EC747C == self) {
        _id_2811CDF4BB4D6F6B = 0;
        break;
      }
    }

    if(_id_2811CDF4BB4D6F6B) {
      self.perkoutlined = 0;
      self notify("eyesOff");
    }

    wait 0.5;
  }
}

unsettagger() {
  self notify("unsetTagger");
}

setpitcher() {
  thread setpitcherinternal();
}

setpitcherinternal() {
  self endon("death_or_disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");
  self setgrenadecookscale(1.5);

  for(;;) {
    self setgrenadethrowscale(1.25);
    self waittill("grenade_pullback", objweapon);
    _id_15E599DA51A42FC2 = objweapon.basename;

    if(_id_15E599DA51A42FC2 == "airdrop_marker_mp" || _id_15E599DA51A42FC2 == "deployable_vest_marker_mp" || _id_15E599DA51A42FC2 == "deployable_weapon_crate_marker_mp")
      self setgrenadethrowscale(1);

    self waittill("grenade_fire", grenade, objweapon);
  }
}

unsetpitcher() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  self notify("unsetPitcher");
}

setboom() {}

setboominternal(attacker) {
  self endon("death_or_disconnect");
  self endon("unsetBoom");
  level endon("game_ended");
  attacker endon("death_or_disconnect");
  waitframe();
  triggerportableradarping(self.origin, attacker, 800, 1500);
  attacker boomtrackplayers(self.origin, self);
}

boomtrackplayers(targetpos, victim) {
  _id_0D1FFADFCF776BBC = scripts\common\utility::playersinsphere(targetpos, 700);

  foreach(player in _id_0D1FFADFCF776BBC) {
    if(victim == player) {
      continue;
    }
    if(scripts\cp_mp\utility\player_utility::isenemy(player) && isalive(player) && !player scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {}
  }
}

boomtrackplayerdeath(attacker, id) {
  self endon("disconnect");
  attacker endon("removearchetype");
  msg = scripts\engine\utility::waittill_any_timeout_1(7.0, "death");

  if(msg == "timeout" && isDefined(self.markedbyboomperk[id]))
    self.markedbyboomperk[id] = undefined;
  else {
    self waittill("spawned_player");
    self.markedbyboomperk = undefined;
  }
}

unsetboom() {
  self notify("unsetBoom");
}

customjuiced(waittime) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("unset_custom_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.1;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\perk::giveperk("specialty_fastreload");
  scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  scripts\mp\utility\perk::giveperk("specialty_stalker");
  scripts\mp\utility\perk::giveperk("specialty_fastoffhand");
  scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::giveperk("specialty_quickswap");
  thread unsetcustomjuicedondeath();
  thread unsetcustomjuicedonride();
  thread unsetcustomjuicedonmatchend();
  endtime = waittime * 1000 + gettime();

  if(!isai(self)) {}

  wait(waittime);
  unsetcustomjuiced();
}

unsetcustomjuiced(death) {
  if(!isDefined(death)) {
    self.movespeedscaler = 1;

    if(scripts\mp\utility\perk::_hasperk("specialty_lightweight"))
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_stalker");
  scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self.isjuiced = undefined;

  if(!isai(self)) {}

  self notify("unset_custom_juiced");
}

unsetcustomjuicedonride() {
  self endon("disconnect");
  self endon("unset_custom_juiced");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::isusingremote()) {
      thread unsetcustomjuiced();
      break;
    }
  }
}

unsetcustomjuicedondeath() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  scripts\engine\utility::waittill_any_2("death", "faux_spawn");
  thread unsetcustomjuiced(1);
}

unsetcustomjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level scripts\engine\utility::waittill_any_2("round_end_finished", "game_ended");
  thread unsetcustomjuiced();
}

settriggerhappy() {}

settriggerhappyinternal() {
  self endon("death_or_disconnect");
  self endon("unsetTriggerHappy");
  level endon("game_ended");
  objweapon = self.lastdroppableweaponobj;
  _id_4FE33EF2E789F809 = self getweaponammostock(objweapon);
  _id_B94F757213C141BF = self getweaponammoclip(objweapon);
  self givestartammo(objweapon);
  _id_F34E7874E06F27EF = self getweaponammoclip(objweapon);
  _id_C3A9683CE4AA1D00 = _id_F34E7874E06F27EF - _id_B94F757213C141BF;
  _id_91AAEECA66E5F1DC = _id_4FE33EF2E789F809 - _id_C3A9683CE4AA1D00;

  if(_id_C3A9683CE4AA1D00 > _id_4FE33EF2E789F809) {
    self setweaponammoclip(objweapon, _id_B94F757213C141BF + _id_4FE33EF2E789F809);
    _id_91AAEECA66E5F1DC = 0;
  }

  self setweaponammostock(objweapon, _id_91AAEECA66E5F1DC);
  self playlocalsound("ammo_crate_use", undefined, undefined, 1);
  self setclientomnvar("ui_trigger_happy", 1);
  wait 0.2;
  self setclientomnvar("ui_trigger_happy", 0);
}

unsettriggerhappy() {
  self setclientomnvar("ui_trigger_happy", 0);
  self notify("unsetTriggerHappy");
}

setincog() {}

unsetincog() {}

setblindeye() {}

unsetblindeye() {}

setquickswap() {}

unsetquickswap() {}

setextraammo() {
  self endon("death_or_disconnect");
  self endon("unset_extraammo");
  level endon("game_ended");

  if(self.gettingloadout)
    self waittill("giveLoadout");

  _id_504C8A35BDE48A6A = scripts\mp\utility\weapon::getvalidextraammoweapons();

  foreach(primary in _id_504C8A35BDE48A6A) {
    if(isDefined(primary) && !isnullweapon(primary) && primary hasattachment("maxammo") && !istrue(primary.first_equipped)) {
      self givemaxammo(primary);
      primary.first_equipped = 1;
    }
  }
}

unsetextraammo() {
  self notify("unset_extraammo");
}

setextradeadly() {
  self endon("death_or_disconnect");
  self endon("unset_extradeadly");
  level endon("game_ended");
  giveammo = 1;

  if(self.gettingloadout)
    self waittill("giveLoadout");
  else
    giveammo = istrue(level._id_0EECCF9E10242815);

  ref = scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(ref) && ref != "none" && giveammo)
    scripts\mp\equipment::incrementequipmentammo(ref);
}

unsetextradeadly() {
  self notify("unset_extradeadly");
}

setbattleslide() {}

unsetbattleslide() {}

setoverkill() {}

unsetoverkill() {}

setactivereload() {}

unsetactivereload() {}

setlifepack() {
  if(!isDefined(level._effect["life_pack_pickup"]))
    level._effect["life_pack_pickup"] = undefined;

  thread watchlifepackkills();
}

watchlifepackkills() {
  self endon("death_or_disconnect");
  self notify("unset_lifepack");
  self endon("unset_lifepack");

  for(;;) {
    self waittill("got_a_kill", victim, weapon, meansofdeath);
    _id_FB1DEF007972B25A = self.origin;
    triggerradius = 20;
    triggerheight = 20;
    _id_A703DCD6CCF2164E = spawn("script_model", self.origin + (0, 0, 10));
    _id_A703DCD6CCF2164E setModel("weapon_life_pack");
    _id_A703DCD6CCF2164E.owner = self;
    _id_A703DCD6CCF2164E.team = self.team;
    _id_A703DCD6CCF2164E hidefromplayer(self);
    _id_4529D94A150D03F6 = spawn("trigger_radius", self.origin, 0, triggerradius, triggerheight);
    _id_4529D94A150D03F6 thread watchlifepackuse(_id_A703DCD6CCF2164E);
    _id_4529D94A150D03F6 thread watchlifepackdeath(_id_A703DCD6CCF2164E);
    _id_A703DCD6CCF2164E thread hoverlifepack();
    _id_A703DCD6CCF2164E rotateYaw(1000, 30, 0.2, 0.2);
    _id_A703DCD6CCF2164E thread watchlifepacklifetime(10, _id_4529D94A150D03F6);
    _id_A703DCD6CCF2164E thread watchlifepackowner();

    foreach(player in level.players)
    _id_A703DCD6CCF2164E setlifepackvisualforplayer(player);
  }
}

activatelifepackboost(owner, duration, _id_771A57DA68A81EF8) {
  self.lifeboostactive = 1;

  if(isDefined(duration) && duration > 0)
    thread watchlifepackboostlifetime(duration);

  if(isDefined(_id_771A57DA68A81EF8) && _id_771A57DA68A81EF8)
    thread watchlifepackuserdeath();

  scripts\mp\utility\perk::giveperk("specialty_regenfaster");
  self setclientomnvar("ui_life_link", 1);
  self notify("enabled_life_pack_boost");
  self.lifepackowner = owner;
  scripts\mp\gamescore::trackbuffassist(owner, self, "medic_lifepack");
}

watchlifepackboostlifetime(duration) {
  self endon("death_or_disconnect");
  wait(duration);

  if(isDefined(self.lifeboostactive))
    disablelifepackboost();
}

disablelifepackboost() {
  if(isDefined(self) && isDefined(self.lifeboostactive)) {
    self.lifeboostactive = undefined;
    self setclientomnvar("ui_life_link", 0);
    self notify("disabled_life_pack_boost");
    scripts\mp\utility\perk::removeperk("specialty_regenfaster");
    scripts\mp\gamescore::untrackbuffassist(self.lifepackowner, self, "medic_lifepack");
    self.lifepackowner = undefined;
  }
}

setlifepackvisualforplayer(player) {
  if(level.teambased && player.team == self.team && player != self.owner) {
    setlifepackoutlinestate(player);
    self showtoplayer(player);
    thread watchlifepackoutlinestate(player);
  } else
    self hidefromplayer(player);
}

setlifepackoutlinestate(player) {
  if(isDefined(player.lifeboostactive)) {
    if(isDefined(player.lifepackoutlines) && player.lifepackoutlines.size > 0) {
      foreach(outline in player.lifepackoutlines) {
        if(self == outline.pack) {
          scripts\mp\utility\outline::outlinedisable(outline.id, outline.pack);
          player.lifepackoutlines = scripts\engine\utility::array_remove(player.lifepackoutlines, outline);
          outline = undefined;
        }
      }
    }
  } else {
    if(!isDefined(player.lifepackoutlines))
      player.lifepackoutlines = [];

    _id_FE215D90A7B55680 = spawnStruct();
    _id_FE215D90A7B55680.id = scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_depth_cyan", "equipment");
    _id_FE215D90A7B55680.pack = self;
    player.lifepackoutlines = scripts\engine\utility::array_add_safe(player.lifepackoutlines, _id_FE215D90A7B55680);
  }
}

watchlifepackoutlinestate(player) {
  self endon("death");

  for(;;) {
    player scripts\engine\utility::waittill_any_2("enabled_life_pack_boost", "disabled_life_pack_boost");
    setlifepackoutlinestate(player);
  }
}

hoverlifepack() {
  self endon("death");
  self endon("phase_resource_pickup");
  _id_044F54E26BFE2399 = self.origin;

  for(;;) {
    self moveTo(_id_044F54E26BFE2399 + (0, 0, 15), 1, 0.2, 0.2);
    wait 1;
    self moveTo(_id_044F54E26BFE2399, 1, 0.2, 0.2);
    wait 1;
  }
}

watchlifepackuse(_id_A703DCD6CCF2164E) {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(player.team != _id_A703DCD6CCF2164E.team) {
      continue;
    }
    if(isDefined(player.lifeboostactive)) {
      continue;
    }
    if(player == _id_A703DCD6CCF2164E.owner) {
      continue;
    }
    player activatelifepackboost(_id_A703DCD6CCF2164E.owner, 5, 1);
    player playlocalsound("scavenger_pack_pickup");
    _id_CFB12209847BC60C = spawnfx(scripts\engine\utility::getfx("life_pack_pickup"), self.origin);
    triggerfx(_id_CFB12209847BC60C);
    _id_CFB12209847BC60C thread scripts\mp\utility\script::delayentdelete(2);

    foreach(_id_6EE5484560EC747C in level.players) {
      if(_id_6EE5484560EC747C.team == player.team) {
        continue;
      }
      _id_CFB12209847BC60C hidefromplayer(_id_6EE5484560EC747C);
    }

    _id_A703DCD6CCF2164E delete();
  }
}

watchlifepackdeath(_id_A703DCD6CCF2164E) {
  self endon("death");
  _id_A703DCD6CCF2164E waittill("death");

  if(isDefined(self))
    self delete();
}

watchlifepacklifetime(lifetime, _id_4529D94A150D03F6) {
  self endon("death");
  wait(lifetime);
  _id_4529D94A150D03F6 delete();
  self delete();
}

watchlifepackowner() {
  self endon("death");
  self.owner waittill("disconnect");

  if(isDefined(self))
    self delete();
}

watchlifepackuserdeath() {
  self endon("disconnect");
  self waittill("death");
  disablelifepackboost();
}

unsetlifepack() {
  disablelifepackboost();
  self notify("unset_lifepack");
}

settoughenup() {
  if(!isDefined(level._effect["toughen_up_screen"]))
    level._effect["toughen_up_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_toughen_up_scrn");

  thread watchtoughenup();
}

watchtoughenup() {
  self endon("death_or_disconnect");
  self endon("unsetToughenUp");
  level endon("game_ended");
  _id_A40F9C47F4C838D5 = 0;
  _id_FF2E69FEFF3A395B = 15;
  _id_6A48C4A0C488C4C3 = 7.5;
  _id_74874432BF895240 = 4;
  _id_E02FF688B6F712BB = 5;
  _id_4E01B7D6147E61A0 = 2;
  _id_D601FF4572D88D47 = [];
  _id_D601FF4572D88D47 = scripts\engine\utility::array_add_safe(_id_D601FF4572D88D47, (35, 0, 10));
  _id_D601FF4572D88D47 = scripts\engine\utility::array_add_safe(_id_D601FF4572D88D47, (0, 35, 10));
  _id_D601FF4572D88D47 = scripts\engine\utility::array_add_safe(_id_D601FF4572D88D47, (-35, 0, 10));
  _id_D601FF4572D88D47 = scripts\engine\utility::array_add_safe(_id_D601FF4572D88D47, (0, -35, 10));
  self waittill("spawned_player");

  for(;;) {
    self waittill("got_a_kill", victim, weapon, meansofdeath);

    if(!isDefined(self.toughenedup)) {
      self.toughenedup = 1;
      _id_5D646DCC86509253 = spawnfxforclient(scripts\engine\utility::getfx("toughen_up_screen"), self getEye(), self);
      triggerfx(_id_5D646DCC86509253);
      thread attachtoughenuparmor("j_forehead", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_ri", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_spineupper", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_shield_back", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_ri", level.bulletstormshield["section"].friendlymodel);

      if(_id_4E01B7D6147E61A0 == 1) {
        scripts\mp\utility\damage::sethealthshield(_id_FF2E69FEFF3A395B);
        thread watchtoughenuplifetime(_id_E02FF688B6F712BB);
      } else {
        scripts\mp\lightarmor::setlightarmorvalue(self, 100);
        thread watchtoughenuplightarmorend();
      }

      _id_5D646DCC86509253 thread watchtoughenupplayerend(self);
      continue;
    }

    if(_id_4E01B7D6147E61A0 == 1) {
      self notify("toughen_up_reset");
      thread watchtoughenuplifetime(_id_E02FF688B6F712BB);
    }
  }
}

attachtoughenuparmor(tag, model, _id_F9CBFF5134DA960B, _id_B092096C70BCC8E4, _id_20EDA1C880EBE5FC) {
  _id_9CCC24389A9EDDEE = self gettagorigin(tag);
  _id_B859A81007DB9551 = spawn("script_model", _id_9CCC24389A9EDDEE);
  _id_B859A81007DB9551 setModel(model);
  _id_1E2F2224127D2990 = (0, 0, 0);
  anglesoffset = (0, 0, 0);

  if(isDefined(_id_F9CBFF5134DA960B))
    _id_1E2F2224127D2990 = _id_F9CBFF5134DA960B;

  if(isDefined(_id_B092096C70BCC8E4))
    anglesoffset = _id_B092096C70BCC8E4;

  _id_B859A81007DB9551.angles = self.angles;
  _id_B859A81007DB9551 linkTo(self, tag, _id_1E2F2224127D2990, anglesoffset);
  _id_B859A81007DB9551 thread watchtoughenupplayerend(self);
  _id_B859A81007DB9551 thread watchtoughenupgameend();
  return _id_B859A81007DB9551;
}

settoughenupmodel(_id_028476F7CD7B8999, _id_DA3BC1CA83216E9F, _id_A40F9C47F4C838D5, _id_20EDA1C880EBE5FC) {
  _id_B859A81007DB9551 = spawn("script_model", self.origin + (0, 0, 50));
  _id_B859A81007DB9551.team = self.owner.team;

  if(_id_20EDA1C880EBE5FC == "friendly")
    _id_B859A81007DB9551 setModel(level.bulletstormshield["section"].friendlymodel);
  else
    _id_B859A81007DB9551 setModel(level.bulletstormshield["section"].enemymodel);

  _id_B859A81007DB9551 linkTo(self, "tag_origin", _id_DA3BC1CA83216E9F, (0, 90 * (_id_A40F9C47F4C838D5 + 1), 0));
  _id_B859A81007DB9551 hide();
  _id_B859A81007DB9551 thread watchtoughenupplayerend(self.owner);
  _id_B859A81007DB9551 thread watchtoughenupgameend();
  _id_B859A81007DB9551 thread settoughenupvisiblestate(_id_20EDA1C880EBE5FC, self.owner);
}

watchtoughenuplightarmorend() {
  self endon("disconnect");
  self waittill("remove_light_armor");
}

watchtoughenupplayerend(owner) {
  self endon("death");
  owner scripts\engine\utility::waittill_any_2("death_or_disconnect", "toughen_up_end");
  owner.toughenedup = undefined;

  if(owner scripts\mp\lightarmor::haslightarmor(owner))
    owner unsetlightarmor();

  if(isDefined(self))
    self delete();
}

watchtoughenupgameend() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self))
    self delete();
}

watchtoughenuplifetime(lifetime) {
  self endon("death");
  self endon("toughen_up_reset");

  while(lifetime > 0) {
    lifetime = lifetime - 1;
    wait 1;
  }

  self notify("toughen_up_end");
}

settoughenupvisiblestate(_id_20EDA1C880EBE5FC, owner) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player == owner) {
      continue;
    }
    if(canshowtoughenupshield(player, _id_20EDA1C880EBE5FC))
      self showtoplayer(player);

    thread watchtoughenupplayerbegin(player, _id_20EDA1C880EBE5FC);
  }
}

watchtoughenupplayerbegin(player, _id_20EDA1C880EBE5FC) {
  player endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    player waittill("spawned_player");
    self hidefromplayer(player);

    if(canshowtoughenupshield(player, _id_20EDA1C880EBE5FC))
      self showtoplayer(player);
  }
}

canshowtoughenupshield(player, _id_20EDA1C880EBE5FC) {
  _id_0B10A7206CD00B51 = 0;

  if(_id_20EDA1C880EBE5FC == "friendly" && player.team == self.team || _id_20EDA1C880EBE5FC == "enemy" && player.team != self.team)
    _id_0B10A7206CD00B51 = 1;

  return _id_0B10A7206CD00B51;
}

unsettoughenup() {
  scripts\mp\utility\damage::clearhealthshield();
  unsetlightarmor();
  self notify("unsetToughenUp");
}

setscoutping() {
  thread updatescoutping();
}

updatescoutping() {
  self endon("death_or_disconnect");
  self endon("unsetScoutPing");
  _id_1C1158E87E764422 = 50;
  _id_B45893C03493D1F5 = 1200;

  for(;;) {
    _id_9F47268324F609B3 = _id_1C1158E87E764422;
    _id_FF9D6502D5D4DC7A = _id_B45893C03493D1F5;

    if(isDefined(self.scoutpingradius))
      _id_9F47268324F609B3 = self.scoutpingradius;

    if(isDefined(self.scoutsweeptime))
      _id_FF9D6502D5D4DC7A = self.scoutsweeptime;

    _id_9F47268324F609B3 = int(_id_9F47268324F609B3);
    _id_FF9D6502D5D4DC7A = int(_id_FF9D6502D5D4DC7A);

    if(_id_9F47268324F609B3 != _id_1C1158E87E764422)
      triggerportableradarpingteam(self.origin, self.team, _id_9F47268324F609B3, _id_FF9D6502D5D4DC7A);

    wait(_id_B45893C03493D1F5 / 1200);
  }
}

updatescoutpingvalues(_id_E7EADB93AD92EBB7) {
  _id_6B41470FD5B3FBB4 = 0;
  _id_9F47268324F609B3 = 150;
  _id_5888FE9DAC2D7D8E = 3000;

  if(isDefined(self.scoutpingmod))
    _id_6B41470FD5B3FBB4 = self.scoutpingmod;

  if(isDefined(self.scoutpingpreviousstage)) {
    if(_id_E7EADB93AD92EBB7 > self.scoutpingpreviousstage) {
      _id_301D62DA1A0738F1 = _id_E7EADB93AD92EBB7 - self.scoutpingpreviousstage;
      _id_6B41470FD5B3FBB4 = _id_6B41470FD5B3FBB4 + _id_301D62DA1A0738F1 / 10;
    } else if(_id_E7EADB93AD92EBB7 < self.scoutpingpreviousstage) {
      _id_301D62DA1A0738F1 = self.scoutpingpreviousstage - _id_E7EADB93AD92EBB7;
      _id_6B41470FD5B3FBB4 = _id_6B41470FD5B3FBB4 - _id_301D62DA1A0738F1 / 10;
    }
  }

  if(isDefined(self.scoutpingmod)) {
    if(_id_6B41470FD5B3FBB4 > self.scoutpingmod || _id_6B41470FD5B3FBB4 < self.scoutpingmod) {
      _id_9F47268324F609B3 = _id_9F47268324F609B3 + _id_9F47268324F609B3 * _id_6B41470FD5B3FBB4 * 1.5;
      _id_5888FE9DAC2D7D8E = _id_5888FE9DAC2D7D8E - _id_5888FE9DAC2D7D8E * _id_6B41470FD5B3FBB4 / 1.5;
      self.scoutpingradius = _id_9F47268324F609B3;
      self.scoutsweeptime = _id_5888FE9DAC2D7D8E;
    }
  }

  if(_id_E7EADB93AD92EBB7 == 0) {
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
  }

  self.scoutpingmod = _id_6B41470FD5B3FBB4;
  self.scoutpingpreviousstage = _id_E7EADB93AD92EBB7;
}

unsetscoutping() {
  self.scoutpingradius = undefined;
  self.scoutsweeptime = undefined;
  self.scoutpingmod = undefined;
  self.scoutpingpreviousstage = undefined;
  self notify("unsetScoutPing");
}

setphasespeed() {
  thread watchphasespeedshift();
  thread watchphasespeedendshift();
}

watchphasespeedshift() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("phase_shift_start");
    self.phasespeedmod = 0.2;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

watchphasespeedendshift() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("phase_shift_completed");
    self.phasespeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

unsetphasespeed() {
  self.phasespeedmod = undefined;
}

setdodge() {
  self allowdodge(1);
}

unsetdodge() {
  self allowdodge(0);
}

setextradodge() {
  self energy_setmax(1, 100);
  self energy_setenergy(1, 100);
}

unsetextradodge() {
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
}

sixthsense_shouldwarnaboutotherplayer(_id_6EE5484560EC747C) {
  if(!scripts\mp\utility\perk::_hasperk("specialty_sixth_sense"))
    return 0;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(!isDefined(_id_6EE5484560EC747C))
    return 0;

  if(!_id_6EE5484560EC747C scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(_id_6EE5484560EC747C.team == self.team)
    return 0;

  if(distancesquared(_id_6EE5484560EC747C.origin, self.origin) > 16000000)
    return 0;

  if(_id_6EE5484560EC747C scripts\mp\utility\perk::_hasperk("specialty_sixth_sense_immune"))
    return 0;

  vehicle = _id_6EE5484560EC747C scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle) && isDefined(vehicle.vehiclename)) {
    _id_17915DB3DE174953 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(_id_6EE5484560EC747C);

    if(_id_17915DB3DE174953) {
      if(vehicle.vehiclename != "light_tank" && vehicle.vehiclename != "apc_russian")
        return 0;
    } else if(vehicle.vehiclename == "apc_russian")
      return 0;
  }

  if(_id_6EE5484560EC747C scripts\mp\utility\player::isusingremote()) {
    _id_7B0C72F7301EB1C4 = _id_6EE5484560EC747C scripts\mp\utility\player::getremotename();

    if(_id_7B0C72F7301EB1C4 == "gunship" || _id_7B0C72F7301EB1C4 == "radar_drone_recon" || _id_7B0C72F7301EB1C4 == "chopper_gunner" || _id_7B0C72F7301EB1C4 == "cruise_predator" || _id_7B0C72F7301EB1C4 == "assault_drone")
      return 0;
  }

  return 1;
}

sixthsense_inotherplayertargetcone(_id_6EE5484560EC747C, _id_1925D24D0AE333E6, _id_F5AA6039EFDCFF26, _id_ED6E173AA5E562A5) {
  _id_577D4BC399877AE4 = _id_1925D24D0AE333E6 - _id_F5AA6039EFDCFF26;
  dot = vectordot(_id_577D4BC399877AE4, _id_ED6E173AA5E562A5);

  if(dot <= 0)
    return 0;

  _id_33E2AF87C7B68CE8 = length(_id_577D4BC399877AE4);
  _id_A4B3B596DCF9790C = 12;
  _id_A4B3B596DCF9790C = _id_A4B3B596DCF9790C + -0.15 * sqrt(_id_33E2AF87C7B68CE8);
  _id_B6B1CD24E33B485F = scripts\engine\math::degrees_to_radians(_id_A4B3B596DCF9790C);
  _id_29F5E95C42138166 = 1 - 0.5 * _id_B6B1CD24E33B485F * _id_B6B1CD24E33B485F;

  if(dot < _id_29F5E95C42138166 * _id_33E2AF87C7B68CE8)
    return 0;

  return 1;
}

sixthsense_playerseesotherplayer(_id_10E9894DC0EB9765, _id_1925D24D0AE333E6, _id_F5AA6039EFDCFF26) {
  _id_7A25DDB41E7358DB = _id_F5AA6039EFDCFF26 - _id_1925D24D0AE333E6;
  dot = vectordot(_id_10E9894DC0EB9765, vectorNormalize(_id_7A25DDB41E7358DB));

  if(dot < 0.382683)
    return 1;

  return 0;
}

sixthsense_think_internal() {
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  _id_0C0269881CB3B186 = 0;
  _id_139C4666448FFEAC = getdvarint("scr_sixth_sense_use_eyes_on") == 1;
  _id_FA89613ACD0EB87E = 0;
  _id_7A25DDB41E7358DB = undefined;
  _id_0746071AB06F38FD = undefined;
  time = getsystemtimeinmicroseconds();

  foreach(num, player in level.sixth_sense_players) {
    if(!isDefined(player)) {
      level.sixth_sense_players[num] = undefined;
      break;
    }

    _id_75ABBF0830C5D3FA = 0;

    if(_id_139C4666448FFEAC && !isbot(player)) {
      if(!player scripts\mp\utility\perk::_hasperk("specialty_sixth_sense")) {
        continue;
      }
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      _id_24F9B94A171CCA52 = player scripts\mp\utility\player::getstancecenter();
      _id_CBFF770C2E560A93 = player getplayerssightingme();

      foreach(_id_6EE5484560EC747C in _id_CBFF770C2E560A93) {
        if(_id_FA89613ACD0EB87E >= 25) {
          _id_FA89613ACD0EB87E = 0;
          waitframe();
        }

        if(!isDefined(player)) {
          level.sixth_sense_players[num] = undefined;
          break;
        }

        if(!isDefined(_id_6EE5484560EC747C)) {
          continue;
        }
        if(!player sixthsense_shouldwarnaboutotherplayer(_id_6EE5484560EC747C)) {
          continue;
        }
        _id_FA89613ACD0EB87E++;
        _id_F5AA6039EFDCFF26 = _id_6EE5484560EC747C getvieworigin();
        _id_ED6E173AA5E562A5 = anglesToForward(_id_6EE5484560EC747C getplayerangles());

        if(!player sixthsense_inotherplayertargetcone(_id_6EE5484560EC747C, _id_24F9B94A171CCA52, _id_F5AA6039EFDCFF26, _id_ED6E173AA5E562A5)) {
          continue;
        }
        _id_75ABBF0830C5D3FA = _id_75ABBF0830C5D3FA | player getsixthsensedirection(_id_6EE5484560EC747C);
      }
    } else {
      _id_24F9B94A171CCA52 = player gettagorigin("j_spinelower");
      _id_64A457A19D7DAA44 = player getEye();
      _id_10E9894DC0EB9765 = anglesToForward(player getplayerangles());

      foreach(_id_6EE5484560EC747C in level.players) {
        if(_id_FA89613ACD0EB87E >= 25) {
          _id_FA89613ACD0EB87E = 0;
          waitframe();
        }

        if(!isDefined(player)) {
          level.sixth_sense_players[num] = undefined;
          break;
        }

        if(!isDefined(_id_6EE5484560EC747C)) {
          continue;
        }
        if(!player sixthsense_shouldwarnaboutotherplayer(_id_6EE5484560EC747C)) {
          continue;
        }
        _id_FA89613ACD0EB87E++;
        _id_F5AA6039EFDCFF26 = _id_6EE5484560EC747C getvieworigin();
        _id_ED6E173AA5E562A5 = anglesToForward(_id_6EE5484560EC747C getplayerangles());

        if(!player sixthsense_inotherplayertargetcone(_id_6EE5484560EC747C, _id_24F9B94A171CCA52, _id_F5AA6039EFDCFF26, _id_ED6E173AA5E562A5)) {
          continue;
        }
        if(sixthsense_playerseesotherplayer(_id_10E9894DC0EB9765, _id_24F9B94A171CCA52, _id_F5AA6039EFDCFF26)) {
          _id_FA89613ACD0EB87E = _id_FA89613ACD0EB87E + 2;
          ignoreents = [player];
          vehicle = _id_6EE5484560EC747C scripts\cp_mp\utility\player_utility::getvehicle();

          if(isDefined(vehicle)) {
            outlineents = getchildoutlineents(vehicle);

            foreach(ent in outlineents)
            ignoreents[ignoreents.size] = ent;
          }

          turret = _id_6EE5484560EC747C.currentturret;

          if(isDefined(turret))
            ignoreents[ignoreents.size] = turret;

          if(scripts\engine\trace::ray_trace_detail_passed(_id_F5AA6039EFDCFF26, _id_64A457A19D7DAA44, ignoreents, _id_FBCABD62B8F66EB8)) {
            _id_75ABBF0830C5D3FA = 255;
            break;
          }
        }
      }
    }

    player updatesixthsensevfx(_id_75ABBF0830C5D3FA);

    if(_id_75ABBF0830C5D3FA != 0) {
      _id_769BB62217827DD4 = "highalert_spotted";

      if(_id_75ABBF0830C5D3FA == 4 || _id_75ABBF0830C5D3FA == 128 || _id_75ABBF0830C5D3FA == 32)
        _id_769BB62217827DD4 = _id_769BB62217827DD4 + "_left";
      else if(_id_75ABBF0830C5D3FA == 1 || _id_75ABBF0830C5D3FA == 64 || _id_75ABBF0830C5D3FA == 8)
        _id_769BB62217827DD4 = _id_769BB62217827DD4 + "_right";

      _id_189B67B2735B981D::_id_55B08D6D71B41402(player, _id_769BB62217827DD4);

      if(getdvarint("dvar_9D4361BE8E1B02EE", 1)) {
        if((!isDefined(player._id_57EFB5BF50DC35EA) || gettime() > player._id_57EFB5BF50DC35EA) && isDefined(player.executionref) && scripts\cp_mp\execution::_id_700277400DCB7857(player.executionref)) {
          player._id_57EFB5BF50DC35EA = gettime() + getdvarint("dvar_505F54E32E56D815", 3000) + randomint(1000);

          if(getdvarint("dvar_87E6B1E56B17932A", 0))
            player playlocalsound("perk_iw9_high_alert_dog_growl");
          else
            player playsoundonmovingent("perk_iw9_high_alert_dog_growl");
        }
      }
    }
  }
}

sixthsense_think() {
  level endon("game_ended");
  level.sixth_sense_players = [];

  for(;;) {
    waitframe();
    sixthsense_think_internal();
  }
}

setsixthsense() {
  if(getdvarint("dvar_A013B18D3EE5CC85", 0) == 1) {
    return;
  }
  self.sixthsenselastactivetime = 0;
  self.sixthsensestate = 0;
  updatesixthsensevfx(0);
  _id_6EA8E24D4901E87C = self getentitynumber();
  level.sixth_sense_players[_id_6EA8E24D4901E87C] = self;
}

unsetsixthsense() {
  thread clearsixthsense();
}

clearsixthsense() {
  self endon("disconnect");
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("removeSixthSense");
  _id_6EA8E24D4901E87C = self getentitynumber();
  level.sixth_sense_players[_id_6EA8E24D4901E87C] = undefined;
  waitframe();
  updatesixthsensevfx(0);
}

setenhancedsixthsense() {}

unsetenhancedsixthsense() {}

updatesixthsensevfx(_id_75ABBF0830C5D3FA) {
  self setclientomnvar("ui_edge_glow", _id_75ABBF0830C5D3FA);
}

getsixthsensedirection(enemy) {
  forward = anglesToForward(self getplayerangles());
  _id_9D9E76097A59CB60 = (forward[0], forward[1], forward[2]);
  _id_9D9E76097A59CB60 = vectorNormalize(_id_9D9E76097A59CB60);
  _id_9001DA663C7CDFEC = enemy.origin - self.origin;
  _id_4720FAE3929BBDBA = (_id_9001DA663C7CDFEC[0], _id_9001DA663C7CDFEC[1], _id_9001DA663C7CDFEC[2]);
  _id_4720FAE3929BBDBA = vectorNormalize(_id_4720FAE3929BBDBA);
  dot = vectordot(_id_9D9E76097A59CB60, _id_4720FAE3929BBDBA);

  if(dot >= 0.92388)
    return 2;
  else if(dot >= 0.5)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 4, 1);
  else if(dot >= 0.5)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 128, 64);
  else if(dot >= -0.707107)
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, _id_9D9E76097A59CB60, enemy.origin), 32, 8);
  else
    return 16;
}

markassixthsensesource(_id_6EE5484560EC747C) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("markAsSixthSenseSource");
  self endon("markAsSixthSenseSource");
  _id_FE8F7703F6313ED4 = _id_6EE5484560EC747C getentitynumber();
  self.sixthsensesource[_id_FE8F7703F6313ED4] = 1;
  _id_6EE5484560EC747C scripts\engine\utility::waittill_any_in_array_or_timeout(["death"], 10);
  self.sixthsensesource[_id_FE8F7703F6313ED4] = 0;
}

setcamoelite() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");

  for(;;) {
    traces = 0;
    players = level.players;
    _id_FD9F8011E476976C = 0;

    foreach(_id_6EE5484560EC747C in players) {
      if(!isDefined(_id_6EE5484560EC747C) || !_id_6EE5484560EC747C scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(_id_6EE5484560EC747C.team == self.team) {
        continue;
      }
      if(_id_6EE5484560EC747C scripts\mp\utility\perk::_hasperk("specialty_empimmune")) {
        continue;
      }
      _id_577D4BC399877AE4 = self.origin - _id_6EE5484560EC747C.origin;
      _id_ED6E173AA5E562A5 = anglesToForward(_id_6EE5484560EC747C getplayerangles());
      dot = vectordot(_id_577D4BC399877AE4, _id_ED6E173AA5E562A5);

      if(dot <= 0) {
        continue;
      }
      _id_02A2E8DE350C69CA = vectorNormalize(_id_577D4BC399877AE4);
      _id_7E1A1E00D916674F = vectorNormalize(_id_ED6E173AA5E562A5);
      dot = vectordot(_id_02A2E8DE350C69CA, _id_7E1A1E00D916674F);

      if(dot < 12) {
        continue;
      }
      traces++;
      tracestart = _id_6EE5484560EC747C getEye();
      _id_8B39E5984DA1FFAF = self getEye();

      if(scripts\engine\trace::ray_trace_passed(tracestart, _id_8B39E5984DA1FFAF, self, scripts\engine\trace::create_default_contents(1))) {
        _id_FD9F8011E476976C = 1;
        break;
      }

      if(traces >= 10) {
        waitframe();
        traces = 0;
      }
    }

    updatecamoeliteoverlay(_id_FD9F8011E476976C);
    waitframe();
  }
}

updatecamoeliteoverlay(visible) {}

unsetcamoelite() {}

setcarepackage() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("airdrop_assault", 0, 0, self);
}

unsetcarepackage() {}

setuav() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("uav", 0, 0, self);
}

unsetuav() {}

setjuiced(waittime) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("unset_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.25;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\utility\perk::giveperk("specialty_fastreload");
  scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  scripts\mp\utility\perk::giveperk("specialty_stalker");
  scripts\mp\utility\perk::giveperk("specialty_fastoffhand");
  scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::giveperk("specialty_quickswap");
  thread unsetjuicedondeath();
  thread unsetjuicedonride();
  thread unsetjuicedonmatchend();

  if(!isDefined(waittime))
    waittime = 10;

  endtime = waittime * 1000 + gettime();

  if(!isai(self)) {}

  wait(waittime);
  unsetjuiced();
}

unsetjuiced(death) {
  if(!isDefined(death)) {
    self.movespeedscaler = 1;

    if(scripts\mp\utility\perk::_hasperk("specialty_lightweight"))
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_stalker");
  scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self.isjuiced = undefined;

  if(!isai(self)) {}

  self notify("unset_juiced");
}

unsetjuicedonride() {
  self endon("disconnect");
  self endon("unset_juiced");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::isusingremote()) {
      thread unsetjuiced();
      break;
    }
  }
}

unsetjuicedondeath() {
  self endon("disconnect");
  self endon("unset_juiced");
  scripts\engine\utility::waittill_any_2("death", "faux_spawn");
  thread unsetjuiced(1);
}

unsetjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_juiced");
  level scripts\engine\utility::waittill_any_2("round_end_finished", "game_ended");
  thread unsetjuiced();
}

hasjuiced() {
  return isDefined(self.isjuiced);
}

setcombathigh() {
  self endon("death_or_disconnect");
  self endon("unset_combathigh");
  level endon("end_game");
  self.damageblockedtotal = 0;

  if(level.splitscreen) {
    yoffset = 56;
    iconsize = 21;
  } else {
    yoffset = 112;
    iconsize = 32;
  }

  if(isDefined(self.juicedtimer))
    self.juicedtimer destroy();

  if(isDefined(self.juicedicon))
    self.juicedicon destroy();

  self.combathighoverlay = newclienthudelem(self);
  self.combathighoverlay.x = 0;
  self.combathighoverlay.y = 0;
  self.combathighoverlay.alignx = "left";
  self.combathighoverlay.aligny = "top";
  self.combathighoverlay.horzalign = "fullscreen";
  self.combathighoverlay.vertalign = "fullscreen";
  self.combathighoverlay setshader("combathigh_overlay", 640, 480);
  self.combathighoverlay.sort = -10;
  self.combathighoverlay.archived = 1;
  self.combathightimer = scripts\mp\hud_util::createtimer("hudsmall", 1.0);
  self.combathightimer scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, yoffset);
  self.combathightimer settimer(10.0);
  self.combathightimer.color = (0.8, 0.8, 0);
  self.combathightimer.archived = 0;
  self.combathightimer.foreground = 1;
  self.combathighicon = scripts\mp\hud_util::createicon("specialty_painkiller", iconsize, iconsize);
  self.combathighicon.alpha = 0;
  self.combathighicon scripts\mp\hud_util::setparent(self.combathightimer);
  self.combathighicon scripts\mp\hud_util::setpoint("BOTTOM", "TOP");
  self.combathighicon.archived = 1;
  self.combathighicon.sort = 1;
  self.combathighicon.foreground = 1;
  self.combathighoverlay.alpha = 0.0;
  self.combathighoverlay fadeovertime(1.0);
  self.combathighicon fadeovertime(1.0);
  self.combathighoverlay.alpha = 1.0;
  self.combathighicon.alpha = 0.85;
  thread unsetcombathighondeath();
  thread unsetcombathighonride();
  wait 8;
  self.combathighicon fadeovertime(2.0);
  self.combathighicon.alpha = 0.0;
  self.combathighoverlay fadeovertime(2.0);
  self.combathighoverlay.alpha = 0.0;
  self.combathightimer fadeovertime(2.0);
  self.combathightimer.alpha = 0.0;
  wait 2;
  self.damageblockedtotal = undefined;
  scripts\mp\utility\perk::removeperk("specialty_combathigh");
}

unsetcombathighondeath() {
  self endon("disconnect");
  self endon("unset_combathigh");
  self waittill("death");
  thread scripts\mp\utility\perk::removeperk("specialty_combathigh");
}

unsetcombathighonride() {
  self endon("disconnect");
  self endon("unset_combathigh");

  for(;;) {
    waitframe();

    if(scripts\mp\utility\player::isusingremote()) {
      thread scripts\mp\utility\perk::removeperk("specialty_combathigh");
      break;
    }
  }
}

unsetcombathigh() {
  self notify("unset_combathigh");
  self.combathighoverlay destroy();
  self.combathighicon destroy();
  self.combathightimer destroy();
}

setlightarmor() {
  scripts\mp\lightarmor::setlightarmorvalue(self, 150);
}

unsetlightarmor() {
  scripts\mp\lightarmor::lightarmor_unset(self);
}

setrevenge() {
  self notify("stopRevenge");
  waitframe();

  if(!isDefined(self.lastkilledby)) {
    return;
  }
  if(level.teambased && self.team == self.lastkilledby.team) {
    return;
  }
  revengeparams = spawnStruct();
  revengeparams.showto = self;
  revengeparams.icon = "compassping_revenge";
  revengeparams.offset = (0, 0, 64);
  revengeparams.width = 10;
  revengeparams.height = 10;
  revengeparams.archived = 0;
  revengeparams.delay = 1.5;
  revengeparams.constantsize = 0;
  revengeparams.pintoscreenedge = 1;
  revengeparams.fadeoutpinnedicon = 0;
  revengeparams.is3d = 0;
  self.revengeparams = revengeparams;
  self.lastkilledby thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(revengeparams.showto, revengeparams.icon, revengeparams.offset, undefined, undefined, undefined, revengeparams.delay);
  thread watchrevengedeath();
  thread watchrevengekill();
  thread watchrevengedisconnected();
  thread watchrevengevictimdisconnected();
  thread watchstoprevenge();
}

watchrevengedeath() {
  self endon("stopRevenge");
  self endon("disconnect");
  lastkilledby = self.lastkilledby;

  for(;;) {
    lastkilledby waittill("spawned_player");
    lastkilledby thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, undefined, undefined, undefined, self.revengeparams.delay);
  }
}

watchrevengekill() {
  self endon("stopRevenge");
  self waittill("killed_enemy");
  self notify("stopRevenge");
}

watchrevengedisconnected() {
  self endon("stopRevenge");
  self.lastkilledby waittill("disconnect");
  self notify("stopRevenge");
}

watchstoprevenge() {
  lastkilledby = self.lastkilledby;
  self waittill("stopRevenge");

  if(!isDefined(lastkilledby)) {
    return;
  }
  foreach(key, headicon in lastkilledby.entityheadicons) {
    if(!isDefined(headicon)) {
      continue;
    }
    headicon destroy();
  }
}

watchrevengevictimdisconnected() {
  objid = self.objidfriendly;
  lastkilledby = self.lastkilledby;
  lastkilledby endon("disconnect");
  level endon("game_ended");
  self endon("stopRevenge");
  self waittill("disconnect");

  if(!isDefined(lastkilledby)) {
    return;
  }
  foreach(key, headicon in lastkilledby.entityheadicons) {
    if(!isDefined(headicon)) {
      continue;
    }
    headicon destroy();
  }
}

unsetrevenge() {
  self notify("stopRevenge");
}

setphaseslide() {
  self.canphaseslide = 1;
}

unsetphaseslide() {
  self.canphaseslide = 0;
}

setteleslide() {
  self.canteleslide = 1;
}

unsetteleslide() {
  self.canteleslide = 0;
}

setphaseslashrephase() {
  self.hasrephase = 1;
}

unsetphaseslashrephase() {
  self.hasrephase = 0;
}

setphasefall() {}

unsetphasefall() {}

setextenddodge() {}

unsetextenddodge() {}

setauraquickswap() {
  scripts\mp\archetypes\archassault::auraquickswap_run();
}

unsetauraquickswap() {}

setauraspeed() {}

unsetauraspeed() {}

setmarktargets() {
  scripts\mp\perks\perk_mark_targets::marktarget_init();
}

unsetmarktargets() {}

setbatterypack() {}

unsetbatterypack() {}

setcamoclone() {}

unsetcamoclone() {}

setblockhealthregen() {
  self.healthregendisabled = 1;
  self notify("force_regeneration");
}

unsetblockhealthregen() {
  self.healthregendisabled = undefined;
  self notify("force_regeneration");
}

setscorestreakpack() {}

unsetscorestreakpack() {}

setsuperpack() {}

unsetsuperpack() {}

setspawncloak() {}

unsetspawncloak() {}

setdodgedefense() {
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("dodgeDefense", 0.5, 0, ::dodgedefenseignorefunc);
}

unsetdodgedefense() {
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("dodgeDefense", 0);
}

dodgedefenseignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!(isDefined(victim.dodging) && victim.dodging && victim scripts\mp\utility\perk::_hasperk("specialty_dodge_defense")))
    return 1;

  return 0;
}

setdodgewave() {}

unsetdodgewave() {}

setgroundpound() {}

unsetgroundpound() {}

setmeleekill() {
  self giveweapon("iw7_fistsperk_mp");
  self assignweaponmeleeslot("iw7_fistsperk_mp");

  if(self hasweapon("iw9_me_fists_mp")) {
    _id_3A9E0F1BEA21D3CC = self getcurrentweapon();
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw9_me_fists_mp");
    self giveweapon("iw7_fistslethal_mp");

    if(_id_3A9E0F1BEA21D3CC.basename == "iw9_me_fists_mp") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("iw7_fistslethal_mp");

      if(isDefined(self.gettingloadout) && self.gettingloadout && isDefined(self.spawnweaponobj) && self.spawnweaponobj.basename == "iw9_me_fists_mp") {
        self.spawnweaponobj = makeweapon("iw7_fistslethal_mp");
        self setspawnweapon(self.spawnweaponobj);
      }
    }
  }
}

unsetmeleekill() {
  scripts\cp_mp\utility\inventory_utility::_takeweapon("iw7_fistsperk_mp");

  if(self hasweapon("iw7_fistslethal_mp")) {
    _id_3A9E0F1BEA21D3CC = self.currentweapon;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw7_fistslethal_mp");
    self giveweapon("iw9_me_fists_mp");

    if(_id_3A9E0F1BEA21D3CC.basename == "iw7_fistslethal_mp")
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("iw9_me_fists_mp");
  }
}

setpowercell() {}

unsetpowercell() {}

sethardline() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
  self.hardlineactive["assists"] = 0;
}

watchhardlineassists() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
}

unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

setoverclock() {}

unsetoverclock() {}

setovercharge() {
  self setclientomnvar("ui_overcharge", 1);
}

unsetovercharge() {
  self setclientomnvar("ui_overcharge", 0);
}

setsupersprintenhanced() {
  thread watchforsupersprintenhancedused();
}

unsetsupersprintenhanced() {
  self notify("unsetSuperSprintEnhanced");
}

watchforsupersprintenhancedused() {
  self endon("unsetSuperSprintEnhanced");
  self endon("disconnect");
  _id_0928ACAECED291D4 = 0;

  while(2000 > _id_0928ACAECED291D4) {
    waitframe();

    if(isDefined(self) && istrue(self issupersprinting())) {
      _id_56DDE920C84C7B04 = level.frameduration;
      _id_0928ACAECED291D4 = _id_0928ACAECED291D4 + _id_56DDE920C84C7B04;
    }
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

settracker() {}

unsettracker() {}

setpersonaltrophy() {}

unsetpersonaltrophy() {}

setdisruptorpunch() {}

unsetdisruptorpunch() {}

setequipmentping() {
  if(!scripts\mp\utility\game::lpcfeaturegated())
    level.equipmentpingactive = 1;
}

unsetequipmentping() {}

setmanatarms() {}

unsetmanatarms() {}

setoutlinekillstreaks() {
  thread outlinekillstreaks_enablemarksafterprematch();
}

outlinekillstreaks_enablemarksafterprematch() {
  self endon("unsetOutlineKillstreak");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  dist = 1000000;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    dist = 1000;

  if(isDefined(self)) {
    self enableentitymarks("killstreak", dist);
    self enableentitymarks("air_killstreak", dist);
    self.perkoutlinekillstreaksset = 1;
    scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_updateallvisibilityforplayer(self);
  }
}

unsetoutlinekillstreaks() {
  if(istrue(self.perkoutlinekillstreaksset)) {
    self disableentitymarks("killstreak");
    self disableentitymarks("air_killstreak");
    self.perkoutlinekillstreaksset = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_updateallvisibilityforplayer(self);
  self notify("unsetOutlineKillstreak");
}

setengineer() {
  thread engineer_enablemarksafterprematch();
}

engineer_enablemarksafterprematch() {
  self endon("unsetEngineer");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  dist = 1000000;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    dist = 1000;

  if(isDefined(self)) {
    self enableentitymarks("equipment", dist);
    self.perkengineerset = 1;
  }
}

unsetengineer() {
  if(istrue(self.perkengineerset)) {
    self disableentitymarks("equipment");
    self.perkengineerset = undefined;
  }

  self notify("unsetEngineer");
}

setnoscopeoutline() {
  if(!isDefined(level.noscopeoutlinesetnotifs)) {
    level.noscopeoutlinesetnotifs = [];
    level.noscopeoutlineunsetnotifs = [];
    level thread processnoscopeoutlinesetnotifs();
    level thread processnoscopeoutlineunsetnotifs();
  }

  level.noscopeoutlinesetnotifs[level.noscopeoutlinesetnotifs.size] = self;
}

unsetnoscopeoutline() {
  level.noscopeoutlineunsetnotifs[level.noscopeoutlineunsetnotifs.size] = self;
}

processnoscopeoutlinesetnotifs() {
  level endon("game_ended");

  for(;;) {
    if(level.noscopeoutlinesetnotifs.size > 0) {
      _id_AC0E594AC96AA3A8 = 0;

      while(isDefined(level.noscopeoutlinesetnotifs[_id_AC0E594AC96AA3A8])) {
        level notify("set_noscopeoutline", level.noscopeoutlinesetnotifs[_id_AC0E594AC96AA3A8]);
        level.noscopeoutlinesetnotifs[_id_AC0E594AC96AA3A8] notify("set_noscopeoutline");
        _id_AC0E594AC96AA3A8++;
        waitframe();
      }

      level.noscopeoutlinesetnotifs = [];
      continue;
    }

    waitframe();
  }
}

processnoscopeoutlineunsetnotifs() {
  level endon("game_ended");

  for(;;) {
    if(level.noscopeoutlineunsetnotifs.size > 0) {
      _id_AC0E594AC96AA3A8 = 0;

      while(isDefined(level.noscopeoutlineunsetnotifs[_id_AC0E594AC96AA3A8])) {
        level notify("unset_noscopeoutline", level.noscopeoutlineunsetnotifs[_id_AC0E594AC96AA3A8]);
        level.noscopeoutlineunsetnotifs[_id_AC0E594AC96AA3A8] notify("unset_noscopeoutline");
        _id_AC0E594AC96AA3A8++;
        waitframe();
      }

      level.noscopeoutlineunsetnotifs = [];
      continue;
    }

    waitframe();
  }
}

setcloak() {}

unsetcloak() {}

setwalllock() {}

unsetwalllock() {}

setrush() {}

unsetrush() {
  self notify("removeCombatHigh");
  self.speedonkillmod = undefined;
}

sethover() {
  thread runhover();
}

unsethover() {}

setmomentum() {
  self.momentumspeedincrease = 0.05;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetmomentum() {
  self.momentumspeedincrease = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

setscavengereqp() {}

unsetscavengereqp() {}

setspawnview() {}

unsetspawnview() {
  foreach(player in level.players)
  player notify("end_spawnview");
}

setheadgear(power) {}

unsetheadgear() {}

setftlslide() {}

unsetftlslide() {}

setimprovedprone() {}

unsetimprovedprone() {}

setghost() {
  thread startgpsjammer();
}

unsetghost() {
  thread removegpsjammer();
}

setsupportkillstreaks() {
  self endon("disconnect");
  self waittill("equipKillstreaksFinished");

  if(!isDefined(self.streakdata.streaks[1])) {
    foreach(_id_153FDEE861E0F06F in self.streakdata.streaks["killstreaks"])
    _id_153FDEE861E0F06F.earned = 0;
  }
}

unsetsupportkillstreaks() {
  self notify("end_support_killstreaks");
}

setoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = 0.98;
  scripts\mp\weapons::updatemovespeedscale();
}

unsetoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = undefined;
}

setcloakaerial() {}

unsetcloakaerial() {}

setspawnradar() {
  self.hasspawnradar = 1;
}

unsetspawnradar() {
  self.hasspawnradar = 1;
}

setimprovedmelee() {}

unsetimprovedmelee() {}

setthief() {}

unsetthief() {}

setadsawareness() {
  thread runadsawareness();
  self setscriptablepartstate("heightened_senses", "default");
}

runadsawareness() {
  self endon("death_or_disconnect");
  self endon("unsetADSAwareness");
  self.awarenessradius = 256;
  self.awarenessqueryrate = 2.0;
  thread awarenessmonitorstance();

  for(;;) {
    wait(self.awarenessqueryrate);
    _id_37C96F3E3F4C1BB8 = scripts\common\utility::playersinsphere(self.origin, self.awarenessradius);

    foreach(player in level.players) {
      if(player.team == self.team) {
        continue;
      }
      if(player scripts\mp\utility\perk::_hasperk("specialty_coldblooded")) {
        continue;
      }
      if(player isonground() && !player issprinting() && !player iswallrunning() && !player issprintsliding()) {
        continue;
      }
      thread playincomingwarning(player);
    }
  }
}

playincomingwarning(target) {
  self setscriptablepartstate("heightened_senses", "scrn_pulse");
  self playRumbleOnEntity("damage_heavy");
  target playsoundtoplayer("ghost_senses_ping", self);
  wait 0.2;

  if(isDefined(self)) {
    self setscriptablepartstate("heightened_senses", "default");

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self playRumbleOnEntity("damage_heavy");

      if(isDefined(target) && target scripts\cp_mp\utility\player_utility::_isalive())
        target playsoundtoplayer("ghost_senses_ping", self);
    }
  }
}

awarenessmonitorstance() {
  self endon("death_or_disconnect");

  for(;;) {
    stance = self getstance();
    velocity = self getvelocity();

    switch (stance) {
      case "stand":
        self.awarenessradius = 400;
        self.awarenessqueryrate = 2.0;
        break;
      case "crouch":
        self.awarenessradius = 650;
        self.awarenessqueryrate = 1.0;
        break;
      case "prone":
        self.awarenessradius = 700;
        self.awarenessqueryrate = 0.5;
        break;
    }

    wait 0.01;
  }
}

awarenessaudiopulse() {
  self endon("death_or_disconnect");
  self endon("stop_awareness");

  for(;;) {
    playsoundatpos(self.origin + (0, 0, 5), "ghost_senses_ping");
    wait 2.0;
  }
}

unsetadsawareness() {
  self notify("unsetADSAwareness");
  self setscriptablepartstate("heightened_senses", "default");
}

setrearguard() {}

unsetrearguard() {
  self.hasrearguardshield = undefined;
}

setsolobuddyboost() {
  self.hassolobuddyboost = 1;
}

unsetsolobuddyboost() {
  self.hassolobuddyboost = undefined;
}

setthrowingknifemelee() {
  if(!isDefined(self.throwingknifemelee)) {
    return;
  }
  self giveweapon(self.throwingknifemelee);
  self assignweaponmeleeslot(self.throwingknifemelee);
  thread watchthrowingknifescavenge();
}

unsetthrowingknifemelee() {
  if(isDefined(self.throwingknifemelee) && self hasweapon(self.throwingknifemelee))
    self takeweapon(self.throwingknifemelee);

  self notify("specialty_equip_throwingKnife_end");
}

watchthrowingkifefireswipe() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  for(;;) {
    self waittill("weapon_change", weapon);

    if(weapon.basename == "iw8_throwingknife_fire_melee_mp") {
      self setscriptablepartstate("equipFlamingKnife", "active");
      self waittill("weapon_change");
      self setscriptablepartstate("equipFlamingKnife", "neutral");
    }
  }
}

killthrowingknifefire() {
  self setscriptablepartstate("equipFlamingKnife", "neutral");
}

_id_A722BB83C625E6C0() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  for(;;) {
    self waittill("weapon_change", weapon);

    if(weapon.basename == "iw8_throwingknife_electric_melee_mp") {
      self setscriptablepartstate("equipFlamingKnife", "active");
      self waittill("weapon_change");
      self setscriptablepartstate("equipFlamingKnife", "neutral");
    }
  }
}

_id_006B1E598A80AC49() {
  self setscriptablepartstate("equipFlamingKnife", "neutral");
}

watchthrowingknifescavenge() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  for(;;) {
    self waittill("offhand_fired", weapon);

    if(scripts\mp\utility\weapon::isthrowingknife(weapon)) {
      ammo = self getammocount(weapon);

      if(ammo == 0) {
        if(isDefined(self.throwingknifemelee) && self hasweapon(self.throwingknifemelee))
          self takeweapon(self.throwingknifemelee);
      }

      while(self getammocount(weapon) == 0)
        wait 0.05;

      self giveweapon(self.throwingknifemelee);
      self assignweaponmeleeslot(self.throwingknifemelee);
    }
  }
}

setbulletoutline() {
  self.bulletoutline = spawnStruct();
  self.bulletoutline.player = self;
  self.bulletoutline.enemies = [];
  self.bulletoutline.enemyids = [];
  self.bulletoutline.enemyendtimes = [];
  self.bulletoutline thread watchbulletoutline();
  self.bulletoutline thread watchbulletoutlinecleanup();
}

unsetbulletoutline() {
  self notify("unsetBulletOutline");
  self.bulletoutline = undefined;
}

watchbulletoutline() {
  self.player endon("death_or_disconnect");
  self.player endon("unsetBulletOutline");

  while(isDefined(self.player)) {
    time = gettime();

    foreach(index, enemy in self.enemies) {
      if(!isDefined(enemy)) {
        bulletoutlineremoveenemy(undefined, index);
        continue;
      }

      if(enemy scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
        bulletoutlineremoveenemy(enemy, index);
        continue;
      }

      if(time >= self.enemyendtimes[index])
        bulletoutlineremoveenemy(enemy, index);
    }

    waitframe();
  }
}

watchbulletoutlinecleanup() {
  self.player scripts\engine\utility::waittill_any_2("disconnect", "unsetBulletOutline");

  foreach(index, enemy in self.enemies) {
    if(isDefined(enemy))
      bulletoutlineremoveenemy(enemy, index);
  }
}

bulletoutlineaddenemy(enemy, duration, _id_4159C70203B2B7C0) {
  entnum = enemy getentitynumber();
  endtime = gettime() + duration * 1000;
  self.enemies[entnum] = enemy;

  if(!isDefined(self.enemyids[entnum]))
    self.enemyids[entnum] = scripts\mp\utility\outline::outlineenableforplayer(enemy, self.player, "outline_depth_red", "perk");

  if(!isDefined(self.enemyendtimes[entnum]) || !isDefined(_id_4159C70203B2B7C0) || _id_4159C70203B2B7C0)
    self.enemyendtimes[entnum] = endtime;
}

bulletoutlineremoveenemy(enemy, index) {
  if(!isDefined(index))
    index = enemy getentitynumber();

  self.enemies[index] = undefined;
  self.enemyendtimes[index] = undefined;

  if(isDefined(enemy))
    scripts\mp\utility\outline::outlinedisable(self.enemyids[index], enemy);

  self.enemyids[index] = undefined;
}

bulletoutlinecheck(attacker, victim, weapon, meansofdeath) {
  if(!(meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET")) {
    return;
  }
  if(!isDefined(attacker) || !isDefined(victim)) {
    return;
  }
  if(!isPlayer(attacker) || !isPlayer(victim)) {
    return;
  }
  _id_C52FFAED35E604DD = attacker;

  if(isDefined(attacker.owner))
    _id_C52FFAED35E604DD = attacker.owner;

  _id_F2AE11D4D6442540 = victim;

  if(isDefined(victim.owner))
    _id_F2AE11D4D6442540 = victim.owner;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(_id_C52FFAED35E604DD, _id_F2AE11D4D6442540))) {
    return;
  }
  if(isPlayer(attacker) && isPlayer(victim) && scripts\mp\utility\outline::outlineoccluded(attacker getEye(), victim getEye())) {
    return;
  }
  if(isDefined(attacker.bulletoutline) && !victim scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline"))
    attacker.bulletoutline bulletoutlineaddenemy(victim, 1);

  if(isDefined(victim.bulletoutline) && !attacker scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline"))
    victim.bulletoutline bulletoutlineaddenemy(attacker, 2.0, 0);
}

markempsignatures(target, id) {
  if(!isDefined(target.empmarked))
    target.empmarked = [];

  if(isDefined(target.empmarked[id]) && target.empmarked[id] == "active") {
    return;
  }
  target.empmarked[id] = "active";
  thread empvfx(target, id);
  target scripts\engine\utility::waittill_any_2("death", "cloak_end");
  target.empmarked[id] = undefined;
}

empvfx(target, id) {
  _id_2FF18B1CBE5C7D33 = ["j_shoulder_ri", "j_shoulder_le", "j_hip_ri", "j_hip_le", "j_spine4", "j_wrist_ri", "j_wrist_le"];
  target.empmarked[id] = undefined;
}

startgpsjammer() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");

  if(isai(self)) {
    while(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0)
      waitframe();
  }

  if(level.minspeedsq == 0) {
    return;
  }
  if(level.timeperiod < 0.05) {
    return;
  }
  self.timesincelastweaponfire = 0.0;
  thread ghostadvanceduavwatcher();
  self.timesincelastweaponfire = 0.0;
  self setplayerghost(1);

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(scripts\mp\class::isweaponsilenced(objweapon)) {
      continue;
    }
    doghostweaponfired();
  }
}

doghostweaponfired() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");
  self setplayerghost(0);
  thread checkforghostweaponfire();

  while(self.timesincelastweaponfire < 3.0) {
    wait(level.timeperiod);
    self.timesincelastweaponfire = self.timesincelastweaponfire + level.timeperiod;
  }

  self notify("ghost_restored");
  self.timesincelastweaponfire = 0.0;
  self setplayerghost(1);
}

checkforghostweaponfire() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  self endon("ghost_restored");

  for(;;) {
    self waittill("weapon_fired");
    self.timesincelastweaponfire = 0.0;
  }
}

ghostadvanceduavwatcher() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  _id_498A2226E5AA47EE = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  if(_id_498A2226E5AA47EE) {
    self setplayeradvanceduavdot(1);
    return;
  }

  for(;;) {
    if(level.teambased) {
      enemyhasauav = level.activeadvanceduavcount - level.activeadvanceduavs[self.team] > 0;

      if(enemyhasauav) {
        self setplayeradvanceduavdot(1);
        self setplayerghost(0);

        while(enemyhasauav) {
          waitframe();
          enemyhasauav = level.activeadvanceduavcount - level.activeadvanceduavs[self.team] > 0;
        }

        self setplayerghost(1);
        self setplayeradvanceduavdot(0);
      }
    } else {
      foreach(player in level.players) {
        if(player == self) {
          continue;
        }
        if(istrue(level.activeadvanceduavs[player.guid]) && level.activeadvanceduavs[player.guid] > 0) {
          self setplayeradvanceduavdot(1);
          self setplayerghost(0);

          while(istrue(level.activeadvanceduavs[player.guid]) && level.activeadvanceduavs[player.guid] > 0)
            level waittill("uav_update");

          self setplayerghost(1);
          self setplayeradvanceduavdot(0);
        }
      }
    }

    waitframe();
  }
}

removegpsjammer() {
  self notify("remove_gpsjammer");
  self setplayerghost(0);
  self setplayeradvanceduavdot(0);
}

setgroundpoundshield() {
  level._effect["groundPoundShield_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

unsetgroundpoundshield() {
  self notify("groundPoundShield_unset");
}

groundpoundshield_onimpact(_id_AF29B63BC110DCF1) {
  thread groundpoundshield_raiseondelay();
}

groundpoundshield_raiseondelay() {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundLand");
  wait 0.25;
  groundpoundshield_raise();
}

groundpoundshield_raise() {
  if(isDefined(self.groundpoundshield))
    thread groundpoundshield_lower(self.groundpoundshield);

  origin = self.origin + anglesToForward(self.angles) * 5;
  angles = self.angles + (0, 90, 0);
  _id_3A798ABBD939DC68 = spawn("script_model", origin);
  _id_3A798ABBD939DC68.angles = angles;
  _id_3A798ABBD939DC68 setModel("weapon_shinguard_col_wm");
  _id_D96E6DDAB67FB9BE = spawn("script_model", origin);
  _id_D96E6DDAB67FB9BE.angles = angles;
  _id_D96E6DDAB67FB9BE setModel("weapon_shinguard_fr_wm");
  _id_D96E6DDAB67FB9BE.outlineid = scripts\mp\utility\outline::outlineenableforall(_id_D96E6DDAB67FB9BE, "outline_nodepth_cyan", "equipment");
  _id_D97B7BDAB68DED0D = spawn("script_model", origin);
  _id_D97B7BDAB68DED0D.angles = angles;
  _id_D97B7BDAB68DED0D setModel("weapon_shinguard_en_wm");
  _id_D97B7BDAB68DED0D.outlineid = scripts\mp\utility\outline::outlineenableforall(_id_D97B7BDAB68DED0D, "outline_nodepth_orange", "equipment");
  _id_3A798ABBD939DC68.visfr = _id_D96E6DDAB67FB9BE;
  _id_3A798ABBD939DC68.visen = _id_D97B7BDAB68DED0D;
  _id_3A798ABBD939DC68.owner = self;
  _id_3A798ABBD939DC68 setCanDamage(1);
  _id_3A798ABBD939DC68.health = 9999;
  _id_3A798ABBD939DC68.shieldhealth = 210;
  self.groundpoundshield = _id_3A798ABBD939DC68;
  players = level.characters;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(level.teambased && player.team == self.team) {
      _id_D97B7BDAB68DED0D hidefromplayer(player);
      continue;
    }

    _id_D96E6DDAB67FB9BE hidefromplayer(player);
  }

  thread groundpoundshield_monitorjoinedteam(_id_3A798ABBD939DC68);
  thread groundpoundshield_loweronleavearea(_id_3A798ABBD939DC68);
  thread groundpoundshield_lowerontime(_id_3A798ABBD939DC68, 3.25);
  thread groundpoundshield_loweronjump(_id_3A798ABBD939DC68);
  thread groundpoundshield_deleteondisconnect(_id_3A798ABBD939DC68);
  thread groundpoundshield_monitorhealth(_id_3A798ABBD939DC68);
  thread groundpound_raisefx();
  return _id_3A798ABBD939DC68;
}

groundpoundshield_lower(_id_3A798ABBD939DC68) {
  self notify("groundPoundShield_end");

  if(!isDefined(_id_3A798ABBD939DC68)) {
    return;
  }
  thread groundpoundshield_lowerfx();
  thread groundpoundshield_deleteshield(_id_3A798ABBD939DC68);
}

groundpoundshield_break(_id_3A798ABBD939DC68) {
  self notify("groundPoundShield_end");

  if(!isDefined(_id_3A798ABBD939DC68)) {
    return;
  }
  thread groundpoundshield_breakfx();
  thread groundpoundshield_deleteshield(_id_3A798ABBD939DC68);
}

groundpoundshield_monitorhealth(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  for(;;) {
    _id_3A798ABBD939DC68 waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);

    if(isDefined(attacker)) {
      if(attacker == self || attacker.team != self.team)
        _id_3A798ABBD939DC68.shieldhealth = _id_3A798ABBD939DC68.shieldhealth - damage;
    }

    _id_3A798ABBD939DC68.health = 9999;
    thread groundpoundshield_damagedfx(attacker, point, direction_vec);

    if(_id_3A798ABBD939DC68.shieldhealth <= 0) {
      thread groundpoundshield_break(_id_3A798ABBD939DC68);
      return;
    } else if(_id_3A798ABBD939DC68.shieldhealth <= 105.0) {
      if(_id_3A798ABBD939DC68.visfr.model != "weapon_shinguard_dam_wm") {
        _id_3A798ABBD939DC68.visfr setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\outline::outlinerefresh(_id_3A798ABBD939DC68.visfr);
      }

      if(_id_3A798ABBD939DC68.visen.model != "weapon_shinguard_dam_wm") {
        _id_3A798ABBD939DC68.visen setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\outline::outlinerefresh(_id_3A798ABBD939DC68.visen);
      }
    }
  }
}

groundpoundshield_loweronjump(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  jumpcur = self isjumping();
  _id_32931493C5657794 = undefined;

  for(;;) {
    _id_32931493C5657794 = jumpcur;
    jumpcur = self isjumping();

    if(!_id_32931493C5657794 && jumpcur) {
      thread groundpoundshield_lower(_id_3A798ABBD939DC68);
      return;
    }

    waitframe();
  }
}

groundpoundshield_lowerontime(_id_3A798ABBD939DC68, time) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  wait(time);
  thread groundpoundshield_lower(_id_3A798ABBD939DC68);
}

groundpoundshield_loweronleavearea(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  while(isDefined(_id_3A798ABBD939DC68)) {
    if(lengthsquared(_id_3A798ABBD939DC68.origin - self.origin) > 11664) {
      thread groundpoundshield_lower(_id_3A798ABBD939DC68);
      return;
    }

    waitframe();
  }
}

groundpoundshield_deleteondisconnect(_id_3A798ABBD939DC68) {
  self endon("groundPoundShield_deleteShield");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "groundPound_unset");
  thread groundpoundshield_deleteshield(_id_3A798ABBD939DC68);
}

groundpoundshield_monitorjoinedteam(_id_3A798ABBD939DC68) {}

groundpoundshield_deleteshield(_id_3A798ABBD939DC68) {
  self notify("groundPoundShield_deleteShield");
  scripts\mp\utility\outline::outlinedisable(_id_3A798ABBD939DC68.visen.outlineid, _id_3A798ABBD939DC68.visen);
  scripts\mp\utility\outline::outlinedisable(_id_3A798ABBD939DC68.visfr.outlineid, _id_3A798ABBD939DC68.visfr);
  _id_3A798ABBD939DC68.visfr delete();
  _id_3A798ABBD939DC68.visen delete();
  _id_3A798ABBD939DC68 delete();
}

groundpound_raisefx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

groundpoundshield_lowerfx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

groundpoundshield_damagedfx(attacker, point, direction_vec) {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  playFX(scripts\engine\utility::getfx("groundPoundShield_impact"), point, -1 * direction_vec);
  playsoundatpos(point, "ds_shield_impact");
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("hitbulletstorm");
}

groundpoundshield_breakfx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

setgroundpoundshock() {
  level._effect["groundPoundShock_impact_sm"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["groundPoundShock_impact_lrg"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

unsetgroundpoundshock() {
  self notify("groundPoundShock_unset");
}

groundpoundshock_onimpact(_id_AF29B63BC110DCF1) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShock_unset");
  radius = undefined;
  effectid = undefined;

  switch (_id_AF29B63BC110DCF1) {
    case "groundPoundLandTier0":
      effectid = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      radius = 144;
      break;
    case "groundPoundLandTier1":
      effectid = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      radius = 180;
      break;
    case "groundPoundLandTier2":
      effectid = scripts\engine\utility::getfx("groundPoundShock_impact_lrg");
      radius = 216;
      break;
  }

  thread groundpoundshock_onimpactfx(radius, effectid);
  enemies = undefined;

  if(level.teambased)
    enemies = scripts\mp\utility\teams::getenemyplayers(self.team, 1);
  else
    enemies = level.characters;

  _id_F85C8A0556EDF077 = radius * radius;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 0, 0);

  foreach(enemy in enemies) {
    if(lengthsquared(enemy getEye() - self getEye()) > _id_F85C8A0556EDF077) {
      continue;
    }
    _id_AA517194E54F048B = physics_raycast(self getEye(), enemy getEye(), contents, undefined, 0, "physicsquery_closest");

    if(isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0) {
      continue;
    }
    thread groundpoundshock_empplayer(enemy);
  }
}

groundpoundshock_empplayer(victim) {
  victim endon("death_or_disconnect");
  scripts\mp\gamescore::trackdebuffassist(self, victim, "groundpound_mp");
  wait 3;

  if(isDefined(self))
    scripts\mp\gamescore::untrackdebuffassist(self, victim, "groundpound_mp");
}

groundpoundshock_onimpactfx(radius, effectid) {
  playFX(effectid, self.origin + (0, 0, 20), (0, 0, 1));
}

setgroundpoundboost() {}

unsetgroundpoundboost() {
  self notify("groundPoundBoost_unset");
}

groundpoundboost_onimpact(_id_AF29B63BC110DCF1) {
  scripts\common\utility::set_doublejumpenergy(self energy_getmax(0));
}

setbattleslideshield() {
  level._effect["battleSlideShield_damage"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  thread battleslideshield_monitor();
}

unsetbattleslideshield() {
  self notify("battleSlideShield_unset");
}

battleslideshield_monitor() {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self notify("battleSlideShield_monitor");
  self endon("battleSlideShield_monitor");

  for(;;) {
    self waittill("sprint_slide_begin");
    thread battleslideshield_raise();
  }
}

battleslideshield_monitorhealth(_id_3A798ABBD939DC68) {
  self endon("disconnect");
  self endon("battleSlide_unset");

  while(isDefined(_id_3A798ABBD939DC68)) {
    _id_3A798ABBD939DC68 waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);
    thread battleslideshield_damagedfx(_id_3A798ABBD939DC68, attacker, point, direction_vec);

    if(_id_3A798ABBD939DC68.health <= 0) {
      thread battleslideshield_break(_id_3A798ABBD939DC68);
      _id_3A798ABBD939DC68 delete();
      continue;
    }

    if(_id_3A798ABBD939DC68.health <= 125.0) {
      if(_id_3A798ABBD939DC68.model != "weapon_shinguard_dam_wm")
        _id_3A798ABBD939DC68 setModel("weapon_shinguard_dam_wm");

      continue;
    }

    if(_id_3A798ABBD939DC68.model != "weapon_shinguard_wm")
      _id_3A798ABBD939DC68 setModel("weapon_shinguard_wm");
  }
}

battleslideshield_raise() {
  if(isDefined(self.battleslideshield))
    thread battleslideshield_lower(self.battleslideshield);

  _id_3A798ABBD939DC68 = scripts\engine\utility::spawn_tag_origin();
  _id_3A798ABBD939DC68 setModel("weapon_shinguard_wm");
  _id_3A798ABBD939DC68 setCanDamage(1);
  _id_3A798ABBD939DC68.health = 250;
  _id_3A798ABBD939DC68 linkTo(self, "tag_origin", (30, 0, 0), (0, 90, 0));
  _id_3A798ABBD939DC68 show();
  self.battleslideshield = _id_3A798ABBD939DC68;
  thread battleslideshield_killonjumpfall(_id_3A798ABBD939DC68);
  thread battleslideshield_killonsprint(_id_3A798ABBD939DC68);
  thread battleslideshield_killontime(_id_3A798ABBD939DC68);
  thread battleslideshield_unlinkonstop(_id_3A798ABBD939DC68);
  thread battleslideshield_monitorhealth(_id_3A798ABBD939DC68);
  thread battleslideshield_killondeathdisconnectunset(_id_3A798ABBD939DC68);
  thread battleslideshield_raisefx(_id_3A798ABBD939DC68);
  return _id_3A798ABBD939DC68;
}

battleslideshield_lower(_id_3A798ABBD939DC68) {
  self notify("battleSlideShield_end");

  if(!isDefined(_id_3A798ABBD939DC68)) {
    return;
  }
  thread battleslideshield_lowerfx(_id_3A798ABBD939DC68);
  _id_3A798ABBD939DC68 delete();
}

battleslideshield_killondeathdisconnectunset(_id_3A798ABBD939DC68) {
  _id_3A798ABBD939DC68 endon("death");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "battleSlide_unset");
  _id_3A798ABBD939DC68 delete();
}

battleslideshield_killonjumpfall(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  _id_3A798ABBD939DC68 endon("death");

  for(;;) {
    if(!self isonground()) {
      _id_3A798ABBD939DC68 delete();
      self notify("battleSlideShield_end");
      return;
    }

    waitframe();
  }
}

battleslideshield_killonsprint(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  _id_3A798ABBD939DC68 endon("death");
  self waittill("sprint_begin");
  _id_3A798ABBD939DC68 delete();
  self notify("battleSlideShield_end");
}

battleslideshield_loweronleavearea(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  _id_3A798ABBD939DC68 endon("death");

  for(;;) {
    if(lengthsquared(_id_3A798ABBD939DC68.origin - self.origin) > 11664) {
      thread battleslideshield_lower(_id_3A798ABBD939DC68);
      return;
    }

    waitframe();
  }
}

battleslideshield_lowerontime(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  _id_3A798ABBD939DC68 endon("death");
  wait 3.5;
  thread battleslideshield_lower(_id_3A798ABBD939DC68);
}

battleslideshield_unlink(_id_3A798ABBD939DC68) {
  if(!isDefined(_id_3A798ABBD939DC68)) {
    return;
  }
  _id_3A798ABBD939DC68 unlink();
  self notify("battleSlideShield_unlink");
  thread battleslideshield_lowerontime(_id_3A798ABBD939DC68);
  thread battleslideshield_loweronleavearea(_id_3A798ABBD939DC68);
  self notify("battleSlideShield_unlink");
}

battleslideshield_killontime(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  _id_3A798ABBD939DC68 endon("death");
  self waittill("sprint_slide_end");
  wait 0.75;
  _id_3A798ABBD939DC68 delete();
  self notify("battleSlideShield_end");
}

battleslideshield_unlinkonstop(_id_3A798ABBD939DC68) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  _id_3A798ABBD939DC68 endon("death");
  self waittill("sprint_slide_end");

  for(;;) {
    if(lengthsquared(self getvelocity()) < 100) {
      thread battleslideshield_unlink(_id_3A798ABBD939DC68);
      return;
    }

    waitframe();
  }
}

battleslideshield_break(_id_3A798ABBD939DC68) {
  if(!isDefined(_id_3A798ABBD939DC68)) {
    return;
  }
  thread battleslideshield_breakfx(_id_3A798ABBD939DC68);
  self notify("battleSlideShield_end");
}

battleslideshield_raisefx(_id_3A798ABBD939DC68) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  _id_3A798ABBD939DC68 endon("death");
}

battleslideshield_lowerfx(_id_3A798ABBD939DC68) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  _id_3A798ABBD939DC68 endon("death");
}

battleslideshield_damagedfx(_id_3A798ABBD939DC68, attacker, point, direction_vec) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  _id_3A798ABBD939DC68 endon("death");
  playFX(scripts\engine\utility::getfx("battleSlideShield_damage"), point, -1 * direction_vec);
  playsoundatpos(point, "ds_shield_impact");
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("hitbulletstorm");
}

battleslideshield_breakfx(_id_3A798ABBD939DC68) {}

setbattleslideoffense() {}

unsetbattleslideoffense() {}

getbattleslideoffensedamage() {
  return 100;
}

setthruster() {
  level._effect["thrusterRadFr"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_fr");
  level._effect["thrusterRadEn"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_en");
  thrusterwatchdoublejump();
}

unsetthruster() {
  if(isDefined(self.thrustfxent))
    self.thrustfxent delete();

  self notify("thruster_unset");
}

thrusterwatchdoublejump() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");

  for(;;) {
    self waittill("doubleJumpBoostBegin");
    thread thrusterloop();
    thread thrusterdamageloop();
  }
}

thrusterloop() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");
  thread thrusterstopfx();

  if(!isDefined(self.thrustfxent)) {
    self.thrustfxent = spawn("script_model", self.origin);
    self.thrustfxent setModel("tag_origin");
  } else
    self.thrustfxent.origin = self.origin;

  waitframe();

  for(;;) {
    self playRumbleOnEntity("damage_light");
    earthquake(0.1, 0.3, self.origin, 120);
    _id_246648A337842D7D = playerphysicstrace(self.origin + (0, 0, 10), self.origin - (0, 0, 600)) + (0, 0, 1);
    self.thrustfxent.origin = _id_246648A337842D7D;
    self.thrustfxent.angles = (90, 0, 0);
    waitframe();
    wait 0.33;
  }
}

thrusterdamageloop() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");

  for(;;) {
    scripts\mp\utility\damage::radiusplayerdamage(self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1);
    wait 0.05;
  }
}

thrusterstopfx() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("doubleJumpBoostEnd", "thruster_unset");
  waitframe();
}

runhover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");

  for(;;) {
    if(self ishighjumping() && self playerads() > 0.3 && self energy_getenergy(0) > 0) {
      executehover();
      thread watchhoverend();
      self waittill("hover_ended");
      endhover();
    }

    wait 0.1;
  }
}

watchhoverend() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self endon("walllock_ended");

  while(self playerads() > 0.3)
    waitframe();

  self notify("hover_ended");
}

executehover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = 1;
  self allowmovement(0);
  self allowjump(0);
  self playlocalsound("ghost_wall_attach");
  org = scripts\engine\utility::spawn_tag_origin();
  self playerlinkTo(org);
  thread managetimeout(org);
}

managetimeout(org) {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  _id_A8C519842AB06C00 = self energy_getrestorerate(0);
  self energy_setrestorerate(0, 1.0);
  wait 2;
  self notify("hover_ended");
  self energy_setrestorerate(0, _id_A8C519842AB06C00);
  self energy_setenergy(0, 0);
}

endhover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = undefined;
  self allowmovement(1);
  self allowjump(1);
  self playlocalsound("ghost_wall_detach");
  self unlink();
}

setadsmarktarget() {}

perk_adsmarktarget_think() {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");

  for(;;) {
    if(self playerads() > 0.5) {
      foreach(_id_BD73C7ACC56CD20C in level.players) {
        if(_id_BD73C7ACC56CD20C scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
          continue;
        }
        if(_id_BD73C7ACC56CD20C.team == self.team) {
          continue;
        }
        if(istrue(_id_BD73C7ACC56CD20C.isperk_adsmarked)) {
          continue;
        }
        if(istrue(_id_BD73C7ACC56CD20C.ischeckingadsmarking)) {
          continue;
        }
        _id_BD73C7ACC56CD20C.ischeckingadsmarking = 1;
        thread perk_adstargetmark_disconnectcleanupthink(_id_BD73C7ACC56CD20C);
        _id_BD73C7ACC56CD20C thread perk_adstargetmark_disconnectcleanupthink(_id_BD73C7ACC56CD20C);

        if(perk_adsmarktarget_check(_id_BD73C7ACC56CD20C)) {
          thread perk_adsmarktarget_confirmtargetandmark(_id_BD73C7ACC56CD20C);
          continue;
        }

        _id_BD73C7ACC56CD20C.ischeckingadsmarking = 0;
      }
    }

    wait 0.2;
  }
}

perk_adsmarktarget_check(target) {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");
  contents = physics_createcontents(["physicscontents_playernosight", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  dist = distance(target.origin, self.origin);
  _id_F34DA3F94B82B632 = 0;

  if(dist != 0)
    _id_F34DA3F94B82B632 = 1000 * (10 / dist);

  _id_CCF0D694C4371281 = target getEye();

  if(target.team != self.team && (self worldpointinreticle_circle(target.origin + (0, 0, 24), 90, _id_F34DA3F94B82B632) || self worldpointinreticle_circle(_id_CCF0D694C4371281, 90, _id_F34DA3F94B82B632))) {
    caststart = self getEye();
    castend = _id_CCF0D694C4371281;
    _id_615161FA74C174F5 = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(_id_615161FA74C174F5) && _id_615161FA74C174F5.size == 0)
      return 1;

    waitframe();
    castend = target.origin + (0, 0, 24);
    _id_4B6158E7CCC8B787 = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(_id_4B6158E7CCC8B787) && _id_4B6158E7CCC8B787.size == 0)
      return 1;
  }

  return 0;
}

perk_adsmarktarget_confirmtargetandmark(target) {
  target endon("death_or_disconnect");
  level endon("game_ended");
  self endon("ADSTargetMarkUnset");
  outlineid = undefined;
  waittime = getdvarfloat("perk_ads_mark_target_hold_time_req");

  if(scripts\mp\utility\perk::_hasperk("specialty_improved_target_mark"))
    waittime = waittime * getdvarfloat("perk_faster_target_mark_rate");

  wait(waittime);
  _id_D7DF9E31F6BDC923 = "hud_icon_new_marked";

  if(scripts\cp_mp\entityheadicons::_id_6EDE573723F08C0F())
    _id_D7DF9E31F6BDC923 = "hud_icon_head_marked";

  if(self playerads() > 0.5 && perk_adsmarktarget_check(target)) {
    _id_BE331B5A39B1738A = spawn("script_model", target.origin);
    _id_F98E48F2527D4205 = _id_BE331B5A39B1738A thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(getlivingplayers_team(self.team), _id_D7DF9E31F6BDC923, 35, 1, 5000, 0, undefined, 1);
    outlineid = scripts\mp\utility\outline::outlineenableforplayer(target, self, "outlinefill_nodepth_orange", "equipment");
    target scripts\mp\utility\outline::_hudoutlineviewmodelenable("outline_nodepth_orange", 0);
    target.isperk_adsmarked = 1;
    thread perk_trackadsmarktargetoutline(_id_F98E48F2527D4205, _id_BE331B5A39B1738A, outlineid, target);
  } else
    target.ischeckingadsmarking = 0;
}

perk_trackadsmarktargetoutline(_id_F98E48F2527D4205, _id_BE331B5A39B1738A, outlineid, _id_82DC593EF677C4F0) {
  level endon("game_ended");
  wait 0.6;
  scripts\mp\utility\outline::outlinedisable(outlineid, _id_82DC593EF677C4F0);

  if(isDefined(_id_82DC593EF677C4F0))
    _id_82DC593EF677C4F0 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();

  _id_887CD8C3577FD0D0 = getdvarfloat("perk_ads_mark_target_highlight_time");

  if(scripts\mp\utility\perk::_hasperk("specialty_improved_target_mark"))
    _id_887CD8C3577FD0D0 = _id_887CD8C3577FD0D0 * getdvarfloat("perk_target_marked_longer_rate");

  wait(_id_887CD8C3577FD0D0 - 0.6);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(_id_F98E48F2527D4205);
  _id_BE331B5A39B1738A delete();

  if(isDefined(_id_82DC593EF677C4F0)) {
    _id_82DC593EF677C4F0.isperk_adsmarked = 0;
    _id_82DC593EF677C4F0.ischeckingadsmarking = 0;
  }

  self notify("adsmark_ended");
}

getlivingplayers_team(team) {
  players = [];

  foreach(player in level.players) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(player scripts\cp_mp\utility\player_utility::_isalive() && player.team == team)
      players[players.size] = player;
  }

  return players;
}

perk_adstargetmark_disconnectcleanupthink(target) {
  scripts\engine\utility::waittill_any_2("ADSTargetMarkUnset", "death_or_disconnect");

  if(isDefined(target))
    target.ischeckingadsmarking = 0;
}

unsetadsmarktarget() {
  self notify("ADSTargetMarkUnset");
}

sethelmet() {}

unsethelmet() {}

setarmorvest() {
  self.tookvesthit = 0;
}

unsetarmorvest() {}

setdoorbreach() {
  scripts\mp\destructible::allowplayertobreach(self);
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 1);
}

unsetdoorbreach() {
  scripts\mp\destructible::allowplayertobreach(self);
}

setdoorsense() {
  if(!isDefined(level.playerswithdoorsense))
    level.playerswithdoorsense = 1;
  else
    level.playerswithdoorsense = level.playerswithdoorsense + 1;
}

unsetdoorsense() {
  level.playerswithdoorsense = level.playerswithdoorsense - 1;
}

setworsenedgunkick() {
  updateweaponkick();
}

unsetworsenedgunkick() {
  updateweaponkick(1);
}

updateweaponkick(_id_D32E25E546898F0F) {
  if(!isDefined(self.weaponkickrecoil))
    self.weaponkickrecoil = 0;

  _id_844ADC5F84EF334B = -25;

  if(scripts\mp\utility\perk::_hasperk("specialty_worsenedgunkick") && !istrue(_id_D32E25E546898F0F)) {
    if(isDefined(self.currentweapon)) {
      switch (self.currentweapon.classname) {
        case "rifle":
          _id_844ADC5F84EF334B = -20;
          break;
        case "mg":
          _id_844ADC5F84EF334B = -20;
          break;
      }
    }
  } else
    _id_844ADC5F84EF334B = 0;

  if(_id_844ADC5F84EF334B != self.weaponkickrecoil) {
    scripts\mp\utility\weapon::setrecoilscale(-1 * self.weaponkickrecoil);
    scripts\mp\utility\weapon::setrecoilscale(_id_844ADC5F84EF334B);
    self.weaponkickrecoil = _id_844ADC5F84EF334B;
  }
}

setkillstreaktoscorestreak() {
  _id_FB3D43F4D6D424EE = undefined;

  if(isDefined(self.pers["killstreakToScorestreak_lifeId"]) && self.pers["killstreakToScorestreak_lifeId"] == self.lifeid) {
    _id_FB3D43F4D6D424EE = self.pers["killstreakToScorestreak"];
    self.pers["killstreakToScorestreak"] = undefined;
    self.pers["killstreakToScorestreak_lifeId"] = undefined;
  } else
    _id_FB3D43F4D6D424EE = killstreaktoscorestreak_killtoscore(self.streakpoints);

  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::setstreakpoints(_id_FB3D43F4D6D424EE);
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

unsetkillstreaktoscorestreak() {
  self.pers["killstreakToScorestreak"] = self.streakpoints;
  self.pers["killstreakToScorestreak_lifeId"] = self.lifeid;
  _id_FB3D43F4D6D424EE = killstreaktoscorestreak_scoretokill(self.streakpoints);
  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::setstreakpoints(_id_FB3D43F4D6D424EE);
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

killstreaktoscorestreak_killtoscore(streakpoints) {
  return streakpoints * 125;
}

killstreaktoscorestreak_scoretokill(streakpoints) {
  return int(streakpoints / 125);
}

setchainkillstreaks() {
  if(self.streakpoints <= 0)
    self.pers["canKillChain"] = 1;
}

unsetchainkillstreaks() {
  if(!istrue(level.gameended))
    self.pers["canKillChain"] = undefined;
}

setscrapweapons() {
  if(getdvarint("perk_graverobber_enabled") == 1)
    self setclientomnvar("ui_graverobber", 1);
}

unsetscrapweapons() {
  self setclientomnvar("ui_graverobber", 0);
}

setdooralarm() {
  self.alarmeddoors = [];
  scripts\mp\door::updatealldoorsalarmvisibilityforplayer(self, 1);
}

unsetdooralarm() {
  foreach(_id_49A4EE9CDB34AF57 in self.alarmeddoors)
  _id_49A4EE9CDB34AF57 scripts\mp\door::removealarmdoor(0);

  self.alarmeddoors = undefined;
  scripts\mp\door::updatealldoorsalarmvisibilityforplayer(self, 0);
}

setreviveuseweapon() {
  thread proximityrevivethink();
}

proximityrevivethink() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");

  if(!isDefined(self.proximityrevivefauxtrigger)) {
    _id_D72D6D8C00A1B78F = spawnStruct();
    _id_D72D6D8C00A1B78F.usetime = getdvarfloat("perk_medicReviveSpeedRatio") * scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer");
    _id_D72D6D8C00A1B78F.curprogress = 0;
    _id_D72D6D8C00A1B78F.owner = undefined;
    _id_D72D6D8C00A1B78F.id = "laststand_reviver";
    _id_D72D6D8C00A1B78F.trigger = spawnStruct();
    _id_D72D6D8C00A1B78F.trigger.id = "laststand_reviver";
    self.proximityrevivefauxtrigger = _id_D72D6D8C00A1B78F;
  }

  _id_D72D6D8C00A1B78F = self.proximityrevivefauxtrigger;

  if(!isDefined(self.hiddenreviveents))
    self.hiddenreviveents = [];

  self.canrevivewithweapon = 1;

  if(isDefined(level.revivetriggers)) {
    foreach(entnum, ent in level.revivetriggers) {
      if(!isDefined(self.hiddenreviveents[entnum])) {
        ent.trigger disableplayeruse(self);
        self.hiddenreviveents[entnum] = ent.trigger;
      }
    }
  }

  foreach(entnum, ent in level.laststandreviveents) {
    if(!isDefined(self.hiddenreviveents[entnum])) {
      ent disableplayeruse(self);
      self.hiddenreviveents[entnum] = ent;
    }
  }

  for(;;) {
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 150, self.team, self);

    foreach(player in players) {
      if(istrue(player.inlaststand) && !istrue(player.stuckinlaststand) && !istrue(player.laststandhealisactive) && !istrue(player scripts\mp\utility\player::getbeingrevivedinternal()) && !isDefined(_id_D72D6D8C00A1B78F.owner))
        thread proximityrevive(player, _id_D72D6D8C00A1B78F);
    }

    if(isDefined(level.revivetriggers)) {
      foreach(_id_DBCE45A33308630D in level.revivetriggers) {
        if(_id_DBCE45A33308630D.ownerteam == self.team) {
          if(!istrue(_id_DBCE45A33308630D.trigger.owner scripts\mp\utility\player::getbeingrevivedinternal()) && !isDefined(_id_D72D6D8C00A1B78F.owner)) {
            if(distancesquared(_id_DBCE45A33308630D.trigger.origin, self.origin) <= 22500)
              thread proximityrevive(_id_DBCE45A33308630D.trigger.owner, _id_D72D6D8C00A1B78F, _id_DBCE45A33308630D);
          }
        }
      }
    }

    wait 0.1;
  }
}

proximityrevive(player, _id_D72D6D8C00A1B78F, reviveent) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");
  player endon("death_or_disconnect");
  player endon("last_stand_finished");
  player scripts\mp\utility\player::setbeingrevivedinternal(1);
  _id_D72D6D8C00A1B78F.owner = player;
  _id_D72D6D8C00A1B78F.trigger.owner = player;
  thread watchproximityrevivefail(player, _id_D72D6D8C00A1B78F, reviveent);

  if(isDefined(reviveent)) {
    reviveent.trigger hide();
    reviveent.trigger makeunusable();
    reviveent scripts\mp\teamrevive::revivetriggerholdonusebegin(self, 1);
  } else if(isDefined(player.laststandreviveent)) {
    player.laststandreviveent hide();
    player.laststandreviveent makeunusable();
  }

  player notify("handle_revive_message");
  player scripts\mp\utility\player::_freezecontrols(1, undefined, "proximityRevive");

  while(_id_D72D6D8C00A1B78F.curprogress < _id_D72D6D8C00A1B78F.usetime) {
    if(distancesquared(self.origin, player.origin) > 90000) {
      self notify("prox_revive_fail");
      return;
    }

    scripts\mp\gameobjects::updateuiprogress(_id_D72D6D8C00A1B78F, 1);
    _id_D72D6D8C00A1B78F.curprogress = _id_D72D6D8C00A1B78F.curprogress + level.framedurationseconds;
    waitframe();
  }

  scripts\mp\gameobjects::updateuiprogress(_id_D72D6D8C00A1B78F, 0);
  player scripts\mp\gameobjects::updateuiprogress(_id_D72D6D8C00A1B78F, 0);
  player scripts\mp\utility\player::_freezecontrols(0, undefined, "proximityRevive");
  _id_D72D6D8C00A1B78F.curprogress = 0;
  _id_D72D6D8C00A1B78F.owner = undefined;
  _id_D72D6D8C00A1B78F.trigger.owner = undefined;

  if(istrue(player.inlaststand))
    player notify("last_stand_revived");
  else {
    reviveent scripts\mp\teamrevive::revivetriggerholdonuseend(self.team, self, 1, 1);
    reviveent scripts\mp\teamrevive::revivetriggerholdonuse(self);
  }
}

watchproximityrevivefail(player, _id_D72D6D8C00A1B78F, reviveent) {
  level endon("game_ended");
  player endon("last_stand_revived");
  player endon("spawned_player");
  team = player.team;
  scripts\engine\utility::waittill_any_ents_return(self, "death_or_disconnect", self, "unset_revive_use_weapon", self, "prox_revive_fail", player, "death_or_disconnect", player, "last_stand_finished");

  if(isDefined(reviveent)) {
    reviveent.trigger show();
    reviveent.trigger makeusable();
    reviveent scripts\mp\teamrevive::revivetriggerholdonuseend(team, self, 0, 1);
  }

  if(isDefined(player)) {
    player scripts\mp\utility\player::setbeingrevivedinternal(0);
    player scripts\mp\gameobjects::updateuiprogress(_id_D72D6D8C00A1B78F, 0);
    player scripts\mp\utility\player::_freezecontrols(0, undefined, "proximityRevive");

    if(isDefined(player.laststandreviveent)) {
      player.laststandreviveent show();
      player.laststandreviveent makeusable();
    }

    player notify("handle_revive_message");
  }

  if(isDefined(self)) {
    _id_D72D6D8C00A1B78F.owner = undefined;
    _id_D72D6D8C00A1B78F.trigger.owner = undefined;
    _id_D72D6D8C00A1B78F.curprogress = 0;
    scripts\mp\gameobjects::updateuiprogress(_id_D72D6D8C00A1B78F, 0);
  }
}

unsetreviveuseweapon() {
  self notify("unset_revive_use_weapon");
  self.canrevivewithweapon = undefined;

  foreach(entnum, ent in self.hiddenreviveents) {
    if(isDefined(ent) && ent.owner != self) {
      ent showtoplayer(self);
      ent enableplayeruse(self);
    }
  }
}

setlocationmarking() {}

unsetlocationmarking() {}

setremotedefuse() {}

unsetremotedefuse() {}

setalwaysminimap() {
  scripts\mp\utility\player::showminimap();
}

unsetalwaysminimap() {
  scripts\mp\utility\player::hideminimap();
}

supersprintkillrefresh_init() {
  level._effect["super_sprint_refresh"] = loadfx("vfx/iw8_mp/perk/vfx_hustle.vfx");
  level._effect["super_sprint_refresh_night"] = loadfx("vfx/iw8_mp/perk/vfx_hustle_night.vfx");
}

supersprintkillrefresh_onkill() {
  self refreshsprinttime();
}

setgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

unsetgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

setfastreloadlaunchers() {}

unsetfastreloadlaunchers() {
  if(istrue(self.fastreloadlaunchers)) {
    scripts\mp\utility\perk::removeperk("specialty_fastreload");
    self.fastreloadlaunchers = undefined;
  }
}

setreduceregendelay() {
  _id_0372301AF73968CB::_id_5457F0107A845374("setReduceRegenDelay_perks", 1.0);
}

unsetreduceregendelay() {
  _id_0372301AF73968CB::_id_4F8B5EFD1816F6C3("setReduceRegenDelay_perks");
}

regendelayreduce_onkill() {
  _id_39E91D553A7E0C6C = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
  _id_0035592968B84E0D = self isnightvisionon();
  _id_EFCAD1FD61529517 = _id_39E91D553A7E0C6C && _id_0035592968B84E0D;
  fx = scripts\engine\utility::ter_op(_id_EFCAD1FD61529517, scripts\engine\utility::getfx("super_sprint_refresh_night"), scripts\engine\utility::getfx("super_sprint_refresh"));
  playfxontagforclients(fx, self, "tag_eye", self);

  if(self.health < 100)
    scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_quick_fix");

  thread regendelayreduce_delayedregen();
}

regendelayreduce_delayedregen() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("regenDelayReduce_delayedRegen");
  self endon("regenDelayReduce_delayedRegen");
  _id_0372301AF73968CB::_id_5457F0107A845374("regenDelayReduce_delayedRegen", 1.0, 140);
}

setreduceregendelayonkill() {
  if(isDefined(self.lastgunkilltime) && self.lastgunkilltime == gettime())
    regendelayreduce_onkill();
}

unsetreduceregendelayonkill() {}

setreduceregendelayonobjective() {
  updatereduceregendelayonobjective();
  thread monitorreduceregendelayonobjective();
}

unsetreduceregendelayonobjective() {
  self notify("unsetReduceRegenDelayOnObjective");
  updatereduceregendelayonobjective(1);
}

monitorreduceregendelayonobjective() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unsetReduceRegenDelayOnObjective");

  for(;;) {
    wait 0.5;
    updatereduceregendelayonobjective();
  }
}

updatereduceregendelayonobjective(_id_8AE15D07CA991755) {
  _id_D8688E5E358C46E8 = isDefined(self.carryobject);
  _id_3821A301C5C7366D = isDefined(self.touchinggameobjects) && self.touchinggameobjects.size > 0;
  _id_A6E1E8C33F7A40FE = isDefined(self.usinggameobjects) && self.usinggameobjects.size > 0;
  _id_00A3833434882E5F = _id_D8688E5E358C46E8 || _id_3821A301C5C7366D || _id_A6E1E8C33F7A40FE;
  _id_5033E1153E007C83 = self.health / self.maxhealth >= 1.0;

  if(_id_00A3833434882E5F && !_id_5033E1153E007C83 && !istrue(_id_8AE15D07CA991755)) {
    if(!istrue(self._id_6772D7C42364EE08)) {
      _id_39E91D553A7E0C6C = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
      _id_0035592968B84E0D = self isnightvisionon();
      _id_EFCAD1FD61529517 = _id_39E91D553A7E0C6C && _id_0035592968B84E0D;
      fx = scripts\engine\utility::ter_op(_id_EFCAD1FD61529517, scripts\engine\utility::getfx("super_sprint_refresh_night"), scripts\engine\utility::getfx("super_sprint_refresh"));
      playfxontagforclients(fx, self, "tag_eye", self);
      self._id_6772D7C42364EE08 = 1;
      scripts\mp\utility\perk::giveperk("specialty_regen_delay_reduced");
      scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_quick_fix");
    }
  } else if(istrue(self._id_6772D7C42364EE08)) {
    self._id_6772D7C42364EE08 = 0;
    scripts\mp\utility\perk::removeperk("specialty_regen_delay_reduced");
  }
}

setrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }
  self notify("setRechargeEquipment");
  level.perkrechargeequipmentplayers = scripts\engine\utility::array_add(level.perkrechargeequipmentplayers, self);
}

unsetrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }
  level.perkrechargeequipmentplayers = scripts\engine\utility::array_remove(level.perkrechargeequipmentplayers, self);
  thread rechargeequipment_clearplayer(self);
}

rechargeequipmentthink_init() {
  level.perkrechargeequipmentplayers = [];
  _id_0BB293D0BE6D94BB = int(ceil(0.5 / level.framedurationseconds));

  for(;;) {
    _id_B8009F31B1522792 = level.perkrechargeequipmentplayers;
    _id_0E9A4C83BB773349 = int(ceil(_id_B8009F31B1522792.size / _id_0BB293D0BE6D94BB));

    for(_id_D94CA37340EBF0F6 = 0; _id_D94CA37340EBF0F6 < _id_0BB293D0BE6D94BB; _id_D94CA37340EBF0F6++) {
      for(_id_EF50426720E1DBB8 = 0; _id_EF50426720E1DBB8 < _id_0E9A4C83BB773349; _id_EF50426720E1DBB8++) {
        _id_A757F11D085DE009 = _id_D94CA37340EBF0F6 * _id_0E9A4C83BB773349 + _id_EF50426720E1DBB8;

        if(_id_A757F11D085DE009 > _id_B8009F31B1522792.size) {
          break;
        }

        player = _id_B8009F31B1522792[_id_A757F11D085DE009];

        if(!isDefined(player)) {
          continue;
        }
        if(!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand) || istrue(self.stuckinlaststand)) {
          continue;
        }
        rechargeequipment_updatestate(player);
      }

      waitframe();
    }
  }
}

rechargeequipment_updatestate(player) {
  if(!isDefined(player.rechargeequipmentstate)) {
    player.rechargeequipmentstate = spawnStruct();
    player.rechargeequipmentstate.progress = [];
    player.rechargeequipmentstate.recharged = [];
  }

  rechargeequipment_updateslot(player, "primary");
  rechargeequipment_updateslot(player, "secondary");
  rechargeequipment_updateui(player);
}

rechargeequipment_updateslot(player, slot) {
  state = player.rechargeequipmentstate;

  if(!isDefined(state.progress[slot]))
    state.progress[slot] = 0;

  state.recharged[slot] = undefined;
  equipment = player scripts\mp\equipment::getcurrentequipment(slot);

  if(!isDefined(equipment)) {
    return;
  }
  ammo = player scripts\mp\equipment::getequipmentammo(equipment);
  ammomax = player scripts\mp\equipment::getequipmentmaxammo(equipment);
  startammo = player scripts\mp\equipment::getequipmentstartammo(equipment);

  if(isDefined(level.gamemodeoverriderestockrechargeperupdate))
    _id_F4F42766799EAE36 = level.gamemodeoverriderestockrechargeperupdate;
  else
    _id_F4F42766799EAE36 = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508(), 0.01, 0.02);

  if(slot == "secondary" && ammo < ammomax && startammo > 1)
    state.progress[slot] = state.progress[slot] + _id_F4F42766799EAE36 * 2;
  else if(ammo < ammomax)
    state.progress[slot] = state.progress[slot] + _id_F4F42766799EAE36;
  else
    state.progress[slot] = 0;

  if(state.progress[slot] >= 1) {
    player scripts\mp\equipment::incrementequipmentslotammo(slot, 1);
    state.progress[slot] = 0;
    state.recharged[slot] = 1;
  }
}

rechargeequipment_clearplayer(player) {
  player endon("setRechargeEquipment");
  player endon("disconnect");
  player.rechargeequipmentstate = undefined;
  waitframe();
  rechargeequipment_updateui(player);
}

rechargeequipment_updateui(player) {
  _id_EA6C6F327A8C9B68 = 0;
  _id_A26D8AB03F8D1BCB = 0;
  _id_7732B71EB53C0AF1 = -1;

  if(isDefined(player) && isDefined(player.rechargeequipmentstate)) {
    player scripts\mp\utility\stats::initpersstat("restockCount");
    state = player.rechargeequipmentstate;

    if(isDefined(state.progress["primary"]))
      _id_EA6C6F327A8C9B68 = state.progress["primary"];

    if(isDefined(state.progress["secondary"]))
      _id_A26D8AB03F8D1BCB = state.progress["secondary"];

    foreach(slot, _ in state.recharged) {
      if(slot == "primary") {
        _id_7732B71EB53C0AF1 = _id_7732B71EB53C0AF1 + 1;
        player playlocalsound("ui_restock_lethals");
        player scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(slot == "secondary") {
        _id_7732B71EB53C0AF1 = _id_7732B71EB53C0AF1 + 2;
        player playlocalsound("ui_restock_tactical");
        player scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  player setclientomnvar("ui_lethal_recharge_progress", _id_EA6C6F327A8C9B68);
  player setclientomnvar("ui_tactical_recharge_progress", _id_A26D8AB03F8D1BCB);
  player setclientomnvar("ui_recharge_notify", _id_7732B71EB53C0AF1);
  player setpowerprogress("primary", _id_EA6C6F327A8C9B68);
  player setpowerprogress("secondary", _id_A26D8AB03F8D1BCB);
}

markequipment_monitorlook() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!isDefined(self.markequipmentstate)) {
    self.markequipmentstate = spawnStruct();
    self.markequipmentstate.markingtime = 0;
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markedents = [];
    self.markequipmentstate.markedentindex = 0;
    self.markequipmentstate.pastmarkedents = [];
    self.markequipmentstate.pastmarkedentindex = 0;
  }

  for(;;) {
    self waittill("marks_target_changed", ent);
    _id_49ED8019E89F9C5A = isDefined(ent) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = ent;
    self.markequipmentstate.markingtime = 0;

    if(_id_49ED8019E89F9C5A)
      thread markequipment_updatestate();
  }
}

markequipment_updatestate() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  _id_B4C04337A6A90C84 = gettime();
  maxdist = 0;

  if(self entityhasmark("air_killstreak", self.markequipmentstate.markingent))
    maxdist = getdvarint("perk_see_air_killstreak_distance");
  else if(self entityhasmark("killstreak", self.markequipmentstate.markingent))
    maxdist = getdvarint("perk_see_killstreak_distance");
  else if(self entityhasmark("equipment", self.markequipmentstate.markingent))
    maxdist = getdvarint("perk_see_equipment_distance");
  else {}

  _id_D8351990B067AA9B = maxdist * maxdist;

  while(isDefined(self.markequipmentstate.markingent) && !istrue(self.ishacking)) {
    if(self entitymarkfilteredin(self.markequipmentstate.markingent)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self.markequipmentstate.markingent) {
      break;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self) && !self _meth_A7DE57196F4B5D16()) {
      break;
    }

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > _id_D8351990B067AA9B) {
      break;
    }

    currenttime = gettime();
    _id_56DDE920C84C7B04 = currenttime - _id_B4C04337A6A90C84;
    self.markequipmentstate.markingtime = self.markequipmentstate.markingtime + _id_56DDE920C84C7B04;

    if(!scripts\engine\utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(scripts\mp\utility\player::isplayerads()) {
        _id_C626A360E6435920 = self.markequipmentstate.markedentindex;
        ent = self.markequipmentstate.markedents[_id_C626A360E6435920];

        if(isDefined(ent)) {
          ent filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(ent);
        }

        if(level.teambased)
          self.markequipmentstate.markingent filterinplayermarks(self.team);
        else
          self.markequipmentstate.markingent filterinplayermarks(self);

        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self playlocalsound("iw8_mp_perk_tactical_recon_marked");

        if(level.teambased && scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_instanceisregistered(self.markequipmentstate.markingent)) {
          self.markequipmentstate.markingent.teammarkedfor = self.team;
          players = scripts\mp\utility\teams::getteamdata(self.markequipmentstate.markingent.teammarkedfor, "players");

          foreach(player in players)
          scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_updatevisibilityforplayer(self.markequipmentstate.markingent, player);
        }

        self.markequipmentstate.markedents[_id_C626A360E6435920] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (_id_C626A360E6435920 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          scripts\mp\killstreaks\killstreaks::givescoreformarktarget(1);
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        } else
          scripts\mp\killstreaks\killstreaks::givescoreformarktarget(0);

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    _id_B4C04337A6A90C84 = currenttime;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

unmarkafterduration(_id_BE331B5A39B1738A) {
  level endon("game_ended");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  _id_BE331B5A39B1738A endon("death");
  timeoutduration = getdvarint("perk_mark_equipment_duration");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_1(timeoutduration, "disconnect");
  unmarkent(_id_BE331B5A39B1738A);
}

unmarkent(_id_BE331B5A39B1738A) {
  _id_BE331B5A39B1738A filterinplayermarks(undefined);

  if(isDefined(_id_BE331B5A39B1738A.teammarkedfor)) {
    if(level.teambased && scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_instanceisregistered(_id_BE331B5A39B1738A)) {
      players = scripts\mp\utility\teams::getteamdata(_id_BE331B5A39B1738A.teammarkedfor, "players");

      foreach(player in players)
      scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_updatevisibilityforplayer(_id_BE331B5A39B1738A, player);
    }

    _id_BE331B5A39B1738A.teammarkedfor = undefined;
  }

  if(isDefined(self)) {
    self.markequipmentstate.markedents = scripts\engine\utility::array_remove(self.markequipmentstate.markedents, _id_BE331B5A39B1738A);
    _id_BE331B5A39B1738A notify("unmarkEnt_" + self getentitynumber());
  }
}

setmarkequipment() {
  if(!level.teambased) {
    return;
  }
  self enabletargetmarks();
  thread markequipment_monitorlook();
}

unsetmarkequipment() {
  if(!level.teambased) {
    return;
  }
  if(isDefined(self.markequipmentstate)) {
    foreach(ent in self.markequipmentstate.markedents) {
      if(isDefined(ent))
        unmarkent(ent);
    }
  }

  self.markequipmentstate = undefined;
  self disabletargetmarks();
  self notify("mark_equip_ended");
}

getchildoutlineents(ent) {
  if(!isDefined(ent))
    return [];

  if(!isDefined(ent.childoutlineents))
    return [ent];

  return ent.childoutlineents;
}

outlinehelper_getallplayers(ent, _id_7AA1FF687CFC30D1) {
  return level.players;
}

outlinehelper_validplayer(player) {
  return 1;
}

outlinehelper_verifydata(_id_7AA1FF687CFC30D1) {
  if(!isDefined(_id_7AA1FF687CFC30D1.getplayers))
    _id_7AA1FF687CFC30D1.getplayers = ::outlinehelper_getallplayers;

  if(!isDefined(_id_7AA1FF687CFC30D1.validplayer))
    _id_7AA1FF687CFC30D1.validplayer = ::outlinehelper_validplayer;

  if(!isDefined(_id_7AA1FF687CFC30D1.hudoutlineassetname))
    _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget";

  if(!isDefined(_id_7AA1FF687CFC30D1.prioritygroup))
    _id_7AA1FF687CFC30D1.prioritygroup = "perk";

  if(!isDefined(_id_7AA1FF687CFC30D1.waittime))
    _id_7AA1FF687CFC30D1.waittime = 0.1;
}

outlinehelper_updateentityoutline(ent) {
  if(isDefined(ent)) {
    _id_8B1683C8EAD7B9BE = ent getentitynumber();
    outlinehelper_disableentityoutline(_id_8B1683C8EAD7B9BE);
    outlinehelper_enableentityoutline(ent);
  }
}

outlinehelper_enableentityoutline(ent) {
  if(!isDefined(ent)) {
    return;
  }
  _id_8B1683C8EAD7B9BE = ent getentitynumber();
  _id_913FE1549A1C5C96 = self.entityoutlines[_id_8B1683C8EAD7B9BE];

  if(isDefined(_id_913FE1549A1C5C96)) {
    return;
  }
  _id_7AA1FF687CFC30D1 = undefined;

  if(self entitymarkfilteredin(ent)) {
    _id_7AA1FF687CFC30D1 = spawnStruct();
    _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
    _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target";
    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  }

  ismarked = self entitymarkfilteredin(ent);

  if(self entityhasmark("air_killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }
    _id_7AA1FF687CFC30D1 = spawnStruct();

    if(ismarked) {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target_killstreak_air";
    } else {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget_killstreak_air";
    }

    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  } else if(self entityhasmark("killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }
    _id_7AA1FF687CFC30D1 = spawnStruct();

    if(ismarked) {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target_killstreak";
    } else {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget_killstreak";
    }

    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  } else if(self entityhasmark("equipment", ent)) {
    _id_7AA1FF687CFC30D1 = spawnStruct();

    if(ismarked) {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk_superior";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_target_equipment";
    } else {
      _id_7AA1FF687CFC30D1.prioritygroup = "perk";
      _id_7AA1FF687CFC30D1.hudoutlineassetname = "spotter_notarget_equipment";
    }

    outlinehelper_verifydata(_id_7AA1FF687CFC30D1);
  }

  if(isDefined(_id_7AA1FF687CFC30D1)) {
    _id_913FE1549A1C5C96 = spawnStruct();
    self.entityoutlines[_id_8B1683C8EAD7B9BE] = _id_913FE1549A1C5C96;
    _id_913FE1549A1C5C96.list = [];
    _id_913FE1549A1C5C96.ent = ent;
    _id_20D77D27621233DF = getchildoutlineents(ent);

    foreach(child in _id_20D77D27621233DF) {
      entoutlineid = scripts\mp\utility\outline::outlineenableforplayer(child, self, _id_7AA1FF687CFC30D1.hudoutlineassetname, _id_7AA1FF687CFC30D1.prioritygroup);
      outline = spawnStruct();
      outline.ent = child;
      outline.id = entoutlineid;
      _id_0AD3B147E911F12F = child getentitynumber();
      _id_913FE1549A1C5C96.list[_id_0AD3B147E911F12F] = outline;
    }
  }
}

outlinehelper_disableentityoutline(entnum) {
  if(isDefined(entnum)) {
    _id_913FE1549A1C5C96 = self.entityoutlines[entnum];

    if(isDefined(_id_913FE1549A1C5C96)) {
      foreach(outline in _id_913FE1549A1C5C96.list)
      scripts\mp\utility\outline::outlinedisable(outline.id, outline.ent);

      self.entityoutlines[entnum] = undefined;
    }
  }
}

markedentities_removeentsbyindex(_id_1D2BE7531AAF82AF, _id_223829BBEFC81935) {
  _id_5877436CC451FA7D = [];

  foreach(ent in _id_1D2BE7531AAF82AF) {
    if(!isDefined(ent)) {
      continue;
    }
    entnum = ent getentitynumber();

    if(!scripts\engine\utility::array_contains(_id_223829BBEFC81935, entnum))
      _id_5877436CC451FA7D[_id_5877436CC451FA7D.size] = ent;
  }

  return _id_5877436CC451FA7D;
}

markedentities_think() {
  self endon("disconnect");
  level endon("game_ended");
  self.entityoutlines = [];

  for(;;) {
    self waittill("marks_changed", _id_B56AC8B012F37095, _id_7B50CC9C94BE9505, _id_C5DDA6B7A37D4129);

    if(isDefined(_id_B56AC8B012F37095)) {
      foreach(_id_E0ABEAA6EF08E178 in _id_B56AC8B012F37095)
      outlinehelper_disableentityoutline(_id_E0ABEAA6EF08E178);

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = markedentities_removeentsbyindex(self.markequipmentstate.markedents, _id_B56AC8B012F37095);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size)
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
      }
    }

    if(isDefined(_id_7B50CC9C94BE9505)) {
      foreach(_id_4905D157180507C8 in _id_7B50CC9C94BE9505)
      outlinehelper_disableentityoutline(_id_4905D157180507C8);
    }

    if(isDefined(_id_C5DDA6B7A37D4129)) {
      foreach(_id_F445C1A8471869FE in _id_C5DDA6B7A37D4129)
      outlinehelper_enableentityoutline(_id_F445C1A8471869FE);
    }
  }
}

setbettermissionrewards() {}

unsetbettermissionrewards() {}

setspecialistbonus() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_specialist_bonus_active", 1);
}

unsetspecialistbonus() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_specialist_bonus_active", 0);
}

_id_756D7E15C7467312() {
  self._id_9E3BDDA27A519A9F = 1;
  scripts\mp\class::_id_C5CE8711741E44B8();
}

_id_FBD953549BE66251() {
  self._id_9E3BDDA27A519A9F = undefined;

  if(!istrue(level.gameended))
    scripts\mp\class::_id_C5CE8711741E44B8();
}

_id_D31614685FB778E1() {
  self notify("undying");
  self._id_E0672FBE459F5193 = 1;
}

_id_62E54942C53B9BDA() {
  self notify("undyingEnd");
  self._id_E0672FBE459F5193 = undefined;
}

_id_7CFA6000210CBD68() {
  self setclientomnvar("ui_overcharge", 2);
}

_id_F1A813FE1B8A2275() {
  self setclientomnvar("ui_overcharge", 0);
}

_id_6FAFF35E3A38BA5F() {
  thread _id_28C65EF144EF09ED();
}

_id_D02ED6D205E7EB64() {}

setsurvivor() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self._id_D3BFE8BAAE5DF8E0 = 1;
}

unsetsurvivor() {
  if(isDefined(self._id_D3BFE8BAAE5DF8E0))
    self._id_D3BFE8BAAE5DF8E0 = undefined;
}

_id_17F9B8D5579B7E98() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(getdvarint("dvar_8C032D1B63113BA0", 0) != 0) {
      return;
    }
    self._id_678855513F5076CA = 1;
    self._id_0514192F8282796C = getdvarint("dvar_5873A982B260E538", 1);
    self._id_A68B289A82138067 = 0;
    _id_A063A7CEBBE73076 = scripts\mp\equipment::getequipmentslotammo("super");

    if(isDefined(scripts\mp\supers::getcurrentsuper()) && isDefined(_id_A063A7CEBBE73076) && _id_A063A7CEBBE73076 > 0) {
      if(_id_66F0CBD5FF8458FE()) {
        scripts\mp\equipment::setequipmentslotammo("super", 0);
        scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
      }
    } else if(isDefined(scripts\mp\supers::getcurrentsuper()))
      self setclientomnvar("ui_perk_package_state", 3);
  } else if(!isDefined(self._id_A68B289A82138067))
    self._id_A68B289A82138067 = 0;

  thread _id_E382D4A17C2FD280();
}

_id_66F0CBD5FF8458FE() {
  _id_D3C112E63BF53EE5 = scripts\mp\supers::getcurrentsuper();

  if(!isDefined(_id_D3C112E63BF53EE5))
    return 0;

  if(level.allowsupers && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 1;

  if(!istrue(self._id_678855513F5076CA))
    return 0;

  if(scripts\mp\supers::_id_F95BCCA44E8CBA53(_id_D3C112E63BF53EE5.staticdata.ref))
    return 0;

  return 1;
}

_id_448448AC4206D715() {
  if(isDefined(self._id_2C0BF62A8DB71FD0))
    self._id_2C0BF62A8DB71FD0 = undefined;

  if(isDefined(self._id_491F93D0219D8D44) && self._id_491F93D0219D8D44 > 1)
    self._id_491F93D0219D8D44 = self._id_491F93D0219D8D44 - 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(isDefined(scripts\mp\supers::getcurrentsuper())) {
      scripts\mp\supers::_id_08C7B1312CF5986B(0);

      if(scripts\mp\supers::getcurrentsuperpoints() < scripts\mp\supers::getsuperpointsneeded()) {
        if(!scripts\mp\supers::issuperinuse()) {
          scripts\mp\supers::setsuperbasepoints(0);
          thread scripts\mp\supers::_id_E648B6FC93BBC0E0();
          self setclientomnvar("ui_perk_package_state", 0);
        }
      }
    }
  }

  if(isDefined(self._id_678855513F5076CA))
    self._id_678855513F5076CA = undefined;

  if(isDefined(self._id_0514192F8282796C))
    self._id_0514192F8282796C = undefined;

  self notify("end_overcharge_field_upgrade");
}

_id_E382D4A17C2FD280() {
  self endon("death_or_disconnect");
  self endon("end_overcharge_field_upgrade");

  while(!isDefined(self._id_678855513F5076CA)) {
    self waittill("super_use_charging");
    waitframe();

    if(self.super.isinuse) {
      continue;
    }
    if(!_id_66F0CBD5FF8458FE()) {
      continue;
    }
    if(self._id_A68B289A82138067 > 0 && scripts\mp\supers::issupercharging()) {
      scripts\mp\supers::givesuperpoints(self._id_A68B289A82138067, undefined, undefined, undefined, 1);
      self._id_A68B289A82138067 = 0;
      self setclientomnvar("ui_super_second_progress", 0);
    }
  }
}

_id_28C65EF144EF09ED() {
  self endon("death_or_disconnect");
  waitframe();
  _id_07C40FA80892A721::givestartingarmor(50, 1);
}

_id_6964A0E0E8D00B09(perk) {
  if(!istrue(level._id_606EB45E074FF204)) {
    return;
  }
  switch (perk) {
    case "specialty_overcharge_field_upgrade":
      _id_C0480A308E322F5E();
      break;
    case "specialty_overwatch":
      _id_DEAAE24BE7F66B43();
      break;
  }
}

_id_F1ADED34AD0D8D15() {
  super = scripts\mp\supers::getcurrentsuper();

  if(!isDefined(super))
    return 0;

  if(!isDefined(super.basepoints))
    return 0;

  if(!isDefined(super.extrapoints))
    return 0;

  if(!isDefined(super.staticdata.pointsneeded))
    return 0;

  return 1;
}

_id_C0480A308E322F5E() {
  if(!_id_F1ADED34AD0D8D15()) {
    return;
  }
  _id_7460D810DB8A0BA9 = scripts\engine\utility::ter_op(scripts\mp\supers::issuperready() || scripts\mp\supers::issuperinuse(), scripts\mp\supers::getsuperpointsneeded(), scripts\mp\supers::getcurrentsuperpoints());
  _id_1BA38423D163B2F6 = scripts\mp\supers::getsuperpointsneeded();
  _id_60DEC3FB001C2B48 = max(0, _id_1BA38423D163B2F6 - _id_7460D810DB8A0BA9);
  scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
  self._id_A68B289A82138067 = clamp(_id_7460D810DB8A0BA9, 0, _id_1BA38423D163B2F6);

  if(!isDefined(self._id_491F93D0219D8D44))
    self._id_491F93D0219D8D44 = 1;

  self._id_491F93D0219D8D44 = self._id_491F93D0219D8D44 + 1;
}

_id_DEAAE24BE7F66B43() {
  triggerportableradarping(self.origin, self, 3000, 3000);
}

_id_5574429FA21B6A4B() {
  self.pers["hasEarnedHardlineStreak"] = 0;
  scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_FAA043C8926419E6", 3, 0);
}

_id_DE2E2E90E60AB20B() {
  equipment = self getweaponslistoffhands();

  foreach(item in equipment)
  self givemaxammo(item);
}

_id_649944F83A9270F1() {
  scripts\mp\killstreaks\killstreaks::awardkillstreak("scrambler_drone_guard", "other");
}

_id_9569D64CD3471640() {
  _id_F835339FB0E0E6E2 = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, 3000);
  _id_7AA1FF687CFC30D1 = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_createoutlinedata(self, self.origin);

  foreach(player in _id_F835339FB0E0E6E2) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(self, player)) {
      continue;
    }
    scripts\mp\equipment\snapshot_grenade::snapshot_grenade_applysnapshot(player, self, _id_7AA1FF687CFC30D1, 2500, 1);
  }
}

_id_2AFCFD10BAA613F4() {
  if(scripts\mp\utility\perk::_hasperk("specialty_armored") && self getammocount("bandage_br") < 1)
    _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(1);
}

_id_A686A690639763DA() {
  self notify("setAnteUp_singleton");
  self endon("setAnteUp_singleton");
  self endon("death_or_disconnect");

  if(istrue(self.gettingloadout))
    self waittill("giveLoadout");

  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_ante_up"];
  points = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_6AD84838E108705A, 0);

  if(!istrue(self._id_606B2FB83BFCB7D1) && isDefined(self.streakpoints)) {
    scripts\mp\events::killeventtextpopup("stat_8BE8F8D0AA5E17DF", 0);
    scripts\mp\killstreaks\killstreaks::setstreakpoints(self.streakpoints + points);
    self._id_606B2FB83BFCB7D1 = 1;
  }
}

_id_22483F0BF514320B() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_ante_up"];
  points = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_6AD84838E108705A, 0);

  if(istrue(self._id_606B2FB83BFCB7D1) && isDefined(self.streakpoints)) {
    scripts\mp\killstreaks\killstreaks::setstreakpoints(self.streakpoints - points);
    self._id_606B2FB83BFCB7D1 = 0;
  }
}

_id_E1349C922318FC19() {
  self notify("slayeronkill_buff");
  _id_C386FD3901A88F30();
  _id_7DD47029F6FC6CEF();
  _id_3EC53AC5E0194753();
}

_id_C386FD3901A88F30() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_slayer"];
  _id_BEA5DF9B0DB5793C = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_6B89E26721E94442, 1);
  _id_81EEB2DE2D93D950 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_A3965D6B67C5F57A, 0);

  if(!isDefined(self.cranked)) {
    self.movespeedscaler = _id_BEA5DF9B0DB5793C;
    scripts\mp\weapons::updatemovespeedscale();
    thread _id_BE29F02ED2CEAEA2(_id_81EEB2DE2D93D950);
  }
}

_id_BE29F02ED2CEAEA2(_id_74B5B12BB6514385) {
  if(_id_74B5B12BB6514385) {
    self endon("slayeronkill_buff");
    self endon("death_or_disconnect");
    wait(_id_74B5B12BB6514385);
  }

  self.movespeedscaler = 1.0;
  scripts\mp\weapons::updatemovespeedscale();
}

_id_7DD47029F6FC6CEF() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_slayer"];
  _id_81EEB2DE2D93D950 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_A3965D6B67C5F57A, 0);

  if(!isDefined(self.cranked)) {
    self._id_51FD42CCE181AED4 = 1;
    thread _id_37401473F4B2D2ED(_id_81EEB2DE2D93D950);
  }
}

_id_37401473F4B2D2ED(_id_74B5B12BB6514385) {
  if(_id_74B5B12BB6514385) {
    self endon("slayeronkill_buff");
    self endon("death_or_disconnect");
    wait(_id_74B5B12BB6514385);
  }

  self._id_51FD42CCE181AED4 = 0;
}

_id_3EC53AC5E0194753() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_slayer"];
  _id_81EEB2DE2D93D950 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_A3965D6B67C5F57A, 0);
  self setclientomnvar("ui_slayerBuff", 1);
  self _meth_C22254916FDFA3E5(1);
  thread _id_7C52C8AF6DEF857A(_id_81EEB2DE2D93D950);
}

_id_7C52C8AF6DEF857A(_id_74B5B12BB6514385) {
  if(_id_74B5B12BB6514385) {
    self endon("slayeronkill_buff");
    self endon("death_or_disconnect");
    wait(_id_74B5B12BB6514385);
  }

  self setclientomnvar("ui_slayerBuff", 0);
  self _meth_C22254916FDFA3E5(0);
  self lerpfovbypreset("default_2seconds");
}

_id_8D12A3F39C293F29() {
  self._id_51FD42CCE181AED4 = 0;
}

_id_CD592C12C1E9CD58() {
  _id_37401473F4B2D2ED(0);
  _id_BE29F02ED2CEAEA2(0);
  _id_7C52C8AF6DEF857A(0);
}

_id_B8D4388CDB3CA5C8() {
  if(!isDefined(self._id_892C291C8EEC8AF2)) {
    self._id_892C291C8EEC8AF2 = 0;
    return;
  }

  if(istrue(self._id_892C291C8EEC8AF2)) {
    return;
  }
  thread _id_0B2219A25A144067();
  self notify("setoperative_outlines");

  if(istrue(self.gettingloadout)) {
    self endon("setoperative_outlines");
    self endon("death_or_disconnect");
    self waittill("giveLoadout");
  }

  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_operative"];
  _id_81EEB2DE2D93D950 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_FFE863E741796294, 0);
  _id_1F033237D8F9E787();
  _id_04030B0CBD934F9C(_id_81EEB2DE2D93D950);
}

_id_0B2219A25A144067() {
  self notify("resetOperativeSingleton");
  self endon("resetOperativeSingleton");
  self endon("disconnect");
  self waittill("death");
  self._id_892C291C8EEC8AF2 = 0;
}

_id_1F033237D8F9E787() {
  self._id_892C291C8EEC8AF2 = 1;

  if(!isDefined(self._id_4920729D2BB168E6))
    self._id_4920729D2BB168E6 = [];

  foreach(enemy in level.players) {
    if(!isPlayer(enemy)) {
      continue;
    }
    if(!scripts\cp_mp\utility\player_utility::isenemy(enemy)) {
      continue;
    }
    self._id_4920729D2BB168E6[enemy getentitynumber()] = scripts\mp\utility\outline::outlineenableforplayer(enemy, self, "outline_nodepth_red", "level_script");
  }
}

_id_04030B0CBD934F9C(_id_74B5B12BB6514385) {
  if(!isarray(self._id_4920729D2BB168E6)) {
    return;
  }
  if(_id_74B5B12BB6514385) {
    self endon("setoperative_outlines");
    self endon("death_or_disconnect");
    wait(_id_74B5B12BB6514385);
  }

  foreach(enemy in level.players) {
    if(!isPlayer(enemy)) {
      continue;
    }
    if(!scripts\cp_mp\utility\player_utility::isenemy(enemy)) {
      continue;
    }
    _id_90ED359D3E96BDCC = enemy getentitynumber();

    if(!isDefined(self._id_4920729D2BB168E6[_id_90ED359D3E96BDCC])) {
      continue;
    }
    scripts\mp\utility\outline::outlinedisable(self._id_4920729D2BB168E6[_id_90ED359D3E96BDCC], enemy);
  }
}

_id_4FCF4D3385AAFB53() {
  _id_04030B0CBD934F9C(0);
}

_id_4A833BCF538DBBF0() {
  self.radarshowenemydirection = 1;
}

_id_9CEA3E4EA6FBE3D7() {
  if(isDefined(level.activeadvanceduavs) && isDefined(level.activeadvanceduavs[self.team]) && level.activeadvanceduavs[self.team] > 0) {
    return;
  }
  self.radarshowenemydirection = 0;
}

_id_AF3D35751DFD4E79() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return undefined;
  else
    return ["specialty_expanded_minimap"];
}

_id_87C42BAF479B4429() {}

_id_E01778BEE1E0920D(event) {
  if(!isDefined(event)) {
    return;
  }
  if(!isDefined(level._id_F2C20BADBF2BA135[event])) {
    return;
  }
  if(!scripts\mp\utility\perk::_hasperk("specialty_tactician")) {
    return;
  }
  _id_F0920D8378D4ECE8 = level._id_F2C20BADBF2BA135[event];
  scripts\mp\utility\points::_id_0366980B6A8796AE(_id_F0920D8378D4ECE8);
}

_id_1A94D63C3C447DDC() {
  if(isDefined(level._id_F2C20BADBF2BA135)) {
    return;
  }
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_tactician"];
  level._id_F2C20BADBF2BA135 = [];
  _id_4EB4D9F70BDF5432 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_4EB4D9F70BDF5432, []);

  foreach(_id_256154779845A56B in _id_4EB4D9F70BDF5432) {
    _id_F0FA3B7B27926553 = _id_256154779845A56B._id_F0FA3B7B27926553;
    _id_EBBB078E6AA4336E = _id_256154779845A56B._id_EBBB078E6AA4336E;

    if(!isDefined(_id_F0FA3B7B27926553)) {
      continue;
    }
    if(!isDefined(_id_EBBB078E6AA4336E)) {
      continue;
    }
    level._id_F2C20BADBF2BA135[_id_F0FA3B7B27926553] = _id_EBBB078E6AA4336E;
  }
}

_id_04AF62A9306C8436() {}

_id_153CF3C8788FE8C1() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_tactician"];
  _id_ACA8F63896A7AA46 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_ACA8F63896A7AA46, 1.0);
  _id_33991AD35A96595A = 1 / _id_ACA8F63896A7AA46;
  setDvar("perk_fastOffhandMultiplier", _id_33991AD35A96595A);
  level _id_1A94D63C3C447DDC();
  level _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("onPlayerScore_TacticianBonus", ::_id_E01778BEE1E0920D);
}

_id_81F0718F6C5AB1D7() {
  self setgrenadethrowscale(1.25);
}

_id_2BBA0E9E144C276C() {
  self setgrenadethrowscale(1);
}

_id_E2DF669ADA6F810C() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_scavenger"];
  _id_D86975024A74BA6C = isDefined(_id_D442547D75DFFD09) && istrue(_id_D442547D75DFFD09._id_A17534D1B2C3F881);

  if(!_id_D86975024A74BA6C && scripts\mp\utility\perk::_hasperk("specialty_scavenger_equipment"))
    scripts\mp\perks\perks::_unsetperk("specialty_scavenger_equipment");
}

_id_76826219412C80CE() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_flak_jacket"];

  if(!isDefined(_id_D442547D75DFFD09) && scripts\mp\utility\perk::_hasperk("specialty_flak_jacket")) {
    scripts\mp\perks\perks::_unsetperk("specialty_flak_jacket");
    return;
  }

  if(isDefined(self._id_81C247612E9C90C3)) {
    if(self._id_81C247612E9C90C3 <= 0)
      _id_BBFB43EDED941446();

    return;
  }

  self._id_81C247612E9C90C3 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_AE4892E2F1BB4145, 200);
  self._id_08CBE63A199E19DE = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_08CBE63A199E19DE, 50);
  self._id_FB1106D94CC95901 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_FB1106D94CC95901, 50);
  _id_576FF7CB2B682B18();
}

_id_2A071B7E5D0351D3() {
  self._id_81C247612E9C90C3 = undefined;
  self._id_08DDDE3A19B245A2 = undefined;
  self._id_FB21FED94CDB51C5 = undefined;
  _id_8A6140B305C1B22B();
}

_id_C8717DCA5558B2FB() {
  _id_5762AC2F22202BA2::_id_7BC7C3983CEF0956("hitFlakJacket", 20);
}

_id_21EC07CE4E600C3A(amount) {
  startinghealth = self._id_81C247612E9C90C3;
  self._id_81C247612E9C90C3 = self._id_81C247612E9C90C3 + amount;

  if(startinghealth <= 0 && self._id_81C247612E9C90C3 > 0) {
    scripts\mp\perks\perks::_setperk("specialty_blastshield");
    scripts\mp\perks\perks::_setperk("specialty_fire_resistence");
  }
}

_id_576FF7CB2B682B18() {
  self._id_8E7850D487706D4D = newhudelem();
  self._id_8E7850D487706D4D.archived = 0;
  self._id_8E7850D487706D4D.location = 0;
  self._id_8E7850D487706D4D.alignx = "center";
  self._id_8E7850D487706D4D.aligny = "bottom";
  self._id_8E7850D487706D4D.foreground = 1;
  self._id_8E7850D487706D4D.fontscale = 1;
  self._id_8E7850D487706D4D.sort = 20;
  self._id_8E7850D487706D4D.alpha = 1;
  self._id_8E7850D487706D4D.x = 512;
  self._id_8E7850D487706D4D.y = 384;
  text = "Flak Jacket Health: " + self._id_81C247612E9C90C3;
  thread _id_46990AAE5CE032AD();
}

_id_8A6140B305C1B22B() {
  if(isDefined(self._id_8E7850D487706D4D))
    self._id_8E7850D487706D4D destroy();

  self notify("blast_shield_removed");
}

_id_46990AAE5CE032AD() {
  self endon("death");
  self endon("blast_shield_removed");
  self waittill("blast_shield_damaged", _id_2D3C546342A0A1EF);
  text = "Flak Jacket Health: " + _id_2D3C546342A0A1EF;
  thread _id_46990AAE5CE032AD();
}

_id_DF1F464B16738E76() {
  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E["specialty_flak_jacket"];

  if(!isDefined(_id_D442547D75DFFD09)) {
    return;
  }
  if(isDefined(self._id_FB21FED94CDB51C5)) {
    return;
  }
  self._id_FB21FED94CDB51C5 = scripts\engine\utility::_id_53C4C53197386572(_id_D442547D75DFFD09._id_FB21FED94CDB51C5, 50);
}

_id_9A3330B21E0AD027() {
  self._id_FB21FED94CDB51C5 = undefined;
}

_id_2E7374F107A12700() {
  _id_BBFB43EDED941446();
  _id_8A6140B305C1B22B();
}

_id_BBFB43EDED941446() {
  scripts\mp\perks\perks::_unsetperk("specialty_blastshield");
  scripts\mp\perks\perks::_unsetperk("specialty_fire_resistence");
}

_id_C834F1EACBB06D09() {
  self _meth_D7BF524EB1822214(1);
}

_id_B35C8CF5DD0E38A2() {
  self _meth_D7BF524EB1822214(0);
}

_id_57FA0386E81EAF33() {
  self.radarshowenemydirection = 1;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    level thread _id_1F97A44D1761C919::_id_AEA00C3815B226DA(self);
}

_id_4173E65571FBFD44() {
  if(!isDefined(self) || !isDefined(self.team))
    return 0;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    self notify("monitor_enemy_prox");

  if(isDefined(level.activeadvanceduavs) && isDefined(level.activeadvanceduavs[self.team]) && level.activeadvanceduavs[self.team] > 0) {
    return;
  }
  self.radarshowenemydirection = 0;
}

_id_E16E3E01EB4E705E() {
  self._id_42294CC94C3BF2C3 = 75;
}

_id_3BFEABC0BD9D0CBF() {
  self._id_42294CC94C3BF2C3 = undefined;
}

_id_7603AADD14DA7EC6() {
  self.hasplatepouch = 1;
}

_id_6AF20073381A18D3() {
  self.hasplatepouch = 0;
}

_id_DA3D9F34D24AC85A() {
  _id_189B67B2735B981D::_id_0F70B3CE9138E10B(self);
}

_id_096F59FEFD781E47() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_189B67B2735B981D::_id_2CC0D17B7E641E00(self, "announcer");
}

_id_096F5AFEFD78207A() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_189B67B2735B981D::_id_2CC0D17B7E641E00(self, "robot");
}

_id_096F5BFEFD7822AD() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_189B67B2735B981D::_id_2CC0D17B7E641E00(self, "hypeman");
}

_id_096F54FEFD781348() {
  if(!getdvarint("dvar_18BF04D5C5766462")) {
    return;
  }
  _id_189B67B2735B981D::_id_2CC0D17B7E641E00(self, "blackcell");
}

_id_FC6E0B02ABB995CB() {
  _id_189B67B2735B981D::_id_2CC0D17B7E641E00(self, "announcer");
}

_id_73E4AE4F932E9F30() {
  _id_189B67B2735B981D::_id_2CC0D17B7E641E00(self, "robot");
}