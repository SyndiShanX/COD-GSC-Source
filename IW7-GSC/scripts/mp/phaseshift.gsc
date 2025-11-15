/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\phaseshift.gsc
*************************************/

func_D41B() {
  level._effect["shoulder_cannon_charge"] = loadfx("vfx\old\misc\shoulder_cannon_charge");
  level._effect["shoulder_cannon_view_flash"] = loadfx("vfx\core\muzflash\minigun_flash_view");
}

func_E89C() {
  var_00 = self getcurrentweapon();
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\mp\utility::_giveweapon("phaseshift_activation_mp");
  scripts\mp\utility::_switchtoweaponimmediate("phaseshift_activation_mp");
  scripts\engine\utility::waitframe();
  scripts\mp\utility::_switchtoweapon(var_00);
  wait(0.2);
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\mp\utility::_takeweapon("phaseshift_activation_mp");
}

func_E169() {
  self notify("remove_shoulder_cannon");
}

func_D41C() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("remove_shoulder_cannon");
  func_E89C();
  self playlocalsound("trophy_turret_plant_plr");
  self playsoundtoteam("trophy_turret_plant_npc", "allies", self);
  self playsoundtoteam("trophy_turret_plant_npc", "axis", self);
  var_00 = spawnturret("misc_turret", self gettagorigin("j_shoulder_ri"), "ball_drone_gun_mp");
  var_00 linkto(self, "j_shoulder_ri", (0, 0, 0), (0, 0, 0));
  var_00 setModel("vehicle_drone_backup_buddy_gun");
  var_00.angles = self.angles;
  var_00.triggerportableradarping = self;
  var_00.team = self.team;
  var_00 getvalidattachments();
  var_00 makeunusable();
  self.vehicle = var_00;
  var_00.var_1E2D = 100;
  if(level.teambased) {
    var_00 setturretteam(self.team);
  }

  var_00 give_player_session_tokens("sentry");
  var_00 setsentryowner(self);
  var_00 setleftarc(180);
  var_00 setrightarc(180);
  var_00 give_crafted_gascan(90);
  var_00 settoparc(30);
  var_00 thread balldrone_attacktargets(self, 1);
  var_00 setturretminimapvisible(1, "buddy_turret");
  self setclientomnvar("ui_shoulder_cannon_ammo", var_00.var_1E2D);
  self setclientomnvar("ui_eng_drone_ammo_type", 1);
  self setclientomnvar("ui_shoulder_cannon_state", 0);
  var_00 setotherent(self);
  var_00.stunned = 0;
  var_00 thread func_139C8();
  thread watchforplayerdeath(var_00);
  thread func_1000B(var_00);
  self setclientomnvar("ui_shoulder_cannon", 1);
}

watchforplayerdeath(param_00) {
  self notify("cannon_deleted");
  self endon("cannon_deleted");
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  param_00 delete();
  if(isDefined(self)) {
    self setclientomnvar("ui_shoulder_cannon_ammo", 0);
    self setclientomnvar("ui_shoulder_cannon", 0);
    self setclientomnvar("ui_shoulder_cannon_target_ent", -1);
    self setclientomnvar("ui_shoulder_cannon_hud_reticle", 0);
  }
}

func_139C8() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    func_1000A(var_01);
  }
}

func_1000A(param_00) {
  self notify("shoulderCannon_stunned");
  self endon("shoulderCannon_stunned");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  self.stunned = 1;
  self notify("turretstatechange");
  wait(param_00);
  self.stunned = 0;
  self notify("turretstatechange");
}

func_F67C(param_00) {
  var_01 = 20;
  var_02 = var_01 * 1000 + gettime();
  self setclientomnvar("ui_shoulder_cannon_timer_end_milliseconds", var_02);
  self.var_38D5 = var_02;
  thread func_139CA();
  thread func_139CB(var_01, param_00);
  thread func_139C9();
}

func_139CA() {
  self notify("watchCannonTimeoutHostMigration");
  self endon("watchCannonTimeoutHostMigration");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  level waittill("host_migration_begin");
  var_00 = scripts\mp\hostmigration::waittillhostmigrationdone();
  if(var_00 > 0) {
    self setclientomnvar("ui_shoulder_cannon_timer_end_milliseconds", self.var_38D5 + var_00);
    return;
  }

  self setclientomnvar("ui_shoulder_cannon_timer_end_milliseconds", self.var_38D5);
}

func_139CB(param_00, param_01) {
  self notify("watchCannonTimer");
  self endon("watchCannonTimer");
  self endon("cannon_deleted");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_02 = 5;
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(param_00 - var_02 - 1);
  while(var_02 > 0) {
    self playsoundtoplayer("mp_cranked_countdown", self);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1);
    var_02--;
  }

  self setclientomnvar("ui_shoulder_cannon_ammo", 0);
  waittillframeend;
  self setclientomnvar("ui_shoulder_cannon", 0);
  param_01 delete();
}

func_139C9() {
  self notify("watchCannonEndGame");
  self endon("watchCannonEndGame");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_shoulder_cannon_timer_end_milliseconds", 0);
      break;
    }

    wait(0.1);
  }
}

balldrone_attacktargets(param_00, param_01) {
  self notify("turret_toggle");
  self endon("turret_toggle");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("turretstatechange");
    if(param_01 == 1) {
      if(self getteamarray() && self.var_1E2D > 0 && isDefined(self.stunned) && !self.stunned) {
        self laseron();
        balldrone_burstfirestop(0.2, param_00);
        thread balldrone_burstfirestart(param_00);
      } else {
        self laseroff();
        thread func_27D8();
        param_00 setclientomnvar("ui_shoulder_cannon_target_ent", -1);
        param_00 setclientomnvar("ui_shoulder_cannon_hud_reticle", 0);
      }

      continue;
    }

    break;
  }
}

balldrone_burstfirestart(param_00) {
  self endon("turret_toggle");
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  var_01 = self;
  var_02 = level._effect["shoulder_cannon_view_flash"];
  var_03 = level._effect["shoulder_cannon_charge"];
  var_04 = weaponfiretime("ball_drone_gun_mp");
  var_05 = 0.01;
  self.triggerportableradarping waittill("begin_firing");
  while(self.var_1E2D > 0) {
    if(self.var_1E2D <= 20) {
      var_06 = self.var_1E2D;
    } else {
      var_06 = randomintrange(10, 20);
    }

    for(var_07 = 0; var_07 < var_06; var_07++) {
      if(isDefined(var_01.inactive) && var_01.inactive) {
        break;
      }

      var_08 = self getturrettarget(0);
      if(isDefined(var_08) && canbetargeted(var_08)) {
        param_00 setclientomnvar("ui_shoulder_cannon_target_ent", var_08 getentitynumber());
        param_00 setclientomnvar("ui_shoulder_cannon_hud_reticle", 2);
        self shootturret();
        param_00.var_38D8 = spawnfxforclient(var_02, param_00 getEye(), param_00);
        triggerfx(param_00.var_38D8);
        self.triggerportableradarping playrumbleonentity("shoulder_turret_fire");
        wait(var_04);
        self.var_1E2D--;
        if(self.var_1E2D < 0) {
          self.var_1E2D = 0;
        }

        param_00 setclientomnvar("ui_shoulder_cannon_ammo", self.var_1E2D);
        param_00 setclientomnvar("ui_shoulder_cannon_state", 2);
        param_00 notify("shoulder_cannon_update", self.var_1E2D * var_05);
        if(isDefined(param_00.var_38D8)) {
          param_00.var_38D8 delete();
        }
      }
    }

    wait(randomfloatrange(0.1, 0.2));
  }

  param_00 setclientomnvar("ui_shoulder_cannon_hud_reticle", 0);
  if(self.var_1E2D <= 0) {
    param_00 setclientomnvar("ui_shoulder_cannon_ammo", 0);
    param_00 setclientomnvar("ui_shoulder_cannon", 0);
    waittillframeend;
    param_00 notify("cannon_deleted");
    self delete();
  }
}

balldrone_burstfirestop(param_00, param_01) {
  var_02 = level._effect["shoulder_cannon_charge"];
  playFXOnTag(var_02, self, "tag_flash");
  var_03 = self getturrettarget(0);
  while(param_00 > 0) {
    param_01 setclientomnvar("ui_shoulder_cannon_target_ent", var_03 getentitynumber());
    param_01 setclientomnvar("ui_shoulder_cannon_hud_reticle", 1);
    param_01 playlocalsound("ball_drone_targeting");
    if(var_03.loadoutarchetype == "archetype_heavy") {
      break;
    }

    wait(0.2);
    param_00 = param_00 - 0.2;
  }

  param_01 setclientomnvar("ui_shoulder_cannon_state", 1);
  param_01 playlocalsound("ball_drone_lockon");
}

func_27D8() {
  self notify("stop_shooting");
  if(isDefined(self.idletarget)) {
    self setlookatent(self.idletarget);
  }

  self.triggerportableradarping setclientomnvar("ui_shoulder_cannon_state", 0);
}

canbetargeted(param_00) {
  var_01 = 1;
  if(isplayer(param_00)) {
    if(!scripts\mp\utility::isreallyalive(param_00) || param_00.sessionstate != "playing") {
      return 0;
    }
  }

  if(level.teambased && isDefined(param_00.team) && param_00.team == self.team) {
    return 0;
  }

  if(isDefined(param_00.team) && param_00.team == "spectator") {
    return 0;
  }

  if(isplayer(param_00) && param_00 == self.triggerportableradarping) {
    return 0;
  }

  if(isplayer(param_00) && isDefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5) {
    return 0;
  }

  if(isplayer(param_00) && param_00 scripts\mp\utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  if(distancesquared(param_00.origin, self.origin) > 810000) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  return var_01;
}

func_1000B(param_00) {
  self endon("death");
  self endon("cannon_deleted");
  self endon("disconnect");
  level endon("game_ended");
  var_01 = 1;
  var_02 = scripts\mp\powers::func_D735("power_shoulderCannon");
  for(;;) {
    if(var_02 == "+frag") {
      self waittill("power_primary_used");
    } else {
      self waittill("power_secondary_used");
    }

    if((var_02 == "+frag" && self fragbuttonpressed()) || var_02 == "+smoke" && self secondaryoffhandbuttonpressed()) {
      while((var_02 == "+frag" && self fragbuttonpressed()) || var_02 == "+smoke" && self secondaryoffhandbuttonpressed()) {
        if(var_01) {
          var_01 = 0;
          param_00 thread balldrone_attacktargets(self, var_01);
          self setclientomnvar("ui_shoulder_cannon_state", 3);
          self setclientomnvar("ui_shoulder_cannon_hud_reticle", 0);
          continue;
        }

        var_01 = 1;
        param_00 thread balldrone_attacktargets(self, var_01);
        param_00 notify("turretstatechange");
        self setclientomnvar("ui_shoulder_cannon_state", 0);
        break;
      }

      wait(0.05);
    }
  }
}