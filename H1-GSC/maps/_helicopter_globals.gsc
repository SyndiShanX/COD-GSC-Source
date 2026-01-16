/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_helicopter_globals.gsc
****************************************/

init_helicopters() {
  level.helicopter_firelinkfunk = ::heli_firelink;
  level.chopperturretonfunc = ::chopper_turret_on;
  level.chopperturretofffunc = ::chopper_turret_off;
}

chopper_turret_off() {
  self notify("mg_off");
}

chopper_turret_on() {
  self endon("death");
  self endon("mg_off");
  var_0 = cos(55);

  while (self.health > 0) {
    var_1 = getenemytarget(16000, var_0, 1, 1);

    if(isdefined(var_1))
      thread shootenemytarget_bullets(var_1);

    wait 2;
  }
}

heli_firelink(var_0) {
  var_1 = getent(var_0.script_linkto, "script_linkname");
  var_2 = !isdefined(var_1);

  if(!isdefined(var_1))
    var_1 = common_scripts\utility::getstruct(var_0.script_linkto, "script_linkname");

  var_3 = var_0.script_firelink;

  if(var_2)
    var_1 = var_1 common_scripts\utility::spawn_tag_origin();

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
      var_1.origin = var_1.origin + (0, 0, -150);
      var_1 moveto(var_1.origin + (0, 0, 150), 0.6, 0, 0);

      foreach(var_6 in var_4) {
        if(!isdefined(self)) {
          continue;
        }
        fire_missile("apache_zippy", 1, var_1);
        wait(var_6);
      }

      break;
    case "hind_rpg":
      fire_missile("hind_rpg", 5, var_1, 0.3);
      break;
    default:
      if(self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500")
        vehicle_scripts\_attack_heli::heli_fire_missiles(var_1, 2, 0.25);
      else
        fire_missile("hind_zippy", 5, var_1, 0.3);

      break;
  }

  if(var_2)
    var_1 delete();
}

globalthink() {
  if(!isdefined(self.vehicletype)) {
    return;
  }
  var_0 = 0;

  if(self.vehicletype == "hind" || self.vehicletype == "hind_blackice" || self.vehicletype == "ny_harbor_hind")
    var_0 = 1;

  if(self.vehicletype == "cobra" || self.vehicletype == "cobra_player") {
    thread attachmissiles("chopperpilot_hellfire", "cobra_Sidewinder");

    if(isdefined(self.fullmodel))
      self.fullmodel thread attachmissiles("chopperpilot_hellfire", "cobra_Sidewinder");

    var_0 = 1;
  }

  if(!var_0) {
    return;
  }
  level thread flares_think(self);
  level thread maps\_helicopter_ai::evasive_think(self);

  if(getdvar("cobrapilot_wingman_enabled") == "1") {
    if(isdefined(self.script_wingman)) {
      level.wingman = self;
      level thread maps\_helicopter_ai::wingman_think(self);
    }
  }
}

flares_think(var_0) {
  var_0 endon("death");
  notifyoncommand("flare_button", "+frag");
  notifyoncommand("flare_button", "+usereload");
  notifyoncommand("flare_button", "+activate");

  while (var_0.health > 0) {
    if(isdefined(var_0.playercontrolled))
      var_0.pilot waittill("flare_button");
    else {
      var_0 waittill("incomming_missile", var_1);

      if(!isdefined(var_1)) {
        continue;
      }
      if(randomint(3) == 0) {
        continue;
      }
      wait(randomfloatrange(0.5, 1.0));
    }

    thread flares_fire(var_0);
    wait 3.0;
  }
}

flares_fire_burst(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  for (var_5 = 0; var_5 < var_1; var_5++) {
    playfx(level.flare_fx[var_0.vehicletype], var_0 gettagorigin("tag_flare"));

    if(isdefined(var_0.playercontrolled)) {
      level.stats["flares_used"]++;
      var_0 notify("dropping_flares");

      if(var_4)
        var_0 playsound("cobra_flare_fire");

      var_4 = !var_4;
    }

    if(var_5 <= var_2 - 1)
      thread flares_redirect_missiles(var_0, var_3);

    wait 0.1;
  }
}

flares_fire(var_0) {
  var_0 endon("death");
  var_1 = 5.0;

  if(isdefined(var_0.flare_duration))
    var_1 = var_0.flare_duration;

  flares_fire_burst(var_0, 8, 1, var_1);
}

create_missileattractor_on_player_chopper() {
  if(isdefined(self.missileattractor))
    missile_deleteattractor(self.missileattractor);

  self.missileattractor = missile_createattractorent(self.centeraimpoint, 10000, 10000);
}

flares_redirect_missiles(var_0, var_1) {
  var_0 notify("flares_out");
  var_0 endon("death");
  var_0 endon("flares_out");

  if(!isdefined(var_1))
    var_1 = 5.0;

  var_2 = flares_get_vehicle_velocity(var_0);
  var_3 = spawn("script_origin", var_0 gettagorigin("tag_flare"));
  var_3 movegravity(var_2, var_1);
  var_4 = undefined;

  if(isdefined(var_0.playercontrolled)) {
    if(isdefined(var_0.missileattractor))
      missile_deleteattractor(var_0.missileattractor);

    var_4 = missile_createattractorent(var_3, 10000, 10000);
  }

  if(isdefined(var_0.incomming_missiles)) {
    for (var_5 = 0; var_5 < var_0.incomming_missiles.size; var_5++)
      var_0.incomming_missiles[var_5] missile_settargetent(var_3);
  }

  wait(var_1);

  if(isdefined(var_0.playercontrolled)) {
    if(isdefined(var_4))
      missile_deleteattractor(var_4);

    var_0 thread create_missileattractor_on_player_chopper();
  }

  if(!isdefined(var_0.script_targetoffset_z))
    var_0.script_targetoffset_z = 0;

  var_6 = (0, 0, var_0.script_targetoffset_z);

  if(!isdefined(var_0.incomming_missiles)) {
    return;
  }
  for (var_5 = 0; var_5 < var_0.incomming_missiles.size; var_5++)
    var_0.incomming_missiles[var_5] missile_settargetent(var_0, var_6);
}

flares_get_vehicle_velocity(var_0) {
  var_1 = var_0.origin;
  wait 0.05;
  var_2 = var_0.origin - var_1;
  return var_2 * 20;
}

missile_deathwait(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");

  if(!isdefined(var_1.incomming_missiles)) {
    return;
  }
  var_1.incomming_missiles = common_scripts\utility::array_remove(var_1.incomming_missiles, var_0);
}

getenemytarget(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

  if(!isdefined(var_4))
    var_4 = 1;

  if(!isdefined(var_5))
    var_5 = 0;

  var_7 = [];
  var_8 = undefined;
  var_9 = common_scripts\utility::get_enemy_team(self.script_team);
  var_10 = [];

  if(var_4) {
    for (var_11 = 0; var_11 < level.vehicles[var_9].size; var_11++)
      var_10[var_10.size] = level.vehicles[var_9][var_11];
  }

  if(var_2) {
    var_12 = getaiarray(var_9);

    for (var_11 = 0; var_11 < var_12.size; var_11++) {
      if(isdefined(var_12[var_11].ignored_by_attack_heli)) {
        continue;
      }
      var_10[var_10.size] = var_12[var_11];
    }

    if(var_9 == "allies") {
      for (var_11 = 0; var_11 < level.players.size; var_11++)
        var_10[var_10.size] = level.players[var_11];
    }
  }

  if(isdefined(var_6))
    var_10 = maps\_utility::array_exclude(var_10, var_6);

  if(var_5)
    var_10 = common_scripts\utility::array_randomize(var_10);

  var_13 = anglestoforward(self.angles);

  for (var_11 = 0; var_11 < var_10.size; var_11++) {
    if(issentient(var_10[var_11]) && issentient(self) && self getthreatbiasgroup() != "") {
      var_14 = getthreatbias(var_10[var_11] getthreatbiasgroup(), self getthreatbiasgroup());

      if(var_14 <= -1000000)
        continue;
    }

    if(isdefined(var_0) && var_0 > 0) {
      if(distance(self.origin, var_10[var_11].origin) > var_0)
        continue;
    }

    if(isdefined(var_1)) {
      var_15 = vectornormalize(var_10[var_11].origin - self.origin);
      var_16 = vectordot(var_13, var_15);

      if(var_16 <= var_1)
        continue;
    }

    if(var_3) {
      var_17 = 0;

      if(isai(var_10[var_11]))
        var_18 = 48;
      else
        var_18 = 150;

      var_17 = sighttracepassed(self.origin, var_10[var_11].origin + (0, 0, var_18), 0, self);

      if(!var_17)
        continue;
    }

    var_7[var_7.size] = var_10[var_11];
  }

  if(var_7.size == 0) {
    self notify("gunner_new_target", var_8);
    return var_8;
  }

  if(var_7.size == 1) {
    self notify("gunner_new_target", var_7[0]);
    return var_7[0];
  }

  var_19 = common_scripts\utility::getclosest(self.origin, var_7);
  self notify("gunner_new_target", var_19);
  return var_19;
}

shootenemytarget_bullets(var_0) {
  self endon("death");
  self endon("mg_off");
  var_0 endon("death");
  self endon("gunner_new_target");

  if(isdefined(self.playercontrolled))
    self endon("gunner_stop_firing");

  var_1 = (0, 0, 0);

  if(isdefined(var_0.script_targetoffset_z))
    var_1 = var_1 + (0, 0, var_0.script_targetoffset_z);
  else if(issentient(var_0))
    var_1 = (0, 0, 32);

  self setturrettargetent(var_0, var_1);

  while (self.health > 0) {
    var_2 = randomintrange(1, 25);

    if(getdvar("cobrapilot_debug") == "1")
      iprintln("randomShots = " + var_2);

    for (var_3 = 0; var_3 < var_2; var_3++) {
      if(isdefined(self.playercontrolled)) {
        if(isdefined(level.cobraweapon) && level.cobraweapon.size > 0)
          self setvehweapon(level.gunnerweapon);
      }

      thread shootenemytarget_bullets_debugline(self, "tag_turret", var_0, var_1, (1, 1, 0), 0.05);
      self fireweapon("tag_flash");

      if(isdefined(self.playercontrolled))
        self setvehweapon(level.cobraweapon[self.pilot.currentweapon].v["weapon"]);

      wait 0.05;
    }

    wait(randomfloatrange(0.25, 2.5));
  }
}

shootenemytarget_bullets_debugline(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvar("cobrapilot_debug") != "1") {
    return;
  }
  if(!isdefined(var_4))
    var_4 = (0, 0, 0);

  var_2 endon("death");
  self endon("gunner_new_target");

  if(!isdefined(var_3))
    var_3 = (0, 0, 0);

  if(isdefined(var_5)) {
    var_5 = gettime() + var_5 * 1000;

    while (gettime() < var_5)
      wait 0.05;
  } else {
    for (;;)
      wait 0.05;
  }
}

attachmissiles(var_0, var_1, var_2, var_3) {
  self.hasattachedweapons = 1;
  var_4 = [];
  var_4[0] = var_0;

  if(isdefined(var_1))
    var_4[1] = var_1;

  if(isdefined(var_2))
    var_4[2] = var_2;

  if(isdefined(var_3))
    var_4[3] = var_3;

  for (var_5 = 0; var_5 < var_4.size; var_5++) {
    for (var_6 = 0; var_6 < level.cobra_weapon_tags[var_4[var_5]].size; var_6++)
      self attach(level.cobra_missile_models[var_4[var_5]], level.cobra_weapon_tags[var_4[var_5]][var_6]);
  }
}

fire_missile(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_1))
    var_1 = 1;

  var_5 = undefined;
  var_6 = undefined;
  var_7 = "cobra_20mm";
  var_8 = [];

  switch (var_0) {
    case "f15_missile":
      var_5 = "cobra_Sidewinder";
      var_8[0] = "le_side_wing_jnt";
      var_8[1] = "ri_side_wing_jnt";
      break;
    case "mi28_seeker":
      var_5 = "cobra_seeker";
      var_8[0] = "tag_store_L_1_a";
      var_8[1] = "tag_store_R_1_a";
      var_8[2] = "tag_store_L_2_a";
      var_8[3] = "tag_store_R_2_a";
      break;
    case "ffar":
      var_5 = "cobra_FFAR";
      var_8[0] = "tag_store_r_2";
      break;
    case "seeker":
      var_5 = "cobra_seeker";
      var_8[0] = "tag_store_r_2";
      break;
    case "ffar_bog_a_lite":
      var_5 = "cobra_ffar_bog_a_lite";
      var_8[0] = "tag_store_r_2";
      break;
    case "ffar_airlift":
      var_5 = "cobra_ffar_airlift";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "ffar_airlift_map_overwrite":
      var_5 = "cobra_ffar_airlift_map_overwrite";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "ffar_airlift_nofx":
      var_5 = "cobra_ffar_airlift_nofx";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "cobra_zippy":
      var_5 = "zippy_rockets";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "apache_zippy":
      var_5 = "zippy_rockets_apache";
      var_8[0] = "tag_flash_2";
      var_8[1] = "tag_flash_3";
      break;
    case "apache_zippy_nd":
      var_5 = "zippy_rockets_apache_nodamage";
      var_8[0] = "tag_flash_2";
      var_8[1] = "tag_flash_3";
      break;
    case "mi28_zippy":
      var_5 = "zippy_rockets_apache";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "mi28_zippy_cheap":
      var_5 = "zippy_rockets_apache_cheap";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "cobra_turret":
      var_5 = "hind_turret_penetration";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "ffar_hind":
      var_7 = "hind_turret";
      var_5 = "hind_ffar";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "hind_zippy":
      var_7 = "hind_turret";
      var_5 = "zippy_rockets";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "hind_rpg":
      var_7 = "hind_turret";
      var_5 = "rpg";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "hind_rpg_cheap":
      var_7 = "hind_turret";
      var_5 = "rpg_cheap";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "ffar_hind_nodamage":
      var_7 = "hind_turret";
      var_5 = "hind_FFAR_nodamage";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "ffar_mi28_village_assault":
      var_7 = "hind_turret";
      var_5 = "mi28_ffar_village_assault";
      var_8[0] = "tag_store_L_2_a";
      var_8[1] = "tag_store_R_2_a";
      var_8[2] = "tag_store_L_2_b";
      var_8[3] = "tag_store_R_2_b";
      var_8[4] = "tag_store_L_2_c";
      var_8[5] = "tag_store_R_2_c";
      var_8[6] = "tag_store_L_2_d";
      var_8[7] = "tag_store_R_2_d";
      break;
    case "ffar_co_rescue":
      var_5 = "cobra_ffar_bog_a_lite";
      var_8[0] = "tag_store_R_2_a";
      var_8[1] = "tag_store_L_2_a";
      break;
    default:
      break;
  }

  var_6 = weaponfiretime(var_5);

  if(isdefined(self.nextmissiletag))
    var_9 = self.nextmissiletag;
  else
    var_9 = -1;

  for (var_10 = 0; var_10 < var_1; var_10++) {
    var_9++;
    var_9 = var_9 % var_8.size;

    if(var_0 == "ffar_mi28_village_assault") {
      if(isdefined(var_2) && isdefined(var_2.origin)) {
        var_11 = self gettagorigin(var_8[var_9]);
        var_12 = vectornormalize(var_2.origin - var_11);
        var_12 = var_12 * 50;
        magicbullet(var_5, var_11 + var_12, var_2.origin);

        if(isdefined(level._effect["ffar_mi28_muzzleflash"]))
          playfxontag(common_scripts\utility::getfx("ffar_mi28_muzzleflash"), self, var_8[var_9]);

        thread delayed_earthquake(0.1, 0.5, 0.2, var_2.origin, 1600);
      }
    } else {
      self setvehweapon(var_5);

      if(isdefined(var_2)) {
        var_13 = self fireweapon(var_8[var_9], var_2);
        soundscripts\_audio::deprecated_aud_send_msg("missile_fired", var_13);

        switch (var_0) {
          case "ffar_bog_a_lite":
          case "ffar":
            var_13 thread maps\_utility::play_sound_on_tag("weap_lau61c_fire", undefined, 1);
          case "ffar_airlift_map_overwrite":
          case "ffar_airlift":
            var_13 thread missilelosetarget(0.1);
            break;
          case "apache_zippy_wall":
          case "mi28_zippy_cheap":
          case "mi28_zippy":
          case "apache_zippy_nd":
          case "apache_zippy":
            if(!isdefined(var_4))
              var_13 thread missilelosetarget(0.6);
            else
              var_13 thread missilelosetarget(var_4);

            break;
          default:
            break;
        }
      } else
        var_13 = self fireweapon(var_8[var_9]);

      self notify("missile_fired", var_13);
    }

    self.nextmissiletag = var_9;

    if(var_10 < var_1 - 1)
      wait(var_6);

    if(isdefined(var_3))
      wait(var_3);
  }

  self setvehweapon(var_7);
}

delayed_earthquake(var_0, var_1, var_2, var_3, var_4) {
  wait(var_0);
  earthquake(var_1, var_2, var_3, var_4);
}

missilelosetarget(var_0) {
  self endon("death");
  wait(var_0);

  if(isdefined(self))
    self missile_cleartarget();
}