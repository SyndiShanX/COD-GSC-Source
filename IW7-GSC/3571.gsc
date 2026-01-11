/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3571.gsc
***************************************/

func_BFBE() {
  level._effect["niagara_expl"] = loadfx("vfx\iw7\_requests\mp\power\vfx_niagara_airburst_expl");
}

func_BFCB() {
  self.func_BFB8 = spawnStruct();
  self.func_BFB8.isactive = 1;
  thread func_BFCD();
}

func_BFCD() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  self.func_BFB8.func_13CE4 = self getcurrentprimaryweapon();

  if(self.func_BFB8.func_13CE4 == "none") {
    self.func_BFB8.func_13CE4 = self.lastdroppableweaponobj;
  }

  scripts\engine\utility::allow_weapon_switch(0);
  scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::allow_usability(0);
  self.func_BFB8.disabledusability = 1;
  self giveweapon("iw7_niagara_mp");
  scripts\mp\utility::_switchtoweaponimmediate("iw7_niagara_mp");
  self setweaponammoclip("iw7_niagara_mp", 2);
  self setweaponammostock("iw7_niagara_mp", 0);
  self disableweaponpickup();
  self.func_BFB8.func_55DB = 1;
  var_00 = "none";

  while(var_00 != "iw7_niagara_mp") {
    self waittill("weapon_change", var_00);
  }

  thread func_BFCC();
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\engine\utility::allow_offhand_weapons(1);
  scripts\engine\utility::allow_usability(1);
  self.func_BFB8.disabledusability = undefined;
  thread func_BFC5();
  thread func_BFC8();
  thread func_BFC3();
}

func_BFBB(var_00, var_01) {
  self notify("niagara_end");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  if(self hasweapon("iw7_niagara_mp") && var_00) {
    if(self getcurrentprimaryweapon() == "iw7_niagara_mp") {
      if(!isDefined(var_01) || var_01 == "none" || !scripts\mp\weapons::isprimaryweapon(var_01)) {
        var_01 = self.func_BFB8.func_13CE4;
      }

      if(!self hasweapon(var_01)) {
        var_01 = self.lastdroppableweaponobj;
      }

      if(isDefined(var_01) && self hasweapon(var_01)) {
        scripts\mp\utility::_switchtoweaponimmediate(var_01);
      }
    }

    scripts\mp\utility::_takeweapon("iw7_niagara_mp");
  }

  if(isDefined(self.func_BFB8.func_55DB)) {
    self _meth_80DB();
  }

  if(isDefined(self.func_BFB8.disabledusability)) {
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\engine\utility::allow_offhand_weapons(1);
    scripts\engine\utility::allow_usability(1);
  }

  if(isDefined(self.func_BFB8.disabledfire)) {
    self allowfire(1);
  }

  self.func_BFB8 = undefined;
  self notify("powers_niagara_update", -1);
}

func_BFC8() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  var_00 = "iw7_niagara_mp";

  while(var_00 == "iw7_niagara_mp") {
    self waittill("weapon_change", var_00);
  }

  thread func_BFBB(1, var_00);
}

func_BFC7() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  var_00 = scripts\mp\powers::func_D735("power_niagara");
  self notifyonplayercommand("niagara_button_pressed", var_00);
  self waittill("niagara_button_pressed");
  thread func_BFBB();
}

func_BFC3() {
  self endon("niagara_end");
  scripts\engine\utility::waittill_any("death", "disconnect");
  thread func_BFBB(0, undefined);
}

func_BFBC(var_00) {
  thread func_BFBD();
  self allowfire(0);
  self.func_BFB8.disabledfire = 1;
  var_01 = self getammocount("iw7_niagara_mp");
  var_02 = var_01 * 0.5;
  self notify("powers_niagara_update", var_02);
  var_03 = var_00 scripts\engine\utility::spawn_tag_origin();
  var_0.killcament = var_03;
  var_0.func_6C1A = var_01 == 0;
  thread func_BFC0(var_03);
  thread func_BFC1(var_03, var_00);
  thread func_BFC4(var_00, var_03);

  if(var_0.func_6C1A) {
    thread func_BFC6(var_00, var_03, 1);
  } else {
    thread func_BFC6(var_00, var_03, 0);
  }

  self.func_BFB8.func_6D96 = gettime();
  self.func_BFB8.func_6D9A = anglesToForward(self getplayerangles()) * 1175 + (0, 0, 10);
}

func_BFC5() {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
}

func_BFC4(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  var_00 endon("death");
  self notifyonplayercommand("niagara_detonateButtonPressed", "+attack");
  self notifyonplayercommand("niagara_detonateButtonPressed", "+attack_akimbo_accessible");
  self notifyonplayercommand("niagara_detonateButtonPressed", "+smoke");
  self waittill("niagara_detonateButtonPressed");
  var_02 = (gettime() - self.func_BFB8.func_6D96) / 1000;
  var_03 = self.func_BFB8.func_6D9A + (0, 0, -800) * var_02 * var_02;
  var_04 = vectortoangles(var_03);
  var_05 = (0, 0, 1) * vectordot(var_03, (0, 0, 1));
  var_06 = var_03 - var_05;
  var_05 = var_05 * 1;
  var_06 = var_06 * 0.7;
  var_03 = var_05 + var_06;
  var_03 = var_03 + (0, 0, 55);
  var_07 = [];
  var_08 = self launchgrenade("niagara_mini_mp", var_0.origin, var_03);
  var_8.func_9E9E = 1;
  var_8.weapon_name = "iw7_niagara_mp";
  var_8.killcament = var_0.killcament;
  var_7[var_7.size] = var_08;
  var_09 = 0;
  var_10 = 45 + var_09;
  var_11 = 90;
  var_12 = randomfloatrange(45, 75);

  for(var_13 = 0; var_13 < 4; var_13++) {
    var_14 = var_10 + var_13 * 90;
    var_15 = var_03;
    var_15 = var_15 + anglestoright(var_04) * cos(var_14) * var_12;
    var_15 = var_15 + anglestoup(var_04) * sin(var_14) * var_12;
    var_08 = self launchgrenade("niagara_mini_mp", var_0.origin, var_15);
    var_8.func_9E9E = 1;
    var_8.killcament = var_0.killcament;
    var_7[var_7.size] = var_08;
  }

  var_10 = 0 + var_09;
  var_11 = 90;
  var_12 = randomfloatrange(95, 125);

  for(var_13 = 0; var_13 < 4; var_13++) {
    var_14 = var_10 + var_13 * 90;
    var_15 = var_03;
    var_15 = var_15 + anglestoright(var_04) * cos(var_14) * var_12;
    var_15 = var_15 + anglestoup(var_04) * sin(var_14) * var_12;
    var_08 = self launchgrenade("niagara_mini_mp", var_0.origin, var_15);
    var_8.func_9E9E = 1;
    var_8.weapon_name = "iw7_niagara_mp";
    var_8.killcament = var_0.killcament;
    var_7[var_7.size] = var_08;
  }

  self.func_BFB8.func_6D9A = undefined;
  self.func_BFB8.func_6D96 = undefined;
  var_00 radiusdamage(var_0.origin, 128, 15, 65, self, "MOD_EXPLOSIVE", "iw7_niagara_mp");
  thread func_BFBA(var_0.origin, var_0.angles);
  thread func_BFC2(var_01, var_07);

  if(var_0.func_6C1A) {
    thread func_BFC6(var_00, undefined, 1);
  } else {
    thread func_BFC6(var_00, undefined, 0);
  }

  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_BFC6(var_00, var_01, var_02) {
  self endon("death");
  self endon("disconnect");
  self endon("niagara_end");
  self notify("niagara_monitorMissileDeath_" + var_00 getentitynumber());
  self endon("niagara_monitorMissileDeath_" + var_00 getentitynumber());
  var_00 waittill("death");
  wait 0.25;

  if(isDefined(self.func_BFB8.disabledfire)) {
    self allowfire(1);
    self.func_BFB8.disabledfire = undefined;
  }

  if(var_02) {
    thread func_BFBB();
  }

  scripts\engine\utility::waitframe();

  if(isDefined(var_01)) {
    var_01 delete();
  }
}

func_BFC1(var_00, var_01) {
  self endon("niagara_killCamPhase1End" + var_00 getentitynumber());
  var_00 endon("death");
  var_02 = var_1.origin;

  for(;;) {
    var_03 = var_02 - var_0.origin;

    if(lengthsquared(var_03) > 1024) {
      var_00 moveto(var_02, 0.1, 0, 0);
    }

    var_00 rotateto(vectortoangles(var_03), 0.1);
    wait 0.1;

    if(isDefined(var_01)) {
      var_02 = var_1.origin;
    }
  }
}

func_BFC2(var_00, var_01) {
  var_00 endon("death");
  self notify("niagara_killCamPhase1End" + var_00 getentitynumber());
  var_02 = func_BFB9(var_01);

  for(;;) {
    var_03 = var_02 - var_0.origin;

    if(lengthsquared(var_03) > 65536) {
      var_00 moveto(var_02, 0.15, 0, 0);
    }

    var_00 rotateto(vectortoangles(var_03), 0.15);
    wait 0.15;
    var_02 = func_BFB9(var_01);

    if(!isDefined(var_02)) {
      break;
    }
  }

  scripts\engine\utility::waitframe();
  var_00 delete();
}

func_BFBF(var_00) {
  return var_00;
}

func_BFC0(var_00) {
  var_00 endon("death");
  self waittill("disconnect");
  var_00 delete();
}

func_BFB9(var_00) {
  var_01 = 0;
  var_02 = (0, 0, 0);

  foreach(var_04 in var_00) {
    if(!isDefined(var_04)) {
      continue;
    }
    var_02 = var_02 + var_4.origin;
    var_1++;
  }

  if(var_01 == 0) {
    return undefined;
  }

  return var_02 / var_01;
}

func_BFBA(var_00, var_01) {
  playFX(scripts\engine\utility::getfx("niagara_expl"), var_00, anglesToForward(var_01), anglestoup(var_01));
  playsoundatpos(var_00, "grenade_explode_scr");
}