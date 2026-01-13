/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3571.gsc
**************************************/

func_BFBE() {
  level._effect["niagara_expl"] = loadfx("vfx\iw7\_requests\mp\power\vfx_niagara_airburst_expl");
}

func_BFCB() {
  self.var_BFB8 = spawnStruct();
  self.var_BFB8.isactive = 1;
  thread func_BFCD();
}

func_BFCD() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  self.var_BFB8.var_13CE4 = self getcurrentprimaryweapon();

  if(self.var_BFB8.var_13CE4 == "none") {
    self.var_BFB8.var_13CE4 = self.lastdroppableweaponobj;
  }

  scripts\engine\utility::allow_weapon_switch(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::allow_usability(0);
  self.var_BFB8.disabledusability = 1;
  self giveweapon("iw7_niagara_mp");
  scripts\mp\utility::_switchtoweaponimmediate("iw7_niagara_mp");
  self setweaponammoclip("iw7_niagara_mp", 2);
  self setweaponammostock("iw7_niagara_mp", 0);
  self disableweaponpickup();
  self.var_BFB8.var_55DB = 1;
  var_0 = "none";

  while(var_0 != "iw7_niagara_mp") {
    self waittill("weapon_change", var_0);
  }

  thread func_BFCC();
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_usability(1);
  self.var_BFB8.disabledusability = undefined;
  thread func_BFC5();
  thread func_BFC8();
  thread func_BFC3();
}

func_BFBB(var_0, var_1) {
  self notify("niagara_end");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(self hasweapon("iw7_niagara_mp") && var_0) {
    if(self getcurrentprimaryweapon() == "iw7_niagara_mp") {
      if(!isDefined(var_1) || var_1 == "none" || !scripts\mp\weapons::isprimaryweapon(var_1)) {
        var_1 = self.var_BFB8.var_13CE4;
      }

      if(!self hasweapon(var_1)) {
        var_1 = self.lastdroppableweaponobj;
      }

      if(isDefined(var_1) && self hasweapon(var_1)) {
        scripts\mp\utility::_switchtoweaponimmediate(var_1);
      }
    }

    scripts\mp\utility::_takeweapon("iw7_niagara_mp");
  }

  if(isDefined(self.var_BFB8.var_55DB)) {
    self _meth_80DB();
  }

  if(isDefined(self.var_BFB8.disabledusability)) {
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\engine\utility::allow_offhand_weapons(1);
    scripts\engine\utility::allow_usability(1);
  }

  if(isDefined(self.var_BFB8.disabledfire)) {
    self allowfire(1);
  }

  self.var_BFB8 = undefined;
  self notify("powers_niagara_update", -1);
}

func_BFC8() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  var_0 = "iw7_niagara_mp";

  while(var_0 == "iw7_niagara_mp") {
    self waittill("weapon_change", var_0);
  }

  thread func_BFBB(1, var_0);
}

func_BFC7() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  var_0 = scripts\mp\powers::func_D735("power_niagara");
  self notifyonplayercommand("niagara_button_pressed", var_0);
  self waittill("niagara_button_pressed");
  thread func_BFBB();
}

func_BFC3() {
  self endon("niagara_end");
  scripts\engine\utility::waittill_any("death", "disconnect");
  thread func_BFBB(0, undefined);
}

func_BFBC(var_0) {
  thread func_BFBD();
  self allowfire(0);
  self.var_BFB8.disabledfire = 1;
  var_1 = self getammocount("iw7_niagara_mp");
  var_2 = var_1 * 0.5;
  self notify("powers_niagara_update", var_2);
  var_3 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0.killcament = var_3;
  var_0.var_6C1A = var_1 == 0;
  thread func_BFC0(var_3);
  thread func_BFC1(var_3, var_0);
  thread func_BFC4(var_0, var_3);

  if(var_0.var_6C1A) {
    thread func_BFC6(var_0, var_3, 1);
  } else {
    thread func_BFC6(var_0, var_3, 0);
  }

  self.var_BFB8.var_6D96 = gettime();
  self.var_BFB8.var_6D9A = anglesToForward(self getplayerangles()) * 1175 + (0, 0, 10);
}

func_BFC5() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
}

func_BFC4(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  var_0 endon("death");
  self notifyonplayercommand("niagara_detonateButtonPressed", "+attack");
  self notifyonplayercommand("niagara_detonateButtonPressed", "+attack_akimbo_accessible");
  self notifyonplayercommand("niagara_detonateButtonPressed", "+smoke");
  self waittill("niagara_detonateButtonPressed");
  var_2 = (gettime() - self.var_BFB8.var_6D96) / 1000;
  var_3 = self.var_BFB8.var_6D9A + (0, 0, -800) * var_2 * var_2;
  var_4 = vectortoangles(var_3);
  var_5 = (0, 0, 1) * vectordot(var_3, (0, 0, 1));
  var_6 = var_3 - var_5;
  var_5 = var_5 * 1;
  var_6 = var_6 * 0.7;
  var_3 = var_5 + var_6;
  var_3 = var_3 + (0, 0, 55);
  var_7 = [];
  var_8 = self launchgrenade("niagara_mini_mp", var_0.origin, var_3);
  var_8.var_9E9E = 1;
  var_8.weapon_name = "iw7_niagara_mp";
  var_8.killcament = var_0.killcament;
  var_7[var_7.size] = var_8;
  var_9 = 0;
  var_10 = 45 + var_9;
  var_11 = 90;
  var_12 = randomfloatrange(45, 75);

  for(var_13 = 0; var_13 < 4; var_13++) {
    var_14 = var_10 + var_13 * 90;
    var_15 = var_3;
    var_15 = var_15 + anglestoright(var_4) * cos(var_14) * var_12;
    var_15 = var_15 + anglestoup(var_4) * sin(var_14) * var_12;
    var_8 = self launchgrenade("niagara_mini_mp", var_0.origin, var_15);
    var_8.var_9E9E = 1;
    var_8.killcament = var_0.killcament;
    var_7[var_7.size] = var_8;
  }

  var_10 = 0 + var_9;
  var_11 = 90;
  var_12 = randomfloatrange(95, 125);

  for(var_13 = 0; var_13 < 4; var_13++) {
    var_14 = var_10 + var_13 * 90;
    var_15 = var_3;
    var_15 = var_15 + anglestoright(var_4) * cos(var_14) * var_12;
    var_15 = var_15 + anglestoup(var_4) * sin(var_14) * var_12;
    var_8 = self launchgrenade("niagara_mini_mp", var_0.origin, var_15);
    var_8.var_9E9E = 1;
    var_8.weapon_name = "iw7_niagara_mp";
    var_8.killcament = var_0.killcament;
    var_7[var_7.size] = var_8;
  }

  self.var_BFB8.var_6D9A = undefined;
  self.var_BFB8.var_6D96 = undefined;
  var_0 radiusdamage(var_0.origin, 128, 15, 65, self, "MOD_EXPLOSIVE", "iw7_niagara_mp");
  thread func_BFBA(var_0.origin, var_0.angles);
  thread func_BFC2(var_1, var_7);

  if(var_0.var_6C1A) {
    thread func_BFC6(var_0, undefined, 1);
  } else {
    thread func_BFC6(var_0, undefined, 0);
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_BFC6(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  self notify("niagara_monitorMissileDeath_" + var_0 getentitynumber());
  self endon("niagara_monitorMissileDeath_" + var_0 getentitynumber());
  var_0 waittill("death");
  wait 0.25;

  if(isDefined(self.var_BFB8.disabledfire)) {
    self allowfire(1);
    self.var_BFB8.disabledfire = undefined;
  }

  if(var_2) {
    thread func_BFBB();
  }

  scripts\engine\utility::waitframe();

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_BFC1(var_0, var_1) {
  self endon("niagara_killCamPhase1End" + var_0 getentitynumber());
  var_0 endon("death");
  var_2 = var_1.origin;

  for(;;) {
    var_3 = var_2 - var_0.origin;

    if(lengthsquared(var_3) > 1024) {
      var_0 moveto(var_2, 0.1, 0, 0);
    }

    var_0 rotateto(vectortoangles(var_3), 0.1);
    wait 0.1;

    if(isDefined(var_1)) {
      var_2 = var_1.origin;
    }
  }
}

func_BFC2(var_0, var_1) {
  var_0 endon("death");
  self notify("niagara_killCamPhase1End" + var_0 getentitynumber());
  var_2 = func_BFB9(var_1);

  for(;;) {
    var_3 = var_2 - var_0.origin;

    if(lengthsquared(var_3) > 65536) {
      var_0 moveto(var_2, 0.15, 0, 0);
    }

    var_0 rotateto(vectortoangles(var_3), 0.15);
    wait 0.15;
    var_2 = func_BFB9(var_1);

    if(!isDefined(var_2)) {
      break;
    }
  }

  scripts\engine\utility::waitframe();
  var_0 delete();
}

func_BFBF(var_0) {
  return var_0;
}

func_BFC0(var_0) {
  var_0 endon("death");
  self waittill("disconnect");
  var_0 delete();
}

func_BFB9(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_2 = var_2 + var_4.origin;
    var_1++;
  }

  if(var_1 == 0) {
    return undefined;
  }

  return var_2 / var_1;
}

func_BFBA(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("niagara_expl"), var_0, anglesToForward(var_1), anglestoup(var_1));
  playsoundatpos(var_0, "grenade_explode_scr");
}