/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\gunship_cp.gsc
*************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "findBoxCenter", &gunship_findboxcenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "getBombingPoint", &gunship_getbombingpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "br_respawn", &gunship_startbrrespawn);

  if(!scripts\cp\utility::tryingtoleave()) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "assignTargetMarkers", &gunship_assigntargetmarkers);
    return;
  }
}

function gunship_findboxcenter(var0, var1) {
  return scripts\cp\cp_globallogic::findboxcenter(var0, var1);
}

function gunship_getbombingpoints(var0, var1, var2) {
  var3 = [];
  var0 -= anglesToForward(self.angles) * 100;

  for(var4 = 0; var4 < var1; var4++) {
    var5 = randomint(var2);
    var6 = randomint(360);
    var7 = var0[0] + var5 * cos(var6);
    var8 = var0[1] + var5 * sin(var6);
    var9 = var0[2];
    var10 = (var7, var8, var9);
    var11 = scripts\engine\trace::ray_trace(var10 + (0, 0, 2000), var10 - (0, 0, 10000), level.players);

    if(isDefined(var11["position"])) {
      var10 = var11["position"];
    }

    var3 = var10;
  }

  return var3;
}

function gunship_startbrrespawn(var0) {
  if(isDefined(var0) && isPlayer(var0)) {
    if(!istrue(var0.fauxdead)) {
      var0.shouldskiplaststand = 0;
      return;
    }

    return;
  }
}

function gunship_assigntargetmarkers(var0) {
  var1 = [];
  var2 = [];
  var3 = [];
  var4 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  var5 = level.players;
  var6 = [];

  if(isDefined(level.vo_paratroopers)) {
    foreach(var8 in level.vo_paratroopers) {
      var6 = scripts\engine\utility::array_add(var6, var8);
    }
  }

  var3 = scripts\engine\utility::array_combine(var6, var4, var5);

  foreach(var11 in var3) {
    if(level.teambased && var11.team == self.team) {
      continue;
    }

    if(var11 == self.owner) {
      continue;
    }

    if(var11 scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var1 = var11;
  }

  foreach(var14 in var5) {
    if(level.teambased && var14.team != self.team) {
      continue;
    }

    var2 = var14;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, var1, self.owner, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, var2, self.owner, 1, 1);
  thread set_trap_flag(level, self.enemytargetmarkergroup);
}

function set_trap_flag(var0, var1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + var0);

  for(;;) {
    level waittill("spawned_group_soldier", var2);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var2, var0, var1);
  }
}

function notcanon(var0, var1, var2, var3, var4, var5) {
  if(!istrue(var5)) {
    if(isDefined(var0) && (isint(var0) || isfloat(var0))) {
      wait var0;
    }

    if(isDefined(var1) && isstring(var1)) {
      level waittill(var1);
    }
  }

  var6 = randomint(360);
  var7 = 15000;

  if(isDefined(var3)) {
    var7 = var3;
  }

  var8 = cos(var6) * var7;
  var9 = sin(var6) * var7;
  var10 = 8000;

  if(isDefined(var4)) {
    var10 = var4;
  }

  var11 = vectorNormalize((var8, var9, var10));
  var11 *= var10;
  var12 = "veh8_mil_air_acharlie130_small_east";
  var13 = level.gunship.origin;

  if(isDefined(var2) && isvector(var2)) {
    var13 = var2;
    level.gunship.origin = var2;
  }

  var14 = spawn("script_model", var13);
  var14 setModel("tag_origin");
  var14.team = "axis";
  var15 = spawn("script_model", var13);
  var15 setModel(var12);
  var15 setCanDamage(1);
  var15.currenthealth = 1000;
  var15.maxhealth = var15.currenthealth;
  var15.health = 9999999;
  var15.owner = var14;
  var15.timeout = 6669;
  var15.currentdamagestate = 0;
  var15.team = "axis";
  var15.ref_11fb4 = 2;
  var15.flaresreservecount = 2;
  var15 scriptmoveroutline();
  var15 scriptmoverthermal();
  var16 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var16 = var15[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", var15.team, 1, 1, 1);
  }

  if(isDefined(var16)) {
    objective_setshowoncompass(var16, 1);
  }

  var15.minimapid = var16;
  var14 linkTo(level.gunship, "tag_origin");
  var15 linkTo(level.gunship, "tag_origin", var11, (0, var6 + 90, -30));
  var14.pers = [];
  var15.streakinfo = var14 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("gunship", var14);
  thread notify_planter_on_damage();
  var15 thread scripts\cp_mp\killstreaks\gunship::set_up_coop_push(undefined);

  if(level.script == "cp_arms_dealer") {
    thread notify_when_loadout_given(var15, undefined);
  } else {
    thread notify_when_loadout_given(var15);
  }

  var15 thread scripts\cp_mp\killstreaks\gunship::gunship_linklightfxent();
  var15 thread scripts\cp_mp\killstreaks\gunship::gunship_linkwingfxents();
  var15 thread scripts\cp_mp\killstreaks\gunship::gunship_trackvelocity();
  var15 thread scripts\cp\cp_flares::flares_monitor(var15.flaresreservecount);
  thread notifyteamonvehicledeath();
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var15);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    var15 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&nostand);
  }

  var15 playLoopSound("iw8_ks_ac130_lp");
}

function ref_123e4() {
  var0 = "ping_killstreaks_gunship";
  var1 = self;
  var2 = var1;
  var3 = var2 scripts\cp\vehicles\little_bird_mg_cp::fx_model(var0);
  var4 = var2 scripts\cp\vehicles\little_bird_mg_cp::fx_obj(var0);
  var5 = soundexists(var3);
  var6 = soundexists(var4);
  var7 = scripts\cp\vehicles\little_bird_mg_cp::fx_thermal(var5, var3, var6, var4);
  var8 = 1;

  if(istrue(var8)) {
    var9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](self.team, 1);

    foreach(var11 in var9) {
      if(var2 == var11) {
        if(var5) {
          var2 playsoundtoplayer(var3, var11);
        }

        continue;
      }

      if(var6) {
        var2 playsoundtoplayer(var4, var11);
      }
    }

    return;
  }
}

function notify_when_loadout_given(var0, var1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(istrue(var1)) {
    for(;;) {
      level waittill("exfil_sequence_started");

      if(istrue(level.computer_debugtestloop)) {
        continue;
      }

      break;
    }
  } else {
    level waittill("exfil_sequence_started");
  }

  thread scripts\cp_mp\killstreaks\gunship::gunship_leave(var0);
}

function notify_planter_on_damage(var0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 8192);
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(isDefined(level.teambased) && isPlayer(var2) && var2.team == self.team) {
      continue;
    }

    if(var5 == "MOD_RIFLE_BULLET" || var5 == "MOD_PISTOL_BULLET" || var5 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    if(isPlayer(var2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    thread ref_12df8(7);
    self.wasdamaged = 1;
    var11 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
      var11 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var2, var10, var5, var1, self.maxhealth, 4, 5, 6);
    }

    self.damagetaken += var11;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(self.currenthealth <= 500 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
    } else if(self.currenthealth <= 250 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_light", "off");
      self setscriptablepartstate("body_damage_medium", "on");
    } else if(self.currenthealth <= 0 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("body_damage_medium", "off");
      self setscriptablepartstate("contrails", "off");
      thread scripts\cp_mp\killstreaks\gunship::gunship_startengineblowoutfx();
    }

    if(self.damagetaken >= self.maxhealth) {
      var12 = self.streakinfo.streakname;
      var13 = undefined;
      var14 = "destroyed_" + var12;
      var15 = undefined;
      var16 = "callout_destroyed_" + var12;
      var17 = 1;

      if(isPlayer(var2)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
          GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), var16, var2);
        }
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
        var18 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var12, var2, var10, var13, var1, var14, var15, var16, var17);
      }

      self.owner delete();
      level.little_bird_mg_mp_init = 1;
      thread scripts\cp\cp_relics::ref_137a2(1);
      thread scripts\cp_mp\killstreaks\gunship::gunship_crash(8, var0);
    }
  }
}

function ref_12df8(var0) {
  self notify("run_suppression_logic");
  self endon("run_suppression_logic");
  self endon("death");
  level endon("game_ended");
  self.ref_139b7 = 1;
  GscBinSkip4(0x35, var0);
}

function removesuppressioneffectsaftertimeout(var0) {
  self notify("removeSuppressionEffectsAfterTimeout");
  self endon("removeSuppressionEffectsAfterTimeout");
  self endon("death");
  level endon("game_ended");
  wait var0;
  self.ref_139b7 = undefined;
}

function nostand(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = distance(self.origin, var4);

    if(var5 < 4000 && var2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var2);
      }

      var2 scripts\cp_mp\killstreaks\gunship::gunship_playflaresfx(var3);

      if(isDefined(var2.owner) && isPlayer(var2.owner)) {
        var2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_flares", 1);
      }

      var6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var6 = var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      self missile_settargetEnt(var6);
      self notify("missile_pairedWithFlare");
      return;
    } else if(var6 < 300 && var3.flaresreservecount <= 0) {
      var3 thread scripts\cp_mp\killstreaks\gunship::gunship_playfakebodyexplosion();
      var7 = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner) && isPlayer(self.owner)) {
        var3 dodamage(var7, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      } else {
        var3 dodamage(var7, var3.origin, undefined, self, "MOD_EXPLOSIVE", self.weapon_name);
      }

      self delete();
    }

    waitframe();
  }
}

function gunship_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_missile_lock");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function notifyteamonvehicledeath(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var1 = [];

    foreach(var3 in level.players) {
      if(!isDefined(var3) || !var3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(level.teambased && var3.team == self.team) {
        continue;
      }

      if(istrue(var3.respawn_in_progress)) {
        continue;
      }

      if(istrue(var3.inlaststand)) {
        continue;
      }

      if(var3 isskydiving()) {
        continue;
      }

      if(isDefined(var3.vehicle) && isent(var3.vehicle)) {} else if(var3 scripts\cp\utility::is_indoors(var3)) {
        continue;
      } else if(!sighttracepassed(self.origin, var3.origin, 0, undefined, 1)) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye") || var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_ghost")) {
          if(var3.ref_1389a <= 3) {
            var3.ref_1389a += 0.05;
            continue;
          } else {
            var3.ref_1389a = 0;
          }
        }
      }

      var1 = nospectatablepropswatch(var3);
      break;
    }

    if(var1.size > 0 && var1.size < 2) {
      foreach(var6 in var1) {
        if(isPlayer(var6)) {
          thread ref_123e4();
          thread nopropsspectate(var6);
          var6 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_single_spotted");
          self notify("gunship_shoot_debug_location");
        }
      }
    } else if(var1.size >= 2) {
      foreach(var6 in var1) {
        if(isPlayer(var6)) {
          thread nopropsspectate(var6);
          var6 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("gunship_multi_spotted");
          self notify("gunship_shoot_debug_location");
        }
      }
    }

    wait randomintrange(3, 15);
  }
}

function nospectatablepropswatch(var0) {
  var1 = scripts\common\utility::playersinsphere(var0.origin, 666);
  var2 = [];

  foreach(var4 in var1) {
    if(level.teambased && var4.team != var0.team) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function notifycapturetoplayers() {
  self endon("death");
  self.owner endon("gunship_switch_debug_weapon");
  self.owner endon("gunship_shoot_debug_location");

  for(;;) {
    var0 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 40000), self);
    waitframe();
  }
}

function notify_planter_on_whizby(var0, var1) {
  self endon("death");

  for(;;) {
    var2 = self.origin;

    if(isDefined(var0)) {
      var2 = self gettagorigin(var0);
    }

    if(istrue(var1)) {
      var3 = anglesToForward(self.angles);
      var4 = anglestoright(self.angles);
      var5 = anglestoup(self.angles);
    }

    wait 0.05;
  }
}

function nopropsspectate(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self notify(var0.name + "enemyGunship_fireRounds");
  self endon(var0.name + "enemyGunship_fireRounds");
  jumpiftrue(isDefined(self.initthermometerwatch)) LOC_00000074;
  self.ref_1459f = ["ac130_105mm_mp", "ac130_40mm_mp", "ac130_25mm_mp"];
  self.initspawnsoverridefunc = 0;
  self.initsolospawnstruct = self.ref_1459f[0];
  self.initthermometerwatch = self.initsolospawnstruct;

  for(;;) {
    var1 = scripts\engine\utility::ref_143ad("gunship_switch_debug_weapon", "gunship_shoot_debug_location");

    if(!isDefined(var1)) {
      waitframe();
      continue;
    }

    if(var1 == "gunship_switch_debug_weapon") {
      self.initspawnsoverridefunc++;

      if(self.initspawnsoverridefunc > 2) {
        self.initspawnsoverridefunc = 0;
      }

      self.initsolospawnstruct = self.ref_1459f[self.initspawnsoverridefunc];
      self.initthermometerwatch = self.initsolospawnstruct;
      continue;
    }

    if(istrue(self.ref_139b7)) {
      waitframe();
      continue;
    }

    var2 = nosplash(var0);
    thread noprone(var2, self.initsolospawnstruct);
  }
}

function normalspeed(var0) {
  return weaponfiretime(var0);
}

function nosplash(var0) {
  var1 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
  var2 = physics_createcontents(var1);
  var3 = self.origin;
  var4 = vectorNormalize(var0.origin - self.origin);
  var5 = var3 + var4 * 50000;
  var6 = scripts\engine\trace::ray_trace(var3, var5, self, var2);
  var7 = var6["position"];
  return var7;
}

function noprone(var0, var1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("gunship_shoot_debug_location");
  self endon("gunship_switch_debug_weapon");

  for(;;) {
    var2 = weaponmaxammo(var1);

    while(var2 > 0) {
      if(istrue(self.ref_139b7)) {
        waitframe();
        continue;
      }

      var3 = undefined;
      var4 = scripts\cp_mp\killstreaks\toma_strike::ref_13bd6(var0, 333);
      var3 = var4.point;
      var5 = undefined;
      var6 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var1), self.origin, var3, var5);
      var6.weapon_name = var1;
      var6.team = self.team;
      thread notstand(var6);
      var2--;

      if(var2 == 0) {
        wait 1;
        self notify("gunship_switch_debug_weapon");
        var7 = level.weaponreloadtime[var1] + getdvarint("scr_dfa_reloadTimerAdd", 0);

        while(var7 > 0) {
          var7--;
          wait 1;
        }
      }

      wait normalspeed(var1);
    }
  }
}

function notstand(var0, var1) {
  level endon("game_ended");
  self endon("leaving");
  var2 = getcompleteweaponname(self.initthermometerwatch);
  var0 waittill("missile_stuck", var3, var4, var5, var6, var7, var8);
  var9 = 0.5;
  var10 = 100;

  if(isDefined(var2) && isDefined(var2.basename)) {
    switch (var2.basename) {
      case "ac130_105mm_mp":
        var9 = 1.5;
        var10 = 500;
        break;
      case "ac130_40mm_mp":
        var9 = 1;
        var10 = 300;
        break;
    }
  }

  var11 = spawn("script_model", var0.origin);
  var11 setModel("ks_ac130_target_mp");
  var11.angles = vectortoangles(var8);
  var11 linkTo(var0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var11 setotherent(self);
  var11 thread scripts\cp_mp\killstreaks\gunship::deleteaftertime(5);
  var12 = "on";

  if(istrue(var1)) {
    var12 = "debug_ground_fx";
  }

  var11 setscriptablepartstate(var0.weapon_name, var12, 0);

  if(isDefined(self)) {
    var0 detonate();
  } else {
    var0 delete();
  }

  var13 = var11.origin;
  var14 = scripts\cp_mp\killstreaks\gunship::getmissileexplscale(var0.weapon_name);
  var15 = 0.75;
  var16 = scripts\cp_mp\killstreaks\gunship::getmissileexplradius(var0.weapon_name);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](var13, var14, var15, var16);
    return;
  }
}

function notetrack_listener_cattleprod_shock_player_at_gate(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("gunship_switch_debug_weapon");
  self.owner endon("gunship_shoot_debug_location");

  for(;;) {
    self.flashlight.angles = vectortoangles(var0 - self.origin);
    waitframe();
  }
}