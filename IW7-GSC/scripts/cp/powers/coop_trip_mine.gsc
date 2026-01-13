/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_trip_mine.gsc
************************************************/

tripmine_init() {
  level._effect["tripMineLaserFr"] = loadfx("vfx\iw7\_requests\mp\power\vfx_trip_mine_beam_friendly.vfx");
}

tripmine_used(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  thread func_127D3(self);
  var_0 waittill("missile_stuck", var_1);
  var_0 setotherent(self);
  var_0 give_player_tickets(1);
  var_0.var_ABC7 = func_127EB(var_0);
  thread scripts\cp\cp_weapon::minedeletetrigger(var_0.var_ABC7);
  var_0.var_ABC9 = func_127EC(var_0);
  thread scripts\cp\cp_weapon::minedeletetrigger(var_0.var_ABC9);
  scripts\cp\cp_weapon::onlethalequipmentplanted(var_0, "power_tripMine");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0 thread func_127DC();
  var_0 setscriptablepartstate("plant", "active", 0);
  var_0 thread func_127D1();
}

func_127EB(var_0) {
  var_1 = var_0 gettagorigin("tag_laser");
  var_2 = var_0.angles;
  var_3 = spawn("trigger_rotatable_radius", var_1, 0, 3, 1000);
  var_3.angles = var_2;
  var_3 enablelinkto();
  var_3 linkto(var_0);
  var_3 hide();
  return var_3;
}

func_127EC(var_0) {
  var_1 = spawn("trigger_rotatable_radius", var_0.origin, 0, 32, 32);
  var_1.angles = var_0.angles;
  var_1 enablelinkto();
  var_1 linkto(var_0);
  var_1 hide();
  return var_1;
}

func_127D1() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  wait(1);
  var_0 = self gettagorigin("tag_laser");
  var_1 = var_0 + anglestoup(self.angles) * 1000;
  thread func_127E0(var_0, var_1);
  thread func_127F4();
}

func_127DC() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  var_0 = self.triggerportableradarping;
  self waittill("detonateExplosive", var_1);
  if(isDefined(var_1)) {
    thread func_127DB(var_1);
    return;
  }

  thread func_127DB(var_0);
}

func_127D8() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("emp_damage", var_0, var_1);
  if(isDefined(self.triggerportableradarping) && var_0 != self.triggerportableradarping) {
    var_0 notify("destroyed_equipment");
  }

  thread func_127D7();
}

func_127DB(var_0) {
  thread func_127D6(5);
  self setentityowner(var_0);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "active_cp", 0);
}

func_127D7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  thread func_127D6(var_0 + 2);
  wait(var_0);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

func_127E7(var_0) {
  var_1 = spawn("script_model", self gettagorigin("tag_laser"));
  var_1.angles = self.angles;
  var_1 setotherent(self.triggerportableradarping);
  var_1 setentityowner(self.triggerportableradarping);
  var_1 setModel("trip_mine_wm_projectile");
  var_1.triggerportableradarping = self.triggerportableradarping;
  var_1.team = self.team;
  var_1.weapon_name = "trip_mine_mp";
  var_1.power = "power_tripMine";
  var_1.killcament = self;
  thread func_127D7(0.2);
  var_1 moveto(var_0, 0.2, 0.1);
  wait(0.2);
  var_2 = undefined;
  if(isDefined(var_1.triggerportableradarping)) {
    var_2 = 5;
    var_1 setscriptablepartstate("explode", "active_cp", 0);
  } else {
    var_2 = 2;
    var_1 setscriptablepartstate("destroy", "active", 0);
  }

  wait(var_2);
  var_1 delete();
}

func_127F4() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.var_6316 endon("death");
  self.triggerportableradarping endon("disconnect");
  var_0 = self.var_ABC7;
  var_1 = func_127D2();
  while(isDefined(var_0)) {
    var_0 waittill("trigger", var_2);
    if(!func_127E4(var_2, 1)) {
      continue;
    }

    var_3 = scripts\engine\utility::ter_op(isplayer(var_2) || isagent(var_2), var_2 gettagorigin("j_helmet"), var_2.origin);
    var_4 = self gettagorigin("tag_laser");
    var_5 = self.var_6316.origin;
    var_6 = scripts\engine\utility::closestdistancebetweensegments(var_2.origin, var_3, var_4, var_5);
    if(!isDefined(var_6)) {
      continue;
    }

    var_7 = var_6[0];
    var_8 = var_6[1];
    var_9 = var_6[2];
    var_0A = var_8[2] > var_3[2];
    var_0B = var_8[2] < var_2.origin[2];
    if(var_0A || var_0B || var_9 > 16) {
      continue;
    }

    thread func_127E8(var_2, var_8);
    break;
  }
}

func_127F7() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_0 = self.var_ABC9;
  var_1 = func_127D2();
  while(isDefined(var_0)) {
    var_0 waittill("trigger", var_2);
    if(!func_127E4(var_2, 0)) {
      continue;
    }

    var_3 = scripts\engine\utility::ter_op(isplayer(var_2) || isagent(var_2), var_2 getEye(), var_2.origin);
    var_4 = function_0287(self.origin, var_2 getEye(), var_1, self, 0, "physicsquery_closest");
    if(isDefined(var_4) && var_4.size > 0) {
      continue;
    }

    var_5 = self.origin;
    var_6 = self.var_6316.origin;
    var_7 = var_5 + var_6 - var_5 * 0.2;
    thread func_127E8(var_2, var_7);
    break;
  }
}

func_127E8(var_0, var_1) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self notify("mine_triggered");
  self setscriptablepartstate("trigger", "active", 0);
  scripts\cp\cp_weapon::explosivetrigger(var_0, 0.3, "tripMine");
  thread func_127E7(var_1);
}

func_127E4(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isplayer(var_0) || isagent(var_0)) {
    if(scripts\cp\powers\coop_phaseshift::isentityphaseshifted(var_0)) {
      return 0;
    }

    if(!scripts\cp\utility::isreallyalive(var_0)) {
      return 0;
    }

    if(self.team == var_0.team) {
      return 0;
    }

    if(!var_1 && lengthsquared(var_0 getentityvelocity()) < 0.0001) {
      return 0;
    }

    return 1;
  }

  return 1;
}

func_127E0(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  var_3 = spawn("script_model", var_1);
  var_3 setModel("tag_origin");
  self.var_10D97 = var_2;
  self.var_6316 = var_3;
  self.var_10D97 linkto(self);
  self.var_6316 linkto(self.var_10D97);
  self.var_41F6 = [];
  self.var_41EF = [];
  scripts\engine\utility::waitframe();
  if(!isDefined(self)) {
    var_2 delete();
    var_3 delete();
    return;
  }

  var_4 = self.triggerportableradarping;
  var_5 = self.triggerportableradarping.team;
  foreach(var_7 in level.players) {
    if(!isDefined(var_7)) {
      continue;
    }

    var_8 = var_7 getentitynumber();
    self.var_41F6[var_8] = var_7;
    self.var_41EF[var_8] = function_02DF(scripts\engine\utility::getfx("tripMineLaserFr"), self.var_10D97, "tag_origin", self.var_6316, "tag_origin", var_7);
  }

  thread func_127F0();
  thread func_127EF();
  thread func_127F1();
  func_127E1();
  self.var_10D97 delete();
  self.var_6316 delete();
  foreach(var_0B in self.var_41EF) {
    if(isDefined(var_0B)) {
      var_0B delete();
    }
  }
}

func_127E1() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("forever");
}

func_127F0() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_0 = self.triggerportableradarping;
  var_1 = self.triggerportableradarping.team;
  for(;;) {
    level waittill("joined_team", var_2);
    var_3 = var_2 getentitynumber();
    self.var_41F6[var_3] = var_2;
    if(isDefined(self.var_41EF[var_3])) {
      self.var_41EF[var_3] delete();
    }

    self.var_41EF[var_3] = function_02DF(scripts\engine\utility::getfx("tripMineLaserFr"), self.var_10D97, "tag_origin", self.var_6316, "tag_origin", var_2);
  }
}

func_127EF() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  for(;;) {
    foreach(var_2, var_1 in self.var_41F6) {
      if(!isDefined(var_1)) {
        if(isDefined(self.var_41EF[var_2])) {
          self.var_41EF[var_2] delete();
        }

        self.var_41F6[var_2] = undefined;
        self.var_41EF[var_2] = undefined;
      }
    }

    wait(0.1);
  }
}

func_127F1() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_0 = func_127D2();
  for(;;) {
    var_1 = self.var_10D97.origin;
    var_2 = var_1 + anglestoup(self.angles) * 1000;
    var_3 = function_0287(var_1, var_2, var_0, self, 0, "physicsquery_closest");
    if(isDefined(var_3) && var_3.size > 0) {
      var_2 = var_3[0]["position"];
    }

    self.var_6316 unlink();
    self.var_6316.origin = var_2;
    self.var_6316 linkto(self.var_10D97);
    scripts\engine\utility::waitframe();
  }
}

func_127D6(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  self freeentitysentient();
  self.exploding = 1;
  var_1 = self.triggerportableradarping;
  if(isDefined(self.triggerportableradarping)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
    var_1 notify("c4_update", 0);
  }

  wait(var_0);
  self delete();
}

func_127D2() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_water", "physicscontents_sky", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_item", "physicscontents_missileclip"]);
}

func_127D3(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_0 waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }
}