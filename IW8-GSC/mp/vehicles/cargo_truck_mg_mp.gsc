/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\cargo_truck_mg_mp.gsc
***********************************************/

main() {
  scripts\stealth\manager::main();
  level.stealth.cantracetoaiignoreents = [];
  level.stealth.fnaddeventplaybcs = ::_id_123CC;
  level.stealth.fnthreatsightsetstateparameters = ::threat_sight_set_state_parameters;
  level.fngetcorpsearrayfunc = ::propaddtolocation;
  level.stealth.playerdelaydisablezombie = ::_id_119DB;
  level.stealth.playerclearspectatekillchainsystem = scripts\cp\coop_stealth::quickdropnewitem;
  set_detect_ranges();
  _id_13078();
  level thread scripts\stealth\threat_sight::threat_sight_set_enabled(1);
  level thread manager_thread();
  level thread update_stealth_spotted_thread();
}

empty(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

set_detect_ranges() {}

_id_13078() {
  var_0["_encstr_87710BBFFF2A6BC0377758139B"] = 600;
  var_0["_encstr_99A90CC42D130F4E7971C2EAE881"] = 300;
  var_0["_encstr_97540BC2FF7F2641F988425F15"] = 100;
  scripts\stealth\corpse::set_corpse_ranges(var_0);
}

manager_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    threat_sight_set_dvar(1);
    scripts\engine\utility::flag_wait("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

    if(!scripts\engine\utility::flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      continue;
    }
    scripts\stealth\manager::event_change("_encstr_8ADA089BC1B78EE8B246");
    scripts\engine\utility::flag_waitopen("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

    if(!scripts\engine\utility::flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      continue;
    }
    scripts\stealth\manager::event_change("_encstr_95DF070DD22319CA9B");
    waittillframeend;
  }
}

threat_sight_set_dvar(var_0) {
  setdvarifuninitialized("_encstr_8FDC145880F1AB605335788BA81043A36B71DEBED563", 0.4);
  setdvarifuninitialized("_encstr_AD5213F054EFE4945530F88311BF36A021CF88331B", 0.5);

  if(var_0 && (!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled)) {
    return;
  }
  setDvar("_encstr_9A3D0B872F1FF1E3D10C8B4407", var_0);
}

update_stealth_spotted_thread() {
  waitframe();
  var_0 = 0;

  for(;;) {
    var_1 = scripts\stealth\manager::anyone_in_combat();

    if(var_1) {
      if(!var_0 && isDefined(level.stealth.stealth_spotted_delay)) {
        wait(level.stealth.stealth_spotted_delay);

        if(!scripts\stealth\manager::anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8")) {
        scripts\engine\utility::flag_set("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

        foreach(var_3 in level.players) {
          if(isDefined(var_3.stealth)) {
            var_4 = var_3 scripts\stealth\utility::get_group_flagname("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
            scripts\engine\utility::flag_set(var_4);
          }
        }
      }
    } else if(scripts\engine\utility::flag("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8")) {
      scripts\engine\utility::flag_clear("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");

      foreach(var_3 in level.players) {
        if(isDefined(var_3.stealth)) {
          var_4 = var_3 scripts\stealth\utility::get_group_flagname("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
          scripts\engine\utility::flag_clear(var_4);
        }
      }
    }

    var_0 = var_1;
    waitframe();
  }
}

threat_sight_set_state_parameters(var_0) {
  if(!isalive(self)) {
    return;
  }
  var_1 = 1.0;
  var_2 = 1.0;

  if(!isDefined(var_0))
    var_0 = self.stealth.threat_sight_state;

  if(isDefined(self.stealth.threatsightratescale))
    var_1 = var_1 * self.stealth.threatsightratescale;

  if(isDefined(self.stealth.threatsightdistscale))
    var_2 = var_2 * self.stealth.threatsightdistscale;

  if(isDefined(level.stealth.threatsightratescale))
    var_1 = var_1 * level.stealth.threatsightratescale;

  if(isDefined(level.stealth.threatsightdistscale))
    var_2 = var_2 * level.stealth.threatsightdistscale;

  switch (var_0) {
    case "_encstr_844113531177F3A8D89877BC1369E19AC0A9D78BE7":
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 1.333 * var_1;
      self.threatsightratemax = 0.8 * var_1;
      break;
    case "_encstr_8B9A0CD8F65B98581DBE86AE738E":
      self.threatsightdistmin = 64 * var_2;
      self.threatsightdistmax = 128 * var_2;
      self.threatsightratemin = 2.5 * var_1;
      self.threatsightratemax = 2.0 * var_1;
      break;
    default:
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 1 * var_1;
      self.threatsightratemax = 0.4 * var_1;
      break;
  }
}

propaddtolocation() {
  if(!isDefined(level.stealth.corpses))
    return [];

  foreach(var_2, var_1 in level.stealth.corpses) {
    if(!isDefined(level.stealth.corpses[var_2]))
      level.stealth.corpses[var_2] = undefined;
  }

  return level.stealth.corpses;
}

_id_11CD7(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;

  if(isDefined(self.stealth.override_damage_auto_range))
    var_0 = self.stealth.override_damage_auto_range;
  else if(isDefined(level.stealth.override_damage_auto_range))
    var_0 = level.stealth.override_damage_auto_range;

  if(isDefined(self.stealth.override_damage_sight_range))
    var_1 = self.stealth.override_damage_sight_range;
  else if(isDefined(level.stealth.override_damage_sight_range))
    var_1 = level.stealth.override_damage_sight_range;

  self waittill("_encstr_AD75063D571AE108");
  var_4 = self getcorpseentity();

  if(isDefined(var_4))
    level.stealth.corpses[var_4 getentitynumber()] = var_4;

  if(!isDefined(self.lastattacker)) {
    return;
  }
  var_2 = self.lastattacker;

  if(!isPlayer(var_2) && (!isDefined(var_2.owner) || !isPlayer(var_2.owner))) {
    return;
  }
  if(isDefined(var_2.owner))
    var_2 = var_2.owner;

  if(!isDefined(var_2.team) || var_2.team == var_3) {
    return;
  }
  scripts\stealth\event::event_broadcast_axis("_encstr_B81D0CB08D63977DB65AB18D5932", "_encstr_9B0115477948C121E82BF3B39F7858D36C1B38097EE9CB", var_2, var_0, var_1);
}

_id_119DB() {
  var_0 = 2;
  var_1 = 200;
  var_2 = 10;
  var_3 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var_4 = self getapproxeyepos();
  var_5 = anglesToForward(self.angles);

  foreach(var_7 in level.players) {
    var_8 = 1.1;
    var_9 = 512;
    var_10 = 3000;
    var_11 = 0.6;
    var_12 = undefined;
    var_13 = undefined;
    var_14 = undefined;

    if(var_7 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var_12 = var_7.vehicle;
      var_13 = var_7.origin;
      var_14 = var_7 getEye();
    } else {
      var_12 = scripts\cp\coop_stealth::quickdropnewitem(var_7);

      if(isDefined(var_12)) {
        var_13 = var_12.origin;
        var_14 = var_12.origin;
        var_9 = 256;
        var_8 = 2;
        var_10 = 2000;
      }
    }

    if(isDefined(var_12)) {
      var_15 = var_13 - self.origin;

      if(abs(var_15[2]) > var_9) {
        continue;
      }
      var_16 = length(var_15);

      if(var_16 > self.threatsightdistmax)
        var_17 = self.threatsightratemax;
      else if(var_16 < self.threatsightdistmin)
        var_17 = self.threatsightratemin;
      else {
        var_18 = (var_16 - self.threatsightdistmin) / (self.threatsightdistmax - self.threatsightdistmin);
        var_17 = var_18 * (self.threatsightratemax - self.threatsightratemin) + self.threatsightratemin;
      }

      var_19 = self cansee(var_7);
      var_20 = var_19;

      if(!var_20 && var_16 < var_10)
        var_20 = scripts\engine\trace::ray_trace_passed(var_4, var_14, [self, var_7, var_12], var_3);

      if(!var_20) {
        continue;
      }
      if(var_19)
        var_17 = var_17 * (var_8 - 1);
      else {
        var_17 = var_17 * var_8;
        var_15 = vectorNormalize(var_13 - self.origin);

        if(vectordot(var_15, var_5) < self.fovcosine)
          var_17 = var_17 * var_11;
      }

      var_21 = length(var_12 vehicle_getvelocity());

      if(var_21 > var_2) {
        if(var_21 > var_1)
          var_17 = var_17 * var_0;
        else
          var_17 = var_17 * (var_0 * (var_21 - var_2) / (var_1 - var_2));
      }

      var_22 = self getthreatsight(var_7);
      var_23 = var_22 + var_17 * level.frameduration / 1000;
      var_23 = min(var_23, 1);
      self setthreatsight(var_7, var_23);
    }
  }
}

_id_123CC(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!self isnearanyplayer(1024)) {
    return;
  }
  if(isDefined(var_3))
    wait(var_3);

  var_6 = undefined;

  switch (var_2) {
    case "_encstr_BA560BB0B1594EA34E59CD5647":
      var_6 = scripts\cp\coop_stealth::prematchmusic();
      break;
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      var_6 = scripts\cp\coop_stealth::puddle_structs();
      break;
    case "_encstr_82110B2AE8581B0B42C5D8CFB8":
      var_6 = scripts\cp\coop_stealth::propane_detonate_fiery_drips();
      break;
    case "_encstr_AA7C07466F9DA30713":
      var_6 = scripts\cp\coop_stealth::projectileimpactthermite();
      break;
    case "_encstr_B84F06CBD04CA31B":
      var_6 = scripts\cp\coop_stealth::raritycamlarge();
      break;
    case "_encstr_8E440A950FE01BB76E96BDE6":
      var_6 = scripts\cp\coop_stealth::propnumclones();
      break;
    case "_encstr_A52C0FB108673D1145651EC2A1C3BF659D":
      var_6 = scripts\cp\coop_stealth::propwaitminigamehudsetpoint();
      break;
    case "_encstr_A5490D5E05C3F8B363F3C8D83B3E43":
      var_6 = scripts\cp\coop_stealth::processassist_regularcp();
      break;
    case "_encstr_8B910E5A3351DAFEF9B0332A28B0A793":
      var_6 = scripts\cp\coop_stealth::ray_trace_trigger_radius_2d();
      break;
    case "_encstr_92FD082A30066B713094":
      var_6 = scripts\cp\coop_stealth::propwatchcleanupondisconnect();
      break;
    case "_encstr_928E112F37025EA89FEB168B577948992A9B93":
      var_6 = scripts\cp\coop_stealth::propwatchcleanuponroundend();
      break;
    case "_encstr_B81D0CB08D63977DB65AB18D5932":
      var_6 = scripts\cp\coop_stealth::pressure_timeout();
      break;
    case "_encstr_83650AB19BA26B100D3CE35A":
      var_6 = scripts\cp\coop_stealth::race_set_player_safe();
      break;
    case "_encstr_8C8E09632740B3834849C2":
      var_6 = scripts\cp\coop_stealth::propsizetext();
      break;
    case "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C":
      var_6 = scripts\cp\coop_stealth::propspawnorigin();
      break;
    case "_encstr_AC2C0C3ACA85B6B4DC17D5B44EE5":
      var_6 = scripts\cp\coop_stealth::recent_spawn_threshold();
      break;
    case "_encstr_85030B637B9B1DBE9BA5B33447":
      var_6 = scripts\cp\coop_stealth::put_passenger_in_truck();
      break;
    case "_encstr_8B0A0BCCA54EE6A3EBB17B9B47":
      var_6 = scripts\cp\coop_stealth::proximity_explode();
      break;
  }

  if(isDefined(var_6))
    level thread scripts\cp\coop_stealth::play_enemy_radio_chat(var_6, self);
}