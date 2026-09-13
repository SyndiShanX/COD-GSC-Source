/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_38757eca8b2f5c7e.gsc
***********************************************/

init() {
  level._id_7BF42D565645A485 = 1;

  while(!isDefined(level.struct_class_names))
    waitframe();

  startstruct = scripts\engine\utility::getStruct("hostile_remote_tank_start_point", "script_noteworthy");

  if(!isDefined(startstruct)) {
    return;
  }
  pathstruct = generatepath(startstruct);
  level waittill("matchStartTimer_done");

  if(isDefined(level._id_4B195D3DD0024B9C))
    team = level._id_4B195D3DD0024B9C;
  else
    team = "team_hundred_ninety_five";

  spawndata = spawnStruct();
  spawndata.origin = startstruct.origin;
  spawndata.angles = startstruct.angles;
  spawndata.spawntype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.owner = undefined;
  spawndata.team = team;
  spawndata.modelname = "veh9_mil_lnd_whotel_v2_composite_mp";
  spawndata.vehicletype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.targetname = "remote_tank";
  spawndata.cancapture = 0;
  spawndata.cancaptureimmediately = 0;
  spawndata.activateimmediately = 1;
  _id_F5E7C5E12051B3EB = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata);
  _id_2884ADC8D320F897 = _id_48814951E916AF89::_id_AF3034A7C69D7EDB(team);
  _id_F5E7C5E12051B3EB.owner = _id_2884ADC8D320F897;
  _id_F5E7C5E12051B3EB setentityowner(_id_2884ADC8D320F897);
  _id_F5E7C5E12051B3EB.owner.team = team;
  _id_F5E7C5E12051B3EB.team = team;
  _id_F5E7C5E12051B3EB.tanktype = "remote_tank";
  _id_F5E7C5E12051B3EB.maxhealth = 3000;
  _id_F5E7C5E12051B3EB.health = 3000;
  _id_F5E7C5E12051B3EB.currenthealth = 3000;
  _id_F5E7C5E12051B3EB.pathstruct = pathstruct;
  _id_F5E7C5E12051B3EB.vehiclename = "pac_sentry";
  _id_F5E7C5E12051B3EB._id_1329597B4278AFE9 = [];
  _id_F5E7C5E12051B3EB._id_0AF81370570C04CA = 7;
  interact = _id_E4A9C1492C383E08(_id_F5E7C5E12051B3EB.origin);
  _id_F5E7C5E12051B3EB thread _id_32D0F3B0D7FC69B6(interact);
  interact._id_F5E7C5E12051B3EB = _id_F5E7C5E12051B3EB;
  _id_F5E7C5E12051B3EB.interact = interact;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(_id_F5E7C5E12051B3EB);
  _id_F5E7C5E12051B3EB.teamfriendlyto = team;
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(_id_F5E7C5E12051B3EB, _id_F5E7C5E12051B3EB.owner, _id_F5E7C5E12051B3EB.owner.team);
  _id_F5E7C5E12051B3EB scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_90FBF0CED62BC14A);
  _id_F5E7C5E12051B3EB scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_E0C83A146741815F);
  _id_F5E7C5E12051B3EB _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_F149E9383F183CF0);
  _id_F5E7C5E12051B3EB _id_736DEC95A49487A6::_id_AA823A31304ED981(::_id_005C67FA91FE5B79);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("wheelson_hack_point", ::_id_10A948F6954B0385);
  _id_F5E7C5E12051B3EB scripts\mp\killstreaks\remotetank::_id_89445073F3E86E5C(_id_F5E7C5E12051B3EB.vehiclename);
  scripts\mp\killstreaks\remotetank::_id_E2797FDB403C45E0(_id_F5E7C5E12051B3EB.vehiclename);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("claymore_mp", 3);
  _id_F5E7C5E12051B3EB.damagecallback = ::_id_95B81D49D4CC38AB;
  _id_F5E7C5E12051B3EB.deathcallback = ::_id_52B9749CBF8C998E;
  _id_F5E7C5E12051B3EB thread _id_822A21DC99EAF90D();
  _id_F5E7C5E12051B3EB thread _id_7CAE93055DAE77EC(pathstruct);
  playFXOnTag(scripts\engine\utility::getfx("vfx_dmz_Wheelson_flashlight"), _id_F5E7C5E12051B3EB, "tag_flash");
}

_id_7CAE93055DAE77EC(pathstruct) {
  level endon("game_ended");

  for(;;) {
    if(istrue(level._id_0C37DDB982D3177D)) {
      break;
    }

    wait 1;
  }

  _id_202BE4795D350B40 = getdvarint("dvar_94B4025090D134C9", 0);

  if(_id_202BE4795D350B40)
    level thread _id_8C52F29581554CF8();

  self vehicle_turnengineon();
  thread scripts\mp\killstreaks\remotetank::_id_CF71EB6E0611096C();
  thread _id_0FCF0610C8F03AAB(pathstruct);
}

_id_8C52F29581554CF8() {
  level endon("game_ended");
  wait 7;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_wheelson_on_patrol", level.players);
}

_id_0FCF0610C8F03AAB(pathstruct) {
  _id_D6C52942B2B5EEE4(pathstruct);
  thread _id_744623B9952A9DC0();
}

_id_D6C52942B2B5EEE4(pathstruct) {
  self _meth_D2E41C7603BA7697("p2p");

  if(isDefined(pathstruct.path) && pathstruct.path.size > 0)
    thread _id_4BAC13D511590220::_id_C3889ABF5CD6ABBF(pathstruct, pathstruct.speed);
}

_id_90FBF0CED62BC14A(data) {
  self._id_DF9D4533B4C32B50 = 1;
  _id_1C9955A4730D4C9E();
  self _meth_77320E794D35465A(_func_906E53C2FB9D3F9C("p2p", "pause"));
  scripts\mp\killstreaks\remotetank::_id_6ADD0F629E59F222();
}

_id_E0C83A146741815F(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  _id_319D2227EC7BC841();
  self _meth_77320E794D35465A(_func_906E53C2FB9D3F9C("p2p", "resume"));
  self._id_DF9D4533B4C32B50 = 0;
}

_id_F149E9383F183CF0(data) {
  _id_8A28FD9DF2F03764 = data.victim;

  if(!isDefined(_id_8A28FD9DF2F03764)) {
    return;
  }
  if(istrue(_id_8A28FD9DF2F03764._id_12BFB031C0A0EFD8)) {
    return;
  }
  _id_8A28FD9DF2F03764._id_12BFB031C0A0EFD8 = 1;
  _id_8A28FD9DF2F03764 thread _id_E6CBF8131B64E6DB();
  _id_8A28FD9DF2F03764 _meth_77320E794D35465A("p2p", "manualSpeed", scripts\engine\utility::mph_to_ips(_id_8A28FD9DF2F03764.pathstruct.speed / 3));
}

_id_005C67FA91FE5B79(data) {
  _id_8A28FD9DF2F03764 = data.victim;

  if(!isDefined(_id_8A28FD9DF2F03764)) {
    return;
  }
  _id_8A28FD9DF2F03764 _meth_77320E794D35465A("p2p", "manualSpeed", scripts\engine\utility::mph_to_ips(_id_8A28FD9DF2F03764.pathstruct.speed));
  _id_8A28FD9DF2F03764._id_12BFB031C0A0EFD8 = 0;
}

_id_E6CBF8131B64E6DB() {
  level endon("game_ended");
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];
  firetime = randomfloatrange(0.2, 0.4);
  childthread _id_4973F20495F7D1FF(firetime);
  self._id_158F2FB396C0CCCB = 1;

  if(!isDefined(self.driver)) {
    self clearturrettarget();
    self._id_80C53303FB317FE2 = undefined;
  }

  msg = scripts\engine\utility::waittill_any_return_2("death", "haywire_cleared");
  self._id_158F2FB396C0CCCB = undefined;
}

_id_4973F20495F7D1FF(firetime) {
  self endon("death");
  self endon("haywire_cleared");

  for(;;) {
    self fireweapon();
    wait(firetime);
  }
}

generatepath(startstruct) {
  points = _id_31331B99886B0B8B(startstruct);
  speed = 10;

  if(isDefined(startstruct.script_speed))
    speed = int(startstruct.script_speed);

  struct = spawnStruct();
  struct.path = points;
  struct.speed = speed;
  struct.direction = 1;
  struct.index = 0;
  return struct;
}

_id_31331B99886B0B8B(startstruct) {
  _id_9E4E1482CB40C9C5 = [];
  _id_64232FA83CEE9507 = scripts\engine\utility::getStruct(startstruct.target, "targetname");

  if(!isDefined(_id_64232FA83CEE9507)) {
    return;
  }
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = _id_64232FA83CEE9507;
  _id_43E0B9317508501B = _id_64232FA83CEE9507;

  for(;;) {
    if(!isDefined(_id_43E0B9317508501B.target)) {
      break;
    }

    _id_3E3B7F7727A65DAD = scripts\engine\utility::getStruct(_id_43E0B9317508501B.target, "targetname");

    if(!isDefined(_id_3E3B7F7727A65DAD)) {
      break;
    }

    _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = _id_3E3B7F7727A65DAD;
    _id_43E0B9317508501B = _id_3E3B7F7727A65DAD;
  }

  return _id_9E4E1482CB40C9C5;
}

_id_52B9749CBF8C998E(inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname) {
  if(istrue(self.destroyed))
    return;
  else
    self.destroyed = 1;

  self notify("death");
  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\outofbounds::clearoob(self, 1);
  self playSound("veh_ks_wheelson_explode");
  self setscriptablepartstate("explode", "on", 0);

  if(isDefined(attacker)) {
    if(isDefined(attacker.owner) && isPlayer(attacker.owner))
      attacker = attacker.owner;

    if(isPlayer(attacker)) {
      _id_4B5A99C16ABFDFB1 = getdvarint("dvar_DFCAD66B7BA8DA13", 500);
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199", objweapon, undefined, _id_4B5A99C16ABFDFB1, self, undefined, undefined, 1, undefined, 1);

      foreach(player in scripts\mp\utility\teams::getteamdata(attacker.team, "players")) {
        if(player != attacker)
          player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199", undefined, undefined, _id_4B5A99C16ABFDFB1, self, undefined, undefined, 1, undefined, 1);
      }
    }
  }

  scripts\cp_mp\challenges::vehiclekilled(self, attacker, damage, objweapon);
  wait 0.35;
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

_id_822A21DC99EAF90D() {
  level endon("game_ended");
  self waittill("death");
  _id_75EA56AC509FED3B = getscriptcachecontents("wheelson", 0);
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  foreach(_id_5B63AED4A779B0AA in _id_75EA56AC509FED3B) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
    spawned = _id_7E52B56769FA7774::spawnpickup(_id_5B63AED4A779B0AA, _id_CB4FAD49263E20C4);

    if(isDefined(spawned))
      spawned setscriptablepartstate(_id_5B63AED4A779B0AA, "dropped");
  }
}

_id_744623B9952A9DC0() {
  self endon("death");
  level endon("game_ended");
  _id_03807E28E9F5CD57 = 0;
  _id_C02EEA4B304A5921 = undefined;
  _id_5D939698BFB74937 = 5;

  for(;;) {
    if(istrue(self._id_DF9D4533B4C32B50) || istrue(self._id_12BFB031C0A0EFD8)) {
      wait 0.25;
      continue;
    }

    _id_4586E4603EE41CDE = self._id_80C53303FB317FE2;
    scripts\mp\killstreaks\remotetank::_id_D8FF9AB17CBA9862();

    if(isDefined(self._id_80C53303FB317FE2)) {
      if(!isDefined(_id_4586E4603EE41CDE))
        self _meth_77320E794D35465A(_func_906E53C2FB9D3F9C("p2p", "pause"));

      _id_C02EEA4B304A5921 = self._id_80C53303FB317FE2 gettagorigin("j_mainroot");
      self setturrettargetEnt(self._id_80C53303FB317FE2, _id_C02EEA4B304A5921 - self._id_80C53303FB317FE2.origin);

      while(scripts\mp\killstreaks\remotetank::_id_44208C5A6449E697(self._id_80C53303FB317FE2) && !_id_05323B44EE395058::_id_BB61346FDA4278E5(self, self._id_80C53303FB317FE2, "j_mainroot", 5)) {
        _id_C02EEA4B304A5921 = self._id_80C53303FB317FE2 gettagorigin("j_mainroot");
        waitframe();
      }

      if(isPlayer(self._id_80C53303FB317FE2))
        _id_031CA5DBBE353500 = self._id_80C53303FB317FE2 scripts\cp_mp\utility\player_utility::_isalive();
      else
        _id_031CA5DBBE353500 = isalive(self._id_80C53303FB317FE2);

      if(_id_031CA5DBBE353500) {
        _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];
        firetime = weaponfiretime(_id_A84CFD847DC1F677.weaponinfo);
        _id_3746EC1BEFD86AE8 = _id_A84CFD847DC1F677.burstmin;
        _id_3E92CD336A99CE02 = _id_A84CFD847DC1F677.burstmax;
        _id_5F622C39D6661B23 = _id_A84CFD847DC1F677.pausemin;
        _id_42AE243CD994C3BD = _id_A84CFD847DC1F677.pausemax;
        _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);
        scripts\mp\killstreaks\remotetank::_id_416E1C2F79FCE693(_id_A84CFD847DC1F677);

        while(_id_89F949A75D92E1A4 > 0) {
          if(!isDefined(self._id_80C53303FB317FE2) || istrue(self._id_DF9D4533B4C32B50)) {
            break;
          }

          if(isPlayer(self._id_80C53303FB317FE2)) {
            if(!self._id_80C53303FB317FE2 scripts\cp_mp\utility\player_utility::_isalive()) {
              break;
            }
          } else if(!isalive(self._id_80C53303FB317FE2)) {
            break;
          }

          if(scripts\mp\killstreaks\remotetank::_id_44208C5A6449E697(self._id_80C53303FB317FE2)) {
            _id_C02EEA4B304A5921 = self._id_80C53303FB317FE2 gettagorigin("j_mainroot");
            self setturrettargetEnt(self._id_80C53303FB317FE2, _id_C02EEA4B304A5921 - self._id_80C53303FB317FE2.origin);
          } else if(isDefined(_id_C02EEA4B304A5921))
            self setturrettargetvec(_id_C02EEA4B304A5921);

          self fireweapon();
          _id_89F949A75D92E1A4--;
          wait(firetime);
        }

        _id_5D939698BFB74937 = 5;
        wait(randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD));
      }

      continue;
    }

    if(isDefined(_id_4586E4603EE41CDE)) {
      self _meth_77320E794D35465A(_func_906E53C2FB9D3F9C("p2p", "resume"));

      if(!isDefined(_id_C02EEA4B304A5921))
        _id_C02EEA4B304A5921 = _id_4586E4603EE41CDE.origin;
    }

    if(isDefined(_id_C02EEA4B304A5921) && _id_5D939698BFB74937 > 0) {
      _id_5D939698BFB74937--;
      _id_7F96D62F3ABBF9B9 = _id_C02EEA4B304A5921 - self.origin;
      _id_03807E28E9F5CD57++;
      _id_03807E28E9F5CD57 = _id_03807E28E9F5CD57 % 2;
      _id_36CF8F99B5548452 = scripts\engine\utility::ter_op(_id_03807E28E9F5CD57 == 0, -1, 1);
      _id_7F96D62F3ABBF9B9 = rotatevector(_id_7F96D62F3ABBF9B9, (0, 65 * _id_36CF8F99B5548452, 0));
      self setturrettargetvec(self.origin + _id_7F96D62F3ABBF9B9);
    } else {
      scripts\mp\killstreaks\remotetank::_id_6ADD0F629E59F222();
      _id_941D89BD45430FF7 = randomfloatrange(-5 + 180 * _id_03807E28E9F5CD57, 5 + 180 * _id_03807E28E9F5CD57);
      _id_03807E28E9F5CD57++;
      _id_03807E28E9F5CD57 = _id_03807E28E9F5CD57 % 2;
      targetangles = (0, _id_941D89BD45430FF7, 0);
      _id_C0686995758526DE = anglesToForward(targetangles);
      start = self.origin + (0, 0, 16);
      end = start + 1000.0 * _id_C0686995758526DE;
      self setturrettargetvec(end);
    }

    scripts\engine\utility::waittill_any_timeout_1(2.0, "turret_on_target");
    wait 0.25;
  }
}

_id_95B81D49D4CC38AB(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  if(isagent(attacker)) {
    return;
  }
  if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback))
    self[[level.vehicles.damagecallback]](inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid);
  else
    self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname);
}

_id_E4A9C1492C383E08(pos) {
  _id_D17C5900F5FD0FEA = spawnscriptable("dmz_boss_trapper_wheelson", pos, (0, 0, 0));
  _id_D17C5900F5FD0FEA.capturetime = 1;
  _id_D17C5900F5FD0FEA.curorigin = _id_D17C5900F5FD0FEA.origin;
  _id_D17C5900F5FD0FEA.offset3d = (0, 0, 15);
  _id_D17C5900F5FD0FEA scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  objid = _id_D17C5900F5FD0FEA.objidnum;
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(objid, _id_D17C5900F5FD0FEA.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_datacenter_hack");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
  scripts\mp\objidpoolmanager::objective_show_progress(objid, 1);
  scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);
  scripts\mp\objidpoolmanager::_id_17DB39BD195CC5B1(objid);
  scripts\mp\objidpoolmanager::_id_F21E9B2E78DE984B(objid, 1200, 1300);
  return _id_D17C5900F5FD0FEA;
}

_id_32D0F3B0D7FC69B6(_id_D17C5900F5FD0FEA) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_D17C5900F5FD0FEA.origin = self.origin;
    scripts\mp\objidpoolmanager::update_objective_position(_id_D17C5900F5FD0FEA.objidnum, _id_D17C5900F5FD0FEA.origin + (0, 0, 15));
    waitframe();
  }
}

_id_1C9955A4730D4C9E() {
  self.interact setscriptablepartstate("wheelson_hack_point", "usable");
  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(self.interact.objidnum);
  self.interact._id_E8BE8ABA7B9F7DF5 = 1;
}

_id_319D2227EC7BC841() {
  if(istrue(self.destroyed)) {
    return;
  }
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.interact.objidnum);
  self.interact setscriptablepartstate("wheelson_hack_point", "unusable");
  self.interact._id_E8BE8ABA7B9F7DF5 = 0;
}

_id_10A948F6954B0385(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level endon("game_ended");

  if(state == "usable") {
    instance setscriptablepartstate(part, "unusable_hacking");
    instance.teams = [player.team];
    instance thread _id_2222389508939FB4(player);
    wait 1.0;
  }
}

_id_2222389508939FB4(hacker) {
  level endon("game_ended");
  _id_C5C6ECF6F8F9C5F5 = 100;
  self.progress = 0;
  _id_90FB369A18926018 = [];
  self.hacker = hacker;
  _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(hacker.team, "players");

  for(;;) {
    if(isalive(hacker) && hacker useButtonPressed() && distance2dsquared(self.origin, hacker.origin) < squared(_id_C5C6ECF6F8F9C5F5))
      self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
    else {
      progress = 0;
      self.progress = 0;
      _id_90FB369A18926018 = _id_43D2F27B124E5276([], _id_90FB369A18926018, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);
      self setscriptablepartstate("wheelson_hack_point", "usable");
      return;
    }

    progress = self.progress / self.capturetime;
    _id_90FB369A18926018 = _id_43D2F27B124E5276(_id_7273312620004BC3, _id_90FB369A18926018, progress);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

    if(self.progress >= self.capturetime) {
      _id_DB90E3F3628EE19C();
      return;
    }

    if(!istrue(self._id_8B5682BB8AAE1441))
      self._id_8B5682BB8AAE1441 = 1;

    waitframe();
  }
}

_id_43D2F27B124E5276(_id_78122E18403A8DC4, _id_90FB369A18926018, progress) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      if(scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.objidnum, player, 1, 2, &"DMZ/BOSS_TRAPPER_WHEELSON_HACK_PROGRESS")) {
        scripts\mp\objidpoolmanager::objective_pin_player(self.objidnum, player);
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
        _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      }

      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_DB90E3F3628EE19C() {
  _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(self.hacker.team, "players");

  if(isDefined(self.hacker) && !scripts\engine\utility::array_contains(self._id_F5E7C5E12051B3EB._id_1329597B4278AFE9, self.hacker.team))
    self._id_F5E7C5E12051B3EB._id_1329597B4278AFE9[self._id_F5E7C5E12051B3EB._id_1329597B4278AFE9.size] = self.hacker.team;

  _id_6A8EC730B2BFA844::_id_5E98EB5DE21B3A8C(self.hacker);

  foreach(player in _id_7273312620004BC3) {
    objective_removeclientfrommask(self.objidnum, player);
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
  }

  wait 15;

  if(istrue(self.destroyed) || istrue(self.emp))
    self setscriptablepartstate("wheelson_hack_point", "usable");
}