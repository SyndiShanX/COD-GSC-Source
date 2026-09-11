/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\healthoverlay.gsc
***********************************************/

function init() {
  var0 = scripts\mp\utility\dvars::respawn_locations("scr_" + scripts\mp\utility\game::getgametype() + "_healthregentime", "scr_player_healthregentime");
  scripts\mp\tweakables::settweakablevalue("player", "healthregentime", var0);
  scripts\mp\tweakables::settweakablelastvalue("player", "healthregentime", var0);
  level.healthregendelay = scripts\mp\tweakables::gettweakablevalue("player", "healthregentime");
  level.healthregendisabled = level.healthregendelay <= 0;
  level.playerhealth_regularregendelay = level.healthregendelay;
  level.islargebrmap = getdvarfloat("scr_br_deathsdoor_exit_pct", 0.8);
  level.iskioskfiresaleactiveforplayer = getdvarfloat("scr_br_deathsdoor_enter_pct", 0.55);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function onplayerspawned() {
  thread manageplayerregen();
  self visionsetthermalforplayer(game["thermal_vision"]);
}

function manageplayerregen() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self.deathsdoor = 0;
  self.islaststandbleedoutdmg = 0;
  self.hasdonepainbreathloopthislife = 0;
  self stoplocalsound("deaths_door_out");
  self stoplocalsound("deaths_door_in");
  self clearsoundsubmix("deaths_door_mp");

  for(;;) {
    scripts\engine\utility::waittill_either("damage", "force_regeneration");
    thread healhregenthink();
  }
}

function onenterdeathsdoor() {
  if(istrue(self.deathsdoor)) {
    return;
  }

  self.deathsdoor = 1;
  self.painbreathloopsplayed = 0;

  if(!istrue(self.islaststandbleedoutdmg) && !istrue(self.littlebirdsmg)) {
    self.islaststandbleedoutdmg = 1;
    self stoplocalsound("deaths_door_out");
    self playlocalsound("deaths_door_in");
    self setsoundsubmix("deaths_door_mp", 0.2, 1);
    self enableplayerbreathsystem(0);
    thread playerbreathingpainsound();
  }

  if(level.healthregendisabled) {
    self painvisionon();
  }

  self notify("deaths_door_enter");
}

function onexitdeathsdoor(var0) {
  if(istrue(var0)) {
    self.painbreathloopsplayed = 0;
    self.hasdonepainbreathloopthislife = 0;
  }

  if(!istrue(self.deathsdoor)) {
    return;
  }

  self.deathsdoor = 0;
  self.islaststandbleedoutdmg = 0;
  self stoplocalsound("deaths_door_in");
  self playlocalsound("deaths_door_out");
  self clearsoundsubmix("deaths_door_mp");
  self enableplayerbreathsystem(1);

  if(level.healthregendisabled) {
    self painvisionoff();
  }

  self notify("deaths_door_exit");
}

function onfullhealth() {
  self notify("healed");
  level notify("healed", self);
  thread scripts\mp\damage::removeoldattackersovertime();
  self setclientomnvar("ui_health_regen_hud", 0);

  if(level.gameended) {
    return;
  }

  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }

  self playlocalsound(scripts\engine\utility::ter_op(scripts\mp\utility\player::isfemale(), "Fem_breathing_better", "breathing_better"));
}

function gethealthpersec(var0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(isDefined(var0)) {
      if(var0 == "equip_bandages") {
        return (self.maxhealth * scripts\mp\equipment\bandage::getbandagehealfractionbr() / scripts\mp\equipment\bandage::getbandagehealtimebr());
      }

      return (self.maxhealth / scripts\mp\equipment\bandage::getfirstaidhealtimebr());
    }
  }

  return 4;
}

function healhregenthink(var0) {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  self notify("healhRegenThink");
  self endon("healhRegenThink");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var1 = !istrue(self.adrenalinepoweractive) && !istrue(self.bandageactive) && !istrue(self.laststandhealisactive);
  var2 = self.health / self.maxhealth;

  while(istrue(level.healthregendisabled) && scripts\mp\utility\player::isusingremote()) {
    waitframe();
  }

  if(var2 < level.iskioskfiresaleactiveforplayer && !scripts\mp\utility\player::isusingremote() && !istrue(self.stadium_puzzle)) {
    onenterdeathsdoor();
  }

  if(var1) {
    if(level.healthregendisabled) {
      return;
    }

    while(istrue(self.healthregendisabled) || !scripts\mp\utility\player::is_health_regen_allowed()) {
      waitframe();
    }

    waitforhealthregendelay();
  }

  if(!var1 || scripts\mp\utility\perk::_hasperk("specialty_regenfaster")) {
    self setclientomnvar("ui_health_regen_hud", 1);
  }

  var3 = self.maxhealth / 50;
  var4 = 0;
  var5 = self.health;
  var6 = istrue(self.adrenalinepoweractive);

  for(;;) {
    if(!scripts\mp\utility\player::is_health_regen_allowed() || istrue(self.healthregendisabled) && var1) {
      return;
    }

    wait 0.05;
    var7 = var3;

    if(istrue(self.adrenalinepoweractive)) {
      var7 = scripts\mp\equipment\adrenaline::gethealthperframe();
    } else if(istrue(self.bandageactive)) {
      var7 = gethealthpersec(var0);
      wait 1;
    } else if(istrue(self.laststandhealisactive)) {
      var7 = scripts\mp\supers\laststand_heal::laststandheal_gethealthperframe();
    } else if(scripts\mp\utility\perk::_hasperk("specialty_regenfaster")) {
      var7 = var3 * level.regenfasterhealthmod;
    }

    if(isDefined(level.ref_12ad2)) {
      var7 = [[level.ref_12ad2]](var7);
    }

    if(self.health < self.maxhealth) {
      var8 = self.health + var7 + var4;
      var9 = int(min(self.maxhealth, var8));
      var4 = var8 - var9;
      self.health = var9;
      var2 = self.health / self.maxhealth;

      if(var2 > level.islargebrmap) {
        onexitdeathsdoor(1);
      }
    }

    if(self.health >= self.maxhealth) {
      self.health = self.maxhealth;
      onexitdeathsdoor(1);
      break;
    }
  }

  var10 = self.health - var5;

  if(var6) {
    scripts\mp\damage::combatrecordtacticalstat("equip_adrenaline", var10);
    scripts\mp\utility\stats::incpersstat("stimDamageHealed", var10);
    scripts\cp\vehicles\vehicle_compass_cp::ref_12092(var10);
    scripts\mp\analyticslog::logevent_playerhealed(self, var10, self);
  } else if(!isai(self)) {
    scripts\mp\analyticslog::ref_119b7(self, var10);
  }

  if(var1 && var10 > 0) {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_recover");
  }

  onfullhealth();
}

function waitforhealthregendelay() {
  self endon("force_regeneration");
  self endon("begin_regeneration");
  self.shrapnelregendelay = 0;

  if(isDefined(self.lastshrapneltime)) {
    var0 = gettime();
    var1 = var0 - self.lastshrapneltime;
    var1 *= 0.001;

    if(scripts\mp\utility\perk::_hasperk("specialty_shrapnel_resist")) {
      var2 = 1;
      self.shrapnelregendelay = max(var2 - var1, 0);
    } else {
      self.shrapnelregendelay = max(3 - var1, 0);
    }
  }

  if(!isDefined(self.regendelayspeed)) {
    self.regendelayspeed = 1;
  }

  var3 = self.shrapnelregendelay > 0;

  if(var3) {
    thread applyshrapnelfx();
  }

  if(!isDefined(self.regendelayreductiontime) || gettime() - self.regendelayreductiontime > 0.15) {
    self.regendelayreduction = 0;
  }

  var4 = level.playerhealth_regularregendelay + self.shrapnelregendelay;
  self.currentregendelay = var4;
  var0 = gettime() * 0.001;

  while(self.currentregendelay - self.regendelayreduction > 0) {
    var5 = self.regendelayspeed;

    if(isDefined(level.ref_12ad1)) {
      var5 = [[level.ref_12ad1]](var5);
    }

    self.currentregendelay -= (gettime() * 0.001 - var0) * var5;
    var0 = gettime() * 0.001;

    if(var3 && self.currentregendelay - self.regendelayreduction <= level.playerhealth_regularregendelay) {
      var3 = 0;

      if(self.regendelayreduction > 0) {
        self notify("shrapnel_ended");
      } else {
        self notify("shrapnel_ended_early");
      }
    }

    wait 0.05;
  }

  if(var3) {
    self notify("shrapnel_ended_early");
  }

  self.regendelayreduction = 0;
  self.regendelayreductiontime = 0;
}

function reducehealthregendelay(var0) {
  if(!isDefined(self.regendelayreduction)) {
    self.regendelayreduction = 0;
    self.regendelayreductiontime = 0;
  }

  self.regendelayreduction += var0;
  self.regendelayreductiontime = gettime();
}

function playerbreathingpainsound(var0) {
  self endon("death_or_disconnect");
  self endon("deaths_door_exit");
  self endon("healed");
  self endon("last_stand_revived");
  level endon("game_ended");
  wait 0.5;

  for(;;) {
    if(scripts\mp\utility\player::isusingremote()) {
      waitframe();
      continue;
    }

    if(level.healthregendisabled) {
      self.painbreathloopsplayed++;

      if(self.painbreathloopsplayed > scripts\engine\utility::ter_op(istrue(self.hasdonepainbreathloopthislife), 1, 4)) {
        wait 1;
        self.hasdonepainbreathloopthislife = 1;
        onexitdeathsdoor(0);
        break;
      }
    }

    self playlocalsound("plr_breath_pain_ong_exh");
    wait 1.7;
  }
}

function applyshrapnelfx() {
  self endon("disconnect");
  self notify("applyShrapnelFX");
  self endon("applyShrapnelFX");
  self setclientomnvar("ui_shrapnel_overlay", 1);
  self playlocalsound("iw8_mp_perk_shrapnel");
  var0 = applyshrapnelfxinternal();

  if(istrue(var0)) {
    self setclientomnvar("ui_shrapnel_overlay", 2);
    return;
  }

  self setclientomnvar("ui_shrapnel_overlay", 3);
}

function applyshrapnelfxinternal() {
  self endon("death");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var0 = scripts\engine\utility::ref_143ae("shrapnel_ended_early", "shrapnel_ended", "force_regeneration");
  return var0 == "shrapnel_ended";
}