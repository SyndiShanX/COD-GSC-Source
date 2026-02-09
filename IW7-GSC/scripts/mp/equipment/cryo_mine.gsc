/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\cryo_mine.gsc
**********************************************/

func_4ADA(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  scripts\mp\utility::printgameaction("cryo mine spawn", var_0.owner);
  var_0 thread func_4AD5();
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 waittill("missile_stuck", var_1);
  var_0 give_player_tickets(1);
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_0.hasruggedeqp = 1;
  }

  scripts\mp\weapons::ontacticalequipmentplanted(var_0, "power_cryoMine");
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 thread scripts\mp\weapons::minedamagemonitor();
  var_0.var_ABC6 = func_4AD1(var_0);
  var_0 thread scripts\mp\weapons::minedeletetrigger(var_0.var_ABC6);
  var_0 thread func_4ACE();
  var_0 missilethermal();
  var_0 missileoutline();
  var_0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", var_0.owner);
  var_0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  var_0 thread func_4AD7();
  var_0 thread func_4AD4();
  var_0 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  var_0 setscriptablepartstate("plant", "active", 0);
  var_0.shouldnotblockspawns = 1;
  thread scripts\mp\weapons::outlineequipmentforowner(var_0, self);
  var_0 thread scripts\mp\entityheadicons::setheadicon_factionimage(self, (0, 0, 20), 0.1);
}

func_4ACE() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.owner endon("disconnect");
  wait(2);
  thread func_4ADC();
}

func_4AD9(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  scripts\mp\utility::printgameaction("cryo mine triggered", self.owner);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\mp\weapons::explosivetrigger(var_0, 0.3, "cryoMine");
  thread func_4AD6(self.owner);
}

func_4AD6(var_0) {
  thread func_4AD2(0.1);
  self setentityowner(var_0);
  self func_8593();
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
}

func_4AD3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  thread func_4AD2(var_0 + 0.1);
  wait(var_0);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

func_4AD2(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self.exploding = 1;
  var_1 = self.owner;
  if(isDefined(self.owner)) {
    var_1.plantedtacticalequip = scripts\engine\utility::array_remove(var_1.plantedtacticalequip, self);
    var_1 notify("cryo_mine_update", 0);
  }

  wait(var_0);
  self delete();
}

func_4AD7() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);
  if(isDefined(var_1)) {
    if(var_1 != var_0) {
      var_0 thread scripts\mp\utility::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
    }

    thread func_4AD6(var_1);
    return;
  }

  thread func_4AD6(var_0);
}

func_4AD4() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 scripts\mp\killstreaks\killstreaks::func_83A0();
    if(isDefined(var_3) && var_3 == "emp_grenade_mp") {
      var_0 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  var_5 = "";
  if(scripts\mp\utility::istrue(self.hasruggedeqp)) {
    var_5 = "hitequip";
  }

  if(isPlayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_5);
  }

  thread func_4AD3();
}

func_4AD5() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::waittill_any("game_ended", "start_bro_shot");
  thread func_4AD3();
}

func_4ADC() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.owner endon("disconnect");
  var_0 = self.var_ABC6;
  while(isDefined(var_0)) {
    var_0 waittill("trigger", var_1);
    if(func_4ADB(var_1)) {
      thread func_4AD9(var_1);
    }
  }
}

func_4AD1(var_0) {
  var_1 = spawn("trigger_rotatable_radius", var_0.origin, 0, 128, 100);
  var_1.angles = var_0.angles;
  var_1 enablelinkto();
  var_1 linkto(var_0);
  var_1 hide();
  return var_1;
}

func_4ACF(var_0, var_1) {
  if(!isPlayer(self) || !isDefined(var_0)) {
    return;
  }

  var_2 = var_0 scripts\mp\powerloot::func_7FC1("power_cryoMine", 4.5);
  if(scripts\mp\utility::_hasperk("specialty_stun_resistance")) {
    scripts\mp\perks\perkfunctions::applystunresistence(var_0, self);
    var_2 = 0.5;
  }

  if(isDefined(var_1)) {
    var_2 = var_2 + var_1;
  }

  thread func_4AD8(var_0, var_2);
  scripts\mp\killstreaks\_chill_common::chill(var_0 getentitynumber(), var_2);
  var_0 scripts\mp\damage::combatrecordtacticalstat("power_cryoMine");
}

func_4ADB(var_0) {
  var_1 = var_0;
  if(!isDefined(var_0)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  if(isPlayer(var_0) || isagent(var_0)) {
    if(scripts\mp\utility::func_9F72(var_0)) {
      return 0;
    }

    if(scripts\mp\utility::func_9F22(var_0)) {
      var_1 = var_0.owner;
    }

    if(!scripts\mp\utility::isreallyalive(var_0)) {
      return 0;
    }

    if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.owner, var_1))) {
      return 0;
    }

    if(lengthsquared(var_0 getentityvelocity()) < 0.0001) {
      return 0;
    }

    var_2 = scripts\common\trace::create_contents(0, 1, 0, 0, 1, 0, 0);
    var_3 = physics_raycast(self.origin, var_0 getEye(), var_2, self, 0, "physicsquery_closest");
    if(isDefined(var_3) && var_3.size > 0) {
      var_3 = physics_raycast(self.origin, var_0.origin, var_2, self, 0, "physicsquery_closest");
      if(isDefined(var_3) && var_3.size > 0) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

func_4AD8(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("disconnect");
  var_2 = var_0 getentitynumber();
  self notify("cryoGrenade_trackDebuff_" + var_2);
  self endon("cryoGrenade_trackDebuff_" + var_2);
  scripts\mp\weapons::func_F7FC();
  scripts\mp\gamescore::func_11ACE(var_0, self, "cryo_mine_mp");
  scripts\engine\utility::waittill_any_timeout(var_1, "chillEnd");
  scripts\mp\weapons::func_F800();
  scripts\mp\gamescore::untrackdebuffassist(var_0, self, "cryo_mine_mp");
}