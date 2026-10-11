/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_62df8493dd83fb28.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_39ae84cf3eeebf70;
#using script_3ed005fe9b78b9da;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\player;
#namespace namespace_b438437e20a33dfb;

function function_3a1cb71d78e0d1() {
  addpowerbutton(self, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &playerzombiejump, 0, undefined, &function_cc58e93121695bbc, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, 6, "jumpStatus", "jumpProgress");
  addpowerbutton(self, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &playerzombiejumpstop, 0);
}

function playerzombiejump(powerstruct, powerref) {
  if(!isDefined(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self playsoundonmovingent("jup_mp_mode_mutation_explosion_charge");
  thread play_loop_sound_on_entity("jup_mp_mode_mutation_explosion_charged_lp");
  self playsoundonmovingent("jup_mp_mode_mutation_zmb_npc_effort");
  var_4ca6e232b3a08ae5 = -1;
  var_e8b1539c9f6ccbc1 = getdvarfloat(@ "hash_2fc6c2dc7f9c722a", 1);
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_6b00aa3867c7f0d9 = getdvarint(@ "hash_69111e35067f9d8f", var_4ca6e232b3a08ae5);
  var_57bd73d0ecaee169 = var_e8b1539c9f6ccbc1 * level.framedurationseconds;
  self.var_17c60a92aea65107 = 0;
  self allowmelee(0);

  if(!function_77bab0532bc12f0e()) {
    self setcamerathirdperson(1);
  }

  self disableoffhandweapons();
  var_715d7709363e068c = undefined;
  progress = 0;

  if(!isDefined(self.var_741cb4edf0f0590c) || gettime() > self.var_741cb4edf0f0590c) {
    self.var_741cb4edf0f0590c = gettime() + 500;
  }

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 0);
  }

  while(!function_77bab0532bc12f0e()) {
    if(level.var_ec4da42b3bbf344c.hudserver) {
      self.powershud[powerref].barelem updatebar(self.var_17c60a92aea65107, 0);
    } else {
      self.powershud[powerref].frac = self.var_17c60a92aea65107;
    }

    prevfrac = self.var_17c60a92aea65107;
    self.var_17c60a92aea65107 += var_57bd73d0ecaee169;

    if(self.var_17c60a92aea65107 >= 1) {
      self.var_17c60a92aea65107 = 1;

      if(var_6b00aa3867c7f0d9 >= 0) {
        if(!isDefined(var_715d7709363e068c)) {
          var_715d7709363e068c = gettime() + var_6b00aa3867c7f0d9 * 1000;
        }

        if(gettime() >= var_715d7709363e068c) {
          break;
        }
      }
    }

    if(level.var_ec4da42b3bbf344c.hudserver && prevfrac < var_eec1ca5327266614 && self.var_17c60a92aea65107 >= var_eec1ca5327266614) {
      self.powershud[powerref].barelem.bar.color = (0, 1, 0);
    }

    if(prevfrac < 1 && self.var_17c60a92aea65107 >= 1) {}

    if(isDefined(powerstruct.powers[powerref].progressupdate)) {
      progress = max(int(self.var_17c60a92aea65107 * 100), 0);
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, progress);
    }

    waitframe();
  }

  thread function_a1b195bc24dae315(powerstruct, powerref);
}

function function_a1b195bc24dae315(powerstruct, powerref) {
  self notify("playerZombieJumpChargeEnd");
  self notify("playerZombieJumpStop");
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_e5482b00771c4909 = getdvarint(@ "hash_2a5201ccbcd3b1a1", 1);
  var_b13a0e71ef0de57c = 1;

  if(self.var_17c60a92aea65107 >= var_eec1ca5327266614 && !function_77bab0532bc12f0e() && !self isinexecutionvictim()) {
    thread function_33624f248fcd577d();
  } else {
    if(var_e5482b00771c4909) {
      if(level.var_ec4da42b3bbf344c.hudserver) {
        self.powershud[powerref].barelem.bar.frac = 0;
      } else {
        self.powershud[powerref].frac = 0;
      }

      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 0);
      self enableoffhandweapons();
      self allowmelee(1);
      self notify("endSuperJumpFov");
    }

    function_e63114420500fb();

    if(function_77bab0532bc12f0e()) {
      function_ae8ecf6e5f68f1ea(self.var_ee75699e65f68166);
    }

    thread function_f2ddb7c78178c1be(powerstruct, powerref);

    if(istrue(self.var_e11136acf00d18f) || !isDefined(self.var_e11136acf00d18f)) {
      self setcamerathirdperson(0);
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 100);
      var_b13a0e71ef0de57c = 0;
    }
  }

  function_cc58e93121695bbc(powerstruct, powerref, var_b13a0e71ef0de57c);
}

function function_cc58e93121695bbc(powerstruct, powerref, docooldown) {
  if(istrue(docooldown)) {
    thread playerpowerstartcooldown(powerstruct, powerref);
  }

  self enableoffhandweapons();
  self.var_e11136acf00d18f = undefined;
  self.var_17c60a92aea65107 = undefined;
  self playSound("jup_mp_mode_mutation_zombie_superjump_leap");
  self playSound("jup_mp_mode_mutation_zombie_superjump_whoosh");
}

function function_33624f248fcd577d() {
  self endon("death_or_disconnect");
  gren = magicgrenademanual("jup_mutant_sludger_explode_mp", self.origin + (0, 0, 32), (0, 0, 0), 0.1);
  gren detonate(self);
  self playerhide(1);
  self sethidenameplate(1);
  self.var_f07121951ba8e9a5 = undefined;
  self.var_741cb4edf0f0590c = undefined;
  val::set("sludger_explode", "freezecontrols", 1);
  wait 1.5;
  level thread namespace_53fc9ddbb516e6e1::fadetoblackforplayersharedfunc(self, 1, 0.5);
  wait 1;
  level thread namespace_53fc9ddbb516e6e1::fadetoblackforplayersharedfunc(self, 0, 0.5);
  spawnpoint = self[[level.getspawnpoint]]();
  self setOrigin(spawnpoint.origin);

  if(isDefined(spawnpoint.angles)) {
    self setplayerangles(spawnpoint.angles);
  }

  self playershow();
  self sethidenameplate(0);
  val::set("sludger_explode", "freezecontrols", 0);
  wait 1;
  self allowmelee(1);
  self setcamerathirdperson(0);
}

function playerzombiejumpstop(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self playSound("jup_mp_mode_mutation_sludge_expl_vo");
  thread stop_loop_sound_on_entity("jup_mp_mode_mutation_explosion_charged_lp");
  waittillframeend();

  if(isDefined(self.var_17c60a92aea65107)) {
    function_a1b195bc24dae315(powerstruct, "jump");
    return;
  }

  self notify("playerZombieJumpStop");
}