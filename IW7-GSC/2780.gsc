/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2780.gsc
**************************************/

func_D41B() {
  level._effect["shoulder_cannon_charge"] = loadfx("vfx\old\misc\shoulder_cannon_charge");
  level._effect["shoulder_cannon_view_flash"] = loadfx("vfx\core\muzflash\minigun_flash_view");
}

func_E89C() {
  var_0 = self getcurrentweapon();
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\mp\utility\game::_giveweapon("phaseshift_activation_mp");
  scripts\mp\utility\game::_switchtoweaponimmediate("phaseshift_activation_mp");
  scripts\engine\utility::waitframe();
  scripts\mp\utility\game::_switchtoweapon(var_0);
  wait 0.2;
  scripts\engine\utility::allow_weapon_switch(1);
  scripts\mp\utility\game::_takeweapon("phaseshift_activation_mp");
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
  var_0 = spawnturret("misc_turret", self gettagorigin("j_shoulder_ri"), "ball_drone_gun_mp");
  var_0 linkto(self, "j_shoulder_ri", (0, 0, 0), (0, 0, 0));
  var_0 setModel("vehicle_drone_backup_buddy_gun");
  var_0.angles = self.angles;
  var_0.owner = self;
  var_0.team = self.team;
  var_0 maketurretinoperable();
  var_0 makeunusable();
  self.vehicle = var_0;
  var_0.var_1E2D = 100;

  if(level.teambased) {
    var_0 setturretteam(self.team);
  }

  var_0 give_player_session_tokens("sentry");
  var_0 setsentryowner(self);
  var_0 setleftarc(180);
  var_0 setrightarc(180);
  var_0 give_crafted_gascan(90);
  var_0 settoparc(30);
  var_0 thread balldrone_attacktargets(self, 1);
  var_0 setturretminimapvisible(1, "buddy_turret");
  self setclientomnvar("ui_shoulder_cannon_ammo", var_0.var_1E2D);
  self setclientomnvar("ui_eng_drone_ammo_type", 1);
  self setclientomnvar("ui_shoulder_cannon_state", 0);
  var_0 setotherent(self);
  var_0.stunned = 0;
  var_0 thread func_139C8();
  thread watchforplayerdeath(var_0);
  thread func_1000B(var_0);
  self setclientomnvar("ui_shoulder_cannon", 1);
}

watchforplayerdeath(var_0) {
  self notify("cannon_deleted");
  self endon("cannon_deleted");
  scripts\engine\utility::waittill_any("death", "disconnect");
  var_0 delete();

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
    self waittill("emp_damage", var_0, var_1);
    func_1000A(var_1);
  }
}

func_1000A(var_0) {
  self notify("shoulderCannon_stunned");
  self endon("shoulderCannon_stunned");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.stunned = 1;
  self notify("turretstatechange");
  wait(var_0);
  self.stunned = 0;
  self notify("turretstatechange");
}

func_F67C(var_0) {
  var_1 = 20;
  var_2 = var_1 * 1000 + gettime();
  self setclientomnvar("ui_shoulder_cannon_timer_end_milliseconds", var_2);
  self.var_38D5 = var_2;
  thread func_139CA();
  thread func_139CB(var_1, var_0);
  thread func_139C9();
}

func_139CA() {
  self notify("watchCannonTimeoutHostMigration");
  self endon("watchCannonTimeoutHostMigration");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  level waittill("host_migration_begin");
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_0 > 0) {
    self setclientomnvar("ui_shoulder_cannon_timer_end_milliseconds", self.var_38D5 + var_0);
  } else {
    self setclientomnvar("ui_shoulder_cannon_timer_end_milliseconds", self.var_38D5);
  }
}

func_139CB(var_0, var_1) {
  self notify("watchCannonTimer");
  self endon("watchCannonTimer");
  self endon("cannon_deleted");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = 5;
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(var_0 - var_2 - 1);

  while(var_2 > 0) {
    self playsoundtoplayer("mp_cranked_countdown", self);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
    var_2--;
  }

  self setclientomnvar("ui_shoulder_cannon_ammo", 0);
  waittillframeend;
  self setclientomnvar("ui_shoulder_cannon", 0);
  var_1 delete();
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

    wait 0.1;
  }
}

balldrone_attacktargets(var_0, var_1) {
  self notify("turret_toggle");
  self endon("turret_toggle");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("turretstatechange");

    if(var_1 == 1) {
      if(self getteamarray() && self.var_1E2D > 0 && (isDefined(self.stunned) && !self.stunned)) {
        self laseron();
        balldrone_burstfirestop(0.2, var_0);
        thread balldrone_burstfirestart(var_0);
      } else {
        self laseroff();
        thread func_27D8();
        var_0 setclientomnvar("ui_shoulder_cannon_target_ent", -1);
        var_0 setclientomnvar("ui_shoulder_cannon_hud_reticle", 0);
      }

      continue;
    }

    break;
  }
}

balldrone_burstfirestart(var_0) {
  self endon("turret_toggle");
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  var_1 = self;
  var_2 = level._effect["shoulder_cannon_view_flash"];
  var_3 = level._effect["shoulder_cannon_charge"];
  var_4 = weaponfiretime("ball_drone_gun_mp");
  var_5 = 0.01;
  self.owner waittill("begin_firing");

  while(self.var_1E2D > 0) {
    if(self.var_1E2D <= 20) {
      var_6 = self.var_1E2D;
    } else {
      var_6 = randomintrange(10, 20);
    }

    for(var_7 = 0; var_7 < var_6; var_7++) {
      if(isDefined(var_1.inactive) && var_1.inactive) {
        break;
      }
      var_8 = self getturrettarget(0);

      if(isDefined(var_8) && canbetargeted(var_8)) {
        var_0 setclientomnvar("ui_shoulder_cannon_target_ent", var_8 getentitynumber());
        var_0 setclientomnvar("ui_shoulder_cannon_hud_reticle", 2);
        self shootturret();
        var_0.var_38D8 = spawnfxforclient(var_2, var_0 getEye(), var_0);
        triggerfx(var_0.var_38D8);
        self.owner playrumbleonentity("shoulder_turret_fire");
        wait(var_4);
        self.var_1E2D--;

        if(self.var_1E2D < 0) {
          self.var_1E2D = 0;
        }

        var_0 setclientomnvar("ui_shoulder_cannon_ammo", self.var_1E2D);
        var_0 setclientomnvar("ui_shoulder_cannon_state", 2);
        var_0 notify("shoulder_cannon_update", self.var_1E2D * var_5);

        if(isDefined(var_0.var_38D8)) {
          var_0.var_38D8 delete();
        }
      }
    }

    wait(randomfloatrange(0.1, 0.2));
  }

  var_0 setclientomnvar("ui_shoulder_cannon_hud_reticle", 0);

  if(self.var_1E2D <= 0) {
    var_0 setclientomnvar("ui_shoulder_cannon_ammo", 0);
    var_0 setclientomnvar("ui_shoulder_cannon", 0);
    waittillframeend;
    var_0 notify("cannon_deleted");
    self delete();
  }
}

balldrone_burstfirestop(var_0, var_1) {
  var_2 = level._effect["shoulder_cannon_charge"];
  playFXOnTag(var_2, self, "tag_flash");

  for(var_3 = self getturrettarget(0); var_0 > 0; var_0 = var_0 - 0.2) {
    var_1 setclientomnvar("ui_shoulder_cannon_target_ent", var_3 getentitynumber());
    var_1 setclientomnvar("ui_shoulder_cannon_hud_reticle", 1);
    var_1 playlocalsound("ball_drone_targeting");

    if(var_3.loadoutarchetype == "archetype_heavy") {
      break;
    }
    wait 0.2;
  }

  var_1 setclientomnvar("ui_shoulder_cannon_state", 1);
  var_1 playlocalsound("ball_drone_lockon");
}

func_27D8() {
  self notify("stop_shooting");

  if(isDefined(self.idletarget)) {
    self setlookatent(self.idletarget);
  }

  self.owner setclientomnvar("ui_shoulder_cannon_state", 0);
}

canbetargeted(var_0) {
  var_1 = 1;

  if(isplayer(var_0)) {
    if(!scripts\mp\utility\game::isreallyalive(var_0) || var_0.sessionstate != "playing") {
      return 0;
    }
  }

  if(level.teambased && isDefined(var_0.team) && var_0.team == self.team) {
    return 0;
  }

  if(isDefined(var_0.team) && var_0.team == "spectator") {
    return 0;
  }

  if(isplayer(var_0) && var_0 == self.owner) {
    return 0;
  }

  if(isplayer(var_0) && isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5) {
    return 0;
  }

  if(isplayer(var_0) && var_0 scripts\mp\utility\game::_hasperk("specialty_blindeye")) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > 810000) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  return var_1;
}

func_1000B(var_0) {
  self endon("death");
  self endon("cannon_deleted");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = 1;
  var_2 = scripts\mp\powers::func_D735("power_shoulderCannon");

  for(;;) {
    if(var_2 == "+frag") {
      self waittill("power_primary_used");
    } else {
      self waittill("power_secondary_used");
    }

    if(var_2 == "+frag" && self fragbuttonpressed() || var_2 == "+smoke" && self secondaryoffhandbuttonpressed()) {
      while(var_2 == "+frag" && self fragbuttonpressed() || var_2 == "+smoke" && self secondaryoffhandbuttonpressed()) {
        if(var_1) {
          var_1 = 0;
          var_0 thread balldrone_attacktargets(self, var_1);
          self setclientomnvar("ui_shoulder_cannon_state", 3);
          self setclientomnvar("ui_shoulder_cannon_hud_reticle", 0);
        } else {
          var_1 = 1;
          var_0 thread balldrone_attacktargets(self, var_1);
          var_0 notify("turretstatechange");
          self setclientomnvar("ui_shoulder_cannon_state", 0);
        }

        break;
      }

      wait 0.05;
    }
  }
}