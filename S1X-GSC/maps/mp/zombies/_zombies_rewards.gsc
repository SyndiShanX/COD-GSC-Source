/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_rewards.gsc
************************************************/

init() {
  level.zombie_rewards = [];
  level thread setuprewardlist();
  thread debug_setuppenalty();
  level thread civrescuethink();
}

civrescuethink() {
  level.civrescueseq = 0;
  level.civfailedescorts = 0;

  for(;;) {
    var_0 = level common_scripts\utility::waittill_any_return("extraction_complete", "extraction_failed");

    if(var_0 == "extraction_complete") {
      level.civrescueseq++;
      level thread civrescuesuccess();
      continue;
    }

    if(level.civrescueseq > 0) {
      level.civrescueseq--;
    }

    level thread civrescuefail();
  }
}

civrescuesuccess() {
  level waittill("zombie_wave_ended");
  wait 1.0;

  if(level.civrescueseq >= 3 && level.civrescueseq <= 4) {
    var_0 = "silver";
  } else if(level.civrescueseq >= 5) {
    var_0 = "gold";
  } else {
    var_0 = "bronze";
  }

  thread civrescuesuccessreward(var_0);
}

civrescuesuccessreward(var_0) {
  if(var_0 == "silver") {
    iprintlnbold(&"ZOMBIE_CIVILIANS_SUCCESS_SILVER_END_ROUND");
  } else if(var_0 == "gold") {
    iprintlnbold(&"ZOMBIE_CIVILIANS_SUCCESS_GOLD_END_ROUND");
  } else {
    iprintlnbold(&"ZOMBIE_CIVILIANS_SUCCESS_END_ROUND");
  }

  foreach(var_2 in level.players) {
    var_2 thread reward_countdowntimer();
  }

  level waittill("timer_countdown_complete");
  reward_enablebyclass(var_0);
}

setuprewardlist() {
  var_0 = ["bronze_money", "silver_money", "gold_money", "refill_ammo", "refill_grenades", "single_grenade", "droppod_single", "droppod_cluster", "atm_all_on", "weapon_upgrade", "fire_sale_activate", "solo_extra_revive"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level.zombie_rewards[var_1] = spawnStruct();
    level.zombie_rewards[var_1].rewardname = var_0[var_1];
    level.zombie_rewards[var_1].lastwavegiven = 0;
    level.zombie_rewards[var_1].specialfunc = undefined;
  }

  setrewardspecialfunction("bronze_money", ::reward_givemoney, "reward_bronze");
  setrewardspecialfunction("silver_money", ::reward_givemoney, "reward_silver");
  setrewardspecialfunction("gold_money", ::reward_givemoney, "reward_gold");
  setrewardspecialfunction("refill_ammo", ::reward_ammorefill);
  setrewardspecialfunction("single_grenade", ::reward_singlegrenade);
  setrewardspecialfunction("refill_grenades", ::reward_grenaderefill);
  setrewardspecialfunction("droppod_single", ::reward_orbitaldropsingle);
  setrewardspecialfunction("droppod_cluster", ::reward_orbitaldropcluster);
  setrewardspecialfunction("weapon_upgrade", ::reward_weaponupgrade);
  setrewardspecialfunction("solo_extra_revive", ::reward_soloextrarevive);
  thread debug_setupallrewards();
}

setrewardspecialfunction(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getrewardbyname(var_0);
  var_5.specialfunc = var_1;

  if(isDefined(var_2)) {
    var_5.funcparm1 = var_2;
  }

  if(isDefined(var_3)) {
    var_5.funcparm2 = var_3;
  }

  if(isDefined(var_4)) {
    var_5.funcparm3 = var_4;
  }
}

getrewardbyname(var_0) {
  foreach(var_2 in level.zombie_rewards) {
    if(var_2.rewardname == var_0) {
      return var_2;
    }
  }

  return undefined;
}

reward_enablebyclass(var_0) {
  switch (var_0) {
    case "bronze":
      thread reward_enable("weapon_upgrade");
      break;
    case "silver":
      thread reward_enable("weapon_upgrade");
      thread reward_enable("single_grenade");
      thread reward_enable("droppod_single");
      thread reward_enable("refill_ammo");
      break;
    case "gold":
      thread reward_enable("weapon_upgrade");
      thread reward_enable("refill_grenades");
      thread reward_enable("droppod_cluster");
      thread reward_enable("refill_ammo");
      break;
    default:
      break;
  }
}

reward_enable(var_0) {
  var_1 = getrewardbyname(var_0);

  if(isDefined(var_1.specialfunc)) {
    var_1 thread callspecialrewardfunction();
  }
}

callspecialrewardfunction() {
  var_0 = self;

  if(!isDefined(var_0.funcparm1)) {
    var_0 thread[[var_0.specialfunc]]();
    return;
  }

  if(!isDefined(var_0.funcparm2)) {
    var_0 thread[[var_0.specialfunc]](var_0.funcparm1);
    return;
  }

  if(!isDefined(var_0.funcparm3)) {
    var_0 thread[[var_0.specialfunc]](var_0.funcparm1, var_0.funcparm2);
    return;
  }

  var_0 thread[[var_0.specialfunc]](var_0.funcparm1, var_0.funcparm2, var_0.funcparm3);
}

rewardlastwavegiven() {
  var_0 = 0;

  if(level.wavecounter - self.lastwavegiven <= 3) {
    var_0 = self.lastwavegiven;
  }

  return var_0;
}

reward_givemoney(var_0) {
  wait 3.0;

  foreach(var_2 in level.players) {
    var_2 maps\mp\gametypes\zombies::givepointsforevent(var_0, undefined, 1);
  }
}

reward_ammorefill() {
  level thread maps\mp\gametypes\zombies::activatemaxammo();
}

reward_singlegrenade() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getlethalweapon();
    var_3 = var_1 gettacticalweapon();
    var_4 = [var_2, var_3];

    foreach(var_6 in var_4) {
      if(var_6 == "none") {
        continue;
      }
      var_1 setweaponammoclip(var_6, var_1 getweaponammoclip(var_6) + 1);
    }
  }
}

reward_grenaderefill() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getlethalweapon();
    var_3 = var_1 gettacticalweapon();
    var_4 = [var_2, var_3];

    foreach(var_6 in var_4) {
      if(var_6 == "none") {
        continue;
      }
      var_7 = weaponclipsize(var_6);
      var_1 setweaponammoclip(var_6, var_7);
    }
  }
}

reward_orbitaldropsingle() {
  level.orbitaldropupgrade = 1;
  thread maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage();
  wait 10.0;
  level.orbitaldropupgrade = 0;
}

reward_orbitaldropcluster() {
  level.orbitaldropupgrade = 1;
  var_0 = randomintrange(2, 3);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    thread maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage();
    wait(randomfloatrange(1.0, 3.0));
  }

  wait 10.0;
  level.orbitaldropupgrade = 0;
}

reward_weaponupgrade() {
  foreach(var_1 in level.players) {
    var_1 thread reward_weaponupgradethink();
  }
}

reward_weaponupgradethink() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.inlaststand) && self.inlaststand == 1) {
    while(self.inlaststand == 1) {
      wait 0.1;
    }
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    while(self.iscarrying == 1) {
      wait 0.1;
    }
  }

  if(isDefined(self.hasbomb) && self.hasbomb == 1) {
    while(self.hasbomb == 1) {
      wait 0.1;
    }
  }

  var_0 = maps\mp\zombies\_util::getplayerweaponzombies(self);
  var_1 = getweaponbasename(var_0);

  if(!maps\mp\zombies\_util::haszombieweaponstate(self, var_1)) {
    return;
  }
  if(self.weaponstate[var_1]["level"] < 20) {
    maps\mp\zombies\_wall_buys::setweaponlevel(self, var_0, self.weaponstate[var_1]["level"] + 1);
  } else if(self.weaponstate[var_1]["level"] == 20) {
    maps\mp\zombies\_wall_buys::setweaponlevel(self, var_0, 25);
  } else {
    return;
  }

  thread maps\mp\zombies\_zombies_audio::playerweaponupgrade(0, self.weaponstate[var_1]["level"]);
  self.numupgrades++;
}

reward_soloextrarevive() {
  if(level.players.size < 2) {
    var_0 = level.terminalitems["exo_revive"];
    var_0.maxbuyssolo++;

    foreach(var_2 in level.players) {
      if(!isDefined(var_2.isexostimactive) || isDefined(var_2.isexostimactive) && var_2.isexostimactive == 0) {
        var_2.isexostimactive = 1;
      }
    }
  }
}

reward_countdowntimer() {
  self endon("disconnect");
  var_0 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, 185);
  var_0 settext(&"ZOMBIE_CIVILIANS_INCOMING_UPGRADE");
  var_0.fontscale = 0.65;
  var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, 205);
  var_1 thread update_countdown();
  var_1.fontscale = 1;
  level common_scripts\utility::waittill_any("timer_countdown_complete");
  var_1 maps\mp\gametypes\_hud_util::destroyelem();
  var_0 maps\mp\gametypes\_hud_util::destroyelem();
}

update_countdown() {
  self endon("disconnect");

  for(var_0 = 0; var_0 < 5; var_0++) {
    var_1 = undefined;

    switch (5 - var_0) {
      case 5:
        var_1 = &"ZOMBIE_CIVILIANS_5";
        break;
      case 4:
        var_1 = &"ZOMBIE_CIVILIANS_4";
        break;
      case 3:
        var_1 = &"ZOMBIE_CIVILIANS_3";
        break;
      case 2:
        var_1 = &"ZOMBIE_CIVILIANS_2";
        break;
      case 1:
        var_1 = &"ZOMBIE_CIVILIANS_1";
        break;
    }

    self settext(var_1);
    playsoundatpos((0, 0, 0), "zmb_weapon_upgrade_countdown");
    wait 1;
  }

  level notify("timer_countdown_complete");
}

civrescuefail() {
  wait 3;
  level.civfailedescorts++;
  thread penalty_powergenerators();
  thread penalty_magicbox();
  thread penalty_traps();
  thread penalty_wallbuys();
  thread penalty_weaponupgrades();
  maps\mp\_utility::gameflagset("power_off");
  var_0 = civfailduration();
  showteamsplashzombies("zombie_power_down");
  wait 3;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.exosuitonline) && var_2.exosuitonline) {
      var_2 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
    }
  }

  setomnvar("ui_zm_powerdown", gettime() + var_0 * 1000);
  wait(var_0);
  maps\mp\_utility::gameflagclear("power_off");
  level notify("restore_power");
  iprintlnbold(&"ZOMBIE_CIVILIANS_POWER_RESTORED");
}

civfailduration() {
  if(level.civfailedescorts == 1) {
    return 60;
  } else if(level.civfailedescorts == 2) {
    return 120;
  } else if(level.civfailedescorts >= 3) {
    return 180;
  }
}

showteamsplashzombies(var_0) {
  foreach(var_2 in level.players) {
    if(maps\mp\zombies\_util::isonhumanteam(var_2) && maps\mp\_utility::isreallyalive(var_2)) {
      var_2 thread maps\mp\gametypes\_hud_message::splashnotify(var_0);
    }
  }
}

penalty_weaponupgrades() {
  foreach(var_1 in level.weaponlevelboxes) {
    maps\mp\zombies\_wall_buys::weaponlevelboxdisable(var_1);
  }

  level waittill("restore_power");

  foreach(var_1 in level.weaponlevelboxes) {
    maps\mp\zombies\_wall_buys::weaponlevelboxenable(var_1);
  }
}

penalty_wallbuys() {
  var_0 = getEntArray("wallbuy", "targetname");

  foreach(var_2 in var_0) {
    maps\mp\zombies\_wall_buys::wallbuydisable(var_2);
  }

  level waittill("restore_power");

  foreach(var_2 in var_0) {
    maps\mp\zombies\_wall_buys::wallbuyenable(var_2);
  }
}

penalty_powergenerators() {
  level.poweroffpenalty = 1;
  level notify("zombie_power_penalty_start");

  foreach(var_1 in level.power_switches) {
    var_1 thread poweroffpenaltyhint();
  }

  level waittill("restore_power");
  level notify("zombie_power_penalty_end");
  level.poweroffpenalty = undefined;
}

poweroffpenaltyhint() {
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring(&"ZOMBIE_CIVILIANS_POWER_OFF_TRIGGER");
  level waittill("zombie_power_penalty_end");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring(&"ZOMBIES_POWER_ON");
}

penalty_magicbox() {
  foreach(var_1 in level.magicboxlocations) {
    if(var_1.active == 0) {
      continue;
    }
    var_1 thread magicboxdisablepenaltythink();
  }
}

magicboxdisablepenaltythink() {
  level endon("game_ended");
  maps\mp\zombies\_wall_buys::deactivatemagicbox();
  level waittill("restore_power");
  maps\mp\zombies\_wall_buys::reactivatemagicbox();
}

penalty_pickups() {
  level.nopickuppenalty = 1;
  level waittill("restore_power");
  level.nopickuppenalty = 0;
}

penalty_droppods() {
  level.nodroppodpenalty = 1;

  if(isDefined(level.carepackages)) {
    foreach(var_1 in level.carepackages) {
      var_1 maps\mp\killstreaks\_airdrop::deletecrate(1);
    }
  }

  level waittill("restore_power");
  level.nodroppodpenalty = undefined;
}

penalty_traps() {
  foreach(var_1 in level.traps) {
    var_1 thread trapdisablepenaltythink();
  }
}

trapdisablepenaltythink() {
  level endon("game_ended");
  var_0 = self;
  var_0 maps\mp\zombies\_traps::trap_deactivate();
  level waittill("restore_power");
  var_0 maps\mp\zombies\_traps::trap_reactivate();
}

debug_setupallrewards() {
  var_0 = [];
  var_0[0] = "bronze_class";
  var_0[1] = "silver_class";
  var_0[2] = "gold_class";

  foreach(var_2 in var_0) {
    thread debug_setupreward(var_2);
  }
}

debug_setupreward(var_0) {
  var_1 = "scr_reward_" + var_0;
  var_2 = "devgui_cmd \"Zombie:2/Toggle Civ Rewards/" + var_0 + "\" \"togglep " + var_1 + " 0 1\";";

  for(;;) {
    while(getdvarint(var_1, 0) == 0) {
      waitframe();
    }

    if(var_0 == "bronze_class") {
      thread civrescuesuccessreward("bronze");
      continue;
    }

    if(var_0 == "silver_class") {
      thread civrescuesuccessreward("silver");
      continue;
    }

    if(var_0 == "gold_class") {
      thread civrescuesuccessreward("gold");
      continue;
    }

    thread reward_enable(var_0);
  }
}

debug_setuppenalty() {
  var_0 = "scr_rescue_civ_penalty";
  var_1 = "devgui_cmd \"Zombie:2/Toggle Civ Penalty\" \"togglep " + var_0 + " 0 1\";";

  for(;;) {
    while(getdvarint(var_0, 0) == 0) {
      waitframe();
    }

    thread civrescuefail();
  }
}