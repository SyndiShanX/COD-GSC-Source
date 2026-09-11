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
  var_0 = cos(55);

  while(self.health > 0) {
    var_1 = getenemytarget(16000, var_0, 1, 1);

    if(isDefined(var_1)) {
      thread shootenemytarget_bullets(var_1);
    }

    wait 2;
  }
}

function heli_firelink(var_0) {
  var_1 = getEnt(var_0.script_linkto, "script_linkname");
  var_2 = !isDefined(var_1);

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct(var_0.script_linkto, "script_linkname");
  }

  var_3 = var_0.script_firelink;

  if(var_2) {
    var_1 = var_1 scripts\engine\utility::spawn_tag_origin();
  }

  switch (var_3) {
    case "zippy_burst":
      wait 1;
      fire_missile("hind_zippy", 1, var_1);
      wait 0.1;
      fire_missile("hind_zippy", 1, var_1);
      wait 0.2;
      fire_missile("hind_zippy", 1, var_1);
      wait 0.3;
      fire_missile("hind_zippy", 1, var_1);
      wait 0.3;
      fire_missile("hind_zippy", 1, var_1);
      break;
    case "apache_zippy":
      var_4 = [0.1, 0.2, 0.3];
      wait 1;
      var_1.origin += (0, 0, -150);
      var_1 moveTo(var_1.origin + (0, 0, 150), 0.6, 0, 0);

      foreach(var_6 in var_4) {
        if(!isDefined(self)) {
          continue;
        }

        fire_missile("apache_zippy", 1, var_1);
        wait var_6;
      }

      break;
    case "hind_rpg":
      fire_missile("hind_rpg", 5, var_1, 0.3);
      break;
    default:
      if(self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500") {
        scripts\vehicle\attack_heli::heli_fire_missiles(var_1, 2, 0.25);
      } else {
        fire_missile("hind_zippy", 5, var_1, 0.3);
      }

      break;
  }

  if(var_2) {
    var_1 delete();
    return;
  }
}

function globalthink() {
  if(!isDefined(self.vehicletype)) {
    return;
  }

  var_0 = 0;

  if(self.vehicletype == "hind" || self.vehicletype == "hind_blackice" || self.vehicletype == "ny_harbor_hind") {
    var_0 = 1;
  }

  if(self.vehicletype == "cobra" || self.vehicletype == "cobra_player") {
    thread attachmissiles("chopperpilot_hellfire", "cobra_Sidewinder");

    if(isDefined(self.fullmodel)) {
      thread attachmissiles(self.fullmodel, "chopperpilot_hellfire");
    }

    var_0 = 1;
  }

  if(!var_0) {
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

function flares_think(var_0) {
  var_0 endon("death");
  notifyoncommand("flare_button", "+frag");
  notifyoncommand("flare_button", "+usereload");
  notifyoncommand("flare_button", "+activate");

  while(var_0.health > 0) {
    if(isDefined(var_0.playercontrolled)) {
      var_0.pilot waittill("flare_button");
    } else {
      var_0 waittill("incomming_missile", var_1);

      if(!isDefined(var_1)) {
        continue;
      }

      if(randomint(3) == 0) {
        continue;
      }

      wait randomfloatrange(0.5, 1);
    }

    thread flares_fire(var_0);
    wait 3;
  }
}

function flares_fire_burst(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    playFX(level.flare_fx[var_0.vehicletype], var_0 gettagorigin("tag_flare"));

    if(isDefined(var_0.playercontrolled)) {
      level.stats["flares_used"]++;
      var_0 notify("dropping_flares");

      if(var_4) {
        var_0 playSound("cobra_flare_fire");
      }

      var_4 = !var_4;
    }

    if(var_5 <= var_2 - 1) {
      thread flares_redirect_missiles(var_0, var_3);
    }

    wait 0.1;
  }
}

function flares_fire(var_0) {
  var_0 endon("death");
  var_1 = 5;

  if(isDefined(var_0.flare_duration)) {
    var_1 = var_0.flare_duration;
  }

  flares_fire_burst(var_0, 8, 1, var_1);
}

function create_missileattractor_on_player_chopper() {
  if(isDefined(self.missileattractor)) {
    missile_deleteattractor(self.missileattractor);
  }

  self.missileattractor = missile_createattractorent(self.centeraimpoint, 10000, 10000);
}

function flares_redirect_missiles(var_0, var_1) {
  var_0 notify("flares_out");
  var_0 endon("death");
  var_0 endon("flares_out");

  if(!isDefined(var_1)) {
    var_1 = 5;
  }

  var_2 = flares_get_vehicle_velocity(var_0);
  var_3 = spawn("script_origin", var_0 gettagorigin("tag_flare"));
  var_3 movegravity(var_2, var_1);
  var_4 = undefined;

  if(isDefined(var_0.playercontrolled)) {
    if(isDefined(var_0.missileattractor)) {
      missile_deleteattractor(var_0.missileattractor);
    }

    var_4 = missile_createattractorent(var_3, 10000, 10000);
  }

  if(isDefined(var_0.incomming_missiles)) {
    for(var_5 = 0; var_5 < var_0.incomming_missiles.size; var_5++) {
      var_0.incomming_missiles[var_5] missile_settargetEnt(var_3);
    }
  }

  wait var_1;

  if(isDefined(var_0.playercontrolled)) {
    if(isDefined(var_4)) {
      missile_deleteattractor(var_4);
    }

    thread create_missileattractor_on_player_chopper();
  }

  if(!isDefined(var_0.script_targetoffset_z)) {
    var_0.script_targetoffset_z = 0;
  }

  var_6 = (0, 0, var_0.script_targetoffset_z);

  if(!isDefined(var_0.incomming_missiles)) {
    return;
  }

  for(var_5 = 0; var_5 < var_0.incomming_missiles.size; var_5++) {
    var_0.incomming_missiles[var_5] missile_settargetEnt(var_0, var_6);
  }
}

function flares_get_vehicle_velocity(var_0) {
  var_1 = var_0.origin;
  wait 0.05;
  var_2 = var_0.origin - var_1;
  return var_2 * 20;
}

function missile_deathwait(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");

  if(!isDefined(var_1.incomming_missiles)) {
    return;
  }

  var_1.incomming_missiles = scripts\engine\utility::array_remove(var_1.incomming_missiles, var_0);
}

function getenemytarget(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_7 = [];
  var_8 = undefined;
  var_9 = scripts\engine\utility::get_enemy_team(self.script_team);
  var_10 = [];

  if(var_4) {
    foreach(var_12 in vehicle_getarray()) {
      if(!isDefined(var_12.script_team)) {
        continue;
      }

      if(var_12.script_team == var_9) {
        var_10 = var_12;
      }
    }
  }

  if(var_2) {
    var_14 = getaiarray(var_9);

    for(var_15 = 0; var_15 < var_14.size; var_15++) {
      if(isDefined(var_14[var_15].ignored_by_attack_heli)) {
        continue;
      }

      var_10 = var_14[var_15];
    }

    if(var_9 == "allies") {
      for(var_15 = 0; var_15 < level.players.size; var_15++) {
        var_10 = level.players[var_15];
      }
    }
  }

  if(isDefined(var_6)) {
    var_10 = scripts\engine\sp\utility::array_exclude(var_10, var_6);
  }

  if(var_5) {
    var_10 = scripts\engine\utility::array_randomize(var_10);
  }

  var_16 = anglesToForward(self.angles);

  for(var_15 = 0; var_15 < var_10.size; var_15++) {
    if(issentient(var_10[var_15]) && issentient(self) && self getthreatbiasgroup() != "") {
      var_17 = getthreatbias(var_10[var_15] getthreatbiasgroup(), self getthreatbiasgroup());

      if(var_17 <= -1000000) {
        continue;
      }
    }

    if(isDefined(var_0) && var_0 > 0) {
      if(distance(self.origin, var_10[var_15].origin) > var_0) {
        continue;
      }
    }

    if(isDefined(var_1)) {
      var_18 = vectorNormalize(var_10[var_15].origin - self.origin);
      var_19 = vectordot(var_16, var_18);

      if(var_19 <= var_1) {
        continue;
      }
    }

    if(var_3) {
      var_20 = 0;

      if(isai(var_10[var_15])) {
        var_21 = 48;
      } else {
        var_21 = 150;
      }

      var_20 = sighttracepassed(self.origin, var_10[var_15].origin + (0, 0, var_21), 0, self);

      if(!var_20) {
        continue;
      }
    }

    var_7 = var_10[var_15];
  }

  if(var_7.size == 0) {
    self notify("gunner_new_target", var_8);
    return var_8;
  }

  if(var_7.size == 1) {
    self notify("gunner_new_target", var_7[0]);
    return var_7[0];
  }

  var_22 = scripts\engine\utility::getclosest(self.origin, var_7);
  self notify("gunner_new_target", var_22);
  return var_22;
}

function shootenemytarget_bullets(var_0) {
  self endon("death");
  self endon("mg_off");
  var_0 endon("death");
  self endon("gunner_new_target");

  if(isDefined(self.playercontrolled)) {
    self endon("gunner_stop_firing");
  }

  var_1 = (0, 0, 0);

  if(isDefined(var_0.script_targetoffset_z)) {
    var_1 += (0, 0, var_0.script_targetoffset_z);
  } else if(issentient(var_0)) {
    var_1 = (0, 0, 32);
  }

  self setturrettargetEnt(var_0, var_1);

  while(self.health > 0) {
    var_2 = randomintrange(1, 25);

    if(getDvar("cobrapilot_debug") == "1") {
      iprintln("randomShots = " + var_2);
    }

    for(var_3 = 0; var_3 < var_2; var_3++) {
      if(isDefined(self.playercontrolled)) {
        if(isDefined(level.cobraweapon) && level.cobraweapon.size > 0) {
          self setvehweapon(level.gunnerweapon);
        }
      }

      thread shootenemytarget_bullets_debugline(self, "tag_turret", var_0, var_1, (1, 1, 0), 0.05);
      self fireweapon("tag_flash");

      if(isDefined(self.playercontrolled)) {
        self setvehweapon(level.cobraweapon[self.pilot.currentweapon].v["weapon"]);
      }

      wait 0.05;
    }

    wait randomfloatrange(0.25, 2.5);
  }
}

function shootenemytarget_bullets_debugline(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getDvar("cobrapilot_debug") != "1") {
    return;
  }

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_2 endon("death");
  self endon("gunner_new_target");

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(isDefined(var_5)) {
    var_5 = gettime() + var_5 * 1000;

    while(gettime() < var_5) {
      wait 0.05;
    }

    return;
  }

  for(;;) {
    wait 0.05;
  }
}

function attachmissiles(var_0, var_1, var_2, var_3) {
  self.hasattachedweapons = 1;
  var_4 = [];
  GscBinSkip0(0x2e, 0, var_0);
}

function fire_missile(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_5 = undefined;
  var_6 = undefined;
  var_7 = "cobra_20mm";
  var_8 = [];

  switch (var_0) {
    case "f15_missile":
      var_5 = "cobra_Sidewinder";
      GscBinSkip0(0x2e, 0, "le_side_wing_jnt");

    case "mi28_seeker":
      var_5 = "cobra_seeker";
      GscBinSkip0(0x2e, 0, "tag_store_L_1_a");

    case "ffar":
      var_5 = "cobra_FFAR";
      GscBinSkip0(0x2e, 0, "tag_store_r_2");

    case "seeker":
      var_5 = "cobra_seeker";
      GscBinSkip0(0x2e, 0, "tag_store_r_2");

    case "ffar_bog_a_lite":
      var_5 = "cobra_FFAR_bog_a_lite";
      GscBinSkip0(0x2e, 0, "tag_store_r_2");

    case "ffar_airlift":
      var_5 = "cobra_FFAR_airlift";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "ffar_airlift_nofx":
      var_5 = "cobra_FFAR_airlift_nofx";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "cobra_zippy":
      var_5 = "zippy_rockets";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "apache_zippy":
      var_5 = "zippy_rockets_apache";
      GscBinSkip0(0x2e, 0, "tag_flash_2");

    case "apache_zippy_nd":
      var_5 = "zippy_rockets_apache_nodamage";
      GscBinSkip0(0x2e, 0, "tag_flash_2");

    case "mi28_zippy":
      var_5 = "zippy_rockets_apache";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "mi28_zippy_cheap":
      var_5 = "zippy_rockets_apache_cheap";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "cobra_turret":
      var_5 = "hind_turret_penetration";
      GscBinSkip0(0x2e, 0, "tag_store_L_wing");

    case "ffar_hind":
      var_7 = "hind_turret";
      var_5 = "hind_FFAR";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_zippy":
      var_7 = "hind_turret";
      var_5 = "zippy_rockets";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_rpg":
      var_7 = "hind_turret";
      var_5 = "rpg";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_rpg_cheap":
      var_7 = "hind_turret";
      var_5 = "rpg_cheap";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "ffar_hind_nodamage":
      var_7 = "hind_turret";
      var_5 = "hind_FFAR_nodamage";
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "ffar_mi28_village_assault":
      var_7 = "hind_turret";
      var_5 = "mi28_ffar_village_assault";
      GscBinSkip0(0x2e, 0, "tag_store_L_2_a");

    case "ffar_co_rescue":
      var_5 = "cobra_FFAR_bog_a_lite";
      GscBinSkip0(0x2e, 0, "tag_store_R_2_a");

    default:
      break;
  }

  var_6 = weaponfiretime(var_5);

  if(isDefined(self.nextmissiletag)) {
    var_9 = self.nextmissiletag;
  } else {
    var_9 = -1;
  }

  var_10 = 0;

  while(var_10 < var_2) {
    var_9++;
    var_9 %= var_9.size;

    if(var_1 == "ffar_mi28_village_assault") {
      if(isDefined(var_3) && isDefined(var_3.origin)) {
        magicbullet(var_6, self gettagorigin(var_9[var_9]), var_3.origin);

        if(isDefined(level._effect["ffar_mi28_muzzleflash"])) {
          playFXOnTag(scripts\engine\utility::getfx("ffar_mi28_muzzleflash"), self, var_9[var_9]);
        }

        thread delayed_earthquake(0.1, 0.5, 0.2, var_3.origin, 1600);
      }
    } else {
      self setvehweapon(var_6);

      if(isDefined(var_3)) {
        var_11 = self fireweapon(var_9[var_9], var_3);

        switch (var_1) {
          case "ffar_airlift":
          case "ffar_bog_a_lite":
          case "ffar":
            thread missilelosetarget(var_11);
            break;
          case "apache_zippy_wall":
          case "mi28_zippy_cheap":
          case "mi28_zippy":
          case "apache_zippy_nd":
          case "apache_zippy":
            if(!isDefined(var_5)) {
              thread missilelosetarget(var_11);
            } else {
              thread missilelosetarget(var_11);
            }

            break;
          default:
            break;
        }
      } else {
        var_11 = self fireweapon(var_9[var_10]);
      }

      self notify("missile_fired", var_11);
    }

    self.nextmissiletag = var_10;

    if(var_11 < var_3 - 1) {
      wait var_8;
    }

    if(isDefined(var_5)) {
      wait var_5;
    }

    var_11++;
  }

  self setvehweapon(var_9);
}

function delayed_earthquake(var_0, var_1, var_2, var_3, var_4) {
  wait var_0;
  earthquake(var_1, var_2, var_3, var_4);
}

function missilelosetarget(var_0) {
  self endon("death");
  wait var_0;

  if(isDefined(self)) {
    self missile_cleartarget();
    return;
  }
}