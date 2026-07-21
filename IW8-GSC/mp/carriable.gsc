/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\carriable.gsc
***********************************************/

_id_131EA(var_0, var_1) {
  var_2 = "_encstr_AB8E0E73E9709BD298E7141D95E8DF43";
  var_3 = level.sentrysettings[var_2];
  var_4 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0.origin, level.sentrysettings[var_2].weaponinfo);
  var_4.team = "_encstr_8E8405EA382B2A";

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_4.angles = var_0.angles;
  var_4.health = var_3.maxhealth;
  var_4.maxhealth = var_3.maxhealth;
  var_4.sentrytype = var_2;
  var_4.momentum = 0;
  var_4.heatlevel = 0;
  var_4.overheated = 0;
  var_4.cooldownwaittime = 2;
  var_4.turrettype = "_encstr_AB8E0E73E9709BD298E7141D95E8DF43";

  if(!isDefined(var_1))
    var_1 = "_encstr_B12D1BBBEAE62128738F6C69B74711B7CA7240E07338C70377CAF65574";

  var_4 setModel(var_1);
  var_4 setturretteam("_encstr_8E8405EA382B2A");
  var_4 makeunusable();
  var_4 setnodeploy(1);
  var_4 setdefaultdroppitch(0);
  var_4 setautorotationdelay(0.2);
  var_4 maketurretinoperable();
  var_4 setleftarc(80);
  var_4 setrightarc(80);
  var_4 setbottomarc(50);
  var_4 settoparc(60);
  var_4 setconvergencetime(0.6, "_encstr_BD6506F36A2B46B0");
  var_4 setconvergencetime(0.6, "_encstr_AF1904C7E3A4");
  var_4 setconvergenceheightpercent(0.65);
  var_4 setdefaultdroppitch(-89.0);
  var_4 setturretmodechangewait(1);
  var_4 solid();
  var_4 scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  var_4 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  var_4 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_0.turret = var_4;

  if(!isDefined(level.vo_paratroopers))
    level.vo_paratroopers = [];

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_4);
  wait 1;
  var_4 setmode("_encstr_97910BA3154320F8EBBA8811A2");
  var_4 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_4 sentryturret_empupdate();
  var_4 thread is_attack_available();
  var_4 thread sentry_attacktargets();
  var_4 thread sentry_handledeath();
  var_4 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  return var_4;
}

sentryturret_empstarted(var_0) {
  sentryturret_empupdate();
}

sentryturret_empcleared(var_0) {
  if(var_0) {
    return;
  }
  sentryturret_empupdate();
}

sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
  } else {
    self turretfireenable();
    self setmode("_encstr_97910BA3154320F8EBBA8811A2");
  }
}

node_fields_after_goal_skit() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.origin;
  var_1 = 0.05;
  var_2 = int(var_1 * 20);

  for(;;)
    wait(var_1);
}

is_attack_available() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_932D0C087BD23CA6CBBB553A4DE8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setCanDamage(1);

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(!isDefined(var_1) || !isPlayer(var_1) && (!isDefined(var_1.owner) || !isPlayer(var_1.owner))) {
      continue;
    }
    if(isDefined(var_9.basename)) {
      if(issubstr(var_9.basename, "_encstr_8F2C0AB2DA1CD74639B7372B")) {}
    }

    var_15 = isDefined(var_1) && isPlayer(var_1);
    var_16 = isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_17 = isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_18 = var_17 && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3";

    if(var_15 || var_16 || var_18) {
      if(!scripts\cp\utility::tryingtoleave()) {
        if(var_16)
          var_1 = var_1.owner;

        scripts\cp\cp_agent_damage::addattacker(self, var_1, var_13, var_9, var_0, var_3, var_2, undefined, undefined, var_4);
      }
    }

    scripts\cp\cp_damagefeedback::process_damage_feedback(var_13, var_1, var_0, var_8, var_4, var_9, var_2, var_2, var_7, undefined, self);
  }
}

sentry_attacktargets() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F", "_encstr_A36A07BB6038639701");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart();
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_targetlocksound() {
  self endon("_encstr_AD75063D571AE108");
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  wait 0.1;
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  wait 0.1;
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_burstfirestart() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      if(!_id_13024()) {
        break;
      }

      self shootturret();
      self notify("_encstr_8FCA0D31D5D8C656E8BE664B4E2B19");
      self.heatlevel = self.heatlevel + var_0;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

_id_13024() {
  if(istrue(self.matchdata_logaward)) {
    var_0 = self getturrettarget(0);

    if(isDefined(var_0) && isPlayer(var_0) && var_0 isparachuting())
      return 0;
  }

  return 1;
}

sentry_burstfirestop() {
  self notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
}

sentry_heatmonitor() {
  if(istrue(self._id_133BC)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1)
      wait(var_0);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > var_3) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var_4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("_encstr_BE690F1038845E50656583101090C917AF");
    }

    var_1 = self.heatlevel;
    wait 0.05;
  }
}

playheatfx() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE690F1038845E50656583101090C917AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");
  self endon("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AF3613176712CD6879D1E0DB475A708D5A8BD7A34B"), self, "_encstr_A14F0AE336178944BA076F41");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

sentry_beepsounds() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  }
}

sentry_handledeath() {
  self waittill("_encstr_AD75063D571AE108");
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);

  if(!isDefined(self)) {
    return;
  }
  self setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_88B20850478F501332D3");

  if(isDefined(self.attackerdata)) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      if(isDefined(self.attackerdata[var_1.guid]) && isDefined(self.attackerdata[var_1.guid].damage)) {
        if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.1)
          var_2 = 1;

        if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.2)
          var_2 = 2;

        if(var_2 >= 1)
          var_1 thread scripts\cp\drone\emp_drone::giverankxp("_encstr_964D15D9B1EE9B0590CA0F341F03852DDBF28178FF37A0", scripts\cp\drone\emp_drone::getscoreinfovalue("_encstr_964D15D9B1EE9B0590CA0F341F03852DDBF28178FF37A0"));
      }
    }
  }

  if(isDefined(self))
    thread sentry_deleteturret();
}

sentry_deleteturret() {
  self notify("_encstr_8C79155A3555CBE2BA61333FD011BC825FD5A39226FB03");
  self endon("_encstr_8C79155A3555CBE2BA61333FD011BC825FD5A39226FB03");
  wait 1.5;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A716129F78982C7B93C83768475162C401417F1B"), self, "_encstr_8E300878E04AE8B18198");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
  self playSound("_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
  wait 0.1;
  self notify("_encstr_990D093256B156D1B4B93B");

  if(isDefined(self))
    self delete();
}