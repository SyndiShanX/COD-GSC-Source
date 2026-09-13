/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_deployable_kiosk.gsc
********************************************************/

main() {
  if(!getdvarint("scr_br_deployable_kiosk_enabled", 0)) {
    return;
  }
  _id_CE60E2DA53459A87();
  _id_041B95BCF009214F();
}

_id_CE60E2DA53459A87() {
  _id_610F57BDDD265BE2::_id_C592E91FC6604AD0();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("drone_deployable_kiosk", ::_id_208501A7029AB500);
  level._id_ED2DCA1658DA90B2 = spawnStruct();
  level._id_ED2DCA1658DA90B2.drones = [];
  level._id_ED2DCA1658DA90B2._id_53385B6BE5F6C52F = getdvarint("dvar_6AF9EA32F9FBBAA6", 200);
  level._id_ED2DCA1658DA90B2._id_406BFEEBFF3AA082 = getdvarint("dvar_7D6D2CB2D139A844", 5);
  level._id_ED2DCA1658DA90B2._id_2C40E29836434CBE = 0;
  level._id_ED2DCA1658DA90B2._id_11F0849A2C7B79CA = getdvarint("dvar_DC10F0E5E78347B4", 0) == 1;
  level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2 = [];
  level._id_ED2DCA1658DA90B2._id_FFE6C41436EFB0B2 = getdvarint("dvar_37C837989177C57C", 7);
  level._id_ED2DCA1658DA90B2._id_A03D33B617B44F0A = getdvarint("dvar_83B158696CBCBCFD", 0) == 1;
  level._id_ED2DCA1658DA90B2._id_1E8AF39FA33C422E = getdvarint("dvar_CDFD65A23B480AA1", 1) == 1;
  level._id_ED2DCA1658DA90B2._id_23C27E34B377C901 = getdvarint("dvar_B9D0BFE07133A6B8", 1) == 1;
  level._id_ED2DCA1658DA90B2._id_F298AD183EDD53EF = getdvarint("dvar_E0B32AD490E21930", 1) == 1;
  level._id_ED2DCA1658DA90B2._id_5944536D424AA063 = getdvarint("dvar_B2198E7C0B5206A8", 1) == 1;
  level._id_ED2DCA1658DA90B2._id_0338B4F24FC6601C = getdvarint("dvar_4C8E6F955528E47E", 52);
  level._id_ED2DCA1658DA90B2._id_C95CC1E87110D92D = getdvarint("dvar_AFA742B5487EF5A3", -9000);
  level._id_ED2DCA1658DA90B2._id_01A01D5E71D5A4CE = getdvarint("dvar_3CA0EEF1458F68A4", 1700);
  level._id_ED2DCA1658DA90B2._id_AAD8A9E2592CF1A5 = getdvarint("dvar_5881E1A607C924DB", 6500);
  level._id_ED2DCA1658DA90B2._id_8C3590379C7AB36F = getdvarint("dvar_3E56C6BBB230D4CD", 4000);
  level._id_ED2DCA1658DA90B2._id_90AA3A29F5C33DB3 = getdvarint("dvar_AF27E42CA35D8854", 200);
  level._id_ED2DCA1658DA90B2._id_35BBF066F50AC582 = getdvarint("dvar_422387A5D7B1948E", 512);
  level._id_ED2DCA1658DA90B2._id_8CF89663DC98483D = getdvarint("dvar_3B47B4EDAFA8E459", 40);
  level._id_ED2DCA1658DA90B2._id_3D4073DF2F497525 = getdvarfloat("dvar_2EC1C01324EA0E78", 9.0);
  level._id_ED2DCA1658DA90B2._id_E90F0FE1F275A8B6 = getdvarfloat("dvar_1F22AFFC058A4F7D", 0.0);
  level._id_ED2DCA1658DA90B2._id_AEEB98B4D36B65A6 = getdvarfloat("dvar_742372C71D3E7554", 0.0);
  level._id_ED2DCA1658DA90B2._id_1A19BD75A8860186 = getdvarint("dvar_56748969528A88E7", 0) == 1;
  level._id_4358D3A0EE13B0F9 = ::_id_590979EF771686A8;
  level._id_AE0244C4C517BA75 = ::_id_AA19007A48FCA6C0;
  level._id_FF4BBEB786042D78 = ::_id_FF4BBEB786042D78;
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(15, ::_id_1E28980B8235671E, ::_id_B77546749EB0C127, ::_id_313D9044D8E6F53C, ::_id_AD1B6F540C35705D);
  level._effect["deployable_kiosk_explosion"] = loadfx("vfx/iw9/prop/scriptables/vfx_military_deployable_buystation.vfx");
}

_id_041B95BCF009214F() {
  game["dialog"]["deploy_ready"] = "dpbs_wzan_redy";
  game["dialog"]["enemy_active"] = "dpbs_wzan_enm1";
  game["dialog"]["friendly_active"] = "dpbs_wzan_frnl";
}

_id_208501A7029AB500(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!istrue(instance.entity._id_98AABCA05601AA67)) {
    player playlocalsound("br_plunder_atm_cancel");
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/UNUSABLE_DEPLOYABLE_KIOSK");
    return;
  }

  instance._id_746C06C00CD6BDC5 = 1;
  player thread _id_4384ABBF498DF6A7::_runpurchasemenu(instance);
}

_id_590979EF771686A8(player, location) {
  owner = undefined;
  ownerteam = undefined;

  if(isDefined(player)) {
    owner = player;
    ownerteam = player.team;
  }

  _id_914F83DDF24BED51 = scripts\cp_mp\parachute::getc130height();
  _id_52C23ADAECC7756F = _id_2CEDCC356F1B9FC8::droptogroundmultitrace((location[0], location[1], _id_914F83DDF24BED51));

  if(istrue(level._id_ED2DCA1658DA90B2._id_1A19BD75A8860186)) {
    _id_4E4DF9CADA88AB11 = "[deployableKioskSpawned]: " + scripts\engine\utility::_id_53C4C53197386572(player.name, "-") + ", " + scripts\engine\utility::_id_53C4C53197386572(player getxuid(), "-") + ", " + scripts\engine\utility::_id_53C4C53197386572(player.team, "-") + ", " + scripts\engine\utility::_id_53C4C53197386572(player.origin[0], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(player.origin[1], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(player.origin[2], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(location[0], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(location[1], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(location[2], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(_id_52C23ADAECC7756F[0], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(_id_52C23ADAECC7756F[1], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(_id_52C23ADAECC7756F[2], scripts\engine\utility::string(0));
    logstring(_id_4E4DF9CADA88AB11);
  }

  _id_E64FDAE06DF3B0AA = undefined;

  if(level._id_ED2DCA1658DA90B2._id_23C27E34B377C901)
    _id_E64FDAE06DF3B0AA = _id_B8214CB8C9E75675(player, _id_52C23ADAECC7756F);

  _id_B0DEAB8543E2CA82 = spawnStruct();
  _id_B0DEAB8543E2CA82.origin = _id_52C23ADAECC7756F + (0, 0, level._id_ED2DCA1658DA90B2._id_01A01D5E71D5A4CE);

  if(isDefined(_id_E64FDAE06DF3B0AA))
    _id_B0DEAB8543E2CA82.dir = _id_E64FDAE06DF3B0AA;
  else
    _id_B0DEAB8543E2CA82.dir = _func_767CEA82B001F645(getclosestpointonnavmesh(_id_52C23ADAECC7756F) - _id_B0DEAB8543E2CA82.origin);

  _id_B0DEAB8543E2CA82.angles = generateaxisanglesfromforwardvector(_id_B0DEAB8543E2CA82.dir, (0, 0, 1));
  _id_F00FA6965D8D5DAD = _id_B0DEAB8543E2CA82.dir * level._id_ED2DCA1658DA90B2._id_C95CC1E87110D92D + (0, 0, level._id_ED2DCA1658DA90B2._id_AAD8A9E2592CF1A5);
  _id_B0DEAB8543E2CA82._id_9F925F5509626DF1 = (_id_F00FA6965D8D5DAD[0] + _id_B0DEAB8543E2CA82.origin[0], _id_F00FA6965D8D5DAD[1] + _id_B0DEAB8543E2CA82.origin[1], _id_F00FA6965D8D5DAD[2]);
  drone = spawn("script_model", _id_B0DEAB8543E2CA82._id_9F925F5509626DF1);
  drone._id_B0DEAB8543E2CA82 = _id_B0DEAB8543E2CA82;
  drone setModel("veh9_mil_air_drone_supply_sweep");
  drone.angles = (0, randomint(360), 0);
  drone.speed = 0;
  drone.health = level._id_ED2DCA1658DA90B2._id_53385B6BE5F6C52F;
  drone.maxhealth = drone.health;
  drone.owner = owner;
  drone.team = ownerteam;

  if(isDefined(player))
    drone setCanDamage(1);
  else
    drone setCanDamage(0);

  drone forcenetfieldhighlod(1);

  if(isDefined(player)) {
    scripts\mp\weapons::_id_E00B77A9CB4D8322(drone);
    drone thread _id_78966BC6B28DA9B4();
  }

  drone thread _id_88AD5BDDAFD52F6E();
  level._id_ED2DCA1658DA90B2.drones[level._id_ED2DCA1658DA90B2.drones.size] = drone;

  if(isDefined(player)) {
    _id_6D5ED003AF1F9612 = level.teamdata[player.team]["alivePlayers"];

    if(_id_6D5ED003AF1F9612.size > 0) {
      foreach(_id_AC0E424AC96A7113 in _id_6D5ED003AF1F9612) {
        if(!isDefined(_id_AC0E424AC96A7113)) {
          continue;
        }
        _id_AC0E424AC96A7113 thread scripts\mp\hud_message::showsplash("br_deployable_kiosk_incoming", undefined, drone.owner);
      }
    }
  }

  drone.spawnorigin = drone.origin;
  drone._id_D4CF75E8A617D80C = _id_B0DEAB8543E2CA82.origin;
  drone._id_DD4F599B9C56DB3A = location[0];
  drone._id_DD4F5A9B9C56DD6D = location[1];
  drone._id_DD4F579B9C56D6D4 = location[2];
  _id_A059CAB9DFE3D005 = 0;

  if(isDefined(player)) {
    _id_BBB0B7AF9811ACEF = scripts\mp\utility\teams::getteamdata(player.team, "alivePlayers");

    foreach(ent in _id_BBB0B7AF9811ACEF)
    _id_A059CAB9DFE3D005 = _id_A059CAB9DFE3D005 + ent.plundercount;
  }

  drone._id_6C90750B2BDE4F94 = _id_A059CAB9DFE3D005;
}

_id_B8214CB8C9E75675(player, location) {
  spawnangles = (0, 0, 0);

  if(!isDefined(player))
    spawnangles = (0, randomfloatrange(0, 360), 0);
  else
    spawnangles = player.angles;

  _id_D77253C873D2B420 = anglesToForward(spawnangles);
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(location - _id_D77253C873D2B420 * 30, location + _id_D77253C873D2B420 * 1000, undefined, contents);
  _id_6E7C70B904418DAA = trace["position"] + trace["normal"] * 20;
  targetpos = location;
  _id_359711DD322783EC = scripts\cp_mp\parachute::getc130height();
  _id_558047C7AC5A2D65 = anglesToForward(spawnangles);
  _id_3C5A1B26C6973C2A = anglestoright(spawnangles);
  _id_F74F18C717B149E2 = [targetpos + (-1 * _id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_3C5A1B26C6973C2A - _id_558047C7AC5A2D65) * 100, targetpos - _id_558047C7AC5A2D65 * 100, targetpos + _id_558047C7AC5A2D65 * 100, targetpos + _id_3C5A1B26C6973C2A * 100, targetpos - _id_3C5A1B26C6973C2A * 100, targetpos + (_id_558047C7AC5A2D65 + _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100];
  _id_D9323F93B3960E7C = vectorNormalize(_id_F74F18C717B149E2[2] - targetpos);
  _id_E3B1338D5BD4399F = 0;
  _id_601DA10886B0DA3D = 0;
  _id_A9DF94497D7DBDAF = 0;

  foreach(_id_F9567F37DB523F7A in _id_F74F18C717B149E2) {
    _id_7A7426E42E674E40 = vectorNormalize(_id_F9567F37DB523F7A - targetpos);
    _id_C45BBEB56DF09B5D = targetpos * (1, 1, 0) + (0, 0, _id_359711DD322783EC);
    _id_32A961DAC02545B0 = _id_C45BBEB56DF09B5D - _id_7A7426E42E674E40 * 24000;
    _id_19189FD85D8A2C19 = _id_C45BBEB56DF09B5D + _id_7A7426E42E674E40 * 24000;
    _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace_passed(_id_32A961DAC02545B0, _id_19189FD85D8A2C19, undefined, contents);

    if(!istrue(_id_1F0571D36D0DF95B)) {
      continue;
    }
    _id_48384E792726B96A = _id_C45BBEB56DF09B5D - _id_7A7426E42E674E40 * int(8000.0);
    _id_E313995ECAD6ABBC = [targetpos, targetpos - _id_7A7426E42E674E40 * 512, targetpos - _id_7A7426E42E674E40 * 256, targetpos + _id_7A7426E42E674E40 * 256, targetpos + _id_7A7426E42E674E40 * 512];
    _id_F0C12707E0CBB8D9 = 0;

    foreach(_id_27AC9F99FC2E7A9B in _id_E313995ECAD6ABBC) {
      results = scripts\engine\trace::ray_trace(_id_48384E792726B96A, _id_27AC9F99FC2E7A9B, undefined, contents);
      _id_1F0571D36D0DF95B = results["fraction"] == 1;

      if(!istrue(_id_1F0571D36D0DF95B)) {
        continue;
      }
      _id_F0C12707E0CBB8D9++;
    }

    if(_id_F0C12707E0CBB8D9 > _id_E3B1338D5BD4399F) {
      _id_D9323F93B3960E7C = _id_7A7426E42E674E40;
      _id_E3B1338D5BD4399F = _id_F0C12707E0CBB8D9;

      if(_id_F0C12707E0CBB8D9 >= 3) {
        break;
      }
    }
  }

  return _id_D9323F93B3960E7C;
}

_id_88AD5BDDAFD52F6E() {
  drone = self;
  level endon("game_ended");
  drone endon("entitydeleted");
  drone._id_1D3BF3B408DA503F = 0;

  if(level._id_ED2DCA1658DA90B2._id_2C40E29836434CBE) {}

  _id_B0DEAB8543E2CA82 = spawnStruct();
  _id_B0DEAB8543E2CA82.origin = drone._id_B0DEAB8543E2CA82.origin;
  _id_B0DEAB8543E2CA82.angles = drone._id_B0DEAB8543E2CA82.angles;
  team = undefined;

  if(isDefined(drone.owner) && isDefined(drone.owner.team))
    team = drone.owner.team;

  drone._id_2FA65F34EB9042F5 = spawn("script_model", drone.origin);
  drone._id_2FA65F34EB9042F5 setModel("military_deployable_buystation");
  drone._id_2FA65F34EB9042F5 linkTo(drone, "tag_origin", (0, 0, -75), (0, 0, 0));
  drone._id_2FA65F34EB9042F5 setCanDamage(1);
  drone._id_2FA65F34EB9042F5.maxhealth = 999999999;
  drone._id_2FA65F34EB9042F5.health = 999999999;
  drone._id_2FA65F34EB9042F5 _id_4E70BA4EBDC8DBE9(drone.owner, "ui_map_icon_buystation_drone", "ui_map_icon_buystation_drone_enemy");
  drone._id_2FA65F34EB9042F5 thread _id_90FA8C1F0EA25D78();
  drone._id_2FA65F34EB9042F5.team = team;
  drone._id_2FA65F34EB9042F5.owner = drone.owner;
  drone._id_2FA65F34EB9042F5._id_98AABCA05601AA67 = 1;
  drone._id_2FA65F34EB9042F5._id_C23CA3472233553D = 1;

  if(isDefined(drone.owner))
    drone playsoundtoplayer("kiosk_drone_eng_swt", drone.owner, drone);

  drone._id_2FA65F34EB9042F5._id_3ED07487789E6309 = drone;
  level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2[level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2.size] = drone._id_2FA65F34EB9042F5;
  drone._id_2FA65F34EB9042F5 _id_9E8C5E7B9D1572B7();

  if(isDefined(drone.team)) {
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("friendly_active", drone.team, 1, 2, undefined, "dx_br_bds4_");
    _id_59C0E644F7951E0C = scripts\mp\utility\teams::getteamdata(drone.team, "players");
    _id_47D7FF10E782D70E = ((_id_B0DEAB8543E2CA82.origin[0] + drone.origin[0]) / 2, (_id_B0DEAB8543E2CA82.origin[1] + drone.origin[1]) / 2, (_id_B0DEAB8543E2CA82.origin[2] + drone.origin[2]) / 2);
    _id_EC0171E2F69933C1 = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(_id_47D7FF10E782D70E);
    _id_826839F2397F1E47 = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(_id_B0DEAB8543E2CA82.origin);
    _id_1F0E57A3271D5FAF = scripts\mp\utility\player::getplayersinradius(_id_EC0171E2F69933C1, level._id_ED2DCA1658DA90B2._id_8C3590379C7AB36F, undefined, _id_59C0E644F7951E0C);
    _id_20DAB4933911DADF = scripts\mp\utility\player::getplayersinradius(_id_826839F2397F1E47, level._id_ED2DCA1658DA90B2._id_8C3590379C7AB36F, undefined, _id_59C0E644F7951E0C);
    _id_B6CD0D44C9BC37E5 = scripts\engine\utility::array_combine(_id_1F0E57A3271D5FAF, _id_20DAB4933911DADF);

    if(isDefined(_id_B6CD0D44C9BC37E5) || _id_B6CD0D44C9BC37E5.length > 0) {
      foreach(player in _id_B6CD0D44C9BC37E5)
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("enemy_active", player, 1, undefined, 2, undefined, "dx_br_bds4_");
    }
  }

  if(istrue(level._id_ED2DCA1658DA90B2._id_1A19BD75A8860186)) {
    _id_4E4DF9CADA88AB11 = "[deployableKioskMovingSequence]: " + scripts\engine\utility::_id_53C4C53197386572(_id_B0DEAB8543E2CA82.origin[0], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(_id_B0DEAB8543E2CA82.origin[1], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(_id_B0DEAB8543E2CA82.origin[2], scripts\engine\utility::string(0));
    logstring(_id_4E4DF9CADA88AB11);
  }

  _id_DCF070D2485A90A4(_id_B0DEAB8543E2CA82, 0);
  drone thread _id_4132402C7EC5947C();
  wait 3;
  _id_B0DEAB8543E2CA82.origin = drone._id_B0DEAB8543E2CA82._id_9F925F5509626DF1;
  _id_DCF070D2485A90A4(_id_B0DEAB8543E2CA82, 1);
  drone delete();
}

_id_4132402C7EC5947C(eattacker) {
  drone = self;
  drone._id_2FA65F34EB9042F5 unlink();
  drone._id_2FA65F34EB9042F5.physicsactivated = 1;
  drone._id_2FA65F34EB9042F5 physicslaunchserver((0, 0, 0), (0, 0, 0));
  _id_212A44A5393C3B34 = drone._id_2FA65F34EB9042F5 physics_getbodyid(0);
  physics_setbodycenterofmassnormal(_id_212A44A5393C3B34, (0, 0, 1));
  drone._id_2FA65F34EB9042F5.angles = (0, drone._id_2FA65F34EB9042F5.angles[1], 0);
  drone._id_1D3BF3B408DA503F = 1;
  drone._id_2FA65F34EB9042F5 _id_42349F0AB9120240();
  drone._id_2FA65F34EB9042F5 thread _id_C9064ACA910696FA();
  drone._id_2FA65F34EB9042F5 playSound("br_deployable_kiosk_detach");
  drone thread _id_3313D37DFD52A977();
  drone _id_F0B074BEF81E8C7B(eattacker);

  if(istrue(level._id_ED2DCA1658DA90B2._id_1A19BD75A8860186)) {
    _id_4E4DF9CADA88AB11 = "[deployableKioskDrop]: " + scripts\engine\utility::_id_53C4C53197386572(drone.origin[0], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(drone.origin[1], scripts\engine\utility::string(0)) + ", " + scripts\engine\utility::_id_53C4C53197386572(drone.origin[2], scripts\engine\utility::string(0));
    logstring(_id_4E4DF9CADA88AB11);
  }
}

_id_DCF070D2485A90A4(_id_B0DEAB8543E2CA82, _id_CEB89B7C7C66002A) {
  drone = self;
  drone._id_3B4FEE20D214BD9B = undefined;
  drone._id_F44262DAAB1A384A = undefined;
  drone.speed = 0;
  drone thread _id_6D9358D777958A1B(_id_B0DEAB8543E2CA82, _id_CEB89B7C7C66002A);
  drone thread _id_610F57BDDD265BE2::_id_53A07930F4FC0E08(_id_B0DEAB8543E2CA82);
  drone thread _id_019375CE96B24AFF();
  drone waittill("redeploy_drone_arrive");

  while(!isDefined(drone._id_3B4FEE20D214BD9B) || !isDefined(drone._id_F44262DAAB1A384A))
    wait 1;

  drone._id_3B4FEE20D214BD9B = undefined;
  drone._id_F44262DAAB1A384A = undefined;
}

_id_6D9358D777958A1B(_id_DAAD7D20D7A17C02, _id_CEB89B7C7C66002A) {
  level endon("game_ended");
  self endon("entitydeleted");
  self._id_DDB39E78F356F112 = _id_DAAD7D20D7A17C02.origin;
  _id_F69A5288E749A523 = level._id_ED2DCA1658DA90B2._id_0338B4F24FC6601C;
  _id_F3DA9DAF22907093 = 2000;
  _id_BBB05E2C2ECB2AC6 = 5;
  _id_3E3E41683DC1BCDD = 0.05;

  if(_id_CEB89B7C7C66002A) {
    self.speed = 0;

    while(self.speed < _id_F69A5288E749A523) {
      self.speed = self.speed + 1;

      if(self.speed > _id_F69A5288E749A523)
        self.speed = _id_F69A5288E749A523;

      self moveTo(self.origin + self.speed * vectorNormalize(self._id_DDB39E78F356F112 - self.origin), _id_3E3E41683DC1BCDD, 0, 0);
      wait(_id_3E3E41683DC1BCDD);
    }
  } else {
    self.speed = 130;

    while(self.speed > _id_F69A5288E749A523) {
      self.speed = self.speed - 1.5;

      if(self.speed < _id_F69A5288E749A523)
        self.speed = _id_F69A5288E749A523;

      self moveTo(self.origin + self.speed * vectorNormalize(self._id_DDB39E78F356F112 - self.origin), _id_3E3E41683DC1BCDD, 0, 0);
      wait(_id_3E3E41683DC1BCDD);
    }
  }

  _id_3E3E41683DC1BCDD = 0.05;

  if(self.speed > level._id_FC4BB27A820F54DD._id_73E374CE21FB4FB5) {
    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > squared(self.speed * 20 * level._id_FC4BB27A820F54DD._id_CCD62F7F63FB25B3)) {
      self moveTo(self.origin + self.speed * vectorNormalize(self._id_DDB39E78F356F112 - self.origin), 0.05, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");

    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > _id_F3DA9DAF22907093) {
      self moveTo(self.origin + (self._id_DDB39E78F356F112 - self.origin) * 0.05 / level._id_FC4BB27A820F54DD._id_CCD62F7F63FB25B3, 0.05, 0, 0);
      self.speed = self.speed * 0.95;
      wait 0.05;
    }
  } else {
    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > 500) {
      self moveTo(self.origin + self.speed * vectorNormalize(self._id_DDB39E78F356F112 - self.origin), 0.05, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");

    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > 0.01) {
      self moveTo(self.origin + (self._id_DDB39E78F356F112 - self.origin) * 0.1, 0.05, 0, 0);
      self.speed = self.speed * 0.9;
      wait 0.05;
    }
  }

  self.speed = 0;
  self._id_DDB39E78F356F112 = undefined;
  self._id_3B4FEE20D214BD9B = 1;
}

_id_3313D37DFD52A977() {
  drone = self;
  _id_1257F2498CDCFEA0 = drone.team;
  _id_15B89FF206500554 = drone._id_2FA65F34EB9042F5;
  _id_15B89FF206500554 endon("death");
  level endon("game_ended");
  _id_15B89FF206500554._id_325BF59FE5F05DB3 = 0;

  if(level._id_ED2DCA1658DA90B2._id_1E8AF39FA33C422E)
    _id_15B89FF206500554 thread _id_443C7F998E6D02EB();

  _id_EE011D69B16FF21D = level._id_ED2DCA1658DA90B2._id_3D4073DF2F497525;
  _id_F7989328EFFFF2ED = 0.5;

  while(!_id_15B89FF206500554._id_325BF59FE5F05DB3 || _id_EE011D69B16FF21D > 0.0) {
    contents = scripts\engine\trace::create_default_contents(1);
    ignoreents = [_id_15B89FF206500554];
    trace = scripts\engine\trace::ray_trace(_id_15B89FF206500554.origin, _id_15B89FF206500554.origin - (0, 0, 100), ignoreents, contents);

    if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none")
      _id_15B89FF206500554._id_325BF59FE5F05DB3 = 1;

    _id_EE011D69B16FF21D = _id_EE011D69B16FF21D - _id_F7989328EFFFF2ED;
    wait(_id_F7989328EFFFF2ED);
  }

  _id_15B89FF206500554._id_325BF59FE5F05DB3 = 1;

  if(isDefined(_id_15B89FF206500554) && isDefined(_id_1257F2498CDCFEA0))
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("deploy_ready", _id_1257F2498CDCFEA0, 1, 2, undefined, "dx_br_bds4_");
}

_id_019375CE96B24AFF() {
  drone = self;
  level endon("game_ended");
  drone endon("entitydeleted");
  wait 1;
  drone setscriptablepartstate("redeploy_drone_relocation_sfx", "kiosk_drone_move_sfx");
  drone waittill("redeploy_drone_arrive");
  drone setscriptablepartstate("redeploy_drone_relocation_sfx", "kiosk_drone_idle_sfx");
}

_id_443C7F998E6D02EB() {
  _id_15B89FF206500554 = self;
  _id_15B89FF206500554 endon("death");
  level endon("game_ended");
  _id_15B89FF206500554 endon("monitorPlayerImpactEnd");
  _id_15B89FF206500554 physics_registerforcollisioncallback();
  _id_E6DE3E488795DA29 = 0;
  _id_7B497A1523996243 = [];
  _id_DBBB663991D31286 = 0;

  for(;;) {
    _id_15B89FF206500554 waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);

    if(level._id_ED2DCA1658DA90B2._id_F298AD183EDD53EF)
      _id_15B89FF206500554 checklinktotrain(ent);

    if(level._id_ED2DCA1658DA90B2._id_5944536D424AA063 && ent scripts\common\vehicle::isvehicle() && !scripts\engine\utility::array_contains(_id_7B497A1523996243, ent) && !istrue(_id_15B89FF206500554._id_325BF59FE5F05DB3)) {
      ent dodamage(max(0, ent.health - 30), _id_15B89FF206500554.origin, undefined, undefined, "MOD_EXPLOSIVE");
      _id_7B497A1523996243[_id_7B497A1523996243.size] = ent;
    }

    if(gettime() - _id_E6DE3E488795DA29 >= level._id_ED2DCA1658DA90B2._id_90AA3A29F5C33DB3) {
      _id_E6DE3E488795DA29 = gettime();
      _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(flag1);
      surfacetype = getsubstr(_id_895F3C282BC9FC68["name"], 9);

      if(surfacetype == "user_terrain1")
        surfacetype = "user_terrain_1";

      if(surfacetype == "user_terrain5")
        surfacetype = "user_terrain_5";

      _id_15B89FF206500554 _id_A23AA2D6571BD5E4(position, normal, _id_D71630B8BAF84FA8, surfacetype);
    }
  }
}

checklinktotrain(ent) {
  _id_15B89FF206500554 = self;

  if(isDefined(ent) && isDefined(ent.script_noteworthy) && isstartstr(ent.script_noteworthy, "train_") && !isDefined(_id_15B89FF206500554 getlinkedparent())) {
    if(isDefined(_id_15B89FF206500554.trainent)) {
      if(_id_15B89FF206500554.trainent == ent)
        return;
      else
        _id_15B89FF206500554 cancelchecklinktotrain();
    }

    _id_15B89FF206500554.trainent = ent;
    _id_15B89FF206500554.traincylestolink = 4;
    _id_15B89FF206500554 thread checklinktotraininternal(ent);
  }
}

cancelchecklinktotrain() {
  _id_15B89FF206500554 = self;
  _id_15B89FF206500554 notify("cancel_link_to_train");
  _id_15B89FF206500554.trainent = undefined;
  _id_15B89FF206500554.traintracerelpos = undefined;
  _id_15B89FF206500554.traintracefails = undefined;
  _id_15B89FF206500554.traintracesuccesses = undefined;
}

checklinktotraininternal(ent) {
  _id_15B89FF206500554 = self;
  _id_15B89FF206500554 endon("death");
  _id_15B89FF206500554 endon("cancel_link_to_train");
  ent endon("death");
  _id_98296BB53C7ACF6E = 4;
  halfheight = 30;
  _id_8F62152221C4541C = 200;
  _id_1375DD9DF5EBF6CD = 100;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  ignorelist = [self];

  foreach(linkedent in self getlinkedchildren(1))
  ignorelist[ignorelist.size] = linkedent;

  self.traintracefails = 0;
  self.traintracesuccesses = 0;

  while(self.traintracefails < 20) {
    caststart = self.origin + anglestoup(self.angles) * halfheight;
    castend = caststart + (0, 0, -1 * _id_8F62152221C4541C);
    _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents);

    if(_id_1F0571D36D0DF95B.size > 0 && isDefined(_id_1F0571D36D0DF95B["entity"]) && scripts\cp_mp\utility\train_utility::is_train_ent(_id_1F0571D36D0DF95B["entity"])) {
      traintracerelpos = combineangles(invertangles(ent.angles), ent.origin - _id_1F0571D36D0DF95B["position"]);

      if(!isDefined(self.traintracerelpos)) {} else if(distancesquared(traintracerelpos, self.traintracerelpos) > _id_1375DD9DF5EBF6CD) {
        self.traintracefails++;
        self.traintracesuccesses = 0;
      } else {
        self.traintracesuccesses++;

        if(self.traintracesuccesses >= _id_98296BB53C7ACF6E) {
          self linkTo(ent);
          thread _id_D49B71F319F0C952();
          break;
        }
      }

      self.traintracerelpos = traintracerelpos;
    } else
      break;

    wait 0.1;
  }

  thread cancelchecklinktotrain();
}

_id_D49B71F319F0C952() {
  _id_15B89FF206500554 = self;

  if(!istrue(_id_15B89FF206500554.physicsactivated)) {
    return;
  }
  _id_15B89FF206500554.physicsactivated = undefined;
  _id_15B89FF206500554.physicssettled = undefined;
  _id_15B89FF206500554 physicsstopserver();
  _id_15B89FF206500554 scripts\cp_mp\killstreaks\airdrop::monitorplayerimpactend();
  _id_15B89FF206500554 cancelchecklinktotrain();
}

_id_A23AA2D6571BD5E4(position, normal, _id_D71630B8BAF84FA8, surfacetype) {
  _id_15B89FF206500554 = self;

  if(surfacetype != "glass_pane") {
    _id_64EB7CED98F907BD = "br_deployable_kiosk_impact_high";
    _id_15B89FF206500554 playSound(_id_64EB7CED98F907BD);
  }
}

_id_78966BC6B28DA9B4() {
  drone = self;
  level endon("game_ended");
  drone endon("entitydeleted");
  drone endon("deployable_kiosk_drone_shot_down");

  for(;;) {
    drone waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    drone _id_614262699FA8E2F2(idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
  }
}

_id_90FA8C1F0EA25D78() {
  _id_15B89FF206500554 = self;
  level endon("game_ended");
  _id_15B89FF206500554 endon("entitydeleted");
  _id_15B89FF206500554 endon("death");

  for(;;) {
    _id_15B89FF206500554 waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(isDefined(_id_15B89FF206500554._id_3ED07487789E6309) && !istrue(_id_15B89FF206500554._id_3ED07487789E6309._id_1D3BF3B408DA503F))
      _id_15B89FF206500554._id_3ED07487789E6309 _id_614262699FA8E2F2(idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
  }
}

_id_614262699FA8E2F2(idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon) {
  drone = self;

  if(isPlayer(eattacker))
    eattacker _id_5762AC2F22202BA2::updatehitmarker("standard", drone.health == 0, 0, 1, "hitequip");
  else if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
    eattacker.owner _id_5762AC2F22202BA2::updatehitmarker("standard", drone.health == 0, 0, 1, "hitequip");

  if(isDefined(eattacker.model) && eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg")
    level thread _id_610F57BDDD265BE2::_id_CF65FBC1C077FADB(eattacker, drone.origin);

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE")
    idamage = int(idamage * level._id_FC4BB27A820F54DD._id_4B2CDACF483DCCC4);

  if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3")
    idamage = level._id_FC4BB27A820F54DD._id_71BA1DDBE86CAB15;

  drone.health = drone.health - idamage;

  if(!isDefined(drone._id_DFDCC313086C8290))
    drone._id_DFDCC313086C8290 = 0;

  drone._id_DFDCC313086C8290 = drone._id_DFDCC313086C8290 + 1;

  if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "toma_proj_mp")
    drone.health = 0;

  if(drone.health <= 0) {
    drone thread _id_AA19007A48FCA6C0(eattacker);
    drone notify("deployable_kiosk_drone_shot_down");
    return;
  } else if(level._id_ED2DCA1658DA90B2._id_11F0849A2C7B79CA && (isDefined(self._id_1D3BF3B408DA503F) && !self._id_1D3BF3B408DA503F))
    drone thread _id_495982203BFC8D29(eattacker);
}

_id_495982203BFC8D29(eattacker) {
  drone = self;
  _id_54A8B2D622F1A1E0 = drone.maxhealth / 2;

  if(!isDefined(drone._id_3E9B7FBC105DF68B))
    drone._id_3E9B7FBC105DF68B = 3;

  for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    if(drone.health < _id_54A8B2D622F1A1E0 * _id_AC0E594AC96AA3A8) {
      if(drone._id_3E9B7FBC105DF68B > _id_AC0E594AC96AA3A8) {
        drone._id_3E9B7FBC105DF68B = _id_AC0E594AC96AA3A8;
        eattacker scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6141024A6FCA1305");
        itemlist = ["brloot_plunder_cash_common_1", "brloot_armor_plate"];
        _id_55BEDC0453A6C09B = randomint(100);
        dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, drone._id_43FFD30A35B0DA72.origin - (0, 0, 200), drone._id_43FFD30A35B0DA72.angles, drone, undefined, undefined, undefined, undefined, undefined, 12000);

        if(_id_55BEDC0453A6C09B < 70)
          item = _id_7E52B56769FA7774::spawnpickup(itemlist[0], _id_CB4FAD49263E20C4, undefined, 1, undefined, 0);
        else
          item = _id_7E52B56769FA7774::spawnpickup(itemlist[1], _id_CB4FAD49263E20C4, undefined, 1, undefined, 0);

        break;
      }
    }
  }
}

_id_9E8C5E7B9D1572B7() {
  _id_2FA65F34EB9042F5 = self;

  if(level._id_ED2DCA1658DA90B2._id_A03D33B617B44F0A) {
    foreach(_id_FE9C88140BFAEEF5 in level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2) {
      if(_id_FE9C88140BFAEEF5 == _id_2FA65F34EB9042F5) {
        continue;
      }
      if(!isDefined(_id_2FA65F34EB9042F5.team) || !isDefined(_id_FE9C88140BFAEEF5.team)) {
        continue;
      }
      if(_id_2FA65F34EB9042F5.team == _id_FE9C88140BFAEEF5.team)
        _id_FE9C88140BFAEEF5 thread _id_F5A81AFEB40E65CD();
    }
  }

  _id_9B5871D1F2CB57E9 = 0;

  foreach(_id_7551D41CB4F1B721 in level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2) {
    if(!isDefined(_id_7551D41CB4F1B721)) {
      continue;
    }
    _id_9B5871D1F2CB57E9++;
  }

  if(_id_9B5871D1F2CB57E9 > level._id_ED2DCA1658DA90B2._id_FFE6C41436EFB0B2) {
    _id_F079A3AC63FF9964 = level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2[0];
    _id_F079A3AC63FF9964 thread _id_F5A81AFEB40E65CD();
  }
}

_id_1E28980B8235671E(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(getdvarint("dvar_271D21FB3081AE5F", 0) == 1) {
    return;
  }
  if(!isDefined(level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2)) {
    return;
  }
  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + level._id_ED2DCA1658DA90B2._id_E90F0FE1F275A8B6;
  _id_C434624FF361BBA2 = _id_52D59C928EB97C81 * _id_52D59C928EB97C81;

  foreach(_id_FE9C88140BFAEEF5 in level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2) {
    _id_E4E4AE4481958D2E = distance2dsquared(_id_FE9C88140BFAEEF5.origin, _id_819EDACDACB810E4) + level._id_53C0FA66001CFF52 > _id_C434624FF361BBA2;

    if(istrue(_id_FE9C88140BFAEEF5._id_98AABCA05601AA67)) {
      if(_id_E4E4AE4481958D2E)
        _id_FE9C88140BFAEEF5 _id_98913CB90FF3AF87();

      continue;
    }

    if(!_id_E4E4AE4481958D2E)
      _id_313D9044D8E6F53C(_id_FE9C88140BFAEEF5);
  }
}

_id_B77546749EB0C127(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(getdvarint("dvar_271D21FB3081AE5F", 0) == 1) {
    return;
  }
  if(!isDefined(level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2)) {
    return;
  }
  _id_31966DAE052C3D71 = [];

  foreach(_id_FE9C88140BFAEEF5 in level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2) {
    _id_E4E4AE4481958D2E = !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_FE9C88140BFAEEF5.origin, level._id_ED2DCA1658DA90B2._id_AEEB98B4D36B65A6);

    if(istrue(_id_FE9C88140BFAEEF5._id_98AABCA05601AA67)) {
      if(_id_E4E4AE4481958D2E) {
        _id_31966DAE052C3D71[_id_31966DAE052C3D71.size] = _id_FE9C88140BFAEEF5;
        _id_FE9C88140BFAEEF5 _id_98913CB90FF3AF87();
      }

      continue;
    }

    if(!_id_E4E4AE4481958D2E) {
      _id_31966DAE052C3D71 = scripts\engine\utility::array_remove(_id_31966DAE052C3D71, _id_FE9C88140BFAEEF5);
      _id_313D9044D8E6F53C(_id_FE9C88140BFAEEF5);
    }
  }

  return _id_31966DAE052C3D71;
}

_id_7B0648952E816403(_id_FE9C88140BFAEEF5) {
  _id_FE9C88140BFAEEF5._id_98AABCA05601AA67 = 1;
  _id_FE9C88140BFAEEF5 setscriptablepartstate("screen", "activated");
}

_id_AD1B6F540C35705D() {
  if(!isDefined(level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2)) {
    return;
  }
  foreach(_id_FE9C88140BFAEEF5 in level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2) {
    if(isDefined(_id_FE9C88140BFAEEF5._id_98AABCA05601AA67))
      _id_FE9C88140BFAEEF5 _id_98913CB90FF3AF87();
  }
}

_id_313D9044D8E6F53C(_id_FE9C88140BFAEEF5) {
  _id_FE9C88140BFAEEF5._id_98AABCA05601AA67 = 1;
  _id_FE9C88140BFAEEF5 setscriptablepartstate("screen", "activated");
}

_id_98913CB90FF3AF87() {
  _id_FE9C88140BFAEEF5 = self;
  _id_FE9C88140BFAEEF5._id_98AABCA05601AA67 = 0;
  _id_FE9C88140BFAEEF5 setscriptablepartstate("screen", "deactivated");

  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(isDefined(_id_AC0E424AC96A7113.br_kiosk) && isDefined(_id_AC0E424AC96A7113.br_kiosk.entity) && _id_AC0E424AC96A7113.br_kiosk.entity == _id_FE9C88140BFAEEF5)
      _id_AC0E424AC96A7113 _id_4384ABBF498DF6A7::_closepurchasemenuwithresponse(2);
  }
}

_id_7440E01CDF6AD541() {
  player = self;
  _id_961550EA13EBBF78 = 0;

  foreach(drone in level._id_ED2DCA1658DA90B2.drones) {
    if(!isDefined(drone)) {
      continue;
    }
    _id_961550EA13EBBF78++;
  }

  if(_id_961550EA13EBBF78 >= level._id_ED2DCA1658DA90B2._id_406BFEEBFF3AA082) {
    player playlocalsound("br_plunder_atm_cancel");
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/AIRSPACE_CROWDED_DEPLOYABLE_KIOSK");
    return 1;
  }

  return 0;
}

_id_F5A81AFEB40E65CD() {
  _id_2FA65F34EB9042F5 = self;
  level endon("game_ended");

  if(isDefined(_id_2FA65F34EB9042F5._id_3ED07487789E6309)) {
    if(!istrue(_id_2FA65F34EB9042F5._id_3ED07487789E6309._id_1D3BF3B408DA503F))
      _id_2FA65F34EB9042F5._id_3ED07487789E6309 thread _id_AA19007A48FCA6C0();
  }

  playFX(scripts\engine\utility::getfx("deployable_kiosk_explosion"), _id_2FA65F34EB9042F5.origin, anglesToForward(_id_2FA65F34EB9042F5.angles), anglestoup(_id_2FA65F34EB9042F5.angles));
  self playSound("br_deployable_kiosk_explode");
  wait 1.4;
  _id_2FA65F34EB9042F5 _id_42349F0AB9120240();
  level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2 = scripts\engine\utility::array_remove(level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2, _id_2FA65F34EB9042F5);
  _id_2FA65F34EB9042F5 delete();
  level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2 = scripts\engine\utility::array_removeundefined(level._id_ED2DCA1658DA90B2._id_5B25E7620E424CB2);
}

_id_AA19007A48FCA6C0(eattacker) {
  drone = self;
  level endon("game_ended");
  level._id_ED2DCA1658DA90B2.drones = scripts\engine\utility::array_remove(level._id_ED2DCA1658DA90B2.drones, drone);
  level._id_ED2DCA1658DA90B2.drones = scripts\engine\utility::array_removeundefined(level._id_ED2DCA1658DA90B2.drones);

  if(!istrue(drone._id_1D3BF3B408DA503F) && isDefined(drone._id_2FA65F34EB9042F5))
    drone thread _id_4132402C7EC5947C(eattacker);

  if(isDefined(eattacker) && isDefined(drone._id_2FA65F34EB9042F5) && isDefined(drone._id_2FA65F34EB9042F5.owner)) {
    if(eattacker.team != drone._id_2FA65F34EB9042F5.owner.team)
      eattacker scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E87586EA44AA31D9");
  }

  drone setscriptablepartstate("redeploy_drone_relocation_smoke_vfx", "enabled");
  drone physics_registerforcollisioncallback();
  drone thread _id_610F57BDDD265BE2::_id_026AACBD66AB5C92();
  drone waittill("collision");
  drone _id_1519CC09E0DBAD0C();
  scripts\mp\weapons::_id_1A33BD42949CCBDA(drone);

  if(isDefined(drone))
    drone delete();
}

_id_1519CC09E0DBAD0C() {
  drone = self;
  _id_78122E18403A8DC4 = scripts\mp\utility\player::getplayersinradius(drone.origin, level._id_ED2DCA1658DA90B2._id_35BBF066F50AC582);

  foreach(player in _id_78122E18403A8DC4)
  player dodamage(level._id_ED2DCA1658DA90B2._id_8CF89663DC98483D, drone.origin, player, player, "MOD_CRUSH");

  vfx = spawnscriptable("scriptable_redeploy_drone_explosion", drone.origin);
  waitframe();
  vfx freescriptable();
}

_id_F0B074BEF81E8C7B(eattacker) {
  drone = self;

  if(!isDefined(drone.owner)) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "shots_taken";
  _id_DFDCC313086C8290 = scripts\engine\utility::ter_op(isDefined(drone._id_DFDCC313086C8290), drone._id_DFDCC313086C8290, 0);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DFDCC313086C8290;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "shot_down";
  _id_40B256CD5E9C4485 = scripts\engine\utility::ter_op(isDefined(eattacker), 1, 0);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_40B256CD5E9C4485;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "shot_down_by_enemy";
  _id_47D00EFCFD046CCB = isDefined(eattacker);
  _id_1E8CE7BAFB66028C = scripts\engine\utility::ter_op(_id_47D00EFCFD046CCB && drone.owner.team != eattacker.team, 1, 0);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_1E8CE7BAFB66028C;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "percentage_distance_travelled";
  _id_6303F40D469148E7 = distance2dsquared(drone.spawnorigin, drone._id_D4CF75E8A617D80C);
  _id_AF992377583332FE = distance2dsquared(drone.spawnorigin, drone.origin);

  if(_id_6303F40D469148E7 <= 0)
    _id_F21610E75D76DF0B = 100;
  else
    _id_F21610E75D76DF0B = _id_AF992377583332FE / _id_6303F40D469148E7 * 100;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(_id_F21610E75D76DF0B);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "weapon_shot_down";
  _id_3565C47F3B387A0A = isDefined(eattacker) && isDefined(eattacker.currentweapon) && isDefined(eattacker.currentweapon.basename);
  _id_F737D47E3C909CCD = "";

  if(_id_3565C47F3B387A0A)
    _id_F737D47E3C909CCD = eattacker.currentweapon.basename;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_F737D47E3C909CCD;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "request_x";
  _id_07DB719E63A1F19E = scripts\engine\utility::ter_op(isDefined(drone._id_DD4F599B9C56DB3A), drone._id_DD4F599B9C56DB3A, -1);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_07DB719E63A1F19E;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "request_y";
  _id_07DB729E63A1F3D1 = scripts\engine\utility::ter_op(isDefined(drone._id_DD4F5A9B9C56DD6D), drone._id_DD4F5A9B9C56DD6D, -1);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_07DB729E63A1F3D1;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "request_z";
  _id_07DB6F9E63A1ED38 = scripts\engine\utility::ter_op(isDefined(drone._id_DD4F579B9C56D6D4), drone._id_DD4F579B9C56D6D4, -1);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_07DB6F9E63A1ED38;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "total_squad_cash";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = drone._id_6C90750B2BDE4F94;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "circle_index";
  circleindex = -1;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
    circleindex = level.br_circle.circleindex;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = circleindex;
  drone.owner dlog_recordplayerevent("dlog_event_br_deployable_kiosk", _id_EC6A81EAC0E4DC61);
}

_id_4E70BA4EBDC8DBE9(owner, friendlyicon, _id_30F120A1EFC1DCBE) {
  _id_2FA65F34EB9042F5 = self;
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(objid, "active");
  objective_position(objid, _id_2FA65F34EB9042F5.origin);
  objective_sethideelevation(objid, 1);
  objective_setplayintro(objid, 0);
  objective_onentity(objid, _id_2FA65F34EB9042F5);
  objective_setzoffset(objid, 50);
  objective_setshowdistance(objid, 0);
  objective_setshowoncompass(objid, 0);
  _func_865F9C5D005F9A08(objid, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, friendlyicon);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 5);
  scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(objid, &"EQUIPMENT/DEPLOYABLE_KIOSK_MARKER");

  if(isDefined(owner))
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(objid, owner.team);
  else
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);

  _func_865F9C5D005F9A08(objid, 0);
  objective_sethideelevation(objid, 1);
  _id_2FA65F34EB9042F5._id_74DC8D9EEDCD0D15 = objid;

  if(isDefined(owner)) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
    objective_state(objid, "active");
    objective_position(objid, _id_2FA65F34EB9042F5.origin);
    objective_sethideelevation(objid, 1);
    objective_setplayintro(objid, 0);
    objective_onentity(objid, _id_2FA65F34EB9042F5);
    objective_setzoffset(objid, 50);
    objective_setshowdistance(objid, 0);
    objective_setshowoncompass(objid, 0);
    _func_865F9C5D005F9A08(objid, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(objid, _id_30F120A1EFC1DCBE);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 5);
    scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(objid, &"EQUIPMENT/DEPLOYABLE_KIOSK_MARKER");
    scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(objid, owner.team);
    _func_865F9C5D005F9A08(objid, 0);
    objective_sethideelevation(objid, 1);
    _id_2FA65F34EB9042F5.enemyobjid = objid;
  }
}

_id_42349F0AB9120240() {
  _id_2FA65F34EB9042F5 = self;

  if(!isDefined(_id_2FA65F34EB9042F5)) {
    return;
  }
  if(isDefined(_id_2FA65F34EB9042F5.objid)) {
    objective_hidefromplayersinmask(_id_2FA65F34EB9042F5.objid);
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_2FA65F34EB9042F5.objid);
    _id_2FA65F34EB9042F5.objid = undefined;
  }

  if(isDefined(_id_2FA65F34EB9042F5._id_74DC8D9EEDCD0D15)) {
    objective_hidefromplayersinmask(_id_2FA65F34EB9042F5._id_74DC8D9EEDCD0D15);
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_2FA65F34EB9042F5._id_74DC8D9EEDCD0D15);
    _id_2FA65F34EB9042F5._id_74DC8D9EEDCD0D15 = undefined;
  }

  if(isDefined(_id_2FA65F34EB9042F5.enemyobjid)) {
    objective_hidefromplayersinmask(_id_2FA65F34EB9042F5.enemyobjid);
    scripts\mp\objidpoolmanager::returnobjectiveid(_id_2FA65F34EB9042F5.enemyobjid);
    _id_2FA65F34EB9042F5.enemyobjid = undefined;
  }
}

_id_4B8F0A33E19C0310() {
  _id_2FA65F34EB9042F5 = self;

  if(!isDefined(_id_2FA65F34EB9042F5)) {
    return;
  }
  if(!isDefined(_id_2FA65F34EB9042F5.objid)) {
    return;
  }
  if(_id_337BD370F7C5E6F9::ispubliceventoftypeactive(2))
    scripts\mp\objidpoolmanager::update_objective_setbackground(_id_2FA65F34EB9042F5.objid, 11);
  else
    scripts\mp\objidpoolmanager::update_objective_setbackground(_id_2FA65F34EB9042F5.objid, 5);
}

_id_C9064ACA910696FA() {
  _id_2FA65F34EB9042F5 = self;
  level endon("game_ended");
  _id_2FA65F34EB9042F5 endon("death");

  for(;;) {
    level scripts\engine\utility::waittill_any_2("public_event_firesale_start", "public_event_firesale_end");
    _id_2FA65F34EB9042F5 _id_4B8F0A33E19C0310();
  }
}

_id_FF4BBEB786042D78(grenade) {
  player = self;
  player endon("disconnect");
  grenade endon("explode_end");
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  player thread _id_58D05FE18DD1C713(grenade);
  grenade waittill("explode", position);
  player notify("deployable_kiosk_drop_finished");
  thread _id_1E270E9C7A27BB49(position);

  if(scripts\mp\outofbounds::ispointinoutofbounds(position) || player _id_7440E01CDF6AD541()) {
    if(isDefined(grenade))
      grenade delete();

    if(isDefined(player.super))
      player scripts\mp\supers::superusefinished(1);

    return;
  }

  _id_590979EF771686A8(player, position);

  if(isDefined(player.super))
    player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

_id_58D05FE18DD1C713(grenade) {
  player = self;
  player endon("disconnect");
  player endon("deployable_kiosk_drop_finished");
  grenade waittill("death");
  waitframe();

  if(isDefined(player.super))
    player scripts\mp\supers::superusefinished(1);
}

_id_1E270E9C7A27BB49(position) {
  _id_0BA3396E2B7597B2 = spawn("script_origin", position);
  _id_0BA3396E2B7597B2 playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  _id_0BA3396E2B7597B2 playSound("smoke_canister_tail_dissipate");
  _id_0BA3396E2B7597B2 stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  _id_0BA3396E2B7597B2 delete();
}