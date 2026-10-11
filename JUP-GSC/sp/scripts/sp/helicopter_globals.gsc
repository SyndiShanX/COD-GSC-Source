/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\helicopter_globals.gsc
************************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\helicopter_ai;
#using scripts\sp\helicopter_globals;
#using scripts\sp\utility;
#using scripts\vehicle\attack_heli;
#namespace helicopter_globals;

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
  cosine55 = cos(55);

  while(self.health > 0) {
    etarget = scripts\sp\helicopter_globals::getenemytarget(16000, cosine55, 1, 1);

    if(isDefined(etarget)) {
      thread scripts\sp\helicopter_globals::shootenemytarget_bullets(etarget);
    }

    wait 2;
  }
}

function heli_firelink(nextpoint) {
  target = getEnt(nextpoint.script_linkto, "script_linkname");
  var_243154aac115bc0a = !isDefined(target);

  if(!isDefined(target)) {
    target = getStruct(nextpoint.script_linkto, "script_linkname");
    assertex(isDefined(target), "No target for script_firelink");
  }

  fire_burst = nextpoint.script_firelink;

  if(var_243154aac115bc0a) {
    target = target spawn_tag_origin();
  }

  switch (fire_burst) {
    case #"hash_2c6245580ea45116":
      wait 1;
      scripts\sp\helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait 0.1;
      scripts\sp\helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait 0.2;
      scripts\sp\helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait 0.3;
      scripts\sp\helicopter_globals::fire_missile("hind_zippy", 1, target);
      wait 0.3;
      scripts\sp\helicopter_globals::fire_missile("hind_zippy", 1, target);
      break;
    case #"hash_4c67bcd319c7e278":
      waits = [0.1, 0.2, 0.3];
      wait 1;
      target.origin += (0, 0, -150);
      target moveTo(target.origin + (0, 0, 150), 0.6, 0, 0);

      foreach(waittime in waits) {
        if(!isDefined(self)) {
          continue;
        }

        scripts\sp\helicopter_globals::fire_missile("apache_zippy", 1, target);
        wait waittime;
      }

      break;
    case #"hash_16c9a0e31aadb518":
      scripts\sp\helicopter_globals::fire_missile("hind_rpg", 5, target, 0.3);
      break;
    default:
      if(self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500") {
        scripts\vehicle\attack_heli::heli_fire_missiles(target, 2, 0.25);
      } else {
        scripts\sp\helicopter_globals::fire_missile("hind_zippy", 5, target, 0.3);
      }

      break;
  }

  if(var_243154aac115bc0a) {
    target delete();
  }
}

function globalthink() {
  if(!isDefined(self.vehicletype)) {
    return;
  }

  ishelicopter = 0;

  if(self.vehicletype == "hind" || self.vehicletype == "hind_blackice" || self.vehicletype == "ny_harbor_hind") {
    ishelicopter = 1;
  }

  if(self.vehicletype == "cobra" || self.vehicletype == "cobra_player") {
    thread attachmissiles("chopperpilot_hellfire", "cobra_Sidewinder");

    if(isDefined(self.fullmodel)) {
      self.fullmodel thread attachmissiles("chopperpilot_hellfire", "cobra_Sidewinder");
    }

    ishelicopter = 1;
  }

  if(!ishelicopter) {
    return;
  }

  level thread flares_think(self);
  level thread scripts\sp\helicopter_ai::evasive_think(self);

  if(getDvar(@ "hash_9f748e2b88d4f7e3") == "1") {
    if(isDefined(self.script_wingman)) {
      level.wingman = self;
      level thread scripts\sp\helicopter_ai::wingman_think(self);
    }
  }
}

function flares_think(vehicle) {
  vehicle endon("death");
  notifyoncommand("flare_button", "+frag");
  notifyoncommand("flare_button", "+usereload");
  notifyoncommand("flare_button", "+activate");

  while(vehicle.health > 0) {
    if(isDefined(vehicle.playercontrolled)) {
      vehicle.pilot waittill("flare_button");
    } else {
      vehicle waittill("incomming_missile", emissile);

      if(!isDefined(emissile)) {
        continue;
      }

      if(randomint(3) == 0) {
        continue;
      }

      wait randomfloatrange(0.5, 1);
    }

    thread flares_fire(vehicle);
    wait 3;
  }
}

function flares_fire_burst(vehicle, fxcount, flarecount, flaretime) {
  assert(isDefined(level.flare_fx[vehicle.vehicletype]));
  assert(fxcount >= flarecount);
  var_7a203c9cb0bc1382 = 1;

  for(i = 0; i < fxcount; i++) {
    playFX(level.flare_fx[vehicle.vehicletype], vehicle gettagorigin("tag_flare"));

    if(isDefined(vehicle.playercontrolled)) {
      level.stats["flares_used"]++;
      vehicle notify("dropping_flares");

      if(var_7a203c9cb0bc1382) {
        vehicle playSound("cobra_flare_fire");
      }

      var_7a203c9cb0bc1382 = !var_7a203c9cb0bc1382;
    }

    if(i <= flarecount - 1) {
      thread flares_redirect_missiles(vehicle, flaretime);
    }

    wait 0.1;
  }
}

function flares_fire(vehicle) {
  vehicle endon("death");
  flaretime = 5;

  if(isDefined(vehicle.flare_duration)) {
    flaretime = vehicle.flare_duration;
  }

  flares_fire_burst(vehicle, 8, 1, flaretime);
}

function create_missileattractor_on_player_chopper() {
  assert(isDefined(self));
  assert(isDefined(self.centeraimpoint));

  if(isDefined(self.missileattractor)) {
    missile_deleteattractor(self.missileattractor);
  }

  self.missileattractor = missile_createattractorent(self.centeraimpoint, 10000, 10000);
}

function flares_redirect_missiles(vehicle, flaretime) {
  vehicle notify("flares_out");
  vehicle endon("death");
  vehicle endon("flares_out");

  if(!isDefined(flaretime)) {
    flaretime = 5;
  }

  vec = flares_get_vehicle_velocity(vehicle);
  flare = spawn("script_origin", vehicle gettagorigin("tag_flare"));
  flare movegravity(vec, flaretime);
  var_e7f1c1501040bde3 = undefined;

  if(isDefined(vehicle.playercontrolled)) {
    if(isDefined(vehicle.missileattractor)) {
      missile_deleteattractor(vehicle.missileattractor);
    }

    var_e7f1c1501040bde3 = missile_createattractorent(flare, 10000, 10000);
  }

  if(isDefined(vehicle.incomming_missiles)) {
    for(i = 0; i < vehicle.incomming_missiles.size; i++) {
      vehicle.incomming_missiles[i] missile_settargetEnt(flare);
    }
  }

  wait flaretime;

  if(isDefined(vehicle.playercontrolled)) {
    if(isDefined(var_e7f1c1501040bde3)) {
      missile_deleteattractor(var_e7f1c1501040bde3);
    }

    vehicle thread create_missileattractor_on_player_chopper();
  }

  if(!isDefined(vehicle.script_targetoffset_z)) {
    vehicle.script_targetoffset_z = 0;
  }

  offset = (0, 0, vehicle.script_targetoffset_z);

  if(!isDefined(vehicle.incomming_missiles)) {
    return;
  }

  for(i = 0; i < vehicle.incomming_missiles.size; i++) {
    vehicle.incomming_missiles[i] missile_settargetEnt(vehicle, offset);
  }
}

function flares_get_vehicle_velocity(vehicle) {
  org1 = vehicle.origin;
  wait 0.05;
  vec = vehicle.origin - org1;
  return vec * 20;
}

function missile_deathwait(emissile, emissile_target) {
  emissile_target endon("death");
  emissile waittill("death");

  if(!isDefined(emissile_target.incomming_missiles)) {
    return;
  }

  emissile_target.incomming_missiles = array_remove(emissile_target.incomming_missiles, emissile);
}

function getenemytarget(fradius, ifovcos, getaitargets, dosighttrace, getvehicletargets, randomizetargetarray, aexcluders) {
  if(!isDefined(getaitargets)) {
    getaitargets = 0;
  }

  if(!isDefined(dosighttrace)) {
    dosighttrace = 0;
  }

  if(!isDefined(getvehicletargets)) {
    getvehicletargets = 1;
  }

  if(!isDefined(randomizetargetarray)) {
    randomizetargetarray = 0;
  }

  etargets = [];
  eclosestvalidtarget = undefined;
  enemyteam = scripts\engine\utility::get_enemy_team(self.script_team);
  possibletargets = [];

  if(getvehicletargets) {
    foreach(vehicle in vehicle_getarray()) {
      if(!isDefined(vehicle.script_team)) {
        continue;
      }

      if(vehicle.script_team == enemyteam) {
        possibletargets[possibletargets.size] = vehicle;
      }
    }
  }

  if(getaitargets) {
    enemyai = getaiarray(enemyteam);

    for(i = 0; i < enemyai.size; i++) {
      if(isDefined(enemyai[i].ignored_by_attack_heli)) {
        continue;
      }

      possibletargets[possibletargets.size] = enemyai[i];
    }

    if(enemyteam == "allies") {
      for(i = 0; i < level.players.size; i++) {
        possibletargets[possibletargets.size] = level.players[i];
      }
    }
  }

  if(isDefined(aexcluders)) {
    possibletargets = array_exclude(possibletargets, aexcluders);
  }

  if(randomizetargetarray) {
    possibletargets = array_randomize(possibletargets);
  }

  forwardvec = anglesToForward(self.angles);

  for(i = 0; i < possibletargets.size; i++) {
    if(issentient(possibletargets[i]) && issentient(self) && self getthreatbiasgroup() != "") {
      bias = getthreatbias(possibletargets[i] getthreatbiasgroup(), self getthreatbiasgroup());

      if(bias <= -1000000) {
        continue;
      }
    }

    if(isDefined(fradius) && fradius > 0) {
      if(distance(self.origin, possibletargets[i].origin) > fradius) {
        continue;
      }
    }

    if(isDefined(ifovcos)) {
      normalvec = vectorNormalize(possibletargets[i].origin - self.origin);
      vecdot = vectordot(forwardvec, normalvec);

      if(vecdot <= ifovcos) {
        continue;
      }
    }

    if(dosighttrace) {
      sighttracepassed = 0;

      if(isai(possibletargets[i])) {
        tracezoffset = 48;
      } else {
        tracezoffset = 150;
      }

      sighttracepassed = sighttracepassed(self.origin, possibletargets[i].origin + (0, 0, tracezoffset), 0, self);

      if(!sighttracepassed) {
        continue;
      }
    }

    etargets[etargets.size] = possibletargets[i];
  }

  if(etargets.size == 0) {
    self notify("gunner_new_target", eclosestvalidtarget);
    return eclosestvalidtarget;
  }

  if(etargets.size == 1) {
    self notify("gunner_new_target", etargets[0]);
    return etargets[0];
  }

  thetarget = getclosest(self.origin, etargets);
  self notify("gunner_new_target", thetarget);
  return thetarget;
}

function shootenemytarget_bullets(etarget) {
  self endon("death");
  self endon("mg_off");
  etarget endon("death");
  self endon("gunner_new_target");

  if(isDefined(self.playercontrolled)) {
    self endon("gunner_stop_firing");
  }

  etargetoffset = (0, 0, 0);

  if(isDefined(etarget.script_targetoffset_z)) {
    etargetoffset += (0, 0, etarget.script_targetoffset_z);
  } else if(issentient(etarget)) {
    etargetoffset = (0, 0, 32);
  }

  self setturrettargetEnt(etarget, etargetoffset);

  while(self.health > 0) {
    randomshots = randomintrange(1, 25);

    if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
      iprintln("randomShots = " + randomshots);
    }

    for(i = 0; i < randomshots; i++) {
      if(isDefined(self.playercontrolled)) {
        if(isDefined(level.cobraweapon) && level.cobraweapon.size > 0) {
          self setvehweapon(level.gunnerweapon);
        }
      }

      thread shootenemytarget_bullets_debugline(self, "tag_turret", etarget, etargetoffset, (1, 1, 0), 0.05);
      self fireweapon("tag_flash");

      if(isDefined(self.playercontrolled)) {
        self setvehweapon(level.cobraweapon[self.pilot.currentweapon].v["weapon"]);
      }

      wait 0.05;
    }

    wait randomfloatrange(0.25, 2.5);
  }
}

function shootenemytarget_bullets_debugline(estartent, estartenttag, etarget, etargetoffset, color, timer) {
  if(getDvar(@ "hash_c9ab8c9fc46c92cf") != "<dev string:x1c>") {
    return;
  }

  if(!isDefined(color)) {
    color = (0, 0, 0);
  }

  etarget endon("<dev string:x1e>");
  self endon("<dev string:x24>");
  assert(isDefined(estartenttag));

  if(!isDefined(etargetoffset)) {
    etargetoffset = (0, 0, 0);
  }

  if(isDefined(timer)) {
    timer = gettime() + timer * 1000;

    while(gettime() < timer) {
      line(estartent gettagorigin(estartenttag), etarget.origin + etargetoffset, color);
      wait 0.05;
    }

    return;
  }

  for(;;) {
    line(estartent gettagorigin(estartenttag), etarget.origin + etargetoffset, color);
    wait 0.05;
  }
}

function attachmissiles(weapon1, weapon2, weapon3, weapon4) {
  self.hasattachedweapons = 1;
  assert(isDefined(weapon1));
  weapon = [];
  weapon[0] = weapon1;

  if(isDefined(weapon2)) {
    weapon[1] = weapon2;
  }

  if(isDefined(weapon3)) {
    weapon[2] = weapon3;
  }

  if(isDefined(weapon4)) {
    weapon[3] = weapon4;
  }

  for(i = 0; i < weapon.size; i++) {
    for(k = 0; k < level.cobra_weapon_tags[weapon[i]].size; k++) {
      self attach(level.cobra_missile_models[weapon[i]], level.cobra_weapon_tags[weapon[i]][k]);
    }
  }
}

function fire_missile(smissiletype, ishots, etarget, fdelay, target_los) {
  if(!isDefined(ishots)) {
    ishots = 1;
  }

  assert(self.health > 0);
  weaponname = undefined;
  weaponshoottime = undefined;
  defaultweapon = "cobra_20mm";
  tags = [];

  switch (smissiletype) {
    case #"hash_8a9a8bb5dc3486a0":
      weaponname = "cobra_Sidewinder";
      tags[0] = "le_side_wing_jnt";
      tags[1] = "ri_side_wing_jnt";
      break;
    case #"hash_b3c93b6b797f0875":
      weaponname = "cobra_seeker";
      tags[0] = "tag_store_L_1_a";
      tags[1] = "tag_store_R_1_a";
      tags[2] = "tag_store_L_2_a";
      tags[3] = "tag_store_R_2_a";
      break;
    case #"hash_3d94d0154908ee82":
      weaponname = "cobra_FFAR";
      tags[0] = "tag_store_r_2";
      break;
    case #"hash_328376e06ad436aa":
      weaponname = "cobra_seeker";
      tags[0] = "tag_store_r_2";
      break;
    case #"hash_839efbe411b43292":
      weaponname = "cobra_FFAR_bog_a_lite";
      tags[0] = "tag_store_r_2";
      break;
    case #"hash_94fe9ac788124de8":
      weaponname = "cobra_FFAR_airlift";
      tags[0] = "tag_store_L_wing";
      tags[1] = "tag_store_R_wing";
      break;
    case #"hash_deec76cccbc43374":
      weaponname = "cobra_FFAR_airlift_nofx";
      tags[0] = "tag_store_L_wing";
      tags[1] = "tag_store_R_wing";
      break;
    case #"hash_63dd5f263a6fa359":
      weaponname = "zippy_rockets";
      tags[0] = "tag_store_L_wing";
      tags[1] = "tag_store_R_wing";
      break;
    case #"hash_4c67bcd319c7e278":
      weaponname = "zippy_rockets_apache";
      tags[0] = "tag_flash_2";
      tags[1] = "tag_flash_3";
      break;
    case #"hash_3a4ef31af3db516f":
      weaponname = "zippy_rockets_apache_nodamage";
      tags[0] = "tag_flash_2";
      tags[1] = "tag_flash_3";
      break;
    case #"hash_443e386e3f9045ae":
      weaponname = "zippy_rockets_apache";
      tags[0] = "tag_store_L_wing";
      tags[1] = "tag_store_R_wing";
      break;
    case #"hash_5cee564ad78444a6":
      weaponname = "zippy_rockets_apache_cheap";
      tags[0] = "tag_store_L_wing";
      tags[1] = "tag_store_R_wing";
      break;
    case #"hash_2dc0d00b9de32bf1":
      weaponname = "hind_turret_penetration";
      tags[0] = "tag_store_L_wing";
      tags[1] = "tag_store_R_wing";
      break;
    case #"hash_e49b84d0e03dffd6":
      defaultweapon = "hind_turret";
      weaponname = "hind_FFAR";
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    case #"hash_fdd3bbf6ff0d543f":
      defaultweapon = "hind_turret";
      weaponname = "zippy_rockets";
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    case #"hash_16c9a0e31aadb518":
      defaultweapon = "hind_turret";
      weaponname = "rpg";
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    case #"hash_a0a5554df3c9d800":
      defaultweapon = "hind_turret";
      weaponname = "rpg_cheap";
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    case #"hash_4fc6e6ca2cb98381":
      defaultweapon = "hind_turret";
      weaponname = "hind_FFAR_nodamage";
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    case #"hash_c978062e6445430c":
      defaultweapon = "hind_turret";
      weaponname = "mi28_ffar_village_assault";
      tags[0] = "tag_store_L_2_a";
      tags[1] = "tag_store_R_2_a";
      tags[2] = "tag_store_L_2_b";
      tags[3] = "tag_store_R_2_b";
      tags[4] = "tag_store_L_2_c";
      tags[5] = "tag_store_R_2_c";
      tags[6] = "tag_store_L_2_d";
      tags[7] = "tag_store_R_2_d";
      break;
    case #"hash_6bacc9fb0186a1af":
      weaponname = "cobra_FFAR_bog_a_lite";
      tags[0] = "tag_store_R_2_a";
      tags[1] = "tag_store_L_2_a";
      break;
    default:
      assertmsg("Invalid missile type specified.");
      break;
  }

  assert(isDefined(weaponname));
  assert(tags.size > 0);
  weaponshoottime = weaponfiretime(weaponname);
  assert(isDefined(weaponshoottime));

  if(isDefined(self.nextmissiletag)) {
    nextmissiletag = self.nextmissiletag;
  } else {
    nextmissiletag = -1;
  }

  for(i = 0; i < ishots; i++) {
    nextmissiletag++;
    nextmissiletag %= tags.size;

    if(smissiletype == "ffar_mi28_village_assault") {
      if(isDefined(etarget) && isDefined(etarget.origin)) {
        magicbullet(weaponname, self gettagorigin(tags[nextmissiletag]), etarget.origin);

        if(isDefined(level._effect["ffar_mi28_muzzleflash"])) {
          playFXOnTag(getfx("ffar_mi28_muzzleflash"), self, tags[nextmissiletag]);
        }

        thread delayed_earthquake(0.1, 0.5, 0.2, etarget.origin, 1600);
      }
    } else {
      self setvehweapon(weaponname);

      if(isDefined(etarget)) {
        emissile = self fireweapon(tags[nextmissiletag], etarget);

        switch (smissiletype) {
          case #"hash_3d94d0154908ee82":
          case #"hash_839efbe411b43292":
          case #"hash_94fe9ac788124de8":
            emissile thread missilelosetarget(0.1);
            break;
          case #"hash_195ee7261f1a1fb5":
          case #"hash_3a4ef31af3db516f":
          case #"hash_443e386e3f9045ae":
          case #"hash_4c67bcd319c7e278":
          case #"hash_5cee564ad78444a6":
            if(!isDefined(target_los)) {
              emissile thread missilelosetarget(0.6);
            } else {
              emissile thread missilelosetarget(target_los);
            }

            break;
          default:
            break;
        }
      } else {
        emissile = self fireweapon(tags[nextmissiletag]);
      }

      self notify("missile_fired", emissile);
    }

    self.nextmissiletag = nextmissiletag;

    if(i < ishots - 1) {
      wait weaponshoottime;
    }

    if(isDefined(fdelay)) {
      wait fdelay;
    }
  }

  self setvehweapon(defaultweapon);
}

function delayed_earthquake(fdelay, scale, duration, source, fradius) {
  wait fdelay;
  earthquake(scale, duration, source, fradius);
}

function missilelosetarget(fdelay) {
  self endon("death");
  wait fdelay;

  if(isDefined(self)) {
    self missile_cleartarget();
  }
}