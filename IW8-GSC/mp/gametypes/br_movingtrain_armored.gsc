/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_movingtrain_armored.gsc
***************************************************/

init() {
  level.validateattacker = ::_id_14642;
  level._id_13BD1 = ::helidrivabledeathall;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7", ::helidrivabledeath);
  totalweaponxpearned();
  teleport_trigger_to_airplane();
  teleport_to_debug_start_pos();
  tr_kiosksearchparams();
  thread _id_11B37();
  level thread exfil_smoke_vfx();
  level thread enemy_targets_headshot();
}

totalweaponxpearned() {
  foreach(var_1 in level._id_145F1._id_13C8D) {
    var_1.team = run_openexfil_spawn();
    var_1.wz_tease.team = run_openexfil_spawn();
  }
}

helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }
  radiusdamage(self.origin, 256, 100, 100, play_ac130_approach_scene(), "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_95E70D8EDBDA85F5839CED35F5B683");
}

helidrivabledeath(var_0, var_1, var_2, var_3) {
  if(var_2 == "_encstr_A2E60C6BC099B7E1A0A93A398F48") {
    var_4 = scripts\common\utility::playersincylinder(var_0, var_1);

    if(!isDefined(var_3))
      var_3 = 1;

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_6) || var_6.team == self.team) {
        continue;
      }
      if(isDefined(var_6.waittill_target_group_complete))
        var_7 = scripts\engine\utility::ter_op(var_6 get_alt_weapon(), var_3, 0);
      else
        var_7 = var_3;

      _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(var_6, var_2, var_7);

      if(var_7)
        var_6.waittill_target_group_complete = gettime();
    }
  } else
    _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbulletpenetration(var_0, var_1, var_2, var_3);
}

get_alt_weapon() {
  if(self.heli_orbit_logic.size > 4)
    return 0;

  if(self.waittill_target_group_complete + 10000 > gettime())
    return 0;

  return 1;
}

teleport_trigger_to_airplane() {
  var_0 = [["_encstr_B40101", 1, "_encstr_B40101", level._effect["_encstr_8175195BB08AD7AA7538802AAF6132B3308047DB50E325A1B9CB8B"]], ["_encstr_A67B2C9B5BB0FB7F6841672D9B3089DB40096182FB680B7208CB5E17B97B4E0F79ED4BBA83DDEFAFD0DB4937B380", 1, "_encstr_B60703EA9F", level._effect["_encstr_AB542004A7BB87794257E08A6F641037128D708DFCF34B863CC7401867852E791A73"]], ["_encstr_B40101", 0.5, "_encstr_B4070327CD", undefined], ["_encstr_B40101", 0, "_encstr_9507038C66", undefined], ["_encstr_BDF729503ECEFB47C9D2F9D2B029316BCD8DEFC2B696BBCA8360F2098017762FD8E04C71CC79CF97A3485A", 0, "_encstr_84670547C3E9F4", undefined]];
  level._id_14637 = _id_127E8(var_0);
  var_0 = [["_encstr_B40101", 1, "_encstr_B40101", level._effect["_encstr_BE831A53B882CFB27D30B8221803FBABC958B3C3D959297BCFB3C4AB"], 0], ["_encstr_8F7A29CB7A011D41800221B86FAC5E717A97D05EC2B9FB6B7D4770E023C7F385527C30481EB265D367837A", 1, "_encstr_B60703EA9F", level._effect["_encstr_86B8240B5FB031FEF3A7118D8FEABE884173B0C3891388AE59531B2B8F528DA148DA5ED8AC6C"], 0], ["_encstr_A37A2923A510DBDDF0AA71C5B8E8DFB2509137B3CDB81282B02832CFF1993C0BBF236BCF57DF6B5CF9517A", 0.66, "_encstr_B4070327CD", level._effect["_encstr_97AE2467CCE1D74C4EFAE1C8FA5837E60BBAB147D76C1627BE8CB0B616EC59FA1823AF34D23A"], 1], ["_encstr_997A293C23FAD959A1C1EBB696D8EBD8B9327DC49CAF589C6BB793568C7DA39CC24BB9AF362CE41DFAC843", 0.33, "_encstr_9507038C66", undefined, 1], ["_encstr_B40101", 0, "_encstr_8E440A950FE01BB76E96BDE6", undefined, 1], ["_encstr_93952B1B42A7AB78F03AEED009A9E8D3BE2D2F96AD876B6A2F58CEC70DEF1C48AA1F3D16DF7A5BA5391F355AF7", 0, "_encstr_84670547C3E9F4", undefined, 1]];
  level._id_14636 = _id_127E8(var_0);
  level._id_14635 = 0;
  var_0 = [["_encstr_B40101", 1, "_encstr_B40101"], ["_encstr_B40101", 0.5, "_encstr_B40101"], ["_encstr_B40101", 0, "_encstr_B40101"]];
  level._id_14638 = _id_127E8(var_0);
}

tr_kiosksearchparams() {
  var_0 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_3, var_2 in level._id_145F1._id_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      continue;
    }
    var_2.wz_tease.isvalidpos = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_2.wz_tease.isvalidpos setModel("_encstr_B1B429EB5A213D61A02241D80FCC7E519A77F07EA2D9F14B917FB051170B3383731DDD68BFD2A711748F4A" + var_3);
    var_2.wz_tease.isvalidpos linkTo(var_2.wz_tease, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  }
}

_id_127E8(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.model = var_3[0];
    var_4.get_request_backup_alias = var_3[1];
    var_4.statename = var_3[2];
    var_4.completex1stashquest = var_3[3];
    var_4._id_12C2B = var_3[4];
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_11B37() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_87A91F7BCF98D9CF2A93033A1808378E6895C8F563D0DB7BC7A93B31C0D767C728", 1700);
  var_1 = getdvarint("_encstr_A64A2843F642C98C9B93AD93FF82C018E74E0858DBB1584D20AFA5C9E79A916088EAB1734AECA87BBADB", 3150);
  var_2 = var_0 + 0;
  tr_ontimerexpired(1, var_2, var_1);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  totaldata();
  tr_ontimerexpired(level.players.size, var_2, var_1);
  level._id_145F1.brmodifyvehicledamage = getdvarint("_encstr_A3921FF79F72E927EB99CAA17B1029D24D308923E1D83792BA3ABAC9ED6EAA30E5", 0);
  level._id_145F1.usedcountinveh = 0;
  level._id_14640 = [];
  fail_mission_if_killed();
}

tr_ontimerexpired(var_0, var_1, var_2) {
  level._id_145F1._id_11B56 = var_0 * var_1;
  level._id_145F1._id_11B61 = var_0 * var_2;
  var_3 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_5 in level._id_145F1._id_13C8D) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_3) {
      var_5.wz_tease.get_remaining_bots = level._id_145F1._id_11B61;
      var_5.wz_tease.lightsfx = 0;
    } else {
      var_5.wz_tease.get_remaining_bots = level._id_145F1._id_11B56;
      var_5.wz_tease.lightsfx = 0;
    }

    var_5.wz_tease.stadium_one_death_func = 1;
  }

  var_7 = level._id_145F1._id_13C8D.size - 1;
  level._id_145F1._id_11B7A = var_7 * level._id_145F1._id_11B56;
}

teleport_to_debug_start_pos() {
  var_0 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_3, var_2 in level._id_145F1._id_13C8D) {
    var_2.wz_tease.lb_wood_surf_dmg_scalar = -1;

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      var_2.wz_tease setCanDamage(1);
      var_2.wz_tease thread setup_weapon_spawns();
    } else {
      var_2.wz_tease setCanDamage(1);
      var_2.wz_tease thread handledamage();
    }

    var_2.wz_tease._id_13CC5 = var_3;
    var_2.wz_tease._id_11E95 = 1;
    var_2.wz_tease._id_1217A = 0;
  }
}

totaldata() {
  var_0 = getdvarfloat("_encstr_91F919B98DC9FA3C23FAB50B0FFA19B0D62CB356EB392BEE2CE4C8", 135000.0);
  level._id_13735 = [30000, 45000, 60000, 75000, 100000, var_0];
  level._id_13736 = ["_encstr_876210B5CD9633CAAF1363D5951CC9D29B3A", "_encstr_AA381558EB60B5E302D062B93B65CFAED85BD2C37F106A", "_encstr_A6E609C01E537A38C1B866", "_encstr_ADF90CB75935329D50F9C26FD863", "_encstr_8A010F8349D34F3690337363C368F1D326", "_encstr_91CB10D82C368D4BCDCED8B0398CCD7D0FC8"];
  level._id_13737 = [];
  var_1 = level.squaddata;

  if(scripts\mp\menus::brking_updateteamscore()) {
    var_1 = [];
    var_1["_encstr_9A8507BA4040188D08"] = level.squaddata["_encstr_9A8507BA4040188D08"];
  }

  foreach(var_7, var_3 in var_1) {
    level._id_13737[var_7] = [];

    foreach(var_5 in var_3) {
      if(var_5.players.size == 0) {
        continue;
      }
      level._id_13737[var_7][var_5.index] = spawnStruct();
      level._id_13737[var_7][var_5.index]._id_13BEE = 0;
      level._id_13737[var_7][var_5.index]._id_11E72 = 0;
    }
  }
}

initmarker() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_955B15437A0DF36608950F39BD202DFFB710BA2BE0E86F");
  var_0 = level._id_145F1._id_13C8D[0];
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tape_machine_animations("_encstr_B6CF1857B4EBD6837DC49CBE385AB976AF4B8DED37FAC38CEB47", "_encstr_AF5A081BBAC993AC73A3", var_0.origin + (0, 0, 300));
  objective_removeallfrommask(var_0.objectiveiconid);
  var_0 thread _id_13FF4();
  var_0 thread _id_13FF3();
  var_0 thread _id_13FF5();
}

_id_13FF5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = 4500;

    foreach(var_2 in level.players) {
      var_3 = distance2d(removespecialistbonus(), var_2.origin);

      if(var_3 > var_0 && isalive(var_2)) {
        if(!isDefined(var_2._id_1337B) || var_2._id_1337B == 0) {
          var_2 _id_1335F();
          var_2._id_1337B = 1;
        }

        continue;
      }

      if(istrue(var_2._id_1337B)) {
        var_2 spawn_crew();
        var_2._id_1337B = 0;
      }
    }

    wait 1;
  }
}

removespecialistbonus() {
  return (level._id_145F1._id_13C8D[3].origin + level._id_145F1._id_13C8D[4].origin) / 2;
}

_id_13FF4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!scripts\mp\flags::gameflag("_encstr_8D1A130FC87D1D39B0A5DCFAC8596E3A93EDBC2B91")) {
    var_0 = removespecialistbonus();
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DB0(var_0 + (0, 0, 300));
    waitframe();
  }
}

_id_1335F() {
  var_0 = level._id_145F1._id_13C8D[0];
  objective_addclienttomask(var_0.objectiveiconid, self);
  objective_showtoplayersinmask(var_0.objectiveiconid);
}

spawn_crew() {
  var_0 = level._id_145F1._id_13C8D[0];
  objective_removeclientfrommask(var_0.objectiveiconid, self);
  objective_showtoplayersinmask(var_0.objectiveiconid);
}

_id_13FF3() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_8D1A130FC87D1D39B0A5DCFAC8596E3A93EDBC2B91");
  _id_12C0D();
}

_id_12C0D() {
  var_0 = level._id_145F1._id_13C8D[0];
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdropedtime();
}

run_openexfil_spawn() {
  if(scripts\mp\menus::brking_updateteamscore())
    return "_encstr_8E8405EA382B2A";

  return "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8";
}

handledamage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_10, var_10, var_11);

    if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == run_openexfil_spawn() && !istrue(var_1._id_1217A)) {
      continue;
    }
    if(self.brdisabledamagestattracking > 0 || self.lb_wood_surf_dmg_scalar < 1) {
      continue;
    }
    if(getdvarint("_encstr_8D4B13E1C8D756E6161336CAD798362D376D7D990F", 1) && !istrue(var_1._id_11E95))
      thread enemy_think(0);

    var_12 = var_1;

    if(isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      var_0 = setupmissionwidget(var_1);

      if(isDefined(var_1.owner))
        var_12 = var_1.owner;
    }

    var_13 = self.get_remaining_bots;
    self.get_remaining_bots = int(max(self.get_remaining_bots - var_0, 0));

    if(var_13 > 0) {
      if(isPlayer(var_12)) {
        if(self.get_remaining_bots <= 0)
          var_12 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B48B0F8CB830F8DA37499BBAAD66022960", 0, 0, "_encstr_B48B0F8CB830F8DA37499BBAAD66022960", 0, 1);
        else
          var_12 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_92B50AD0A5A3D0CA2C8C1E46", 0, 0, "_encstr_92B50AD0A5A3D0CA2C8C1E46", 0, 1);

        var_14 = int(min(var_0, var_13));
        _id_13FCF(var_12, var_14);
      }

      _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::equipprimarypickup(var_1, var_0);
    }

    if(getgametypekillsperhouravg())
      getblueprintforpickupweapon();
  }
}

setup_weapon_spawns() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_979F19207BC154C29EF797A7F9B39B95191B9BAD68B8F27A6699BF");
  level endon("_encstr_845010B99B42E3283F7FC11B63FAE823FA2B");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_10, var_10, var_11);

    if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == run_openexfil_spawn() && !istrue(var_1._id_1217A)) {
      continue;
    }
    if(getdvarint("_encstr_8D4B13E1C8D756E6161336CAD798362D376D7D990F", 1) && !istrue(var_1._id_11E95))
      thread enemy_think(0);

    var_12 = var_1;

    if(isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      var_0 = setupmissionwidget(var_1);

      if(isDefined(var_1.owner))
        var_12 = var_1.owner;
    }

    var_13 = self.get_remaining_bots;
    self.get_remaining_bots = int(max(self.get_remaining_bots - var_0, 0));

    if(var_13 > 0) {
      if(isPlayer(var_12)) {
        var_12 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A2FB098A2035874AB0F358", self.get_remaining_bots == 0, 0, "_encstr_A5AE098ADB583E0AF7A5AB", 0, 1);
        var_14 = int(min(var_0, var_13));
        _id_13FCF(var_12, var_14);
      }

      _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::equipprimarypickup(var_1, var_0);
    }

    if(getkothlocations())
      getbombteam();
  }
}

setupmissionwidget(var_0) {
  var_1 = spawnStruct();
  var_1.ent = [var_0, self];
  var_1.velocity = [var_0 vehicle_getvelocity(), self.velocity];
  var_2 = _encstr_A2F9283B6136B70AB8C7075DD93A97DFD1D9C303AB050715E0ED7F558FD8DC1B0C53DB0A10683A7F5037::setup_hacks(var_1);

  if(var_2 > 0)
    var_2 = clamp(var_2, 0.0, 3000);

  return var_2;
}

_id_13CCD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D1A130FC87D1D39B0A5DCFAC8596E3A93EDBC2B91");
  level._id_145F1.usedcountinveh = 1;
  var_0 = getdvarint("_encstr_BD7F23AB1EBA3174730B052B571AA8B0497591050716F8AEFA8F132993608DC00C0A1BB9EB", 30);
  wait(var_0);
  var_1 = level._id_14636.size - 2;
  var_2 = level._id_14638.size - 1;
  var_3 = level._id_14637.size - 2;
  var_4 = level._id_145F1._id_11B56 * 0.02;
  var_5 = level._id_145F1._id_11B7C * 0.02;
  var_6 = level._id_145F1._id_11B61 * 0.02;

  foreach(var_9, var_8 in level._id_145F1._id_13C8D)
  var_8.wz_tease._id_1217A = 1;

  for(;;) {
    foreach(var_9, var_8 in level._id_145F1._id_13C8D) {
      var_11 = var_8.wz_tease;

      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == level._id_145F1.cargo_truck_mg_create._id_119A4) {
        if(var_11.lb_wood_surf_dmg_scalar < var_3)
          var_11 dodamage(var_6, var_11.origin, var_11, var_11, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
        else
          break;
      } else {
        if(var_11.brdisabledamagestattracking > 0) {
          if(isDefined(var_11.frontturret) && var_11.frontturret.lb_wood_surf_dmg_scalar < var_2)
            var_11.frontturret dodamage(var_5, var_11.frontturret.origin, var_11, var_11, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");

          if(isDefined(var_11.rearturret) && var_11.rearturret.lb_wood_surf_dmg_scalar < var_2)
            var_11.rearturret dodamage(var_5, var_11.rearturret.origin, var_11, var_11, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");

          continue;
        }

        if(var_11.lb_wood_surf_dmg_scalar < var_1)
          var_11 dodamage(var_4, var_11.origin, var_11, var_11, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
      }
    }

    wait 1;
  }
}

_id_13FCF(var_0, var_1) {
  var_2 = level._id_13737[var_0.team][var_0.squadindex]._id_13BEE;
  var_3 = level._id_13735[level._id_13735.size - 1];

  if(var_2 < var_3) {
    level._id_13737[var_0.team][var_0.squadindex]._id_13BEE = min(var_2 + var_1, var_3);
    _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::fadeoutoverlay(var_0);

    while(isDefined(level._id_13735[level._id_13737[var_0.team][var_0.squadindex]._id_11E72]) && level._id_13737[var_0.team][var_0.squadindex]._id_13BEE >= level._id_13735[level._id_13737[var_0.team][var_0.squadindex]._id_11E72])
      _id_13F1A(level._id_13737[var_0.team][var_0.squadindex]._id_11E72, level.squaddata[var_0.team][var_0.squadindex].players, var_0);
  }
}

_id_13F1A(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4.squadindex == var_2.squadindex)
      var_4 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4(level._id_13736[var_0]);
  }

  level._id_13737[var_2.team][var_2.squadindex]._id_11E72++;
}

getgametypekillsperhouravg() {
  var_0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var_0 >= level._id_14636.size - 1)
    return 0;

  var_1 = self.get_remaining_bots / level._id_145F1._id_11B56;

  if(var_1 > level._id_14636[var_0].get_request_backup_alias)
    return 0;

  return 1;
}

getblueprintforpickupweapon() {
  var_0 = self.get_remaining_bots / level._id_145F1._id_11B56;

  for(var_1 = level._id_14636.size - 2; self.lb_wood_surf_dmg_scalar < var_1 && var_0 <= level._id_14636[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias; self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var_1))) {}

  caclulate_track_distance(self.lb_wood_surf_dmg_scalar);

  if(self.lb_wood_surf_dmg_scalar == var_1) {
    extract_removemissionweapon();
    thread explosion();
  }
}

caclulate_track_distance(var_0) {
  self.lb_wood_surf_dmg_scalar = var_0;
  var_1 = level._id_14636[self.lb_wood_surf_dmg_scalar];

  if(var_1.model != "_encstr_B40101")
    self setModel(var_1.model);

  if(var_1.statename != "_encstr_B40101")
    self setscriptablepartstate("_encstr_A29B05E9400E5D", var_1.statename);

  if(isDefined(var_1.completex1stashquest))
    self.completex1stashquest = var_1.completex1stashquest;

  if(isDefined(self.isvalidpos) && self.lb_wood_surf_dmg_scalar >= 4) {
    self.isvalidpos delete();
    self.isvalidpos = undefined;
  }

  lbravo_actor_keep_anim_loop();

  if(istrue(var_1._id_12C2B)) {
    if(isDefined(self.frontturret))
      self.frontturret has_started_cache_defenses();

    if(isDefined(self.rearturret))
      self.rearturret has_started_cache_defenses();
  }

  if(self.lb_wood_surf_dmg_scalar == 1)
    level notify("_encstr_9B580FC6B039F59D5DB1B995E4B0268D59");

  _id_1402A(self._id_13CC5, self.lb_wood_surf_dmg_scalar);
}

calculateandvalidatefuelstability(var_0) {
  self.lb_wood_surf_dmg_scalar = var_0;
  var_1 = level._id_14637[self.lb_wood_surf_dmg_scalar];

  if(var_1.model != "_encstr_B40101")
    self setModel(var_1.model);

  if(var_1.statename != "_encstr_B40101")
    self setscriptablepartstate("_encstr_A29B05E9400E5D", var_1.statename);

  if(isDefined(var_1.completex1stashquest))
    self.completex1stashquest = var_1.completex1stashquest;

  _id_13FED(self.lb_wood_surf_dmg_scalar);
}

_id_119A6() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread exterior_goal_func("_encstr_B14726208A257FCA028FEDE6895730B70F7238E0D2B1B38263D4784866BFF893757938C03A12DB5B", self, 4);
  f11scriptlightinit();
  wait 5;
  calculateandvalidatefuelstability(level._id_14637.size - 1);
  lastdeathheadiconforenemy();
  _id_13C9D();
}

explosion() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = play_ac130_approach_scene();
  self._id_1293B = 1;
  thread _id_13FD6();
  wait 5;
  self._id_1293B = 0;
  caclulate_track_distance(level._id_14636.size - 1);

  foreach(var_2 in level.players)
  var_2 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B6A51213E4F51E647DC2E45BB79C2B8CF5B10B4E");

  thread _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extractquest_helipadid();
  lastdeathheadiconforenemy();
  level._id_14635 = level._id_14635 + 1;
  level notify("_encstr_8C880E13DF23177FABC0136B38CB77B3");
  getrandompointinboundscircle();
  thread _id_13E62();
  wait 0.1;
  var_4 = scripts\mp\utility\player::getplayersinradius(self.origin, 1500);

  foreach(var_2 in var_4) {
    if(onteamproximitybecameinvalidplayer(var_2))
      var_2 _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extratimeincreasecountcap(4);
  }

  _id_13CCA();
  level._id_145F1.instance++;
  self.mediumstatehealthratio = _id_1327C();
}

onteamproximitybecameinvalidplayer(var_0) {
  var_1 = ["_encstr_A2B40B8E2C3B7DDB274B9D4B37", "_encstr_A1CF0F1DC2767DCC39ED733AFA4CB0B956", "_encstr_A27E0E439879C7BB6B1732618E0BE385", "_encstr_99FA098E169DD7331EC066", "_encstr_83FA09472C3BD7CCE10398"];
  var_2 = var_0.origin + (0, 0, var_0 getplayerviewheight());
  var_3 = [self, var_0];
  var_4 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);

  foreach(var_6 in var_1) {
    if(!self tagexists(var_6)) {
      return;
    }
    var_7 = self gettagorigin(var_6);

    if(scripts\engine\trace::ray_trace_passed(var_7, var_2, var_3, var_4))
      return 1;
  }

  return 0;
}

lbravo_actor_keep_anim_loop() {
  var_0 = 750;
  var_1 = self.origin;
  var_2 = self.angles + (-90, 0, 0);
  var_3 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);
  var_4 = physics_capsulecast(var_1, var_1, 200, var_0 / 2, var_2, var_3, [], "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = var_7["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_8)) {
      var_5[var_5.size] = var_8;

      if(onteamproximitybecameinvalidplayer(var_8))
        var_8 dodamage(250, self.origin, self, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    }
  }

  var_10 = scripts\mp\utility\player::getplayersinradius(self.origin, 750, undefined, var_5);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12) || !onteamproximitybecameinvalidplayer(var_12)) {
      continue;
    }
    var_13 = distancesquared(var_12.origin, self.origin);

    if(var_13 < squared(550))
      var_14 = 90;
    else
      var_14 = 50;

    var_12 dodamage(var_14, self.origin, self, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  }
}

_id_1327C() {
  var_0 = 700;
  var_1 = 85;
  var_2 = anglesToForward(self.angles) * 350;
  var_3 = anglestoup(self.angles) * 30;
  var_4 = self.origin + var_2 + var_3;
  var_5 = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", var_4, 0, var_1, var_0);
  var_5.angles = self.angles + (-90, 0, 0);
  var_5.burnid = scripts\mp\equipment\molotov::molotov_get_next_burning_id();
  var_5.playersintrigger = [];
  var_5.traincar = self;
  var_5 enablelinkTo();
  var_5 linkTo(self);
  var_5 thread mercywintriggered();
  var_5 thread method_for_calling_reinforcemen();
  var_5 thread hangar_juggs();
  return var_5;
}

mercywintriggered() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_845010B99B42E3283F7FC11B63FAE823FA2B");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    var_1 = var_0 getentitynumber();

    if(isDefined(self.playersintrigger[var_1])) {
      continue;
    }
    self.playersintrigger[var_1] = var_0;
    var_0 mercymatchending_time(var_0, undefined, undefined, self.burnid);
  }
}

method_for_calling_reinforcemen() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_845010B99B42E3283F7FC11B63FAE823FA2B");

  for(;;) {
    foreach(var_2, var_1 in self.playersintrigger) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }
      if(var_1 istouching(self)) {
        continue;
      }
      self.playersintrigger[var_2] = undefined;
      var_1 scripts\mp\equipment\molotov::molotov_stop_burning(self.burnid);
    }

    waitframe();
  }
}

mercymatchending_time(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\equipment\molotov::molotov_get_burning_info(1);

  if(!isDefined(var_3))
    var_3 = scripts\mp\equipment\molotov::molotov_get_next_burning_id();

  var_5 = scripts\mp\equipment\molotov::molotov_get_burning_source(var_0, var_1, var_2, var_4, var_3, 1);
  var_6 = 0;

  if(var_5.count <= 0)
    var_6 = 1;

  var_5.count++;

  if(var_6)
    thread mercymatchending_nuke();
}

mercymatchending_nuke() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_977F0FBA0EC8B0A3CAF589AB27735A379D");
  self endon("_encstr_977F0FBA0EC8B0A3CAF589AB27735A379D");
  thread scripts\mp\equipment\molotov::molotov_cleanup_burning();
  var_0 = scripts\mp\equipment\molotov::molotov_get_burning_info();

  if(gettime() <= var_0.updatetimestamp)
    waitframe();

  for(;;) {
    var_0 = scripts\mp\equipment\molotov::molotov_get_burning_info();
    var_1 = undefined;

    foreach(var_3 in var_0.sources) {
      if(var_3 scripts\mp\equipment\molotov::molotov_burning_source_is_valid()) {
        if(!isDefined(var_1) || var_3.id > var_1)
          var_1 = var_3.id;

        continue;
      }

      var_0.sources[var_3.id] = undefined;
    }

    if(isDefined(var_1)) {
      var_0.timeoff = 0;
      var_0.timeon = var_0.timeon + 0.05;
      var_3 = var_0.sources[var_1];
      var_5 = 15;
      var_6 = undefined;
      var_7 = var_3.attacker.origin;

      if(isDefined(var_3.inflictor)) {
        var_6 = var_3.inflictor;
        var_7 = var_3.inflictor.origin;
      }

      if(var_0.timetodamage <= 0) {
        self dodamage(var_5, var_7, var_3.attacker, var_6, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_BA730BF8AFF178988293F158B9");
        var_0.firstdamagedone = 1;
        var_0.timetodamage = 0.25;
      } else {
        if(!var_0.firstdamagedone) {
          self dodamage(var_5, var_7, var_3.attacker, var_6, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_BA730BF8AFF178988293F158B9");
          var_0.firstdamagedone = 1;
        }

        var_0.timetodamage = var_0.timetodamage - 0.05;
      }
    } else {
      var_0.timeoff = var_0.timeoff + 0.05;

      if(var_0.timeoff >= 0.25)
        thread scripts\mp\equipment\molotov::molotov_clear_burning();
    }

    var_0.updatetimestamp = gettime();
    wait 0.05;
  }
}

hangar_juggs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_845010B99B42E3283F7FC11B63FAE823FA2B");

  foreach(var_2, var_1 in self.playersintrigger)
  var_1 scripts\mp\equipment\molotov::molotov_stop_burning(self.burnid);

  self.traincar.mediumstatehealthratio = undefined;
  self delete();
}

_id_13FD6() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;

  while(self._id_1293B) {
    if(isDefined(var_0))
      var_0 delete();

    var_0 = getmaxobjectivecount(self.origin[0], self.origin[1], 1500);
    var_0 setmapcirclecolorindex(0);
    var_0 setmapcirclestyleindex(0);
    wait 0.5;
  }

  var_0 delete();
}

lastdeathheadiconforenemy() {
  foreach(var_1 in level._id_145F1._id_13C8D) {
    if(var_1.wz_tease == self) {
      if(isDefined(var_1.num_hackers)) {
        var_1.num_hackers delete();
        break;
      }
    }
  }
}

run_module_unpause_funcs() {
  var_0 = 0;

  foreach(var_3, var_2 in level._id_145F1._id_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == level._id_145F1.cargo_truck_mg_create._id_119A4)
      continue;
    else
      var_0 = var_0 + var_2.wz_tease.get_remaining_bots;
  }

  return var_0;
}

getkothlocations() {
  var_0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var_0 >= level._id_14637.size - 1)
    return 0;

  var_1 = self.get_remaining_bots / level._id_145F1._id_11B61;

  if(var_1 > level._id_14637[var_0].get_request_backup_alias)
    return 0;

  return 1;
}

getbombteam() {
  var_0 = self.get_remaining_bots / level._id_145F1._id_11B61;

  for(var_1 = level._id_14637.size - 2; self.lb_wood_surf_dmg_scalar < var_1 && var_0 <= level._id_14637[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias; self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var_1))) {}

  calculateandvalidatefuelstability(self.lb_wood_surf_dmg_scalar);

  if(self.lb_wood_surf_dmg_scalar == var_1) {
    thread _id_13E62();
    level notify("_encstr_BEF510D8921FDB50909D398583786BA3F3E5");
    extract_removemissionweapon();
    thread _id_119A6();
  }
}

register_vehicle_as_ambient() {
  var_0 = [];
  var_1 = level._id_14636.size - 1;

  foreach(var_4, var_3 in level._id_145F1._id_13C8D) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == level._id_145F1.cargo_truck_mg_create._id_119A4)
      continue;
    else if(var_3.wz_tease.lb_wood_surf_dmg_scalar < var_1)
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

getrandompointinboundscircle() {
  var_0 = 0;
  var_1 = level._id_14636.size - 1;

  foreach(var_4, var_3 in level._id_145F1._id_13C8D) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == level._id_145F1.cargo_truck_mg_create._id_119A4)
      continue;
    else if(var_3.wz_tease.lb_wood_surf_dmg_scalar < var_1)
      var_0++;
  }

  if(var_0 == 0)
    _id_119A5();
}

_id_119A5() {
  scripts\mp\flags::gameflagset("_encstr_979F19207BC154C29EF797A7F9B39B95191B9BAD68B8F27A6699BF");
  var_0 = level._id_145F1._id_13C8D[0].wz_tease;
  var_0 extractioncomplete();
  var_0 calculateandvalidatefuelstability(1);
}

_id_13C9D() {
  scripts\mp\flags::gameflagset("_encstr_8D1A130FC87D1D39B0A5DCFAC8596E3A93EDBC2B91");

  foreach(var_1 in level.players)
  var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8BE416151B21EB4ABFFBA3D9A466E92D7AF7A1BDD7EB3D80");

  level._id_145F1._id_13C8D[0].wz_tease.frontturret _id_13E63();
}

_id_1402A(var_0, var_1) {
  if(var_1 == 0) {
    return;
  }
  var_2 = 3;
  var_3 = var_0 * var_2;
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_B6941453D161A096D723DB7EDA5BC518430F89F35456", var_3, var_2, var_1);
}

_id_13FED(var_0) {
  var_1 = 3;
  var_2 = 0;
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_B6941453D161A096D723DB7EDA5BC518430F89F35456", var_2, var_1, var_0);
}

_id_1402D(var_0, var_1, var_2) {
  var_3 = 2;
  var_4 = var_3 * 2;
  var_5 = (var_0 - 1) * var_4 + var_1 * var_3;
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_B2EC16D3C83FE6B39E535A3FE583D7ADC1E14AEA481B117A", var_5, var_3, var_2);
}

enemy_rushdown_player() {
  ent_cleanup(level._id_145F1.brmodifyvehicledamage * level._id_14639);
}

ent_cleanup(var_0) {
  var_1 = 7;
  var_2 = var_0;
  var_3 = [];
  var_4 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_7, var_6 in level._id_145F1._id_13C8D) {
    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == var_4) {
      continue;
    }
    var_3[var_3.size] = var_6.wz_tease;
  }

  while(var_1 > 0 && var_2 > 0) {
    var_8 = var_0 / var_1;
    var_9 = 0;
    var_1 = 0;

    foreach(var_7, var_11 in var_3) {
      if(var_8 >= var_11.get_remaining_bots) {
        if(isDefined(var_11.lightsfx) && !var_11.lightsfx) {
          var_9 = var_9 + (var_8 - var_11.get_remaining_bots);
          var_11.lightsfx = 1;
        }
      } else
        var_1++;

      var_11 dodamage(var_8, var_11.origin, var_11);
    }

    var_2 = var_9;
  }

  var_4 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_7, var_11 in var_3)
  var_11.lightsfx = 0;
}

entityhit() {
  var_0 = spawnStruct();
  var_0.streakname = "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  var_0.owner = self;
  var_0.score = 0;
  var_0.shots_fired = 0;
  var_0.hits = 0;
  var_0.damage = 0;
  var_0.kills = 0;
  var_0._id_121A9 = "_encstr_97901DB71389F8E0E75AAE5373E3AB485FA7330BBB6AE8B9EF91E03BE9E3FE";
  var_0._id_121A8 = "_encstr_AF521D6D9BF58EDEDA85FA374727B4B6AC7D1B1B5D9B47ACC97DB683FA1E23";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE"))
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE")]](var_0, "_encstr_A2E60C6BC099B7E1A0A93A398F48");

  return var_0;
}

ents_to_clean_up(var_0) {
  if(var_0 == "_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220" || var_0 == "_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0")
    return level._effect["_encstr_926724331B0B190172FE20FED8F17D51608DC975ED1A201AC5E37E17188B68092DC4194BA3CB"];

  if(var_0 == "_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8" || var_0 == "_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E")
    return level._effect["_encstr_AC262175FE8869BE4371723399B36E40645E9FF97572487563AB6E6AD78FA9F9FCA141"];

  return undefined;
}

entry_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_1, var_5);
  var_7 setModel(var_6);
  var_7.team = run_openexfil_spawn();
  var_7.angles = var_2;
  var_7.turreton = 1;
  var_7.name = var_3;
  var_7.momentum = 0;
  var_7.attackingtarget = undefined;
  var_7._id_14258 = var_0.name;
  var_7._id_12CB3 = 15;
  var_7._id_11C78 = "_encstr_97910BA3154320F8EBBA8811A2";
  var_7._id_11C77 = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  var_7.weaponname = var_5;
  var_7.health = level.turretsettings[var_5].health;
  var_7.maxhealth = level.turretsettings[var_5].maxhealth;
  var_7._id_1407D = 1;
  var_7._id_12161 = 0;
  var_7.completex1stashquest = ents_to_clean_up(var_5);
  var_7 linkTo(var_0.wz_tease, var_4, (0, 0, 0), (0, 0, 0));
  var_7 setturretteam(run_openexfil_spawn());
  var_7 setturretmodechangewait(0);
  var_7 setmode(var_7._id_11C78);
  var_7 makeunusable();
  var_7 maketurretinoperable();
  var_7 setconvergenceheightpercent(level.turretsettings[var_5]._id_132BE);
  var_7 setdefaultdroppitch(0.0);
  var_7 setCanDamage(1);
  var_7 setnodeploy(1);
  var_7 setautorotationdelay(1);
  var_7 setconvergencetime(level.turretsettings[var_5]._id_14681, "_encstr_AF1904C7E3A4");
  var_7 setconvergencetime(level.turretsettings[var_5]._id_12381, "_encstr_BD6506F36A2B46B0");
  var_7.damagecenter = var_7.origin + (0, 0, 10);
  var_7._id_13E91 = var_4;
  var_7.lb_wood_surf_dmg_scalar = 0;
  var_7.brking_getcenterofcircle = 1;
  var_7.helperdrone_isbeingpingedbydrone = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7.origin);
  var_7.helperdrone_isbeingpingedbydrone.team = var_7.team;
  var_7.helperdrone_isbeingpingedbydrone linkTo(var_7, "_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D", (0, 0, 0), (0, 0, 0));
  var_7.helperdrone_isbeingpingedbydrone.juggernaut_update_hint_logic = var_2;
  var_7.helperdrone_isbeingpingedbydrone setModel(var_6);
  var_7.helperdrone_isbeingpingedbydrone hide();
  var_7 thread _id_13E80();
  var_7 thread _id_13E7E();

  if(var_5 != "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38")
    var_7 thread _id_13E6E();

  level._id_14640[level._id_14640.size] = var_7;
  return var_7;
}

extractcountdown(var_0, var_1, var_2, var_3) {
  var_4 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_1.origin, var_2);
  var_4 setModel(var_3);
  var_4 linkTo(var_0.wz_tease, var_1._id_13E91, (0, 0, 0), (0, 0, 0));
  var_4.team = var_1.team;
  var_4.angles = var_1.angles;
  var_4.turreton = var_1.turreton;
  var_4.name = var_1.name;
  var_4.momentum = var_1.momentum;
  var_4.attackingtarget = var_1.attackingtarget;
  var_4._id_14258 = var_1._id_14258;
  var_4._id_12CB3 = var_1._id_12CB3;
  var_4._id_11C78 = var_1._id_11C78;
  var_4._id_11C77 = var_1._id_11C77;
  var_4.weaponname = var_2;
  var_4.health = var_1.health;
  var_4.maxhealth = var_1.maxhealth;
  var_4._id_1407D = var_1._id_1407D;
  var_4._id_12161 = var_1._id_12161;
  var_4.completex1stashquest = ents_to_clean_up(var_2);
  var_4 setturretteam(var_1.team);
  var_4 setturretmodechangewait(0);
  var_4 setmode(var_4._id_11C78);
  var_4 makeunusable();
  var_4 maketurretinoperable();
  var_4 setconvergenceheightpercent(level.turretsettings[var_1.weaponname]._id_132BE);
  var_4 setdefaultdroppitch(0.0);
  var_4 setCanDamage(1);
  var_4 setnodeploy(1);
  var_4 setautorotationdelay(1);
  var_4 setconvergencetime(level.turretsettings[var_1.weaponname]._id_14681, "_encstr_AF1904C7E3A4");
  var_4 setconvergencetime(level.turretsettings[var_1.weaponname]._id_12381, "_encstr_BD6506F36A2B46B0");
  var_4.damagecenter = var_1.damagecenter;
  var_4._id_13E91 = var_1._id_13E91;
  var_4.lb_wood_surf_dmg_scalar = var_1.lb_wood_surf_dmg_scalar;
  var_4.helperdrone_isbeingpingedbydrone = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
  var_4.helperdrone_isbeingpingedbydrone.team = var_4.team;
  var_4.helperdrone_isbeingpingedbydrone linkTo(var_4, "_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D", (0, 0, 0), (0, 0, 0));
  var_4.helperdrone_isbeingpingedbydrone.juggernaut_update_hint_logic = var_1.angles;
  var_4.helperdrone_isbeingpingedbydrone setModel(var_3);
  var_4.helperdrone_isbeingpingedbydrone hide();
  var_4 thread _id_13E80(3);
  var_4 thread _id_13E7E();

  if(var_2 != "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38" && var_2 != "_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0")
    var_4 thread _id_13E6E();

  level._id_14640[level._id_14640.size] = var_4;
  return var_4;
}

extraction_balloon_total_plunder() {
  foreach(var_2, var_1 in level._id_145F1._id_13C8D) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == level._id_145F1.cargo_truck_mg_create._id_119A4)
      continue;
    else {
      var_1.wz_tease.frontturret extractioncomplete();
      var_1.wz_tease.rearturret extractioncomplete();
    }
  }
}

extractioncomplete() {
  self._id_12161 = 0;
  self.outlineid = scripts\mp\utility\outline::outlineenableforall(self, "_encstr_8CA31542B0DBE04C98FD293935206868F193D79F310395", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
}

extract_removemissionweapon() {
  self._id_12161 = 1;
  scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
}

entmantlingendtime() {
  var_0 = spawnStruct();
  var_0._id_13E89 = "_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220";
  var_0.turretmodel = "_encstr_8A65298719F5CEB234C1F5B55AC6F51B9B23FA269CEBD14EB04B37EB47579C27CA479BFAD9584736B473CE";
  var_1 = spawnStruct();
  var_1._id_13E89 = "_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8";
  var_1.turretmodel = "_encstr_B27C262393E17E4541D7B0E97845FFA49092A95A6A4F0BFBE3503EE8B3605BD095E88651D2EA499F";
  var_2 = spawnStruct();
  var_2._id_13E89 = "_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123";
  var_2.turretmodel = "_encstr_B2722888CEC92BF390179EE5B240E7F9D2DA51196B801B63F17868F6798020D3EDDB7017332003E5C7BB";
  var_3 = spawnStruct();
  var_3._id_13E89 = "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38";
  var_3.turretmodel = "_encstr_A5182C43E7F8560AA0906F012415F9CC882CA9AA98782B6BB1D86889E303C3332F6937A71398F82729D589594B53";
  return [[var_3], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0]];
}

enter_numbers_start() {
  var_0 = spawnStruct();
  var_0._id_13E89 = "_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0";
  var_0.turretmodel = "_encstr_8A65298719F5CEB234C1F5B55AC6F51B9B23FA269CEBD14EB04B37EB47579C27CA479BFAD9584736B473CE";
  var_1 = spawnStruct();
  var_1._id_13E89 = "_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E";
  var_1.turretmodel = "_encstr_B27C262393E17E4541D7B0E97845FFA49092A95A6A4F0BFBE3503EE8B3605BD095E88651D2EA499F";
  var_2 = spawnStruct();
  var_2._id_13E89 = "_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0";
  var_2.turretmodel = "_encstr_A5182C43E7F8560AA0906F012415F9CC882CA9AA98782B6BB1D86889E303C3332F6937A71398F82729D589594B53";
  return [[var_2], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0], [var_1, var_1], [var_0, var_0]];
}

fail_mission_if_killed() {
  var_0 = getdvarint("_encstr_974222BA09F03F2B6AB983C7EB18D16CA0B3728743F9CD824981F37BEB3EE9BCB8BA2FCA", 1050);
  var_1 = level.players.size * var_0;
  level._id_145F1._id_11B7C = var_1;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"] = spawnStruct();
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"].health = var_1;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"].maxhealth = var_1;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"].burst = 20;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"]._id_12212 = 1;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"].lockstrength = 3;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"].spinuptime = 0.1;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"].cooldowntime = 0.3;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"]._id_13A84 = 3500;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"]._id_132BE = 0.65;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"]._id_14681 = 0.35;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"]._id_12381 = 0.35;
  level.turretsettings["_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220"].weaponinfo = "_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220";
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"] = spawnStruct();
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"].health = var_1;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"].maxhealth = var_1;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"].burst = 20;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"]._id_12212 = 0.1;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"].lockstrength = 3;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"].spinuptime = 0.1;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"].cooldowntime = 0.3;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"]._id_13A84 = 3500;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"]._id_132BE = 0.65;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"]._id_14681 = 0.35;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"]._id_12381 = 0.35;
  level.turretsettings["_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0"].weaponinfo = "_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0";
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"] = spawnStruct();
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"].health = var_1;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"].maxhealth = var_1;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"].burst = 1;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"]._id_12212 = 3.5;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"].lockstrength = 3;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"].spinuptime = 0.4;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"].cooldowntime = 0.1;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"]._id_13A84 = 4500;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"]._id_132BE = 0.1;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"]._id_14681 = 1;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"]._id_12381 = 1;
  level.turretsettings["_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8"].weaponinfo = "_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8";
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"] = spawnStruct();
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"].health = var_1;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"].maxhealth = var_1;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"].burst = 1;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"]._id_12212 = 0.9;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"].lockstrength = 3;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"].spinuptime = 0.4;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"].cooldowntime = 0.1;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"]._id_13A84 = 4500;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"]._id_132BE = 0.1;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"]._id_14681 = 1;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"]._id_12381 = 1;
  level.turretsettings["_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E"].weaponinfo = "_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E";
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"] = spawnStruct();
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].health = var_1;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].maxhealth = var_1;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].burst = 1;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"]._id_12212 = 20;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].lockstrength = 6;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].spinuptime = 1;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].cooldowntime = 1;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"]._id_13A84 = 5000;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"]._id_132BE = 0.2;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"]._id_14681 = 1;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"]._id_12381 = 1;
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].weaponinfo = "_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123";
  level.turretsettings["_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123"].streakinfo = entityhit();
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"] = spawnStruct();
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"].health = var_1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"].maxhealth = var_1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"].burst = 1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"]._id_12212 = 2;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"].lockstrength = 3;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"].spinuptime = 1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"].cooldowntime = 0.1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"]._id_13A84 = 4500;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"]._id_132BE = 0.1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"]._id_14681 = 1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"]._id_12381 = 1;
  level.turretsettings["_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38"].weaponinfo = "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38";
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"] = spawnStruct();
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"].health = var_1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"].maxhealth = var_1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"].burst = 1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"]._id_12212 = 0.7;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"].lockstrength = 3;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"].spinuptime = 1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"].cooldowntime = 0.1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"]._id_13A84 = 4500;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"]._id_132BE = 0.1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"]._id_14681 = 1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"]._id_12381 = 1;
  level.turretsettings["_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0"].weaponinfo = "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38";
  var_2 = entmantlingendtime();

  foreach(var_8, var_4 in level._id_145F1._id_13C8D) {
    var_5 = var_2[var_8];

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level._id_145F1.cargo_truck_mg_create._id_119A4) {
      var_4.wz_tease.frontturret = entry_open(var_4, var_4.wz_tease gettagorigin("_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260"), var_4.angles, "_encstr_9BAF0D33C9DEE68EAF47BAC9C956A3", "_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260", var_5[0]._id_13E89, var_5[0].turretmodel);
      var_4.wz_tease.frontturret.traincar = var_4.wz_tease;
      var_4.wz_tease.brdisabledamagestattracking = 1;
      continue;
    }

    var_6 = (0, 0, 0);
    var_7 = (0, 180, 0);
    var_4.wz_tease.frontturret = entry_open(var_4, var_4.wz_tease gettagorigin("_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260"), var_4.angles + var_6, "_encstr_9BAF0D33C9DEE68EAF47BAC9C956A3", "_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260", var_5[0]._id_13E89, var_5[0].turretmodel);
    var_4.wz_tease.rearturret = entry_open(var_4, var_4.wz_tease gettagorigin("_encstr_8AA1104B5B2461E420CBE22FE3992A1A8FD5"), var_4.angles + var_7, "_encstr_B4F50CE49516C9BE47D593392BE8", "_encstr_8AA1104B5B2461E420CBE22FE3992A1A8FD5", var_5[1]._id_13E89, var_5[1].turretmodel);
    var_4.wz_tease.frontturret.traincar = var_4.wz_tease;
    var_4.wz_tease.rearturret.traincar = var_4.wz_tease;
    var_4.wz_tease.brdisabledamagestattracking = 2;
  }
}

_id_13E80(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_921D09D9D9C0090D7275B4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    wait(var_0);

  var_1 = level.turretsettings[self.weaponname];
  var_2 = var_1.cooldowntime;

  for(;;) {
    if(!istrue(self.turreton)) {
      waitframe();
      continue;
    }

    var_3 = _id_13E6B();

    if(isDefined(var_3)) {
      self.currenttarget = var_3;
      _id_13E68(var_3);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
    }

    wait 0.05;
  }
}

_id_13E6B() {
  var_0 = level.turretsettings[self.weaponname];
  var_1 = var_0._id_13A84;
  var_2 = var_1 * var_1;
  var_3 = self.origin + anglesToForward(self.angles) * var_1;
  var_4 = scripts\common\utility::playersinsphere(var_3, var_1);
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_4) {
    var_9 = _id_13E72(var_8);

    if(!istrue(var_9)) {
      continue;
    }
    var_10 = self gettagorigin("_encstr_91E80B3A2CCE7D262C4E9359D8");
    var_11 = var_8.origin;
    var_12 = distancesquared(var_10, var_11);

    if(!isDefined(var_5) && !isDefined(var_6) || var_12 < var_6) {
      var_5 = var_8;
      var_6 = var_12;
    }
  }

  return var_5;
}

_id_13E72(var_0) {
  var_1 = 1;

  if(!isDefined(var_0))
    var_1 = 0;
  else if(!scripts\mp\utility\player::isreallyalive(var_0))
    var_1 = 0;
  else if(scripts\mp\utility\player::unset_relic_trex(var_0))
    var_1 = 0;
  else if(isDefined(var_0.play_disguise_vo))
    var_1 = 0;
  else if(!_id_13E5E(var_0))
    var_1 = 0;

  return var_1;
}

_id_13E7C(var_0) {
  var_1 = level.turretsettings[self.weaponname];
  var_2 = var_1._id_13A84;
  var_3 = var_2 * var_2;

  if(!_id_13E72(var_0))
    return 0;

  if(distancesquared(self gettagorigin("_encstr_91E80B3A2CCE7D262C4E9359D8"), var_0.origin) > var_3)
    return 0;

  return 1;
}

_id_13E5E(var_0) {
  var_1 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];
  var_2 = self gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_3 = var_0.origin + (0, 0, var_0 getplayerviewheight());
  var_4 = vectorNormalize(var_3 - var_2);
  var_5 = vectorNormalize(anglesToForward(self.angles));
  var_6 = [self, var_0];
  var_6 = scripts\engine\utility::array_combine(var_6, level._id_14640);
  var_7 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_8 = var_0 scripts\cp_mp\utility\player_utility::isinvehicle();

  if(istrue(var_8)) {
    var_9 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();
    var_6[var_6.size] = var_9;
    var_10 = var_9 getlinkedchildren();

    if(isDefined(var_10) && var_10.size > 0)
      var_6 = scripts\engine\utility::array_combine(var_6, var_10);
  }

  for(var_11 = 0; var_11 < var_1.size; var_11++) {
    if(scripts\engine\trace::ray_trace_passed(var_2, var_3, var_6, var_7) && vectordot(var_5, var_4) > cos(120))
      return 1;
  }

  return 0;
}

_id_13E71(var_0) {
  var_1 = self gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_2 = var_0.origin;
  var_3 = vectorNormalize(var_2 - var_1);
  var_4 = vectorNormalize(anglesToForward(self gettagangles("_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D")));

  if(vectordot(var_4, var_3) > 0.3)
    return 1;

  return 0;
}

_id_13E68(var_0) {
  self settargetentity(var_0);
  self.attackingtarget = var_0;
  _id_13E79();
  _id_13E5C(var_0);
  _id_13E5D();
  self cleartargetentity();
  self.currenttarget = undefined;
}

_id_13E79() {
  self laseron();
  var_0 = level.turretsettings[self.weaponname];

  while(istrue(self.turreton) && self.momentum < var_0.spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

_id_13E78() {
  self laseroff();
  self.momentum = 0;
}

_id_13E5C(var_0) {
  self endon("_encstr_921D09D9D9C0090D7275B4");
  var_1 = level.turretsettings[self.weaponname];
  var_2 = var_1.burst;
  var_3 = var_1._id_12212;
  var_4 = var_1.lockstrength;

  while(istrue(self.turreton) && _id_13E7C(var_0)) {
    for(var_5 = 0; var_5 < var_2; var_5++) {
      if(istrue(self.turreton) && _id_13E7C(var_0) && _id_13E71(var_0)) {
        if(self.weaponname == "_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123") {
          var_6 = var_1.streakinfo;
          _id_11D2C(self.origin, var_0.origin, var_6);
          self shootturret("_encstr_A14F0AE336178944BA076F41", var_4);
        } else {
          var_7 = weaponfiretime(var_1.weaponinfo);
          self shootturret("_encstr_A14F0AE336178944BA076F41", var_4);
          wait(var_7);
        }

        continue;
      }

      break;
    }

    wait(var_3);
  }
}

_id_13E5D() {
  _id_13E78();
}

_id_13E7E() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self)) {
    self.helperdrone_isbeingpingedbydrone delete();
    self delete();
  }
}

enemy_think(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self._id_12161)) {
    return;
  }
  var_1 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  if(var_0)
    var_1 = "_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D";

  if(isDefined(self.completex1stashquest))
    playFXOnTag(self.completex1stashquest, self, var_1);
}

_id_13E6E() {
  self endon("_encstr_BA7B12F653BAA9CD218F3810B755E0DD62FB60FE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_0, var_3, var_4, var_1, var_5, var_6);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == run_openexfil_spawn() && !istrue(var_0._id_1217A)) {
      continue;
    }
    if(getdvarint("_encstr_8D4B13E1C8D756E6161336CAD798362D376D7D990F", 1) && !istrue(var_0._id_11E95))
      thread enemy_think(1);

    var_7 = var_0;

    if(isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      if(isDefined(var_0.owner))
        var_7 = var_0.owner;
    }

    var_8 = var_2;

    if(self.health < 0)
      var_8 = var_8 + self.health;

    if(isPlayer(var_7)) {
      if(self.health <= 0)
        var_7 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_AF2311A0734B13E35D20FAE358F51EB3C1EF3B", 0, 1, "_encstr_AF2311A0734B13E35D20FAE358F51EB3C1EF3B", 0, 1);
      else
        var_7 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_91D70CB88F43EBA71A7B4DB37B5D", 0, 1, "_encstr_91D70CB88F43EBA71A7B4DB37B5D", 0, 1);

      var_9 = int(min(var_2, var_8));
      _id_13FCF(var_7, var_9);
    }

    _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::equipsecondarypickup(var_0, var_8);

    if(getrandompointinboundssafecircle())
      getc130airdropheight();

    if(self.health <= 0) {
      break;
    }
  }

  _id_13E63();
  self.traincar thread _id_13E85();
}

_id_13E63() {
  if(self.turreton) {
    if(self.health > 0) {
      self notify("_encstr_BA7B12F653BAA9CD218F3810B755E0DD62FB60FE");
      self.health = 0;
    }

    self.turreton = 0;
    self setmode(self._id_11C77);
    self cleartargetentity();
    self.attackingtarget = undefined;
    self notify("_encstr_921D09D9D9C0090D7275B4");
    self hide();

    if(isDefined(self.outlineid))
      extract_removemissionweapon();

    if(self.weaponname == "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38" || self.weaponname == "_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0") {
      self._id_127E6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      self._id_127E6 setModel("_encstr_9A331758BF494D694BEF8D05BA1B710121C26838C291B98043");
      self._id_127E6.angles = self.traincar.angles;
      self._id_127E6 linkTo(self.traincar, self._id_13E91);
      self._id_127E6 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_A6F60962E72762A73BBD53");
    } else {
      self._id_127E6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      self._id_127E6 setModel("_encstr_A36F12F046BEEC333CEB3ABA2793B247F583DB83");
      self._id_127E6.angles = self.traincar.angles;
      self._id_127E6 linkTo(self.traincar, self._id_13E91);
      self._id_127E6 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_A71904E89A72");
      self.isvalidpos = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      self.isvalidpos setModel("_encstr_95BB2E8746FAE456CE95168DEB1637E61657633AEB8D8527D747EA27C9593AE6EB46566E1D39F6CBAC8CBE9159B15836");
      self.isvalidpos.angles = self.traincar.angles;
      self.isvalidpos linkTo(self.traincar, self._id_13E91);
    }
  }
}

has_started_cache_defenses() {
  if(isDefined(self.isvalidpos)) {
    self.isvalidpos delete();
    self.isvalidpos = undefined;
  }

  if(isDefined(self._id_127E6)) {
    self._id_127E6 delete();
    self._id_127E6 = undefined;
  }
}

has_no_focus_fire_attackers(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = 5;

  wait(var_0);

  if(isDefined(self))
    self delete();
}

_id_13E62() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self.frontturret.turreton)
    self.frontturret _id_13E63();

  if(isDefined(self.rearturret) && self.rearturret.turreton)
    self.rearturret _id_13E63();

  self.frontturret kill();

  if(isDefined(self.rearturret))
    self.rearturret kill();

  if(isDefined(self.frontturret) || isDefined(self.rearturret)) {
    self.frontturret hide();
    self.frontturret.helperdrone_isbeingpingedbydrone hide();

    if(isDefined(self.rearturret)) {
      self.rearturret hide();
      self.rearturret.helperdrone_isbeingpingedbydrone hide();
    }

    wait 5;
    self.frontturret.helperdrone_isbeingpingedbydrone delete();
    self.frontturret delete();

    if(isDefined(self.rearturret)) {
      self.rearturret.helperdrone_isbeingpingedbydrone delete();
      self.rearturret delete();
    }
  }
}

getrandompointinboundssafecircle() {
  var_0 = self.lb_wood_surf_dmg_scalar + 1;

  if(var_0 >= level._id_14638.size)
    return 0;

  var_1 = self.health / self.maxhealth;

  if(var_1 > level._id_14638[var_0].get_request_backup_alias)
    return 0;

  return 1;
}

getc130airdropheight() {
  var_0 = self.health / self.maxhealth;

  for(var_1 = level._id_14638.size - 1; self.lb_wood_surf_dmg_scalar < var_1 && var_0 <= level._id_14638[self.lb_wood_surf_dmg_scalar + 1].get_request_backup_alias; self.lb_wood_surf_dmg_scalar = int(min(self.lb_wood_surf_dmg_scalar + 1, var_1))) {}

  calculatenumteamswithplayers(self.lb_wood_surf_dmg_scalar);
}

calculatenumteamswithplayers(var_0) {
  self.lb_wood_surf_dmg_scalar = var_0;
  var_1 = level._id_14638[self.lb_wood_surf_dmg_scalar];

  if(var_1.model != "_encstr_B40101")
    self setModel(var_1.model);

  if(var_1.statename != "_encstr_B40101")
    self setscriptablepartstate("_encstr_A29B05E9400E5D", var_1.statename);

  var_2 = scripts\engine\utility::ter_op(self == self.traincar.frontturret, 0, 1);
  _id_1402D(self.traincar._id_13CC5, var_2, self.lb_wood_surf_dmg_scalar);
}

_id_13E64() {
  var_0 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_2 in level._id_145F1._id_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      var_2.wz_tease.frontturret _id_13E63();
      continue;
    } else if(var_2.wz_tease.lb_wood_surf_dmg_scalar != level._id_14636.size - 1) {
      var_2.wz_tease.frontturret _id_13E63();
      var_2.wz_tease.rearturret _id_13E63();
    }
  }
}

_id_13E65() {
  if(!self.turreton) {
    self show();
    self.helperdrone_isbeingpingedbydrone hide();
    self.helperdrone_isbeingpingedbydrone setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_A18008BD35E222F01BD0");
    self.health = self.maxhealth;
    self setmode(self._id_11C78);
    self.turreton = 1;
    thread _id_13E80();

    if(self.weaponname != "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38")
      thread _id_13E6E();
  }
}

_id_13E66() {
  var_0 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_2 in level._id_145F1._id_13C8D) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0) {
      var_2.wz_tease.frontturret _id_13E65();
      continue;
    } else if(var_2.wz_tease.lb_wood_surf_dmg_scalar != level._id_14636.size - 1) {
      var_2.wz_tease.frontturret _id_13E65();
      var_2.wz_tease.rearturret _id_13E65();
    }
  }
}

fire_rate() {
  _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::f11scriptlighttoggle(0);
  var_0 = enter_numbers_start();

  foreach(var_7, var_2 in level._id_145F1._id_13C8D) {
    var_3 = var_0[var_7];

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == level._id_145F1.cargo_truck_mg_create._id_119A4) {
      var_4 = extractcountdown(var_2, var_2.wz_tease.frontturret, var_3[0]._id_13E89, var_3[0].turretmodel);
      var_2.wz_tease.frontturret.helperdrone_isbeingpingedbydrone delete();
      var_2.wz_tease.frontturret delete();
      var_2.wz_tease.frontturret = var_4;
      var_2.wz_tease.frontturret.traincar = var_2.wz_tease;
      continue;
    }

    if(isDefined(var_2.wz_tease.frontturret) && var_2.wz_tease.frontturret.turreton && var_2.wz_tease.frontturret.health > 0) {
      var_5 = extractcountdown(var_2, var_2.wz_tease.frontturret, var_3[0]._id_13E89, var_3[0].turretmodel);
      var_2.wz_tease.frontturret.helperdrone_isbeingpingedbydrone delete();
      var_2.wz_tease.frontturret delete();
      var_2.wz_tease.frontturret = var_5;
      var_2.wz_tease.frontturret.traincar = var_2.wz_tease;
      var_2.wz_tease.frontturret extractioncomplete();
      var_2.wz_tease.frontturret getc130airdropheight();
    }

    if(isDefined(var_2.wz_tease.rearturret) && var_2.wz_tease.rearturret.turreton && var_2.wz_tease.rearturret.health > 0) {
      var_6 = extractcountdown(var_2, var_2.wz_tease.rearturret, var_3[1]._id_13E89, var_3[1].turretmodel);
      var_2.wz_tease.rearturret.helperdrone_isbeingpingedbydrone delete();
      var_2.wz_tease.rearturret delete();
      var_2.wz_tease.rearturret = var_6;
      var_2.wz_tease.rearturret.traincar = var_2.wz_tease;
      var_2.wz_tease.rearturret extractioncomplete();
      var_2.wz_tease.rearturret getc130airdropheight();
    }
  }

  wait 2.5;
  level notify("_encstr_A5980C716326706D1B9BBDABBB43");
}

_id_11D2C(var_0, var_1, var_2) {
  var_3 = play_ac130_approach_scene();
  _id_132B3(var_3, var_0, var_1, var_2);
}

_id_13E85() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _id_13CCA();
  self.brdisabledamagestattracking = max(self.brdisabledamagestattracking - 1, 0);

  if(self.brdisabledamagestattracking == 0) {
    wait 0.2;
    caclulate_track_distance(1);
    extractioncomplete();

    if(!scripts\mp\flags::gameflag("_encstr_921513A8357660729EA3435B820B9266597F114A12")) {
      thread _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extratimeincreasecount(3, 0);
      wait 9;
      _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::fadeoutinspectatorsofplayer(1);
    }
  }
}

enemy_targets_headshot() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_979F19207BC154C29EF797A7F9B39B95191B9BAD68B8F27A6699BF");
  level waittill("_encstr_A5980C716326706D1B9BBDABBB43");
  _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::showsplash("_encstr_A9921DD562D9C81E7FDA5B21824FFD39ABDD7D6D1D7BC890BFF2D1A90A27A5");

  while(level._id_145F1._id_13CCA < 15)
    wait 0.2;

  level notify("_encstr_96730F07980BE1EB53ADC7F5185D83B193");
  _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::showsplash("_encstr_83A91A5EEE07AB22B9B7ADC20AC808455BE6FFBFE9D266BA6DD0E352");
}

_id_13CCA() {
  level._id_145F1._id_13CCA++;
  level notify("_encstr_8DAB150B9B028308B778073339F981431BE323D8B1E5B1");

  if(level._id_145F1._id_13CCA == 6)
    thread fire_rate();
}

round_vehicle_path_logic() {
  if(level._id_145F1._id_13CCA >= 21)
    var_0 = 0.5;
  else if(level._id_145F1._id_13CCA >= 15)
    var_0 = 1;
  else
    var_0 = 0;

  var_0 = getdvarfloat("_encstr_B66414BB1DAE67896DAF45FF26892AC04043923FF318", var_0);
  return var_0;
}

round_waittill_at_end_enemy_count() {
  if(level._id_145F1._id_13CCA >= 21)
    var_0 = 0.5;
  else if(level._id_145F1._id_13CCA >= 15)
    var_0 = 0.3;
  else
    var_0 = 0;

  var_0 = getdvarfloat("_encstr_85E811624F17D663032BB98332E108ADA312DA", var_0);
  return var_0;
}

exfil_smoke_vfx() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_845010B99B42E3283F7FC11B63FAE823FA2B");
  level endon("_encstr_BEF510D8921FDB50909D398583786BA3F3E5");

  for(;;) {
    if(level._id_145F1._id_13CCA < 15) {
      wait 0.5;
      continue;
    }

    level._id_145F1._id_1397C = [];
    var_0 = register_vehicle_as_ambient();

    if(var_0.size == 0) {
      var_1 = level._id_145F1._id_13C8D[0];
      var_1 thread enter_combat_after_call();
      wait(round_waittill_at_end_enemy_count());
    } else {
      foreach(var_3 in var_0) {
        var_3 thread enter_combat_after_call();
        wait(round_waittill_at_end_enemy_count());
      }
    }

    waitframe();
    wait(round_vehicle_path_logic());
  }
}

enter_combat_after_call() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_845010B99B42E3283F7FC11B63FAE823FA2B");
  level endon("_encstr_BEF510D8921FDB50909D398583786BA3F3E5");
  _encstr_879428B91BE4A5C1E89BE5ADE0F29DC2B6AC472F389537BC89E4EB9D58B556A3F20E95D7E191E276DCD8::extractionlocation();
  thread _id_1397A();
}

_id_1397A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_845010B99B42E3283F7FC11B63FAE823FA2B");
  level endon("_encstr_BEF510D8921FDB50909D398583786BA3F3E5");
  var_0 = play_ac130_approach_scene();
  var_1 = 0;
  var_2 = 1;

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\mp\utility\player::getplayersinradius(self.origin, 12000);

  foreach(var_5 in var_3) {
    if(var_1 >= var_2) {
      break;
    }

    if(!get_bomb_case_omnvar_value_based_on_color(var_5.origin)) {
      continue;
    }
    if(unset_slow_healthregen(var_5.origin)) {
      continue;
    }
    if(!_id_13E1C(var_5.origin)) {
      continue;
    }
    _id_132B3(var_0, self.origin, var_5.origin);
    var_1++;
  }

  var_7 = var_1;

  while(var_7 < var_2) {
    var_8 = getrandompointincircle(self.origin, 5000, 0.5);

    if(unset_slow_healthregen(var_8)) {
      continue;
    }
    if(!_id_13E1C(var_8)) {
      continue;
    }
    _id_132B3(var_0, self.origin, var_8);
    var_7++;
  }

  level notify("_encstr_A99117E122DAA03F97DBDD63A35F7E9866C74369143FF08DBB");
}

get_bomb_case_omnvar_value_based_on_color(var_0) {
  var_1 = gettime() - 500000;
  var_2 = scripts\mp\utility\player::getplayersinradius(var_0, 1200);

  foreach(var_4 in var_2) {
    var_5 = play_train_sequence(var_4);

    if(isDefined(var_5) && level._id_145F1._id_1397D[var_5].watch_for_player_in_los >= var_1)
      return 0;
  }

  return 1;
}

_id_13E1C(var_0) {
  var_1 = gettime();
  var_2 = var_1 - 500000;
  var_3 = scripts\mp\utility\player::getplayersinradius(var_0, 1200);

  foreach(var_5 in var_3) {
    var_6 = play_train_sequence(var_5);

    if(isDefined(var_6) && level._id_145F1._id_1397D[var_6].watch_for_player_in_los >= var_2)
      return 0;
  }

  foreach(var_5 in var_3) {
    var_6 = play_train_sequence(var_5);

    if(!isDefined(var_6)) {
      var_9 = spawnStruct();
      var_9.player = var_5;
      var_6 = level._id_145F1._id_1397D.size;
    } else
      var_9 = level._id_145F1._id_1397D[var_6];

    var_9.watch_for_player_in_los = var_1 + randomint(1000);
    level._id_145F1._id_1397D[var_6] = var_9;
  }

  return 1;
}

play_train_sequence(var_0) {
  foreach(var_3, var_2 in level._id_145F1._id_1397D) {
    if(var_2.player == var_0)
      return var_3;
  }

  return undefined;
}

unset_slow_healthregen(var_0) {
  foreach(var_2 in level._id_145F1._id_1397C) {
    var_3 = distance2d(var_0, var_2);

    if(var_3 <= 1200)
      return 1;
  }

  return 0;
}

_id_14642(var_0) {
  if(isagent(var_0)) {
    var_1 = play_ac130_approach_scene();

    if(var_1 != var_0) {
      if(!isDefined(var_0.isactive) || !var_0.isactive)
        return undefined;

      if(!isDefined(var_0.classname))
        return undefined;
    }
  }

  return var_0;
}

play_ac130_approach_scene() {
  var_0 = undefined;

  if(isDefined(level._id_13CC2))
    var_0 = level._id_13CC2;
  else {
    var_1 = scripts\engine\utility::array_reverse(level.agentarray);

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(isDefined(var_3.team) && var_3.team != "_encstr_8E8405EA382B2A") {
        continue;
      }
      if(!isDefined(var_3.team) && isDefined(var_3.agentteam)) {
        continue;
      }
      var_0 = var_3;
      var_0._id_1407D = 1;

      if(!isDefined(var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"]))
        var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"] = 0;

      break;
    }

    level._id_13CC2 = var_0;
  }

  return var_0;
}

_id_132B3(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = var_0 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A2E60C6BC099B7E1A0A93A398F48", var_0);

  var_3._id_11EAE = 1;
  var_3._id_11F47 = 1;
  var_3.vehicle_process_node_when_at_goal = 1;
  var_3._id_121A9 = "_encstr_97901DB71389F8E0E75AAE5373E3AB485FA7330BBB6AE8B9EF91E03BE9E3FE";
  var_3._id_121A8 = "_encstr_AF521D6D9BF58EDEDA85FA374727B4B6AC7D1B1B5D9B47ACC97DB683FA1E23";
  var_0.origin = var_2;
  var_0.angles = vectortoangles(var_2 - var_1);
  level._id_145F1._id_1397C = scripts\engine\utility::array_add(level._id_145F1._id_1397C, var_2);
  var_3._id_13A81 = var_2;
  var_0 thread scripts\cp_mp\killstreaks\toma_strike::starttomastrike(5, undefined, undefined, var_3);
}

getrandompointincircle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_1 <= 0.0)
    return var_0;

  var_7 = 0.0;

  if(isDefined(var_2))
    var_7 = var_2;

  var_8 = 1.0;

  if(isDefined(var_3))
    var_8 = var_3;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_6))
    var_6 = 360;

  var_9 = squared(var_1 * var_7);
  var_10 = squared(var_1 * var_8);
  var_11 = undefined;

  if(var_9 == var_10)
    var_11 = sqrt(var_9);
  else
    var_11 = sqrt(randomfloatrange(var_9, var_10));

  var_12 = var_5 + randomfloat(var_6 - var_5);
  var_13 = (var_11 * cos(var_12), var_11 * sin(var_12), 0);
  var_14 = var_0 + var_13;

  if(var_4) {
    var_15 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    var_14 = scripts\engine\utility::drop_to_ground((var_0[0], var_0[1], 400) + var_13, undefined, undefined, undefined, var_15);
  }

  return var_14;
}

exterior_goal_func(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_2);
  var_1 playsoundonmovingent(var_0);
}

f11scriptlightinit() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 setsoundsubmix("_encstr_8BE416151B21EB4ABFFBA3D9A466E92D7AF7A1BDD7EB3D80", 0.3);
  }
}