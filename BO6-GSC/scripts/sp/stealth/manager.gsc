/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\stealth\manager.gsc
******************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_table;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\door;
#using scripts\sp\stealth\player;
#using scripts\sp\utility;
#using scripts\stealth\door;
#using scripts\stealth\manager;
#namespace namespace_44096fb81ec0b367;

function main() {
  stealth_manager::main();
  level.player thread stealth_manager::update_stealth_spotted_thread();
  level.player thread function_5752265428cf3c51();
  level.player thread update_stealth_spotted_thread();
  level thread stealth_manager::manager_thread();

  if(door_sp::function_1c2fb6a9190a2421()) {
    door::stealth_suspicious_doors_init();
  }

  assert(isDefined(level.stealth), "<dev string:x24>");
  level.stealth.fnplayerlootenabled = &utility_sp::playerlootenabled;
  level.stealth.fnsetbattlechatter = &utility::set_battlechatter;
  level.stealth.fnaddeventplaybcs = &battlechatter::addeventplaybcs;
  level.stealth.fnanimgenericcustomanimmode = &anim_sp::anim_generic_custom_animmode;
  var_cd389afdcc9febb8 = function_fdaf3a8cbe025861();

  if(isarray(var_cd389afdcc9febb8) && var_cd389afdcc9febb8.size > 0) {
    level.stealth.fnthreatsightplayersightaudio = &threat_sight_player_sight_audio;
    level.stealth.fnthreatsightplayersightaudiocleanup = &function_6e83d9bed5ee310c;
    level notify("\x1d\x1b0\x1a\x8c\x98\xc3p\x98& 0\x90\x8fz\xc9\xc7\xee\xa6\x89\x85\xe8_\x15X\xdb\xa7");
  } else {
    println("<dev string:x6f>");
  }

  level.stealth.var_d7c0c88cfdabd5a8 = &function_511c0c4464213104;
  level.stealth.var_4c9be84f33b1416e = &function_1ed6ad941982b6cb;
  level notify("qFT\xacH\xdb:\x15\x83\xe4@A\x16\x11f\xd5o\xc5*o6T\xd8XP\xafJ");
  level.stealth.fnsetstealthmode = &set_stealth_mode_sp;
  setdvarifuninitialized(@ "scr_sixthsense_enabled", 1);
  setdvarifuninitialized(@ "hash_82eb856681438f08", 1);
  setdvarifuninitialized(@ "hash_3a810db500922b6c", 0);

  if(getdvarint(@ "scr_sixthsense_enabled")) {
    level.stealth.fnsixthsense = &namespace_5a0f99556b0f68f7::sixthsense_init;
  }

  function_69b970e5ea26252b([level.player]);
  battlechatter_table::bctable_setfiles("\x12\xc2\xc8\x9d-\x1d\x9b", "\xbe\xca-j\xb5Z=\xeeO\x92\bK\v0fg\xf1\x1e\xc0\x14!\xa1\xf8U\xdd\x0e~", "\xd5?\xe0\xd5\xe7\xbf\x13h\xb7\b~_\x93u\x16XU\xca\xbe\x92\xe4\xa4\xc7?Af\x9f\x16\xd4\x98");
}

function set_stealth_mode_sp(enabled, musichidden, musicspotted) {
  if(enabled) {
    foreach(player in level.players) {
      player thread namespace_5a0f99556b0f68f7::ambient_player_thread();
    }

    return;
  }

  foreach(player in level.players) {
    player thread namespace_5a0f99556b0f68f7::ambient_player_stop();
  }
}

function function_fdaf3a8cbe025861() {
  aliases = ["\xfdI\x8ep\r$\x9a\\\xd8\xf5,\xc5\xaa.\xd5\b\x14Pg\xa9\xc9\x1eX\x7f", "\x1by\x9e\xf5\x8b\xed*\xfc\xf9\xe8C\xafq\xc3:\x9e[\xf4\x10\xb3\xabB\xee\xf8", "\xba\xc4\x81_^\xc5\xd7/L~\xd3L\x06\x88}\x80k\x95\x19\x8972\xbdNz"];

  foreach(sndalias in aliases) {
    if(!soundexists(sndalias)) {
      println("<dev string:xac>" + sndalias + "<dev string:xda>");
      return undefined;
    }
  }

  return aliases;
}

function threat_sight_player_sight_audio(anycansee, maxthreat, willdebugprint) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xc7IV\xd8\xf9\x89\\O\xfb\xdb\x88I\"z\xbe\xb3qA\x13!{\xa4>\xac\xb8,\x01\v^\x14o");
  self endon("\xc7IV\xd8\xf9\x89\\O\xfb\xdb\x88I\"z\xbe\xb3qA\x13!{\xa4>\xac\xb8,\x01\v^\x14o");
  level endon("\xcd\x90ny|\xfa\x04\xf6\xa7/\x8d\xb8\xad\xaf\x7f\xe1\x87{\x1d2=\x8c'\xde$v\xc3");

  if(!isDefined(willdebugprint)) {
    willdebugprint = 0;
  }

  aliases = function_fdaf3a8cbe025861();
  assert(isarray(aliases) && aliases.size > 0, "<dev string:xeb>");

  if(!getdvarint(@ "hash_21b72d8c9ff7a1b3", 0)) {
    maxthreat = 0;
  }

  if(!isDefined(self.stealth.threat_sight_snd_ent) && anycansee && maxthreat > 0) {
    self.stealth.threat_sight_snd_ent = [];
    self.stealth.threat_sight_snd_vol = 0;
    self.stealth.threat_sight_snd_threat = 0;

    foreach(index, alias in aliases) {
      snd_ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);

      if(!isPlayer(self)) {
        thread utility::delete_on_death(snd_ent);
      }

      snd_ent linkTo(self);
      snd_ent scalevolume(0, 0);
      snd_ent.isplaying = 0;
      self.stealth.threat_sight_snd_ent[alias] = snd_ent;
    }
  }

  if(willdebugprint) {
    printtoscreen2d(32, 492, "<dev string:x126>" + maxthreat + "<dev string:x137>" + anycansee + "<dev string:x13d>", (1, 1, 1), 1.5);
  }

  if(isDefined(self.stealth.threat_sight_snd_ent)) {
    self.stealth.threat_sight_snd_threat -= self.stealth.threat_sight_snd_threat * 0.125;
    self.stealth.threat_sight_snd_threat += maxthreat * 0.125;

    if(self.stealth.threat_sight_snd_threat < 0.0001) {
      self.stealth.threat_sight_snd_threat = 0;
    }

    maxthreat = self.stealth.threat_sight_snd_threat;
  }

  while(isDefined(self.stealth.threat_sight_snd_ent)) {
    index = 0;
    var_f757d7864b659204 = 0;

    if(maxthreat > 0) {
      var_33ab3968228b3fef = function_7341d3484a85ad15(self);

      if(maxthreat < 0.05) {
        threat_clamped = clamp(maxthreat, 0, 0.05);
        mu = threat_clamped / 0.05;
        vol_delta = 0.99;
        vol_lerp = 0.01 + vol_delta * mu;
        self.stealth.threat_sight_snd_vol = vol_lerp;
      } else {
        self.stealth.threat_sight_snd_vol = 1;
      }
    } else {
      self.stealth.threat_sight_snd_vol = 0;
      self.stealth.threat_sight_snd_threat = 0;
    }

    self.stealth.threat_sight_snd_vol = clamp(self.stealth.threat_sight_snd_vol, 0, 1);

    if(willdebugprint) {
      printtoscreen2d(32, 508, "<dev string:x142>" + self.stealth.threat_sight_snd_threat, (1, 1, 1), 1.5);
    }

    if(willdebugprint) {
      printtoscreen2d(32, 524, "<dev string:x153>" + self.stealth.threat_sight_snd_vol, (1, 1, 1), 1.5);
    }

    foreach(alias, snd_ent in self.stealth.threat_sight_snd_ent) {
      coef = 1;

      switch (index) {
        case 0:
          if(maxthreat < 0.75) {
            coef = cos(180 * maxthreat * 0.666);
          } else {
            coef = 0;
          }

          break;
        case 1:
          if(maxthreat < 0.75) {
            coef = sin(180 * maxthreat * 0.666);
          } else if(maxthreat < 1) {
            coef = sin(180 * (1 - maxthreat) * 2);
          } else {
            coef = 0;
          }

          break;
        case 2:
          if(maxthreat < 0.75) {
            coef = 0;
          } else {
            coef = cos(180 * (1 - maxthreat) * 2);
          }

          break;
      }

      vol = clamp(self.stealth.threat_sight_snd_vol * coef, 0, 1);

      if(vol > 0) {
        var_f757d7864b659204 = 1;

        if(snd_ent.isplaying == 0) {
          snd_ent scalevolume(0, 0);
          mapname = getDvar(@ "g_mapname");

          if(mapname != "\xe3\xbf\a\xa8\xbc\x80") {
            snd_ent utility::delaycall(0.05, &playloopsound, alias);
          }

          snd_ent.isplaying = 1;
        }

        snd_ent scalevolume(vol, 0.05);
        snd_ent utility::delaycall(0, &scalevolume, vol, 0.05);
      } else if(snd_ent.isplaying == 1) {
        snd_ent scalevolume(0, 0.05);
        snd_ent utility::delaycall(0.05, &stoploopsound);
        snd_ent.isplaying = 0;
      }

      if(willdebugprint) {
        printtoscreen2d(32, 540 + index * 16, "<dev string:x164>" + index + "<dev string:x16e>" + vol, (1, 1, 1), 1.5);
      }

      if(willdebugprint) {
        printtoscreen2d(384, 540 + index * 16, "<dev string:x178>" + coef, (1, 1, 1), 1.5);
      }

      index++;
    }

    if(!var_f757d7864b659204) {
      foreach(alias, snd_ent in self.stealth.threat_sight_snd_ent) {
        snd_ent scalevolume(0, 0.05);
        snd_ent stoploopsound();
        snd_ent utility::delaycall(0.05, &delete);
      }

      self.stealth.threat_sight_snd_ent = undefined;
      self.stealth.threat_sight_snd_vol = undefined;
      self.stealth.threat_sight_snd_threat = undefined;
    }

    wait 0.05;
  }
}

function function_6e83d9bed5ee310c() {
  if(isDefined(self.stealth.threat_sight_snd_ent)) {
    fade_time = self.stealth.threat_sight_snd_threat / 0.125;

    foreach(snd_ent in self.stealth.threat_sight_snd_ent) {
      snd_ent scalevolume(0, fade_time);
      snd_ent utility::delaycall(fade_time, &stoploopsound);
      snd_ent utility::delaycall(fade_time + 0.05, &delete);
    }

    self stoprumble("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
    self.stealth.threat_sight_snd_ent = undefined;
    self.stealth.threat_sight_snd_vol = undefined;
    self.stealth.threat_sight_snd_threat = undefined;
  }
}

function function_511c0c4464213104(anycansee, maxthreat) {
  if(stealth_manager::anyone_in_combat()) {
    if(isDefined(level.stealth.previousmaxthreat) && level.stealth.previousmaxthreat > 0) {
      self stoprumble("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
      self playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
    }

    maxthreat = 0;
  } else if((!isDefined(level.stealth.previousmaxthreat) || level.stealth.previousmaxthreat <= 0) && maxthreat > 0 && maxthreat < 1) {
    self playrumblelooponentity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
  } else if(isDefined(level.stealth.previousmaxthreat) && level.stealth.previousmaxthreat > 0 && maxthreat <= 0) {
    self stoprumble("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
  } else if((!isDefined(level.stealth.previousmaxthreat) || isDefined(level.stealth.previousmaxthreat) && level.stealth.previousmaxthreat < 1) && maxthreat >= 1) {
    self stoprumble("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
    self playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
  }

  level.stealth.previousmaxthreat = maxthreat;
}

function function_1ed6ad941982b6cb() {
  self stoprumble("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
}

function private update_stealth_spotted_thread() {
  self notify("a\xfd\xba|\xed\xd1\xbau\xfbeCVH\b\n\xdc");
  self endon("a\xfd\xba|\xed\xd1\xbau\xfbeCVH\b\n\xdc");

  if(!isDefined(level.stealth.spottedsfx)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("\x1f\x93?pK+\x9c", ai);
    ent = self;

    if(issentient(ai)) {
      ent = ai;
    }

    ent playsoundatviewheight(level.stealth.spottedsfx);
  }
}

function private function_5752265428cf3c51() {
  self notify("\xc2 \x95\xa3\xc4\xba\xb0?\x170\xbb\xc6\xd4\x15\t\xc3");
  self endon("\xc2 \x95\xa3\xc4\xba\xb0?\x170\xbb\xc6\xd4\x15\t\xc3");

  if(!isDefined(level.stealth.sightedsfx)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  var_408da87583835344 = -1;

  while(true) {
    self waittill("u\x1a\xae2C$\xd6", ai);
    alreadysighted = 0;

    if(isDefined(self.var_9846878b6e719559) && isDefined(self.var_9846878b6e719559.active) && self.var_9846878b6e719559.active.size > 1) {
      alreadysighted = 1;
    } else if(stealth_manager::anyone_in_combat()) {
      alreadysighted = 1;
    }

    if(gettime() >= var_408da87583835344 && !alreadysighted) {
      var_408da87583835344 = gettime() + 0;
      ent = self;

      if(issentient(ai)) {
        ent = ai;
      }

      ent playsoundatviewheight(level.stealth.sightedsfx);
    }
  }
}