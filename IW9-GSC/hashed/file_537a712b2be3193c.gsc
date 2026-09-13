/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_537a712b2be3193c.gsc
***********************************************/

_id_43825E7633150BE3(aitype, spawnpoint, _id_920F4173513EB6B8, goalradius) {
  ai = scripts\mp\mp_agent::spawnnewagentaitype(aitype, spawnpoint.origin, (0, 0, 0));

  if(isDefined(ai)) {
    ai _id_18A73A64992DD07D::_id_389FFF85C076F49E();
    ai _id_B292D0931FD89CD1(aitype);
    ai _id_9D7852EAABE40398(aitype);
    ai _id_0A5BF59B49D59188(aitype);
    ai notify("stop_hunting");

    if(!_id_0578D89786B7EDA1()) {
      ai cleargoalvolume();
      ai setgoalpos(ai.origin);
    }

    if(isDefined(goalradius))
      ai.goalradius = goalradius;
    else
      ai.goalradius = 1024;

    ai _id_68FA6B4EE60216AE::init(aitype);
    ai scripts\engine\utility::delaythread(3, ::_id_3B02EEBE0B11F734, _id_920F4173513EB6B8);
    return ai;
  }

  return undefined;
}

_id_B292D0931FD89CD1(aitype) {
  if(issubstr(aitype, "_smg"))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_100");
  else if(issubstr(aitype, "_ar"))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_100");
  else if(issubstr(aitype, "_sniper"))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_100");
  else if(issubstr(aitype, "_juggernaut"))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_1000");
  else if(issubstr(aitype, "_shotgun"))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_100");
  else if(issubstr(aitype, "_lmg"))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_100");
  else if(issubstr(aitype, "_rpg"))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_100");
}

_id_9D7852EAABE40398(aitype) {
  _id_18A73A64992DD07D::_id_389FFF85C076F49E();
  _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_armor_plate");
  _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_powerup_equipment");
}

_id_0A5BF59B49D59188(aitype) {
  if(issubstr(aitype, "_juggernaut"))
    _id_266C399FB76E6719::set_juggernaut_flags();
  else if(issubstr(aitype, "riotshield"))
    self._id_0B6AC2CA2CE25F58 = 1;
  else if(issubstr(aitype, "heavy"))
    _id_18A73A64992DD07D::give_soldier_armor();
  else
    _id_BC6DBD7AED124330();
}

_id_BC6DBD7AED124330() {
  if(!isDefined(level._id_AE12ED8FC05422D2))
    level._id_AE12ED8FC05422D2 = 0;

  if(level._id_AE12ED8FC05422D2 < 6) {
    return;
  }
  _id_98EA5AFB293A76A2 = level._id_AE12ED8FC05422D2 - 6 + 1;
  self.baseaccuracy = self.baseaccuracy + 0.1 * _id_98EA5AFB293A76A2;
  maxhealth = self.maxhealth + _id_98EA5AFB293A76A2 * 25;

  if(maxhealth > 810)
    maxhealth = 810;

  self.maxhealth = maxhealth;
  self.health = maxhealth;
}

_id_192F8A34D0AE130F(ai_array, _id_CE3C23B4AB427559) {
  leader = scripts\engine\utility::random(ai_array);

  if(isDefined(_id_CE3C23B4AB427559)) {
    if(isarray(_id_CE3C23B4AB427559))
      leader = scripts\engine\utility::random(_id_CE3C23B4AB427559);
    else
      leader = _id_CE3C23B4AB427559;
  }

  for(;;) {
    alive = 0;

    foreach(ai in ai_array) {
      if(!isalive(ai) || ai.health < 1) {
        continue;
      }
      alive = 1;
    }

    if(!alive) {
      return;
    }
    if(isDefined(leader) && isalive(leader)) {
      foreach(ai in ai_array) {
        if(!isDefined(ai)) {
          continue;
        }
        if(ai == leader) {
          continue;
        }
        if(!isalive(ai) || ai.health < 1) {
          continue;
        }
        if(!isDefined(ai.goalent) || ai.goalent != leader) {
          if(getDvar("squad_debug") != "")
            ai hudoutlineenable("outline_nodepth_white");

          ai notify("stop_hunting");
          ai setgoalentity(leader);
          ai.goalent = leader;
        }

        _id_4666C0E35742BC07 = 0;

        foreach(player in level.players) {
          if(distance2dsquared(leader.origin, player.origin) < squared(leader.goalradius))
            _id_4666C0E35742BC07 = 1;
        }

        ai.goalradius = 256;

        if(_id_4666C0E35742BC07 || distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius)) {
          if(distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius)) {
            ai setcoverselectionfocusent(leader);
            ai.goalradius = 800;
          }
        }
      }
    } else {
      ai_array = scripts\engine\utility::array_removeundefined(ai_array);

      if(ai_array.size == 0) {
        return;
      }
      leader = scripts\engine\utility::random(ai_array);

      if(isDefined(_id_CE3C23B4AB427559)) {
        alive = 0;

        foreach(guy in _id_CE3C23B4AB427559) {
          if(!isalive(guy) || guy.health < 1) {
            continue;
          }
          alive = 1;
        }

        if(alive) {
          if(isarray(_id_CE3C23B4AB427559))
            leader = scripts\engine\utility::random(_id_CE3C23B4AB427559);
          else
            leader = _id_CE3C23B4AB427559;
        }
      }

      leader notify("stop_hunting");

      if(getDvar("squad_debug") != "")
        leader hudoutlineenable("outline_nodepth_green");

      leader thread _id_9C0FBE62C1B9D660();
    }

    wait 1;
  }
}

_id_EDBFA2BA7F3B537F() {
  for(;;) {
    level waittill("spawn_boss_heli");
    _id_A35AF25CA5C20EA8 = spawnStruct();
    _id_A35AF25CA5C20EA8.origin = (0, 0, 2000);
    _id_A35AF25CA5C20EA8.script_noteworthy = "test_path";
    spawn_point = spawnStruct();
    spawn_point.origin = (-10000, -10000, 1200);
    spawn_point.angles = (0, 0, 0);
    spawn_point.classname_mp = "script_vehicle_apache_east";
    spawn_point.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
    spawn_point.vehicletype = "veh_apache_cp";
    heli = scripts\common\vehicle::vehicle_spawn(spawn_point);
    heli.death_fx_on_self = 1;
    heli.circle_radius = 2500;
    heli scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret");
    heli thread _id_8D90F05D674519FF(1);
    heli.isheli = 1;
    heli.health = 50000;
    heli.maxhealth = 50000;
    heli.team = "axis";
    heli setvehicleteam(heli.team);
    heli setmaxpitchroll(15, 15);
    heli.health_remaining = 2250;
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(heli, 1800);
    heli sethoverparams(25, 15, 10);
    heli.headicon = createheadicon(heli);
    setheadiconimage(heli.headicon, "hud_icon_head_equipment_enemy");
    setheadiconmaxdistance(heli.headicon, 12000);
    setheadiconnaturaldistance(heli.headicon, 1500);
    setheadiconzoffset(heli.headicon, 10);
    setheadiconsnaptoedges(heli.headicon, 1);

    if(!isDefined(level.special_lockon_target_list))
      level.special_lockon_target_list = [];

    level.special_lockon_target_list[level.special_lockon_target_list.size] = heli;
    level.attack_heli = heli;
    heli waittill("death");
  }
}

_id_8D90F05D674519FF(_id_472C96D6A8ED7D53) {
  _id_F204DACE25365C76 = "tag_pilot";

  if(!self tagexists(_id_F204DACE25365C76))
    _id_F204DACE25365C76 = "tag_pilot1";

  self.pilot = spawn("script_model", self gettagorigin(_id_F204DACE25365C76));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, _id_F204DACE25365C76, (0, 0, 0), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("vh_mindia8_pilot_idle");

  if(isDefined(_id_472C96D6A8ED7D53))
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
}

_id_3B02EEBE0B11F734(_id_25F0D68EE22434EB) {
  if(!getdvarint("dvar_26524832A07CF602", 1)) {
    self.dropweapon = 0;
    return;
  }

  if(!isDefined(_id_25F0D68EE22434EB))
    _id_25F0D68EE22434EB = 0;

  self.dropweapon = _id_25F0D68EE22434EB;
  self._id_98ADD129A7ECB962 = 0;
}

_id_0578D89786B7EDA1() {
  return getdvarint("dvar_45DED5ED971FB14A", 0) != 0;
}

_id_3BA1A006F4DE9686() {
  self.script_stealthgroup = "dogs";
  _id_0E92EC2858FC2AC1();
}

_id_9C0FBE62C1B9D660() {
  self endon("death");
  self endon("stop_hunting");
  player = scripts\engine\utility::random(level.players);

  for(;;) {
    if(!isDefined(player) || istrue(player.inlaststand)) {
      selected = 0;

      foreach(_id_4A27F44F23590C6F in level.players) {
        if(istrue(_id_4A27F44F23590C6F.inlaststand)) {
          continue;
        }
        player = _id_4A27F44F23590C6F;
        selected = 1;
      }

      if(!selected) {
        wait 3;
        player = undefined;
        continue;
      }
    }

    foreach(_id_8B6D3988CED8664E in level.players)
    self getenemyinfo(_id_8B6D3988CED8664E);

    org = player.origin;
    wait 3;
  }
}

_id_E4F3059610095250(spawned, _id_7F0C5EAD0494E282, _id_DA87F68719E2B303) {
  if(!isDefined(_id_7F0C5EAD0494E282))
    _id_7F0C5EAD0494E282 = 0;

  wave_num = level._id_AE12ED8FC05422D2;

  if(isDefined(_id_DA87F68719E2B303))
    wave_num = _id_DA87F68719E2B303;

  for(;;) {
    wait 1;
    alive = 0;

    if(!isDefined(spawned))
      spawned = level._id_0603F2855FC89966[wave_num];

    if(!isDefined(spawned)) {
      return;
    }
    foreach(ent in spawned) {
      if(isalive(ent) && ent.health > 0) {
        if(!isDefined(ent._id_B003E2C45A4BF6F7))
          ent._id_B003E2C45A4BF6F7 = ent.origin;
        else if(distancesquared(ent._id_B003E2C45A4BF6F7, ent.origin) < squared(16)) {
          if(!isDefined(ent._id_DC9BED8DC1499C04))
            ent._id_DC9BED8DC1499C04 = 0;
          else
            ent._id_DC9BED8DC1499C04++;

          if(ent._id_DC9BED8DC1499C04 > 5) {}
        }

        alive++;
        continue;
      }
    }

    if(alive > _id_7F0C5EAD0494E282)
      continue;
    else
      return;
  }
}

_id_0E92EC2858FC2AC1(group_name, func) {
  if(isDefined(self.spawnpoint))
    self.spawnpoint.spawnflags = 512;

  self.goalradius = 16;
  self.sightmaxdistance = 2200;

  if(!isDefined(self.script_stealthgroup))
    self.script_stealthgroup = "stealth_intro_group";

  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

_id_AB858DAAC5D7B598() {
  _id_837590C56A1C2441 = [];
  _id_837590C56A1C2441["prone"] = 800;
  _id_837590C56A1C2441["crouch"] = 1500;
  _id_837590C56A1C2441["stand"] = 3000;
  _id_6CBBAFD9FF4B4702 = [];
  _id_6CBBAFD9FF4B4702["prone"] = 800;
  _id_6CBBAFD9FF4B4702["crouch"] = 1500;
  _id_6CBBAFD9FF4B4702["stand"] = 3000;
  scripts\stealth\utility::set_detect_ranges(_id_837590C56A1C2441, _id_6CBBAFD9FF4B4702);
}

_id_C84A5070BB4A2D2D(_id_17B73AA1820974EE) {
  if(isDefined(_id_17B73AA1820974EE))
    scripts\cp\coop_stealth::set_maxvisibledist(_id_17B73AA1820974EE);
  else
    scripts\cp\coop_stealth::set_maxvisibledist(8192);
}