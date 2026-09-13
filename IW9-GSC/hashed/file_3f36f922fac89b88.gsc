/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3f36f922fac89b88.gsc
***********************************************/

_id_D3E28724DF898EDF() {
  level thread _id_94F6A7A616983A99();
  level thread _id_9B4E08F8DE0B4636();
  level thread _id_971BE1A4E2A8013B();
}

_id_94F6A7A616983A99() {
  if(isDefined(level._id_D0ADA23E81337306) && scripts\engine\utility::array_contains(level._id_D0ADA23E81337306, "a")) {
    _id_41F1D2B91C165DB8::_id_31B15538260E6EB2("a");
    return;
  }

  if(istrue(level._id_C60247DAEC61ED67)) {
    return;
  }
  level._id_C60247DAEC61ED67 = 1;
  level thread _id_05A27D14F171D343("a");
  level thread _id_51023E7DB5068D92::_id_1B883233216DE750();
  level thread scripts\cp\cp_snakecam::enable_snake_cams();
  _id_51023E7DB5068D92::_id_0BE65C33F980FE0B();
  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_exterior", "stealth_container");
  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_exterior_patrol", "stealth_container");
  level thread _id_3E993095709797BD();
  level thread _id_5D96D5ED2C4E7AA9();
  level thread _id_B1D0E7C28EA91BC7();
}

_id_5D96D5ED2C4E7AA9() {
  level endon("obj_a_interior_spawned");
  wait 1;

  for(;;) {
    level waittill("door_event", origin, _id_EEE718E33217DC9E);
    objname = "stealth_a";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(scripts\engine\utility::distance_2d_squared(origin, getEnt("interior_ai_spawn_trigger_objA", "targetname").origin) <= 90000) {
      if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_shotgun", "stealth_container");
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_shotgun", "stealth_container");
      } else {
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_smg", "stealth_container");
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_smg", "stealth_container");
      }

      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_upstairs_ambush", "stealth_container");
      level._id_8332A0D90935D5E8[objname] = 1;
      level notify("kill_upstairs_thread");
      level notify("obj_a_interior_spawned");
    }
  }
}

_id_3E993095709797BD() {
  level endon("obj_a_interior_spawned");
  _id_780678E81FE0812B = getEnt("interior_ai_spawn_trigger_objA", "targetname");

  for(;;) {
    _id_780678E81FE0812B waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_a";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_shotgun", "stealth_container");
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_shotgun", "stealth_container");
    } else {
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_smg", "stealth_container");
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_smg", "stealth_container");
    }

    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_upstairs_ambush", "stealth_container");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_upstairs_thread");
    level notify("obj_a_interior_spawned");
    break;
  }
}

_id_B1D0E7C28EA91BC7() {
  _id_D6BD3E7E1ABC7488 = getEntArray("interior_ai_spawn_trigger_upstairs_objA", "targetname");

  foreach(trigger in _id_D6BD3E7E1ABC7488)
  trigger thread _id_22FEDCD8701E4DD7();
}

_id_22FEDCD8701E4DD7() {
  level endon("kill_upstairs_thread");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_a";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_shotgun", "stealth_container");
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_shotgun", "stealth_container");
    } else {
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_smg", "stealth_container");
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_interior_upstairs_smg", "stealth_container");
    }

    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_a_upstairs_ambush", "stealth_container");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("obj_a_interior_spawned");
    level notify("kill_upstairs_thread");
    break;
  }
}

_id_9B4E08F8DE0B4636() {
  if(isDefined(level._id_D0ADA23E81337306) && scripts\engine\utility::array_contains(level._id_D0ADA23E81337306, "b")) {
    foreach(trigger in getEntArray("nvg_lasers", "targetname"))
    trigger notify("cleanup_target_nvg");

    _id_41F1D2B91C165DB8::_id_31B15538260E6EB2("b");
    return;
  }

  if(istrue(level._id_B681A67C472F3E22)) {
    return;
  }
  level._id_B681A67C472F3E22 = 1;
  level thread _id_05A27D14F171D343("b");
  _id_51023E7DB5068D92::spawn_claymore_group("obj_b_claymores");
  level thread _id_51023E7DB5068D92::_id_1B883233216DE750();
  thread scripts\cp\cp_snakecam::enable_snake_cams();

  if(getdvarint("dvar_F94319AFACA59ED6", 0) == 0)
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_sniper", "stealth_container");

  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_exterior", "stealth_container");
  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_exterior_patrol", "stealth_container");
  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_exterior_roof", "stealth_container");
  level._id_8332A0D90935D5E8["stealth_b"] = 1;
  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_smg", "stealth_container");
  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_2_smg", "stealth_container");
  _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_ambush_smg", "stealth_container");
}

_id_5D96D2ED2C4E7410() {
  level endon("obj_b_interior_spawned");

  for(;;) {
    level waittill("door_event", origin, _id_EEE718E33217DC9E);
    objname = "stealth_b";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(scripts\engine\utility::distance_2d_squared(origin, getEnt("interior_ai_spawn_trigger_objB", "targetname").origin) <= 90000) {
      if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_shotgun", "stealth_container");
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_ambush_shotgun", "stealth_container");
      } else {
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_smg", "stealth_container");
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_2_smg", "stealth_container");
        _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_ambush_smg", "stealth_container");
      }

      level._id_8332A0D90935D5E8[objname] = 1;
      level notify("kill_objb_spawner_thread");
      level notify("obj_b_interior_spawned");
    }
  }
}

_id_3E992D9570979124() {
  level notify("kill_objb_spawner_thread");
  level endon("kill_objb_spawner_thread");
  _id_780678E81FE0812B = getEnt("interior_ai_spawn_trigger_objB", "targetname");

  for(;;) {
    _id_780678E81FE0812B waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_b";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    if(getdvarint("dvar_AA53922F2189291A", 0) != 0) {
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_shotgun", "stealth_container");
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_ambush_shotgun", "stealth_container");
    } else {
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_smg", "stealth_container");
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_interior_2_smg", "stealth_container");
      _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_b_ambush_smg", "stealth_container");
    }

    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_objb_spawner_thread");
    break;
  }
}

_id_971BE1A4E2A8013B() {
  if(isDefined(level._id_D0ADA23E81337306) && scripts\engine\utility::array_contains(level._id_D0ADA23E81337306, "c")) {
    _id_41F1D2B91C165DB8::_id_31B15538260E6EB2("c");
    return;
  }

  if(istrue(level._id_C58764B80FED93A9)) {
    return;
  }
  level._id_C58764B80FED93A9 = 1;
  _id_51023E7DB5068D92::spawn_claymore_group("obj_c_claymores");
  level thread _id_05A27D14F171D343("c");
  level thread _id_51023E7DB5068D92::_id_1B883233216DE750();
  level thread scripts\cp\cp_snakecam::enable_snake_cams();
  level thread _id_51023E7DB5068D92::_id_AD620C1E7115446B();

  if(getdvarint("dvar_99BB5C2C4F003E2B", 0) == 0) {
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_exterior", "stealth_container");
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_exterior_patrol", "stealth_container");
  }

  level thread _id_B1D0E9C28EA9202D();
}

_id_B1D0E9C28EA9202D() {
  _id_D6BD3E7E1ABC7488 = getEntArray("interior_ai_spawn_trigger_objC", "targetname");

  foreach(trigger in _id_D6BD3E7E1ABC7488)
  trigger thread _id_50C7F174DAE1AEEA();
}

_id_50C7F174DAE1AEEA() {
  level endon("kill_objC_spawner_thread");

  for(;;) {
    self waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    objname = "stealth_c";

    if(istrue(level._id_8332A0D90935D5E8[objname])) {
      return;
    }
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_interior", "stealth_container");
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_interior_upstairs", "stealth_container");
    _id_742F61B6768A1AAB::_id_7C36558FF1376EA2("spawner_obj_c_upstairs_ambush", "stealth_container");
    level._id_8332A0D90935D5E8[objname] = 1;
    level notify("kill_objC_spawner_thread");
    break;
  }
}

_id_6FA1D65707713DF4() {
  if(istrue(level._id_6955C64B23118DB4)) {
    return;
  }
  level._id_6955C64B23118DB4 = 1;
}

_id_05A27D14F171D343(obj) {
  if(1) {
    return;
  }
  if(_id_742F61B6768A1AAB::_id_D70F981E9EBE2A90() < 2) {
    return;
  }
  spawner = scripts\engine\utility::getStruct("vehicle_techo_patroller_" + obj, "targetname");
  spawner._id_79FA6BD3C9BF6A0D = 1;
  _id_CBD652D85EF24B68 = getEnt("vehicle_spawn_trigger_" + obj, "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
}

_id_1D0378AEFD2D7FA5() {
  level endon("game_ended");
  createthreatbiasgroup("escort_helicopter");
  setthreatbias("axis", "escort_helicopter", 999999);
  setthreatbias("axis", "player1", 1);
  setthreatbias("axis", "player2", 1);
  setthreatbias("axis", "player3", 1);
  setthreatbias("axis", "player4", 1);
  _id_CBD652D85EF24B68 = getEnt("exfil_vehicle_spawn_trigger_apache", "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  scripts\engine\utility::flag_wait("spawn_and_send_escort_chopper");
  spawn_point = scripts\engine\utility::getStruct("escort_heli_spawn", "targetname");
  _id_70B0ED47E23397C0 = scripts\engine\utility::getStruct("escort_heli_path_start", "targetname");
  spawn_point.classname_mp = "script_vehicle_apache_east";
  spawn_point.script_modelname = "veh9_mil_air_ahotel64_ks_mp";
  spawn_point.vehicletype = "veh_apache_cp";
  heli = scripts\common\vehicle::vehicle_spawn(spawn_point);
  heli.death_fx_on_self = 1;
  heli.circle_radius = 2500;
  heli scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret");
  heli.isheli = 1;
  heli.health = 50000;
  heli.maxhealth = 50000;
  heli.team = "allies";
  heli setvehicleteam("allies");
  heli setmaxpitchroll(15, 15);
  heli.health_remaining = 2250;
  heli sethoverparams(25, 15, 10);
  heli setCanDamage(0);
  heli.rockets_ready = 1;
  heli.has_rockets = 1;
  heli.target_ent = scripts\engine\utility::spawn_tag_origin();
  heli thread _id_EFCD466CD5D7B4A2();
  heli _id_26E836994FBF2299("allies");
  heli setscriptablepartstate("blinking_lights", "on");
  heli.exfil_struct = _id_70B0ED47E23397C0;
  heli.headicon = createheadicon(heli);
  heli setvehiclelookattext(undefined, &"CP_BAD_SITUATION_OBJ/EXFIL_HELI_CALLSIGN");
  level notify("exfil_apache_spawned");
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);

  if(!isDefined(heli.exfil_struct.angles))
    heli.exfil_struct.angles = (0, 0, 0);

  heli.going_to_exfil = 1;
  heli vehicle_setspeed(60, 30);
  heli sethoverparams(60, 10, 10);
  heli setyawspeed(100, 100, 100, 0.1);
  heli setturningability(1);
  heli setneargoalnotifydist(50);
  heli.streakname = "gunship";
  heli.vehiclename = "gunship";
  heli thread _id_8AADCD01B4EDC6EB(heli);
  thread _id_23A49CE6577AEEC5(heli);
  level._id_AE22D3BE096B121A = heli;
  level waittill("escort_heli_delete_heli");
  heli.minigun makeunusable();
  heli.minigun maketurretinoperable();

  if(isDefined(heli.vip))
    heli.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();

  if(isDefined(heli.minigun))
    heli.minigun delete();

  heli thread _id_34448E15CE014185();
  deleteheadicon(heli.headicon);
  heli delete();
}

_id_34448E15CE014185() {
  self endon("death");

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(isDefined(attacker) && isPlayer(attacker)) {
      if(scripts\engine\utility::cointoss())
        _id_5D265B4FCA61F070::say("dx_cbc_usm1_generic_friendlyfire", undefined, undefined, undefined, undefined, "global");
    }
  }
}

_id_EFCD466CD5D7B4A2() {
  tag = "tag_light_belly";
  self.spotlight = spawnturret("misc_turret", self gettagorigin(tag), "fighter_spotlight");
  self.spotlight.angles = self gettagangles(tag);
  self.spotlight setModel("veh9_mil_air_heli_blima_spotlight");
  self.spotlight linkTo(self, tag, (-25, 15, -21), (180, 180, 0));
  self.spotlight makeunusable();
  self.spotlight setmode("manual");
  self.spotlight setturretteam("allies");
  self.spotlight setdefaultdroppitch(0);
  self.spotlight setleftarc(180);
  self.spotlight setrightarc(180);
  self.spotlight settoparc(180);
  self.spotlight setbottomarc(180);
  self.spotlight setconvergencetime(0.05, "yaw");
  self.spotlight setconvergencetime(0.05, "pitch");
  self.spotlight.target_ent = scripts\engine\utility::spawn_tag_origin();
  self.spotlight settargetentity(self.spotlight.target_ent);
  wait 1;
  playFXOnTag(level._effect["spotlight"], self.spotlight, "tag_flash");
}

_id_26E836994FBF2299(team) {
  scripts\cp\utility::make_entity_sentient_cp(team, 0);
  self setthreatbiasgroup("escort_helicopter");
}

_id_8AADCD01B4EDC6EB(heli) {
  heli endon("death");
  heli endon("clear_attack_threads");
  heli._id_0E43C4924A62CDA7 = scripts\engine\utility::getStruct("attack_position_1", "targetname");
  heli setvehgoalpos(heli._id_0E43C4924A62CDA7.origin + (0, 0, 300), 0);
  heli sethoverparams(60, 10, 10);
  heli vehicle_setspeed(30, 15);
  current_struct = heli._id_0E43C4924A62CDA7;

  for(;;) {
    if(isDefined(current_struct))
      heli setvehgoalpos(current_struct.origin + (0, 0, 300), 0);
    else
      return;

    heli waittill("goal");

    if(!istrue(heli._id_8DB2B691349C4892))
      heli._id_8DB2B691349C4892 = 1;

    current_struct = scripts\engine\utility::getStruct(current_struct.target, "targetname");
    heli sethoverparams(60, 10, 10);
    heli vehicle_setspeed(30, 15);
  }
}

_id_A55CAC62F5E2873E(timeout) {
  level endon("game_ended");
  wait(timeout);
  scripts\engine\utility::flag_set("hover_lz");
}

_id_B65CD53D323B85E1(heli) {
  heli endon("death");
  heli setvehgoalpos(heli.exfil_struct.origin + (0, 0, 333), 0);
  current_struct = heli.exfil_struct;

  for(;;) {
    if(isDefined(current_struct))
      heli setvehgoalpos(current_struct.origin + (0, 0, 333), 0);
    else
      return;

    heli waittill("goal");
    current_struct = scripts\engine\utility::getStruct(current_struct.target, "targetname");
    heli vehicle_setspeed(15, 10);
  }
}

_id_23A49CE6577AEEC5(heli) {
  _id_CBD652D85EF24B68 = getEnt("exfil_vehicle_spawn_trigger_apache_attack", "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  heli.minigun setturretteam("allies");
  heli.minigun setmode("manual");
  nextfiretime = gettime();
  _id_D1CCB3CF97AD85F5 = 0;
  _id_24F98AF94D03218A = [];

  for(;;) {
    if(!istrue(heli._id_8DB2B691349C4892)) {
      waitframe();
      continue;
    }

    _id_EC80496532425417 = heli _id_B3004C061FC41F6B(heli.exfil_struct.origin + (0, 0, -150), 25000000);

    if(isDefined(level._id_24A25C6BE881BE0C) && level._id_24A25C6BE881BE0C.size <= 2) {
      _id_EC80496532425417 = heli get_nearby_enemy(heli.exfil_struct.origin + (0, 0, -150), 25000000);
      scripts\engine\utility::flag_set("hover_lz");
    }

    if(!isDefined(_id_EC80496532425417) && (isDefined(level._id_24A25C6BE881BE0C) && level._id_24A25C6BE881BE0C.size > 0))
      _id_EC80496532425417 = heli get_nearby_enemy(heli.exfil_struct.origin + (0, 0, -150), 25000000);

    if(!isDefined(_id_EC80496532425417)) {
      heli.minigun cleartargetentity();
      heli.spotlight cleartargetentity();
      heli clearlookatent();
      waitframe();
      _id_D1CCB3CF97AD85F5++;

      if(_id_D1CCB3CF97AD85F5 >= 5)
        _id_D1CCB3CF97AD85F5 = 0;

      continue;
    } else {
      if(isDefined(level._id_24A25C6BE881BE0C) && level._id_24A25C6BE881BE0C.size > 0) {
        level._id_24A25C6BE881BE0C = scripts\engine\utility::array_removeundefined(level._id_24A25C6BE881BE0C);
        _id_24F98AF94D03218A = scripts\engine\utility::array_combine(level._id_24A25C6BE881BE0C, scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"));
        thread _id_7F3EC2451A1B9748(_id_EC80496532425417, heli, nextfiretime);
        heli _id_2F8ACDF27E569EFE([_id_EC80496532425417], 2);
        thread _id_7E1A468DA43087E3::_id_5EDC9105AB852308();
        continue;
      }

      thread _id_7F3EC2451A1B9748(_id_EC80496532425417, heli, nextfiretime);
      heli _id_2F8ACDF27E569EFE([_id_EC80496532425417], 2);
      thread _id_7E1A468DA43087E3::_id_5EDC9105AB852308();
    }
  }
}

_id_7F3EC2451A1B9748(_id_EC80496532425417, heli, nextfiretime) {
  _id_D1CCB3CF97AD85F5 = 0;
  _id_119D71E3F7006F18 = _id_EC80496532425417.origin + (0, 0, 1100);
  heli.minigun settargetentity(_id_EC80496532425417);
  heli.spotlight settargetentity(_id_EC80496532425417);
  heli setlookatent(_id_EC80496532425417);

  for(;;) {
    msg = heli.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 3.0);

    if(msg == "timeout") {
      heli.minigun cleartargetentity();
      heli.spotlight cleartargetentity();
      heli notify("unleash_the rockets");
      return;
    } else if(gettime() > nextfiretime) {
      heli notify("unleash_the rockets");

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 15; _id_AC0E594AC96AA3A8++) {
        heli.minigun shootturret();
        wait(randomfloatrange(0.1, 0.3));
      }

      nextfiretime = gettime() + randomintrange(500, 750);
    }
  }
}

_id_CB9D61ACA5ACB46E(heli) {
  heli endon("death");
  _id_CBD652D85EF24B68 = getEnt("exfil_vehicle_spawn_trigger_apache_attack", "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  heli.minigun setturretteam("allies");
  heli.minigun setmode("manual");
  nextfiretime = gettime();
  _id_D1CCB3CF97AD85F5 = 0;

  for(;;) {
    if(!istrue(heli._id_8DB2B691349C4892)) {
      waitframe();
      continue;
    }

    _id_EC80496532425417 = heli _id_B3004C061FC41F6B(heli.exfil_struct.origin + (0, 0, -150), 25000000);

    if(!isDefined(_id_EC80496532425417)) {
      scripts\engine\utility::flag_set("hover_lz");
      _id_EC80496532425417 = heli get_nearby_enemy(heli.exfil_struct.origin + (0, 0, -150), 25000000);
    }

    if(!isDefined(_id_EC80496532425417)) {
      heli.minigun cleartargetentity();
      heli.spotlight cleartargetentity();
      heli clearlookatent();
      waitframe();
      _id_D1CCB3CF97AD85F5++;

      if(_id_D1CCB3CF97AD85F5 >= 5)
        _id_D1CCB3CF97AD85F5 = 0;

      continue;
    }

    _id_D1CCB3CF97AD85F5 = 0;
    _id_119D71E3F7006F18 = _id_EC80496532425417.origin + (0, 0, 1100);
    heli.minigun settargetentity(_id_EC80496532425417);
    heli.spotlight settargetentity(_id_EC80496532425417);
    heli setlookatent(_id_EC80496532425417);
    msg = heli.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 0.05);

    if(msg == "timeout") {
      heli.minigun cleartargetentity();
      heli.spotlight cleartargetentity();
      heli clearlookatent();
      continue;
    } else if(gettime() > nextfiretime) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 15; _id_AC0E594AC96AA3A8++) {
        heli.minigun shootturret();
        wait 0.1;
      }

      nextfiretime = gettime() + 500;
    }
  }
}

_id_2F8ACDF27E569EFE(targets, _id_AE4236AF36E273DC) {
  self endon("death");
  self waittill("unleash_the rockets");

  if(isDefined(_id_AE4236AF36E273DC))
    wait(_id_AE4236AF36E273DC);

  self.target_ent unlink();
  _id_C2E32AE249AA7753 = [];

  if(!isarray(targets))
    _id_C2E32AE249AA7753[_id_C2E32AE249AA7753.size] = targets;
  else
    _id_C2E32AE249AA7753 = targets;

  tag = "tag_gun_l";
  rocket = undefined;
  _id_6D259FBB6C14C5D9 = [];
  _id_A542D4FB1B75F71B = spawnStruct();
  _id_A542D4FB1B75F71B.count = 0;

  foreach(_id_AC0E594AC96AA3A8, target in _id_C2E32AE249AA7753) {
    if(!isDefined(target)) {
      continue;
    }
    if(istrue(self.abort)) {
      return;
    }
    end = undefined;
    temp = scripts\engine\utility::spawn_tag_origin();

    if(isvector(target))
      temp.origin = target;
    else
      temp.origin = target.origin;

    waitframe();

    if(!isDefined(target)) {
      continue;
    }
    if(!isDefined(temp.origin)) {
      continue;
    }
    _id_BB2614156DD72ED0 = 0;
    _id_CF6B8D2D0EF1ACAF = scripts\engine\utility::getclosest(temp.origin, level.players);

    if(distancesquared(_id_CF6B8D2D0EF1ACAF.origin, temp.origin) < 160000)
      _id_BB2614156DD72ED0 = 1;

    allies = undefined;

    if(!_id_BB2614156DD72ED0)
      allies = getaiarrayinradius(temp.origin, 400, "allies");

    if(isDefined(allies) && allies.size || istrue(self.abort))
      _id_BB2614156DD72ED0 = 1;

    if(_id_BB2614156DD72ED0) {
      temp delete();
      continue;
    }

    angles = vectortoangles(scripts\engine\utility::flat_origin(temp.origin) - scripts\engine\utility::flat_origin(self.origin));

    if(!scripts\engine\utility::within_fov(scripts\engine\utility::flat_origin(self.origin), self.angles, scripts\engine\utility::flat_origin(temp.origin), -0.173648)) {
      if(isai(target) || target _id_7E1A468DA43087E3::_id_5151C9A51BB8C91E()) {
        self setlookatent(target);
        self.minigun settargetentity(target);
        self.spotlight settargetentity(target);
      } else {
        self setlookatent(temp);
        self.minigun settargetentity(temp);
        self.spotlight settargetentity(temp);
      }

      waitframe();

      while(!scripts\engine\utility::within_fov(scripts\engine\utility::flat_origin(self.origin), self.angles, scripts\engine\utility::flat_origin(temp.origin), -0.173648))
        waitframe();

      self clearlookatent();
    }

    if(!isDefined(temp)) {
      continue;
    }
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 6; _id_AC0E5C4AC96AAA41++) {
      speed = self vehicle_getspeed();
      offset = speed * 10;
      start = self gettagorigin(tag) + anglesToForward(self.angles) * offset;
      start = start - (0, 0, 69);

      if(isDefined(temp)) {
        rocket = magicbullet("iw9_la_rpapa7_mp", start, temp.origin);
        _id_A542D4FB1B75F71B.count++;
        _id_8AE0BDBDA627F4A2 = temp.origin;
        thread _id_B13A02EF89620AD1(rocket);
        rocket thread scripts\engine\utility::delete_on_death(temp);
        rocket thread _id_61C953B094954548(target, _id_A542D4FB1B75F71B);
        _id_6D259FBB6C14C5D9[_id_6D259FBB6C14C5D9.size] = rocket;
      }

      wait(randomfloatrange(0.1, 0.3));
    }

    tag = scripts\engine\utility::ter_op(tag == "tag_gun_l", "tag_gun_r", "tag_gun_l");

    if(_id_AC0E594AC96AA3A8 == _id_C2E32AE249AA7753.size - 1) {
      break;
    }

    wait 0.35;
  }

  start = gettime();

  for(;;) {
    if(_id_A542D4FB1B75F71B.count == 0) {
      return;
    }
    if(gettime() - start > 5000) {
      break;
    }

    waitframe();
  }
}

_id_B13A02EF89620AD1(rocket) {
  _id_4CF58793CC4F1AD6 = spawn("script_origin", rocket.origin);
  _id_4CF58793CC4F1AD6 linkTo(rocket);
  _id_4CF58793CC4F1AD6 playLoopSound("missile_incoming");
  rocket waittill("death");
  _id_4CF58793CC4F1AD6 stopsounds();
  wait 0.1;
  _id_4CF58793CC4F1AD6 delete();
}

_id_61C953B094954548(target, _id_92DB85C8DCF21152) {
  self waittill("death");
  _id_92DB85C8DCF21152.count--;

  if(!isDefined(self)) {
    return;
  }
  _id_183BDCC9E630D8DD = self.origin;
  earthquake(0.35, 0.45, _id_183BDCC9E630D8DD, 4000);
  _id_1B345617DD7F27D4 = scripts\engine\utility::get_array_of_closest(_id_183BDCC9E630D8DD, level.players);

  if(isDefined(_id_1B345617DD7F27D4)) {
    foreach(_id_CF6B8D2D0EF1ACAF in _id_1B345617DD7F27D4)
    _id_CF6B8D2D0EF1ACAF playRumbleOnEntity("damage_heavy");
  }

  waitframe();

  if(!isDefined(target)) {
    return;
  }
  if(!_id_7E1A468DA43087E3::_id_D6C65A66F59242A4(target) && _id_7E1A468DA43087E3::_id_F60B16BD3CA5FA28(target)) {
    if(istrue(target.magic_bullet_shield)) {
      return;
    }
    damage = undefined;

    if(isai(target))
      damage = target.health;
    else if(target _id_7E1A468DA43087E3::_id_5151C9A51BB8C91E()) {
      if(isDefined(target.healthbuffer))
        damage = target.health - target.healthbuffer + 1;
      else
        damage = target.health + 1;
    }

    target dodamage(damage, target.origin, level._id_AE22D3BE096B121A, undefined, "MOD_EXPLOSIVE", "iw8_la_rpapa7_mp_friendly");
  }
}

heli_cleanup_exfil_area(heli) {
  heli endon("death");
  level notify("starting_cleanup");
  heli.minigun setturretteam("allies");
  heli.minigun setmode("manual");
  nextfiretime = gettime();
  _id_D1CCB3CF97AD85F5 = 0;
  level scripts\engine\utility::waittill_any_timeout_1(69, "attack_vehicles_now");

  for(;;) {
    while(!isDefined(heli.exfil_struct))
      waitframe();

    _id_EC80496532425417 = heli _id_B3004C061FC41F6B(heli.exfil_struct.origin + (0, 0, -150), 25000000);

    if(!isDefined(_id_EC80496532425417))
      _id_EC80496532425417 = heli get_nearby_enemy(heli.exfil_struct.origin + (0, 0, -150), 25000000);

    if(!isDefined(_id_EC80496532425417)) {
      heli.minigun cleartargetentity();
      waitframe();
      _id_D1CCB3CF97AD85F5++;

      if(_id_D1CCB3CF97AD85F5 >= 5)
        _id_D1CCB3CF97AD85F5 = 0;

      continue;
    }

    _id_D1CCB3CF97AD85F5 = 0;
    _id_119D71E3F7006F18 = _id_EC80496532425417.origin + (0, 0, 1100);
    heli.minigun settargetentity(_id_EC80496532425417);

    if(distance(_id_119D71E3F7006F18, heli.origin) > 1500)
      heli setvehgoalpos(_id_119D71E3F7006F18, 1);

    msg = heli.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 0.05);

    if(msg == "timeout") {
      heli.minigun cleartargetentity();
      continue;
    } else if(gettime() > nextfiretime) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 35; _id_AC0E594AC96AA3A8++) {
        heli.minigun shootturret();
        wait 0.1;
      }

      nextfiretime = gettime() + 500;
    }
  }
}

heli_go_to_exfil_point() {
  self endon("death");
  _id_9927B201A8510982 = scripts\engine\utility::getStruct("payload_apache_exfil_point", "script_noteworthy");
  heli = self;
  heli vehicle_setspeed(90, 30);
  heli setvehgoalpos(_id_9927B201A8510982.origin, 1);
}

get_nearby_enemy(org, _id_465A06BAE1ABB77E) {
  self endon("death");

  if(!isDefined(_id_465A06BAE1ABB77E))
    _id_465A06BAE1ABB77E = 25000000;

  guys = getaiarray("axis");

  if(!isDefined(guys))
    return undefined;

  guys = sortbydistance(guys, self.origin);

  foreach(guy in guys) {
    if(!isalive(guy)) {
      continue;
    }
    if(distancesquared(guy.origin, org) < _id_465A06BAE1ABB77E && scripts\engine\trace::ray_trace_passed(self.spotlight.origin, guy.origin + (0, 0, 100), guys))
      return guy;
  }

  return undefined;
}

_id_B3004C061FC41F6B(org, _id_465A06BAE1ABB77E) {
  if(!isDefined(_id_465A06BAE1ABB77E))
    _id_465A06BAE1ABB77E = 25000000;

  if(!isDefined(level._id_24A25C6BE881BE0C))
    return undefined;

  level._id_24A25C6BE881BE0C = scripts\engine\utility::array_removeundefined(level._id_24A25C6BE881BE0C);
  guys = level._id_24A25C6BE881BE0C;

  if(guys.size == 0)
    return undefined;

  guys = sortbydistance(guys, self.origin);

  foreach(guy in guys) {
    if(guy.health <= 0) {
      continue;
    }
    if(distancesquared(guy.origin, org) < _id_465A06BAE1ABB77E && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), guy.origin + (0, 0, 100), guys))
      return guy;
  }

  return undefined;
}

_id_8E50DE6FC790C82C(waittime) {
  level endon("game_ended");
  self endon("death");
  self endon("player_entered_enemy_vehicle");
  wait(waittime);
  self dodamage(self.health * 2, (0, 0, 0));
}

domassairetreat(time) {
  level endon("game_ended");
  wait(time);
  _id_DFAFAFF2E24D36FA = scripts\engine\utility::getStruct("morales_ai_mass_escape", "targetname");
  _id_FC9AC45209F959BB = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(enemy in _id_FC9AC45209F959BB)
  enemy thread retreatanddie(_id_DFAFAFF2E24D36FA.origin);
}

retreatanddie(origin) {
  level endon("game_ended");
  self endon("death");
  self notify("received_retreat_order");
  self.ignoreall = 1;
  self.goalradius = 64;
  self setgoalpos(origin);
  scripts\engine\utility::waittill_notify_or_timeout("goal", 40);
  self dodamage(self.health + 100, self.origin);
}

watchforhelideletion(heli) {
  level endon("game_ended");
  heli endon("death");
  _id_0448FF3DBF1B03D7 = 0;
  _id_20E8A95A4CA4DF2E = 10000;

  while(!istrue(_id_0448FF3DBF1B03D7)) {
    _id_0448FF3DBF1B03D7 = 1;

    foreach(player in level.players) {
      if(distance(player.origin, heli.origin) <= _id_20E8A95A4CA4DF2E)
        _id_0448FF3DBF1B03D7 = 0;
    }

    wait 3;
  }

  level notify("escort_heli_delete_heli");
}

_id_35954B3FB5848A5F(_id_F940C1E878A94160, _id_8AE031EB8918B630) {
  _id_F940C1E878A94160 = int(clamp(_id_F940C1E878A94160, 1, 5));
  spawner = scripts\engine\utility::getStruct("exfil_vehicle_" + _id_F940C1E878A94160, "targetname");
  spawner._id_79FA6BD3C9BF6A0D = 1;
  _id_CBD652D85EF24B68 = getEnt("exfil_vehicle_spawn_trigger_" + _id_F940C1E878A94160, "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  if(isDefined(_id_8AE031EB8918B630))
    wait(_id_8AE031EB8918B630);

  thread scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawner);
}

_id_DEF7A7EC079353A0(spawner) {
  while(!istrue(_id_0F859274A76341A7(spawner)))
    waitframe();
}

_id_0F859274A76341A7(spawner) {
  foreach(player in level.players) {
    if(distance2dsquared(player.origin, spawner.origin) < 4194304)
      return 0;

    if(player worldpointinreticle_circle(spawner.origin, 80, 100))
      return 0;

    if(scripts\engine\utility::within_fov(player getEye(), player getplayerangles(), spawner.origin, 80))
      return 0;
  }

  return 1;
}

_id_006C76A176F13D9B(targetname) {
  _id_0B5742ADAF0EB632 = scripts\engine\utility::getStructArray(targetname, "targetname");

  foreach(spawner in _id_0B5742ADAF0EB632) {}
}

_id_611022CAB305A8F5(trigger) {
  trigger notify("waittill_players_trigger_exfil_vehicle");
  trigger endon("waittill_players_trigger_exfil_vehicle");

  for(;;) {
    trigger waittill("trigger", entity);

    if(!isPlayer(entity)) {
      if(isDefined(entity.owner)) {
        if(!isPlayer(entity.owner))
          continue;
      } else
        continue;
    }

    break;
  }
}

empty() {}

_id_D7675700AAA4AA7B() {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("level_ready_for_script"))
    scripts\engine\utility::flag_init("level_ready_for_script");

  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(!isDefined(self.riders))
    self.riders = [];

  if(!isDefined(self.unloadque))
    self.unloadque = [];

  _id_28926EABDE819B0D::_id_03DD20FF8B99819A();
  scripts\common\vehicle::vehicle_lights_on("headlights", "script_vehicle_iw9_truck_techo_rebel_armor");
  self endon("death");
  self endon("stop_chasing");

  if(!isDefined(level._id_24A25C6BE881BE0C))
    level._id_24A25C6BE881BE0C = [];

  scripts\cp\cp_outofbounds::enableoobimmunity(self);
  level._id_24A25C6BE881BE0C = scripts\engine\utility::array_add(level._id_24A25C6BE881BE0C, self);
  thread _id_8E50DE6FC790C82C(300);
  thread _id_7E1A468DA43087E3::_id_E6BCE649B1F466C2();
  self _meth_D2E41C7603BA7697("p2p");
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  self _meth_77320E794D35465A("p2p", "goalThreshold", 200);
  self _meth_77320E794D35465A("p2p", "throttleSpeedClose", 1);
  self _meth_77320E794D35465A("p2p", "reverseGasNormal", 1.5);
  self _meth_77320E794D35465A("p2p", "steeringMultiplier", 4);
  self _meth_77320E794D35465A("p2p", "stuckTime", 3);
  veh_speed = 20;
  thread _id_24E4405CF93F20ED::_id_4808177C29F56FB9();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo_rebel_armor", "damageIgnoresArmor"))
    self._id_7A646FF827387AC0 = scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo_rebel_armor", "damageIgnoresArmor");

  targetname = self.vehicle_spawner.targetname;
  index = strtok(targetname, "_")[2];
  current_target = scripts\engine\utility::getStruct("vehicle_arrival_" + index, "targetname");

  if(isDefined(self.vehicle_spawner.target))
    current_target = scripts\engine\utility::getStruct(self.vehicle_spawner.target, "targetname");

  _id_CBD652D85EF24B68 = getEnt("exfil_vehicle_spawn_trigger_" + index, "targetname");

  if(isDefined(_id_CBD652D85EF24B68))
    _id_611022CAB305A8F5(_id_CBD652D85EF24B68);

  for(;;) {
    wait 0.05;

    if(!isDefined(current_target)) {
      return;
    }
    _id_CA3EE910A7A8F690 = current_target;
    _id_BC36C55F86568C40 = undefined;

    if(isDefined(_id_CA3EE910A7A8F690))
      _id_BC36C55F86568C40 = _id_CA3EE910A7A8F690.origin;
    else {
      _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

      if(!isDefined(_id_C729D49D406ACED8)) {
        wait 0.05;
        continue;
      }

      _id_BC36C55F86568C40 = _id_C729D49D406ACED8.origin;
    }

    _id_4BAC13D511590220::_id_28991B23DBA743D8(_id_BC36C55F86568C40);
    _id_4BAC13D511590220::_id_8F40A2C8678F8304(self.origin, _id_BC36C55F86568C40, veh_speed);

    if(isDefined(current_target.target))
      current_target = scripts\engine\utility::getStruct(current_target.target, "targetname");
    else {
      if(!isDefined(level._id_CAF93A91742E465E))
        level._id_CAF93A91742E465E = 1;
      else
        level._id_CAF93A91742E465E++;

      if(level._id_CAF93A91742E465E >= 4)
        level notify("attack_vehicles_now");

      _id_223B1474B6A49425();
      return;
    }

    if(_id_24E4405CF93F20ED::_id_EEE51130CC8DCE38())
      return;
  }
}

_id_1AB6B61153087915(data) {
  if(isDefined(data.attacker) && isPlayer(data.attacker))
    data.damage = 0;
  else if(isDefined(data.attacker) && isDefined(data.attacker.chopper)) {
    self._id_0A529FF2C9467326++;

    if(self._id_0A529FF2C9467326 >= 6)
      data.damage = data.damage * 100;
  } else if(isexplosivedamagemod(data.meansofdeath) && data.meansofdeath != "MOD_EXPLOSIVE_BULLET")
    data.damage = max(5, int(data.damage / 2));
  else if(data.meansofdeath == "MOD_EXPLOSIVE_BULLET")
    data.damage = max(5, int(data.damage / 3.5));
  else
    data.damage = max(5, int(data.damage / 4.5));

  _id_52616AAE7B55D981 = int(clamp((self.health - data.damage) / self.maxhealth * 100, 0, 100));
  setomnvar("ui_special_veh_health_percent", int(_id_52616AAE7B55D981));

  if(isDefined(self.owner))
    level notify("vehicledamage", self.owner);
}

_id_223B1474B6A49425() {
  self notify("path_updated");
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 1);
  self _meth_77320E794D35465A("p2p", "goalPoint", self.origin);
  self stoppath();
  self vehicle_setspeedimmediate(0, 1, 1);
  self vehicle_cleardrivingstate();
  waitframe();

  if(getdvarint("dvar_33AE62B0A8839FFA", 0) != 0) {
    return;
  }
  self.nav_obstacle = createnavobstaclebybounds(self.origin, (64, 128, 64), self.angles, "axis");
  scripts\common\vehicle_code::_vehicle_unload("default");

  if(scripts\common\vehicle_aianim::riders_unloadable("default"))
    self waittill("unloaded");

  if(isDefined(level.vehicle._id_9442D439C225C3FE)) {
    if([[level.vehicle._id_9442D439C225C3FE]](self))
      return 1;
  }
}

_id_94CA7667777996FF(start_point, end_point, speed) {}

_id_4D8A7F23888A87A0(path, speed) {
  self notify("path_updated");
  self endon("path_updated");
  self endon("kill_thread_since_spotted");

  foreach(point in path) {
    self _meth_77320E794D35465A("p2p", "goalPoint", point);
    dist = distance(self.origin, point);
    time = undefined;

    if(dist > 0)
      time = _id_0E80538EF14D00E1::get_duration_between_points(self.origin, point, speed);

    key = _func_906E53C2FB9D3F9C("p2p", "targetTime");

    if(isDefined(time))
      self _meth_77320E794D35465A(key, time);
    else
      self _meth_77320E794D35465A(key, 0.2);

    while(distancesquared(self.origin, point) > squared(300))
      waitframe();
  }
}

_id_9FE0C847F66DEF2A(obj) {
  self endon("death");
  self notify("watch_for_ai_entering_combat_while_in_vehicle" + obj);
  self endon("watch_for_ai_entering_combat_while_in_vehicle" + obj);

  for(;;) {
    level waittill("unload_spawners_for_obj", _id_B82E4EA250D08A3B);

    if(obj == _id_B82E4EA250D08A3B) {
      self notify("kill_thread_since_spotted");
      waitframe();
      _id_223B1474B6A49425();
      break;
    }
  }
}

_id_FDD3757C269F0BCA() {
  self endon("death");
  self.damage_functions = [];
  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.bullet_shield[classname]) && !isDefined(self.script_bulletshield))
    self.script_bulletshield = level.vehicle.templates.bullet_shield[classname];

  if(isDefined(level.vehicle.templates.grenade_shield[classname]) && !isDefined(self.script_grenadeshield))
    self.script_grenadeshield = level.vehicle.templates.bullet_shield[classname];

  self.healthbuffer = 20000;
  self.health = self.health + self.healthbuffer;
  currenthealth = self.health;
  self.custom_damage_handler = 1;
  self._id_0A529FF2C9467326 = 0;

  while(self.health > 0) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(isDefined(attacker) && isDefined(attacker.chopper)) {
      self._id_0A529FF2C9467326++;

      if(self._id_0A529FF2C9467326 >= 6) {
        if(isDefined(self._id_A9F96E33F612C828))
          [[self._id_A9F96E33F612C828]]();

        self notify("death", attacker, meansofdeath, objweapon, damagelocation);
      }
    }

    if(getdvarint("dvar_CFD8073837710CEF")) {}

    if(isDefined(self._id_C543F8E941150B0B)) {
      _id_81A21B295824983A = self[[self._id_C543F8E941150B0B]](partname, meansofdeath, damagelocation);

      if(isDefined(_id_81A21B295824983A)) {
        if(isDefined(self._id_2352359EF3EEFCD3))
          self thread[[self._id_2352359EF3EEFCD3]](attacker, amount, _id_81A21B295824983A, direction_vec, damagelocation);

        amount = 0;
        self.health = currenthealth;
        continue;
      }
    }

    foreach(func in self.damage_functions)
    thread[[func]](amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(isDefined(attacker)) {
      attacker scripts\engine\utility::script_func("register_shot_hit");

      if(scripts\engine\utility::func_ref_exist("vehicle_damage_modifier")) {
        data = undefined;

        if(isDefined(level.fn_damage_pack))
          data = [[level.fn_damage_pack]](attacker, self, amount, objweapon, meansofdeath, undefined, damagelocation, direction_vec, modelname, partname, tagname, _id_44E290FB31B85206);

        if(isDefined(data))
          self.damage_data = data;
        else
          self.damage_data = undefined;

        _id_98AFD1CE36F4905A = scripts\engine\utility::script_func("vehicle_damage_modifier", data);

        if(isDefined(_id_98AFD1CE36F4905A))
          amount = _id_98AFD1CE36F4905A;
      }
    }

    if(scripts\common\vehicle_code::vehicle_should_regenerate(attacker, meansofdeath, objweapon) || scripts\common\vehicle::_id_D7FE44FFB08B499A()) {
      if(getdvarint("dvar_CFD8073837710CEF")) {}

      if(isDefined(self.regenerate) && !istrue(self.regenerate))
        currenthealth = self.health;
      else
        self.health = currenthealth;
    } else {
      if(scripts\common\utility::issp() && isDefined(meansofdeath)) {
        _id_CBB4C29A1471D3C4 = 0;

        if(meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE_SPLASH")
          _id_CBB4C29A1471D3C4 = amount * 12;
        else if(meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_PROJECTILE")
          _id_CBB4C29A1471D3C4 = amount * 5;

        if(_id_CBB4C29A1471D3C4) {
          if(getdvarint("dvar_CFD8073837710CEF")) {}

          self.health = self.health - int(_id_CBB4C29A1471D3C4);
        }
      }

      currenthealth = self.health;
    }

    if(self.health <= self.healthbuffer) {
      if(isDefined(self._id_A9F96E33F612C828))
        [[self._id_A9F96E33F612C828]]();

      self notify("death", attacker, meansofdeath, objweapon, damagelocation);
      continue;
    }

    if(self isscriptable() && self getscriptablehaspart("mp_test_folder")) {
      damagestate = undefined;
      _id_47D36F3CB2120A2B = (self.health - self.healthbuffer) / (self.maxhealth - self.healthbuffer);

      if(_id_47D36F3CB2120A2B <= 0.3)
        damagestate = "damageHeavy";
      else if(_id_47D36F3CB2120A2B <= 0.65)
        damagestate = "damageMedium";
      else if(_id_47D36F3CB2120A2B <= 0.9)
        damagestate = "damageLight";

      if(isDefined(damagestate)) {
        if(self getscriptablepartstate(damagestate, 1) != damagestate) {
          if(self getscriptablehaspart(damagestate))
            self setscriptablepartstate(damagestate, "highSpeed", 1);
        }
      }
    }
  }
}

_id_17FC1AB81CB61842() {
  if(!scripts\engine\utility::flag_exist("level_ready_for_script"))
    scripts\engine\utility::flag_init("level_ready_for_script");

  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(!isDefined(self.riders))
    self.riders = [];

  if(!isDefined(self.unloadque))
    self.unloadque = [];

  _id_28926EABDE819B0D::_id_03DD20FF8B99819A();
  self endon("death");
  self endon("stop_chasing");
  self endon("unloaded");
  scripts\cp\cp_outofbounds::enableoobimmunity(self);
  self _meth_D2E41C7603BA7697("p2p");
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  self _meth_77320E794D35465A("p2p", "goalThreshold", 48);
  self _meth_77320E794D35465A("p2p", "reverseGasNormal", 0.75);
  self _meth_77320E794D35465A("p2p", "stuckTime", 3);
  self _meth_77320E794D35465A("p2p", "manualSpeed", 250);
  thread _id_24E4405CF93F20ED::_id_4808177C29F56FB9();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_jltv_mg", "damageIgnoresArmor"))
    self._id_7A646FF827387AC0 = scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_jltv_mg", "damageIgnoresArmor");

  targetname = self.vehicle_spawner.targetname;
  index = strtok(targetname, "_")[2];
  current_target = undefined;

  if(isDefined(self.vehicle_spawner.target))
    current_target = scripts\engine\utility::getStruct(self.vehicle_spawner.target, "targetname");

  self setscriptablepartstate("tag_light_front_left", "on");
  self setscriptablepartstate("tag_light_front_right", "on");
  thread _id_205A864C4DDDC0EA();
  thread _id_3C808C662DD93712();
  _id_72B101F75CEB5F3F();

  while(!istrue(self._id_05B28EB17C0B5497)) {
    wait 0.05;

    if(istrue(self._id_65D1C67ECFD84B03)) {
      return;
    }
    if(!isDefined(current_target)) {
      return;
    }
    _id_CA3EE910A7A8F690 = current_target;
    _id_BC36C55F86568C40 = undefined;

    if(isDefined(_id_CA3EE910A7A8F690))
      _id_BC36C55F86568C40 = _id_CA3EE910A7A8F690.origin;
    else {
      _id_C729D49D406ACED8 = scripts\cp\utility::get_closest_living_player();

      if(!isDefined(_id_C729D49D406ACED8)) {
        wait 0.05;
        continue;
      }

      _id_BC36C55F86568C40 = _id_C729D49D406ACED8.origin;
    }

    _id_BC36C55F86568C40 = getclosestpointonnavmesh(_id_BC36C55F86568C40);
    self _meth_77320E794D35465A("p2p", "goalPoint", _id_BC36C55F86568C40);

    while(distancesquared(self.origin, _id_BC36C55F86568C40) > squared(200))
      waitframe();

    if(isDefined(current_target.target))
      current_target = scripts\engine\utility::getStruct(current_target.target, "targetname");
    else
      return;

    if(_id_24E4405CF93F20ED::_id_EEE51130CC8DCE38())
      return;
  }
}

_id_567244E44FF8E2DD() {
  self endon("death");
  self._id_05B28EB17C0B5497 = 1;
  self _meth_65AA053C077C003A(1);
  _id_3E514F618725E8F8 = self.riders;
  self notify("newFollowPath");

  foreach(rider in self.riders) {
    if(self._id_F8D72B691958C9A0)
      rider setstealthstate("combat");
  }

  waitframe();
  _id_24E4405CF93F20ED::_id_7D8F81A94DC08A15();

  if(self._id_F626B845D8C284E2) {
    _id_023558660003813E = self._id_FDA9EA513D557243.entity;
    _func_BC97202BA2DB4CF4(_id_023558660003813E, 0);

    foreach(rider in _id_3E514F618725E8F8)
    rider aieventlistenerevent(self._id_FDA9EA513D557243.typeorig, _id_023558660003813E, self._id_FDA9EA513D557243.origin);
  }

  wait 1;

  foreach(rider in self.riders)
  rider thread _id_742F61B6768A1AAB::_id_9C0FBE62C1B9D660(undefined, undefined, 1);

  self _meth_65AA053C077C003A(0);
  self vehicle_turnengineoff();
  _id_24E4405CF93F20ED::_id_1686ECAABFDC542D();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
}

_id_205A864C4DDDC0EA() {
  self endon("death");

  while(!isDefined(self._id_FE321E008E65C319))
    waitframe();

  self._id_FE321E008E65C319._id_A4738C70736D3A61 = ::_id_BDB70E412A38418D;
  _id_185EE38BD3793878 = self.origin;
  _id_84FB7053AB953427 = gettime();
  _id_1F328B9BEBD73213 = gettime();
  lasthealth = self.health;
  self._id_F626B845D8C284E2 = 0;

  while(!istrue(self._id_05B28EB17C0B5497)) {
    self._id_F8D72B691958C9A0 = 0;

    if(isDefined(self.riders)) {
      foreach(rider in self.riders) {
        if(isDefined(rider) && isalive(rider)) {
          if(rider scripts\asm\asm_bb::bb_iswhizbyrequested()) {
            self._id_F8D72B691958C9A0 = 1;
            break;
          }
        }
      }
    }

    if(_id_FD324F74C6D07C2E() || (_id_24E4405CF93F20ED::_id_EEE51130CC8DCE38() || lasthealth - self.health > 200) || istrue(self._id_F626B845D8C284E2) || istrue(self._id_F8D72B691958C9A0)) {
      thread _id_567244E44FF8E2DD();
      return;
    }

    waitframe();
  }
}

_id_3C808C662DD93712() {
  self endon("death");
  self endon("unloaded");

  for(;;) {
    self waittill("damage", amount, attacker);

    if(!isPlayer(attacker))
      continue;
    else {
      wait 1;
      thread _id_567244E44FF8E2DD();
      return;
    }
  }
}

_id_FD324F74C6D07C2E() {
  if(istrue(self._id_65D1C67ECFD84B03))
    return 1;

  return 0;
}

_id_BDB70E412A38418D(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!isDefined(self.vehicle) || self.vehicle _id_FD324F74C6D07C2E())
    _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_72B101F75CEB5F3F() {
  foreach(rider in self.riders) {
    rider thread _id_742F61B6768A1AAB::_id_7BB278ADFAC595F5(1);
    rider thread _id_A8A03775DFD66E6E();
  }
}

_id_3C40B3A157D1EA42() {
  self endon("death");
  self endon("kill_unload_watchers");

  for(;;) {
    if(_id_9F162ACD67E4E102(self))
      waitframe();

    waitframe();
  }
}

_id_EBDB14C8494516E3() {
  for(;;) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.instances)) {
      foreach(_id_7731ADEF63E19B0C, _id_E5CD5CE5EE8DC6C9 in level.vehicle.instances) {
        foreach(vehicle in _id_E5CD5CE5EE8DC6C9) {
          if(_id_9F162ACD67E4E102(vehicle))
            waitframe();
        }
      }
    }

    foreach(vehicle in level._id_6E5FF6CAE14C4081) {
      if(_id_9F162ACD67E4E102(vehicle))
        waitframe();
    }

    waitframe();
  }
}

_id_9F162ACD67E4E102(vehicle) {
  if(!isDefined(vehicle))
    return 0;

  velocity = vehicle vehicle_getvelocity();
  _id_A539ACFB614AD59D = vectorNormalize(velocity);
  speed = length(velocity);
  ents = undefined;

  if(speed > 100) {
    _id_A2FCE1A0DAA1830A = scripts\cp\utility\entity::_id_D9CE8FB00F0E5FA1(vehicle.origin, speed * 1.0);

    foreach(ent in _id_A2FCE1A0DAA1830A) {
      if(!isagent(ent) || !isalive(ent)) {
        continue;
      }
      if(istrue(ent._id_C2C8A0D42AB3BCDA)) {
        continue;
      }
      if(isDefined(ent.vehicle)) {
        continue;
      }
      _id_8F95E32CFD250705 = vectorNormalize(ent.origin - vehicle.origin);

      if(vectordot(_id_8F95E32CFD250705, _id_A539ACFB614AD59D) > 0.9) {
        _id_3A3002B6CA1FC40D = vectordot(anglesToForward(ent.angles), _id_8F95E32CFD250705 * -1);
        _id_6B16895685C64534 = vectordot(anglestoright(ent.angles), _id_8F95E32CFD250705 * -1);

        if(abs(_id_3A3002B6CA1FC40D) > abs(_id_6B16895685C64534)) {
          if(_id_6B16895685C64534 > 0)
            ent thread _id_5AE33E6D50F7A4C6("avoid_left");
          else
            ent thread _id_5AE33E6D50F7A4C6("avoid_right");
        } else if(_id_3A3002B6CA1FC40D > 0)
          ent thread _id_5AE33E6D50F7A4C6("avoid_back");
        else
          ent thread _id_5AE33E6D50F7A4C6("avoid_forward");

        continue;
      }
    }

    return 1;
  }

  return 0;
}

_id_5AE33E6D50F7A4C6(animname) {
  self endon("death");

  if(istrue(self._id_C2C8A0D42AB3BCDA)) {
    return;
  }
  if(!isDefined(self.asmname) || !self asmhasstate(self.asmname, "animscripted") || !isDefined(self._id_AE3EA15396B65C1F) || !archetypehasstate(self._id_AE3EA15396B65C1F, "animscripted")) {
    return;
  }
  self._id_C2C8A0D42AB3BCDA = 1;
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", animname);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  self dontinterpolate();
  self aisetanim("animscripted", animindex);
  _id_228C1F2F3A2D92F1 = getanimlength(xanim);
  wait(_id_228C1F2F3A2D92F1);
  scripts\asm\asm_bb::bb_clearanimScripted();
  self._id_C2C8A0D42AB3BCDA = 0;
}

_id_837C7C8C00031F47() {
  self endon("death");
  level endon("obj_scene_started");
  waitframe();

  while(!isDefined(self.riders))
    wait 0.5;

  self.gunner = _id_87E5390ABA2E681B();

  while(!isDefined(self.gunner)) {
    self.gunner = _id_87E5390ABA2E681B();
    wait 0.1;
  }

  self.gunner.allowpain = 0;
  self.gunner._id_292D0F6A197C141E = 1;

  while(!isDefined(self.mgturret))
    waitframe();

  turret = self.mgturret[0];
  turret makeunusable();
  self.gunner.vehicle = self;
  self.gunner waittill("death");

  if(isDefined(turret)) {
    turret cleartargetentity();
    turret setmode("sentry_offline");
  }

  if(isDefined(self.turret_pointer))
    self.turret_pointer delete();

  wait 0.75;
  self notify("gunner_defeated");
}

_id_87E5390ABA2E681B() {
  foreach(rider in self.riders) {
    if(rider.vehicle_position == 4)
      return rider;
  }

  return undefined;
}

_id_A8A03775DFD66E6E() {
  self endon("death");
  level endon("obj_scene_started");

  for(;;) {
    wait 0.2;

    if(self[[self.fnisinstealthcombat]]()) {
      self._id_65D1C67ECFD84B03 = 1;

      if(isDefined(self.vehicle)) {
        self.vehicle._id_65D1C67ECFD84B03 = 1;
        return;
      }
    }
  }
}

update_turret_pointer(pos) {
  if(!isDefined(self.turret_pointer))
    self.turret_pointer = scripts\engine\utility::spawn_script_origin(pos);
  else
    self.turret_pointer.origin = pos;

  self.mgturret[0] settargetentity(self.turret_pointer);
}

turret_spotted_ent_think(ent) {
  ent endon("stop_turret_spotted_ent_think");
  ent endon("disconnect");
  _id_F00D645C58143E63 = 0;

  for(;;) {
    if(!isDefined(ent)) {
      return;
    }
    while(isalive(self.gunner) && turret_is_on_ent(ent, 10)) {
      _id_F00D645C58143E63++;

      if(_id_F00D645C58143E63 >= 3) {
        if(isPlayer(ent)) {
          if(!scripts\engine\utility::is_equal(self.turret_investigate_pos, ent.origin))
            update_turret_investigate_pos(ent.origin);
        } else
          return;
      }

      waitframe();
    }

    if(_id_F00D645C58143E63 > 0)
      _id_F00D645C58143E63 = 0;

    waitframe();
  }
}

turret_is_on_ent(ent, fov) {
  if(distance2dsquared(self.origin, ent.origin) > 4000000)
    return 0;

  origin = ent.origin;

  if(isPlayer(ent))
    origin = ent getEye();
  else
    origin = ent.origin;

  turret = self.mgturret[0];
  start = turret gettagorigin("tag_flash");
  angles = turret gettagangles("tag_flash");

  if(scripts\engine\utility::within_fov(start, angles, origin, cos(fov))) {
    if(self.gunner cansee(ent))
      return 1;
  }

  return 0;
}

update_turret_investigate_pos(pos) {
  scripts\engine\utility::ent_flag_set("turret_investigate_pos_updated");
  self.turret_investigate_pos = pos;
  self.turret_investigate_pos_time = gettime();
}

turret_aim_think() {
  self.gunner endon("stealth_hunt");
  self.gunner endon("death");
  _id_72BB599075A82534 = undefined;
  self._id_F9374A64EF9C64EC = undefined;
  _id_2D1996A1AFA79192 = 0;
  _id_C00939B2974DB87C = (0, 0, 0);
  _id_072BD42692055CDD = [self.mgturret[0], self.gunner];
  _id_072BD42692055CDD = scripts\engine\utility::array_combine(_id_072BD42692055CDD, level.players);

  for(;;) {
    waitframe();

    if(!isDefined(level.players) || level.players.size == 0) {
      continue;
    }
    self.mgturret[0]._id_F9374A64EF9C64EC = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(self.mgturret[0]._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(self.gunner.enemy, self.mgturret[0]._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(gettime() - self.gunner lastknowntime(self.mgturret[0]._id_F9374A64EF9C64EC) > 10000) {
      continue;
    }
    if(scripts\engine\utility::is_equal(self.gunner lastknownpos(self.mgturret[0]._id_F9374A64EF9C64EC), _id_72BB599075A82534)) {
      continue;
    }
    _id_72BB599075A82534 = self.gunner lastknownpos(self.mgturret[0]._id_F9374A64EF9C64EC);

    if(gettime() > _id_2D1996A1AFA79192) {
      start_origin = self.mgturret[0] gettagorigin("tag_aim");
      _id_A89FB08B16E1D170 = self.mgturret[0]._id_F9374A64EF9C64EC getEye() - self.mgturret[0]._id_F9374A64EF9C64EC.origin - (0, 0, 10);

      if(scripts\engine\trace::ray_trace_passed(start_origin, _id_72BB599075A82534, _id_072BD42692055CDD))
        _id_C00939B2974DB87C = (0, 0, 0);
      else if(scripts\engine\trace::ray_trace_passed(start_origin, _id_72BB599075A82534 + _id_A89FB08B16E1D170, _id_072BD42692055CDD))
        _id_C00939B2974DB87C = _id_A89FB08B16E1D170;
      else if(scripts\engine\trace::ray_trace_passed(start_origin, _id_72BB599075A82534 + _id_A89FB08B16E1D170 / 2, _id_072BD42692055CDD))
        _id_C00939B2974DB87C = _id_A89FB08B16E1D170 / 2;

      _id_2D1996A1AFA79192 = gettime() + 1000;
    }

    aim_pos = _id_72BB599075A82534 + _id_C00939B2974DB87C;

    if(distancesquared(aim_pos, self.origin) < 40000 && !self.mgturret[0] turretcantarget(aim_pos)) {
      _id_6B8BC7FAB156CCD9 = self.origin;
      _id_F92BD9CAB49D2D58 = scripts\engine\utility::flatten_vector(aim_pos - _id_6B8BC7FAB156CCD9);
      aim_pos = _id_6B8BC7FAB156CCD9 + _id_F92BD9CAB49D2D58 * 500;
    }

    update_turret_pointer(aim_pos);
  }
}

turret_shoot_think() {
  self notify("stop_turret_shoot_think");
  self endon("stop_turret_shoot_think");
  gunner = self.ownervehicle.gunner;

  while(!gunner_can_shoot_player(gunner))
    waitframe();

  for(;;) {
    waitframe();

    if(!isDefined(self._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(gunner.enemy, self._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(gettime() - gunner lastknowntime(self._id_F9374A64EF9C64EC) > 10000) {
      continue;
    }
    if(isDefined(self.ownervehicle.turret_pointer)) {
      if(!self turretcantarget(self.ownervehicle.turret_pointer.origin))
        continue;
    }

    start_origin = self gettagorigin("tag_flash");
    start_angles = self gettagangles("tag_flash");
    _id_4351410D12107DF3 = gunner lastknownpos(self._id_F9374A64EF9C64EC);

    if(!turret_aimed_at_last_known(start_origin, start_angles, _id_4351410D12107DF3)) {
      continue;
    }
    if(distance2dsquared(self.origin, _id_4351410D12107DF3) > squared(3000)) {
      continue;
    }
    trace = scripts\engine\trace::ray_trace(start_origin, start_origin + anglesToForward(start_angles) * 3000, self);
    _id_E18FB8F9395C8AF8 = trace["entity"];

    if(isDefined(_id_E18FB8F9395C8AF8) && (_id_E18FB8F9395C8AF8 == self.ownervehicle || scripts\engine\utility::is_equal(_id_E18FB8F9395C8AF8.team, "axis"))) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      self shootturret("tag_flash");
      level notify("technical_hot_event", gunner);
      wait 0.1;
    }

    wait 1;

    while(!gunner_can_shoot_player(gunner))
      waitframe();
  }
}

gunner_can_shoot_player(gunner) {
  if(!isDefined(self._id_F9374A64EF9C64EC))
    return 0;

  if(gunner cansee(self._id_F9374A64EF9C64EC))
    return 1;

  _id_EE752F5A6B0F9807 = gunner lastknowntime(self._id_F9374A64EF9C64EC);

  if(!isDefined(_id_EE752F5A6B0F9807))
    return 0;

  if(gettime() - _id_EE752F5A6B0F9807 > 10000)
    return 0;

  _id_72BB599075A82534 = gunner lastknownpos(self._id_F9374A64EF9C64EC);

  if(!isDefined(_id_72BB599075A82534))
    return 0;

  if(!turret_aimed_at_last_known(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), _id_72BB599075A82534))
    return 0;

  if(distancesquared(_id_72BB599075A82534, self._id_F9374A64EF9C64EC.origin) > 16384)
    return 0;

  return 1;
}

turret_aimed_at_last_known(start_origin, start_angles, _id_C74E2E565EE3FE18) {
  if(!isDefined(self._id_F9374A64EF9C64EC))
    return 0;

  if(scripts\engine\utility::within_fov(start_origin, start_angles, _id_C74E2E565EE3FE18, 0.7))
    return 1;

  _id_A89FB08B16E1D170 = self._id_F9374A64EF9C64EC getEye() - self._id_F9374A64EF9C64EC.origin;

  if(scripts\engine\utility::within_fov(start_origin, start_angles, _id_C74E2E565EE3FE18 + _id_A89FB08B16E1D170, 0.7))
    return 1;

  if(scripts\engine\utility::within_fov(start_origin, start_angles, _id_C74E2E565EE3FE18 + _id_A89FB08B16E1D170 / 2, 0.7))
    return 1;

  return 0;
}

turret_sweep(turret, _id_46D8E81088AF53D5, _id_87CDBDFE21E2D499) {
  self endon("death");
  self endon("turret_investigate_pos_updated");
  self.gunner endon("death");
  self.gunner endon("stealth_combat");
  turret setconvergencetime(_id_87CDBDFE21E2D499, "yaw");
  turret setconvergencetime(_id_87CDBDFE21E2D499, "pitch");
  turret setleftarc(180);
  turret setrightarc(180);
  _id_140149F4F2ED1009 = scripts\engine\utility::get_array_of_closest(self.origin, level.technical_spotlight_targets, undefined, undefined, 4000);
  _id_6075CD8D87DF97EC = [];
  _id_DE40082E48FF7CC9 = anglestoright(self.angles);
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
  _id_6B84F2EC187B1C4D = scripts\engine\utility::getclosest(self.origin, _id_A02118632C7F1621, 1500);

  if(isDefined(_id_6B84F2EC187B1C4D)) {
    dir = vectorNormalize(_id_6B84F2EC187B1C4D.origin - self.origin);
    dot = vectordot(_id_DE40082E48FF7CC9, dir);
    _id_46D8E81088AF53D5 = dot;
  }

  foreach(target in _id_140149F4F2ED1009) {
    dir = vectorNormalize(target.origin - self.origin);
    dot = vectordot(_id_DE40082E48FF7CC9, dir);

    if(dot * _id_46D8E81088AF53D5 <= 0) {
      continue;
    }
    if(!turret turretcantarget(target.origin)) {
      continue;
    }
    _id_6075CD8D87DF97EC[_id_6075CD8D87DF97EC.size] = target;
  }

  best_target = undefined;

  foreach(player in level.players) {
    dir = vectorNormalize(player.origin - self.origin);
    dot = vectordot(_id_DE40082E48FF7CC9, dir);

    if(dot * _id_46D8E81088AF53D5 > 0) {
      best_target = scripts\engine\utility::getclosest(player.origin, _id_6075CD8D87DF97EC);
      continue;
    }

    best_target = scripts\cp\utility::getfarthest(player.origin, _id_6075CD8D87DF97EC);
  }

  if(!isDefined(best_target))
    return 0;

  update_turret_pointer(best_target.origin);
  waittill_technical_turns_or_timeout(_id_87CDBDFE21E2D499 + 2);
  return 1;
}

waittill_technical_turns_or_timeout(timeout) {
  _id_F6E585610BAFC635 = anglesToForward(self.angles);
  _id_BFDA656E7B3CC1A0 = gettime() + timeout * 1000;

  while(gettime() < _id_BFDA656E7B3CC1A0) {
    waitframe();
    forward = anglesToForward(self.angles);
    dot = vectordot(_id_F6E585610BAFC635, forward);

    if(dot < 0.5) {
      break;
    }
  }
}