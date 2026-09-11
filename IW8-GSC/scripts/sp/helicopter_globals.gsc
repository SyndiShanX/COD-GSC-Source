/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\helicopter_globals.gsc
***********************************************/

function init_helicopters() {
  level.helicopter_firelinkfunk = &heli_firelink;
  level.chopperturretonfunc = &chopper_turret_on;
  level.chopperturretofffunc = &chopper_turret_off;
}

function chopper_turret_off() {
  self notify("mg_off");
}

function chopper_turret_on() {
  self endon("death");
  self endon("mg_off");
  var0 = cos(55);

  while(self.health > 0) {
    var1 = getenemytarget(16000, var0, 1, 1);

    if(isDefined(var1)) {
      thread shootenemytarget_bullets(var1);
    }

    wait 2;
  }
}

function heli_firelink(var0) {
  var1 = getEnt(var0.script_linkto, "script_linkname");
  var2 = !isDefined(var1);

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct(var0.script_linkto, "script_linkname");
  }

  var3 = var0.script_firelink;

  if(var2) {
    var1 = var1 scripts\engine\utility::spawn_tag_origin();
  }

  switch (var3) {
    case "zippy_burst":
      wait 1;
      fire_missile("hind_zippy", 1, var1);
      wait 0.1;
      fire_missile("hind_zippy", 1, var1);
      wait 0.2;
      fire_missile("hind_zippy", 1, var1);
      wait 0.3;
      fire_missile("hind_zippy", 1, var1);
      wait 0.3;
      fire_missile("hind_zippy", 1, var1);
      break;
    case "apache_zippy":
      var4 = [0.1, 0.2, 0.3];
      wait 1;
      var1.origin += (0, 0, -150);
      var1 moveTo(var1.origin + (0, 0, 150), 0.6, 0, 0);

      foreach(var6 in var4) {
        if(!isDefined(self)) {
          continue;
        }

        fire_missile("apache_zippy", 1, var1);
        wait var6;
      }

      break;
    case "hind_rpg":
      fire_missile("hind_rpg", 5, var1, 0.3);
      break;
    default:
      if(self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500") {
        scripts\vehicle\attack_heli::heli_fire_missiles(var1, 2, 0.25);
      } else {
        fire_missile("hind_zippy", 5, var1, 0.3);
      }

      break;
  }

  if(var2) {
    var1 delete();
    return;
  }
}

function globalthink() {
  if(!isDefined(self.vehicletype)) {
    return;
  }

  var0 = 0;

  if(self.vehicletype == "hind" || self.vehicletype == "hind_blackice" || self.vehicletype == "ny_harbor_hind") {
    var0 = 1;
  }

  if(self.vehicletype == "cobra" || self.vehicletype == "cobra_player") {
    thread attachmissiles("chopperpilot_hellfire", "cobra_Sidewinder");

    if(isDefined(self.fullmodel)) {
      thread attachmissiles(self.fullmodel, "chopperpilot_hellfire");
    }

    var0 = 1;
  }

  if(!var0) {
    return;
  }

  thread flares_think(level);
  level thread scripts\sp\helicopter_ai::evasive_think(self);

  if(getDvar("cobrapilot_wingman_enabled") == "1") {
    if(isDefined(self.script_wingman)) {
      level.wingman = self;
      level thread scripts\sp\helicopter_ai::wingman_think(self);
      return;
    }

    return;
  }
}

function flares_think(var0) {
  var0 endon("death");
  notifyoncommand("flare_button", "+frag");
  notifyoncommand("flare_button", "+usereload");
  notifyoncommand("flare_button", "+activate");

  while(var0.health > 0) {
    if(isDefined(var0.playercontrolled)) {
      var0.pilot waittill("flare_button");
    } else {
      var0 waittill("incomming_missile", var1);

      if(!isDefined(var1)) {
        continue;
      }

      if(randomint(3) == 0) {
        continue;
      }

      wait randomfloatrange(0.5, 1);
    }

    thread flares_fire(var0);
    wait 3;
  }
}

function flares_fire_burst(var0, var1, var2, var3) {
  var4 = 1;

  for(var5 = 0; var5 < var1; var5++) {
    playFX(level.flare_fx[var0.vehicletype], var0 gettagorigin("tag_flare"));

    if(isDefined(var0.playercontrolled)) {
      level.stats["flares_used"]++;
      var0 notify("dropping_flares");

      if(var4) {
        var0 playSound("cobra_flare_fire");
      }

      var4 = !var4;
    }

    if(var5 <= var2 - 1) {
      thread flares_redirect_missiles(var0, var3);
    }

    wait 0.1;
  }
}

function flares_fire(var0) {
  var0 endon("death");
  var1 = 5;

  if(isDefined(var0.flare_duration)) {
    var1 = var0.flare_duration;
  }

  flares_fire_burst(var0, 8, 1, var1);
}

function create_missileattractor_on_player_chopper() {
  if(isDefined(self.missileattractor)) {
    missile_deleteattractor(self.missileattractor);
  }

  self.missileattractor = missile_createattractorent(self.centeraimpoint, 10000, 10000);
}

function flares_redirect_missiles(var0, var1) {
  var0 notify("flares_out");
  var0 endon("death");
  var0 endon("flares_out");

  if(!isDefined(var1)) {
    var1 = 5;
  }

  var2 = flares_get_vehicle_velocity(var0);
  var3 = spawn("script_origin", var0 gettagorigin("tag_flare"));
  var3 movegravity(var2, var1);
  var4 = undefined;

  if(isDefined(var0.playercontrolled)) {
    if(isDefined(var0.missileattractor)) {
      missile_deleteattractor(var0.missileattractor);
    }

    var4 = missile_createattractorent(var3, 10000, 10000);
  }

  if(isDefined(var0.incomming_missiles)) {
    for(var5 = 0; var5 < var0.incomming_missiles.size; var5++) {
      var0.incomming_missiles[var5] missile_settargetEnt(var3);
    }
  }

  wait var1;

  if(isDefined(var0.playercontrolled)) {
    if(isDefined(var4)) {
      missile_deleteattractor(var4);
    }

    thread create_missileattractor_on_player_chopper();
  }

  if(!isDefined(var0.script_targetoffset_z)) {
    var0.script_targetoffset_z = 0;
  }

  var6 = (0, 0, var0.script_targetoffset_z);

  if(!isDefined(var0.incomming_missiles)) {
    return;
  }

  for(var5 = 0; var5 < var0.incomming_missiles.size; var5++) {
    var0.incomming_missiles[var5] missile_settargetEnt(var0, var6);
  }
}

function flares_get_vehicle_velocity(var0) {
  var1 = var0.origin;
  wait 0.05;
  var2 = var0.origin - var1;
  return var2 * 20;
}

function missile_deathwait(var0, var1) {
  var1 endon("death");
  var0 waittill("death");

  if(!isDefined(var1.incomming_missiles)) {
    return;
  }

  var1.incomming_missiles = scripts\engine\utility::array_remove(var1.incomming_missiles, var0);
}

function getenemytarget(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  var7 = [];
  var8 = undefined;
  var9 = scripts\engine\utility::get_enemy_team(self.script_team);
  var10 = [];

  if(var4) {
    foreach(var12 in vehicle_getarray()) {
      if(!isDefined(var12.script_team)) {
        continue;
      }

      if(var12.script_team == var9) {
        var10 = var12;
      }
    }
  }

  if(var2) {
    var14 = getaiarray(var9);

    for(var15 = 0; var15 < var14.size; var15++) {
      if(isDefined(var14[var15].ignored_by_attack_heli)) {
        continue;
      }

      var10 = var14[var15];
    }

    if(var9 == "allies") {
      for(var15 = 0; var15 < level.players.size; var15++) {
        var10 = level.players[var15];
      }
    }
  }

  if(isDefined(var6)) {
    var10 = scripts\engine\sp\utility::array_exclude(var10, var6);
  }

  if(var5) {
    var10 = scripts\engine\utility::array_randomize(var10);
  }

  var16 = anglesToForward(self.angles);

  for(var15 = 0; var15 < var10.size; var15++) {
    if(issentient(var10[var15]) && issentient(self) && self getthreatbiasgroup() != "") {
      var17 = getthreatbias(var10[var15] getthreatbiasgroup(), self getthreatbiasgroup());

      if(var17 <= -1000000) {
        continue;
      }
    }

    if(isDefined(var0) && var0 > 0) {
      if(distance(self.origin, var10[var15].origin) > var0) {
        continue;
      }
    }

    if(isDefined(var1)) {
      var18 = vectorNormalize(var10[var15].origin - self.origin);
      var19 = vectordot(var16, var18);

      if(var19 <= var1) {
        continue;
      }
    }

    if(var3) {
      var20 = 0;

      if(isai(var10[var15])) {
        var21 = 48;
      } else {
        var21 = 150;
      }

      var20 = sighttracepassed(self.origin, var10[var15].origin + (0, 0, var21), 0, self);

      if(!var20) {
        continue;
      }
    }

    var7 = var10[var15];
  }

  if(var7.size == 0) {
    self notify("gunner_new_target", var8);
    return var8;
  }

  if(var7.size == 1) {
    self notify("gunner_new_target", var7[0]);
    return var7[0];
  }

  var22 = scripts\engine\utility::getclosest(self.origin, var7);
  self notify("gunner_new_target", var22);
  return var22;
}

function shootenemytarget_bullets(var0) {
  self endon("death");
  self endon("mg_off");
  var0 endon("death");
  self endon("gunner_new_target");

  if(isDefined(self.playercontrolled)) {
    self endon("gunner_stop_firing");
  }

  var1 = (0, 0, 0);

  if(isDefined(var0.script_targetoffset_z)) {
    var1 += (0, 0, var0.script_targetoffset_z);
  } else if(issentient(var0)) {
    var1 = (0, 0, 32);
  }

  self setturrettargetEnt(var0, var1);

  while(self.health > 0) {
    var2 = randomintrange(1, 25);

    if(getDvar("cobrapilot_debug") == "1") {
      iprintln("randomShots = " + var2);
    }

    for(var3 = 0; var3 < var2; var3++) {
      if(isDefined(self.playercontrolled)) {
        if(isDefined(level.cobraweapon) && level.cobraweapon.size > 0) {
          self setvehweapon(level.gunnerweapon);
        }
      }

      thread shootenemytarget_bullets_debugline(self, "tag_turret", var0, var1, (1, 1, 0), 0.05);
      self fireweapon("tag_flash");

      if(isDefined(self.playercontrolled)) {
        self setvehweapon(level.cobraweapon[self.pilot.currentweapon].v["weapon"]);
      }

      wait 0.05;
    }

    wait randomfloatrange(0.25, 2.5);
  }
}

function shootenemytarget_bullets_debugline(var0, var1, var2, var3, var4, var5) {
  if(getDvar("cobrapilot_debug") != "1") {
    return;
  }

  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var2 endon("death");
  self endon("gunner_new_target");

  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  if(isDefined(var5)) {
    var5 = gettime() + var5 * 1000;

    while(gettime() < var5) {
      wait 0.05;
    }

    return;
  }

  for(;;) {
    wait 0.05;
  }
}

function attachmissiles(var0, var1, var2, var3) {
  self.hasattachedweapons = 1;
  var4 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function fire_missile(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var5 = undefined;
  var6 = undefined;
  var7 = "cobra_20mm";
  var8 = [];

  switch (var0) {
    case "f15_missile":
      var5 = "cobra_Sidewinder";
      GscBinSkip0(0x2e, 0, "le_side_wing_jnt");

    case "mi28_seeker":
      var5 = "cobra_seeker";
      GscBinSkip0(0x2e, 0, "tag_store_L_1_a");

    case "ffar":
      var5 = "cobra_FFAR";
      GscBinSkip0(0x2e, 0, "tag_store_r_2");

    case "seeker":
      var5 = "cobra_seeker";
      GscBinSkip0(0x2e, 0, "tag_store_r_2");

    case "ffar_bog_a_lite":
      var5 = "cobra_FFAR_bog_a_lite";
      GscBinSkip0(0x2e, 0, "tag_store_r_2");

    case "ffar_airlift":
      var5 = "cobra_FFAR_airlift";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "ffar_airlift_nofx":
      var5 = "cobra_FFAR_airlift_nofx";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "cobra_zippy":
      var5 = "zippy_rockets";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "apache_zippy":
      var5 = "zippy_rockets_apache";
      GscBinSkip0(0x2e, 0, "tag_flash_2");

    case "apache_zippy_nd":
      var5 = "zippy_rockets_apache_nodamage";
      GscBinSkip0(0x2e, 0, "tag_flash_2");

    case "mi28_zippy":
      var5 = "zippy_rockets_apache";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "mi28_zippy_cheap":
      var5 = "zippy_rockets_apache_cheap";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "cobra_turret":
      var5 = "hind_turret_penetration";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "ffar_hind":
      var7 = "hind_turret";
      var5 = "hind_FFAR";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_zippy":
      var7 = "hind_turret";
      var5 = "zippy_rockets";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_rpg":
      var7 = "hind_turret";
      var5 = "rpg";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_rpg_cheap":
      var7 = "hind_turret";
      var5 = "rpg_cheap";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "ffar_hind_nodamage":
      var7 = "hind_turret";
      var5 = "hind_FFAR_nodamage";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "ffar_mi28_village_assault":
      var7 = "hind_turret";
      var5 = "mi28_ffar_village_assault";
      GscBinSkip0(0x2e, 0, "tag_store_L_2_a");

    case "ffar_co_rescue":
      var5 = "cobra_FFAR_bog_a_lite";
      GscBinSkip0(0x2e, 0, "tag_store_R_2_a");

    default:
      break;
  }

  var6 = weaponfiretime(var5);

  if(isDefined(self.nextmissiletag)) {
    var9 = self.nextmissiletag;
  } else {
    var9 = -1;
  }

  var10 = 0;

  while(var10 < var2) {
    var9++;
    var9 %= var9.size;

    if(var1 == "ffar_mi28_village_assault") {
      if(isDefined(var3) && isDefined(var3.origin)) {
        magicbullet(var6, self gettagorigin(var9[var9]), var3.origin);

        if(isDefined(level._effect["ffar_mi28_muzzleflash"])) {
          playFXOnTag(scripts\engine\utility::getfx("ffar_mi28_muzzleflash"), self, var9[var9]);
        }

        thread delayed_earthquake(0.1, 0.5, 0.2, var3.origin, 1600);
      }
    } else {
      self setvehweapon(var6);

      if(isDefined(var3)) {
        var11 = self fireweapon(var9[var9], var3);

        switch (var1) {
          case "ffar_airlift":
          case "ffar_bog_a_lite":
          case "ffar":
            thread missilelosetarget(var11);
            break;
          case "apache_zippy_wall":
          case "mi28_zippy_cheap":
          case "mi28_zippy":
          case "apache_zippy_nd":
          case "apache_zippy":
            if(!isDefined(var5)) {
              thread missilelosetarget(var11);
            } else {
              thread missilelosetarget(var11);
            }

            break;
          default:
            break;
        }
      } else {
        var11 = self fireweapon(var9[var10]);
      }

      self notify("missile_fired", var11);
    }

    self.nextmissiletag = var10;

    if(var11 < var3 - 1) {
      wait var8;
    }

    if(isDefined(var5)) {
      wait var5;
    }

    var11++;
  }

  self setvehweapon(var9);
}

function delayed_earthquake(var0, var1, var2, var3, var4) {
  wait var0;
  earthquake(var1, var2, var3, var4);
}

function missilelosetarget(var0) {
  self endon("death");
  wait var0;

  if(isDefined(self)) {
    self missile_cleartarget();
    return;
  }
}