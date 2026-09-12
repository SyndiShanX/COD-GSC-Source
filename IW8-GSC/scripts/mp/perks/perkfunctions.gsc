/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perkfunctions.gsc
***********************************************/

function setbountyhunter() {}

function unsetbountyhunter() {}

function sethealer() {
  thread radialhealer();
}

function radialhealer() {
  self endon("unset_healer");
  self endon("disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }

  self.teammateswithhealperk = [];

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 350, self.team, self);

      foreach(var_2 in var_0) {
        if(var_2 scripts\mp\utility\perk::_hasperk("specialty_healer")) {
          continue;
        }

        if(self.team == var_2.team && var_2 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var_2.healer)) {
          var_3 = var_2 getentitynumber();

          if(self.teammateswithhealperk.size == 0) {
            scripts\mp\hud_message::showmiscmessage("healing_players");
          }

          var_2.healer = self;
          self.teammateswithhealperk[var_3] = 1;
          var_2 scripts\mp\utility\perk::giveperk("specialty_regenfaster");
          var_2 scripts\mp\utility\perk::giveperk("specialty_regen_delay_reduced");
          var_2 scripts\mp\hud_message::showmiscmessage("in_healing_range");
          givehealedoverlay(var_2);
          thread healerperkteammatewatcher(var_2);
          thread healerperkteammatedestructor(var_2);
        }
      }
    }

    wait 0.3;
  }
}

function healerperkteammatewatcher(var_0) {
  level endon("game_ended");
  self endon("unset_healer");
  self endon("death_or_disconnect");
  var_0 endon("death_or_disconnect");

  for(;;) {
    var_1 = 400;

    if(distancesquared(self.origin, var_0.origin) > var_1 * var_1 || var_0.team != self.team) {
      var_0 notify("out_of_healing_range");
      return;
    }

    var_2 = var_0 getentitynumber();

    if(var_0.health < var_0.maxhealth && var_0.healedoverlay.alpha == var_0.healedoverlay.lowalpha) {
      thread healedoverlayfade(var_0, var_0.healedoverlay, self);
    } else if(var_0.health == var_0.maxhealth) {
      thread healedoverlayfade(var_0, var_0.healedoverlay, self);
    }

    wait 0.1;
  }
}

function healerperkteammatedestructor(var_0) {
  level endon("game_ended");
  var_1 = var_0 getentitynumber();
  scripts\engine\utility::waittill_any_ents(self, "unset_healer", self, "death_or_disconnect", var_0, "death_or_disconnect", var_0, "out_of_healing_range");

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\perk::removeperk("specialty_regenfaster");
    var_0 scripts\mp\utility\perk::removeperk("specialty_regen_delay_reduced");
    var_0.healer = undefined;
    var_0 scripts\mp\hud_message::showmiscmessage("out_of_healing_range");
  }

  if(isDefined(self)) {
    self.teammateswithhealperk[var_1] = undefined;

    if(self.teammateswithhealperk.size == 0) {
      scripts\mp\hud_message::showmiscmessage("no_healing_players");
      return;
    }

    return;
  }
}

function unsethealer() {
  self notify("unset_healer");
}

function givehealedoverlay(var_0) {
  var_1 = newclienthudelem(var_0);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("overlay_healer", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1.lowalpha = 0;
  var_1.highalpha = 0.75;
  var_0.healedoverlay = var_1;
  thread healedoverlayfade(var_0, var_1, self);
  thread healedoverlaydestructor(var_0, var_1);
}

function healedoverlayfade(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("out_of_healing_range");
  var_1 endon("death_or_disconnect");
  var_1 endon("unset_healer");
  var_0 fadeovertime(0.5);
  var_0.alpha = var_2;
}

function healedoverlaydestructor(var_0, var_1) {
  scripts\engine\utility::waittill_any_ents(level, "game_ended", var_1, "unset_healer", var_1, "death_or_disconnect", self, "death_or_disconnect", self, "out_of_healing_range");

  if(isDefined(var_0)) {
    var_0 fadeovertime(1);
    var_0.alpha = 0;
    wait 1;
    var_0 destroy();
    return;
  }
}

function settank() {}

function unsettank() {}

function setsurvivor() {}

function unsetsurvivor() {}

function setstealth() {}

function unsetstealth() {}

function setbreacher() {
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 1);
}

function unsetbreacher() {
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 0);
}

function setsupport() {}

function unsetsupport() {}

function setdemolitions() {}

function unsetdemolitions() {}

function setintel() {}

function unsetintel() {}

function sethunter() {}

function unsethunter() {}

function setspotter() {}

function unsetspotter() {}

function setmunitions() {}

function unsetmunitions() {}

function setoffhandprovider() {
  thread offhandproviderthread();
}

function offhandproviderthread() {
  level endon("game_ended");
  self endon("unset_offhand_provider");
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 144, self.team, self);

    foreach(var_2 in var_0) {
      if(!isDefined(var_2.ohpequipmentrefills)) {
        var_2.ohpequipmentrefills = [];
      }

      if(equipmentusedbyslot(var_2, "primary") == 0 && equipmentusedbyslot(var_2, "secondary") == 0) {
        continue;
      }

      if(!isDefined(var_2.ohpequipmentrefills[self getentitynumber()]) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_2.ohpequipmentrefills[self getentitynumber()] = 1;
        var_3 = refillequipment(var_2);

        for(var_4 = 0; var_4 < var_3["primary"]; var_4++) {
          thread ohpequipmentfillednotification(var_2, self.name);
        }

        for(var_4 = 0; var_4 < var_3["secondary"]; var_4++) {
          thread ohpequipmentfillednotification(var_2, self.name);
        }

        thread ohpallowuseonplayerdeath(var_2);
        var_2 playsoundtoplayer("scavenger_pack_pickup", var_2);
      }
    }

    wait 0.1;
  }
}

function ohpallowuseonplayerdeath(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = self getentitynumber();
  scripts\engine\utility::waittill_any_ents_return(self, "disconnect", var_0, "death");
  var_0.ohpequipmentrefills[var_1] = undefined;
}

function unsetoffhandprovider() {
  self notify("unset_offhand_provider");
}

function refillequipment() {
  var_0 = [];
  GscBinSkip0(0x2e, "primary", equipmentusedbyslot("primary", 1));
}

function equipmentusedbyslot(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = scripts\mp\equipment::getcurrentequipment(var_0);
  var_3 = getequipmentstartammo(var_0);
  var_4 = scripts\mp\equipment::getequipmentammo(var_2);

  if(var_1 && var_3 - var_4 > 0) {
    scripts\mp\equipment::incrementequipmentammo(var_2, var_3 - var_4);
  }

  return var_3 - var_4;
}

function getequipmentstartammo(var_0) {
  var_1 = scripts\mp\equipment::getcurrentequipment(var_0);
  var_2 = scripts\mp\equipment::getequipmentstartammo(var_1);

  if(var_0 == "primary" && scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) {
    var_2 = scripts\mp\equipment::getequipmentmaxammo(var_1);
  }

  return var_2;
}

function ohpequipmentfillednotification(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.munitionsnotifications)) {
    self.munitionsnotifications = [];
  }

  var_2 = self.munitionsnotifications.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(var_3 < 2) {
      thread movenotificationup(self.munitionsnotifications[var_3]);
      continue;
    }

    var_4 = self.munitionsnotifications[var_3];
    self.munitionsnotifications[var_3] = undefined;
    var_4 notify("delete_icon_elem");
  }

  var_5 = 620;
  var_6 = 360;
  var_7 = 352;
  var_8 = 264;
  var_9 = newclienthudelem(self);
  var_9.x = var_7;
  var_9.y = var_8;
  var_9.alignx = "right";
  var_9.aligny = "top";
  var_9.sort = 2;
  var_9.alpha = 0;
  var_10 = scripts\mp\equipment::getequipmenttableinfo(var_1);
  var_9 setshader(var_10.image, 25, 25);
  var_9 fadeovertime(0.15);
  var_9 moveovertime(0.35);
  var_9.alpha = 1;
  var_9.x = var_5;
  var_9.y = var_6;
  self.munitionsnotifications = scripts\engine\utility::array_insert(self.munitionsnotifications, var_9, 0);
  var_9 endon("delete_icon_elem");
  thread ohpcleanupnotificationondeath(var_9);
  var_9.isanimating = 1;
  wait 0.35;
  var_9.isanimating = 0;
  wait 3;
  var_9 fadeovertime(0.5);
  var_9.alpha = 0;
  wait 0.5;
  var_9 notify("delete_icon_elem");
}

function ohpcleanupnotificationondeath(var_0) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_ents(self, "death_or_disconnect", var_0, "delete_icon_elem");

  if(isDefined(self)) {
    self.munitionsnotifications = scripts\engine\utility::array_remove(self.munitionsnotifications, var_0);
  }

  var_0 destroy();
}

function movenotificationup(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 endon("delete_icon_elem");

  if(!istrue(var_0.isanimating)) {
    var_0 moveovertime(0.35);
  }

  var_0.y -= 25;
  wait 0.35;
}

function ref_131b3() {
  self endon("death_or_disconnect");
  self endon("quick_unset");
  self notify("setquick_start");
  self endon("setquick_start");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143af("sprint_begin", "sprint_end", "weapon_change", "death");
    thread set_train_stopped(var_0);
  }
}

function ref_13f6a() {
  self notify("quick_unset");
  self setmovespeedscale(1);
}

function set_train_stopped(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(var_0 == "sprint_begin") {
    if(self.lastweaponobj hasattachment("gunperk_quick")) {
      self setmovespeedscale(1.04);
      return;
    }

    return;
  }

  if(var_0 == "sprint_end" || var_0 == "death") {
    self setmovespeedscale(1);
    return;
  }

  if(var_0 == "weapon_change") {
    waitframe();

    if(!self.lastweaponobj hasattachment("gunperk_quick")) {
      self setmovespeedscale(1);
      return;
    }

    self setmovespeedscale(1.04);
    return;
  }
}

function setoverkillpro() {}

function unsetoverkillpro() {}

function setempimmune() {}

function unsetempimmune() {}

function setautospot() {
  if(!isPlayer(self)) {
    return;
  }

  autospotadswatcher();
  autospotdeathwatcher();
}

function autospotdeathwatcher() {
  self waittill("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  self autospotoverlayoff();
}

function unsetautospot() {
  if(!isPlayer(self)) {
    return;
  }

  self notify("endAutoSpotAdsWatcher");
  self autospotoverlayoff();
}

function autospotadswatcher() {
  self endon("death_or_disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    waitframe();

    if(self isusingturret()) {
      self autospotoverlayoff();
      continue;
    }

    var_1 = self playerads();

    if(var_1 < 1 && var_0) {
      var_0 = 0;
      self autospotoverlayoff();
    }

    if(var_1 < 1 && !var_0) {
      continue;
    }

    if(var_1 == 1 && !var_0) {
      var_0 = 1;
      self autospotoverlayon();
    }
  }
}

function setregenfaster() {}

function unsetregenfaster() {}

function timeoutregenfaster() {
  self.hasregenfaster = undefined;
  scripts\mp\utility\perk::removeperk("specialty_regenfaster");
  self setclientdvar("ui_regen_faster_end_milliseconds", 0);
  self notify("timeOutRegenFaster");
}

function sethardshell() {
  self.shellshockreduction = 0.25;
}

function unsethardshell() {
  self.shellshockreduction = 0;
}

function setsharpfocus() {
  thread monitorsharpfocus();
}

function monitorsharpfocus() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_monitorSharpFocus");

  for(;;) {
    updatesharpfocus();
    self waittill("weapon_change");
  }
}

function updatesharpfocus() {
  var_0 = self.currentweapon;
  var_1 = undefined;
  var_2 = scripts\mp\utility\weapon::ref_14584(var_0);

  if(var_2 == 5) {
    var_1 = 0.7;
  } else if(var_2 == 4) {
    var_1 = 0.1;
  } else if(var_2 == 2) {
    var_1 = 0.05;
  } else if(var_2 == 3) {
    var_1 = 0.05;
  } else if(var_2 == 1) {
    var_1 = 0.25;
  } else {
    var_1 = 0.05;
  }

  scripts\mp\weapons::updateviewkickscale(var_1);
}

function unsetsharpfocus() {
  self notify("stop_monitorSharpFocus");
  scripts\mp\weapons::updateviewkickscale(1);
}

function updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }

  var_0 = undefined;
  var_1 = scripts\mp\utility\weapon::ref_14584(self.currentweapon);

  if(var_1 == 5) {
    var_0 = 0.7;
  } else if(var_1 == 4) {
    var_0 = 0.1;
  } else if(var_1 == 2) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 = getdvarfloat("scr_marksman_flinchscalar", 0.05);
    } else {
      var_0 = 0.05;
    }
  } else if(var_1 == 3) {
    var_0 = 0.05;
  } else if(var_1 == 1) {
    var_0 = 0.25;
  } else if(var_1 == 6) {
    var_0 = getdvarfloat("scr_marksman_flinchscalar", 0.05);
  } else {
    var_0 = 0.05;
  }

  scripts\mp\weapons::updateviewkickscale(var_0);
}

function ref_13121() {
  self endon("death_or_disconnect");
  scripts\mp\utility\perk::giveperk("specialty_increaseaccuracy");
  wait getdvarfloat("scr_gunperk_acquisition_duration", 5);
  scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
}

function ref_131d0() {
  thread ref_11cfc();
}

function ref_11cfc() {
  self endon("tight_grip_unset");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notifyonplayercommand("tightgrip_fire", "+attack");
  self notifyonplayercommand("tightgrip_fire", "+attack_akimbo_accessible");
  self notifyonplayercommand("tightgrip_release", "-attack");
  self notifyonplayercommand("tightgrip_release", "-attack_akimbo_accessible");

  for(;;) {
    self waittill("tightgrip_fire");

    if(self.currentweapon hasattachment("gunperk_tightgrip")) {
      if(!scripts\mp\utility\perk::_hasperk("specialty_tightgrip")) {
        scripts\mp\utility\perk::giveperk("specialty_tightgrip");
      } else {
        self notify("tightgrip_continue");
      }

      self waittill("tightgrip_release");
      thread lobby_patrol_enemy_watcher();
    }
  }
}

function lobby_patrol_enemy_watcher() {
  self endon("death_or_disconnect");
  self endon("tightgrip_continue");
  wait 0.2;

  if(self hasperk("specialty_tightgrip")) {
    scripts\mp\utility\perk::removeperk("specialty_tightgrip");
    return;
  }
}

function ref_13f70() {
  self notify("tight_grip_unset");
  self notifyonplayercommandremove("tightgrip_fire", "+attack");
  self notifyonplayercommandremove("tightgrip_fire", "+attack_akimbo_accessible");
  self notifyonplayercommandremove("tightgrip_release", "-attack");
  self notifyonplayercommandremove("tightgrip_release", "-attack_akimbo_accessible");

  if(self hasperk("specialty_tightgrip")) {
    scripts\mp\utility\perk::removeperk("specialty_tightgrip");
    return;
  }
}

function ref_131b4() {
  thread ref_11d1a();
}

function ref_11d1a() {
  self endon("death_or_disconnect");
  self endon("quickscope_unset");

  for(;;) {
    if(self.currentweapon hasattachment("gunperk_quickscope") && self playerads() == 1) {
      thread ref_131b5();

      while(self playerads() == 1) {
        waitframe();
      }

      if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
        scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
      }
    }

    waitframe();
  }
}

function ref_131b5() {
  self endon("death_or_disconnect");
  self notify("quickscope_accuracy_start");
  self endon("quickscope_accuracy_start");
  self endon("quickscope_unset");

  if(!scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::giveperk("specialty_increaseaccuracy");
  }

  wait 1;

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    return;
  }
}

function ref_13f6b() {
  self notify("quickscope_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    return;
  }
}

function ref_13159() {
  thread ref_11d08();
}

function ref_11d08() {
  self endon("death_or_disconnect");
  self endon("hardscope_unset");

  for(;;) {
    if(self playerads() == 1) {
      thread ref_1315a();

      while(self playerads() == 1) {
        waitframe();
      }

      self notify("hardscope_cancel");

      if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
        scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
      }
    }

    waitframe();
  }
}

function ref_1315a() {
  self endon("death_or_disconnect");
  self endon("hardscope_cancel");
  self endon("hardscope_unset");
  wait 0.5;
  scripts\mp\utility\perk::giveperk("specialty_increaseaccuracy");
}

function ref_13f65() {
  self notify("hardscope_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    return;
  }
}

function ref_13176() {
  thread ref_11d13();
}

function ref_11d13() {
  self endon("death_or_disconnect");
  self endon("nervesofsteel_unset");

  for(;;) {
    if(isDefined(self.health) && isDefined(self.maxhealth) && self.health < self.maxhealth) {
      scripts\mp\utility\perk::giveperk("specialty_increaseaccuracy");

      while(self.health < self.maxhealth) {
        waitframe();
      }

      scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    }

    waitframe();
  }
}

function ref_13f66() {
  self notify("nervesofsteel_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    return;
  }
}

function ref_13195() {
  thread ref_11d15();
}

function ref_11d15() {
  self endon("death_or_disconnect");

  if(self.currentweapon hasattachment("gunperk_panic")) {
    thread ref_13196();
  }

  for(;;) {
    self waittill("weapon_change");
    waitframe();

    if(self.currentweapon hasattachment("gunperk_panic")) {
      thread ref_13196();
      continue;
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
      scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    }
  }
}

function ref_13196() {
  self endon("death_or_disconnect");
  self notify("panic_accuracy_set");
  self endon("panic_accuracy_set");
  self endon("panic_unset");

  if(!scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::giveperk("specialty_increaseaccuracy");
  }

  wait 3;
  scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
}

function ref_13f68() {
  self notify("panic_unset");

  if(scripts\mp\utility\perk::_hasperk("specialty_increaseaccuracy")) {
    scripts\mp\utility\perk::removeperk("specialty_increaseaccuracy");
    return;
  }
}

function ammodisabling_run(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(var_0.disabledspeedmod)) {
    return;
  } else {
    var_0.disabledspeedmod = -0.05;
  }

  var_0 shellshock("chargemode_mp", 0.8);
  var_0 scripts\mp\weapons::updatemovespeedscale();
  ammodisabling_impair(var_0);
  scripts\engine\utility::ref_143b9(0.8, "death");
  ammodisabling_impairend(var_0);
  var_0.disabledspeedmod = undefined;
  var_0 scripts\mp\weapons::updatemovespeedscale();
}

function ammodisabling_impair() {
  scripts\common\utility::allow_sprint(0);
  scripts\common\utility::allow_slide(0);
  scripts\common\utility::allow_jump(0);
}

function ammodisabling_impairend() {
  scripts\common\utility::allow_sprint(1);
  scripts\common\utility::allow_slide(1);
  scripts\common\utility::allow_jump(1);
}

function setviewkickoverride() {
  self.overrideviewkickscale = 0.05;
  self.ref_1218d = 0.05;
  self.ref_1218f = 0.14;
  self.overrideviewkickscalesniper = 0.26;
  self.overrideviewkickscalepistol = 0.05;

  if(scripts\mp\utility\game::getgametype() == "br") {
    self.ref_1218e = getdvarfloat("scr_marksman_flinchscalar", 0.05) * getdvarfloat("scr_br_focusperk_scalar", 0.7);
  } else {
    self.ref_1218e = 0.05;
  }

  scripts\mp\weapons::updateviewkickscale();
}

function unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.ref_1218d = undefined;
  self.ref_1218f = undefined;
  self.ref_1218e = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  scripts\mp\weapons::updateviewkickscale();
}

function setaffinityspeedboost() {
  self.weaponaffinityspeedboost = 0.08;
  scripts\mp\weapons::updatemovespeedscale();
}

function unsetaffinityspeedboost() {
  self.weaponaffinityspeedboost = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

function setaffinityextralauncher() {
  self.weaponaffinityextralauncher = 1;
  var_0 = scripts\mp\class::buildweapon(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid);
  var_1 = scripts\mp\class::buildweapon(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.loadoutsecondaryvariantid);

  if(scripts\mp\utility\weapon::getweapongroup(var_0.basename) == "weapon_projectile") {
    self setweaponammoclip(var_0, weaponclipsize(var_0));
  }

  if(scripts\mp\utility\weapon::getweapongroup(var_1.basename) == "weapon_projectile") {
    self setweaponammoclip(var_1, weaponclipsize(var_1));
    return;
  }
}

function unsetaffinityextralauncher() {
  self.weaponaffinityextralauncher = undefined;
}

function setdoubleload() {
  self endon("death_or_disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    var_0 = self getweaponslist("primary");

    foreach(var_2 in var_0) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = weaponclipsize(var_2);
      var_5 = var_4 - var_3;
      var_6 = self getweaponammostock(var_2);

      if(var_3 != var_4 && var_6 > 0) {
        if(var_3 + var_6 >= var_4) {
          self setweaponammoclip(var_2, var_4);
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammoclip(var_2, var_3 + var_6);

        if(var_6 - var_5 > 0) {
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammostock(var_2, 0);
      }
    }
  }
}

function unsetdoubleload() {
  self notify("endDoubleLoad");
}

function setmarksman(var_0) {}

function unsetmarksman() {}

function setfastcrouch() {
  thread watchfastcrouch();
}

function watchfastcrouch() {
  self endon("death_or_disconnect");
  self endon("fastcrouch_unset");

  for(;;) {
    var_0 = (self getstance() == "crouch" || self getstance() == "prone") && !self issprintsliding();

    if(!isDefined(self.fastcrouchspeedmod)) {
      if(var_0) {
        self.fastcrouchspeedmod = 0.25;
        scripts\mp\weapons::updatemovespeedscale();
      }
    } else if(!var_0) {
      self.fastcrouchspeedmod = undefined;
      scripts\mp\weapons::updatemovespeedscale();
    }

    waitframe();
  }
}

function unsetfastcrouch() {
  self notify("fastcrouch_unset");

  if(isDefined(self.fastcrouchspeedmod)) {
    self.fastcrouchspeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
    return;
  }
}

function setrshieldradar() {
  self endon("unsetRShieldRadar");
  wait 0.75;
  self makeportableradar();
  thread setrshieldradar_cleanup();
}

function setrshieldradar_cleanup() {
  self endon("unsetRShieldRadar");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    unsetrshieldradar();
    return;
  }
}

function unsetrshieldradar() {
  self clearportableradar();
  self notify("unsetRShieldRadar");
}

function setrshieldscrambler() {
  self makescrambler();
  thread setrshieldscrambler_cleanup();
}

function setrshieldscrambler_cleanup() {
  self endon("unsetRShieldScrambler");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    unsetrshieldscrambler();
    return;
  }
}

function unsetrshieldscrambler() {
  self clearscrambler();
  self notify("unsetRShieldScrambler");
}

function setstunresistance(var_0) {
  if(!isDefined(var_0)) {
    if(scripts\mp\utility\game::unset_relic_grounded()) {
      var_0 = getdvarint("scr_br_perkstun_resistance_scalar", 2);
    } else {
      var_0 = 4;
    }
  }

  var_0 = int(var_0);

  if(var_0 == 10) {
    self.stunresistscalar = 0;
    return;
  }

  self.stunresistscalar = var_0 / 10;
}

function unsetstunresistance() {
  self.stunresistscalar = 1;
}

function setstunmore(var_0) {
  self.stunmorescalar = getdvarfloat("perk_stun_more_scalar", 1.4);
}

function unsetstunmore() {
  self.stunmorescalar = 1;
}

function getstunscalartype(var_0) {
  var_1 = var_0 scripts\mp\utility\perk::_hasperk("specialty_stun_resistance");
  var_2 = var_0 scripts\mp\utility\perk::_hasperk("penalty_stun_more");

  if(var_1 && !var_2) {
    return "stun_less";
  } else if(var_2 && !var_1) {
    return "stun_more";
  }

  return "stun_normal";
}

function applystunresistence(var_0, var_1, var_2) {
  var_3 = getstunscalartype(var_1);

  if(var_3 == "stun_less" && var_0 != var_1) {
    if(isDefined(var_1.stunresistscalar) && isDefined(var_2)) {
      var_2 *= var_1.stunresistscalar;
    }

    var_4 = scripts\engine\utility::ter_op(isDefined(var_0.owner), var_0.owner, var_0);
    var_5 = scripts\engine\utility::ter_op(isDefined(var_1.owner), var_1.owner, var_1);

    if(isPlayer(var_4) && var_4 != var_1) {
      var_0 scripts\mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_4, var_5))) {
      var_1 scripts\cp\vehicles\vehicle_compass_cp::resistedstun(var_4);
    }
  } else if(!istrue(var_1 scripts\mp\utility\player::is_allowed_to_be_stunned())) {
    var_2 = 0;
  } else if(var_3 == "stun_more" && var_0 != var_1) {
    if(isDefined(var_1.stunmorescalar) && isDefined(var_2)) {
      var_2 *= var_1.stunmorescalar;
    }
  }

  if(var_1 scripts\mp\utility\game::ismatchstartprotected()) {
    var_2 *= 0.1;
  }

  return var_2;
}

function setweaponlaser() {
  if(isagent(self)) {
    return;
  }

  self endon("unsetWeaponLaser");
  wait 0.5;
  thread setweaponlaser_internal();
}

function unsetweaponlaser() {
  self notify("unsetWeaponLaser");

  if(isDefined(self.perkweaponlaseron) && self.perkweaponlaseron) {
    scripts\mp\utility\weapon::disableweaponlaser();
  }

  self.perkweaponlaseron = undefined;
  self.perkweaponlaseroffforswitchstart = undefined;
}

function setweaponlaser_waitforlaserweapon(var_0) {
  for(var_0 = getweaponbasename(var_0);; var_0 = var_1.basename) {
    if(isDefined(var_0) && (var_0 == "iw6_kac_mp" || var_0 == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", var_1);
  }
}

function setweaponlaser_internal() {
  self endon("death_or_disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  var_0 = self getcurrentweapon();
  setweaponlaser_waitforlaserweapon(var_0);

  if(self.perkweaponlaseron == 0) {
    self.perkweaponlaseron = 1;
    scripts\mp\utility\weapon::enableweaponlaser();
  }

  GscBinSkip4(0x35);
}

function setweaponlaser_monitorweaponswitchstart(var_0) {
  self endon("weapon_change");
  self waittill("weapon_switch_started");
  GscBinSkip4(0x35, var_0);
}

function setweaponlaser_onweaponswitchstart(var_0) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    scripts\mp\utility\weapon::disableweaponlaser();
  }

  wait var_0;
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    scripts\mp\utility\weapon::enableweaponlaser();
    return;
  }
}

function setweaponlaser_monitorads() {
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

function setsteadyaimpro() {
  self setaimspreadmovementscale(0.5);
}

function unsetsteadyaimpro() {
  self notify("end_SteadyAimPro");
  self setaimspreadmovementscale(1);
}

function perkusedeathtracker() {
  self endon("disconnect");
  self waittill("death");
  self._useperkenabled = undefined;
}

function setendgame() {
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

function unsetendgame() {
  self notify("stopEndGame");
  self.endgame = undefined;
  scripts\mp\utility\player::restorebasevisionset(1);

  if(!isDefined(self.endgametimer)) {
    return;
  }

  self.endgametimer scripts\mp\hud_util::destroyelem();
  self.endgameicon scripts\mp\hud_util::destroyelem();
}

function endgamedeath(var_0) {
  self endon("death_or_disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait var_0 + 1;
  scripts\mp\utility\damage::_suicide();
}

function setsaboteur() {
  self.objectivescaler = 1.2;
}

function unsetsaboteur() {
  self.objectivescaler = 1;
}

function setcombatspeed() {
  self endon("death_or_disconnect");
  self endon("unsetCombatSpeed");
  self.incombatspeed = 0;
  unsetcombatspeedscalar();

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isDefined(var_1.team)) {
      continue;
    }

    if(level.teambased && var_1.team == self.team) {
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

function endofspeedwatcher() {
  self notify("endOfSpeedWatcher");
  self endon("endOfSpeedWatcher");
  self endon("death_or_disconnect");
  self waittill("healed");
  unsetcombatspeedscalar();
  self.incombatspeed = 0;
}

function setcombatspeedscalar() {
  if(self.weaponspeed <= 0.8) {
    self.combatspeedscalar = 1.4;
  } else if(self.weaponspeed <= 0.9) {
    self.combatspeedscalar = 1.3;
  } else {
    self.combatspeedscalar = 1.2;
  }

  scripts\mp\weapons::updatemovespeedscale();
}

function unsetcombatspeedscalar() {
  self.combatspeedscalar = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

function unsetcombatspeed() {
  unsetcombatspeedscalar();
  self notify("unsetCombatSpeed");
}

function setlightweight() {
  if(!isDefined(self.cranked)) {
    self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
    scripts\mp\weapons::updatemovespeedscale();
    return;
  }
}

function unsetlightweight() {
  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

function setblackbox() {}

function unsetblackbox() {}

function setsteelnerves() {
  scripts\mp\utility\perk::giveperk("specialty_bulletaccuracy");
  scripts\mp\utility\perk::giveperk("specialty_holdbreath");
}

function unsetsteelnerves() {
  scripts\mp\utility\perk::removeperk("specialty_bulletaccuracy");
  scripts\mp\utility\perk::removeperk("specialty_holdbreath");
}

function setdelaymine() {}

function unsetdelaymine() {}

function setlocaljammer() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self makescrambler();
    return;
  }
}

function unsetlocaljammer() {
  self clearscrambler();
}

function setthermal() {
  self thermalvisionon();
}

function unsetthermal() {
  self thermalvisionoff();
}

function setonemanarmy() {
  thread onemanarmyweaponchangetracker();
}

function unsetonemanarmy() {
  self notify("stop_oneManArmyTracker");
}

function onemanarmyweaponchangetracker() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0.basename != "onemanarmy_mp") {
      continue;
    }

    thread selectonemanarmyclass();
  }
}

function isonemanarmymenu(var_0) {
  if(var_0 == game["menu_onemanarmy"]) {
    return true;
  }

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && var_0 == game["menu_onemanarmy_defaults_splitscreen"]) {
    return true;
  }

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && var_0 == game["menu_onemanarmy_custom_splitscreen"]) {
    return true;
  }

  return false;
}

function selectonemanarmyclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\common\utility::allow_weapon_switch(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_usability(0);
  thread closeomamenuondeath();
  self waittill("menuresponse", var_0, var_1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_usability(1);

  if(var_1 == "back" || !isonemanarmymenu(var_0) || scripts\mp\utility\player::isusingremote()) {
    var_2 = self getcurrentweapon();

    if(var_2.basename == "onemanarmy_mp") {
      scripts\common\utility::allow_weapon_switch(0);
      scripts\common\utility::allow_offhand_weapons(0);
      scripts\common\utility::allow_usability(0);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(scripts\mp\utility\inventory::getlastweapon());
      self waittill("weapon_change");
      scripts\common\utility::allow_weapon_switch(1);
      scripts\common\utility::allow_offhand_weapons(1);
      scripts\common\utility::allow_usability(1);
    }

    return;
  }

  thread giveonemanarmyclass(var_2);
}

function closeomamenuondeath() {
  self endon("menuresponse");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_usability(1);
}

function giveonemanarmyclass(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\perk::_hasperk("specialty_omaquickchange")) {
    var_1 = 3;
    scripts\mp\utility\sound::playplayerandnpcsounds(self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc");
  } else {
    var_1 = 6;
    scripts\mp\utility\sound::playplayerandnpcsounds(self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc");
  }

  thread omausebar(var_1);
  scripts\common\utility::allow_weapon(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_usability(0);
  wait var_1;
  scripts\common\utility::allow_weapon(1);
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_usability(1);
  scripts\mp\class::giveloadout(self.pers["team"], var_1);

  if(isDefined(self.carryflag)) {
    self attach(self.carryflag, "J_spine4", 1);
  }

  self notify("changed_kit");
  level notify("changed_kit");
  scripts\mp\rank::tryresetrankxp();
}

function omausebar(var_0) {
  self endon("disconnect");
  var_1 = scripts\mp\hud_util::createprimaryprogressbar();
  var_2 = scripts\mp\hud_util::createprimaryprogressbartext();
  var_2 settext(&"MPUI_CHANGING_KIT");
  var_1 scripts\mp\hud_util::updatebar(0, 1 / var_0);
  var_3 = 0;

  while(var_3 < var_0 && isalive(self) && !level.gameended) {
    wait 0.05;
    var_3 += 0.05;
  }

  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

function setafterburner() {
  self energy_setrestorerate(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 600, 1000));
  self energy_setresttimems(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 750, 750));
}

function unsetafterburner() {
  self energy_setrestorerate(0, 400);
  self energy_setresttimems(0, 900);
}

function setblastshield() {}

function unsetblastshield() {}

function toggleblastshield(var_0) {}

function blastshieldusetracker(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("end_perkUseTracker");
  level endon("game_ended");

  for(;;) {
    self waittill("empty_offhand");

    if(!scripts\common\utility::is_offhand_weapons_allowed()) {
      continue;
    }

    self[[var_1]](scripts\mp\utility\perk::_hasperk("specialty_blastshield"));
  }
}

function setfreefall() {}

function unsetfreefall() {}

function settacticalinsertion() {
  scripts\mp\equipment::giveequipment("equip_tac_insert", "secondary");
}

function unsettacticalinsertion() {}

function setpainted(var_0) {
  if(isPlayer(self)) {
    var_1 = 0.5;

    if(!scripts\mp\utility\perk::_hasperk("specialty_engineer") && !scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      self.painted = 1;
      var_2 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0, "outline_nodepth_orange", "perk");
      thread watchpainted(var_2, var_1);
      thread watchpaintedagain(var_2);
      return;
    }

    return;
  }
}

function watchpainted(var_0, var_1) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::ref_143b9(var_1, "death");
  self.painted = 0;
  scripts\mp\utility\outline::outlinedisable(var_0, self);
  self notify("painted_end");
}

function watchpaintedagain(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::ref_143a5("painted_again", "painted_end");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

function ispainted() {
  return isDefined(self.painted) && self.painted;
}

function setassists() {}

function unsetassists() {}

function setrefillgrenades() {
  if(isDefined(self.primarygrenade)) {
    self givemaxammo(self.primarygrenade);
  }

  if(isDefined(self.secondarygrenade)) {
    self givemaxammo(self.secondarygrenade);
    return;
  }
}

function unsetrefillgrenades() {}

function setrefillammo() {
  if(isDefined(self.primaryweapon)) {
    self givemaxammo(self.primaryweapon);
  }

  if(isDefined(self.secondaryweapon)) {
    self givemaxammo(self.secondaryweapon);
    return;
  }
}

function unsetrefillammo() {}

function setcomexp() {}

function unsetcomexp() {}

function settagger() {
  thread settaggerinternal();
}

function settaggerinternal() {
  self endon("death_or_disconnect");
  self endon("unsetTagger");
  level endon("game_ended");

  for(;;) {
    self waittill("eyesOn");
    var_0 = self getplayerssightingme();

    foreach(var_2 in var_0) {
      if(level.teambased && var_2.team == self.team) {
        continue;
      }

      if(isalive(var_2) && var_2.sessionstate == "playing") {
        if(!isDefined(var_2.perkoutlined)) {
          var_2.perkoutlined = 0;
        }

        if(!var_2.perkoutlined) {
          var_2.perkoutlined = 1;
        }

        thread outlinewatcher(var_2);
      }
    }
  }
}

function outlinewatcher(var_0) {
  self endon("death_or_disconnect");
  self endon("eyesOff");
  level endon("game_ended");

  for(;;) {
    var_1 = 1;
    var_2 = var_0 getplayerssightingme();

    foreach(var_4 in var_2) {
      if(var_4 == self) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      self.perkoutlined = 0;
      self notify("eyesOff");
    }

    wait 0.5;
  }
}

function unsettagger() {
  self notify("unsetTagger");
}

function setpitcher() {
  thread setpitcherinternal();
}

function setpitcherinternal() {
  self endon("death_or_disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");
  self setgrenadecookscale(1.5);

  for(;;) {
    self setgrenadethrowscale(1.25);
    self waittill("grenade_pullback", var_0);
    var_1 = var_0.basename;

    if(var_1 == "airdrop_marker_mp" || var_1 == "deployable_vest_marker_mp" || var_1 == "deployable_weapon_crate_marker_mp") {
      self setgrenadethrowscale(1);
    }

    self waittill("grenade_fire", var_2, var_0);
  }
}

function unsetpitcher() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  self notify("unsetPitcher");
}

function setboom() {}

function setboominternal(var_0) {
  self endon("death_or_disconnect");
  self endon("unsetBoom");
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  waitframe();
  triggerportableradarping(self.origin, var_0, 800, 1500);
  boomtrackplayers(var_0, self.origin, self);
}

function boomtrackplayers(var_0, var_1) {
  var_2 = scripts\common\utility::playersinsphere(var_0, 700);

  foreach(var_4 in var_2) {
    if(var_1 == var_4) {
      continue;
    }

    if(scripts\mp\utility\player::isenemy(var_4) && isalive(var_4) && !var_4 scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {}
  }
}

function boomtrackplayerdeath(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("removearchetype");
  var_2 = scripts\engine\utility::ref_143b9(7, "death");

  if(var_2 == "timeout" && isDefined(self.markedbyboomperk[var_1])) {
    self.markedbyboomperk[var_1] = undefined;
    return;
  }

  self waittill("spawned_player");
  self.markedbyboomperk = undefined;
}

function unsetboom() {
  self notify("unsetBoom");
}

function customjuiced(var_0) {
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
  var_1 = var_0 * 1000 + gettime();

  if(isai(self)) {}

  wait var_0;
  unsetcustomjuiced();
}

function unsetcustomjuiced(var_0) {
  if(!isDefined(var_0)) {
    self.movespeedscaler = 1;

    if(scripts\mp\utility\perk::_hasperk("specialty_lightweight")) {
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
    }

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_stalker");
  scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self.isjuiced = undefined;

  if(isai(self)) {}

  self notify("unset_custom_juiced");
}

function unsetcustomjuicedonride() {
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

function unsetcustomjuicedondeath() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  scripts\engine\utility::ref_143a5("death", "faux_spawn");
  thread unsetcustomjuiced(1);
}

function unsetcustomjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level scripts\engine\utility::ref_143a5("round_end_finished", "game_ended");
  thread unsetcustomjuiced();
}

function settriggerhappy() {}

function settriggerhappyinternal() {
  self endon("death_or_disconnect");
  self endon("unsetTriggerHappy");
  level endon("game_ended");
  var_0 = self.lastdroppableweaponobj;
  var_1 = self getweaponammostock(var_0);
  var_2 = self getweaponammoclip(var_0);
  self givestartammo(var_0);
  var_3 = self getweaponammoclip(var_0);
  var_4 = var_3 - var_2;
  var_5 = var_1 - var_4;

  if(var_4 > var_1) {
    self setweaponammoclip(var_0, var_2 + var_1);
    var_5 = 0;
  }

  self setweaponammostock(var_0, var_5);
  self playlocalsound("ammo_crate_use");
  self setclientomnvar("ui_trigger_happy", 1);
  wait 0.2;
  self setclientomnvar("ui_trigger_happy", 0);
}

function unsettriggerhappy() {
  self setclientomnvar("ui_trigger_happy", 0);
  self notify("unsetTriggerHappy");
}

function setincog() {}

function unsetincog() {}

function setblindeye() {}

function unsetblindeye() {}

function setquickswap() {}

function unsetquickswap() {}

function setextraammo() {
  self endon("death_or_disconnect");
  self endon("unset_extraammo");
  level endon("game_ended");

  if(self.gettingloadout) {
    self waittill("giveLoadout");
  }

  var_0 = scripts\mp\utility\weapon::getvalidextraammoweapons();

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !nullweapon(var_2) && var_2 hasattachment("maxammo", 1) && !istrue(var_2.first_equipped)) {
      self givemaxammo(var_2);
      var_2.first_equipped = 1;
    }
  }
}

function unsetextraammo() {
  self notify("unset_extraammo");
}

function setextraequipment() {
  self endon("death_or_disconnect");
  self endon("unset_extraequipment");
  level endon("game_ended");

  if(self.gettingloadout) {
    self waittill("giveLoadout");
  }

  var_0 = self.loadoutperkoffhand;

  if(isDefined(var_0) && var_0 != "specialty_null") {
    if(var_0 != "specialty_tacticalinsertion" && var_0 != "smoke_grenade_mp" && var_0 != "player_trophy_system_mp") {
      self setweaponammoclip(var_0, 2);
      return;
    }

    return;
  }
}

function unsetextraequipment() {
  self notify("unset_extraequipment");
}

function setextradeadly() {
  self endon("death_or_disconnect");
  self endon("unset_extradeadly");
  level endon("game_ended");

  if(self.gettingloadout) {
    self waittill("giveLoadout");
  }

  var_0 = scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(var_0) && var_0 != "none") {
    scripts\mp\equipment::incrementequipmentammo(var_0);
    return;
  }
}

function unsetextradeadly() {
  self notify("unset_extradeadly");
}

function setbattleslide() {}

function unsetbattleslide() {}

function setoverkill() {}

function unsetoverkill() {}

function setactivereload() {}

function unsetactivereload() {}

function setlifepack() {
  if(!isDefined(level._effect["life_pack_pickup"])) {
    level._effect["life_pack_pickup"] = undefined;
  }

  thread watchlifepackkills();
}

function watchlifepackkills() {
  self endon("death_or_disconnect");
  self notify("unset_lifepack");
  self endon("unset_lifepack");

  for(;;) {
    self waittill("got_a_kill", var_0, var_1, var_2);
    var_3 = self.origin;
    var_4 = 20;
    var_5 = 20;
    var_6 = spawn("script_model", self.origin + (0, 0, 10));
    var_6 setModel("weapon_life_pack");
    var_6.owner = self;
    var_6.team = self.team;
    var_6 hidefromplayer(self);
    var_7 = spawn("trigger_radius", self.origin, 0, var_4, var_5);
    thread watchlifepackuse(var_7);
    thread watchlifepackdeath(var_7);
    thread hoverlifepack();
    var_6 rotateYaw(1000, 30, 0.2, 0.2);
    thread watchlifepacklifetime(var_6, 10);
    thread watchlifepackowner();

    foreach(var_9 in level.players) {
      setlifepackvisualforplayer(var_6, var_9);
    }
  }
}

function activatelifepackboost(var_0, var_1, var_2) {
  self.lifeboostactive = 1;

  if(isDefined(var_1) && var_1 > 0) {
    thread watchlifepackboostlifetime(var_1);
  }

  if(isDefined(var_2) && var_2) {
    thread watchlifepackuserdeath();
  }

  scripts\mp\utility\perk::giveperk("specialty_regenfaster");
  self setclientomnvar("ui_life_link", 1);
  self notify("enabled_life_pack_boost");
  self.lifepackowner = var_0;
  thread scripts\mp\gamescore::trackbuffassistfortime(var_0, self, "medic_lifepack", var_1);
}

function watchlifepackboostlifetime(var_0) {
  self endon("death_or_disconnect");
  wait var_0;

  if(isDefined(self.lifeboostactive)) {
    disablelifepackboost();
    return;
  }
}

function disablelifepackboost() {
  if(isDefined(self) && isDefined(self.lifeboostactive)) {
    self.lifeboostactive = undefined;
    self setclientomnvar("ui_life_link", 0);
    self notify("disabled_life_pack_boost");
    scripts\mp\utility\perk::removeperk("specialty_regenfaster");
    scripts\mp\gamescore::untrackbuffassist(self.lifepackowner, self, "medic_lifepack");
    self.lifepackowner = undefined;
    return;
  }
}

function setlifepackvisualforplayer(var_0) {
  if(level.teambased && var_0.team == self.team && var_0 != self.owner) {
    setlifepackoutlinestate(var_0);
    self showtoplayer(var_0);
    thread watchlifepackoutlinestate(var_0);
    return;
  }

  self hidefromplayer(var_0);
}

function setlifepackoutlinestate(var_0) {
  if(isDefined(var_0.lifeboostactive)) {
    if(isDefined(var_0.lifepackoutlines) && var_0.lifepackoutlines.size > 0) {
      foreach(var_3, var_2 in var_0.lifepackoutlines) {
        if(self == var_2.pack) {
          scripts\mp\utility\outline::outlinedisable(var_2.id, var_2.pack);
          var_0.lifepackoutlines = scripts\engine\utility::array_remove(var_0.lifepackoutlines, var_2);
          var_2 = undefined;
        }
      }

      return;
    }

    return;
  }

  if(!isDefined(var_3.lifepackoutlines)) {
    var_3.lifepackoutlines = [];
  }

  var_4 = spawnStruct();
  var_4.id = scripts\mp\utility\outline::outlineenableforplayer(self, var_3, "outline_depth_cyan", "equipment");
  var_4.pack = self;
  var_3.lifepackoutlines = scripts\engine\utility::array_add_safe(var_3.lifepackoutlines, var_4);
}

function watchlifepackoutlinestate(var_0) {
  self endon("death");

  for(;;) {
    var_0 scripts\engine\utility::ref_143a5("enabled_life_pack_boost", "disabled_life_pack_boost");
    setlifepackoutlinestate(var_0);
  }
}

function hoverlifepack() {
  self endon("death");
  self endon("phase_resource_pickup");
  var_0 = self.origin;

  for(;;) {
    self moveTo(var_0 + (0, 0, 15), 1, 0.2, 0.2);
    wait 1;
    self moveTo(var_0, 1, 0.2, 0.2);
    wait 1;
  }
}

function watchlifepackuse(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(var_1.team != var_0.team) {
      continue;
    }

    if(isDefined(var_1.lifeboostactive)) {
      continue;
    }

    if(var_1 == var_0.owner) {
      continue;
    }

    activatelifepackboost(var_1, var_0.owner, 5, 1);
    var_1 playlocalsound("scavenger_pack_pickup");
    var_2 = spawnfx(scripts\engine\utility::getfx("life_pack_pickup"), self.origin);
    triggerfx(var_2);
    var_2 thread scripts\mp\utility\script::delayentdelete(2);

    foreach(var_4 in level.players) {
      if(var_4.team == var_1.team) {
        continue;
      }

      var_2 hidefromplayer(var_4);
    }

    var_0 delete();
  }
}

function watchlifepackdeath(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchlifepacklifetime(var_0, var_1) {
  self endon("death");
  wait var_0;
  var_1 delete();
  self delete();
}

function watchlifepackowner() {
  self endon("death");
  self.owner waittill("disconnect");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchlifepackuserdeath() {
  self endon("disconnect");
  self waittill("death");
  disablelifepackboost();
}

function unsetlifepack() {
  disablelifepackboost();
  self notify("unset_lifepack");
}

function settoughenup() {
  if(!isDefined(level._effect["toughen_up_screen"])) {
    level._effect["toughen_up_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_toughen_up_scrn");
  }

  thread watchtoughenup();
}

function watchtoughenup() {
  self endon("death_or_disconnect");
  self endon("unsetToughenUp");
  level endon("game_ended");
  var_0 = 0;
  var_1 = 15;
  var_2 = 7.5;
  var_3 = 4;
  var_4 = 5;
  var_5 = 2;
  var_6 = [];
  var_6 = scripts\engine\utility::array_add_safe(var_6, (35, 0, 10));
  var_6 = scripts\engine\utility::array_add_safe(var_6, (0, 35, 10));
  var_6 = scripts\engine\utility::array_add_safe(var_6, (-35, 0, 10));
  var_6 = scripts\engine\utility::array_add_safe(var_6, (0, -35, 10));
  self waittill("spawned_player");

  for(;;) {
    self waittill("got_a_kill", var_7, var_8, var_9);

    if(!isDefined(self.toughenedup)) {
      self.toughenedup = 1;
      var_10 = spawnfxforclient(scripts\engine\utility::getfx("toughen_up_screen"), self getEye(), self);
      triggerfx(var_10);
      thread attachtoughenuparmor("j_forehead", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_ri", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_spineupper", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_shield_back", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_ri", level.bulletstormshield["section"].friendlymodel);

      if(var_5 == 1) {
        scripts\mp\utility\damage::sethealthshield(var_1);
        thread watchtoughenuplifetime(var_4);
      } else {
        scripts\mp\lightarmor::setlightarmorvalue(self, 100);
        thread watchtoughenuplightarmorend();
      }

      thread watchtoughenupplayerend(var_10);
      continue;
    }

    if(var_5 == 1) {
      self notify("toughen_up_reset");
      thread watchtoughenuplifetime(var_4);
    }
  }
}

function attachtoughenuparmor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_0);
  var_6 = spawn("script_model", var_5);
  var_6 setModel(var_1);
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_7 = var_2;
  }

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  var_6.angles = self.angles;
  var_6 linkTo(self, var_0, var_7, var_8);
  thread watchtoughenupplayerend(var_6);
  thread watchtoughenupgameend();
  return var_6;
}

function settoughenupmodel(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", self.origin + (0, 0, 50));
  var_4.team = self.owner.team;

  if(var_3 == "friendly") {
    var_4 setModel(level.bulletstormshield["section"].friendlymodel);
  } else {
    var_4 setModel(level.bulletstormshield["section"].enemymodel);
  }

  var_4 linkTo(self, "tag_origin", var_1, (0, 90 * (var_2 + 1), 0));
  var_4 hide();
  thread watchtoughenupplayerend(var_4);
  thread watchtoughenupgameend();
  thread settoughenupvisiblestate(var_4, var_3);
}

function watchtoughenuplightarmorend() {
  self endon("disconnect");
  self waittill("remove_light_armor");
}

function watchtoughenupplayerend(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::ref_143a5("death_or_disconnect", "toughen_up_end");
  var_0.toughenedup = undefined;

  if(var_0 scripts\mp\lightarmor::haslightarmor(var_0)) {
    unsetlightarmor(var_0);
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchtoughenupgameend() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchtoughenuplifetime(var_0) {
  self endon("death");
  self endon("toughen_up_reset");

  while(var_0 > 0) {
    var_0 -= 1;
    wait 1;
  }

  self notify("toughen_up_end");
}

function settoughenupvisiblestate(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(var_3 == var_1) {
      continue;
    }

    if(canshowtoughenupshield(var_3, var_0)) {
      self showtoplayer(var_3);
    }

    thread watchtoughenupplayerbegin(var_3, var_0);
  }
}

function watchtoughenupplayerbegin(var_0, var_1) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 waittill("spawned_player");
    self hidefromplayer(var_0);

    if(canshowtoughenupshield(var_0, var_1)) {
      self showtoplayer(var_0);
    }
  }
}

function canshowtoughenupshield(var_0, var_1) {
  var_2 = 0;

  if(var_1 == "friendly" && var_0.team == self.team || var_1 == "enemy" && var_0.team != self.team) {
    var_2 = 1;
  }

  return var_2;
}

function unsettoughenup() {
  scripts\mp\utility\damage::clearhealthshield();
  unsetlightarmor();
  self notify("unsetToughenUp");
}

function setscoutping() {
  thread updatescoutping();
}

function updatescoutping() {
  self endon("death_or_disconnect");
  self endon("unsetScoutPing");
  var_0 = 50;
  var_1 = 1200;
  var_2 = undefined;
  jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) LOC_00000040;
  var_2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();

  for(;;) {
    var_3 = var_0;
    var_4 = var_1;

    if(isDefined(self.scoutpingradius)) {
      var_3 = self.scoutpingradius;
    }

    if(isDefined(self.scoutsweeptime)) {
      var_4 = self.scoutsweeptime;
    }

    var_3 = int(var_3);
    var_4 = int(var_4);

    if(var_3 != var_0) {
      if(istrue(var_2) && getdvarint("scr_advanced_scout_ping_squad_only", 0)) {
        var_5 = level.squaddata[self.team][self.squadindex].players;

        foreach(var_7 in var_5) {
          triggerportableradarping(self.origin, self, var_3, var_4);
        }
      } else {
        triggerportableradarpingteam(self.origin, self.team, var_3, var_4);
      }
    }

    wait var_1 / 1200;
  }
}

function updatescoutpingvalues(var_0) {
  var_1 = 0;
  var_2 = 150;
  var_3 = 3000;

  if(isDefined(self.scoutpingmod)) {
    var_1 = self.scoutpingmod;
  }

  if(isDefined(self.scoutpingpreviousstage)) {
    if(var_0 > self.scoutpingpreviousstage) {
      var_4 = var_0 - self.scoutpingpreviousstage;
      var_1 += var_4 / 10;
    } else if(var_0 < self.scoutpingpreviousstage) {
      var_4 = self.scoutpingpreviousstage - var_0;
      var_1 -= var_4 / 10;
    }
  }

  if(isDefined(self.scoutpingmod)) {
    if(var_1 > self.scoutpingmod || var_1 < self.scoutpingmod) {
      var_2 += var_2 * var_1 * 1.5;
      var_3 -= var_3 * var_1 / 1.5;
      self.scoutpingradius = var_2;
      self.scoutsweeptime = var_3;
    }
  }

  if(var_0 == 0) {
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
  }

  self.scoutpingmod = var_1;
  self.scoutpingpreviousstage = var_0;
}

function unsetscoutping() {
  self.scoutpingradius = undefined;
  self.scoutsweeptime = undefined;
  self.scoutpingmod = undefined;
  self.scoutpingpreviousstage = undefined;
  self notify("unsetScoutPing");
}

function setphasespeed() {
  thread watchphasespeedshift();
  thread watchphasespeedendshift();
}

function watchphasespeedshift() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("phase_shift_start");
    self.phasespeedmod = 0.2;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

function watchphasespeedendshift() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("phase_shift_completed");
    self.phasespeedmod = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

function unsetphasespeed() {
  self.phasespeedmod = undefined;
}

function setdodge() {
  self allowdodge(1);
}

function unsetdodge() {
  self allowdodge(0);
}

function setextradodge() {
  self energy_setmax(1, 100);
  self energy_setenergy(1, 100);
}

function unsetextradodge() {
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
}

function ref_133af(var_0) {
  if(!scripts\mp\utility\perk::_hasperk("specialty_sixth_sense")) {
    return false;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0.team == self.team) {
    return false;
  }

  if(distancesquared(var_0.origin, self.origin) > 16000000) {
    return false;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_sixth_sense_immune")) {
    return false;
  }

  var_1 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1) && isDefined(var_1.vehiclename)) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(var_0);

    if(var_2) {
      if(var_1.vehiclename != "light_tank" && var_1.vehiclename != "apc_russian") {
        return false;
      }
    } else if(var_1.vehiclename == "apc_russian") {
      return false;
    }
  }

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    var_3 = var_0 scripts\mp\utility\player::getremotename();

    if(var_3 == "gunship" || var_3 == "radar_drone_recon" || var_3 == "chopper_gunner" || var_3 == "cruise_predator" || var_3 == "assault_drone") {
      return false;
    }
  }

  return true;
}

function ref_133ad(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_2;
  var_5 = vectordot(var_4, var_3);

  if(var_5 <= 0) {
    return false;
  }

  var_6 = length(var_4);
  var_7 = 12;
  var_7 += -0.15 * sqrt(var_6);
  var_8 = scripts\engine\math::keypad_increase_failnum(var_7);
  var_9 = 1 - 0.5 * var_8 * var_8;

  if(var_5 < var_9 * var_6) {
    return false;
  }

  return true;
}

function ref_133ae(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = vectordot(var_0, vectorNormalize(var_3));

  if(var_4 < 0.382683) {
    return true;
  }

  return false;
}

function sixthsense_think_internal() {
  var_0 = scripts\engine\trace::create_default_contents(1);
  var_1 = 0;
  var_2 = getdvarint("scr_sixth_sense_use_eyes_on") == 1;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = getsystemtimeinmicroseconds();

  foreach(var_28, var_8 in level.sixth_sense_players) {
    if(!isDefined(var_8)) {
      level.sixth_sense_players[var_28] = undefined;
      break;
    }

    var_9 = 0;

    if(var_2 && !isbot(var_8)) {
      if(!var_8 scripts\mp\utility\perk::_hasperk("specialty_sixth_sense")) {
        continue;
      }

      if(!var_8 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      var_10 = var_8 scripts\mp\utility\player::getstancecenter();
      var_11 = var_8 getplayerssightingme();

      foreach(var_13 in var_11) {
        if(var_3 >= 25) {
          var_3 = 0;
          waitframe();
        }

        if(!isDefined(var_8)) {
          level.sixth_sense_players[var_28] = undefined;
          break;
        }

        if(!ref_133af(var_8, var_13)) {
          continue;
        }

        var_3++;
        var_14 = var_13 getvieworigin();
        var_15 = anglesToForward(var_13 getplayerangles());

        if(!ref_133ad(var_8, var_13, var_10, var_14, var_15)) {
          continue;
        }

        var_9 |= roof_rpg_covers(var_8, var_13);
      }
    } else {
      var_10 = var_8 gettagorigin("j_spinelower");
      var_17 = var_8 getEye();
      var_18 = anglesToForward(var_8 getplayerangles());

      foreach(var_13 in level.players) {
        if(var_3 >= 25) {
          var_3 = 0;
          waitframe();
        }

        if(!isDefined(var_8)) {
          level.sixth_sense_players[var_28] = undefined;
          break;
        }

        if(!ref_133af(var_8, var_13)) {
          continue;
        }

        var_3++;
        var_14 = var_13 getvieworigin();
        var_15 = anglesToForward(var_13 getplayerangles());

        if(!ref_133ad(var_8, var_13, var_10, var_14, var_15)) {
          continue;
        }

        if(ref_133ae(var_18, var_10, var_14)) {
          var_3 += 2;
          var_20 = [var_8];
          var_21 = var_13 scripts\cp_mp\utility\player_utility::getvehicle();

          if(isDefined(var_21)) {
            var_22 = getchildoutlineents(var_21);

            foreach(var_24 in var_22) {
              var_20 = var_24;
            }
          }

          var_26 = var_13.currentturret;

          if(isDefined(var_26)) {
            var_20 = var_26;
          }

          if(scripts\engine\trace::ray_trace_detail_passed(var_14, var_17, var_20, var_0)) {
            var_9 = 255;
            break;
          }
        }
      }

      var_28 = undefined;
      var_17 = undefined;
    }

    if(scripts\mp\gametypes\br_public::isbrgametypefuncdefinedwrapper("sixthSenseThink")) {
      var_6 |= scripts\mp\gametypes\br_public::runbrgametypefuncwrapper("sixthSenseThink", var_5);
    }

    updatesixthsensevfx(var_5, var_6);
  }

  var_4 = undefined;
}

function sixthsense_think() {
  level.sixth_sense_players = [];

  for(;;) {
    waitframe();
    sixthsense_think_internal();
  }
}

function setsixthsense() {
  if(getdvarint("perk_sixthsensedisabled", 0) == 1) {
    return;
  }

  self.sixthsenselastactivetime = 0;
  self.sixthsensestate = 0;
  updatesixthsensevfx(0);
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = self;
}

function unsetsixthsense() {
  thread health_reduction();
}

function health_reduction() {
  self endon("disconnect");
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("removeSixthSense");
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = undefined;
  waitframe();
  updatesixthsensevfx(0);
}

function setenhancedsixthsense() {}

function unsetenhancedsixthsense() {}

function updatesixthsensevfx(var_0) {
  self setclientomnvar("ui_edge_glow", var_0);
}

function roof_rpg_covers(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectorNormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388) {
    return 2;
  }

  if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, var_2, var_0.origin), 4, 1);
  }

  if(var_5 >= 0.5) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, var_2, var_0.origin), 128, 64);
  }

  if(var_5 >= -0.707107) {
    return scripts\engine\utility::ter_op(scripts\mp\utility\script::isleft2d(self.origin, var_2, var_0.origin), 32, 8);
  }

  return 16;
}

function markassixthsensesource(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("markAsSixthSenseSource");
  self endon("markAsSixthSenseSource");
  var_1 = var_0 getentitynumber();
  self.sixthsensesource[var_1] = 1;
  var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["death"], 10);
  self.sixthsensesource[var_1] = 0;
}

function setcamoelite() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");

  for(;;) {
    var_0 = 0;
    var_1 = level.players;
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isDefined(var_4) || !var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(var_4.team == self.team) {
        continue;
      }

      if(var_4 scripts\mp\utility\perk::_hasperk("specialty_empimmune")) {
        continue;
      }

      var_5 = self.origin - var_4.origin;
      var_6 = anglesToForward(var_4 getplayerangles());
      var_7 = vectordot(var_5, var_6);

      if(var_7 <= 0) {
        continue;
      }

      var_8 = vectorNormalize(var_5);
      var_9 = vectorNormalize(var_6);
      var_7 = vectordot(var_8, var_9);

      if(var_7 < 12) {
        continue;
      }

      var_0++;
      var_10 = var_4 getEye();
      var_11 = self getEye();

      if(scripts\engine\trace::ray_trace_passed(var_10, var_11, self, scripts\engine\trace::create_default_contents(1))) {
        var_2 = 1;
        break;
      }

      if(var_0 >= 10) {
        waitframe();
        var_0 = 0;
      }
    }

    updatecamoeliteoverlay(var_2);
    waitframe();
  }
}

function updatecamoeliteoverlay(var_0) {}

function unsetcamoelite() {}

function setcarepackage() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("airdrop_assault", 0, 0, self);
}

function unsetcarepackage() {}

function setuav() {
  thread scripts\mp\killstreaks\killstreaks::givekillstreak("uav", 0, 0, self);
}

function unsetuav() {}

function setjuiced(var_0) {
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

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = var_0 * 1000 + gettime();

  if(isai(self)) {}

  wait var_0;
  unsetjuiced();
}

function unsetjuiced(var_0) {
  if(!isDefined(var_0)) {
    self.movespeedscaler = 1;

    if(scripts\mp\utility\perk::_hasperk("specialty_lightweight")) {
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
    }

    scripts\mp\weapons::updatemovespeedscale();
  }

  scripts\mp\utility\perk::removeperk("specialty_fastreload");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_stalker");
  scripts\mp\utility\perk::removeperk("specialty_fastoffhand");
  scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::removeperk("specialty_quickswap");
  self.isjuiced = undefined;

  if(isai(self)) {}

  self notify("unset_juiced");
}

function unsetjuicedonride() {
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

function unsetjuicedondeath() {
  self endon("disconnect");
  self endon("unset_juiced");
  scripts\engine\utility::ref_143a5("death", "faux_spawn");
  thread unsetjuiced(1);
}

function unsetjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_juiced");
  level scripts\engine\utility::ref_143a5("round_end_finished", "game_ended");
  thread unsetjuiced();
}

function hasjuiced() {
  return isDefined(self.isjuiced);
}

function setcombathigh() {
  self endon("death_or_disconnect");
  self endon("unset_combathigh");
  level endon("end_game");
  self.damageblockedtotal = 0;

  if(level.splitscreen) {
    var_0 = 56;
    var_1 = 21;
  } else {
    var_0 = 112;
    var_1 = 32;
  }

  if(isDefined(self.juicedtimer)) {
    self.juicedtimer destroy();
  }

  if(isDefined(self.juicedicon)) {
    self.juicedicon destroy();
  }

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
  self.combathightimer = scripts\mp\hud_util::createtimer("hudsmall", 1);
  self.combathightimer scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, var_0);
  self.combathightimer settimer(10);
  self.combathightimer.color = (0.8, 0.8, 0);
  self.combathightimer.archived = 0;
  self.combathightimer.foreground = 1;
  self.combathighicon = scripts\mp\hud_util::createicon("specialty_painkiller", var_1, var_1);
  self.combathighicon.alpha = 0;
  self.combathighicon scripts\mp\hud_util::setparent(self.combathightimer);
  self.combathighicon scripts\mp\hud_util::setpoint("BOTTOM", "TOP");
  self.combathighicon.archived = 1;
  self.combathighicon.sort = 1;
  self.combathighicon.foreground = 1;
  self.combathighoverlay.alpha = 0;
  self.combathighoverlay fadeovertime(1);
  self.combathighicon fadeovertime(1);
  self.combathighoverlay.alpha = 1;
  self.combathighicon.alpha = 0.85;
  thread unsetcombathighondeath();
  thread unsetcombathighonride();
  wait 8;
  self.combathighicon fadeovertime(2);
  self.combathighicon.alpha = 0;
  self.combathighoverlay fadeovertime(2);
  self.combathighoverlay.alpha = 0;
  self.combathightimer fadeovertime(2);
  self.combathightimer.alpha = 0;
  wait 2;
  self.damageblockedtotal = undefined;
  scripts\mp\utility\perk::removeperk("specialty_combathigh");
}

function unsetcombathighondeath() {
  self endon("disconnect");
  self endon("unset_combathigh");
  self waittill("death");
  thread scripts\mp\utility\perk::removeperk("specialty_combathigh");
}

function unsetcombathighonride() {
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

function unsetcombathigh() {
  self notify("unset_combathigh");
  self.combathighoverlay destroy();
  self.combathighicon destroy();
  self.combathightimer destroy();
}

function setlightarmor() {
  scripts\mp\lightarmor::setlightarmorvalue(self, 150);
}

function unsetlightarmor() {
  scripts\mp\lightarmor::lightarmor_unset(self);
}

function setrevenge() {
  self notify("stopRevenge");
  waitframe();

  if(!isDefined(self.lastkilledby)) {
    return;
  }

  if(level.teambased && self.team == self.lastkilledby.team) {
    return;
  }

  var_0 = spawnStruct();
  var_0.showto = self;
  var_0.icon = "compassping_revenge";
  var_0.offset = (0, 0, 64);
  var_0.width = 10;
  var_0.height = 10;
  var_0.archived = 0;
  var_0.delay = 1.5;
  var_0.constantsize = 0;
  var_0.pintoscreenedge = 1;
  var_0.fadeoutpinnedicon = 0;
  var_0.is3d = 0;
  self.revengeparams = var_0;
  self.lastkilledby thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_0.showto, var_0.icon, var_0.offset, undefined, undefined, undefined, var_0.delay);
  thread watchrevengedeath();
  thread watchrevengekill();
  thread watchrevengedisconnected();
  thread watchrevengevictimdisconnected();
  thread watchstoprevenge();
}

function watchrevengedeath() {
  self endon("stopRevenge");
  self endon("disconnect");
  var_0 = self.lastkilledby;

  for(;;) {
    var_0 waittill("spawned_player");
    var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, undefined, undefined, undefined, self.revengeparams.delay);
  }
}

function watchrevengekill() {
  self endon("stopRevenge");
  self waittill("killed_enemy");
  self notify("stopRevenge");
}

function watchrevengedisconnected() {
  self endon("stopRevenge");
  self.lastkilledby waittill("disconnect");
  self notify("stopRevenge");
}

function watchstoprevenge() {
  var_0 = self.lastkilledby;
  self waittill("stopRevenge");

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0.entityheadicons) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2 destroy();
  }
}

function watchrevengevictimdisconnected() {
  var_0 = self.objidfriendly;
  var_1 = self.lastkilledby;
  var_1 endon("disconnect");
  level endon("game_ended");
  self endon("stopRevenge");
  self waittill("disconnect");

  if(!isDefined(var_1)) {
    return;
  }

  foreach(var_3 in var_1.entityheadicons) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 destroy();
  }
}

function unsetrevenge() {
  self notify("stopRevenge");
}

function setphaseslide() {
  self.canphaseslide = 1;
}

function unsetphaseslide() {
  self.canphaseslide = 0;
}

function setteleslide() {
  self.canteleslide = 1;
}

function unsetteleslide() {
  self.canteleslide = 0;
}

function setphaseslashrephase() {
  self.hasrephase = 1;
}

function unsetphaseslashrephase() {
  self.hasrephase = 0;
}

function setphasefall() {}

function unsetphasefall() {}

function setextenddodge() {}

function unsetextenddodge() {}

function setauraquickswap() {
  scripts\mp\archetypes\archassault::auraquickswap_run();
}

function unsetauraquickswap() {}

function setauraspeed() {}

function unsetauraspeed() {}

function setmarktargets() {
  scripts\mp\perks\perk_mark_targets::marktarget_init();
}

function unsetmarktargets() {}

function setbatterypack() {}

function unsetbatterypack() {}

function setcamoclone() {}

function unsetcamoclone() {}

function setblockhealthregen() {
  self.healthregendisabled = 1;
  self notify("force_regeneration");
}

function unsetblockhealthregen() {
  self.healthregendisabled = undefined;
  self notify("force_regeneration");
}

function setscorestreakpack() {}

function unsetscorestreakpack() {}

function setsuperpack() {}

function unsetsuperpack() {}

function setspawncloak() {}

function unsetspawncloak() {}

function setdodgedefense() {
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("dodgeDefense", 0.5, 0, &dodgedefenseignorefunc);
}

function unsetdodgedefense() {
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("dodgeDefense", 0);
}

function dodgedefenseignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!(isDefined(var_2.dodging) && var_2.dodging && var_2 scripts\mp\utility\perk::_hasperk("specialty_dodge_defense"))) {
    return true;
  }

  return false;
}

function setdodgewave() {}

function unsetdodgewave() {}

function setgroundpound() {}

function unsetgroundpound() {}

function setmeleekill() {
  self giveweapon("iw7_fistsperk_mp");
  self assignweaponmeleeslot("iw7_fistsperk_mp");

  if(self hasweapon("iw8_fists_mp")) {
    var_0 = self getcurrentweapon();
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_fists_mp");
    self giveweapon("iw7_fistslethal_mp");

    if(var_0.basename == "iw8_fists_mp") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("iw7_fistslethal_mp");

      if(isDefined(self.gettingloadout) && self.gettingloadout && isDefined(self.spawnweaponobj) && self.spawnweaponobj.basename == "iw8_fists_mp") {
        self.spawnweaponobj = getcompleteweaponname("iw7_fistslethal_mp");
        self setspawnweapon(self.spawnweaponobj);
        return;
      }

      return;
    }

    return;
  }
}

function unsetmeleekill() {
  scripts\cp_mp\utility\inventory_utility::_takeweapon("iw7_fistsperk_mp");

  if(self hasweapon("iw7_fistslethal_mp")) {
    var_0 = self.currentweapon;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw7_fistslethal_mp");
    self giveweapon("iw8_fists_mp");

    if(var_0.basename == "iw7_fistslethal_mp") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon("iw8_fists_mp");
      return;
    }

    return;
  }
}

function setpowercell() {}

function unsetpowercell() {}

function sethardline() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints, 1);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
  self.hardlineactive["assists"] = 0;
}

function watchhardlineassists() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
}

function unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

function setoverclock() {}

function unsetoverclock() {}

function setovercharge() {
  thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_overcharge", 1);
}

function unsetovercharge() {
  thread _calloutmarkerping_handleluinotify_added::ref_1313d("ui_overcharge", 0);
}

function setsupersprintenhanced() {
  thread watchforsupersprintenhancedused();
}

function unsetsupersprintenhanced() {
  self notify("unsetSuperSprintEnhanced");
}

function watchforsupersprintenhancedused() {
  self endon("unsetSuperSprintEnhanced");
  self endon("disconnect");
  var_0 = 0;

  while(2000 > var_0) {
    waitframe();

    if(isDefined(self) && istrue(self issupersprinting())) {
      var_1 = level.frameduration;
      var_0 += var_1;
    }
  }

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

function settracker() {}

function unsettracker() {}

function setpersonaltrophy() {}

function unsetpersonaltrophy() {}

function setdisruptorpunch() {}

function unsetdisruptorpunch() {}

function setequipmentping() {
  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    level.equipmentpingactive = 1;
    return;
  }
}

function unsetequipmentping() {}

function setruggedeqp() {}

function unsetruggedeqp() {}

function feedbackruggedeqp(var_0, var_1, var_2, var_3) {}

function setmanatarms() {}

function unsetmanatarms() {}

function setoutlinekillstreaks() {
  thread outlinekillstreaks_enablemarksafterprematch();
}

function outlinekillstreaks_enablemarksafterprematch() {
  self endon("unsetOutlineKillstreak");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = 1000000;

  if(level.gametype == "br") {
    var_0 = 1000;
  }

  if(isDefined(self)) {
    self enableentitymarks("killstreak", var_0);
    self enableentitymarks("air_killstreak", var_0);
    self.perkoutlinekillstreaksset = 1;
    _calloutmarkerping_predicted_timeout::ref_14130(self);
    return;
  }
}

function unsetoutlinekillstreaks() {
  if(istrue(self.perkoutlinekillstreaksset)) {
    self disableentitymarks("killstreak");
    self disableentitymarks("air_killstreak");
    self.perkoutlinekillstreaksset = undefined;
  }

  _calloutmarkerping_predicted_timeout::ref_14130(self);
  self notify("unsetOutlineKillstreak");
}

function setengineer() {
  thread engineer_enablemarksafterprematch();
}

function engineer_enablemarksafterprematch() {
  self endon("unsetEngineer");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = 1000000;

  if(level.gametype == "br") {
    var_0 = 1000;
  }

  if(isDefined(self)) {
    self enableentitymarks("equipment", var_0);
    self.perkengineerset = 1;
    return;
  }
}

function unsetengineer() {
  if(istrue(self.perkengineerset)) {
    self disableentitymarks("equipment");
    self.perkengineerset = undefined;
  }

  self notify("unsetEngineer");
}

function setnoscopeoutline() {
  if(!isDefined(level.noscopeoutlinesetnotifs)) {
    level.noscopeoutlinesetnotifs = [];
    level.noscopeoutlineunsetnotifs = [];
    thread processnoscopeoutlinesetnotifs();
    thread processnoscopeoutlineunsetnotifs();
  }

  level.noscopeoutlinesetnotifs[level.noscopeoutlinesetnotifs.size] = self;
}

function unsetnoscopeoutline() {
  level.noscopeoutlineunsetnotifs[level.noscopeoutlineunsetnotifs.size] = self;
}

function processnoscopeoutlinesetnotifs() {
  level endon("game_ended");

  for(;;) {
    if(level.noscopeoutlinesetnotifs.size > 0) {
      var_0 = 0;

      while(isDefined(level.noscopeoutlinesetnotifs[var_0])) {
        level notify("set_noscopeoutline", level.noscopeoutlinesetnotifs[var_0]);
        level.noscopeoutlinesetnotifs[var_0] notify("set_noscopeoutline");
        var_0++;
        waitframe();
      }

      level.noscopeoutlinesetnotifs = [];
      continue;
    }

    waitframe();
  }
}

function processnoscopeoutlineunsetnotifs() {
  level endon("game_ended");

  for(;;) {
    if(level.noscopeoutlineunsetnotifs.size > 0) {
      var_0 = 0;

      while(isDefined(level.noscopeoutlineunsetnotifs[var_0])) {
        level notify("unset_noscopeoutline", level.noscopeoutlineunsetnotifs[var_0]);
        level.noscopeoutlineunsetnotifs[var_0] notify("unset_noscopeoutline");
        var_0++;
        waitframe();
      }

      level.noscopeoutlineunsetnotifs = [];
      continue;
    }

    waitframe();
  }
}

function setcloak() {}

function unsetcloak() {}

function setwalllock() {}

function unsetwalllock() {}

function setrush() {}

function unsetrush() {
  self notify("removeCombatHigh");
  self.speedonkillmod = undefined;
}

function sethover() {
  thread runhover();
}

function unsethover() {}

function setmomentum() {
  self endon("death_or_disconnect");
  self endon("momentum_unset");
  self.momentumspeedincrease = 0;
  scripts\mp\weapons::updatemovespeedscale();

  for(;;) {
    self waittill("killed_enemy");
    thread ref_11cd0();
  }
}

function unsetmomentum() {
  self notify("momentum_unset");
  self.momentumspeedincrease = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

function ref_11cd0() {
  self endon("death_or_disconnect");
  self endon("momentum_unset");
  self.momentumspeedincrease += 0.04;
  self.momentumspeedincrease = min(self.momentumspeedincrease, 0.12);
  scripts\mp\weapons::updatemovespeedscale();
  thread ref_11ccf();
}

function ref_11ccf() {
  self endon("death_or_disconnect");
  self notify("momentum_reset_speed");
  self endon("momentum_reset_speed");
  wait 5;
  self.momentumspeedincrease = 0;
  scripts\mp\weapons::updatemovespeedscale();
}

function setscavengereqp() {}

function unsetscavengereqp() {}

function setspawnview() {}

function unsetspawnview() {
  foreach(var_1 in level.players) {
    var_1 notify("end_spawnview");
  }
}

function setheadgear(var_0) {}

function unsetheadgear() {}

function setftlslide() {}

function unsetftlslide() {}

function setimprovedprone() {}

function unsetimprovedprone() {}

function setghost() {
  thread startgpsjammer();
}

function unsetghost() {
  thread removegpsjammer();
}

function setsupportkillstreaks() {
  self endon("disconnect");
  self waittill("equipKillstreaksFinished");

  if(!isDefined(self.streakdata.streaks[1])) {
    foreach(var_1 in self.streakdata.streaks["killstreaks"]) {
      var_1.earned = 0;
    }

    return;
  }
}

function unsetsupportkillstreaks() {
  self notify("end_support_killstreaks");
}

function setoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = 0.98;
  scripts\mp\weapons::updatemovespeedscale();
}

function unsetoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = undefined;
}

function setcloakaerial() {}

function unsetcloakaerial() {}

function setspawnradar() {
  self.hasspawnradar = 1;
}

function unsetspawnradar() {
  self.hasspawnradar = 1;
}

function setimprovedmelee() {}

function unsetimprovedmelee() {}

function setthief() {}

function unsetthief() {}

function setadsawareness() {
  thread runadsawareness();
  self setscriptablepartstate("heightened_senses", "default");
}

function runadsawareness() {
  self endon("death_or_disconnect");
  self endon("unsetADSAwareness");
  self.awarenessradius = 256;
  self.awarenessqueryrate = 2;
  thread awarenessmonitorstance();

  for(;;) {
    wait self.awarenessqueryrate;
    var_0 = scripts\common\utility::playersinsphere(self.origin, self.awarenessradius);

    foreach(var_2 in level.players) {
      if(var_2.team == self.team) {
        continue;
      }

      if(var_2 scripts\mp\utility\perk::_hasperk("specialty_coldblooded")) {
        continue;
      }

      if(var_2 isonground() && !var_2 issprinting() && !var_2 iswallrunning() && !var_2 issprintsliding()) {
        continue;
      }

      thread playincomingwarning(var_2);
    }
  }
}

function playincomingwarning(var_0) {
  self setscriptablepartstate("heightened_senses", "scrn_pulse");
  self playRumbleOnEntity("damage_heavy");
  var_0 playsoundtoplayer("ghost_senses_ping", self);
  wait 0.2;

  if(isDefined(self)) {
    self setscriptablepartstate("heightened_senses", "default");

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self playRumbleOnEntity("damage_heavy");

      if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_0 playsoundtoplayer("ghost_senses_ping", self);
        return;
      }

      return;
    }

    return;
  }
}

function awarenessmonitorstance() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = self getstance();
    var_1 = self getvelocity();

    switch (var_0) {
      case "stand":
        self.awarenessradius = 400;
        self.awarenessqueryrate = 2;
        break;
      case "crouch":
        self.awarenessradius = 650;
        self.awarenessqueryrate = 1;
        break;
      case "prone":
        self.awarenessradius = 700;
        self.awarenessqueryrate = 0.5;
        break;
    }

    wait 0.01;
  }
}

function awarenessaudiopulse() {
  self endon("death_or_disconnect");
  self endon("stop_awareness");

  for(;;) {
    playsoundatpos(self.origin + (0, 0, 5), "ghost_senses_ping");
    wait 2;
  }
}

function unsetadsawareness() {
  self notify("unsetADSAwareness");
  self setscriptablepartstate("heightened_senses", "default");
}

function setrearguard() {}

function unsetrearguard() {
  self.hasrearguardshield = undefined;
}

function setsolobuddyboost() {
  self.hassolobuddyboost = 1;
}

function unsetsolobuddyboost() {
  self.hassolobuddyboost = undefined;
}

function setthrowingknifemelee() {
  self giveweapon(self.ref_13b5c);
  self assignweaponmeleeslot(self.ref_13b5c);
  thread watchthrowingknifescavenge();

  if(self.ref_13b5c == "iw8_throwingknife_fire_melee_mp") {
    thread ref_144fd();
    return;
  }

  if(self.ref_13b5c == "iw8_throwingknife_electric_melee_mp") {
    thread ref_144fc();
    return;
  }
}

function unsetthrowingknifemelee() {
  if(isDefined(self.ref_13b5c) && self hasweapon(self.ref_13b5c)) {
    self takeweapon(self.ref_13b5c);
  }

  self notify("specialty_equip_throwingKnife_end");

  if(isDefined(self.ref_13b5c) && self.ref_13b5c == "iw8_throwingknife_fire_melee_mp") {
    votesys_think();
    return;
  }

  if(isDefined(self.ref_13b5c) && self.ref_13b5c == "iw8_throwingknife_electric_melee_mp") {
    votesys_new();
    return;
  }
}

function ref_144fd() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0.basename == "iw8_throwingknife_fire_melee_mp") {
      self setscriptablepartstate("WeaponVFXViewmodel", "flamingKnife");
      self waittill("weapon_change");
      self setscriptablepartstate("WeaponVFXViewmodel", "neutral");
    }
  }
}

function votesys_think() {
  self setscriptablepartstate("WeaponVFXViewmodel", "neutral");
}

function ref_144fc() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0.basename == "iw8_throwingknife_electric_melee_mp") {
      self setscriptablepartstate("WeaponVFXViewmodel", "electricKnife");
      self waittill("weapon_change");
      self setscriptablepartstate("WeaponVFXViewmodel", "neutral");
    }
  }
}

function votesys_new() {
  self setscriptablepartstate("WeaponVFXViewmodel", "neutral");
}

function watchthrowingknifescavenge() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  for(;;) {
    self waittill("offhand_fired", var_0);

    if(scripts\mp\utility\weapon::isthrowingknife(var_0)) {
      var_1 = self getammocount(var_0);

      if(var_1 == 0) {
        if(isDefined(self.ref_13b5c) && self hasweapon(self.ref_13b5c)) {
          self takeweapon(self.ref_13b5c);
        }
      }

      while(self getammocount(var_0) == 0) {
        wait 0.05;
      }

      self giveweapon(self.ref_13b5c);
      self assignweaponmeleeslot(self.ref_13b5c);
    }
  }
}

function setbulletoutline() {
  self.bulletoutline = spawnStruct();
  self.bulletoutline.player = self;
  self.bulletoutline.enemies = [];
  self.bulletoutline.enemyids = [];
  self.bulletoutline.enemyendtimes = [];
  thread watchbulletoutline();
  thread watchbulletoutlinecleanup();
}

function unsetbulletoutline() {
  self notify("unsetBulletOutline");
  self.bulletoutline = undefined;
}

function watchbulletoutline() {
  self.player endon("death_or_disconnect");
  self.player endon("unsetBulletOutline");

  while(isDefined(self.player)) {
    var_0 = gettime();

    foreach(var_3, var_2 in self.enemies) {
      if(!isDefined(var_2)) {
        bulletoutlineremoveenemy(undefined, var_3);
        continue;
      }

      if(var_2 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
        bulletoutlineremoveenemy(var_2, var_3);
        continue;
      }

      if(var_0 >= self.enemyendtimes[var_3]) {
        bulletoutlineremoveenemy(var_2, var_3);
      }
    }

    waitframe();
  }
}

function watchbulletoutlinecleanup() {
  self.player scripts\engine\utility::ref_143a5("disconnect", "unsetBulletOutline");

  foreach(var_1 in self.enemies) {
    if(isDefined(var_1)) {
      bulletoutlineremoveenemy(var_1, var_2);
    }
  }
}

function bulletoutlineaddenemy(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_4 = gettime() + var_1 * 1000;
  self.enemies[var_3] = var_0;

  if(!isDefined(self.enemyids[var_3])) {
    self.enemyids[var_3] = scripts\mp\utility\outline::outlineenableforplayer(var_0, self.player, "outline_depth_red", "perk");
  }

  if(!isDefined(self.enemyendtimes[var_3]) || !isDefined(var_2) || var_2) {
    self.enemyendtimes[var_3] = var_4;
    return;
  }
}

function bulletoutlineremoveenemy(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0 getentitynumber();
  }

  self.enemies[var_1] = undefined;
  self.enemyendtimes[var_1] = undefined;

  if(isDefined(var_0)) {
    scripts\mp\utility\outline::outlinedisable(self.enemyids[var_1], var_0);
  }

  self.enemyids[var_1] = undefined;
}

function bulletoutlinecheck(var_0, var_1, var_2, var_3) {
  if(!(var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_EXPLOSIVE_BULLET")) {
    return;
  }

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  if(!isPlayer(var_0) || !isPlayer(var_1)) {
    return;
  }

  var_4 = var_0;

  if(isDefined(var_0.owner)) {
    var_4 = var_0.owner;
  }

  var_5 = var_1;

  if(isDefined(var_1.owner)) {
    var_5 = var_1.owner;
  }

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_4, var_5))) {
    return;
  }

  if(isPlayer(var_0) && isPlayer(var_1) && scripts\mp\utility\outline::outlineoccluded(var_0 getEye(), var_1 getEye())) {
    return;
  }

  if(isDefined(var_0.bulletoutline) && !var_1 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
    bulletoutlineaddenemy(var_0.bulletoutline, var_1, 1);
  }

  if(isDefined(var_1.bulletoutline) && !var_0 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
    bulletoutlineaddenemy(var_1.bulletoutline, var_0, 2, 0);
    return;
  }
}

function markempsignatures(var_0, var_1) {
  if(!isDefined(var_0.empmarked)) {
    var_0.empmarked = [];
  }

  if(isDefined(var_0.empmarked[var_1]) && var_0.empmarked[var_1] == "active") {
    return;
  }

  var_0.empmarked[var_1] = "active";
  thread empvfx(var_0, var_1);
  var_0 scripts\engine\utility::ref_143a5("death", "cloak_end");
  var_0.empmarked[var_1] = undefined;
}

function empvfx(var_0, var_1) {
  var_2 = ["j_shoulder_ri", "j_shoulder_le", "j_hip_ri", "j_hip_le", "j_spine4", "j_wrist_ri", "j_wrist_le"];
  var_0.empmarked[var_1] = undefined;
}

function startgpsjammer() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");

  if(isai(self)) {
    while(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0) {
      waitframe();
    }
  }

  if(level.minspeedsq == 0) {
    return;
  }

  if(level.timeperiod < 0.05) {
    return;
  }

  self.timesincelastweaponfire = 0;
  thread ghostadvanceduavwatcher();

  if(scripts\mp\utility\game::unset_relic_grounded() && getdvarint("perk_ghost_only_while_moving", 1)) {
    thread ref_11d12();
  } else {
    self setplayerghost(1);
    self.ref_122fe = 1;
  }

  self.timesincelastweaponfire = 0;

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(scripts\mp\class::vehicle_checkpiggybackexploit(var_0)) {
      continue;
    }

    doghostweaponfired();
  }
}

function doghostweaponfired() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");
  self setplayerghost(0);
  self.playbattlechattersound = 1;
  thread checkforghostweaponfire();

  while(self.timesincelastweaponfire < 3) {
    wait level.timeperiod;
    self.timesincelastweaponfire += level.timeperiod;
  }

  self notify("ghost_restored");
  self.timesincelastweaponfire = 0;

  if(self.ref_122fe) {
    self setplayerghost(1);
  }

  self.playbattlechattersound = undefined;
}

function checkforghostweaponfire() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  self endon("ghost_restored");

  for(;;) {
    self waittill("weapon_fired");
    self.timesincelastweaponfire = 0;
  }
}

function ghostadvanceduavwatcher() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  var_0 = scripts\mp\utility\game::getgametype() == "br";

  if(var_0) {
    self setplayeradvanceduavdot(1);
    return;
  }

  for(;;) {
    if(level.teambased) {
      var_1 = sat_setup_interactions();

      if(var_1) {
        self setplayeradvanceduavdot(1);
        self setplayerghost(0);

        while(var_1) {
          waitframe();
          var_1 = sat_setup_interactions();
        }

        self setplayerghost(1);
        self setplayeradvanceduavdot(0);
      }
    } else {
      foreach(var_3 in level.players) {
        if(var_3 == self) {
          continue;
        }

        if(istrue(level.activeadvanceduavs[var_3.guid]) && level.activeadvanceduavs[var_3.guid] > 0) {
          self setplayeradvanceduavdot(1);
          self setplayerghost(0);

          while(istrue(level.activeadvanceduavs[var_3.guid]) && level.activeadvanceduavs[var_3.guid] > 0) {
            level waittill("uav_update");
          }

          self setplayerghost(1);
          self setplayeradvanceduavdot(0);
        }
      }
    }

    waitframe();
  }
}

function sat_setup_interactions() {
  var_0 = 0;
  var_1 = undefined;

  if(!isDefined(level.audio_heli_end_fade_out) || !isDefined(level.activeadvanceduavs)) {
    return var_0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
  }

  if(istrue(var_1) && getdvarint("scr_uav_for_squad_only", 1)) {
    var_2 = 0;

    foreach(var_4 in level.squaddata[self.team]) {
      var_2 += level.activeadvanceduavs[self.team + var_5];
    }

    var_0 = level.audio_heli_end_fade_out - var_2 > 0;
  } else {
    var_0 = level.audio_heli_end_fade_out - level.activeadvanceduavs[self.team] > 0;
  }

  return var_0;
}

function ref_11d12() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = getdvarint("perk_ghost_speed_threshold", 190);
  self.ref_122fe = 0;
  var_1 = 0;

  for(;;) {
    var_2 = self.super;
    var_3 = isDefined(var_2) && isDefined(var_2.staticdata.ref) && isDefined(var_2.usepercent);

    if(var_3 && var_2.staticdata.ref == "super_deadsilence" && var_2.usepercent > 0 || isDefined(self.vehicle)) {
      if(!self.ref_122fe) {
        self.ref_122fe = 1;
        var_1 = 0;
        self setplayerghost(1);
      }

      if(var_1 && self.ref_122fe) {
        self notify("enable_ghost");
        var_1 = 0;
      }

      waitframe();
      continue;
    }

    var_4 = self getvelocity();
    var_5 = abs(var_4[0]) + abs(var_4[1]) + abs(var_4[2]);

    if(var_5 >= var_0 && !self.ref_122fe && !self isjumping() && !istrue(self.playbattlechattersound)) {
      self.ref_122fe = 1;
      var_1 = 0;
      self setplayerghost(1);
    } else if(var_5 >= var_0 && var_1 && self.ref_122fe) {
      self notify("enable_ghost");
      var_1 = 0;
    } else if(var_5 < var_0 && self.ref_122fe && !var_1) {
      thread ref_122fd();
      var_1 = 1;
    }

    waitframe();
  }
}

function ref_122fd() {
  self endon("enable_ghost");
  self endon("remove_gpsjammer");
  self endon("disconnect");
  wait getdvarfloat("perk_ghost_falloff_delay", 2);

  if(!isDefined(self)) {
    return;
  }

  self.ref_122fe = 0;
  self setplayerghost(0);
}

function removegpsjammer() {
  self notify("remove_gpsjammer");
  self setplayerghost(0);
  self.ref_122fe = undefined;
  self setplayeradvanceduavdot(0);
}

function setgroundpoundshield() {
  level._effect["groundPoundShield_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function unsetgroundpoundshield() {
  self notify("groundPoundShield_unset");
}

function groundpoundshield_onimpact(var_0) {
  thread groundpoundshield_raiseondelay();
}

function groundpoundshield_raiseondelay() {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundLand");
  wait 0.25;
  groundpoundshield_raise();
}

function groundpoundshield_raise() {
  if(isDefined(self.groundpoundshield)) {
    thread groundpoundshield_lower(self.groundpoundshield);
  }

  var_0 = self.origin + anglesToForward(self.angles) * 5;
  var_1 = self.angles + (0, 90, 0);
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("weapon_shinguard_col_wm");
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setModel("weapon_shinguard_fr_wm");
  var_3.outlineid = scripts\mp\utility\outline::outlineenableforall(var_3, "outline_nodepth_cyan", "equipment");
  var_4 = spawn("script_model", var_0);
  var_4.angles = var_1;
  var_4 setModel("weapon_shinguard_en_wm");
  var_4.outlineid = scripts\mp\utility\outline::outlineenableforall(var_4, "outline_nodepth_orange", "equipment");
  var_2.visfr = var_3;
  var_2.visen = var_4;
  var_2.owner = self;
  var_2 setCanDamage(1);
  var_2.health = 9999;
  var_2.shieldhealth = 210;
  self.groundpoundshield = var_2;
  var_5 = level.characters;

  foreach(var_7 in var_5) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(level.teambased && var_7.team == self.team) {
      var_4 hidefromplayer(var_7);
      continue;
    }

    var_3 hidefromplayer(var_7);
  }

  thread groundpoundshield_monitorjoinedteam(var_2);
  thread groundpoundshield_loweronleavearea(var_2);
  thread groundpoundshield_lowerontime(var_2, 3.25);
  thread groundpoundshield_loweronjump(var_2);
  thread groundpoundshield_deleteondisconnect(var_2);
  thread groundpoundshield_monitorhealth(var_2);
  thread groundpound_raisefx();
  return var_2;
}

function groundpoundshield_lower(var_0) {
  self notify("groundPoundShield_end");

  if(!isDefined(var_0)) {
    return;
  }

  thread groundpoundshield_lowerfx();
  thread groundpoundshield_deleteshield(var_0);
}

function groundpoundshield_break(var_0) {
  self notify("groundPoundShield_end");

  if(!isDefined(var_0)) {
    return;
  }

  thread groundpoundshield_breakfx();
  thread groundpoundshield_deleteshield(var_0);
}

function groundpoundshield_monitorhealth(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_2)) {
      if(var_2 == self || var_2.team != self.team) {
        var_0.shieldhealth -= var_1;
      }
    }

    var_0.health = 9999;
    thread groundpoundshield_damagedfx(var_2, var_4, var_3);

    if(var_0.shieldhealth <= 0) {
      thread groundpoundshield_break(var_0);
      return;
    }

    if(var_0.shieldhealth <= 105) {
      if(var_0.visfr.model != "weapon_shinguard_dam_wm") {
        var_0.visfr setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\outline::outlinerefresh(var_0.visfr);
      }

      if(var_0.visen.model != "weapon_shinguard_dam_wm") {
        var_0.visen setModel("weapon_shinguard_dam_wm");
        scripts\mp\utility\outline::outlinerefresh(var_0.visen);
      }
    }
  }
}

function groundpoundshield_loweronjump(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  var_1 = self isjumping();
  var_2 = undefined;

  for(;;) {
    var_2 = var_1;
    var_1 = self isjumping();

    if(!var_2 && var_1) {
      thread groundpoundshield_lower(var_0);
      return;
    }

    waitframe();
  }
}

function groundpoundshield_lowerontime(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  wait var_1;
  thread groundpoundshield_lower(var_0);
}

function groundpoundshield_loweronleavearea(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  while(isDefined(var_0)) {
    if(lengthsquared(var_0.origin - self.origin) > 11664) {
      thread groundpoundshield_lower(var_0);
      return;
    }

    waitframe();
  }
}

function groundpoundshield_deleteondisconnect(var_0) {
  self endon("groundPoundShield_deleteShield");
  scripts\engine\utility::ref_143a5("death_or_disconnect", "groundPound_unset");
  thread groundpoundshield_deleteshield(var_0);
}

function groundpoundshield_monitorjoinedteam(var_0) {}

function groundpoundshield_deleteshield(var_0) {
  self notify("groundPoundShield_deleteShield");
  scripts\mp\utility\outline::outlinedisable(var_0.visen.outlineid, var_0.visen);
  scripts\mp\utility\outline::outlinedisable(var_0.visfr.outlineid, var_0.visfr);
  var_0.visfr delete();
  var_0.visen delete();
  var_0 delete();
}

function groundpound_raisefx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

function groundpoundshield_lowerfx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

function groundpoundshield_damagedfx(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  playFX(scripts\engine\utility::getfx("groundPoundShield_impact"), var_1, -1 * var_2);
  playsoundatpos(var_1, "ds_shield_impact");
  var_0 scripts\mp\damagefeedback::updatedamagefeedback("hitbulletstorm");
}

function groundpoundshield_breakfx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

function setgroundpoundshock() {
  level._effect["groundPoundShock_impact_sm"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["groundPoundShock_impact_lrg"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function unsetgroundpoundshock() {
  self notify("groundPoundShock_unset");
}

function groundpoundshock_onimpact(var_0) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShock_unset");
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "groundPoundLandTier0":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_1 = 144;
      break;
    case "groundPoundLandTier1":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_sm");
      var_1 = 180;
      break;
    case "groundPoundLandTier2":
      var_2 = scripts\engine\utility::getfx("groundPoundShock_impact_lrg");
      var_1 = 216;
      break;
  }

  thread groundpoundshock_onimpactfx(var_1, var_2);
  var_3 = undefined;

  if(level.teambased) {
    var_3 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);
  } else {
    var_3 = level.characters;
  }

  var_4 = var_1 * var_1;
  var_5 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 0, 0);

  foreach(var_7 in var_3) {
    if(lengthsquared(var_7 getEye() - self getEye()) > var_4) {
      continue;
    }

    var_8 = physics_raycast(self getEye(), var_7 getEye(), var_5, undefined, 0, "physicsquery_closest");

    if(isDefined(var_8) && var_8.size > 0) {
      continue;
    }

    thread groundpoundshock_empplayer(var_7);
  }
}

function groundpoundshock_empplayer(var_0) {
  var_0 endon("death_or_disconnect");
  thread scripts\mp\gamescore::trackdebuffassistfortime(self, var_0, "groundpound_mp", 3);
}

function groundpoundshock_onimpactfx(var_0, var_1) {
  playFX(var_1, self.origin + (0, 0, 20), (0, 0, 1));
}

function setgroundpoundboost() {}

function unsetgroundpoundboost() {
  self notify("groundPoundBoost_unset");
}

function groundpoundboost_onimpact(var_0) {
  scripts\common\utility::set_doublejumpenergy(self energy_getmax(0));
}

function setbattleslideshield() {
  level._effect["battleSlideShield_damage"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  thread battleslideshield_monitor();
}

function unsetbattleslideshield() {
  self notify("battleSlideShield_unset");
}

function battleslideshield_monitor() {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self notify("battleSlideShield_monitor");
  self endon("battleSlideShield_monitor");

  for(;;) {
    self waittill("sprint_slide_begin");
    thread battleslideshield_raise();
  }
}

function battleslideshield_monitorhealth(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");

  while(isDefined(var_0)) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread battleslideshield_damagedfx(var_0, var_2, var_4, var_3);

    if(var_0.health <= 0) {
      thread battleslideshield_break(var_0);
      var_0 delete();
      continue;
    }

    if(var_0.health <= 125) {
      if(var_0.model != "weapon_shinguard_dam_wm") {
        var_0 setModel("weapon_shinguard_dam_wm");
      }

      continue;
    }

    if(var_0.model != "weapon_shinguard_wm") {
      var_0 setModel("weapon_shinguard_wm");
    }
  }
}

function battleslideshield_raise() {
  if(isDefined(self.battleslideshield)) {
    thread battleslideshield_lower(self.battleslideshield);
  }

  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 setModel("weapon_shinguard_wm");
  var_0 setCanDamage(1);
  var_0.health = 250;
  var_0 linkTo(self, "tag_origin", (30, 0, 0), (0, 90, 0));
  var_0 show();
  self.battleslideshield = var_0;
  thread battleslideshield_killonjumpfall(var_0);
  thread battleslideshield_killonsprint(var_0);
  thread battleslideshield_killontime(var_0);
  thread battleslideshield_unlinkonstop(var_0);
  thread battleslideshield_monitorhealth(var_0);
  thread battleslideshield_killondeathdisconnectunset(var_0);
  thread battleslideshield_raisefx(var_0);
  return var_0;
}

function battleslideshield_lower(var_0) {
  self notify("battleSlideShield_end");

  if(!isDefined(var_0)) {
    return;
  }

  thread battleslideshield_lowerfx(var_0);
  var_0 delete();
}

function battleslideshield_killondeathdisconnectunset(var_0) {
  var_0 endon("death");
  scripts\engine\utility::ref_143a5("death_or_disconnect", "battleSlide_unset");
  var_0 delete();
}

function battleslideshield_killonjumpfall(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");

  for(;;) {
    if(!self isonground()) {
      var_0 delete();
      self notify("battleSlideShield_end");
      return;
    }

    waitframe();
  }
}

function battleslideshield_killonsprint(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_begin");
  var_0 delete();
  self notify("battleSlideShield_end");
}

function battleslideshield_loweronleavearea(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  var_0 endon("death");

  for(;;) {
    if(lengthsquared(var_0.origin - self.origin) > 11664) {
      thread battleslideshield_lower(var_0);
      return;
    }

    waitframe();
  }
}

function battleslideshield_lowerontime(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  wait 3.5;
  thread battleslideshield_lower(var_0);
}

function battleslideshield_unlink(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 unlink();
  self notify("battleSlideShield_unlink");
  thread battleslideshield_lowerontime(var_0);
  thread battleslideshield_loweronleavearea(var_0);
  self notify("battleSlideShield_unlink");
}

function battleslideshield_killontime(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_slide_end");
  wait 0.75;
  var_0 delete();
  self notify("battleSlideShield_end");
}

function battleslideshield_unlinkonstop(var_0) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  var_0 endon("death");
  self waittill("sprint_slide_end");

  for(;;) {
    if(lengthsquared(self getvelocity()) < 100) {
      thread battleslideshield_unlink(var_0);
      return;
    }

    waitframe();
  }
}

function battleslideshield_break(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  thread battleslideshield_breakfx(var_0);
  self notify("battleSlideShield_end");
}

function battleslideshield_raisefx(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
}

function battleslideshield_lowerfx(var_0) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
}

function battleslideshield_damagedfx(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  var_0 endon("death");
  playFX(scripts\engine\utility::getfx("battleSlideShield_damage"), var_2, -1 * var_3);
  playsoundatpos(var_2, "ds_shield_impact");
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("hitbulletstorm");
}

function battleslideshield_breakfx(var_0) {}

function setbattleslideoffense() {}

function unsetbattleslideoffense() {}

function getbattleslideoffensedamage() {
  return 100;
}

function setthruster() {
  level._effect["thrusterRadFr"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_fr");
  level._effect["thrusterRadEn"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_en");
  thrusterwatchdoublejump();
}

function unsetthruster() {
  if(isDefined(self.thrustfxent)) {
    self.thrustfxent delete();
  }

  self notify("thruster_unset");
}

function thrusterwatchdoublejump() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");

  for(;;) {
    self waittill("doubleJumpBoostBegin");
    thread thrusterloop();
    thread thrusterdamageloop();
  }
}

function thrusterloop() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");
  thread thrusterstopfx();

  if(!isDefined(self.thrustfxent)) {
    self.thrustfxent = spawn("script_model", self.origin);
    self.thrustfxent setModel("tag_origin");
  } else {
    self.thrustfxent.origin = self.origin;
  }

  waitframe();

  for(;;) {
    self playRumbleOnEntity("damage_light");
    earthquake(0.1, 0.3, self.origin, 120);
    var_0 = playerphysicstrace(self.origin + (0, 0, 10), self.origin - (0, 0, 600)) + (0, 0, 1);
    self.thrustfxent.origin = var_0;
    self.thrustfxent.angles = (90, 0, 0);
    waitframe();
    wait 0.33;
  }
}

function thrusterdamageloop() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");

  for(;;) {
    scripts\mp\utility\damage::radiusplayerdamage(self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1);
    wait 0.05;
  }
}

function thrusterstopfx() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\engine\utility::ref_143a5("doubleJumpBoostEnd", "thruster_unset");
  waitframe();
}

function runhover() {
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

function watchhoverend() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self endon("walllock_ended");

  while(self playerads() > 0.3) {
    waitframe();
  }

  self notify("hover_ended");
}

function executehover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = 1;
  self allowmovement(0);
  self allowjump(0);
  self playlocalsound("ghost_wall_attach");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self playerlinkTo(var_0);
  thread managetimeout(var_0);
}

function managetimeout(var_0) {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  var_1 = self energy_getrestorerate(0);
  self energy_setrestorerate(0, 1);
  wait 2;
  self notify("hover_ended");
  self energy_setrestorerate(0, var_1);
  self energy_setenergy(0, 0);
}

function endhover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = undefined;
  self allowmovement(1);
  self allowjump(1);
  self playlocalsound("ghost_wall_detach");
  self unlink();
}

function setadsmarktarget() {}

function perk_adsmarktarget_think() {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");

  for(;;) {
    if(self playerads() > 0.5) {
      foreach(var_1 in level.players) {
        if(var_1 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
          continue;
        }

        if(var_1.team == self.team) {
          continue;
        }

        if(istrue(var_1.isperk_adsmarked)) {
          continue;
        }

        if(istrue(var_1.ischeckingadsmarking)) {
          continue;
        }

        var_1.ischeckingadsmarking = 1;
        thread perk_adstargetmark_disconnectcleanupthink(var_1);
        thread perk_adstargetmark_disconnectcleanupthink(var_1);

        if(perk_adsmarktarget_check(var_1)) {
          thread perk_adsmarktarget_confirmtargetandmark(var_1);
          continue;
        }

        var_1.ischeckingadsmarking = 0;
      }
    }

    wait 0.2;
  }
}

function perk_adsmarktarget_check(var_0) {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_2 = distance(var_0.origin, self.origin);
  var_3 = 0;

  if(var_2 != 0) {
    var_3 = 1000 * 10 / var_2;
  }

  var_4 = var_0 getEye();

  if(var_0.team != self.team && (self worldpointinreticle_circle(var_0.origin + (0, 0, 24), 90, var_3) || self worldpointinreticle_circle(var_4, 90, var_3))) {
    var_5 = self getEye();
    var_6 = var_4;
    var_7 = physics_raycast(var_5, var_6, var_1, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size == 0) {
      return true;
    }

    waitframe();
    var_6 = var_0.origin + (0, 0, 24);
    var_8 = physics_raycast(var_5, var_6, var_1, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_8) && var_8.size == 0) {
      return true;
    }
  }

  return false;
}

function perk_adsmarktarget_confirmtargetandmark(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  self endon("ADSTargetMarkUnset");
  var_1 = undefined;
  var_2 = getdvarfloat("perk_ads_mark_target_hold_time_req");

  if(scripts\mp\utility\perk::_hasperk("specialty_improved_target_mark")) {
    var_2 *= getdvarfloat("perk_faster_target_mark_rate");
  }

  wait var_2;

  if(self playerads() > 0.5 && perk_adsmarktarget_check(var_0)) {
    var_3 = spawn("script_model", var_0.origin);

    if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_4 = 0;
      var_5 = 5000;
      var_6 = 100;
    } else {
      var_4 = 1;
      var_5 = 5000;
      var_6 = 0;
    }

    var_7 = var_6 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(getlivingplayers_team(self.team), "icon_navbar_enemy", 35, var_4, var_5, var_6, undefined, 1);
    var_4 = scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "outlinefill_nodepth_orange", "equipment");
    var_3 scripts\mp\utility\outline::_hudoutlineviewmodelenable("outline_nodepth_orange", 0);
    var_3.isperk_adsmarked = 1;
    thread perk_trackadsmarktargetoutline(var_7, var_6, var_4, var_3);
    return;
  }

  var_3.ischeckingadsmarking = 0;
}

function perk_trackadsmarktargetoutline(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  wait 0.6;
  scripts\mp\utility\outline::outlinedisable(var_2, var_3);

  if(isDefined(var_3)) {
    var_3 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }

  var_4 = getdvarfloat("perk_ads_mark_target_highlight_time");

  if(scripts\mp\utility\perk::_hasperk("specialty_improved_target_mark")) {
    var_4 *= getdvarfloat("perk_target_marked_longer_rate");
  }

  wait var_4 - 0.6;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0);
  var_1 delete();

  if(isDefined(var_3)) {
    var_3.isperk_adsmarked = 0;
    var_3.ischeckingadsmarking = 0;
  }

  self notify("adsmark_ended");
}

function getlivingplayers_team(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3.team)) {
      continue;
    }

    if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && var_3.team == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function perk_adstargetmark_disconnectcleanupthink(var_0) {
  scripts\engine\utility::ref_143a5("ADSTargetMarkUnset", "death_or_disconnect");

  if(isDefined(var_0)) {
    var_0.ischeckingadsmarking = 0;
    return;
  }
}

function unsetadsmarktarget() {
  self notify("ADSTargetMarkUnset");
}

function sethelmet() {}

function unsethelmet() {}

function setarmorvest() {
  self.tookvesthit = 0;
}

function unsetarmorvest() {}

function setladder() {}

function unsetladder() {}

function setdoorbreach() {
  scripts\mp\destructible::allowplayertobreach(self);
  scripts\mp\door::updatealldoorslockvisibilityforplayer(self, 1);
}

function unsetdoorbreach() {
  scripts\mp\destructible::allowplayertobreach(self);
}

function setdoorsense() {
  if(!isDefined(level.playerswithdoorsense)) {
    level.playerswithdoorsense = 1;
    return;
  }

  level.playerswithdoorsense += 1;
}

function unsetdoorsense() {
  level.playerswithdoorsense -= 1;
}

function setworsenedgunkick() {
  updateweaponkick();
}

function unsetworsenedgunkick() {
  updateweaponkick(1);
}

function updateweaponkick(var_0) {
  if(!isDefined(self.weaponkickrecoil)) {
    self.weaponkickrecoil = 0;
  }

  var_1 = -25;

  if(scripts\mp\utility\perk::_hasperk("specialty_worsenedgunkick") && !istrue(var_0)) {
    if(isDefined(self.currentweapon)) {
      switch (self.currentweapon.classname) {
        case "rifle":
          var_1 = -20;
          break;
        case "mg":
          var_1 = -20;
          break;
      }
    }
  } else {
    var_1 = 0;
  }

  if(var_1 != self.weaponkickrecoil) {
    scripts\mp\utility\weapon::setrecoilscale(-1 * self.weaponkickrecoil);
    scripts\mp\utility\weapon::setrecoilscale(var_1);
    self.weaponkickrecoil = var_1;
    return;
  }
}

function setkillstreaktoscorestreak() {
  var_0 = undefined;

  if(isDefined(self.pers["killstreakToScorestreak_lifeId"]) && self.pers["killstreakToScorestreak_lifeId"] == self.lifeid) {
    var_0 = self.pers["killstreakToScorestreak"];
    self.pers["killstreakToScorestreak"] = undefined;
    self.pers["killstreakToScorestreak_lifeId"] = undefined;
  } else {
    var_0 = vote_player_reset(self.streakpoints);
  }

  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::setstreakpoints(var_0);
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints, 1);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

function unsetkillstreaktoscorestreak() {
  self.pers["killstreakToScorestreak"] = self.streakpoints;
  self.pers["killstreakToScorestreak_lifeId"] = self.lifeid;
  var_0 = vote_player_set(self.streakpoints);
  scripts\mp\killstreaks\killstreaks::updatestreakcosts();
  scripts\mp\killstreaks\killstreaks::setstreakpoints(var_0);
  scripts\mp\killstreaks\killstreaks::checkstreakreward(self.streakpoints, 1);
  scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

function vote_player_reset(var_0) {
  return var_0 * 125;
}

function vote_player_set(var_0) {
  return int(var_0 / 125);
}

function ref_13137() {
  if(self.streakpoints <= 0) {
    self.pers["canKillChain"] = 1;
    return;
  }
}

function ref_13f64() {
  if(!istrue(level.gameended)) {
    self.pers["canKillChain"] = undefined;
    return;
  }
}

function setscrapweapons() {
  if(getdvarint("perk_graverobber_enabled") == 1) {
    self setclientomnvar("ui_graverobber", 1);
    return;
  }
}

function unsetscrapweapons() {
  self setclientomnvar("ui_graverobber", 0);
}

function setdooralarm() {
  self.alarmeddoors = [];
  scripts\mp\door::updatealldoorsalarmvisibilityforplayer(self, 1);
}

function unsetdooralarm() {
  foreach(var_1 in self.alarmeddoors) {
    var_1 scripts\mp\door::removealarmdoor(0);
  }

  self.alarmeddoors = undefined;
  scripts\mp\door::updatealldoorsalarmvisibilityforplayer(self, 0);
}

function setreviveuseweapon() {
  thread proximityrevivethink();
}

function proximityrevivethink() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");

  if(!isDefined(self.proximityrevivefauxtrigger)) {
    var_0 = spawnStruct();
    var_0.usetime = getdvarfloat("perk_medicReviveSpeedRatio") * scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveTimer");
    var_0.curprogress = 0;
    var_0.owner = undefined;
    var_0.id = "laststand_reviver";
    var_0.trigger = spawnStruct();
    var_0.trigger.id = "laststand_reviver";
    self.proximityrevivefauxtrigger = var_0;
  }

  var_0 = self.proximityrevivefauxtrigger;

  if(!isDefined(self.hiddenreviveents)) {
    self.hiddenreviveents = [];
  }

  self.canrevivewithweapon = 1;

  if(isDefined(level.revivetriggers)) {
    foreach(var_3, var_2 in level.revivetriggers) {
      if(!isDefined(self.hiddenreviveents[var_3])) {
        var_2.trigger disableplayeruse(self);
        self.hiddenreviveents[var_3] = var_2.trigger;
      }
    }
  }

  foreach(var_2 in level.laststandreviveents) {
    if(!isDefined(self.hiddenreviveents[var_3])) {
      var_2 disableplayeruse(self);
      self.hiddenreviveents[var_3] = var_2;
    }
  }

  for(;;) {
    var_5 = scripts\mp\utility\player::getplayersinradius(self.origin, 150, self.team, self);

    foreach(var_7 in var_5) {
      if(istrue(var_7.inlaststand) && !istrue(var_7.stuckinlaststand) && !istrue(var_7.laststandhealisactive) && !istrue(var_7 scripts\mp\utility\player::registerpuzzleinteractions()) && !isDefined(var_0.owner)) {
        thread proximityrevive(var_7, var_0);
      }
    }

    if(isDefined(level.revivetriggers)) {
      foreach(var_10 in level.revivetriggers) {
        if(var_10.ownerteam == self.team) {
          if(!istrue(var_10.trigger.owner scripts\mp\utility\player::registerpuzzleinteractions()) && !isDefined(var_0.owner)) {
            if(distancesquared(var_10.trigger.origin, self.origin) <= 22500) {
              thread proximityrevive(var_10.trigger.owner, var_0, var_10);
            }
          }
        }
      }
    }

    wait 0.1;
  }
}

function proximityrevive(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_finished");
  var_0 scripts\mp\utility\player::ref_1312b(1);
  var_1.owner = var_0;
  var_1.trigger.owner = var_0;
  thread watchproximityrevivefail(var_0, var_1, var_2);

  if(isDefined(var_2)) {
    var_2.trigger hide();
    var_2.trigger makeunusable();
    var_2 scripts\mp\teamrevive::revivetriggerholdonusebegin(self, 1);
  } else if(isDefined(var_0.laststandreviveent)) {
    var_0.laststandreviveent hide();
    var_0.laststandreviveent makeunusable();
  }

  var_0 notify("handle_revive_message");
  var_0 scripts\mp\utility\player::_freezecontrols(1, undefined, "proximityRevive");

  while(var_1.curprogress < var_1.usetime) {
    if(distancesquared(self.origin, var_0.origin) > 90000) {
      self notify("prox_revive_fail");
      return;
    }

    scripts\mp\gameobjects::updateuiprogress(var_1, 1);
    var_1.curprogress += level.framedurationseconds;
    waitframe();
  }

  scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
  var_0 scripts\mp\utility\player::_freezecontrols(0, undefined, "proximityRevive");
  var_1.curprogress = 0;
  var_1.owner = undefined;
  var_1.trigger.owner = undefined;

  if(istrue(var_0.inlaststand)) {
    var_0 notify("last_stand_revived");
    return;
  }

  var_2 scripts\mp\teamrevive::revivetriggerholdonuseend(self.team, self, 1, 1);
  var_2 scripts\mp\teamrevive::revivetriggerholdonuse(self);
}

function watchproximityrevivefail(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("last_stand_revived");
  var_0 endon("spawned_player");
  var_3 = var_0.team;
  scripts\engine\utility::waittill_any_ents_return(self, "death_or_disconnect", self, "unset_revive_use_weapon", self, "prox_revive_fail", var_0, "death_or_disconnect", var_0, "last_stand_finished");

  if(isDefined(var_2)) {
    var_2.trigger show();
    var_2.trigger makeusable();
    var_2 scripts\mp\teamrevive::revivetriggerholdonuseend(var_3, self, 0, 1);
  }

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\player::ref_1312b(0);
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
    var_0 scripts\mp\utility\player::_freezecontrols(0, undefined, "proximityRevive");

    if(isDefined(var_0.laststandreviveent)) {
      var_0.laststandreviveent show();
      var_0.laststandreviveent makeusable();
    }

    var_0 notify("handle_revive_message");
  }

  if(isDefined(self)) {
    var_1.owner = undefined;
    var_1.trigger.owner = undefined;
    var_1.curprogress = 0;
    scripts\mp\gameobjects::updateuiprogress(var_1, 0);
    return;
  }
}

function unsetreviveuseweapon() {
  self notify("unset_revive_use_weapon");
  self.canrevivewithweapon = undefined;

  foreach(var_1 in self.hiddenreviveents) {
    if(isDefined(var_1) && var_1.owner != self) {
      var_1 showtoplayer(self);
      var_1 enableplayeruse(self);
    }
  }
}

function setlocationmarking() {}

function unsetlocationmarking() {}

function setremotedefuse() {}

function unsetremotedefuse() {}

function setalwaysminimap() {
  scripts\mp\utility\player::showminimap();
}

function unsetalwaysminimap() {
  scripts\mp\utility\player::hideminimap();
}

function supersprintkillrefresh_init() {
  level._effect["super_sprint_refresh"] = loadfx("vfx/iw8_mp/perk/vfx_hustle.vfx");
  level._effect["super_sprint_refresh_night"] = loadfx("vfx/iw8_mp/perk/vfx_hustle_night.vfx");
}

function supersprintkillrefresh_onkill() {
  self refreshsprinttime();
}

function setgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

function unsetgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

function setfastreloadlaunchers() {}

function unsetfastreloadlaunchers() {
  if(istrue(self.fastreloadlaunchers)) {
    scripts\mp\utility\perk::removeperk("specialty_fastreload");
    self.fastreloadlaunchers = undefined;
    return;
  }
}

function setreduceregendelay() {
  self.regendelayspeed = 2;
}

function unsetreduceregendelay() {
  self.regendelayspeed = 1;
}

function regendelayreduce_onkill() {
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_1 = self isnightvisionon();
  var_2 = var_0 && !var_1;
  var_3 = scripts\engine\utility::ter_op(var_2, scripts\engine\utility::getfx("super_sprint_refresh_night"), scripts\engine\utility::getfx("super_sprint_refresh"));
  playfxontagforclients(var_3, self, "tag_eye", self);
  thread ref_12acf();
}

function ref_12acf() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("regenDelayReduce_delayedRegen");
  self endon("regenDelayReduce_delayedRegen");
  var_0 = gettime();

  while(var_0 + 140 > gettime()) {
    scripts\mp\healthoverlay::reducehealthregendelay(10000);
    waitframe();
  }
}

function ref_131b8() {
  if(isDefined(self.waittoopenaltbunker) && self.waittoopenaltbunker == gettime()) {
    regendelayreduce_onkill();
    return;
  }
}

function ref_13f6c() {}

function ref_12ad0() {
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_1 = self isnightvisionon();
  var_2 = var_0 && !var_1;
  var_3 = scripts\engine\utility::ter_op(var_2, scripts\engine\utility::getfx("super_sprint_refresh_night"), scripts\engine\utility::getfx("super_sprint_refresh"));
  playfxontagforclients(var_3, self, "tag_eye", self);
  thread ref_12acf();
}

function ref_131ba() {
  if(isDefined(self.tracking_max_health) && istrue(self.tracking_max_health)) {
    ref_12ad0();
    return;
  }
}

function setreduceregendelayonobjective() {
  updatereduceregendelayonobjective();
  thread monitorreduceregendelayonobjective();
}

function unsetreduceregendelayonobjective() {
  self notify("unsetReduceRegenDelayOnObjective");
  updatereduceregendelayonobjective(1);
}

function monitorreduceregendelayonobjective() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unsetReduceRegenDelayOnObjective");

  for(;;) {
    wait 0.5;
    updatereduceregendelayonobjective();
  }
}

function updatereduceregendelayonobjective(var_0) {
  var_1 = isDefined(self.carryobject);
  var_2 = isDefined(self.touchinggameobjects) && self.touchinggameobjects.size > 0;
  var_3 = isDefined(self.usinggameobjects) && self.usinggameobjects.size > 0;
  var_4 = var_1 || var_2 || var_3;

  if(var_4 && !istrue(var_0)) {
    if(!istrue(self.isonobjective)) {
      self.isonobjective = 1;
      scripts\mp\utility\perk::giveperk("specialty_regen_delay_reduced");
      return;
    }

    return;
  }

  if(istrue(self.isonobjective)) {
    self.isonobjective = 0;
    scripts\mp\utility\perk::removeperk("specialty_regen_delay_reduced");
    return;
  }
}

function setrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }

  self notify("setRechargeEquipment");
  level.perkrechargeequipmentplayers = scripts\engine\utility::array_add(level.perkrechargeequipmentplayers, self);
}

function unsetrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }

  level.perkrechargeequipmentplayers = scripts\engine\utility::array_remove(level.perkrechargeequipmentplayers, self);
  thread rechargeequipment_clearplayer(self);
}

function rechargeequipmentthink_init() {
  level.perkrechargeequipmentplayers = [];
  var_0 = int(ceil(0.5 / level.framedurationseconds));

  for(;;) {
    var_1 = level.perkrechargeequipmentplayers;
    var_2 = int(ceil(var_1.size / var_0));

    for(var_3 = 0; var_3 < var_0; var_3++) {
      for(var_4 = 0; var_4 < var_2; var_4++) {
        var_5 = var_3 * var_2 + var_4;

        if(var_5 > var_1.size) {
          break;
        }

        var_6 = var_1[var_5];

        if(!isDefined(var_6)) {
          continue;
        }

        if(!var_6 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_6.inlaststand) || istrue(self.stuckinlaststand)) {
          continue;
        }

        rechargeequipment_updatestate(var_6);
      }

      waitframe();
    }
  }
}

function rechargeequipment_updatestate(var_0) {
  if(!isDefined(var_0.rechargeequipmentstate)) {
    var_0.rechargeequipmentstate = spawnStruct();
    var_0.rechargeequipmentstate.progress = [];
    var_0.rechargeequipmentstate.recharged = [];
  }

  rechargeequipment_updateslot(var_0, "primary");
  rechargeequipment_updateslot(var_0, "secondary");
  rechargeequipment_updateui(var_0);
}

function rechargeequipment_updateslot(var_0, var_1) {
  var_2 = var_0.rechargeequipmentstate;

  if(!isDefined(var_2.progress[var_1])) {
    var_2.progress[var_1] = 0;
  }

  var_2.recharged[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::getcurrentequipment(var_1);

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = relic_squadlink_remove_visionset(var_3);
  var_5 = var_0 scripts\mp\equipment::getequipmentammo(var_3);
  var_6 = var_0 scripts\mp\equipment::getequipmentmaxammo(var_3);
  var_7 = var_0 scripts\mp\equipment::getequipmentstartammo(var_3);

  if(isDefined(level.playerzombiewaittillinputreturn)) {
    var_8 = level.playerzombiewaittillinputreturn;
  } else if(var_5 == "alt") {
    var_8 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "br", 0.00833333, 0.02);
  } else {
    var_8 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "br", 0.0166667, 0.02);
  }

  if(var_3 == "secondary" && var_7 < var_8 && var_8 > 1) {
    var_4.progress[var_3] += var_8 * 2;
  } else if(var_7 < var_8) {
    var_4.progress[var_3] += var_8;
  } else {
    var_4.progress[var_3] = 0;
  }

  if(var_4.progress[var_3] >= 1) {
    var_2 scripts\mp\equipment::incrementequipmentslotammo(var_3, 1);
    var_4.progress[var_3] = 0;
    var_4.recharged[var_3] = 1;
    return;
  }
}

function relic_squadlink_remove_visionset(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "equip_adrenaline":
      var_1 = "alt";
      break;
    default:
      var_1 = "normal";
      break;
  }

  return var_1;
}

function rechargeequipment_clearplayer(var_0) {
  var_0 endon("setRechargeEquipment");
  var_0 endon("disconnect");
  var_0.rechargeequipmentstate = undefined;
  waitframe();
  rechargeequipment_updateui(var_0);
}

function rechargeequipment_updateui(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0.rechargeequipmentstate)) {
    var_0 scripts\mp\utility\stats::initpersstat("restockCount");
    var_4 = var_0.rechargeequipmentstate;

    if(isDefined(var_4.progress["primary"])) {
      var_1 = var_4.progress["primary"];
    }

    if(isDefined(var_4.progress["secondary"])) {
      var_2 = var_4.progress["secondary"];
    }

    foreach(var_6 in var_4.recharged) {
      if(var_7 == "primary") {
        var_3 += 1;
        var_0 playlocalsound("ui_restock_lethals");
        var_0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(var_7 == "secondary") {
        var_3 += 2;
        var_0 playlocalsound("ui_restock_tactical");
        var_0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  var_0 setclientomnvar("ui_lethal_recharge_progress", var_1);
  var_0 setclientomnvar("ui_tactical_recharge_progress", var_2);
  var_0 setclientomnvar("ui_recharge_notify", var_3);
  var_0 clearladderstate("primary", var_1);
  var_0 clearladderstate("secondary", var_2);
}

function markequipment_monitorlook() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  jumpiftrue(isDefined(self.markequipmentstate)) LOC_0000007e;
  self.markequipmentstate = spawnStruct();
  self.markequipmentstate.markingtime = 0;
  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markedents = [];
  self.markequipmentstate.markedentindex = 0;
  self.markequipmentstate.pastmarkedents = [];
  self.markequipmentstate.pastmarkedentindex = 0;

  for(;;) {
    self waittill("marks_target_changed", var_0);
    var_1 = isDefined(var_0) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = var_0;
    self.markequipmentstate.markingtime = 0;

    if(var_1) {
      thread markequipment_updatestate();
    }
  }
}

function markequipment_updatestate() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  var_0 = gettime();
  var_1 = 0;

  if(self entityhasmark("air_killstreak", self.markequipmentstate.markingent)) {
    var_1 = getdvarint("perk_see_air_killstreak_distance");
  } else if(self entityhasmark("killstreak", self.markequipmentstate.markingent)) {
    var_1 = getdvarint("perk_see_killstreak_distance");
  } else if(self entityhasmark("equipment", self.markequipmentstate.markingent)) {
    var_1 = getdvarint("perk_see_equipment_distance");
  }

  var_2 = var_1 * var_1;

  while(isDefined(self.markequipmentstate.markingent) && !istrue(self.ishacking)) {
    if(self entitymarkfilteredin(self.markequipmentstate.markingent)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self.markequipmentstate.markingent) {
      break;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self)) {
      break;
    }

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > var_2) {
      break;
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    self.markequipmentstate.markingtime += var_4;

    if(!scripts\engine\utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(scripts\mp\utility\player::isplayerads()) {
        var_5 = self.markequipmentstate.markedentindex;
        var_6 = self.markequipmentstate.markedents[var_5];

        if(isDefined(var_6)) {
          var_6 filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(var_6);
        }

        if(level.teambased) {
          self.markequipmentstate.markingent filterinplayermarks(self.team);
        } else {
          self.markequipmentstate.markingent filterinplayermarks(self);
        }

        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self playlocalsound("iw8_mp_perk_tactical_recon_marked");

        if(level.teambased && _calloutmarkerping_predicted_timeout::ref_14126(self.markequipmentstate.markingent)) {
          self.markequipmentstate.markingent.ref_13ab2 = self.team;
          var_7 = scripts\mp\utility\player::getteamarray(self.markequipmentstate.markingent.ref_13ab2);

          foreach(var_9 in var_7) {
            _calloutmarkerping_predicted_timeout::ref_14132(self.markequipmentstate.markingent, var_9);
          }
        }

        self.markequipmentstate.markedents[var_5] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (var_5 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          scripts\mp\killstreaks\killstreaks::givescoreformarktarget(1);
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        } else {
          scripts\mp\killstreaks\killstreaks::givescoreformarktarget(0);
        }

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    var_0 = var_3;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

function unmarkafterduration(var_0) {
  level endon("game_ended");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  var_0 endon("death");
  var_1 = getdvarint("perk_mark_equipment_duration");
  scripts\engine\utility::ref_143bf(var_1, "disconnect");
  unmarkent(var_0);
}

function unmarkent(var_0) {
  var_0 filterinplayermarks(undefined);

  if(isDefined(var_0.ref_13ab2)) {
    if(level.teambased && _calloutmarkerping_predicted_timeout::ref_14126(var_0)) {
      var_1 = scripts\mp\utility\player::getteamarray(var_0.ref_13ab2);

      foreach(var_3 in var_1) {
        _calloutmarkerping_predicted_timeout::ref_14132(var_0, var_3);
      }
    }

    var_0.ref_13ab2 = undefined;
  }

  if(isDefined(self)) {
    self.markequipmentstate.markedents = scripts\engine\utility::array_remove(self.markequipmentstate.markedents, var_0);
    var_0 notify("unmarkEnt_" + self getentitynumber());
    return;
  }
}

function setmarkequipment() {
  if(!level.teambased) {
    return;
  }

  self enabletargetmarks();
  thread markequipment_monitorlook();
}

function unsetmarkequipment() {
  if(!level.teambased) {
    return;
  }

  if(isDefined(self.markequipmentstate)) {
    foreach(var_1 in self.markequipmentstate.markedents) {
      if(isDefined(var_1)) {
        unmarkent(var_1);
      }
    }
  }

  self.markequipmentstate = undefined;
  self disabletargetmarks();
  self notify("mark_equip_ended");
}

function getchildoutlineents(var_0) {
  if(!isDefined(var_0)) {
    return [];
  }

  if(!isDefined(var_0.childoutlineents)) {
    return [var_0];
  }

  return var_0.childoutlineents;
}

function outlinehelper_getallplayers(var_0, var_1) {
  return level.players;
}

function outlinehelper_validplayer(var_0) {
  return true;
}

function outlinehelper_verifydata(var_0) {
  if(!isDefined(var_0.getplayers)) {
    var_0.getplayers = &outlinehelper_getallplayers;
  }

  if(!isDefined(var_0.validplayer)) {
    var_0.validplayer = &outlinehelper_validplayer;
  }

  if(!isDefined(var_0.hudoutlineassetname)) {
    var_0.hudoutlineassetname = "spotter_notarget";
  }

  if(!isDefined(var_0.prioritygroup)) {
    var_0.prioritygroup = "perk";
  }

  if(!isDefined(var_0.waittime)) {
    var_0.waittime = 0.1;
    return;
  }
}

function outlinehelper_updateentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 getentitynumber();
    outlinehelper_disableentityoutline(var_1);
    outlinehelper_enableentityoutline(var_0);
    return;
  }
}

function outlinehelper_enableentityoutline(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0 getentitynumber();
  var_2 = self.entityoutlines[var_1];

  if(isDefined(var_2)) {
    return;
  }

  var_3 = undefined;

  if(self entitymarkfilteredin(var_0)) {
    var_3 = spawnStruct();
    var_3.prioritygroup = "perk_superior";
    var_3.hudoutlineassetname = "spotter_target";
    outlinehelper_verifydata(var_3);
  }

  var_4 = self entitymarkfilteredin(var_0);

  if(self entityhasmark("air_killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }

    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "perk_superior";
      var_3.hudoutlineassetname = "spotter_target_killstreak_air";
    } else {
      var_3.prioritygroup = "perk";
      var_3.hudoutlineassetname = "spotter_notarget_killstreak_air";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("killstreak", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }

    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "perk_superior";
      var_3.hudoutlineassetname = "spotter_target_killstreak";
    } else {
      var_3.prioritygroup = "perk";
      var_3.hudoutlineassetname = "spotter_notarget_killstreak";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("equipment", var_0)) {
    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "perk_superior";
      var_3.hudoutlineassetname = "spotter_target_equipment";
    } else {
      var_3.prioritygroup = "perk";
      var_3.hudoutlineassetname = "spotter_notarget_equipment";
    }

    outlinehelper_verifydata(var_3);
  }

  if(isDefined(var_3)) {
    var_2 = spawnStruct();
    self.entityoutlines[var_1] = var_2;
    var_2.list = [];
    var_2.ent = var_0;
    var_5 = getchildoutlineents(var_0);

    foreach(var_7 in var_5) {
      var_8 = scripts\mp\utility\outline::outlineenableforplayer(var_7, self, var_3.hudoutlineassetname, var_3.prioritygroup);
      var_9 = spawnStruct();
      var_9.ent = var_7;
      var_9.id = var_8;
      var_10 = var_7 getentitynumber();
      var_2.list[var_10] = var_9;
    }

    return;
  }
}

function outlinehelper_disableentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = self.entityoutlines[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1.list) {
        scripts\mp\utility\outline::outlinedisable(var_3.id, var_3.ent);
      }

      self.entityoutlines[var_0] = undefined;
      return;
    }

    return;
  }
}

function ref_11b0b(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_5 = var_4 getentitynumber();

    if(!scripts\engine\utility::array_contains(var_1, var_5)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function markedentities_think() {
  self endon("disconnect");
  level endon("game_ended");
  self.entityoutlines = [];

  for(;;) {
    self waittill("marks_changed", var_0, var_1, var_2);

    if(isDefined(var_0)) {
      foreach(var_4 in var_0) {
        outlinehelper_disableentityoutline(var_4);
      }

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = ref_11b0b(self.markequipmentstate.markedents, var_0);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size) {
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
        }
      }
    }

    if(isDefined(var_1)) {
      foreach(var_7 in var_1) {
        outlinehelper_disableentityoutline(var_7);
      }
    }

    if(isDefined(var_2)) {
      foreach(var_10 in var_2) {
        outlinehelper_enableentityoutline(var_10);
      }
    }
  }
}

function ref_1312c() {
  self notify("cancel_better_mission_rewards_unset");
  self.should_drop_scavenger_bag = 1;
  ref_14022(self.team);
  thread ks_airdroppercircle();
}

function ref_13f63() {}

function ks_airdroppercircle() {
  var_0 = self.team;
  var_1 = self.squadindex;
  self endon("cancel_better_mission_rewards_unset");
  scripts\engine\utility::ref_143a5("spawned_player", "disconnect");

  if(isDefined(self)) {
    self.should_drop_scavenger_bag = undefined;
  }

  ref_14022(var_0, var_1);
}

function ref_14022(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  var_2 = scripts\mp\gametypes\br_quest_util::rewardangles(var_0);

  if(!isDefined(level.clearlethalonunresolvedcollision)) {
    level.clearlethalonunresolvedcollision = [];
  }

  var_3 = 0;

  if(isDefined(level.clearlethalonunresolvedcollision[var_0])) {
    var_3 = level.clearlethalonunresolvedcollision[var_0];
  }

  var_4 = var_2 - var_3;

  if(var_4 != 0) {
    scripts\mp\gametypes\br_quest_util::battletracksmusicstate(var_0, var_4, var_1);
  }

  level.clearlethalonunresolvedcollision[var_0] = var_2;
}

function ref_131c2() {
  self clearvehicleturretstickers(1);

  if(scripts\mp\utility\game::getgametype() != "br") {
    self setclientomnvar("ui_specialist_bonus_active", 1);
    return;
  }
}

function ref_13f6e() {
  self clearvehicleturretstickers(0);

  if(scripts\mp\utility\game::getgametype() != "br") {
    self setclientomnvar("ui_specialist_bonus_active", 0);
    return;
  }
}

function ref_13199() {
  self.ref_12369 = spawnStruct();
  self.ref_12369.ref_13a72 = [];
  self.ref_12369.targetids = [];
  self.ref_12369.ref_12367 = [];
  self.ref_12369.instant_revived = 0;

  for(var_0 = 0; var_0 < 4; var_0++) {
    self.ref_12369.ref_12367[var_0] = -1;
  }
}

function maxmuncurrencycap(var_0) {
  if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
    return;
  }

  if(var_0.team == self.team) {
    return;
  }

  if(isDefined(self.ref_12369)) {
    ref_1236a(var_0);
    ref_1236b(var_0);
    var_0.ref_13a70 = 1;
    return;
  }
}

function ref_1236a(var_0) {
  var_1 = "hud_icon_head_marked";
  var_2 = 8;
  var_3 = 1;
  var_4 = 0;
  var_5 = 500;

  if(isDefined(var_0.ref_13a70)) {
    return;
  }

  var_6 = self.ref_12369.ref_13a72[var_0 getentitynumber()];

  if(!isDefined(var_6)) {
    self.ref_12369.ref_13a72[var_0 getentitynumber()] = var_0;
    var_6 = var_0;
    var_7 = self.ref_12369.instant_revived;
    self.ref_12369.instant_revived = (self.ref_12369.instant_revived + 1) % 4;

    if(isDefined(self.ref_12369.ref_13a72[self.ref_12369.ref_12367[var_7]])) {
      var_8 = self.ref_12369.ref_13a72[self.ref_12369.ref_12367[var_7]];
      self.ref_12369.ref_12367[var_7] = -1;
      thread ref_1236d(var_8, var_8);
      thread ref_12372(var_8);
    }

    self.ref_12369.ref_12367[var_7] = var_0 getentitynumber();
    var_9 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
    var_6.headicon = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_9, var_1, var_2, var_3, var_4, var_5, undefined, 1, 1);
    self playlocalsound("br_perk_advanced_scout_marking", self);
    scripts\mp\gametypes\br_public::ref_1276a("br_perk_advanced_scout_marking", self.team, var_0);
    thread ref_1236f(var_0, var_0);
    thread ref_12373(var_0);
    return;
  }
}

function ref_1236b(var_0) {
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_0, self, "outlinefill_nodepth_orange", "perk");
  var_0 scripts\mp\utility\outline::_hudoutlineviewmodelenable("snapshotgrenade", 0);

  if(!isDefined(var_0.ref_13a70)) {
    var_0 playlocalsound("br_perk_advanced_scout_marked_plr");
  }

  thread ref_12371(var_0, var_1);
}

function ref_1236f(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = var_0 getentitynumber();
  var_0 endon("removeHeadIcon_" + var_2);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 3);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1);
}

function ref_12373(var_0) {
  self endon("disconnect");
  self endon("pingOnDamageDeactivate");
  var_1 = var_0 getentitynumber();
  self endon("removeEntNum_" + var_1);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 3);

  if(isDefined(self.ref_12369) && isDefined(self.ref_12369.ref_13a72)) {
    var_2 = self.ref_12369.ref_13a72[var_1];

    if(isDefined(var_2)) {
      var_0.ref_13a70 = undefined;
      self.ref_12369.ref_13a72[var_1] = undefined;
    }
  }

  foreach(var_4 in self.ref_12369.ref_12367) {
    if(var_4 == var_1) {
      self.ref_12369.ref_12367[var_5] = -1;
      return;
    }
  }
}

function ref_1236d(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = var_0 getentitynumber();
  var_0 notify("removeHeadIcon_" + var_2);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1);
}

function ref_12372(var_0) {
  self endon("disconnect");
  self endon("pingOnDamageDeactivate");
  var_1 = var_0 getentitynumber();
  self notify("removeEntNum_" + var_1);

  if(isDefined(self.ref_12369) && isDefined(self.ref_12369.ref_13a72)) {
    var_2 = self.ref_12369.ref_13a72[var_1];

    if(isDefined(var_2)) {
      var_0.ref_13a70 = undefined;
      self.ref_12369.ref_13a72[var_1] = undefined;
      return;
    }

    return;
  }
}

function ref_12371(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 scripts\engine\utility::waittill_notify_or_timeout("death", 0.6);
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
  var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

function ref_12374() {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(self.ref_11b14)) {
    return;
  }

  self.ref_11b14 = 1;
  self iprintlnbold(&"KILLSTREAKS_HINTS/RECON_NO_MARK");
  self playlocalsound("br_perk_advanced_scout_marking_resist_plr", self);
  wait 1;
  self.ref_11b14 = undefined;
}

function ref_13f69() {
  if(isDefined(self.ref_12369.ref_13a72) && self.ref_12369.ref_13a72.size > 0) {
    foreach(var_1 in self.ref_12369.ref_13a72) {
      if(isDefined(var_1)) {
        thread ref_12372(var_1);
      }
    }
  }

  self.ref_12369 = undefined;
  self notify("pingOnDamageDeactivate");
}

function ref_121b7(var_0) {
  var_1 = scripts\mp\gametypes\br_public::round_at_max(self.team, self.squadindex, "ui_squad_reinforced_perk");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(self.pers["squadMemberIndex"]), self.pers["squadMemberIndex"] - 1, 0);
  var_3 = 1 << var_2;
  var_4 = scripts\engine\utility::ter_op(istrue(var_0), var_1 | var_3, var_1 ^ var_3);
  scripts\mp\gametypes\br_public::ref_131c3(self.team, self.squadindex, "ui_squad_reinforced_perk", var_4);
  var_5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_7 in var_5) {
    var_7 setclientomnvar("ui_squad_reinforced_perk", var_4);
  }
}

function ref_13928() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  if(!self isonground()) {
    self waittill("victim_was_damaged");

    if(istrue(self.instantclassswapallowed)) {
      scripts\mp\class::disableclassswapallowed();
      return;
    }

    return;
  }
}

function ref_131c5() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
    return;
  }

  thread ref_13928();
  scripts\mp\gametypes\br_armor::searchcirclesize(1);
  ref_121b7(1);
}

function ref_13f6f() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
    return;
  }

  if(istrue(self.instantclassswapallowed)) {
    scripts\mp\gametypes\br_armor::searchcirclesize(0);
  }

  ref_121b7(0);
}

function ref_13716() {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(self.ref_11b14)) {
    return;
  }

  self.ref_11b14 = 1;
  self playlocalsound("br_perk_advanced_scout_marking_resist_plr", self);
  wait 1;
  self.ref_11b14 = undefined;
}