/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_terminals.gsc
******************************************/

init() {
  precacheterminalfx();
  level.terminalitems = [];
  var_0 = initterminalitem("exo_suit", &"ZOMBIES_EXO_SUIT", &"ZOMBIES_BUY_EXO_SUIT", 0, 0, "ui_zm_exo_suit");
  var_0 setteminalfx("station_buy_exo_pwr_on", "station_buy_exo_pwr_off");
  var_0 = initterminalitem("exo_health", &"ZOMBIES_PERK_HEALTH", &"ZOMBIES_BUY_PERK_HEALTH", 2500, 1, "ui_zm_exo_health");
  var_0 setteminalfx("station_upgrade_exo_health_pwr_on", "station_upgrade_exo_health_pwr_off");
  var_0 = initterminalitem("specialty_fastreload", &"ZOMBIES_PERK_RELOAD", &"ZOMBIES_BUY_PERK_RELOAD", 2000, 1, "ui_zm_exo_reload");
  var_0 setteminalfx("station_upgrade_exo_reload_pwr_on", "station_upgrade_exo_reload_pwr_off");

  if(!maps\mp\zombies\_util::iszombieshardmode()) {
    var_0 = initterminalitem("exo_revive", &"ZOMBIES_PERK_REVIVE", &"ZOMBIES_BUY_PERK_REVIVE", 1500, 1, "ui_zm_exo_revive");
    var_0 setsolooverrides(500, 0, 3);
    var_0 setteminalfx("station_upgrade_exo_revive_pwr_on", "station_upgrade_exo_revive_pwr_off");
  }

  var_0 = initterminalitem("exo_stabilizer", &"ZOMBIES_PERK_STABILIZER", &"ZOMBIES_BUY_PERK_STABILIZER", 1750, 1, "ui_zm_exo_stabilizer");
  var_0 setteminalfx("station_upgrade_exo_stabilizer_pwr_on", "station_upgrade_exo_stabilizer_pwr_off");
  var_0 = initterminalitem("exo_slam", &"ZOMBIES_PERK_SLAM", &"ZOMBIES_BUY_PERK_SLAM", 2000, 1, "ui_zm_exo_slam");
  var_0 setteminalfx("station_upgrade_exo_slam_pwr_on", "station_upgrade_exo_slam_pwr_off");
  var_0 = initterminalitem("exo_tacticalArmor", &"ZOMBIES_PERK_TACTICALARMOR", &"ZOMBIES_BUY_PERK_TACTICALARMOR", 2000, 1, "ui_zm_exo_tacticalarmor");
  var_0 setteminalfx("station_upgrade_exo_tactarmor_pwr_on", "station_upgrade_exo_tactarmor_pwr_off");
  initterminalitem("host_cure", &"ZOMBIES_HOST_CURE", &"ZOMBIES_BUY_HOST_CURE", 250, 0);
  initterminalitem("atm", &"ZOMBIES_MONEY", &"ZOMBIES_BUY_MONEY", 0, 0);
  level.hostcuremodels = [];
  level.terminals = [];
  initterminals("perk_terminal", ::perkterminaltriggerthink);
  initterminals("exo_terminal", ::perkterminaltriggerthink);
  initterminals("atm_terminal", ::atmterminalthink, ::atmterminalroundupdate);

  if(!maps\mp\zombies\_util::iszombieshardmode() && isDefined(level.terminals["exo_revive"])) {
    var_1 = level.terminals["exo_revive"];

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      for(var_3 = var_2 + 1; var_3 < var_1.size; var_3++) {
        if(isDefined(var_1[var_2].script_index) && isDefined(var_1[var_3].script_index) && var_1[var_2].script_index == var_1[var_3].script_index) {
          var_1[var_2].linkedterminal = var_1[var_3];
          var_1[var_3].linkedterminal = var_1[var_2];
        }
      }
    }
  }

  precacheterminalanims();
  level thread playercountwatch();
}

onplayerspawn() {
  self.zm_perks = [];
  maps\mp\_utility::playerallowhighjumpdrop(0, "exoSlam");
  self setclientomnvar("ui_zm_exo_slam_next_time", 0);

  foreach(var_1 in level.terminalitems) {
    if(isDefined(var_1.omnvar)) {
      self setclientomnvar(var_1.omnvar, 0);
    }
  }

  perkupdatesortorder();
}

playercountwatch() {
  for(;;) {
    var_0 = level.players.size;

    while(var_0 == level.players.size) {
      waitframe();
    }

    level notify("playerCountUpdate");
  }
}

precacheterminalanims() {
  if(getiteminmap("host_cure")) {
    precachempanim("xom_host_cure_station_start");
    precachempanim("xom_host_cure_station_loop");
    precachempanim("xom_host_cure_station_stop");
  }
}

precacheterminalfx() {
  level._effect["zombie_exo_slam"] = loadfx("vfx/gameplay/mp/zombie/dlc_exo_slam_impact");
  level._effect["zombie_host_cure"] = loadfx("vfx/props/dlc_prop_health_station_cure");
  level._effect["zombie_host_cure_idle"] = loadfx("vfx/props/dlc_prop_health_station_idle");
  level._effect["zombie_host_cure_cooldown"] = loadfx("vfx/props/dlc_prop_health_station_cooldown");
  level._effect["exo_equip"] = loadfx("vfx/props/dlc_prop_exo_buy_fx_character");
  level._effect["atm_jackpot"] = loadfx("vfx/props/dlc_prop_cashbox_cash_shooter");
}

initterminalitem(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.name = var_0;
  var_6.locname = var_1;
  var_6.locbuyname = var_2;
  var_6.cost = var_3;
  var_6.requiresexo = var_4;
  var_6.inmap = 0;
  var_6.omnvar = var_5;
  var_6.numbuys = 0;
  var_6.maxbuys = -1;
  level.terminalitems[var_0] = var_6;
  return var_6;
}

setsolooverrides(var_0, var_1, var_2) {
  self.costsolo = var_0;
  self.requiresexosolo = var_1;
  self.maxbuyssolo = var_2;
}

setteminalfx(var_0, var_1) {
  self.onfx = common_scripts\utility::getfx(var_0);
  self.offfx = common_scripts\utility::getfx(var_1);
}

hasexosuit() {
  return isDefined(self.exosuitonline) && self.exosuitonline;
}

getitemlocname(var_0) {
  return level.terminalitems[var_0].locname;
}

getitemlocbuy(var_0) {
  return level.terminalitems[var_0].locbuyname;
}

getitemcostsolo(var_0) {
  var_1 = level.terminalitems[var_0].costsolo;

  if(isDefined(level.penaltycostincrease)) {
    for(var_2 = 0; var_2 < level.penaltycostincrease; var_2++) {
      var_3 = maps\mp\zombies\_util::getincreasedcost(var_1);
      var_1 = var_3;
    }
  }

  return var_1;
}

getitemcost(var_0) {
  if(isDefined(level.terminalitems[var_0].costsolo) && level.players.size == 1) {
    return getitemcostsolo(var_0);
  }

  var_1 = level.terminalitems[var_0].cost;

  if(isDefined(level.penaltycostincrease)) {
    for(var_2 = 0; var_2 < level.penaltycostincrease; var_2++) {
      var_3 = maps\mp\zombies\_util::getincreasedcost(var_1);
      var_1 = var_3;
    }
  }

  return var_1;
}

getitemrequiresexo(var_0) {
  if(isDefined(level.terminalitems[var_0].requiresexosolo) && level.players.size == 1) {
    return level.terminalitems[var_0].requiresexosolo;
  }

  return level.terminalitems[var_0].requiresexo;
}

getitemloccost(var_0) {
  return maps\mp\zombies\_util::getcoststring(getitemcost(var_0));
}

getiteminmap(var_0) {
  return level.terminalitems[var_0].inmap;
}

getitemomnvar(var_0) {
  return level.terminalitems[var_0].omnvar;
}

getitemnumbuys(var_0) {
  return level.terminalitems[var_0].numbuys;
}

getitemmaxsolobuys(var_0) {
  return level.terminalitems[var_0].maxbuyssolo;
}

getitemmaxbuys(var_0) {
  if(isDefined(level.terminalitems[var_0].maxbuyssolo) && level.players.size == 1) {
    return level.terminalitems[var_0].maxbuyssolo;
  }

  return level.terminalitems[var_0].maxbuys;
}

setiteminmap(var_0) {
  level.terminalitems[var_0].inmap = 1;
}

setitemusecount(var_0, var_1) {
  level.terminalitems[var_0].numbuys = var_1;
}

itemhasuses(var_0) {
  var_1 = getitemmaxbuys(var_0);
  return var_1 < 0 || var_1 > getitemnumbuys(var_0);
}

getitemtype() {
  if(isDefined(self.script_parameters)) {
    return self.script_parameters;
  }

  switch (self.targetname) {
    case "exo_terminal":
      return "exo_suit";
    default:
      return "none";
  }
}

getterminaltrigger() {
  switch (self.itemtype) {
    case "atm":
      return getent(self.target, "targetname");
    default:
      return self;
  }
}

getterminalmodel() {
  switch (self.itemtype) {
    case "host_cure":
      return undefined;
    case "exo_tacticalArmor":
    case "exo_slam":
    case "exo_stabilizer":
    case "exo_revive":
    case "specialty_fastreload":
    case "exo_suit":
    case "exo_health":
      return getent(self.target, "targetname");
    default:
      return self;
  }
}

getterminallight() {
  switch (self.itemtype) {
    case "exo_tacticalArmor":
    case "exo_slam":
    case "exo_stabilizer":
    case "exo_revive":
    case "specialty_fastreload":
    case "exo_suit":
    case "exo_health":
      var_0 = getent(self.target, "targetname");

      if(isDefined(var_0) && isDefined(var_0.target)) {
        return getent(var_0.target, "targetname");
      }
    default:
      break;
  }
}

getterminalhintstring(var_0) {
  var_1 = terminal_has_power();
  var_2 = 0;
  var_3 = itemhasuses(self.itemtype);
  var_4 = maps\mp\zombies\_util::is_true(self.terminaldisabled);

  if(var_4) {
    return "";
  }

  var_5 = self.itemtype == "exo_suit";

  if(isDefined(var_0)) {
    var_2 = var_0 perkterminalhasexosuit("exo_suit") || !getitemrequiresexo(self.itemtype) && !var_5;

    if(self.itemtype != "host_cure" && !var_5) {
      if(!var_3) {
        return &"ZOMBIES_ALL_USED";
      } else if(!var_2) {
        return &"ZOMBIES_REQUIRES_EXO";
      } else if(!var_1) {
        return &"ZOMBIES_REQUIRES_POWER";
      }
    }
  }

  switch (self.itemtype) {
    case "exo_slam":
      if(!var_0 perkterminalhasexoslam(self.itemtype)) {
        return getitemlocbuy(self.itemtype);
      }

      break;
    case "exo_health":
      if(!var_0 perkterminalhasexohealth(self.itemtype)) {
        return getitemlocbuy(self.itemtype);
      }

      break;
    case "exo_revive":
      if(!var_0 perkterminalhasexorevive(self.itemtype)) {
        return getitemlocbuy(self.itemtype);
      }

      break;
    case "exo_stabilizer":
      if(!var_0 perkterminalhasexostabilizer(self.itemtype)) {
        return getitemlocbuy(self.itemtype);
      }

      break;
    case "specialty_fastreload":
      if(!var_0 perkterminalhas(self.itemtype)) {
        return getitemlocbuy(self.itemtype);
      }

      break;
    case "exo_tacticalArmor":
      if(!var_0 perkterminalhasexotacticalarmor(self.itemtype)) {
        return getitemlocbuy(self.itemtype);
      }

      break;
    case "host_cure":
      if(!var_1) {
        return &"ZOMBIES_REQUIRES_POWER";
      } else if(perkterminalcoolingdown()) {
        return &"ZOMBIES_CURE_COOLDOWN_HINT";
      } else if(maps\mp\zombies\_util::is_true(self.terminalrunning)) {
        return &"ZOMBIES_CURE_ACTIVE_HINT";
      } else {
        return getitemlocbuy(self.itemtype);
      }

      break;
    case "exo_suit":
      if(!var_1) {
        return &"ZOMBIES_REQUIRES_POWER";
      } else if(!var_2) {
        return getitemlocbuy(self.itemtype);
      }

      break;
    default:
      break;
  }

  return "";
}

getterminalsecondaryhintstring(var_0) {
  var_1 = terminal_has_power();
  var_2 = 0;
  var_3 = itemhasuses(self.itemtype);
  var_4 = maps\mp\zombies\_util::is_true(self.terminaldisabled);
  self.showtokenstring = 0;

  if(var_4) {
    return "";
  }

  var_5 = self.itemtype == "exo_suit";

  if(isDefined(var_0)) {
    var_2 = var_0 perkterminalhasexosuit("exo_suit") || !getitemrequiresexo(self.itemtype) && !var_5;

    if(self.itemtype != "host_cure" && !var_5) {
      if(!var_3) {
        return "";
      } else if(!var_1 && !var_2) {
        return &"ZOMBIES_REQUIRES_POWER";
      } else if(!var_2 || !var_1) {
        return "";
      }
    }
  }

  switch (self.itemtype) {
    case "exo_slam":
      if(level.currentgen && var_0 perkterminalhasexoslam(self.itemtype)) {
        return "";
      }

      self.showtokenstring = getitemcost(self.itemtype) > 0;
      return getitemloccost(self.itemtype);
    case "exo_health":
      if(level.currentgen && var_0 perkterminalhasexohealth(self.itemtype)) {
        return "";
      }

      self.showtokenstring = getitemcost(self.itemtype) > 0;
      return getitemloccost(self.itemtype);
    case "exo_revive":
      if(level.currentgen && var_0 perkterminalhasexorevive(self.itemtype)) {
        return "";
      }

      self.showtokenstring = getitemcost(self.itemtype) > 0;
      return getitemloccost(self.itemtype);
    case "exo_stabilizer":
      if(level.currentgen && var_0 perkterminalhasexostabilizer(self.itemtype)) {
        return "";
      }

      self.showtokenstring = getitemcost(self.itemtype) > 0;
      return getitemloccost(self.itemtype);
    case "specialty_fastreload":
      if(level.currentgen && var_0 perkterminalhasexofastreload(self.itemtype)) {
        return "";
      }

      self.showtokenstring = getitemcost(self.itemtype) > 0;
      return getitemloccost(self.itemtype);
    case "exo_tacticalArmor":
      if(level.currentgen && var_0 perkterminalhasexotacticalarmor(self.itemtype)) {
        return "";
      }

      self.showtokenstring = getitemcost(self.itemtype) > 0;
      return getitemloccost(self.itemtype);
    case "host_cure":
      if(var_1 && !(perkterminalcoolingdown() || maps\mp\zombies\_util::is_true(self.terminalrunning))) {
        self.showtokenstring = getitemcost(self.itemtype) > 0;
        return getitemloccost(self.itemtype);
      }

      break;
    case "exo_suit":
      self.showtokenstring = getitemcost(self.itemtype) > 0;
    default:
      break;
  }

  return "";
}

terminalhintstringupdate(var_0) {
  var_0 endon("disconnect");
  thread terminalupdatehintstringonconnect(var_0);
  thread terminalupdatehintstringondisconnect(var_0);
  thread terminalupdatehintstringpower(var_0);

  for(;;) {
    waittillframeend;
    var_1 = getterminalhintstring(var_0);
    self sethintstring(var_1);
    var_2 = getterminalsecondaryhintstring(var_0);
    self setsecondaryhintstring(var_2);
    maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(getitemcost(self.itemtype)));
    maps\mp\zombies\_util::tokenhintstring(self.showtokenstring);
    self setcursorhint("HINT_NOICON");
    var_0 common_scripts\utility::waittill_any("terminal_activated", "terminalPlayerConnected", "terminalPlayerDisconnected", "terminalPowerActivated", "player_infected", "take_perk");
  }
}

cg_onplayerconnectedterminalhintstringupdate(var_0) {
  var_0 endon("death");

  for(;;) {
    level waittill("connected", var_1);
    var_0 thread cg_terminalhintstringupdate(var_1);
  }
}

cg_terminalhintstringupdate(var_0) {
  var_0 endon("disconnect");
  thread terminalupdatehintstringonconnect(var_0);
  thread terminalupdatehintstringondisconnect(var_0);
  thread terminalupdatehintstringpower(var_0);
  maps\mp\zombies\_util::cg_setupstorestrings(var_0);

  for(;;) {
    while(!var_0 istouching(self)) {
      wait 0.1;
    }

    waittillframeend;
    var_0.storedescription settext(getterminalhintstring(var_0));
    var_0.storecost settext(getterminalsecondaryhintstring(var_0));
    cg_terminalwaittilltriggerexit(var_0);
    var_0.storedescription settext("");
    var_0.storecost settext("");
  }
}

cg_terminalwaittilltriggerexit(var_0) {
  var_0 endon("terminalStateChange");
  childthread cg_terminalwaittillstatechange(var_0);

  while(var_0 istouching(self)) {
    wait 0.1;
  }

  return;
}

cg_terminalwaittillstatechange(var_0) {
  var_0 common_scripts\utility::waittill_any("terminal_activated", "terminalPlayerConnected", "terminalPlayerDisconnected", "terminalPowerActivated", "player_infected", "take_perk");
  var_0 notify("terminalStateChange");
}

terminalupdatehintstringsmulticlient() {
  thread terminalupdatehintstringonconnect();
  thread terminalupdatehintstringpower();

  for(;;) {
    waittillframeend;
    self setcursorhint("HINT_NOICON");
    var_0 = getterminalhintstring();
    self sethintstring(var_0);
    var_1 = getterminalsecondaryhintstring();
    self setsecondaryhintstring(var_1);
    maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(getitemcost(self.itemtype)));
    maps\mp\zombies\_util::tokenhintstring(self.showtokenstring);
    level common_scripts\utility::waittill_any("terminal_activated", "terminalPlayerConnected", "terminalPowerActivated", "player_infected", "terminal_cooldown_ended", "terminal_cooldown_started", "terminal_disabled", "terminal_reenabled");
  }
}

terminalupdatehintstringpower(var_0) {
  if(isDefined(var_0)) {
    var_0 endon("disconnect");
  }

  if(!terminal_requires_power()) {
    return;
  }
  for(;;) {
    common_scripts\utility::flag_wait(self.script_flag_true);

    if(isDefined(var_0)) {
      var_0 notify("terminalPowerActivated");
    }

    level notify("terminalPowerActivated");
    common_scripts\utility::flag_waitopen(self.script_flag_true);

    if(isDefined(var_0)) {
      var_0 notify("terminalPowerActivated");
    }

    level notify("terminalPowerActivated");
  }
}

terminalupdatehintstringonconnect(var_0) {
  if(isDefined(var_0)) {
    var_0 endon("disconnect");
  }

  if(!isDefined(level.terminalitems[self.itemtype].costsolo)) {
    return;
  }
  for(;;) {
    level waittill("connected");

    if(isDefined(var_0)) {
      var_0 notify("terminalPlayerConnected");
    }

    level notify("terminalPlayerConnected");
  }
}

terminalupdatehintstringondisconnect(var_0) {
  if(!isDefined(level.terminalitems[self.itemtype].costsolo)) {
    return;
  }
  var_0 waittill("disconnect");

  foreach(var_0 in level.players) {
    var_0 notify("terminalPlayerDisconnected");
  }
}

initterminals(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_5.itemtype = var_5 getitemtype();

    if(maps\mp\zombies\_util::iszombieshardmode() && var_5.itemtype == "exo_revive") {
      var_6 = var_5 getterminallight();

      if(isDefined(var_6)) {
        var_6 setlightintensity(0);
      }

      var_5 delete();
      continue;
    }

    if(isDefined(var_5.script_flag_true) && !common_scripts\utility::flag_exist(var_5.script_flag_true)) {
      common_scripts\utility::flag_init(var_5.script_flag_true);
    }

    setiteminmap(var_5.itemtype);
    var_7 = var_5 getterminaltrigger();
    var_5.trigger = var_7;
    var_7.modelent = var_5 getterminalmodel();
    var_7.light = var_5 getterminallight();

    if(!isDefined(level.terminals[var_5.itemtype])) {
      level.terminals[var_5.itemtype] = [];
    }

    var_8 = level.terminals[var_5.itemtype].size;
    level.terminals[var_5.itemtype][var_8] = var_5;
    var_7.itemtype = var_5.itemtype;

    if(level.nextgen) {
      if(maps\mp\zombies\_util::isusetriggerforsingleclient(var_7)) {
        maps\mp\zombies\_util::setupusetriggerforclient(var_7, ::terminalhintstringupdate);
      } else if(var_0 != "atm_terminal") {
        var_7 thread terminalupdatehintstringsmulticlient();
      }
    } else if(var_0 != "atm_terminal") {
      foreach(var_10 in level.players) {
        var_7 thread cg_terminalhintstringupdate(var_10);
      }

      thread cg_onplayerconnectedterminalhintstringupdate(var_7);
    }

    var_7 thread[[var_1]]();
  }

  if(isDefined(var_2)) {
    thread[[var_2]](var_3);
  }
}

atmterminalroundupdate(var_0) {
  var_1 = 1;

  for(;;) {
    level waittill("zombie_wave_ended");
    var_2 = 0;
    var_3 = 0;
    var_4 = 1;

    foreach(var_6 in var_0) {
      if(var_6.trigger.active) {
        var_2++;
      }

      if(var_6.trigger.activationcount < var_1) {
        var_4 = 0;
      }
    }

    if(var_4) {
      var_1++;
    }

    var_0 = common_scripts\utility::array_randomize(var_0);

    for(var_8 = 0; var_8 < var_0.size && var_2 < 4 && var_3 < 2; var_8++) {
      if(var_0[var_8].trigger.active) {
        continue;
      }
      if(var_0[var_8].trigger.activationcount >= var_1) {
        continue;
      }
      var_0[var_8].trigger notify("atm_on");
      var_2++;
      var_3++;
    }
  }
}

atmterminalthink() {
  self.activationcount = 0;
  self.usedcount = 0;
  self.forcejackpot = 0;
  thread atmterminalfx();
  maps\mp\_utility::gameflagwait("prematch_done");
  var_0 = 0.01;

  for(;;) {
    self.active = 0;
    self sethintstring(&"ZOMBIES_EMPTY_STRING");
    self waittill("atm_on");
    self.activationcount++;
    self.active = 1;
    self sethintstring(getitemlocbuy(self.itemtype));
    self waittill("trigger", var_1);
    self.usedcount++;
    var_2 = randomfloat(1) < var_0 || self.forcejackpot;

    if(var_2) {
      self.forcejackpot = 0;
      self sethintstring(&"ZOMBIES_EMPTY_STRING");
      atmjackpot();
    } else {
      var_1 maps\mp\gametypes\zombies::givepointsforevent("atm", undefined, 1);
      var_1 playlocalsound("interact_credit_machine");
    }

    self notify("atm_off");
  }
}

atmjackpot() {
  playFX(common_scripts\utility::getfx("atm_jackpot"), self.modelent.origin, anglesToForward(self.modelent.angles));
  var_0 = spawn("script_origin", self.modelent.origin);
  playsoundatpos(self.modelent.origin, "cash_machine_malfunction");
  maps\mp\zombies\_zombies_audio_announcer::announcerjackpotdialog(self.modelent.origin);
  wait 5;
  var_0 playLoopSound("cash_machine_malfunction_loop");
  var_1 = 120;
  var_2 = var_1 * var_1;
  var_3 = 0.5;
  var_4 = anglesToForward(self.modelent.angles);

  for(var_5 = 0; var_5 < 100; var_5++) {
    foreach(var_7 in level.players) {
      var_8 = distance2dsquared(var_7.origin, self.modelent.origin);

      if(var_8 > var_2) {
        continue;
      }
      var_9 = var_7.origin - self.modelent.origin;
      var_9 = (var_9[0], var_9[1], 0);
      var_9 = vectornormalize(var_9);
      var_10 = vectordot(var_9, var_4);

      if(var_10 < var_3) {
        continue;
      }
      var_7 maps\mp\gametypes\zombies::givepointsforevent("atm_jackpot");
    }

    wait 0.1;
  }

  playsoundatpos(self.modelent.origin, "cash_machine_malfunction_end");
  var_0 stoploopsound();
  waitframe();
  var_0 delete();
}

atmterminalfx() {
  for(;;) {
    self.modelent hidepart("TAG_SCREEN_ON");
    self.modelent showpart("TAG_SCREEN_OFF");
    thread audio_stop_atm_attract();
    self waittill("atm_on");
    self.modelent hidepart("TAG_SCREEN_OFF");
    self.modelent showpart("TAG_SCREEN_ON");
    self scalevolume(1, 1);
    self playLoopSound("interact_credit_machine_attract");
    self waittill("atm_off");
  }
}

audio_stop_atm_attract() {
  self scalevolume(0, 1);
  wait 1;
  self stoploopsound();
}

perkterminalhas(var_0) {
  return self hasperk(var_0, 1);
}

perkterminalset(var_0, var_1) {
  maps\mp\_utility::giveperk(var_0, 0);
  self playrumbleonentity("damage_heavy");
}

perkterminaltake(var_0) {
  maps\mp\_utility::_unsetperk(var_0);
}

perkterminalactivate(var_0) {
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_exo"), self.modelent, "TAG_ORIGIN", 1);
}

perkterminalhasexohealth(var_0) {
  return self.maxhealth == 200;
}

perkterminalsetexohealth(var_0, var_1) {
  self.maxhealth = 200;
  self.health = 200;
  var_2 = maps\mp\gametypes\zombies::getexosuitperkweaponname("health");
  var_3 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
  maps\mp\gametypes\zombies::playweaponflourish(var_2, var_3);
}

perkterminaltakeexohealth(var_0) {
  self.maxhealth = 100;
}

perkterminalhasexostabilizer(var_0) {
  return self hasperk("specialty_bulletaccuracy", 1);
}

perkterminalsetexostabilizer(var_0, var_1) {
  maps\mp\_utility::giveperk("specialty_bulletaccuracy", 0);
  maps\mp\_utility::giveperk("specialty_sprintfire", 0);
  maps\mp\_utility::giveperk("specialty_quickswap", 0);
  maps\mp\_utility::giveperk("specialty_fastoffhand", 0);
  var_2 = maps\mp\gametypes\zombies::getexosuitperkweaponname("stabilizer");
  var_3 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
  maps\mp\gametypes\zombies::playweaponflourish(var_2, var_3);
}

perkterminaltakeexostabilizer(var_0) {
  maps\mp\_utility::_unsetperk("specialty_bulletaccuracy");
  maps\mp\_utility::_unsetperk("specialty_sprintfire");
  maps\mp\_utility::_unsetperk("specialty_quickswap");
  maps\mp\_utility::_unsetperk("specialty_fastoffhand");
}

perkterminalhasexorevive(var_0) {
  return maps\mp\zombies\_zombies_laststand::hasexostim();
}

perkterminalsetexorevive(var_0, var_1) {
  self.isexostimactive = 1;

  if(hasexosuit()) {
    var_2 = maps\mp\gametypes\zombies::getexosuitperkweaponname("stim");
    var_3 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
    maps\mp\gametypes\zombies::playweaponflourish(var_2, var_3);
  }
}

perkterminaltakeexorevive(var_0) {
  self.isexostimactive = 0;
}

perkterminalhasexoslam(var_0) {
  return isDefined(self.isexoslamactive) && self.isexoslamactive;
}

perkterminalsetexoslam(var_0, var_1) {
  self.isexoslamactive = 1;
  maps\mp\_utility::playerallowhighjumpdrop(1, "exoSlam");
  self setclientomnvar("ui_zm_exo_slam_next_time", 0);
  var_2 = maps\mp\gametypes\zombies::getexosuitperkweaponname("slam");
  var_3 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
  maps\mp\gametypes\zombies::playweaponflourish(var_2, var_3);
}

perkterminaltakeexoslam(var_0) {
  self.isexoslamactive = 0;
  self.exoslamnextusetime = undefined;
  maps\mp\_utility::playerallowhighjumpdrop(0, "exoSlam");
  self setclientomnvar("ui_zm_exo_slam_next_time", 0);
}

perkterminalhasexofastreload(var_0) {
  return self hasperk("specialty_fastreload", 1);
}

perkterminalsetexofastreload(var_0, var_1) {
  maps\mp\_utility::giveperk("specialty_fastreload", 0);
  maps\mp\_utility::giveperk("specialty_sprintreload", 0);
  var_2 = maps\mp\gametypes\zombies::getexosuitperkweaponname("fastreload");
  var_3 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
  maps\mp\gametypes\zombies::playweaponflourish(var_2, var_3);
}

perkterminaltakeexofastreload(var_0) {
  maps\mp\_utility::_unsetperk("specialty_fastreload");
  maps\mp\_utility::_unsetperk("specialty_sprintreload");
}

perkterminalhasexotacticalarmor(var_0) {
  return self hasperk("specialty_stockpile", 1);
}

perkterminalsetexotacticalarmor(var_0, var_1) {
  maps\mp\_utility::giveperk("specialty_stockpile", 0);
  maps\mp\_utility::giveperk("specialty_extralethal", 0);
  maps\mp\_utility::giveperk("specialty_extratactical", 0);
  var_2 = maps\mp\gametypes\zombies::getexosuitperkweaponname("tacticalarmor");
  var_3 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
  maps\mp\gametypes\zombies::playweaponflourish(var_2, var_3);
}

perkterminaltakeexotacticalarmor(var_0) {
  maps\mp\_utility::_unsetperk("specialty_stockpile");
  maps\mp\_utility::_unsetperk("specialty_extralethal");
  maps\mp\_utility::_unsetperk("specialty_extratactical");
  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    var_4 = self getweaponammoclip(var_3);
    var_5 = weaponclipsize(var_3, self);

    if(var_4 > var_5) {
      self setweaponammoclip(var_3, var_4);
    }

    if(!isweaponcliponly(var_3)) {
      var_6 = self getweaponammostock(var_3);
      var_7 = weaponmaxammo(var_3, self);

      if(var_6 > var_7) {
        self setweaponammostock(var_3, var_6);
      }
    }
  }

  if(isDefined(self.pers["em1Ammo"])) {
    var_9 = maps\mp\gametypes\zombies::getem1maxammo();

    if(self.pers["em1Ammo"].ammo > var_9) {
      self.pers["em1Ammo"].ammo = var_9;
    }

    maps\mp\gametypes\zombies::playerupdateem1omnvar();
  }

  if(isDefined(self.primaryweaponsammo)) {
    foreach(var_14, var_11 in self.primaryweaponsammo) {
      var_12 = weaponclipsize(var_14, self);

      if(var_11["ammoclip"] > var_12) {
        self.primaryweaponsammo[var_14]["ammoclip"] = var_12;
      }

      if(common_scripts\utility::string_find(var_14, "akimbo") && isDefined(var_11["ammoclipleft"]) && var_11["ammoclipleft"] > var_12) {
        self.primaryweaponsammo[var_14]["ammoclipleft"] = var_12;
      }

      if(!isweaponcliponly(var_14)) {
        var_13 = weaponmaxammo(var_14, self);

        if(var_11["ammostock"] > var_13) {
          self.primaryweaponsammo[var_14]["ammostock"] = var_13;
        }
      }
    }
  }
}

perkterminalusershostcure() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(maps\mp\zombies\_util::isplayerinfected(var_2) && var_2 istouching(self.curetrigger)) {
      var_0[var_0.size] = var_2;
    }
  }

  var_4 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_6 in var_4) {
    if(isDefined(var_6.agent_type) && var_6.agent_type == "zombie_host" && var_6 istouching(self.curetrigger)) {
      var_0[var_0.size] = var_6;
    }

    if(isDefined(level.hostcurefuncoverride) && isDefined(level.hostcurefuncoverride[var_6.agent_type]) && var_6 istouching(self.curetrigger)) {
      var_0[var_0.size] = var_6;
    }
  }

  return var_0;
}

perkterminalactivatehostcure(var_0) {
  thread perkterminalactivatehostcurefx(var_0);
  thread perkterminalactivatehostcureanim(var_0);
}

perkterminalactivatehostcureanim(var_0) {
  if(!isDefined(self.curemodel)) {
    return;
  }
  level notify("cure_station_active");
  var_1 = gettime();
  self.curemodel scriptmodelplayanim("xom_host_cure_station_start", "curestation");
  self.curemodel playSound("interact_decontam_zone");
  self.curemodel waittillmatch("curestation", "end");
  thread audio_decontam_attract_in_use_start(self.curemodel);
  self.curemodel scriptmodelplayanim("xom_host_cure_station_loop");
  wait(var_0 - (gettime() - var_1) / 1000);
  self.curemodel scriptmodelplayanim("xom_host_cure_station_stop");
  wait 10;
  self.curemodel playSound("interact_decontam_zone_ready");
  thread audio_decontam_attract_in_use_stop(self.curemodel);
  level notify("cure_station_deactive");
}

perkterminalactivatehostcurefx(var_0) {
  if(!isDefined(self.curemodel)) {
    return;
  }
  playFXOnTag(common_scripts\utility::getfx("zombie_host_cure"), self.curemodel, "TAG_FX");
}

perkterminalsethostcure(var_0, var_1) {
  self notify("cured", 1);
  self setwatersheeting(1, 0.5);
  var_2 = common_scripts\utility::getStructArray("host_cure_teleport", "targetname");

  if(var_2.size) {
    var_3 = common_scripts\utility::random(var_2);
    self dontinterpolate();
    self setorigin(var_3.origin);
    self setangles(var_3.angles);
  }
}

perkterminalsethostcurezombie(var_0, var_1) {
  if(isDefined(level.hostcurefuncoverride) && isDefined(level.hostcurefuncoverride[self.agent_type])) {
    self thread[[level.hostcurefuncoverride[self.agent_type]]](var_0, var_1);
    return;
  }

  if(!isDefined(level.zombiehostcures) || !isDefined(level.lastzombiehostcuretime)) {
    level.zombiehostcures = 0;
    level.lastzombiehostcuretime = 0;
  }

  if(gettime() - level.lastzombiehostcuretime > 300) {
    level.zombiehostcures = 0;
  }

  level.zombiehostcures++;
  level.lastzombiehostcuretime = gettime();
  self suicide();
}

givecurestationachievement() {
  if(self.agent_type != "zombie_host") {
    return;
  }
  if(!isDefined(level.zombiehostcures) || level.zombiehostcures < 5) {
    return;
  }
  foreach(var_1 in level.players) {
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC2_ZOMBIE_ONEMANSPOISON");
  }
}

perkterminalhostcuredisabled() {
  if(isPlayer(self) && isDefined(self.currentzone) && isDefined(level.zone_is_contaminated_func) && [[level.zone_is_contaminated_func]](self.currentzone)) {
    return 1;
  }

  return 0;
}

audio_decontam_attract_on(var_0) {
  var_0 scalevolume(1, 0.25);
  var_0 playLoopSound("interact_decontam_zone_attract");
}

audio_decontam_attract_in_use_start(var_0) {
  var_0 scalevolume(0, 0.5);
}

audio_decontam_attract_in_use_stop(var_0) {
  var_0 scalevolume(1, 1);
}

audio_decontam_attract_disable(var_0) {
  var_0 scalevolume(0, 0.5);
}

playergivepostexoequipment() {
  var_0 = self getlethalweapon();

  if(isDefined(var_0)) {
    var_1 = maps\mp\zombies\_util::getpostexoequipmentname(var_0);

    if(isDefined(var_1) && var_1 != var_0) {
      var_2 = self getweaponammoclip(var_0);
      maps\mp\zombies\_wall_buys::givezombieequipment(self, var_1, 0);
      self setweaponammoclip(var_1, var_2);
    }
  }

  var_3 = self gettacticalweapon();

  if(isDefined(var_3)) {
    var_4 = maps\mp\zombies\_util::getpostexoequipmentname(var_3);

    if(isDefined(var_4) && var_4 != var_3) {
      var_2 = self getweaponammoclip(var_3);
      maps\mp\zombies\_wall_buys::givezombieequipment(self, var_4, 0);
      self setweaponammoclip(var_4, var_2);
    }
  }
}

perkterminalhasexosuit(var_0) {
  return hasexosuit();
}

perkterminalsetexosuit(var_0, var_1) {
  self.exosuitonline = 1;
  givecheapskateachievement();
  thread playequipexosuitfx();
  setexocharactermodel();
  var_2 = maps\mp\gametypes\zombies::getexosuitequipweaponname();
  var_3 = maps\mp\gametypes\zombies::getexosuitequipweaponduration();
  maps\mp\gametypes\zombies::playweaponflourish(var_2, var_3);

  if(self.exosuitround == 0) {
    self.exosuitround = level.wavecounter;
  }

  maps\mp\zombies\_util::zombieallowallboost(1, "class");
  playergivepostexoequipment();
  level notify("player_given_exo_suit");
}

setexocharactermodel() {
  switch (self.characterindex) {
    case 0:
      thread maps\mp\zombies\_util::setcharactermodel("security_exo", 1);
      break;
    case 1:
      thread maps\mp\zombies\_util::setcharactermodel("exec_exo", 1);
      break;
    case 2:
      thread maps\mp\zombies\_util::setcharactermodel("it_exo", 1);
      break;
    case 3:
    default:
      if(maps\mp\zombies\_util::getzombieslevelnum() < 3) {
        thread maps\mp\zombies\_util::setcharactermodel("janitor_exo", 1);
      } else {
        thread maps\mp\zombies\_util::setcharactermodel("pilot_exo", 1);
      }

      break;
  }
}

playequipexosuitfx() {
  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("exo_equip"), self, "tag_origin", var_1);
  }
}

givecheapskateachievement() {
  if(self.moneycurrent != self.moneyearnedtotal || !isDefined(self.joinedround1) || !self.joinedround1) {
    return;
  }
  maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_CHEAPSKATE");
}

perkterminaltakeexosuit(var_0) {
  self.exosuitonline = 0;
  maps\mp\zombies\_util::zombieallowallboost(0, "class");
}

perkterminalactivateexosuit(var_0) {
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_exo"), self.modelent, "TAG_ORIGIN", 1);
}

perkterminalonfx() {
  var_0 = level.terminalitems[self.itemtype];

  if(isDefined(self.offfxent)) {
    self.offfxent = undefined;
    maps\mp\zombies\_util::stopfxontagnetwork(var_0.offfx, self.modelent, "tag_origin");
  }

  if(isDefined(var_0.onfx) && !isDefined(self.onfxent)) {
    maps\mp\zombies\_util::playfxontagnetwork(var_0.onfx, self.modelent, "tag_origin");
    self.onfxent = 1;
  }
}

perkterminalofffx() {
  var_0 = level.terminalitems[self.itemtype];

  if(isDefined(self.onfxent)) {
    self.onfxent = undefined;
    maps\mp\zombies\_util::stopfxontagnetwork(var_0.onfx, self.modelent, "tag_origin");
  }

  if(isDefined(var_0.offfx) && !isDefined(self.offfxent)) {
    maps\mp\zombies\_util::playfxontagnetwork(var_0.offfx, self.modelent, "tag_origin");
    self.offfxent = 1;
  }
}

perkterminallighton() {
  if(isDefined(self.light)) {
    self.light setlightcolor((0.501, 1, 1));
  }
}

perkterminallightoff() {
  if(isDefined(self.light)) {
    self.light setlightcolor((1, 0, 0));
  }
}

perkterminaltriggerthink() {
  thread perkterminalupdate();
  thread perkterminalusethink();
  waitframe();

  if(!maps\mp\zombies\_util::isusetriggerprimary(self)) {
    return;
  }
  thread perkterminalplayercountwatch();
  thread perkterminalpowerwatch();
  thread perkterminalupdatefx();
}

perkterminalplayercountwatch() {
  for(;;) {
    level waittill("playerCountUpdate");
    self notify("updateFX");
  }
}

perkterminalpowerwatch() {
  if(!terminal_requires_power()) {
    return;
  }
  for(;;) {
    self notify("updateFX");
    common_scripts\utility::flag_wait(self.script_flag_true);
    self notify("updateFX");
    common_scripts\utility::flag_waitopen(self.script_flag_true);
  }
}

perkterminalupdatefx() {
  for(;;) {
    var_0 = itemhasuses(self.itemtype);
    var_1 = terminal_has_power();

    if(var_0 && var_1) {
      perkterminalonfx();
      perkterminallighton();
      perkterminalattractaudioon();
    } else {
      perkterminalofffx();
      perkterminallightoff();
      perkterminalattractaudiooff();
    }

    self waittill("updateFX");
  }
}

perkterminalattractaudioon() {
  if(isDefined(self.aud_attract_on) && self.aud_attract_on) {
    return;
  } else {
    self.aud_attract_on = 1;

    switch (self.itemtype) {
      case "exo_health":
        self playLoopSound("interact_exo_upgrade_attract");
        break;
      case "exo_revive":
        self playLoopSound("interact_exo_upgrade_attract");
        break;
      case "exo_slam":
        self playLoopSound("interact_exo_upgrade_attract");
        break;
      case "exo_suit":
        self playLoopSound("interact_exo_buy_attract");
        self playSound("exo_station_restored");
        break;
      case "exo_stabilizer":
        self playLoopSound("interact_exo_upgrade_attract");
        break;
      case "specialty_fastreload":
        self playLoopSound("interact_exo_upgrade_attract");
        break;
      case "exo_tacticalArmor":
        self playLoopSound("interact_exo_upgrade_attract");
        break;
      default:
        break;
    }
  }
}

perkterminalattractaudiooff() {
  return;
}

perkterminalcuremodellighton() {
  if(isDefined(self.light) && isDefined(self.light.lightonintensity) && isDefined(self.light.ison) && !self.light.ison) {
    self.light setlightintensity(self.light.lightonintensity);
    self.light.ison = 1;
  }
}

perkterminalcuremodellightoff() {
  if(isDefined(self.light) && isDefined(self.light.lightoffintensity) && isDefined(self.light.ison) && self.light.ison) {
    self.light setlightintensity(self.light.lightoffintensity);
    self.light.ison = 0;
  }
}

perkterminalupdate() {
  switch (self.itemtype) {
    case "host_cure":
      thread perkterminalupdatehostcure();
      break;
    default:
      break;
  }
}

perkterminalupdatehostcure() {
  self.curetrigger = getent(self.target, "targetname");

  if(isDefined(self.curetrigger.target)) {
    self.curemodel = getent(self.curetrigger.target, "targetname");

    if(isDefined(self.curemodel)) {
      self.curemodel.terminal = self;
      level.hostcuremodels[level.hostcuremodels.size] = self.curemodel;
    }
  }

  if(isDefined(self.curemodel) && isDefined(self.curemodel.target)) {
    var_0 = getent(self.curemodel.target, "targetname");

    if(isDefined(var_0) && var_0.code_classname == "light") {
      self.curemodel.light = var_0;
      self.curemodel.light.lightonintensity = self.curemodel.light getlightintensity();
      self.curemodel.light.lightoffintensity = 0.1;
      self.curemodel.light.ison = 1;
      self.curemodel perkterminalcuremodellightoff();
    }
  }

  thread perkterminalupdatehostcuredisabled();
  thread perkterminalupdatehostcurefx();
  thread perkterminalupdatehostcureicon();
}

perkterminalupdatehostcuredisabled() {
  self.terminaldisabled = 0;
  var_0 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.origin);

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    level waittill("contaminate" + var_0);
    self.terminaldisabled = 1;
    self notify("terminal_disabled");
    level notify("terminal_disabled");
    thread maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
    level waittill("clean" + var_0);
    self.terminaldisabled = 0;
    self notify("terminal_reenabled");
    level notify("terminal_reenabled");
    thread maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
  }
}

perkterminalupdatehostcurefx() {
  for(;;) {
    terminal_wait_for_power();

    if(self.terminaldisabled) {
      self waittill("terminal_reenabled");
    }

    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_idle"), self.curemodel, "TAG_FX");
    thread audio_decontam_attract_on(self.curemodel);
    common_scripts\utility::waittill_either("terminal_activated", "terminal_disabled");
    maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_idle"), self.curemodel, "TAG_FX");

    if(self.terminaldisabled) {
      thread audio_decontam_attract_disable(self.curemodel);
      continue;
    }

    self waittill("terminal_cooldown_started");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_cooldown"), self.curemodel, "TAG_FX");
    self waittill("terminal_cooldown_ended");
    maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_cooldown"), self.curemodel, "TAG_FX");
  }
}

perkterminalupdatehostcureicon() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.origin);

  for(;;) {
    if(isDefined(var_2)) {
      level common_scripts\utility::waittill_any("player_cured", "player_infected", "contaminate" + var_2, "clean" + var_2);
    } else {
      level common_scripts\utility::waittill_any("player_cured", "player_infected");
    }

    if(maps\mp\zombies\_util::is_true(self.terminaldeactivated)) {
      continue;
    }
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(maps\mp\zombies\_util::isplayerinfected(var_5)) {
        var_3 = 1;
        break;
      }
    }

    if(isDefined(level.zone_is_contaminated_func) && [[level.zone_is_contaminated_func]](var_2)) {
      var_3 = 0;
    }

    if(var_0 && !var_3) {
      if(isDefined(var_1)) {
        var_1 destroy();
      }

      var_0 = 0;
      continue;
    }

    if(!var_0 && var_3) {
      var_1 = newhudelem();
      var_1 setshader("waypoint_cure_zone", 8, 8);
      var_1 setwaypoint(1, 1);
      var_1.x = self.curemodel.origin[0];
      var_1.y = self.curemodel.origin[1];
      var_1.z = self.curemodel.origin[2] + 70;
      var_0 = 1;
    }
  }
}

perkterminalusethink() {
  for(;;) {
    var_0 = undefined;
    var_1 = "trigger";

    if(getitemcost(self.itemtype)) {
      [var_0, var_1] = maps\mp\zombies\_util::waittilltriggerortokenuse();
    } else {
      self waittill("trigger", var_0);
    }

    if(!terminal_has_power()) {
      continue;
    }
    perkterminalgive(var_0, self.itemtype, var_1, 0);
  }
}

perkterminalgive(var_0, var_1, var_2, var_3) {
  var_4 = &"ZOMBIES_HAVE_PERK";
  var_5 = undefined;
  var_6 = undefined;
  var_7 = ::perkterminalactivate;
  var_8 = "interact_exo_upgrade";
  var_9 = 0;
  var_10 = "killed_player";
  var_11 = 0;
  var_12 = 0;
  var_13 = undefined;

  switch (var_1) {
    case "exo_health":
      var_14 = ::perkterminalhasexohealth;
      var_15 = ::perkterminalsetexohealth;
      var_16 = ::perkterminaltakeexohealth;
      break;
    case "exo_revive":
      var_14 = ::perkterminalhasexorevive;
      var_15 = ::perkterminalsetexorevive;
      var_16 = ::perkterminaltakeexorevive;
      break;
    case "exo_slam":
      var_14 = ::perkterminalhasexoslam;
      var_15 = ::perkterminalsetexoslam;
      var_16 = ::perkterminaltakeexoslam;
      break;
    case "host_cure":
      var_14 = undefined;
      var_15 = ::perkterminalsethostcure;
      var_6 = ::perkterminalsethostcurezombie;
      var_5 = ::perkterminalusershostcure;
      var_7 = ::perkterminalactivatehostcure;
      var_16 = undefined;
      var_8 = undefined;
      var_9 = 1;
      var_12 = 5;
      var_11 = 10;

      if(isDefined(level.curestationcooldownmodifier)) {
        var_11 = var_11 * level.curestationcooldownmodifier;
      }

      var_13 = ::perkterminalhostcuredisabled;
      break;
    case "exo_suit":
      var_14 = ::perkterminalhasexosuit;
      var_15 = ::perkterminalsetexosuit;
      var_16 = ::perkterminaltakeexosuit;
      var_7 = ::perkterminalactivateexosuit;
      var_4 = &"ZOMBIES_HAVE_EXO";
      var_8 = "interact_exo_buy";
      break;
    case "exo_stabilizer":
      var_14 = ::perkterminalhasexostabilizer;
      var_15 = ::perkterminalsetexostabilizer;
      var_16 = ::perkterminaltakeexostabilizer;
      break;
    case "specialty_fastreload":
      var_14 = ::perkterminalhasexofastreload;
      var_15 = ::perkterminalsetexofastreload;
      var_16 = ::perkterminaltakeexofastreload;
      break;
    case "exo_tacticalArmor":
      var_14 = ::perkterminalhasexotacticalarmor;
      var_15 = ::perkterminalsetexotacticalarmor;
      var_16 = ::perkterminaltakeexotacticalarmor;
      break;
    default:
      var_14 = ::perkterminalhas;
      var_15 = ::perkterminalset;
      var_16 = ::perkterminaltake;
      break;
  }

  if(!itemhasuses(var_1)) {
    return;
  }
  if(getitemrequiresexo(var_1) && !var_0 hasexosuit()) {
    var_0 thread maps\mp\zombies\_zombies_audio::playerexosuitrejected(var_1, "no_suit");
    var_0 playsoundtoplayer("ui_button_error", var_0);
    var_0 iprintlnbold(&"ZOMBIES_NEED_EXO_SUIT");
    return;
  }

  if(isDefined(var_14) && var_0[[var_14]](var_1)) {
    if(isDefined(var_4)) {
      var_0 iprintlnbold(var_4);
    }

    return;
  }

  if(isDefined(var_13) && var_0[[var_13]]()) {
    return;
  }
  if(var_11 > 0 && !var_3 && perkterminalcoolingdown()) {
    var_17 = self.nextusetime - gettime();
    var_17 = ceil(var_17 / 1000);

    if(var_17 > 1) {
      var_0 iprintlnbold(&"ZOMBIES_TERMINAL_COOLDOWN_SECS", var_17);
    } else {
      var_0 iprintlnbold(&"ZOMBIES_TERMINAL_COOLDOWN_SEC", var_17);
    }

    return;
  }

  var_18 = getitemcost(var_1);

  if(var_18 > 0) {
    if(var_2 == "token") {
      var_0 maps\mp\gametypes\zombies::spendtoken(self.tokencost);
    } else if(!var_3 && !var_0 maps\mp\gametypes\zombies::attempttobuy(getitemcost(var_1))) {
      var_0 thread maps\mp\zombies\_zombies_audio::playerexosuitrejected(var_1, "no_cash");
      return;
    }
  }

  if(!var_3 && isDefined(var_7)) {
    [[var_7]](var_12);
  }

  if(isDefined(var_8) && !var_3) {
    var_0 playlocalsound(var_8);
  }

  var_0 thread maps\mp\zombies\_zombies_audio::playerexosuit(var_1);
  self.terminalrunning = 1;
  setitemusecount(var_1, getitemnumbuys(var_1) + 1);
  self notify("updateFX");

  if(isDefined(self.linkedterminal)) {
    self.linkedterminal notify("updateFX");
  }

  self notify("terminal_activated");
  var_0 notify("terminal_activated", var_1);
  level notify("terminal_activated", var_1);
  var_19 = gettime();

  for(;;) {
    var_20 = [var_0];

    if(!var_3 && isDefined(var_5)) {
      var_20 = [[var_5]]();
    }

    foreach(var_22 in var_20) {
      if(isPlayer(var_22)) {
        var_23 = getitemomnvar(var_1);

        if(isDefined(var_23)) {
          var_22 setclientomnvar(var_23, 1);
        }

        if(var_1 != "exo_suit") {
          var_0 thread maps\mp\zombies\_zombies_audio::moneyspend();
        }

        var_22 iprintlnbold(getitemlocname(var_1));
        var_22[[var_15]](var_1, var_0);
        level notify("terminal_player", var_1, self.origin, var_0);

        if(!var_9) {
          var_22.zm_perks[var_22.zm_perks.size] = var_1;
          var_22 thread perkterminaltakewait(var_1, var_16, var_10);
        }

        var_22 perkupdatesortorder();
        continue;
      }

      if(isDefined(var_6)) {
        var_22[[var_6]](var_1, var_0);
      }
    }

    var_25 = (gettime() - var_19) / 1000;

    if(var_12 <= var_25) {
      break;
    }

    waitframe();
  }

  level notify("terminal_complete", var_1, self.origin);
  self.terminalrunning = undefined;

  if(var_11 > 0 && !var_3) {
    self.nextusetime = gettime() + var_11 * 1000;
    thread terminalcooldownnotifies(var_11);
  }
}

perkterminalhostcureincooldown(var_0) {
  return var_0 perkterminalcoolingdown();
}

perkterminalcoolingdown() {
  return isDefined(self.nextusetime) && self.nextusetime > gettime();
}

perkupdatesortorder() {
  var_0 = 0;
  var_1 = 1;

  foreach(var_3 in self.zm_perks) {
    if(var_3 == "exo_suit") {
      continue;
    }
    var_4 = perkgetindex(var_3);
    var_0 = var_0 + var_4 * var_1;
    var_1 = var_1 * 10;
  }

  self setclientomnvar("ui_zm_perk_order", var_0);
}

perkgetindex(var_0) {
  switch (var_0) {
    case "exo_health":
      return 1;
    case "specialty_fastreload":
      return 2;
    case "exo_revive":
      return 3;
    case "exo_stabilizer":
      return 4;
    case "exo_slam":
      return 5;
    case "exo_tacticalArmor":
      return 6;
    default:
      return 0;
  }
}

terminalcooldownnotifies(var_0) {
  self notify("terminal_cooldown_started");
  level notify("terminal_cooldown_started");
  maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
  wait(var_0);
  self notify("terminal_cooldown_ended");
  level notify("terminal_cooldown_ended");
  maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
}

perkterminaltakewait(var_0, var_1, var_2) {
  self endon("disconnect");
  thread perkterminaltakeonsolo(var_0);
  thread perkterminaltakeonendsolo(var_0);
  common_scripts\utility::waittill_any(var_2, "take_" + var_0);
  self notify("lost_" + var_0);
  self notify("take_perk", var_0);
  self[[var_1]](var_0);
  self.zm_perks = common_scripts\utility::array_remove(self.zm_perks, var_0);
  var_3 = getitemomnvar(var_0);

  if(isDefined(var_3)) {
    self setclientomnvar(var_3, 0);
  }

  perkupdatesortorder();
}

perkterminaltakeonsolo(var_0) {
  self endon("disconnect");
  self endon("lost_" + var_0);
  var_1 = getitemmaxsolobuys(var_0);

  if(!isDefined(var_1) || var_1 >= getitemnumbuys(var_0)) {
    return;
  }
  for(;;) {
    level waittill("playerCountUpdate");

    if(level.players.size == 1) {
      break;
    }
  }

  self notify("take_" + var_0);
}

perkterminaltakeonendsolo(var_0) {
  self endon("disconnect");
  self endon("lost_" + var_0);

  if(level.players.size != 1) {
    return;
  }
  var_1 = getitemcostsolo(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  for(;;) {
    level waittill("playerCountUpdate");

    if(level.players.size != 1) {
      break;
    }
  }

  self notify("take_" + var_0);
  maps\mp\gametypes\zombies::givemoney(var_1);
}

terminal_requires_power() {
  return isDefined(self.script_flag_true);
}

terminal_has_power() {
  if(terminal_requires_power()) {
    return common_scripts\utility::flag(self.script_flag_true);
  }

  return 1;
}

terminal_wait_for_power() {
  if(terminal_requires_power()) {
    common_scripts\utility::flag_wait(self.script_flag_true);
  }
}

perkhud(var_0, var_1) {
  var_2 = 20;

  if(!isDefined(self.perkhuds)) {
    self.perkhuds = [];
  }

  if(isDefined(self.perkhuds[var_1])) {
    destroyperkhud(var_1);
  }

  var_3 = maps\mp\gametypes\_hud_util::createfontstring("hudbig", 1.0);
  var_3 maps\mp\gametypes\_hud_util::setpoint("BOTTOM LEFT", undefined, 0, -100 - var_2 * self.perkhuds.size);
  var_3.label = var_0;
  var_3.color = (1, 1, 1);
  var_3.alpha = 1;

  foreach(var_5 in self.perkhuds) {
    var_3 thread updateperkkhuppos(var_5, var_2);
  }

  self.perkhuds[var_1] = var_3;
}

updateperkkhuppos(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  self.y = self.y + var_1;
}

destroyperkhud(var_0) {
  if(isDefined(self.perkhuds[var_0])) {
    self.perkhuds[var_0] destroy();
    self.perkhuds[var_0] = undefined;
  }
}

zombiegroundslamready() {
  return !isDefined(self.exoslamnextusetime) || self.exoslamnextusetime <= gettime();
}

zombiesgroundslam(var_0) {
  self playsoundtoplayer("pc_boost_slam_land_dmg_default", self);
  self playsoundtoteam("npc_boost_slam_land_dmg_default", "allies", self);
  zombiegroundslamcommon(var_0);
  return 1;
}

zombiesgroundslamhitplayer(var_0) {
  zombiegroundslamcommon(undefined, var_0);
  return 1;
}

zombiegroundslamcommon(var_0, var_1) {
  if(perkterminalhasexoslam() && zombiegroundslamready()) {
    var_2 = 100.0;
    var_3 = 250.0;
    var_4 = 0.1;
    var_5 = 0.5;
    var_6 = 100.0;
    var_7 = 300.0;
    var_8 = 10.0;

    if(isDefined(var_1) && !var_1 maps\mp\zombies\_util::instakillimmune()) {
      var_1 dodamage(var_1.health, self.origin, self, self, "MOD_TRIGGER_HURT", "boost_slam_mp");
      playFX(common_scripts\utility::getfx("gib_full_body"), var_1.origin, (1, 0, 0));
    }

    if(!isDefined(var_0)) {
      var_0 = var_2;
    }

    if(var_0 < var_2) {
      return;
    }
    thread groudslamcooldown(var_8);
    self.exoslamnextusetime = gettime() + int(var_8 * 1000);
    self setclientomnvar("ui_zm_exo_slam_next_time", self.exoslamnextusetime);
    var_9 = (var_0 - var_2) / (var_3 - var_2);
    var_9 = clamp(var_9, 0.0, 1.0);
    var_10 = (var_7 - var_6) * var_9 + var_6;
    var_11 = level.agentclasses["zombie_generic"].roundhealth;
    self radiusdamage(self.origin, var_10, var_5 * var_11, var_4 * var_11, self, "MOD_EXPLOSIVE", "boost_slam_mp");
    physicsexplosionsphere(self.origin, var_10, 20, 1);
    playFX(common_scripts\utility::getfx("zombie_exo_slam"), self.origin);
  }
}

groudslamcooldown(var_0) {
  self endon("lost_exo_slam");
  wait(var_0);
}