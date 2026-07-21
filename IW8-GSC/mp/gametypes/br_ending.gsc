/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_ending.gsc
***********************************************/

define_as_level_infil_driver() {
  if(!_id_11C64(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD"))) {
    return;
  }
  _encstr_95FB18894EAF2B9B465A73B3EBB79D564EC9B446B2FA969B5AA3();
  setdvarifuninitialized("_encstr_994C161B30CDF1AB53B87566CDD853076FE852B2805937CB", 1);
  setdvarifuninitialized("_encstr_B14816CD36397D314ED7953C33D21B7DA97D1B3458CD6C95", 0);

  if(_getdeathstatecode::vehicle_damage_loadtable())
    setdvarifuninitialized("_encstr_8AC1184BFE5AD11E13478B95C3CA5048DF03760125B1F0C15AB3", 1);
  else
    setdvarifuninitialized("_encstr_8AC1184BFE5AD11E13478B95C3CA5048DF03760125B1F0C15AB3", 0);

  if(getdvarint("_encstr_8AC1184BFE5AD11E13478B95C3CA5048DF03760125B1F0C15AB3", 0) == 1)
    _getdeathstatecode::vehicle_damage_mp_init();
  else
    go_to_combat();
}

_encstr_95FB18894EAF2B9B465A73B3EBB79D564EC9B446B2FA969B5AA3() {
  level._encstr_87BF11E265A81D1B3B58EA5263050B5290219D = getDvar("_encstr_872F170B52ABF048CA0F839D5C7450A4770A2371EB7313B027", "_encstr_B40101");
  var_0 = 0;

  switch (level._encstr_87BF11E265A81D1B3B58EA5263050B5290219D) {
    case "_encstr_81100FFBD05F8B2FC33BDF0BDE2BCF179D":
      var_0 = _encstr_B41E325780D3C9A341167DE5FF8F4A863948A3B7F08931AADF21B211EE1DE1554291530FD0637F13ABD07A16CEEB1A1660E8CFBF::_encstr_9765210EAB60633FBEA2A3AAEB1D2F5DF8119669C9D9EAEBE8DB4AE256654B5638910D();
      break;
    default:
      break;
  }

  if(var_0) {
    switch (level._encstr_87BF11E265A81D1B3B58EA5263050B5290219D) {
      case "_encstr_81100FFBD05F8B2FC33BDF0BDE2BCF179D":
        _encstr_B41E325780D3C9A341167DE5FF8F4A863948A3B7F08931AADF21B211EE1DE1554291530FD0637F13ABD07A16CEEB1A1660E8CFBF::_encstr_9669181384834050CB171FC7C342AD585D5899486DD7D098520B();
        break;
      default:
        break;
    }
  }
}

gates_combat() {
  if(!getdvarint("_encstr_994C161B30CDF1AB53B87566CDD853076FE852B2805937CB"))
    return 0;

  if(!_id_11C64(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD")))
    return 0;

  if(istrue(level.deletequestobjicon))
    return 0;

  return 1;
}

_id_11C64(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_A95E0A98B78C2FC6F6AB9B1D":
    case "_encstr_BD1D06DA5D98651B":
    case "_encstr_85EE090C9DD0A62F3CA1B3":
    case "_encstr_A519044B436F":
    case "_encstr_A11804CEC338":
    case "_encstr_A919041BADA2":
    case "_encstr_920A0862BD63CB5FC758":
    case "_encstr_91190446A2B3":
    case "_encstr_9286085A21B8034D3863":
    case "_encstr_AAEF05B85A86E9":
    case "_encstr_A11804C81332":
    case "_encstr_831904FDF363":
    case "_encstr_AD51088015D1E2D47930":
    case "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95":
    case "_encstr_AD300C932B4C969CD1D0AF911346":
    case "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8":
    case "_encstr_A254085207A6B7334B5A":
    case "_encstr_87A205AF50D049":
    case "_encstr_AFDD05A6AB763B":
    case "_encstr_8AE1099A0B999F2D28AF15":
    case "_encstr_B40101":
      var_1 = 1;
      break;
  }

  return var_1;
}

_encstr_97DE1F6E43DBEA6319EBE027CAC6BD85327D95738C2DB9B3AFC6EDB158D12DF6E6() {
  if(_getdeathstatecode::vehicle_damage_loadtable() || getdvarint("_encstr_8AC1184BFE5AD11E13478B95C3CA5048DF03760125B1F0C15AB3", 0))
    return 1;

  if(getdvarint("_encstr_AC2A11B9C6C9AF31E4F5E93C0E7DB23CCC5A1B", 0) == 1)
    return 1;

  if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8))
    return istrue(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_9AA60E07C9598DF62C912BB98C96DCD9);

  return 0;
}

_id_13E00(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(_encstr_97DE1F6E43DBEA6319EBE027CAC6BD85327D95738C2DB9B3AFC6EDB158D12DF6E6()) {
    var_2 = propminigamefinish(var_0, var_1, 1);

    if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_995A1A2B734696DC9DEC5A2BDDA5CDECC1B1C2F2599CED39B4B39637))
      var_3 = level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_995A1A2B734696DC9DEC5A2BDDA5CDECC1B1C2F2599CED39B4B39637;
    else
      var_3 = var_2[0].origin;

    foreach(var_5 in level.players)
    var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_3);
  }
}

_id_123DE(var_0, var_1) {
  if(!gates_combat()) {
    return;
  }
  level notify("_encstr_A1A61418C35D69665FED269FD503AB1B093A50908AF6");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_sort_with_func(var_0, ::hideleaderhashuntilpercent);
  _id_13FBC(var_0);
  level notify("_encstr_AC63109843D7295D3A2C58D48963A11142F3");
  level.disable_back_light = 1;

  if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_AB1E14FFAD8D1B4A78A17FC338786EA2DE3F536F7526))
    var_0 = [[level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_AB1E14FFAD8D1B4A78A17FC338786EA2DE3F536F7526]](var_0);

  var_2 = randomfloat(1) < getdvarfloat("_encstr_B14816CD36397D314ED7953C33D21B7DA97D1B3458CD6C95");
  var_3 = propmoveunlock();
  var_4 = init_door_ent_flags(var_3, var_0, var_1);

  if(var_2) {
    setomnvarforallclients("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
    level thread onjoinedteamcb(15, "_encstr_B4AD205E8812DF4BEDCFFF8395FB826788B15622414897B32851D7E383882A99A0D8");
    var_3 = "_encstr_A143070DA0DA6B3885";
  }

  var_0 = undefined;
  level.defendkill = var_4;
  var_4.onping = var_3;
  var_4 _id_13082(var_3, var_1);
  nagstilflag(var_4);
  var_5 = name_fx(var_4);
  headicon_image(var_4.origin, 1000);
  hasscrapassist();
  _encstr_ABA411D8C62BC2E4AF9BD697465AB3CA3B993C();
  var_4 scripts\common\anim::anim_first_frame_solo(var_4.gameending, var_4._id_121B8[0].anime);

  foreach(var_7 in level.players) {
    var_7 cameradefault();
    var_7 cameralinkTo(var_4.gameending, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 1);
    var_7 thread nakeddrophandleloadout(var_4.gameending);

    if(isDefined(var_4._id_142D0))
      var_7 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer(var_4._id_142D0, 0);
  }

  bush_onplayerconnect(var_4, 1);

  if(var_2) {
    var_9 = 5;
    playcinematicforall("_encstr_B4AD205E8812DF4BEDCFFF8395FB826788B15622414897B32851D7E383882A99A0D8", 1, 1);
    setomnvarforallclients("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 10);
    wait(var_9);
    ongrenadeused(var_4);
    setomnvarforallclients("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
  }

  wait 1;
  bush_concealment_monitor(var_4);
}

bush_onplayerconnect(var_0, var_1) {
  foreach(var_3 in var_0._id_121B8) {
    if(isDefined(var_3.startfunc))
      [[var_3.startfunc]](var_3._id_121D4);

    if(istrue(var_1) && isDefined(var_3.fx)) {
      if(isDefined(var_3.fxtag))
        playFXOnTag(scripts\engine\utility::getfx(var_3.fx), var_3.playerzombiejumpcleanup, var_3.fxtag);
      else
        playFX(scripts\engine\utility::getfx(var_3.fx), var_3.playerzombiemonitorinput, anglesToForward(var_3.playerzombiehud), anglestoup(var_3.playerzombiehud));
    }

    if(var_3.players.size > 0) {
      var_3.players = scripts\engine\utility::array_removeundefined(var_3.players);

      foreach(var_5 in var_3.players) {
        var_5 dontinterpolate();

        if(isDefined(var_5.x1fin_playerdisconnect)) {
          if(!isPlayer(var_5))
            var_5.x1fin_playerdisconnect thread scripts\common\anim::anim_single_solo(var_5.player_rig, var_3.anime, var_5.x1fin_removequestinstance);
          else
            var_5.x1fin_playerdisconnect thread scripts\mp\anim::anim_player_solo(var_5, var_5.player_rig, var_3.anime, var_5.x1fin_removequestinstance);

          continue;
        }

        if(!isPlayer(var_5)) {
          var_0 thread scripts\common\anim::anim_single_solo(var_5.player_rig, var_3.anime);
          continue;
        }

        var_0 thread scripts\mp\anim::anim_player_solo(var_5, var_5.player_rig, var_3.anime);
      }

      if(isDefined(var_0._id_124EA)) {
        foreach(var_8 in var_0._id_124EA) {
          if(isDefined(var_8.player)) {
            continue;
          }
          if(isDefined(var_8.x1fin_playerdisconnect)) {
            var_8.x1fin_playerdisconnect thread scripts\common\anim::anim_single_solo(var_8, var_3.anime, var_8.x1fin_removequestinstance);
            continue;
          }

          var_0 thread scripts\common\anim::anim_single_solo(var_8, var_3.anime);
        }
      }
    }

    if(var_3.ents.size > 0) {
      foreach(var_11 in var_3.ents)
      var_11 dontinterpolate();

      var_0 thread scripts\common\anim::anim_single(var_3.ents, var_3.anime);
    }

    var_0.gameending dontinterpolate();
    var_0 scripts\common\anim::anim_single_solo(var_0.gameending, var_3.anime);
    waitframe();
    level.defendkill notify("_encstr_B44E0A0AB9F8BE9A680B0323");
  }

  level.defendkill notify("_encstr_A2440FB0B1B1FAB936CACDB2B9D7CADC19");
}

bush_concealment_monitor(var_0) {
  foreach(var_2 in var_0._id_121B8) {
    foreach(var_4 in var_2.ents) {
      if(isDefined(var_4)) {
        if(isDefined(var_4.linkedents))
          scripts\engine\utility::array_delete(var_4.linkedents);

        var_4 delete();
      }
    }
  }

  brking_onplayerconnect();

  foreach(var_8 in level.players) {
    if(isDefined(var_8) && isDefined(var_8.player_rig)) {
      if(isDefined(var_8.sessionstate) && var_8.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
        var_8 setspectatedefaults(var_0.origin, var_0.angles);
      else
        var_8 setOrigin(var_0.origin);

      var_8.player_rig delete();
    }
  }

  if(isDefined(var_0.gameending))
    var_0.gameending delete();
}

hideleaderhashuntilpercent(var_0, var_1) {
  return var_0.pers["_encstr_82FB06EB26785BD7"] >= var_1.pers["_encstr_82FB06EB26785BD7"];
}

_id_13AEE() {
  wait 25;

  foreach(var_1 in level.players)
  var_1 setplayermusicstate("_encstr_B40101");
}

nagstilflag(var_0) {
  level.endmatchcameratransitions = 1;
  level notify("_encstr_918D15899CA638B0DDB982D8B0CBB2273715DC8C4BB93B");

  foreach(var_2 in level.players) {
    if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_88DD19E87BA49065C233132D4B1A5D9918EB40F0BF6A6B3B9B9B97))
      var_2 thread[[level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_88DD19E87BA49065C233132D4B1A5D9918EB40F0BF6A6B3B9B9B97]]();

    var_2 predictstreampos(var_0.origin);
    var_2 scripts\mp\utility\player::hidehudenable();
    var_2 setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
    var_2 setclientomnvar("_encstr_A5011EAB96BE13C97D9B2E570B91D79536D26B2DB985A3B232EB58B1E8B49D56", 0);

    if(isDefined(var_2.sessionstate)) {
      if(var_2.sessionstate == "_encstr_84670547C3E9F4")
        var_2 thread scripts\mp\playerlogic::spawnintermission(var_0.gameending);

      if(var_2.sessionstate == "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
        var_2 scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");

      if(var_2.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        if(getdvarint("_encstr_8182210B20DDE1BB638845763D2843375FF05283A85565FFBE865875465347BB5B183A", 0)) {
          var_2 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
          var_2 scripts\mp\spectating::setdisabled();
        }

        var_2 setspectatedefaults(var_0.gameending.origin, var_0.gameending.angles);
        var_2 spawn(var_0.gameending.origin, var_0.gameending.angles);
        continue;
      }

      if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_995A1A2B734696DC9DEC5A2BDDA5CDECC1B1C2F2599CED39B4B39637))
        var_2 setOrigin(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_995A1A2B734696DC9DEC5A2BDDA5CDECC1B1C2F2599CED39B4B39637);
      else
        var_2 setOrigin(var_0.origin + (0, 0, 100));

      if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_AF911A3B9EF7A0D07FBBF861B31F98988AE4BB9B3DDA3828973271AB))
        var_2 setplayerangles(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_AF911A3B9EF7A0D07FBBF861B31F98988AE4BB9B3DDA3828973271AB);
    }
  }
}

name_fx(var_0) {
  var_1 = var_0.winners;
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.sessionstate) && var_4.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
      var_2 = var_4.origin;
      break;
    }
  }

  var_6 = [];
  var_7 = 0;

  foreach(var_11, var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isPlayer(var_4)) {
      continue;
    }
    if(isDefined(var_4.sessionstate) && var_4.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
      var_4.forcespawnorigin = var_2;
      var_4 scripts\mp\playerlogic::spawnplayer(0);
    }

    var_4 namehud();
    var_9 = var_4 scripts\mp\teams::lookupcurrentoperator(var_4.team);
    var_10 = scripts\mp\teams::getoperatorgender(var_9);
    var_4._id_145CA = var_7;
    var_7++;

    if(!isDefined(var_4.animname) || var_4.animname != var_4.disable_stealth_reinforcement_icon)
      var_4.animname = var_4.disable_stealth_reinforcement_icon;

    var_4 thread _id_124F0();
    var_4 create_player_rig(var_4.animname, "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A", var_0);
    level thread nag_radius(var_4);
    var_6[var_6.size] = var_4.player_rig;
  }

  return var_6;
}

namehud() {
  self playershow(1);
  _id_1248E();
  _id_12467();
  self.plotarmor = 1;
  scripts\mp\outofbounds::enableoobimmunity(self);
  self.x1fin_playerdisconnect = undefined;
  self.x1fin_removequestinstance = undefined;
}

nearby_ai_combat_via_grenade(var_0) {
  var_1 = var_0.winners;
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.sessionstate) && var_4.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
      var_2 = var_4.origin;
      break;
    }
  }

  var_6 = 0;

  foreach(var_9, var_8 in var_1) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(!isPlayer(var_8)) {
      continue;
    }
    if(isDefined(var_8.player_rig))
      var_8.player_rig delete();

    if(isDefined(var_8.sessionstate) && var_8.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
      var_8.forcespawnorigin = var_2;
      var_8 scripts\mp\playerlogic::spawnplayer(0);
    }

    var_8 namelocations();
    var_8._id_145CA = undefined;
    var_8 thread _id_124F0();
  }

  brking_onplayerconnect();
}

namelocations() {
  self playershow(1);
  _id_1248E();
  _id_12468();
  self.plotarmor = 0;
  scripts\mp\outofbounds::disableoobimmunity(self);
  self.x1fin_playerdisconnect = undefined;
  self.x1fin_removequestinstance = undefined;
}

_id_13FBC(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_sort_with_func(var_0, ::hideleaderhashuntilpercent);
  var_1 = -1;
  var_2 = 0;

  foreach(var_6, var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_5 = 8 * var_2;
    var_1 = var_1 &~(255 << var_5);
    var_1 = var_1 | var_4 getentitynumber() << var_5;
    var_2++;
  }

  setomnvarforallclients("_encstr_96240EA3D859C62039933BAEC3CF0BA3", var_1);
}

init_death_animations(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.uniform_suicide_truck_speed_manager = 1;
  var_1.disable_stealth_reinforcement_icon = "_encstr_A77508AB084109229D67";
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 create_player_rig(var_1.disable_stealth_reinforcement_icon, "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A", var_0);
  var_1 linkTo(var_1.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", (0, 0, 0), (0, 0, 0));
  level thread nag_radius(var_1, 1);
  var_0.winners[0] = var_1;
}

_id_1248E() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self.vehicle);

  if(istrue(self.usingascender) && isDefined(self.cansticktoent))
    scripts\cp_mp\auto_ascender::canseesafecircleui();

  if(isDefined(self.remoteuav))
    self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();

  if(isDefined(self.currentturret))
    scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse(self.currentturret);

  if(isDefined(self.usingremote)) {
    var_0 = vehicle_getarray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2.owner) && var_2.owner == self) {
        if(isDefined(var_2.helperdronetype))
          var_2 scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(1);
      }
    }
  }
}

_id_12467() {
  if(!isPlayer(self)) {
    return;
  }
  self allowmovement(0);
  self allowjump(0);
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self disableweaponswitch();
  scripts\common\utility::allow_vehicle_use(0);
  self skydive_interrupt();
}

_id_12468() {
  if(!isPlayer(self)) {
    return;
  }
  self allowmovement(1);
  self allowjump(1);
  self enableoffhandweapons();
  self allowmelee(1);
  self allowads(1);
  self allowfire(1);
  self enableweaponswitch();
}

nag_radius(var_0, var_1) {
  var_2 = var_0.player_rig;
  var_3 = isPlayer(var_0);

  if(!isDefined(var_1))
    var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  else
    wait 0.1;

  if(!isDefined(var_2)) {
    return;
  }
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A5C41283E14EE339B347EA3BB0CEB07D26FD790B"), var_2, "_encstr_8E010B996FB7B6B3C1D1183343");
}

_id_124F0() {
  if(istrue(self.isjuggernaut)) {
    return;
  }
  var_0 = undefined;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3.classname != "_encstr_965306392D3336B2" && var_3.classname != "_encstr_A1100738A33A638123" && var_3.classname != "_encstr_BE0703A54C" && var_3.classname != "_encstr_850707F7E5833355B8") {
      continue;
    }
    var_0 = var_3;

    if(isDefined(var_0)) {
      break;
    }
  }

  if(!nullweapon(self.currentweapon)) {
    self clearaccessory();
    self takeallweapons();
  } else
    waitframe();

  if(!isDefined(var_0))
    var_0 = scripts\mp\class::fixcollision("_encstr_99B70F4B51C1668BE823134AA8DCC78B32", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 0);

  if(getdvarint("_encstr_AC2A11B9C6C9AF31E4F5E93C0E7DB23CCC5A1B", 0) == 1) {
    var_5 = [];
    var_5[var_5.size] = "_encstr_99B70F4B51C1668BE823134AA8DCC78B32";
    var_5[var_5.size] = "_encstr_8C160DAFE71BF161681EB5BCB0F8FC";
    var_5[var_5.size] = "_encstr_93E40E73E51637AD4F68E3CA500BB376";
    var_5[var_5.size] = "_encstr_99B310905209D5DBA9FAC38B62BB2FE0850A";
    var_0 = scripts\mp\class::fixcollision(var_5[randomint(var_5.size)], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 0);
  }

  if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && istrue(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_9ADF129BD6FB65F0BA2DE828E558C0EF527793EB)) {
    var_6 = 33;

    if(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_A15E0E8540A310995BDBD0708236A329 == "_encstr_A28B09B3D21BB185B473B9")
      var_6 = 34;

    var_0 = scripts\mp\class::fixcollision("_encstr_A1AF0E479D512ED87948CB6783081C23", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", var_6);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"] = createheadicon(var_0);
  self.primaryweapon = createheadicon(var_0);
  self.primaryweaponobj = var_0;
  self.secondaryweapon = undefined;
  self.secondaryweaponobj = undefined;

  if(self getweaponammoclip(var_0) < 5)
    self setweaponammoclip(var_0, 5);

  var_7 = self switchtoweapon(var_0);
}

propmoveunlock() {
  var_0 = "_encstr_97EA088D34DE831CB239";

  if(getdvarint("_encstr_AC2A11B9C6C9AF31E4F5E93C0E7DB23CCC5A1B", 0) == 1)
    var_0 = "_encstr_92EF0C076332FF48B54A36AAF088";

  if(getdvarint("_encstr_8AC1184BFE5AD11E13478B95C3CA5048DF03760125B1F0C15AB3", 0) == 1)
    var_0 = "_encstr_85DE05A6B2AC0E";

  var_1 = getdvarint("_encstr_8E0C119EFE039F516A6F48B023AF4929AAE499", 0);

  if(var_1 == 1)
    _encstr_9AE62BB0A75A08C15BCA98B1E2063B10B667D08873E64081B6752F507EEB0F39782740787FAA98593ACDAC4E16::_encstr_9B5C119BF78B7709D30F50B8271486B3B21C0D();
  else if(var_1 == 2)
    _encstr_9AE62BB0A75A08C15BCA98B1E2063B10B667D08873E64081B6752F507EEB0F39782740787FAA98593ACDAC4E16::_encstr_8764133B2DC663C2B4739B95E199A5D8D7B4B92D47();

  if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8))
    var_0 = level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_A15E0E8540A310995BDBD0708236A329;

  return var_0;
}

_id_13082(var_0, var_1) {
  if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_950C1793553A733827EB57BE08AFE3E545508C206280404D16))
    self[[level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_950C1793553A733827EB57BE08AFE3E545508C206280404D16]](var_1);
  else {
    switch (var_0) {
      case "_encstr_97EA088D34DE831CB239":
        givewincondition(var_1);
        break;
      case "_encstr_85DE05A6B2AC0E":
        _getdeathstatecode::vehicle_damage_getpristinestateminhealth(var_1);
        break;
      case "_encstr_A143070DA0DA6B3885":
        oninteractionstarted(var_1);
        break;
      case "_encstr_92EF0C076332FF48B54A36AAF088":
        _encstr_8B521836D0F607E0B227A7DEB64C2D59CA0F33B4B1D71C586C5B(var_1);
        break;
      case "_encstr_AD14071ACA277B95B9":
        _encstr_9AE62BB0A75A08C15BCA98B1E2063B10B667D08873E64081B6752F507EEB0F39782740787FAA98593ACDAC4E16::_encstr_8B8A11A48FCB6705BFB0A808B16D8E69279F24(var_1);
        break;
      case "_encstr_A28B09B3D21BB185B473B9":
        _encstr_9AE62BB0A75A08C15BCA98B1E2063B10B667D08873E64081B6752F507EEB0F39782740787FAA98593ACDAC4E16::_encstr_9B1713A38B998229602097F7A8B9E94A279FEE1E62(var_1);
        break;
      default:
        givewincondition(var_1);
        break;
    }
  }
}

init_door_ent_flags(var_0, var_1, var_2) {
  var_3 = propmatchslope(var_1, var_2);
  var_4 = undefined;

  switch (var_0) {
    case "_encstr_97EA088D34DE831CB239":
      var_4 = var_3 init_carepackages();
      break;
    case "_encstr_85DE05A6B2AC0E":
      var_4 = var_3 init_carepackages();
      break;
    default:
      var_4 = var_3 init_carepackages();
  }

  var_3.winners = var_1;
  var_3.gameending = var_4;
  return var_3;
}

propmatchslope(var_0, var_1) {
  var_2 = propminigamefinish(var_0, var_1, 1);

  if(!isDefined(var_2[0].angles))
    var_2[0].angles = (0, 0, 0);

  return var_2[0];
}

propminigamefinish(var_0, var_1, var_2) {
  if(level.script == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    var_3 = scripts\engine\utility::getStructArray("_encstr_AB980FF8860769B60CF9DEA9515FAB2FE1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else if(level.script == "_encstr_84E70D78D34F41EDF1A24D5F7AFB23")
    var_3 = _id_11DC9();
  else if(scripts\cp_mp\utility\game_utility::turretdisabled())
    var_3 = _id_11DC7();
  else if(level.script == "_encstr_8CD508CA98A70FAFC01D")
    var_3 = _id_11DCD();
  else if(level.script == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319")
    var_3 = _id_11DF2();
  else if(level.script == "_encstr_8F340F3992796F28DFDFE808E736C1FF27")
    var_3 = _id_11DF3();
  else
    var_3 = _id_11DCE();

  if(isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8) && isDefined(level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_91461AF3EBDA03A27CD3EB85731783FF7FF4FDE538481983D275968E))
    var_3 = [[level._encstr_8D5015A2EB4FC5B0DCBDB9301D25DA20924AEFD36211E8._encstr_91461AF3EBDA03A27CD3EB85731783FF7FF4FDE538481983D275968E]](var_3);

  if(istrue(var_2))
    return _id_134D2(var_3, var_0, var_1);
  else
    return var_3;
}

_id_134D2(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::array_removeundefined(var_1);

  if(var_1.size > 0)
    var_3 = get_center_of_array(var_1);
  else
    var_3 = var_2;

  var_0 = sortbydistance(var_0, var_3);
  return var_0;
}

headicon_image(var_0, var_1) {
  var_2 = tablesort(var_0, var_1, 20000);

  foreach(var_4 in var_2)
  scripts\cp_mp\vehicles\vehicle::_id_14197(var_4);
}

hasscrapassist() {
  foreach(var_1 in level.defendkill.winners) {
    if(isDefined(var_1.watch_for_molotov_ambush_and_spawners)) {
      scripts\mp\utility\outline::outlinedisable(var_1.watch_for_molotov_ambush_and_spawners, var_1);
      var_1.watch_for_molotov_ambush_and_spawners = undefined;
    }
  }
}

_encstr_ABA411D8C62BC2E4AF9BD697465AB3CA3B993C() {
  foreach(var_1 in level.defendkill.winners) {
    if(isDefined(var_1))
      var_1 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
  }
}

_id_11DCE() {
  var_0 = [];
  var_0[0] = init_level_drop_structs((-35516, -26964, -290.492), (0, -37.2493, 0), 1);
  var_0[1] = init_level_drop_structs((-24507.4, -31751.5, -118), (0, 24.7373, 0));
  var_0[2] = init_level_drop_structs((-18475.3, -38031.3, 1390), (0, 21.3294, 0));
  var_0[3] = init_level_drop_structs((-22962.6, -26693.8, -133.431), (0, -79.9927, 0), 1);
  var_0[4] = init_level_drop_structs((-21665.5, -27275.8, -148.989), (0, -36.6941, 0), 1);
  var_0[5] = init_level_drop_structs((-21726, -25961.2, -146), (0, -108.126, 0), 1);
  var_0[6] = init_level_drop_structs((-12285.8, -40588.5, 518.07), (0, -148.112, 0), 1);
  var_0[7] = init_level_drop_structs((-36409.6, -14177.9, -286.708), (0, -15.7255, 0), 1);
  var_0[8] = init_level_drop_structs((-30525.8, -17654.2, -234.947), (0, -127.959, 0), 1);
  var_0[9] = init_level_drop_structs((-17170.3, -31131.8, 264.201), (0, -174.161, 0), 1);
  var_0[10] = init_level_drop_structs((-28797.3, -17400, -241.606), (0, 16.8587, 0));
  var_0[11] = init_level_drop_structs((-18155.4, -27275.3, -224.811), (0, -121.999, 0), 1);
  var_0[12] = init_level_drop_structs((-9975.39, -38284.4, 344.1), (0, -46.4665, 0), 1);
  var_0[13] = init_level_drop_structs((-29281.2, -13754.2, -145.391), (0, -11.8112, 0));
  var_0[14] = init_level_drop_structs((-17821.6, -23448.4, -262), (0, 62.3774, 0), 1);
  var_0[15] = init_level_drop_structs((-18619.8, -20889.8, -257.189), (0, -71.9892, 0), 1);
  var_0[16] = init_level_drop_structs((-14480.9, -25405.9, -288.831), (0, 154.786, 0), 1);
  var_0[17] = init_level_drop_structs((-9256.33, -33580.9, 158.984), (0, 146.051, 0), 1);
  var_0[18] = init_level_drop_structs((-8492.02, -34971.8, 166.312), (0, 161.494, 0), 1);
  var_0[19] = init_level_drop_structs((-16599, -22468.6, -278.939), (0, 154.273, 0), 1);
  var_0[20] = init_level_drop_structs((-11999.8, -28038.4, -31.998), (0, 5.45263, 0), 1);
  var_0[21] = init_level_drop_structs((-32056.9, -9169.36, -306.919), (0, 71.9528, 0));
  var_0[22] = init_level_drop_structs((-23530.6, -14806.7, -69.1128), (0, -153.028, 0), 1);
  var_0[23] = init_level_drop_structs((-27480.3, -10672.5, -69.3776), (0, -3.16859, 0), 1);
  var_0[24] = init_level_drop_structs((-4660.23, -38889.8, 608.219), (0, 63.5175, 0), 1);
  var_0[25] = init_level_drop_structs((-10475.2, -27452, -31.9999), (0, 118.642, 0), 1);
  var_0[26] = init_level_drop_structs((-20693.1, -15175.3, -304), (0, -66.6904, 0));
  var_0[27] = init_level_drop_structs((-16776.3, -18894, -338.316), (0, -15.0922, 0), 1);
  var_0[28] = init_level_drop_structs((-26751, -7621.31, 40.6807), (0, 58.4382, 0));
  var_0[29] = init_level_drop_structs((-13668.5, -18519.2, -368), (0, -143.119, 0));
  var_0[30] = init_level_drop_structs((-22473.8, -10149.8, -301.138), (0, -70.3961, 0), 1);
  var_0[31] = init_level_drop_structs((-11184.8, -21061.9, -315.854), (0, 5.70909, 0), 1);
  var_0[32] = init_level_drop_structs((-30018.7, -4590.08, -316.327), (0, 23.8697, 0));
  var_0[33] = init_level_drop_structs((-4140.38, -30726.9, 278.381), (0, -144.114, 0));
  var_0[34] = init_level_drop_structs((-34822.4, -1184.25, -263.947), (0, -71.6069, 0), 1);
  var_0[35] = init_level_drop_structs((-26229.5, -4015.4, -313.889), (0, -117.77, 0), 1);
  var_0[36] = init_level_drop_structs((-30027.8, -1782.43, -313.225), (0, 175.937, 0));
  var_0[37] = init_level_drop_structs((-27619.2, -2302.54, -313.891), (0, -8.77301, 0), 1);
  var_0[38] = init_level_drop_structs((-7118.65, -19301.2, -144), (0, -5.73525, 0), 1);
  var_0[39] = init_level_drop_structs((-10491.1, -14985.5, -360), (0, -103.058, 0), 1);
  var_0[40] = init_level_drop_structs((-14283.6, -11003.1, -315.39), (0, 7.08201, 0));
  var_0[41] = init_level_drop_structs((-23169, -3966.54, -321.134), (0, -83.3339, 0), 1);
  var_0[42] = init_level_drop_structs((-8787.73, -15589.1, -367.949), (0, 100.158, 0), 1);
  var_0[43] = init_level_drop_structs((-817.503, -25527.6, -256.485), (0, -66.9498, 0), 1);
  var_0[44] = init_level_drop_structs((-14242.2, -8993.57, -285.128), (0, 40.3822, 0));
  var_0[45] = init_level_drop_structs((4555.72, -36115.3, -200.848), (0, -156.66, 0), 1);
  var_0[46] = init_level_drop_structs((1627.87, -28799.2, 312), (0, 150.838, 0), 1);
  var_0[47] = init_level_drop_structs((-9101.03, -10035.7, -320), (0, 33.7296, 0));
  var_0[48] = init_level_drop_structs((-6042.41, -13135.6, -363.999), (0, -134.727, 0), 1);
  var_0[49] = init_level_drop_structs((3185.75, -25611.3, -288.702), (0, 93.1862, 0), 1);
  var_0[50] = init_level_drop_structs((1792.7, -23147, -290.615), (0, -151.835, 0), 1);
  var_0[51] = init_level_drop_structs((-35463.8, 7869.36, 52.9549), (0, -93.1204, 0), 1);
  var_0[52] = init_level_drop_structs((-716.066, -18775.2, 934), (0, -148.79, 0));
  var_0[53] = init_level_drop_structs((1588.6, -20401.1, -285), (0, -58.1805, 0));
  var_0[54] = init_level_drop_structs((12452, -35755.6, -484), (0, -28.7822, 0), 1);
  var_0[55] = init_level_drop_structs((4648.29, -19224.9, -286.002), (0, 28.824, 0), 1);
  var_0[56] = init_level_drop_structs((-21706.1, 6555.31, -279.84), (0, 5.8398, 0), 1);
  var_0[57] = init_level_drop_structs((-16018.1, 4086.84, -318.486), (0, 3.79374, 0), 1);
  var_0[58] = init_level_drop_structs((-25374.2, 10918.1, -320), (0, 120.887, 0), 1);
  var_0[59] = init_level_drop_structs((-12119.8, 2981.18, -329.815), (0, 105.554, 0), 1);
  var_0[60] = init_level_drop_structs((-14767.3, 5096.92, -400.009), (0, 131.701, 0), 1);
  var_0[61] = init_level_drop_structs((8177.97, -19326, -286.002), (0, 91.7841, 0), 1);
  var_0[62] = init_level_drop_structs((15726.9, -35325.4, 318.345), (0, 151.377, 0), 1);
  var_0[63] = init_level_drop_structs((11454.7, -22581.5, -214.023), (0, -92.045, 0), 1);
  var_0[64] = init_level_drop_structs((-21126.1, 11662.1, -317.002), (0, -174.747, 0), 1);
  var_0[65] = init_level_drop_structs((-7293.09, 3009.49, -317.508), (0, -152.562, 0), 1);
  var_0[66] = init_level_drop_structs((17629.6, -32800.1, 15.9988), (0, 7.32444, 0), 1);
  var_0[67] = init_level_drop_structs((504.818, -3834.63, -449), (0, 66.6309, 0), 1);
  var_0[68] = init_level_drop_structs((-25415.2, 15191.1, -325.003), (0, -84.1954, 0), 1);
  var_0[69] = init_level_drop_structs((13957.3, -21816.1, -194), (0, -75.6819, 0), 1);
  var_0[70] = init_level_drop_structs((-10176, 6713.5, -400), (0, 75.3382, 0), 1);
  var_0[71] = init_level_drop_structs((-15327.9, 10742.1, -400), (0, 32.2232, 0), 1);
  var_0[72] = init_level_drop_structs((8420.99, -11753.6, 306), (0, 83.4712, 0), 1);
  var_0[73] = init_level_drop_structs((-22216, 14718, -64.0002), (0, -82.0633, 0), 1);
  var_0[74] = init_level_drop_structs((-17022, 11976.4, -322.43), (0, 105.663, 0), 1);
  var_0[75] = init_level_drop_structs((-30924.8, 19829.7, 205), (0, -69.3892, 0), 1);
  var_0[76] = init_level_drop_structs((-2024.99, 3060.21, -330.017), (0, -158.048, 0), 1);
  var_0[77] = init_level_drop_structs((-28136.9, 19575.5, -448.227), (0, -98.4958, 0), 1);
  var_0[78] = init_level_drop_structs((-12771.2, 11772.2, -326.973), (0, 19.9583, 0), 1);
  var_0[79] = init_level_drop_structs((22131, -32223, -440), (0, 119.727, 0), 1);
  var_0[80] = init_level_drop_structs((-5075.7, 7706.88, -323.004), (0, 133.054, 0), 1);
  var_0[81] = init_level_drop_structs((-22334.3, 18697.4, 688.005), (0, 140.553, 0), 1);
  var_0[82] = init_level_drop_structs((-25425.5, 20658.8, -448), (0, 0.274191, 0), 1);
  var_0[83] = init_level_drop_structs((23625.3, -31238.1, -563.054), (0, -52.2092, 0), 1);
  var_0[84] = init_level_drop_structs((-33327.4, 24789.2, 12.4296), (0, -44.4776, 0), 1);
  var_0[85] = init_level_drop_structs((21118.3, -22709.8, -232), (0, 42.769, 0));
  var_0[86] = init_level_drop_structs((-28418.1, 23715.5, -447.994), (0, -89.5397, 0), 1);
  var_0[87] = init_level_drop_structs((16769.7, -13392.7, 356.076), (0, -37.8018, 0));
  var_0[88] = init_level_drop_structs((-13952.5, 17259.8, -324), (0, -76.2444, 0), 1);
  var_0[89] = init_level_drop_structs((24205.4, -25029.5, -328.008), (0, 169.376, 0), 1);
  var_0[90] = init_level_drop_structs((12118.5, -3994.79, -340.649), (0, -23.2087, 0), 1);
  var_0[91] = init_level_drop_structs((-17899.8, 21527.3, -450.34), (0, -8.05977, 0), 1);
  var_0[92] = init_level_drop_structs((22217.9, -18422.9, 632), (0, 162.28, 0), 1);
  var_0[93] = init_level_drop_structs((21407.1, -16363.3, 1916.75), (0, -1.0712, 0), 1);
  var_0[94] = init_level_drop_structs((-2832.02, 13488.4, -319.985), (0, -0.230498, 0), 1);
  var_0[95] = init_level_drop_structs((3266.46, 9488.52, -317.067), (0, 97.6153, 0), 1);
  var_0[96] = init_level_drop_structs((22117.5, -13790.4, 256.102), (0, 135.758, 0), 1);
  var_0[97] = init_level_drop_structs((24850.9, -18555.2, -208.2), (0, -76.8969, 0), 1);
  var_0[98] = init_level_drop_structs((-23053.6, 27499.5, -460.201), (0, 83.541, 0), 1);
  var_0[99] = init_level_drop_structs((-8326.54, 20049.9, -257.261), (0, 110.381, 0), 1);
  var_0[100] = init_level_drop_structs((19238.7, -6573.38, -40), (0, -88.569, 0));
  var_0[101] = init_level_drop_structs((-36685.3, 33440.3, 1474.01), (0, -73.7051, 0), 1);
  var_0[102] = init_level_drop_structs((26569.7, -16938.2, -221.571), (0, 92.2376, 0), 1);
  var_0[103] = init_level_drop_structs((26412.2, -13112.5, -264), (0, 55.7859, 0), 1);
  var_0[104] = init_level_drop_structs((20248.8, -2154.65, -506.989), (0, 116.839, 0));
  var_0[105] = init_level_drop_structs((-6577.92, 23388.3, -448.004), (0, -101.867, 0), 1);
  var_0[106] = init_level_drop_structs((18069.7, 1558.6, -590.448), (0, -85.7224, 0), 1);
  var_0[107] = init_level_drop_structs((-10855.2, 27363.9, -259.411), (0, 148.092, 0), 1);
  var_0[108] = init_level_drop_structs((-2919.92, 22409.8, -446.75), (0, -78.7055, 0), 1);
  var_0[109] = init_level_drop_structs((-16866.8, 30593, -225.8), (0, -75.0401, 0), 1);
  var_0[110] = init_level_drop_structs((37954.1, -37722.9, -577.993), (0, 69.8195, 0), 1);
  var_0[111] = init_level_drop_structs((35023.3, -24338.2, -566), (0, 53.0156, 0), 1);
  var_0[112] = init_level_drop_structs((16187.4, 8712.66, -332.163), (0, -84.2018, 0), 1);
  var_0[113] = init_level_drop_structs((-25609.6, 36743.4, 348.439), (0, -160.438, 0));
  var_0[114] = init_level_drop_structs((-14068.2, 31959.7, -250.623), (0, -153.916, 0), 1);
  var_0[115] = init_level_drop_structs((29348.7, -8361.65, -424.006), (0, -81.6393, 0), 1);
  var_0[116] = init_level_drop_structs((8670.39, 18913.1, -303.729), (0, 105.535, 0), 1);
  var_0[117] = init_level_drop_structs((35020.4, -16139.2, -572.017), (0, 58.7604, 0), 1);
  var_0[118] = init_level_drop_structs((19630.8, 10158.6, -451.09), (0, -142.492, 0), 1);
  var_0[119] = init_level_drop_structs((43465.3, -36148.1, 51.093), (0, 112.905, 0));
  var_0[120] = init_level_drop_structs((-19560, 39017.6, -640), (0, 105.902, 0));
  var_0[121] = init_level_drop_structs((3395.98, 28640.1, 1.42773), (0, 135.948, 0), 1);
  var_0[122] = init_level_drop_structs((-12456.8, 38252.8, 0.642883), (0, 136.198, 0));
  var_0[123] = init_level_drop_structs((34810.3, -3657.19, -488), (0, -139.433, 0));
  var_0[124] = init_level_drop_structs((48307, -38482.1, 2272), (0, 54.6218, 0), 1);
  var_0[125] = init_level_drop_structs((17534.5, 19736.7, 318.301), (0, -103.234, 0), 1);
  var_0[126] = init_level_drop_structs((49054.6, -37186.3, 2272.02), (0, 62.8379, 0), 1);
  var_0[127] = init_level_drop_structs((-26149.3, 47192.9, 2703.16), (0, 36.4515, 0));
  var_0[128] = init_level_drop_structs((50932.9, -41318, 1347), (0, -109.525, 0), 1);
  var_0[129] = init_level_drop_structs((44159.8, -13820.7, -87.1293), (0, -7.88874, 0));
  var_0[130] = init_level_drop_structs((51090.6, -34587.3, 1343.9), (0, -9.93786, 0), 1);
  var_0[131] = init_level_drop_structs((32681, 7595.22, -497.554), (0, -48.5794, 0), 1);
  var_0[132] = init_level_drop_structs((35336.5, 3905.92, -551.754), (0, -23.8152, 0), 1);
  var_0[133] = init_level_drop_structs((52357.4, -33339, 1258.09), (0, -20.541, 0), 1);
  var_0[134] = init_level_drop_structs((-520.246, 39710.8, 2783), (0, -72.5011, 0), 1);
  var_0[135] = init_level_drop_structs((45634.6, -11566.6, -58.2778), (0, -151.105, 0), 1);
  var_0[136] = init_level_drop_structs((50376.7, -21886.4, -395.252), (0, -23.787, 0));
  var_0[137] = init_level_drop_structs((51570.2, -24783.1, -113.531), (0, 104.684, 0), 1);
  var_0[138] = init_level_drop_structs((39824, 1114.83, -424.993), (0, 138.361, 0), 1);
  var_0[139] = init_level_drop_structs((25390.7, 20043.1, 1343.21), (0, 135.63, 0), 1);
  var_0[140] = init_level_drop_structs((52294.1, -25802.7, -83.0376), (0, -19.67, 0), 1);
  var_0[141] = init_level_drop_structs((-11742.3, 47596, 1790.51), (0, -161.796, 0), 1);
  var_0[142] = init_level_drop_structs((44198.1, -4238.47, 266.547), (0, -102.295, 0));
  var_0[143] = init_level_drop_structs((48747.6, -12179.9, 14.8108), (0, -111.192, 0), 1);
  var_0[144] = init_level_drop_structs((46453.4, -6647.04, 208.457), (0, -15.0621, 0), 1);
  var_0[145] = init_level_drop_structs((12849.3, 34747.5, 2458.5), (0, -39.4017, 0), 1);
  var_0[146] = init_level_drop_structs((52493.1, -17205.6, -391.658), (0, 19.0522, 0), 1);
  var_0[147] = init_level_drop_structs((54470.9, -21095.7, -394.817), (0, -68.4661, 0));
  var_0[148] = init_level_drop_structs((-24417, 56523.2, 2659.76), (0, -129.922, 0), 1);
  var_0[149] = init_level_drop_structs((37257.1, 13799.8, 232), (0, 22.0809, 0), 1);
  var_0[150] = init_level_drop_structs((23294, 29633.7, 1019.7), (0, 17.9623, 0), 1);
  var_0[151] = init_level_drop_structs((-9892.05, 53353.9, 2428.22), (0, -25.4412, 0));
  var_0[152] = init_level_drop_structs((49428.4, 1843.77, 19.9863), (0, 175.256, 0), 1);
  var_0[153] = init_level_drop_structs((3411.24, 49881.5, 1032), (0, 83.1958, 0), 1);
  var_0[154] = init_level_drop_structs((57090, -11008.2, -433.158), (0, -94.4655, 0), 1);
  var_0[155] = init_level_drop_structs((20175.4, 39040, 957.372), (0, 82.8313, 0), 1);
  var_0[156] = init_level_drop_structs((-8255.86, 57148.3, 1071.37), (0, -11.2614, 0), 1);
  var_0[157] = init_level_drop_structs((51848.1, 3726.24, 29.3418), (0, 172.199, 0), 1);
  var_0[158] = init_level_drop_structs((50898.1, 6776.73, 29.7878), (0, -8.3196, 0), 1);
  var_0[159] = init_level_drop_structs((-17676, 62373.4, 1908.92), (0, -4.78614, 0));
  var_0[160] = init_level_drop_structs((12324.8, 47493.6, 1036), (0, -44.8196, 0), 1);
  var_0[161] = init_level_drop_structs((29716.1, 34472.4, 435.436), (0, -133.228, 0), 1);
  var_0[162] = init_level_drop_structs((37269.7, 27514, 190.688), (0, -36.7275, 0), 1);
  var_0[163] = init_level_drop_structs((46679.8, 17932.4, -352.184), (0, 157.463, 0), 1);
  var_0[164] = init_level_drop_structs((53649.7, 7546.33, 29.3552), (0, -107.59, 0), 1);
  var_0[165] = init_level_drop_structs((57918.4, 650.832, 41.0137), (0, 106.07, 0), 1);
  var_0[166] = init_level_drop_structs((7073.74, 57285.5, 1036), (0, 164.547, 0), 1);
  var_0[167] = init_level_drop_structs((27957.2, 43805.1, 1753.23), (0, -142.754, 0), 1);
  var_0[168] = init_level_drop_structs((20050.9, 52735.7, 1917.76), (0, 137.974, 0), 1);
  var_0[169] = init_level_drop_structs((43887.3, 31928.7, -198.527), (0, -93.8224, 0), 1);
  var_0[170] = init_level_drop_structs((44717.5, 39263.5, -42.8776), (0, -102.018, 0), 1);
  var_0[171] = init_level_drop_structs((37958.5, 47398, 944.177), (0, -119.853, 0), 1);
  return var_0;
}

_id_11DCD() {
  var_0 = [];
  var_0[0] = init_level_drop_structs((-35516, -26964, -290.492), (0, -37.2493, 0), 1);
  var_0[1] = init_level_drop_structs((-24507.4, -31751.5, -118), (0, 24.7373, 0), 1);
  var_0[2] = init_level_drop_structs((-18335, -38528, 1426), (0, 21.3294, 0), 1);
  var_0[3] = init_level_drop_structs((-22962.6, -26693.8, -133.431), (0, -79.9927, 0), 1);
  var_0[4] = init_level_drop_structs((-21665.5, -27275.8, -148.989), (0, -36.6941, 0), 1);
  var_0[5] = init_level_drop_structs((-21726, -25961.2, -146), (0, -108.126, 0), 1);
  var_0[6] = init_level_drop_structs((-17034.3, -31571.8, 264.201), (0, -174.161, 0), 1);
  var_0[7] = init_level_drop_structs((-36409.6, -14177.9, -286.708), (0, -15.7255, 0), 1);
  var_0[8] = init_level_drop_structs((-30525.8, -17654.2, -234.947), (0, -127.959, 0), 1);
  var_0[9] = init_level_drop_structs((-28797.3, -17400, -241.606), (0, 16.8587, 0), 1);
  var_0[10] = init_level_drop_structs((-18155.4, -27275.3, -224.811), (0, -121.999, 0), 1);
  var_0[11] = init_level_drop_structs((-10441.3, -39384.6, 348.396), (0, -75.0314, 0));
  var_0[12] = init_level_drop_structs((-29281.2, -13754.2, -145.391), (0, -11.8112, 0), 1);
  var_0[13] = init_level_drop_structs((-17821.6, -23448.4, -262), (0, 62.3774, 0), 1);
  var_0[14] = init_level_drop_structs((-18619.8, -20889.8, -257.189), (0, -71.9892, 0), 1);
  var_0[15] = init_level_drop_structs((-9256.33, -33580.9, 158.984), (0, 146.051, 0), 1);
  var_0[16] = init_level_drop_structs((-8492.02, -34971.8, 166.312), (0, 161.494, 0), 1);
  var_0[17] = init_level_drop_structs((-14337.1, -25432.4, -288.003), (0, 18.2365, 0));
  var_0[18] = init_level_drop_structs((-16599, -22468.6, -278.939), (0, 154.273, 0), 1);
  var_0[19] = init_level_drop_structs((-11999.8, -28038.4, -31.998), (0, 5.45263, 0), 1);
  var_0[20] = init_level_drop_structs((-32056.9, -9169.36, -306.919), (0, 71.9528, 0), 1);
  var_0[21] = init_level_drop_structs((-23530.6, -14806.7, -69.1128), (0, -153.028, 0), 1);
  var_0[22] = init_level_drop_structs((-27480.3, -10672.5, -69.3776), (0, -3.16859, 0), 1);
  var_0[23] = init_level_drop_structs((-4660.23, -38889.8, 608.219), (0, 63.5175, 0), 1);
  var_0[24] = init_level_drop_structs((-10475.2, -27452, -31.9999), (0, 118.642, 0), 1);
  var_0[25] = init_level_drop_structs((-20693.1, -15175.3, -304), (0, -66.6904, 0), 1);
  var_0[26] = init_level_drop_structs((-16776.3, -18894, -338.316), (0, -15.0922, 0), 1);
  var_0[27] = init_level_drop_structs((-13668.5, -18519.2, -368), (0, -143.119, 0), 1);
  var_0[28] = init_level_drop_structs((-22473.8, -10149.8, -301.138), (0, -70.3961, 0), 1);
  var_0[29] = init_level_drop_structs((-11184.8, -21061.9, -315.854), (0, 5.70909, 0), 1);
  var_0[30] = init_level_drop_structs((-26223.1, -7239.33, 36.2852), (0, -142.791, 0));
  var_0[31] = init_level_drop_structs((-30018.7, -4590.08, -316.327), (0, 23.8697, 0), 1);
  var_0[32] = init_level_drop_structs((-4140.38, -30726.9, 278.381), (0, -144.114, 0), 1);
  var_0[33] = init_level_drop_structs((-34822.4, -1184.25, -263.947), (0, -71.6069, 0), 1);
  var_0[34] = init_level_drop_structs((-30043.8, -1902.43, -313.225), (0, 175.937, 0), 1);
  var_0[35] = init_level_drop_structs((-26229.5, -4015.4, -313.889), (0, -117.77, 0), 1);
  var_0[36] = init_level_drop_structs((-27619.2, -2302.54, -313.891), (0, -8.77301, 0), 1);
  var_0[37] = init_level_drop_structs((-7118.65, -19301.2, -144), (0, -5.73525, 0), 1);
  var_0[38] = init_level_drop_structs((-10491.1, -14985.5, -360), (0, -103.058, 0), 1);
  var_0[39] = init_level_drop_structs((-14483.6, -10859.1, -315.39), (0, 7.08201, 0), 1);
  var_0[40] = init_level_drop_structs((-23169, -3966.54, -321.134), (0, -83.3339, 0), 1);
  var_0[41] = init_level_drop_structs((-8787.73, -15589.1, -367.949), (0, 100.158, 0), 1);
  var_0[42] = init_level_drop_structs((-817.503, -25527.6, -256.485), (0, -66.9498, 0), 1);
  var_0[43] = init_level_drop_structs((-14242.2, -8993.57, -285.128), (0, 40.3822, 0), 1);
  var_0[44] = init_level_drop_structs((4555.72, -36115.3, -200.848), (0, -156.66, 0), 1);
  var_0[45] = init_level_drop_structs((1627.87, -28799.2, 312), (0, 150.838, 0), 1);
  var_0[46] = init_level_drop_structs((-9101.03, -10035.7, -320), (0, 33.7296, 0), 1);
  var_0[47] = init_level_drop_structs((-6042.41, -13135.6, -363.999), (0, -134.727, 0), 1);
  var_0[48] = init_level_drop_structs((3185.75, -25611.3, -288.702), (0, 93.1862, 0), 1);
  var_0[49] = init_level_drop_structs((1792.7, -23147, -290.615), (0, -151.835, 0), 1);
  var_0[50] = init_level_drop_structs((-35463.8, 7869.36, 52.9549), (0, -93.1204, 0), 1);
  var_0[51] = init_level_drop_structs((-716.066, -18775.2, 934), (0, -148.79, 0), 1);
  var_0[52] = init_level_drop_structs((1588.6, -20401.1, -285), (0, -58.1805, 0), 1);
  var_0[53] = init_level_drop_structs((12452, -35755.6, -484), (0, -28.7822, 0), 1);
  var_0[54] = init_level_drop_structs((4648.29, -19224.9, -286.002), (0, 28.824, 0), 1);
  var_0[55] = init_level_drop_structs((-21706.1, 6555.31, -279.84), (0, 5.8398, 0), 1);
  var_0[56] = init_level_drop_structs((-16018.1, 4086.84, -318.486), (0, 3.79374, 0), 1);
  var_0[57] = init_level_drop_structs((-25374.2, 10918.1, -320), (0, 120.887, 0), 1);
  var_0[58] = init_level_drop_structs((-12119.8, 2981.18, -329.815), (0, 105.554, 0), 1);
  var_0[59] = init_level_drop_structs((-14767.3, 5096.92, -400.009), (0, 131.701, 0), 1);
  var_0[60] = init_level_drop_structs((8177.97, -19326, -286.002), (0, 91.7841, 0), 1);
  var_0[61] = init_level_drop_structs((15726.9, -35325.4, 318.345), (0, 151.377, 0), 1);
  var_0[62] = init_level_drop_structs((11454.7, -22581.5, -214.023), (0, -92.045, 0), 1);
  var_0[63] = init_level_drop_structs((-20678.1, 11742.1, -320.114), (0, -174.747, 0), 1);
  var_0[64] = init_level_drop_structs((-7293.09, 3009.49, -317.508), (0, -152.562, 0), 1);
  var_0[65] = init_level_drop_structs((17629.6, -32800.1, 15.9988), (0, 7.32444, 0), 1);
  var_0[66] = init_level_drop_structs((504.818, -3834.63, -449), (0, 66.6309, 0), 1);
  var_0[67] = init_level_drop_structs((-25415.2, 15191.1, -325.003), (0, -84.1954, 0), 1);
  var_0[68] = init_level_drop_structs((13957.3, -21816.1, -194), (0, -75.6819, 0), 1);
  var_0[69] = init_level_drop_structs((-10176, 6713.5, -400), (0, 75.3382, 0), 1);
  var_0[70] = init_level_drop_structs((-15327.9, 10742.1, -400), (0, 32.2232, 0), 1);
  var_0[71] = init_level_drop_structs((8420.99, -11753.6, 306), (0, 83.4712, 0), 1);
  var_0[72] = init_level_drop_structs((-22216, 14718, -64.0002), (0, -82.0633, 0), 1);
  var_0[73] = init_level_drop_structs((-17022, 11976.4, -322.43), (0, 105.663, 0), 1);
  var_0[74] = init_level_drop_structs((-30924.8, 19829.7, 205), (0, -69.3892, 0), 1);
  var_0[75] = init_level_drop_structs((-2024.99, 3060.21, -330.017), (0, -158.048, 0), 1);
  var_0[76] = init_level_drop_structs((-12771.2, 11772.2, -326.973), (0, 19.9583, 0), 1);
  var_0[77] = init_level_drop_structs((-22206.3, 18001.4, 688.005), (0, 140.553, 0), 1);
  var_0[78] = init_level_drop_structs((22131, -32223, -440), (0, 119.727, 0), 1);
  var_0[79] = init_level_drop_structs((-3427.7, 6818.88, -323.004), (0, 133.054, 0), 1);
  var_0[80] = init_level_drop_structs((-25425.5, 20658.8, -448), (0, 0.274191, 0), 1);
  var_0[81] = init_level_drop_structs((23625.3, -31238.1, -563.054), (0, -52.2092, 0), 1);
  var_0[82] = init_level_drop_structs((-33327.4, 24789.2, 12.4296), (0, -44.4776, 0), 1);
  var_0[83] = init_level_drop_structs((21118.3, -22709.8, -232), (0, 42.769, 0), 1);
  var_0[84] = init_level_drop_structs((-28418.1, 23715.5, -447.994), (0, -89.5397, 0), 1);
  var_0[85] = init_level_drop_structs((16769.7, -13392.7, 356.076), (0, -37.8018, 0), 1);
  var_0[86] = init_level_drop_structs((-13952.5, 17259.8, -324), (0, -76.2444, 0), 1);
  var_0[87] = init_level_drop_structs((24205.4, -25029.5, -328.008), (0, 169.376, 0), 1);
  var_0[88] = init_level_drop_structs((11918.5, -3474.79, -347.198), (0, 336.788, 0));
  var_0[89] = init_level_drop_structs((-17899.8, 21527.3, -450.34), (0, -8.05977, 0), 1);
  var_0[90] = init_level_drop_structs((22217.9, -18422.9, 632), (0, 162.28, 0), 1);
  var_0[91] = init_level_drop_structs((20216.9, -14855.9, 4440), (0, -105.534, 0));
  var_0[92] = init_level_drop_structs((-2832.02, 13488.4, -319.985), (0, -0.230498, 0), 1);
  var_0[93] = init_level_drop_structs((3266.46, 9488.52, -317.067), (0, 97.6153, 0), 1);
  var_0[94] = init_level_drop_structs((22117.5, -13790.4, 256.102), (0, 135.758, 0), 1);
  var_0[95] = init_level_drop_structs((24850.9, -18555.2, -208.2), (0, -76.8969, 0), 1);
  var_0[96] = init_level_drop_structs((-23053.6, 27499.5, -460.201), (0, 83.541, 0), 1);
  var_0[97] = init_level_drop_structs((-8326.54, 20049.9, -257.261), (0, 110.381, 0), 1);
  var_0[98] = init_level_drop_structs((19238.7, -6573.38, -40), (0, -88.569, 0), 1);
  var_0[99] = init_level_drop_structs((-36685.3, 33440.3, 1474.01), (0, -73.7051, 0), 1);
  var_0[100] = init_level_drop_structs((26569.7, -16938.2, -221.571), (0, 92.2376, 0), 1);
  var_0[101] = init_level_drop_structs((26412.2, -13112.5, -264), (0, 55.7859, 0), 1);
  var_0[102] = init_level_drop_structs((20248.8, -2154.65, -506.989), (0, 116.839, 0), 1);
  var_0[103] = init_level_drop_structs((-6577.92, 23388.3, -448.004), (0, -101.867, 0), 1);
  var_0[104] = init_level_drop_structs((18069.7, 1558.6, -590.448), (0, -85.7224, 0), 1);
  var_0[105] = init_level_drop_structs((33871.9, -25305.2, -566), (0, -31.8678, 0));
  var_0[106] = init_level_drop_structs((-2919.92, 22409.8, -446.75), (0, -78.7055, 0), 1);
  var_0[107] = init_level_drop_structs((-16866.8, 30593, -225.8), (0, -75.0401, 0), 1);
  var_0[108] = init_level_drop_structs((37954.1, -37722.9, -577.993), (0, 69.8195, 0), 1);
  var_0[109] = init_level_drop_structs((-10855.2, 28227.9, -286), (0, 148.092, 0), 1);
  var_0[110] = init_level_drop_structs((6617.88, 17297.6, -289.993), (0, -64.9318, 0));
  var_0[111] = init_level_drop_structs((16187.4, 8712.66, -332.163), (0, -84.2018, 0), 1);
  var_0[112] = init_level_drop_structs((-14068.2, 31959.7, -250.623), (0, -153.916, 0), 1);
  var_0[113] = init_level_drop_structs((29348.7, -8361.65, -424.006), (0, -81.6393, 0), 1);
  var_0[114] = init_level_drop_structs((35020.4, -16139.2, -572.017), (0, 58.7604, 0), 1);
  var_0[115] = init_level_drop_structs((19630.8, 10158.6, -451.09), (0, -142.492, 0), 1);
  var_0[116] = init_level_drop_structs((43465.3, -36148.1, 51.093), (0, 112.905, 0), 1);
  var_0[117] = init_level_drop_structs((-19560, 39017.6, -640), (0, 105.902, 0), 1);
  var_0[118] = init_level_drop_structs((3395.98, 28640.1, 1.42773), (0, 135.948, 0), 1);
  var_0[119] = init_level_drop_structs((-12456.8, 38252.8, 0.642883), (0, 136.198, 0), 1);
  var_0[120] = init_level_drop_structs((30374.5, 1918, -584), (0, 240.147, 0), 1);
  var_0[121] = init_level_drop_structs((34810.3, -3657.19, -488), (0, -139.433, 0), 1);
  var_0[122] = init_level_drop_structs((48307, -38482.1, 2272), (0, 54.6218, 0), 1);
  var_0[123] = init_level_drop_structs((17534.5, 19736.7, 318.301), (0, -103.234, 0), 1);
  var_0[124] = init_level_drop_structs((49054.6, -37186.3, 2272.02), (0, 62.8379, 0), 1);
  var_0[125] = init_level_drop_structs((-26149.3, 47192.9, 2703.16), (0, 36.4515, 0), 1);
  var_0[126] = init_level_drop_structs((50932.9, -41318, 1347), (0, -109.525, 0), 1);
  var_0[127] = init_level_drop_structs((-27964, 48715, 2554), (0, 116.668, 0));
  var_0[128] = init_level_drop_structs((44159.8, -13820.7, -87.1293), (0, -7.88874, 0), 1);
  var_0[129] = init_level_drop_structs((51090.6, -34587.3, 1343.9), (0, -9.93786, 0), 1);
  var_0[130] = init_level_drop_structs((32681, 7595.22, -497.554), (0, -48.5794, 0), 1);
  var_0[131] = init_level_drop_structs((35392.5, 3953.92, -537.668), (0, -23.8152, 0), 1);
  var_0[132] = init_level_drop_structs((52357.4, -33339, 1258.09), (0, -20.541, 0), 1);
  var_0[133] = init_level_drop_structs((45354.6, -11966.6, -80.277), (0, -151.105, 0), 1);
  var_0[134] = init_level_drop_structs((-520.246, 39710.8, 2783), (0, -72.5011, 0), 1);
  var_0[135] = init_level_drop_structs((50376.7, -21886.4, -395.252), (0, -23.787, 0), 1);
  var_0[136] = init_level_drop_structs((51570.2, -24783.1, -113.531), (0, 104.684, 0), 1);
  var_0[137] = init_level_drop_structs((39824, 1114.83, -424.993), (0, 138.361, 0), 1);
  var_0[138] = init_level_drop_structs((52294.1, -25802.7, -83.0376), (0, -19.67, 0), 1);
  var_0[139] = init_level_drop_structs((44324.8, -4273.61, 263.415), (0, -177.943, 0));
  var_0[140] = init_level_drop_structs((46453.4, -6647.04, 208.457), (0, -15.0621, 0), 1);
  var_0[141] = init_level_drop_structs((49114.5, -11366.7, 9.90356), (0, 70.9343, 0));
  var_0[142] = init_level_drop_structs((12849.3, 34747.5, 2458.5), (0, -39.4017, 0), 1);
  var_0[143] = init_level_drop_structs((-24761.1, 54243.7, 2632.83), (0, -110.996, 0));
  var_0[144] = init_level_drop_structs((52493.1, -17205.6, -391.658), (0, 19.0522, 0), 1);
  var_0[145] = init_level_drop_structs((54022.2, -21039.7, -397.627), (0, -67.3496, 0));
  var_0[146] = init_level_drop_structs((-24417, 56523.2, 2659.76), (0, -129.922, 0), 1);
  var_0[147] = init_level_drop_structs((37257.1, 13799.8, 232), (0, 22.0809, 0), 1);
  var_0[148] = init_level_drop_structs((23294, 29633.7, 1027.7), (0, 17.9623, 0), 1);
  var_0[149] = init_level_drop_structs((-9892.05, 53353.9, 2428.22), (0, -25.4412, 0), 1);
  var_0[150] = init_level_drop_structs((49428.4, 1843.77, 19.9863), (0, 175.256, 0), 1);
  var_0[151] = init_level_drop_structs((3411.24, 49881.5, 1032), (0, 83.1958, 0), 1);
  var_0[152] = init_level_drop_structs((57090, -11008.2, -433.158), (0, -94.4655, 0), 1);
  var_0[153] = init_level_drop_structs((20175.4, 39040, 957.372), (0, 82.8313, 0), 1);
  var_0[154] = init_level_drop_structs((-8255.86, 57148.3, 1071.37), (0, -11.2614, 0), 1);
  var_0[155] = init_level_drop_structs((51848.1, 3726.24, 29.3418), (0, 172.199, 0), 1);
  var_0[156] = init_level_drop_structs((50898.1, 6776.73, 29.7878), (0, -8.3196, 0), 1);
  var_0[157] = init_level_drop_structs((-17676, 62373.4, 1908.92), (0, -4.78614, 0), 1);
  var_0[158] = init_level_drop_structs((12324.8, 47493.6, 1036), (0, -44.8196, 0), 1);
  var_0[159] = init_level_drop_structs((29716.1, 34472.4, 587.436), (0, -133.228, 0), 1);
  var_0[160] = init_level_drop_structs((37269.7, 27514, 190.688), (0, -36.7275, 0), 1);
  var_0[161] = init_level_drop_structs((46679.8, 17932.4, -352.184), (0, 157.463, 0), 1);
  var_0[162] = init_level_drop_structs((53649.7, 7546.33, 29.3552), (0, -107.59, 0), 1);
  var_0[163] = init_level_drop_structs((32652.2, 34860.1, 587.138), (0, -18.5619, 0));
  var_0[164] = init_level_drop_structs((57918.4, 650.832, 41.0137), (0, 106.07, 0), 1);
  var_0[165] = init_level_drop_structs((7073.74, 57285.5, 1036), (0, 164.547, 0), 1);
  var_0[166] = init_level_drop_structs((28049.2, 43607.1, 1769.23), (0, -142.754, 0), 1);
  var_0[167] = init_level_drop_structs((20050.9, 52735.7, 1917.76), (0, 137.974, 0), 1);
  var_0[168] = init_level_drop_structs((43887.3, 31928.7, -198.527), (0, -93.8224, 0), 1);
  var_0[169] = init_level_drop_structs((38241.2, 38003.4, 555.227), (0, -33.0121, 0));
  return var_0;
}

_id_11DF2() {
  var_0 = [];
  var_0[0] = init_level_drop_structs((-20150, -19994, 888), (0, 90, 0));
  return var_0;
}

_id_11DC9() {
  var_0 = [];
  var_0[var_0.size] = init_level_drop_structs((29786.7, 41132.6, 749.673), (0, -132.937, 0));
  var_0[var_0.size] = init_level_drop_structs((31330.7, 43775.2, 685), (0, -111.923, 0));
  var_0[var_0.size] = init_level_drop_structs((37671.1, 42532.2, 857.039), (0, -169.422, 0));
  var_0[var_0.size] = init_level_drop_structs((40311.2, 44060.2, 1326.98), (0, 169.247, 0));
  return var_0;
}

_id_11DC7() {
  var_0 = [];

  if(getdvarint("_encstr_AC2A11B9C6C9AF31E4F5E93C0E7DB23CCC5A1B", 0) == 1) {
    var_0[0] = init_level_drop_structs((-1161, 9916, 653), (0, 60, 0));
    var_0[1] = init_level_drop_structs((-855, -9036, 151), (0, 218, 0));
    var_0[2] = init_level_drop_structs((-597, 6622, 1062), (0, 155, 0));
    var_0[3] = init_level_drop_structs((-1262, 4134, 1073), (0, 261, 0));
    var_0[4] = init_level_drop_structs((1058, -2260, 1360), (0, 325, 0));
    var_0[5] = init_level_drop_structs((2056, -5660, 699), (0, 145, 0));
    var_0[6] = init_level_drop_structs((2485, -363, 836), (0, 15, 0));
    var_0[7] = init_level_drop_structs((-2031, -4864, 686), (0, 102, 0));
    var_0[8] = init_level_drop_structs((-4420, 3862, 615), (0, 43, 0));
    var_0[9] = init_level_drop_structs((-4754, 1351, 716), (0, 120, 0));
  } else {
    var_0[0] = init_level_drop_structs((-3899, 2190, 693), (0, 159, 0));
    var_0[1] = init_level_drop_structs((-786, -11590, 184), (0, 0, 0));
    var_0[2] = init_level_drop_structs((1548, -5824, 698), (0, 235, 0));
    var_0[3] = init_level_drop_structs((5503, -4329, 144), (0, 0, 0));
    var_0[4] = init_level_drop_structs((-4054, -2949, 628), (0, 270, 0));
    var_0[5] = init_level_drop_structs((848, -2529, 1360), (0, 270, 0));
    var_0[6] = init_level_drop_structs((-32, 84, 1760), (0, 50, 0));
    var_0[7] = init_level_drop_structs((3655, 3712, 193), (0, 355, 0));
    var_0[8] = init_level_drop_structs((-939, 4528, 1072), (0, 260, 0));
    var_0[9] = init_level_drop_structs((1154, 3796, 949), (0, 320, 0));
    var_0[10] = init_level_drop_structs((-4967, 4679, 616), (0, 90, 0));
    var_0[11] = init_level_drop_structs((-2274, 6468, 880), (0, 180, 0));
    var_0[12] = init_level_drop_structs((-1398, 10000, 656), (0, 45, 0));
    var_0[13] = init_level_drop_structs((1756, 9261, 664), (0, 95, 0));
    var_0[14] = init_level_drop_structs((489, 7480, 837), (0, 285, 0));
    var_0[15] = init_level_drop_structs((-1448, -2097, 1262), (0, 181, 0));
    var_0[16] = init_level_drop_structs((-4485, 5703, 152), (0, 200, 0));
    var_0[17] = init_level_drop_structs((-2098, -8823, 154), (0, 0, 0));
    var_0[18] = init_level_drop_structs((-6510, 76, 90), (0, 230, 0));
  }

  return var_0;
}

_id_11DF3() {
  var_0 = [];
  var_0[0] = init_level_drop_structs((-10348, -252, 337), (0, 270, 0));
  var_0[1] = init_level_drop_structs((-9884, -2228, 337.175), (0, 314, 0));
  var_0[2] = init_level_drop_structs((7540.97, -5987.92, 517.681), (0, 0, 0));
  var_0[3] = init_level_drop_structs((11692, -3868, 497.961), (0, 15, 0));
  var_0[4] = init_level_drop_structs((11104, 2240, 525.771), (0, 300, 0));
  var_0[5] = init_level_drop_structs((436, 2188, 1562.25), (0, 150, 0));
  var_0[6] = init_level_drop_structs((6252.97, 3460.08, 925.001), (0, 70, 0));
  var_0[7] = init_level_drop_structs((-692, 7760, 1798.25), (0, 0, 0));
  var_0[8] = init_level_drop_structs((1040, -112, 1294), (0, 319, 0));
  var_0[9] = init_level_drop_structs((2492, -3444, 1003), (0, 5, 0));
  var_0[10] = init_level_drop_structs((-5972, 1832, 1109.87), (0, 84, 0));
  var_0[11] = init_level_drop_structs((-6588, -216, 1191), (0, 84, 0));
  return var_0;
}

init_level_drop_structs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  return var_3;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

init_carepackages() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 useanimtree(#animtree);
  var_0.animname = "_encstr_87730A95DCC82DCDCE1A855B";
  return var_0;
}

musictriggerthink(var_0) {
  self notify("_encstr_9B510F55ED106C838CAE2A42D1D50F24F8");
  self endon("_encstr_9B510F55ED106C838CAE2A42D1D50F24F8");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0 * 20;
  var_2 = 1;
  var_3 = 1.0 / var_1;
  self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    waitframe();
    var_2 = var_2 - var_3;
    var_2 = max(var_2, 0);
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_2);
  }
}

nag_get_in_heli(var_0) {
  self notify("_encstr_9ABC1089BD4C601842478D8BC30AC808F593");
  self endon("_encstr_9ABC1089BD4C601842478D8BC30AC808F593");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0 * 20;
  var_2 = 0;
  var_3 = 1.0 / var_1;
  self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    waitframe();
    var_2 = var_2 + var_3;
    var_2 = min(var_2, 1);
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_2);
  }
}

nakeddrophandleloadout(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level.defendkill endon("_encstr_B44E0A0AB9F8BE9A680B0323");

  for(;;) {
    if(!self isspectatingplayer()) {
      waitframe();
      continue;
    }

    var_1 = self getspectatingplayer();

    if(isDefined(var_1)) {
      var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
      self cameradefault();
      self cameralinkTo(var_0, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 1);
    }

    waitframe();
  }
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2, var_3) {
  self.animname = var_0;
  var_4 = var_2.origin;

  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_5.player = self;
  self.player_rig = var_5;
  self.player_rig setModel(var_1);
  self.player_rig hide();
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig._id_145CA = self._id_145CA;
  self.player_rig.cinematic_motion_override = scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = scripts\mp\utility\infilexfil::handledofnotetrack;

  if(!isDefined(var_2._id_124EA))
    var_2._id_124EA = [];

  if(isPlayer(self)) {
    self playerlinktodelta(self.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 0, 0, 0, 0, 1);
    var_2._id_124EA[var_2._id_124EA.size] = self.player_rig;
  } else
    self.player_rig._id_145CA = 0;

  self notify("_encstr_A9920CF579D7F1B6CBAAD963B24B");
}

remove_player_rig() {
  if(isDefined(self))
    self unlink();

  if(isDefined(self.player_rig))
    self.player_rig delete();
}

get_center_of_array(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1 = (var_1[0] + var_0[var_2].origin[0], var_1[1] + var_0[var_2].origin[1], var_1[2] + var_0[var_2].origin[2]);

  if(var_0.size != 0)
    return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);

  return undefined;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

givewincondition(var_0) {
  thread givestartingarmor(5, var_0);

  if(!getdvarint("_encstr_83D9183FBB4A29FE03311178EA07A0B0A970B993237770B54B9B")) {
    self._id_13CE3 = processvoqueue();
    unloadinfiltransient(self._id_13CE3);
    setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 18);
    var_1 = getdvarfloat("_encstr_AD141ADCC627FA8939D7ACE623F5A3275837E6B4CACDE8FADD855AD1", 6.0);
    wait(var_1);
  }

  var_2 = _id_135CA("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261");
  var_2 hidepart("_encstr_B236182349D4173578ABEED775E0BB0F8626FA2AD13DB7E1CA03");
  var_2 hidepart("_encstr_843618CBF9E88F1A771303CF4D28D3E7E886C65511087DF1F7BD");
  var_2 hidepart("_encstr_8A36182BF0115FD2CBBB8DC91EEF7B271B99FB339829DD39816E");
  var_2 hidepart("_encstr_A23618CDAE824F408947A82903AF3B77BB594E59060AF3CE202A");
  var_2 hidepart("_encstr_AF6C1875373ACF53C893CDC978F505B763C09E91D2A1DF176173");
  var_2 hidepart("_encstr_8D6C18C0D9AC400B4E6A344F33C063675AE7C610CEF3A56FD832");
  var_2 hidepart("_encstr_A56C18C1AF5A80905964C8A6CA0FC8C0A3EF65694792550120EA");
  var_2 hidepart("_encstr_866C1860466F102157FFE0982A4809A03E9001193734A826282A");
  self.onkillingblow = var_2;
  givexpwithtext();
  var_3 = ["_encstr_A9AB18A8FFC988AF627B7F19471A53E86F129381A20F784EDA7F", "_encstr_8EEC09159F6238030BFA23"];
  var_4 = [var_3];
  var_5 = "_encstr_828E1EB92D9C305003AFC9C7F3D903683C04019092D498FE297BEDF3EBC2D6C8";
  var_6 = _id_135CA(var_5, undefined, var_4);
  self._id_12D97 = var_6;
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0)
    init_death_animations(self);

  thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ABF20BE7B0B911BA27BDD60AA5", self.winners);
  var_7 = _id_135CA("_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D");
  self.rope = var_7;
  self.gameending = init_carepackages();
  var_8 = [];
  var_8[0] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_ABDB12EA1086CF91F08B07018F682733A50993C7");

  if(self.winners.size > 1)
    var_8[1] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_99DB126DD398DE77B4B8E9324386D7D578A30AB9");

  if(self.winners.size > 2)
    var_8[2] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_A1DB122B2B3336C7DC20CE96873EFDB0B363C862");

  if(self.winners.size > 3)
    var_8[3] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_A7DB127713068AE708AD71C6FB90E592559383F6");

  self.canspawnontacinsert = var_8;
  self._id_121B8 = [];
  var_9 = 0;
  self._id_121B8[var_9] = init_bomb_objective("_encstr_ADD507F3EFC86D85A3");
  self._id_121B8[var_9] backendevent([], ::glgrenadeparent);
  self._id_121B8[var_9] back_struct(var_2, %_encstr_A75215E132EF988BDA67116F53225B9069C14B384A69EA);
  self._id_121B8[var_9] back_struct(var_6, %_encstr_BA6B1212A08F77CBE9AB744FB6108F3A094AAFAF);
  self._id_121B8[var_9] back_struct(var_7, %_encstr_995F141393F556F099D21BFAC9BD0EAC7DCDD0604C0C);
  self._id_121B8[var_9] awardstadiumblueprint(%_encstr_855313AE0269539AF62FE081FF09F0EF732C3F8F0A);
  self._id_121B8[var_9] back_field_clip("_encstr_85E41101EAD75FE0072ADBB9266C48B08F129B", self.origin, self.angles);
  var_9++;
  self._id_121B8[var_9] = init_bomb_objective("_encstr_85D507BB02F238E0E5");
  self._id_121B8[var_9] backendevent(self.winners, ::glint);
  self._id_121B8[var_9] back_struct(var_2, %_encstr_8B521526E4F556F03396C6BE318D2D5BC2EBB934C08C0C);

  if(!isDefined(level.scr_notetrack["_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261"]) || !isDefined(level.scr_notetrack["_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261"]["_encstr_9A19040BCDBC"]["_encstr_A3100CA8FB805AE169521592E528"])) {
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_A3100CA8FB805AE169521592E528", ::globalrelicsfunc);
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_A14B0CB10BBFCFA9162A9FFB423F", ::globalstruct);
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_93B90C7F6723AE41A15E20F9428C", ::go_investigate_loc);
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_AAEB0C80DA46FBAB9752018F2BFF", ::go_patrol_the_maze);
  }

  self._id_121B8[var_9] back_struct(var_6, %_encstr_BA1C15921B5F8FD255BAF3E9D0193AD8706F1AE3370527);
  self._id_121B8[var_9] back_struct(var_7, %_encstr_915F141333C1D312BB41199832F75BABB94BC81A8FB2);
  self._id_121B8[var_9] back_struct(var_8[0], %_encstr_A68E19C49CAFACF0CCD28DD70BCD6CB23746AC4E81FA37A118C860);

  if(self.winners.size > 1)
    self._id_121B8[var_9] back_struct(var_8[1], %_encstr_8F1D19CA9E4E378055D84A717097BECF800D5552971627CCA13A97);

  if(self.winners.size > 2)
    self._id_121B8[var_9] back_struct(var_8[2], %_encstr_AD35191393EB561E99D2367D0B37D8B27332CA4E64FA371A818C03);

  if(self.winners.size > 3)
    self._id_121B8[var_9] back_struct(var_8[3], %_encstr_BA8819B6AAD86DF3CA126DBFA9EB2335D2C445CB9E6F8FD8BF3BB7);

  self._id_121B8[var_9] back_vector(self.winners[0], %_encstr_B462140AB8977FC3D1A37C574C5B0FD26F5832A702E1, %_encstr_ADBA18A8DA6945F8C7A1807ED2A36B3FC63E309B8ADF913C496D);
  self._id_121B8[var_9] back_vector(self.winners[1], %_encstr_ADF61476D64FA2803148BB6F208B492FF7EE7C7A9EF9, %_encstr_9A7518319C7D59E1334BB1F576EAF24CAF9B1AC09106EB66CAD6);
  self._id_121B8[var_9] back_vector(self.winners[2], %_encstr_AD95147B1540BA90D0F0CD192910C987386FDBAA3D5F, %_encstr_84D3180AB8977FC3D1A37C574C5B0F526F5832A702E1B9C3E999);
  self._id_121B8[var_9] back_vector(self.winners[3], %_encstr_A5A01426397D561ECC4B36D73B5D5E66FA9B86068C18, %_encstr_AFE7181327F5CA87CC4B63FA9DBAF2CCD7B9860C2303FACCCAB5);
  self._id_121B8[var_9] awardstadiumblueprint(%_encstr_B453134E9B29B54BF4130BCF6F2F42D7E06052C23B);
  var_9++;
  self._id_121B8[var_9] = init_bomb_objective("_encstr_9AAC09E66C56E69591E26A");
  self._id_121B8[var_9] backendevent(self.winners, ::glintfx);
  self._id_121B8[var_9] back_struct(var_2, %_encstr_9A52158962471F4B8F62A3572DBC9A9ADE07AB48D9A2F3);
  self._id_121B8[var_9] back_struct(var_6, %_encstr_8D1C154CC97D593C33A5D8FAE05A8DB7A3EBB943C091D4);
  self._id_121B8[var_9] back_vector(self.winners[0], %_encstr_B16214B5BB81C5B8E6DC8D7E47DD78A739173999C24F);
  self._id_121B8[var_9] back_vector(self.winners[1], %_encstr_81F61462E5F95FEB3C38DAD1C18DA702A18F10B8FD02);
  self._id_121B8[var_9] back_vector(self.winners[2], %_encstr_96951431C97D2BE1992D1BD7B35DE564EBDC8660199A);
  self._id_121B8[var_9] back_vector(self.winners[3], %_encstr_99A0141222C12F9BA0E7C98932B379A398FA7812AAFF);
  self._id_121B8[var_9] awardstadiumblueprint(%_encstr_B15313630D48B298E8F8D511D1B8C5693651B2AA3B);
  var_9++;
  self._id_121B8[var_9] = init_bomb_objective("_encstr_8AD507626671FDF856");
  self._id_121B8[var_9] backendevent(self.winners, ::global_relic_amped_func);
  self._id_121B8[var_9] back_struct(var_2, %_encstr_A1521521F22F584B1A27512F13621BD0A9018BF80A2BAA);
  self._id_121B8[var_9] back_struct(var_6, %_encstr_A61C151362C6A86225F913B8B2AF0A5839710353025663);
  self._id_121B8[var_9] back_vector(self.winners[0], %_encstr_8C621426E4F5593CCCB436F5D95D5EC0FA9B1A066660, %_encstr_87A4189388F645A3E59B2DE9F4BBCB589E1833622AC3878ACBA1, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
  self._id_121B8[var_9] back_vector(self.winners[1], %_encstr_87F61498E4AFACF033A563AF3BD5CB13F53786609918, %_encstr_8386189E3EB75A68D950935708933147DFD6648206D131BE4168, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
  self._id_121B8[var_9] back_vector(self.winners[2], %_encstr_B695147DCA6198933332107EFA57CBFA892391511302, %_encstr_B2BE18B88B797BBA23A9F160BF37C29DD12360B2775AD7B107C5, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
  self._id_121B8[var_9] back_vector(self.winners[3], %_encstr_BAA0148939D7CA0F665A637D9DAEE5997D37D0816660, %_encstr_A3F818BD2AA99590398C81D92F1F8BFB69DB386203D2A7E4ED18, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
  self._id_121B8[var_9] awardstadiumblueprint(%_encstr_8A5313F1229FE8FBAA77015F67E249F16B3C33235A);

  if(self.winners.size >= 2) {
    var_9++;
    self._id_121B8[var_9] = init_bomb_objective("_encstr_96D507F258557361ED");
    self._id_121B8[var_9] backendevent([var_6], ::global_relic_landlocked_func);
    self._id_121B8[var_9] back_struct(var_2, %_encstr_965215314EFAB23C664BD8D7891B966BC2D7DC8603A10C);
    self._id_121B8[var_9] back_vector(self.winners[0], %_encstr_8B62148927AF2BF0CC5AB1AF76EAE518F56E1AC04306, %_encstr_AD7B1861B26F180B5AE791EFC733D3FAD74AA8B3CBE811CC429F, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
    self._id_121B8[var_9] back_vector(self.winners[1], %_encstr_A7F6141339BE950FCC2D1BF5D95DE513AF3743600D18, %_encstr_A25E182013E1F332DB2179F807BF5AE359ABE83A8FD24FC98F5D, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
    self._id_121B8[var_9] back_vector(self.winners[2], %_encstr_A7951489E4FACA87CCD2C6FAB3ABBC647DB9A10C4306, %_encstr_A6FA1882FA5FC23BF93CD08839F3CB57A890030AF28290A01A7D, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
    self._id_121B8[var_9] back_vector(self.winners[3], %_encstr_BDA014BBDE7905A9A2D920F6FF6070CA20534BB88A8A, %_encstr_A6E71868DAFF1A3A08A9490777888BD2A7D670FA2C435F72410B, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
    self._id_121B8[var_9] awardstadiumblueprint(%_encstr_955313F29B784FC0D03B9CA7C70B4D5F96304F1F6B);
  }

  if(self.winners.size >= 3) {
    var_9++;
    self._id_121B8[var_9] = init_bomb_objective("_encstr_88D5076E36B2E6CA4D");
    self._id_121B8[var_9] backendevent([], ::global_relic_squadlink_func);
    self._id_121B8[var_9] back_struct(var_2, %_encstr_855215AE0269539AF62FE081FB04708B52E19E230AA781);
    self._id_121B8[var_9] back_vector(self.winners[0], %_encstr_A162148532E9100BABBAA8F662DF437231AB19D99D9A, %_encstr_AB6B185EF299A36A06FF30B1DF4D0241E1DAC3FF9BC70F51EDC7, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
    self._id_121B8[var_9] back_vector(self.winners[1], %_encstr_86F61489C9F559C3994B637DB35DF289F53743606AC0, %_encstr_AB6F183B063E6393908241472F8848D28143A9D0E20FBFD1E79A, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
    self._id_121B8[var_9] back_vector(self.winners[2], %_encstr_AC9514CB53B98082582B2B29A7F5082A0F038093B542, %_encstr_85E418214B17D5A0C73189F7276BE0066F33F8E38702AFA8DF1D, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
    self._id_121B8[var_9] back_vector(self.winners[3], %_encstr_B8A0149827D7591E332D1BFAB3ABE5CCEBE61AC06A0C, %_encstr_B83B188B90EE6D8BDDA305F19CD3D363B6F0DB4A32AB9FB22349, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
    self._id_121B8[var_9] awardstadiumblueprint(%_encstr_8C5313319CFACAF0CCB48DEBB1C2DAAFB91A814D0C);
  }

  if(self.winners.size == 4) {
    var_9++;
    self._id_121B8[var_9] = init_bomb_objective("_encstr_81D5076E6C2B375663");
    self._id_121B8[var_9] backendevent([], ::global_relic_team_prox_func);
    self._id_121B8[var_9] back_struct(var_2, %_encstr_B452154E9B29B54BF4130BCF6DA902E5708682543B9A28);
    self._id_121B8[var_9] back_vector(self.winners[0], %_encstr_836214959BA1E598063CE09EA7FD5887597719B932FF, %_encstr_9707184C39FAACC3CC5AC6BECEEACB0CBEDC1A0C1BC0AF6695AD, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
    self._id_121B8[var_9] back_vector(self.winners[1], %_encstr_ABF6144CC9FAB2F03396B17D3BEA9762BECD0D0C630C, %_encstr_A5FE18A1ABBF795B7239ABA77AFBD04F77CA63C23FB030A0F0F0, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
    self._id_121B8[var_9] back_vector(self.winners[2], %_encstr_AB95147E8B5163B36BB045DF499D7052018AE3972DC3, %_encstr_8A3018763A37E1A1CFCA639102237BD3DFC38BD7D632EED57792, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
    self._id_121B8[var_9] back_vector(self.winners[3], %_encstr_A6A0147ACEF7F59093B741D7679542A238738BDFDFAA, %_encstr_B6D918989CF556E1CC5AC6FAD9EAE599EB37D0C0C606AFCCAC5B, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
    self._id_121B8[var_9] awardstadiumblueprint(%_encstr_8B531326E4F556F03396C6BEB12CADD7E60D181BC0);
  }

  var_9++;
  self._id_121B8[var_9] = init_bomb_objective("_encstr_AAD507E6C659CDB29B");
  self._id_121B8[var_9] backendevent([], ::global_stealth_broken_func);
  self._id_121B8[var_9] back_struct(var_2, %_encstr_A9521531E4AF591ECC4B8DD74CC64B5BC2EBCD340C6EC0);
  self._id_121B8[var_9] back_vector(self.winners[0], %_encstr_A162148532E9100BABBAA8F662DF437231AB19D99F9A);
  self._id_121B8[var_9] back_vector(self.winners[1], %_encstr_A5F6144C93D72B0FCC2DD8EBEC5D2FC4FA9B4360B960);
  self._id_121B8[var_9] back_vector(self.winners[2], %_encstr_9195145A33D01798B843F4FF6718E002788B7207F33F);
  self._id_121B8[var_9] back_vector(self.winners[3], %_encstr_97A014A673C15DB31CFB9367DFBD6BC319BBDCBA4312);
  self._id_121B8[var_9] awardstadiumblueprint(%_encstr_A1531321F22F584B1A27512F17B21941BBCCE3130A);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_encstr_8B521836D0F607E0B227A7DEB64C2D59CA0F33B4B1D71C586C5B(var_0) {
  thread givestartingarmor(5, var_0);

  if(!getdvarint("_encstr_83D9183FBB4A29FE03311178EA07A0B0A970B993237770B54B9B")) {
    self._id_13CE3 = processvoqueue();
    unloadinfiltransient(self._id_13CE3);
    setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 18);
    var_1 = getdvarfloat("_encstr_AD141ADCC627FA8939D7ACE623F5A3275837E6B4CACDE8FADD855AD1", 6.0);
    wait(var_1);
  }

  self._id_142D0 = "_encstr_AAD81BC703E94A9316B603394B89C7F229ABF911B8494E1D0A905E7BEB";
  var_2 = _id_135CA("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261");
  var_2 hidepart("_encstr_B236182349D4173578ABEED775E0BB0F8626FA2AD13DB7E1CA03");
  var_2 hidepart("_encstr_843618CBF9E88F1A771303CF4D28D3E7E886C65511087DF1F7BD");
  var_2 hidepart("_encstr_8A36182BF0115FD2CBBB8DC91EEF7B271B99FB339829DD39816E");
  var_2 hidepart("_encstr_A23618CDAE824F408947A82903AF3B77BB594E59060AF3CE202A");
  var_2 hidepart("_encstr_AF6C1875373ACF53C893CDC978F505B763C09E91D2A1DF176173");
  var_2 hidepart("_encstr_8D6C18C0D9AC400B4E6A344F33C063675AE7C610CEF3A56FD832");
  var_2 hidepart("_encstr_A56C18C1AF5A80905964C8A6CA0FC8C0A3EF65694792550120EA");
  var_2 hidepart("_encstr_866C1860466F102157FFE0982A4809A03E9001193734A826282A");
  self.onkillingblow = var_2;
  givexpwithtext();
  var_3 = ["_encstr_A9AB18A8FFC988AF627B7F19471A53E86F129381A20F784EDA7F", "_encstr_8EEC09159F6238030BFA23"];
  var_4 = [var_3];
  var_5 = "_encstr_828E1EB92D9C305003AFC9C7F3D903683C04019092D498FE297BEDF3EBC2D6C8";
  var_6 = _id_135CA(var_5, undefined, var_4);
  self._id_12D97 = var_6;
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0)
    init_death_animations(self);

  thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ABF20BE7B0B911BA27BDD60AA5", self.winners);
  var_7 = _id_135CA("_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D");
  self.rope = var_7;
  self.gameending = init_carepackages();
  var_8 = [];
  var_8[0] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_ABDB12EA1086CF91F08B07018F682733A50993C7");

  if(self.winners.size > 1)
    var_8[1] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_99DB126DD398DE77B4B8E9324386D7D578A30AB9");

  if(self.winners.size > 2)
    var_8[2] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_A1DB122B2B3336C7DC20CE96873EFDB0B363C862");

  if(self.winners.size > 3)
    var_8[3] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_A7DB127713068AE708AD71C6FB90E592559383F6");

  self.canspawnontacinsert = var_8;
  var_9 = "_encstr_B8971533ABD88DC4DE19BCFAA77BAD13B495BE16AF2639";
  var_10 = _id_135CA(var_9, "_encstr_8A821CD018D983F3561BB8A74DB1D781208795E3F26D49E9409BB1D2173B");
  var_11 = _id_135CA(var_9, "_encstr_A7971CEE422913DAB66FA0417BD0932F23ADD1661C62414BA72F88325EB0");
  var_12 = _id_135CA(var_9, "_encstr_A3CA1C7A13F0F77858A314DF6D5082D78A2802C2D8B5DAE2B9BF18B8C33A");
  var_13 = _id_135CA(var_9, "_encstr_B8EA1C130876C523651BAD69FE21DBB7BA78A7AB78E9682F3F2EB4CA4799");
  var_14 = _id_135CA(var_9, "_encstr_86A41C82EB083FB0806BAC973518FA8FC2E0CA0A10FDA23B7147D0E08B82");
  var_15 = _id_135CA(var_9, "_encstr_A21D1C264EEB2BC3CCD2C6AF930FE0EBF4EDAD4C5AACC01BF5DC43C04C06");
  var_16 = _id_135CA(var_9, "_encstr_9BC31CEABE6E1760B538AA91C8A15A4762A87D625B710A7B1F10F25FCA49");
  var_17 = _id_135CA(var_9, "_encstr_93591C13937DB2F0CCD21BAF393C07BE4FB7B631D2CA0607AFCD1A068918");
  var_18 = _id_135CA(var_9, "_encstr_AD1C1C499A57203372BFF997FBBB7FA91AB5D0C1C4D5424B19CFC9518267");
  var_19 = _id_135CA(var_9, "_encstr_ABA21C9827FACAF0334BD8F5271E83BE3DDBB6985AAC13C07DCDA10C64C0");
  var_20 = _id_135CA(var_9, "_encstr_8F8A1CA58EB7CAD0CEF329FFBB4810C7F36ABA8B297D333EDFA00BE10BF2");
  var_21 = _id_135CA(var_9, "_encstr_B4831C469321BD53FC1B73C7559B9BCF50983DCE6818112F58076B72FD67");
  var_22 = [];

  if(self.winners.size <= 1)
    var_22 = [var_11, var_12, var_13, var_14, var_19];

  if(self.winners.size == 2)
    var_22 = [var_11, var_13, var_14, var_19];

  if(self.winners.size == 3)
    var_22 = [var_13, var_14];

  var_23 = _id_135CA(var_9, "_encstr_857C1CEBF08E0DEBBDC36551B669A3EF51606353D0431027F7E66C823FA1");
  var_23 hide();
  self._id_121B8 = [];
  var_24 = 0;
  self._id_121B8[var_24] = init_bomb_objective("_encstr_AFAC0972C180C6F287C546");
  self._id_121B8[var_24] backendevent(var_23, ::_encstr_BAAC1F196C17F847D2435B693B3A8110BF85A1D0577FA8735FB2E31F77935F985C);
  self._id_121B8[var_24] back_struct(var_2, %_encstr_A7E81990F0092F73BC7C4B575E62E867C6B373C807492E7CE042A3);
  self._id_121B8[var_24] back_struct(var_6, %_encstr_ADC2160285993F8B5C58BA71C3AB6379A017879B298A12E6);
  self._id_121B8[var_24] back_struct(var_7, %_encstr_AF51184C93F5ACF0CCA563F5278738F54EBD8359D79B8606C0D4);
  self._id_121B8[var_24] awardstadiumblueprint(%_encstr_953517C4E4D7951E332D8DFA39F038AF6CC2DAF5DCD018C0A6);
  var_24++;
  self._id_121B8[var_24] = init_bomb_objective("_encstr_ADD507F3EFC86D85A3");
  self._id_121B8[var_24] backendevent(var_23, ::_encstr_B8701FF758F5A81FB73BB902625FD9300DA57D7BFD51E86B8A271BEEDB03070863);
  self._id_121B8[var_24] back_struct(var_23, %_encstr_857C1CEBF08E0DEBBDC36551B669A3EF51606353D0431027F7E66C823FA1);

  if(!isDefined(level.scr_notetrack[var_23.animname]) || !isDefined(level.scr_notetrack[var_23.animname]["_encstr_9A19040BCDBC"]["_encstr_88780599B4E495"]))
    scripts\common\anim::addnotetrack_customfunction(var_23.animname, "_encstr_88780599B4E495", ::_encstr_ADD519F3F9986F0D7FD0A01BD0D96D706DAFD50714E25BF392DEB7);

  self._id_121B8[var_24] back_struct(var_10, %_encstr_8A821CD018D983F3561BB8A74DB1D781208795E3F26D49E9409BB1D2173B);
  self._id_121B8[var_24] back_struct(var_11, %_encstr_A7971CEE422913DAB66FA0417BD0932F23ADD1661C62414BA72F88325EB0);
  self._id_121B8[var_24] back_struct(var_12, %_encstr_A3CA1C7A13F0F77858A314DF6D5082D78A2802C2D8B5DAE2B9BF18B8C33A);
  self._id_121B8[var_24] back_struct(var_13, %_encstr_B8EA1C130876C523651BAD69FE21DBB7BA78A7AB78E9682F3F2EB4CA4799);
  self._id_121B8[var_24] back_struct(var_14, %_encstr_86A41C82EB083FB0806BAC973518FA8FC2E0CA0A10FDA23B7147D0E08B82);
  self._id_121B8[var_24] back_struct(var_15, %_encstr_A21D1C264EEB2BC3CCD2C6AF930FE0EBF4EDAD4C5AACC01BF5DC43C04C06);
  self._id_121B8[var_24] back_struct(var_16, %_encstr_9BC31CEABE6E1760B538AA91C8A15A4762A87D625B710A7B1F10F25FCA49);
  self._id_121B8[var_24] back_struct(var_17, %_encstr_93591C13937DB2F0CCD21BAF393C07BE4FB7B631D2CA0607AFCD1A068918);
  self._id_121B8[var_24] awardstadiumblueprint(%_encstr_B635179E2277C3C114EB9B3175E8FF0F884B1D889B0862E7D7);
  var_24++;
  var_25 = [];
  var_25["_encstr_881108BBB95836E360FF"] = self.winners;
  var_25["_encstr_8D48079DD59BE65627"] = var_23;
  var_25["_encstr_AACC0EF4BDDA135A2BDC8ADB09A5232B"] = var_22;
  self._id_121B8[var_24] = init_bomb_objective("_encstr_85D507BB02F238E0E5");
  self._id_121B8[var_24] backendevent(var_25, ::_encstr_A5221F8F3080E3BFE0E363B097FA91206FEF8548AA97D3506BE771E790E3706A81);
  self._id_121B8[var_24] back_struct(var_2, %_encstr_B8E8195EFE779AA81990539760F278E1E5196415EFCFB3F0AB521A);

  if(!isDefined(level.scr_notetrack["_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261"]) || !isDefined(level.scr_notetrack["_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261"]["_encstr_9A19040BCDBC"]["_encstr_A3100CA8FB805AE169521592E528"])) {
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_A3100CA8FB805AE169521592E528", ::globalrelicsfunc);
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_A14B0CB10BBFCFA9162A9FFB423F", ::globalstruct);
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_93B90C7F6723AE41A15E20F9428C", ::go_investigate_loc);
    scripts\common\anim::addnotetrack_customfunction("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261", "_encstr_AAEB0C80DA46FBAB9752018F2BFF", ::go_patrol_the_maze);
  }

  self._id_121B8[var_24] back_struct(var_6, %_encstr_BA1C15921B5F8FD255BAF3E9D0193AD8706F1AE3370527);
  self._id_121B8[var_24] back_struct(var_7, %_encstr_915F141333C1D312BB41199832F75BABB94BC81A8FB2);
  self._id_121B8[var_24] back_struct(var_8[0], %_encstr_8C3F1D1023D1C3028B71298842DB4BEF065B60A07AB70B9B2A5FAE1B78AA7B);
  self._id_121B8[var_24] back_struct(var_10, %_encstr_B4821C469321BD53FC1B73C7559B9BCF50983DCE6818101F58076B72FD67);
  self._id_121B8[var_24] back_struct(var_15, %_encstr_821D1C1EB2D9E32A46BF70F1CB80E35F731D0196CCD2119B17FF588222E0);
  self._id_121B8[var_24] back_struct(var_16, %_encstr_8FC31CAA2D319733E4F02219BBC3CBC1F0EF2D32B3588A46AFAB5AF74B3F);
  self._id_121B8[var_24] back_struct(var_17, %_encstr_8E591C586B999B5AC30951C00A6383273842A8C072AF691A4F3B6B6FA26A);
  self._id_121B8[var_24] back_struct(var_18, %_encstr_AD1C1C499A57203372BFF997FBBB7FA91AB5D0C1C4D5424B19CFC9518267);
  self._id_121B8[var_24] back_struct(var_20, %_encstr_8F8A1CA58EB7CAD0CEF329FFBB4810C7F36ABA8B297D333EDFA00BE10BF2);
  self._id_121B8[var_24] back_struct(var_21, %_encstr_B4831C469321BD53FC1B73C7559B9BCF50983DCE6818112F58076B72FD67);
  self._id_121B8[var_24] back_vector(self.winners[0], %_encstr_AB9818F8860769A00EF9DCAE3849AB1FC7BB4A0A07BB99220260, %_encstr_8A1C1C8A3817FF435123FCD7467AAB899FE8A327E9E7F41A83B7C7E6D5E0);

  if(!isDefined(level.scr_notetrack[self.winners[0].animname]) || !isDefined(level.scr_notetrack[self.winners[0].animname]["_encstr_9A19040BCDBC"]["_encstr_88780599B4E495"]))
    scripts\common\anim::addnotetrack_customfunction(self.winners[0].animname, "_encstr_88780599B4E495", ::shoot_gun_from_notetrack);

  if(self.winners.size > 1) {
    self._id_121B8[var_24] back_struct(var_8[1], %_encstr_8C271D7A13F0F77858A314DF6D5082D707ABE2B238358FB2CAE703E0C12ADA);
    self._id_121B8[var_24] back_struct(var_12, %_encstr_BECA1CA172AFD8CB9AA7D1AFD3A317C1328DC839DCFD2A262127D179FA4F);
    self._id_121B8[var_24] back_vector(self.winners[1], %_encstr_8380184E9B29B54BF4130BCF4DA393D740C35E02D6B07007F6B9, %_encstr_AB951C7E8B5163B36BB045DFEB1B3839C00B6B87FFABD0C2727B3796FA90);

    if(!isDefined(level.scr_notetrack[self.winners[1].animname]) || !isDefined(level.scr_notetrack[self.winners[1].animname]["_encstr_9A19040BCDBC"]["_encstr_88780599B4E495"]))
      scripts\common\anim::addnotetrack_customfunction(self.winners[1].animname, "_encstr_88780599B4E495", ::shoot_gun_from_notetrack);
  }

  if(self.winners.size > 2) {
    self._id_121B8[var_24] back_struct(var_8[2], %_encstr_92951D892BB06BFBA0498D5780AB8BC19767364A88B853426A7F4E2C901203);
    self._id_121B8[var_24] back_struct(var_11, %_encstr_86971C6EBB09956BD4336BAF2D83B3F7486025F670600807A01F430AD58F);
    self._id_121B8[var_24] back_struct(var_19, %_encstr_ABA21C9827FACAF0334BD8F5271E83BE3DDBB6985AAC13C07DCDA10C64C0);
    self._id_121B8[var_24] back_vector(self.winners[2], %_encstr_8A4218707EF14D1BCC49586932134B67F7E510AADEF710C7CA4A, %_encstr_AC041C326DC7A9428E70D818035278F147CD27F2AF7EB82ABFEA886BFA10);

    if(!isDefined(level.scr_notetrack[self.winners[2].animname]) || !isDefined(level.scr_notetrack[self.winners[2].animname]["_encstr_9A19040BCDBC"]["_encstr_88780599B4E495"]))
      scripts\common\anim::addnotetrack_customfunction(self.winners[2].animname, "_encstr_88780599B4E495", ::shoot_gun_from_notetrack);
  }

  if(self.winners.size > 3) {
    self._id_121B8[var_24] back_struct(var_8[3], %_encstr_B87D1D5D0B9FD55BEA2B64C75B6B6B7FD727BE5A206D1F62EF4F1B904BA7AF);
    self._id_121B8[var_24] back_struct(var_13, %_encstr_87EA1C2B304ECD2B7D03A511F629E3AFB270AFA370E150373726ACC2FE61);
    self._id_121B8[var_24] back_struct(var_14, %_encstr_A9A41C3E626FB9E987B248C91B58B1B6831731A6C12FCB8B213B60BA7762);
    self._id_121B8[var_24] back_vector(self.winners[3], %_encstr_8A2A189572418F40215FF31993CBEAEE3FB5401A811318FFEADA, %_encstr_A2701CDEB870018873605BAF5201BBA14A23DB2329D73397CB171F2E9BA0);

    if(!isDefined(level.scr_notetrack[self.winners[3].animname]) || !isDefined(level.scr_notetrack[self.winners[3].animname]["_encstr_9A19040BCDBC"]["_encstr_88780599B4E495"]))
      scripts\common\anim::addnotetrack_customfunction(self.winners[3].animname, "_encstr_88780599B4E495", ::shoot_gun_from_notetrack);
  }

  self._id_121B8[var_24] awardstadiumblueprint(%_encstr_A93517865A51A969C81F91E9EA8203C7CB908060D7100B6A6F);
  var_24++;
  self._id_121B8[var_24] = init_bomb_objective("_encstr_9AAC09E66C56E69591E26A");
  self._id_121B8[var_24] backendevent(self.winners, ::glintfx);
  self._id_121B8[var_24] back_struct(var_2, %_encstr_9A52158962471F4B8F62A3572DBC9A9ADE07AB48D9A2F3);
  self._id_121B8[var_24] back_struct(var_6, %_encstr_8D1C154CC97D593C33A5D8FAE05A8DB7A3EBB943C091D4);
  self._id_121B8[var_24] back_vector(self.winners[0], %_encstr_B16214B5BB81C5B8E6DC8D7E47DD78A739173999C24F);
  self._id_121B8[var_24] back_vector(self.winners[1], %_encstr_81F61462E5F95FEB3C38DAD1C18DA702A18F10B8FD02);
  self._id_121B8[var_24] back_vector(self.winners[2], %_encstr_96951431C97D2BE1992D1BD7B35DE564EBDC8660199A);
  self._id_121B8[var_24] back_vector(self.winners[3], %_encstr_99A0141222C12F9BA0E7C98932B379A398FA7812AAFF);
  self._id_121B8[var_24] awardstadiumblueprint(%_encstr_B15313630D48B298E8F8D511D1B8C5693651B2AA3B);
  var_24++;
  self._id_121B8[var_24] = init_bomb_objective("_encstr_8AD507626671FDF856");
  self._id_121B8[var_24] backendevent(self.winners, ::global_relic_amped_func);
  self._id_121B8[var_24] back_struct(var_2, %_encstr_A1521521F22F584B1A27512F13621BD0A9018BF80A2BAA);
  self._id_121B8[var_24] back_struct(var_6, %_encstr_A61C151362C6A86225F913B8B2AF0A5839710353025663);
  self._id_121B8[var_24] back_vector(self.winners[0], %_encstr_8C621426E4F5593CCCB436F5D95D5EC0FA9B1A066660, %_encstr_87A4189388F645A3E59B2DE9F4BBCB589E1833622AC3878ACBA1, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
  self._id_121B8[var_24] back_vector(self.winners[1], %_encstr_87F61498E4AFACF033A563AF3BD5CB13F53786609918, %_encstr_8386189E3EB75A68D950935708933147DFD6648206D131BE4168, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
  self._id_121B8[var_24] back_vector(self.winners[2], %_encstr_B695147DCA6198933332107EFA57CBFA892391511302, %_encstr_B2BE18B88B797BBA23A9F160BF37C29DD12360B2775AD7B107C5, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
  self._id_121B8[var_24] back_vector(self.winners[3], %_encstr_BAA0148939D7CA0F665A637D9DAEE5997D37D0816660, %_encstr_A3F818BD2AA99590398C81D92F1F8BFB69DB386203D2A7E4ED18, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
  self._id_121B8[var_24] awardstadiumblueprint(%_encstr_8A5313F1229FE8FBAA77015F67E249F16B3C33235A);

  if(self.winners.size >= 2) {
    var_24++;
    self._id_121B8[var_24] = init_bomb_objective("_encstr_96D507F258557361ED");
    self._id_121B8[var_24] backendevent([var_6], ::global_relic_landlocked_func);
    self._id_121B8[var_24] back_struct(var_2, %_encstr_965215314EFAB23C664BD8D7891B966BC2D7DC8603A10C);
    self._id_121B8[var_24] back_vector(self.winners[0], %_encstr_8B62148927AF2BF0CC5AB1AF76EAE518F56E1AC04306, %_encstr_AD7B1861B26F180B5AE791EFC733D3FAD74AA8B3CBE811CC429F, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
    self._id_121B8[var_24] back_vector(self.winners[1], %_encstr_A7F6141339BE950FCC2D1BF5D95DE513AF3743600D18, %_encstr_A25E182013E1F332DB2179F807BF5AE359ABE83A8FD24FC98F5D, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
    self._id_121B8[var_24] back_vector(self.winners[2], %_encstr_A7951489E4FACA87CCD2C6FAB3ABBC647DB9A10C4306, %_encstr_A6FA1882FA5FC23BF93CD08839F3CB57A890030AF28290A01A7D, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
    self._id_121B8[var_24] back_vector(self.winners[3], %_encstr_BDA014BBDE7905A9A2D920F6FF6070CA20534BB88A8A, %_encstr_A6E71868DAFF1A3A08A9490777888BD2A7D670FA2C435F72410B, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
    self._id_121B8[var_24] awardstadiumblueprint(%_encstr_955313F29B784FC0D03B9CA7C70B4D5F96304F1F6B);
  }

  if(self.winners.size >= 3) {
    var_24++;
    self._id_121B8[var_24] = init_bomb_objective("_encstr_88D5076E36B2E6CA4D");
    self._id_121B8[var_24] backendevent([], ::global_relic_squadlink_func);
    self._id_121B8[var_24] back_struct(var_2, %_encstr_855215AE0269539AF62FE081FB04708B52E19E230AA781);
    self._id_121B8[var_24] back_vector(self.winners[0], %_encstr_A162148532E9100BABBAA8F662DF437231AB19D99D9A, %_encstr_AB6B185EF299A36A06FF30B1DF4D0241E1DAC3FF9BC70F51EDC7, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
    self._id_121B8[var_24] back_vector(self.winners[1], %_encstr_86F61489C9F559C3994B637DB35DF289F53743606AC0, %_encstr_AB6F183B063E6393908241472F8848D28143A9D0E20FBFD1E79A, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
    self._id_121B8[var_24] back_vector(self.winners[2], %_encstr_AC9514CB53B98082582B2B29A7F5082A0F038093B542, %_encstr_85E418214B17D5A0C73189F7276BE0066F33F8E38702AFA8DF1D, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
    self._id_121B8[var_24] back_vector(self.winners[3], %_encstr_B8A0149827D7591E332D1BFAB3ABE5CCEBE61AC06A0C, %_encstr_B83B188B90EE6D8BDDA305F19CD3D363B6F0DB4A32AB9FB22349, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
    self._id_121B8[var_24] awardstadiumblueprint(%_encstr_8C5313319CFACAF0CCB48DEBB1C2DAAFB91A814D0C);
  }

  if(self.winners.size == 4) {
    var_24++;
    self._id_121B8[var_24] = init_bomb_objective("_encstr_81D5076E6C2B375663");
    self._id_121B8[var_24] backendevent([], ::global_relic_team_prox_func);
    self._id_121B8[var_24] back_struct(var_2, %_encstr_B452154E9B29B54BF4130BCF6DA902E5708682543B9A28);
    self._id_121B8[var_24] back_vector(self.winners[0], %_encstr_836214959BA1E598063CE09EA7FD5887597719B932FF, %_encstr_9707184C39FAACC3CC5AC6BECEEACB0CBEDC1A0C1BC0AF6695AD, %_encstr_8CDC19234D08F2D8A8B8955191D8115FE0A793E277E719B268414F);
    self._id_121B8[var_24] back_vector(self.winners[1], %_encstr_ABF6144CC9FAB2F03396B17D3BEA9762BECD0D0C630C, %_encstr_A5FE18A1ABBF795B7239ABA77AFBD04F77CA63C23FB030A0F0F0, %_encstr_B2761992EEC967C95102F8D75263AB43C1ABE8537237B760730820);
    self._id_121B8[var_24] back_vector(self.winners[2], %_encstr_AB95147E8B5163B36BB045DF499D7052018AE3972DC3, %_encstr_8A3018763A37E1A1CFCA639102237BD3DFC38BD7D632EED57792, %_encstr_861419198B7157F9785F11F79FAB723DF12BE08007270EA42D07CF);
    self._id_121B8[var_24] back_vector(self.winners[3], %_encstr_A6A0147ACEF7F59093B741D7679542A238738BDFDFAA, %_encstr_B6D918989CF556E1CC5AC6FAD9EAE599EB37D0C0C606AFCCAC5B, %_encstr_918D19899CBEB23C99A563BEB3ABBC33F5CDD006B1C0FAD45D76CE);
    self._id_121B8[var_24] awardstadiumblueprint(%_encstr_8B531326E4F556F03396C6BEB12CADD7E60D181BC0);
  }

  var_24++;
  self._id_121B8[var_24] = init_bomb_objective("_encstr_AAD507E6C659CDB29B");
  self._id_121B8[var_24] backendevent([], ::global_stealth_broken_func);
  self._id_121B8[var_24] back_struct(var_2, %_encstr_A9521531E4AF591ECC4B8DD74CC64B5BC2EBCD340C6EC0);
  self._id_121B8[var_24] back_vector(self.winners[0], %_encstr_A162148532E9100BABBAA8F662DF437231AB19D99F9A);
  self._id_121B8[var_24] back_vector(self.winners[1], %_encstr_A5F6144C93D72B0FCC2DD8EBEC5D2FC4FA9B4360B960);
  self._id_121B8[var_24] back_vector(self.winners[2], %_encstr_9195145A33D01798B843F4FF6718E002788B7207F33F);
  self._id_121B8[var_24] back_vector(self.winners[3], %_encstr_97A014A673C15DB31CFB9367DFBD6BC319BBDCBA4312);
  self._id_121B8[var_24] awardstadiumblueprint(%_encstr_A1531321F22F584B1A27512F17B21941BBCCE3130A);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

oninteractionstarted(var_0) {
  thread givestartingarmor(5, var_0);

  if(!getdvarint("_encstr_83D9183FBB4A29FE03311178EA07A0B0A970B993237770B54B9B")) {
    self._id_13CE3 = processvoqueue();
    unloadinfiltransient(self._id_13CE3);
    setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 18);
    var_1 = getdvarfloat("_encstr_AD141ADCC627FA8939D7ACE623F5A3275837E6B4CACDE8FADD855AD1", 6.0);
    wait(var_1);
  }

  var_2 = _id_135CA("_encstr_B1DB1FD3C333875F90D8F531F198BA499E793737B3F07B5BB020EAC368D0F42261");
  var_2 hidepart("_encstr_B236182349D4173578ABEED775E0BB0F8626FA2AD13DB7E1CA03");
  var_2 hidepart("_encstr_843618CBF9E88F1A771303CF4D28D3E7E886C65511087DF1F7BD");
  var_2 hidepart("_encstr_8A36182BF0115FD2CBBB8DC91EEF7B271B99FB339829DD39816E");
  var_2 hidepart("_encstr_A23618CDAE824F408947A82903AF3B77BB594E59060AF3CE202A");
  var_2 hidepart("_encstr_AF6C1875373ACF53C893CDC978F505B763C09E91D2A1DF176173");
  var_2 hidepart("_encstr_8D6C18C0D9AC400B4E6A344F33C063675AE7C610CEF3A56FD832");
  var_2 hidepart("_encstr_A56C18C1AF5A80905964C8A6CA0FC8C0A3EF65694792550120EA");
  var_2 hidepart("_encstr_866C1860466F102157FFE0982A4809A03E9001193734A826282A");
  self.onkillingblow = var_2;
  givexpwithtext();
  var_3 = ["_encstr_A9AB18A8FFC988AF627B7F19471A53E86F129381A20F784EDA7F", "_encstr_8EEC09159F6238030BFA23"];
  var_4 = [var_3];
  var_5 = "_encstr_828E1EB92D9C305003AFC9C7F3D903683C04019092D498FE297BEDF3EBC2D6C8";
  var_6 = _id_135CA(var_5, undefined, var_4);
  self._id_12D97 = var_6;
  var_7 = _id_135CA("_encstr_82AE18B20FF088A769EB19D353BE6FC28AD92734BB08D6DFAF8B");
  self._id_127E3 = var_7;
  var_8 = ["_encstr_AB301C6907418E10B311A353099BF8C84A93EBF7379A56B8C7A2E3366B7D", "_encstr_9AAA0994EB0727BD83F564"];
  var_9 = ["_encstr_95F814B5ACAF3358269C4BB1EBB158E6EDC1BCF51889", "_encstr_8CAA09439163028299D04A"];
  var_10 = [var_8, var_9];
  var_11 = _id_135CA("_encstr_9ACD10771D6DE2CA90D8B71348088009F98D", undefined, var_10);
  self._id_12909 = var_11;
  var_3 = _id_135CA("_encstr_83CD181A56B091F5B6C1F5C95D6EEBB91A07F6D84BCDC2BE0C98");
  var_7.head = var_3;
  var_12 = _id_135CA("_encstr_A18F14ECD6FA5BDBCD6C854E9991AF184CBE6CDE5B0E");
  var_7.rifle = var_12;
  var_7.head hide();
  var_7.rifle hide();
  var_7 hide();
  var_11.linkedents[0] hide();
  var_11.linkedents[1] hide();
  var_11 hide();
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0)
    init_death_animations(self);

  thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ABF20BE7B0B911BA27BDD60AA5", self.winners);
  var_13 = _id_135CA("_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D");
  self.rope = var_13;
  self.gameending = init_carepackages();
  var_14 = [];
  var_14[0] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_ABDB12EA1086CF91F08B07018F682733A50993C7");

  if(self.winners.size > 1)
    var_14[1] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_99DB126DD398DE77B4B8E9324386D7D578A30AB9");

  if(self.winners.size > 2)
    var_14[2] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_A1DB122B2B3336C7DC20CE96873EFDB0B363C862");

  if(self.winners.size > 3)
    var_14[3] = _id_135CA("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE", "_encstr_A7DB127713068AE708AD71C6FB90E592559383F6");

  self.canspawnontacinsert = var_14;
  self._id_121B8 = [];
  var_15 = 0;
  self._id_121B8[var_15] = init_bomb_objective("_encstr_ADD507F3EFC86D85A3");
  self._id_121B8[var_15] backendevent([], ::glgrenadeparent);
  self._id_121B8[var_15] back_struct(var_2, %_encstr_A75215E132EF988BDA67116F53225B9069C14B384A69EA);
  self._id_121B8[var_15] back_struct(var_6, %_encstr_BA6B1212A08F77CBE9AB744FB6108F3A094AAFAF);
  self._id_121B8[var_15] back_struct(var_13, %_encstr_995F141393F556F099D21BFAC9BD0EAC7DCDD0604C0C);
  self._id_121B8[var_15] awardstadiumblueprint(%_encstr_855313AE0269539AF62FE081FF09F0EF732C3F8F0A);
  self._id_121B8[var_15] back_field_clip("_encstr_85E41101EAD75FE0072ADBB9266C48B08F129B", self.origin, self.angles);
  var_15++;
  self._id_121B8[var_15] = init_bomb_objective("_encstr_85D507BB02F238E0E5");
  self._id_121B8[var_15] backendevent(self.winners, ::glint);
  self._id_121B8[var_15] back_struct(var_2, %_encstr_8B521526E4F556F03396C6BE318D2D5BC2EBB934C08C0C);
  self._id_121B8[var_15] back_struct(var_6, %_encstr_BA1C15921B5F8FD255BAF3E9D0193AD8706F1AE3370527);
  self._id_121B8[var_15] back_struct(var_13, %_encstr_915F141333C1D312BB41199832F75BABB94BC81A8FB2);
  self._id_121B8[var_15] back_struct(var_14[0], %_encstr_A68E19C49CAFACF0CCD28DD70BCD6CB23746AC4E81FA37A118C860);

  if(self.winners.size > 1)
    self._id_121B8[var_15] back_struct(var_14[1], %_encstr_8F1D19CA9E4E378055D84A717097BECF800D5552971627CCA13A97);

  if(self.winners.size > 2)
    self._id_121B8[var_15] back_struct(var_14[2], %_encstr_AD35191393EB561E99D2367D0B37D8B27332CA4E64FA371A818C03);

  if(self.winners.size > 3)
    self._id_121B8[var_15] back_struct(var_14[3], %_encstr_BA8819B6AAD86DF3CA126DBFA9EB2335D2C445CB9E6F8FD8BF3BB7);

  if(self.winners.size > 1)
    self._id_121B8[var_15] back_vector(self.winners[0], %_encstr_B462140AB8977FC3D1A37C574C5B0FD26F5832A702E1, %_encstr_ADBA18A8DA6945F8C7A1807ED2A36B3FC63E309B8ADF913C496D);

  if(self.winners.size > 2)
    self._id_121B8[var_15] back_vector(self.winners[1], %_encstr_ADF61476D64FA2803148BB6F208B492FF7EE7C7A9EF9, %_encstr_9A7518319C7D59E1334BB1F576EAF24CAF9B1AC09106EB66CAD6);

  if(self.winners.size > 3)
    self._id_121B8[var_15] back_vector(self.winners[2], %_encstr_AD95147B1540BA90D0F0CD192910C987386FDBAA3D5F, %_encstr_84D3180AB8977FC3D1A37C574C5B0F526F5832A702E1B9C3E999);

  switch (self.winners.size) {
    case 1:
      self._id_121B8[var_15] back_vector(self.winners[0], %_encstr_8C251B7A13F0F77858A314DF4738C06A18AB52E7B31F67F408811CED69, %_encstr_8C251B7A13F0F77858A314DF4738C06A18AB52E7B31F67F408811CED69);

      if(!isDefined(level.scr_notetrack[self.winners[0].animname]) || !isDefined(level.scr_notetrack[self.winners[0].animname]["_encstr_9A19040BCDBC"]["_encstr_BAB9091F942D9858977210"])) {
        scripts\common\anim::addnotetrack_customfunction(self.winners[0].animname, "_encstr_BAB9091F942D9858977210", ::onhotfootplayerkilled);
        scripts\common\anim::addnotetrack_customfunction(self.winners[0].animname, "_encstr_97820AB98DDEB67BBEF6D5A3", ::oninstanceremoved);
        scripts\common\anim::addnotetrack_customfunction(self.winners[0].animname, "_encstr_9A440A23727EC1204F5D0875", ::ongulagendmatch);
        scripts\common\anim::addnotetrack_customfunction(self.winners[0].animname, "_encstr_BD710B3BE1FF938D28DF0716B5", ::onhelmetsniped);
      }

      break;
    case 2:
      self._id_121B8[var_15] back_vector(self.winners[1], %_encstr_A6731B6E121FC999F7E21879FACB538BC7BBE3FFCACAF6E71C9A10A0E2, %_encstr_A6731B6E121FC999F7E21879FACB538BC7BBE3FFCACAF6E71C9A10A0E2);

      if(!isDefined(level.scr_notetrack[self.winners[1].animname]) || !isDefined(level.scr_notetrack[self.winners[1].animname]["_encstr_9A19040BCDBC"]["_encstr_BAB9091F942D9858977210"])) {
        scripts\common\anim::addnotetrack_customfunction(self.winners[1].animname, "_encstr_BAB9091F942D9858977210", ::onhotfootplayerkilled);
        scripts\common\anim::addnotetrack_customfunction(self.winners[1].animname, "_encstr_97820AB98DDEB67BBEF6D5A3", ::oninstanceremoved);
        scripts\common\anim::addnotetrack_customfunction(self.winners[1].animname, "_encstr_9A440A23727EC1204F5D0875", ::ongulagendmatch);
        scripts\common\anim::addnotetrack_customfunction(self.winners[1].animname, "_encstr_BD710B3BE1FF938D28DF0716B5", ::onhelmetsniped);
      }

      break;
    case 3:
      self._id_121B8[var_15] back_vector(self.winners[2], %_encstr_915A1B1333C1D312BB411998279F7A05B94BC81A8FB26F885F7C118D3C, %_encstr_915A1B1333C1D312BB411998279F7A05B94BC81A8FB26F885F7C118D3C);

      if(!isDefined(level.scr_notetrack[self.winners[2].animname]) || !isDefined(level.scr_notetrack[self.winners[2].animname]["_encstr_9A19040BCDBC"]["_encstr_BAB9091F942D9858977210"])) {
        scripts\common\anim::addnotetrack_customfunction(self.winners[2].animname, "_encstr_BAB9091F942D9858977210", ::onhotfootplayerkilled);
        scripts\common\anim::addnotetrack_customfunction(self.winners[2].animname, "_encstr_97820AB98DDEB67BBEF6D5A3", ::oninstanceremoved);
        scripts\common\anim::addnotetrack_customfunction(self.winners[2].animname, "_encstr_9A440A23727EC1204F5D0875", ::ongulagendmatch);
        scripts\common\anim::addnotetrack_customfunction(self.winners[2].animname, "_encstr_BD710B3BE1FF938D28DF0716B5", ::onhelmetsniped);
      }

      break;
    case 4:
      self._id_121B8[var_15] back_vector(self.winners[3], %_encstr_87DB1B5A7241E98BDC9C4C377A339357DFBB78B2BA696FA0F850D152D5, %_encstr_87DB1B5A7241E98BDC9C4C377A339357DFBB78B2BA696FA0F850D152D5);

      if(!isDefined(level.scr_notetrack[self.winners[3].animname]) || !isDefined(level.scr_notetrack[self.winners[3].animname]["_encstr_9A19040BCDBC"]["_encstr_BAB9091F942D9858977210"])) {
        scripts\common\anim::addnotetrack_customfunction(self.winners[3].animname, "_encstr_BAB9091F942D9858977210", ::onhotfootplayerkilled);
        scripts\common\anim::addnotetrack_customfunction(self.winners[3].animname, "_encstr_97820AB98DDEB67BBEF6D5A3", ::oninstanceremoved);
        scripts\common\anim::addnotetrack_customfunction(self.winners[3].animname, "_encstr_9A440A23727EC1204F5D0875", ::ongulagendmatch);
        scripts\common\anim::addnotetrack_customfunction(self.winners[3].animname, "_encstr_BD710B3BE1FF938D28DF0716B5", ::onhelmetsniped);
      }

      break;
  }

  self._id_121B8[var_15] awardstadiumblueprint(%_encstr_B453134E9B29B54BF4130BCF6F2F42D7E06052C23B);
}

onhelmetsniped(var_0) {
  var_0.player scripts\mp\utility\infilexfil::givegunless();
}

onhotfootplayerkilled(var_0) {
  setslowmotion(1.0, 0.25, 0.1);
}

oninstanceremoved(var_0) {
  setslowmotion(0.25, 1.0, 0.1);
}

ongulagendmatch(var_0) {
  level.defendkill.gameending notify("_encstr_B26B0C62E310EFF82760E3BB9B80", "_encstr_961804BD954A");
}

ongrenadeused(var_0) {
  setomnvarforallclients("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1);
  level.defendkill.gameending notify("_encstr_B26B0C62E310EFF82760E3BB9B80", "_encstr_961804BD954A");
}

onhack(var_0) {
  brking_ontimelimit(4.8, 130, 4, 8);
}

processvoqueue() {
  switch (level.script) {
    case "_encstr_99640BBF88E674E2C5AD3BF282":
      return "_encstr_9AC926B303B0F113019888AE5AE2AFDD08A0455B7AE757D34BD744F6CF61EF9892B9EA025BB1F0E3";
    case "_encstr_83C10CAD83FA23EDCD2B3AE6B646":
      return "_encstr_A30727BF0399539D18CA29F87A4BB802FDABC71D7B3203A1F17351D3D82F419893870BE3118A29F35B";
    case "_encstr_B1D508B607F591B7CD33":
      return "_encstr_8DC3236DF390F328BF721328AAFB0F7577F59BFF404E426AF0EF576E325503530912573522";
    case "_encstr_84E70D78D34F41EDF1A24D5F7AFB23":
      return "_encstr_99E02518B32F40B5020461E0DE1B8F0B6D8F68783F97197DCA2C68F4F9222930B063A8F03F54B3";
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      return "_encstr_99A1281D20C12C90A0E7C98962725FFD85FE7846DB3A278247CF3092BCD50997B73CD7D7F3CD45B0C3C3";
    case "_encstr_AFFF0BE590A158DFF3D1238507":
      return "_encstr_917326E188D8E850B5FB2C0F13BD6EB80749877817F0BF9B3523373874F75F99624703128B104D20";
    case "_encstr_8C690B68C3BF0D206ED1496BAA":
      return "_encstr_8A5E26882247A1A88FDF91F10E2EC9800BF8DF27393E275370181296773E10323F8F1B2536D7C553";
    case "_encstr_9B330E11FF076B6E22C70B31FB3FB7B0":
      return "_encstr_974F29AD38D74B37CCA5B1EB26397D9537C6583856647DC1D6EB95B98CB4E6B37D360DDE1C832B9CD7A339";
    case "_encstr_A9690B5B38F5ACB98D2C0EACCC":
      return "_encstr_87EB2617204EC14A7D03A511FE3D119593109FEB102B3F2255ADEC5554BF2A50B8F05327401E6C1B";
    case "_encstr_AF690B8DE7364F0A17C0C3EA12":
      return "_encstr_BD0426B5EF3E775505887A41B845411F13DE01208DAB675F2DF8524AA8C786E3C83F98AD9E6EB3A2";
    case "_encstr_8D200EC21BB88FC238EB405D29B18AB6":
      return "_encstr_BD0426B5EF3E775505887A41B845411F13DE01208DAB675F2DF8524AA8C786E3C83F98AD9E6EB3A2";
    case "_encstr_8CD508CA98A70FAFC01D":
      return "_encstr_8E3623CB60D940309B6A7806C21360E06DC6F1371DFD708B936216894A0FAFF807329FE992";
    case "_encstr_A3F50BC8631F6D20CD64F7A155":
      return "_encstr_8E3623CB60D940309B6A7806C21360E06DC6F1371DFD708B936216894A0FAFF807329FE992";
    case "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319":
      return "_encstr_8E3623CB60D940309B6A7806C21360E06DC6F1371DFD708B936216894A0FAFF807329FE992";
    case "_encstr_93BA0B9A43E0DBCAA1891D041D":
      return "_encstr_99E02518B32F40B5020461E0DE1B8F0B6D8F68783F97197DCA2C68F4F9222930B063A8F03F54B3";
    case "_encstr_8F340F3992796F28DFDFE808E736C1FF27":
      return "_encstr_8E3623CB60D940309B6A7806C21360E06DC6F1371DFD708B936216894A0FAFF807329FE992";
  }

  return "_encstr_B40101";
}

givestartingarmor(var_0, var_1) {
  var_2 = self.origin + (0, 0, 1000);
  var_3 = vectorNormalize(var_2 - var_1);
  var_4 = var_2 + var_3 * 3000;
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_5 playSound("_encstr_93281AFD4AE11813B3B290FE9ABB469085B91D7FFF945051F7C9A843");
  var_5 moveTo(var_2, var_0);
  wait(var_0);
  var_5 delete();
}

givesuperpointsonprematchdone() {
  if(level.defendkill.winners.size == 0) {
    return;
  }
  var_0 = "_encstr_B6F522855BE76FCEF0E2AF8AAAA160CA6FFF10F1862240FF1BFB59C251DBB653C8FB063D";
  var_1 = "_encstr_A6CC1ACA12B95883921814F909FF568CDF90CEEB75EBB04D55E750BD";

  if(level.defendkill.onping == "_encstr_A143070DA0DA6B3885") {
    var_0 = "_encstr_AB2824EDC51307EE959132DB609B254F08207C8A503E0EB24188FB02A89F1A5F261BFE0476C0";
    var_1 = "_encstr_A6CC1ACA12B95883921814F909FF568CDF90CEEB75EBB04D55E750BD";

    switch (level.defendkill.winners.size) {
      case 1:
        var_0 = "_encstr_81782882F8B799C30B905D481430A3D12B989BEBC017DA43E0E7394D361E1B6579C88252D9D3456BDBD8";
        var_1 = "_encstr_8CD821234D08F2D8A8B8955173781A1BD7FFF6E3DBC6DBB7B0468AA5E84B5E02580173";
        break;
      case 2:
        var_0 = "_encstr_84832825C56771EAC3690F439898AC390BD0EB9AA0971F20E870773F503688E2E9FBF5D6AF03126C7318";
        var_1 = "_encstr_BE3B214C93F5B2C3CC5A36F583164E8E62FA46C1B29CDCEDE6F50EBD8D4B9BC2D7D839";
        break;
      case 3:
        var_0 = "_encstr_9A09285BAB6EFA2627FAB20F335A1BD72DDC1DC9DEFACC1C8D58BC564EF538BDB15AE62CBEA537E8E4F6";
        var_1 = "_encstr_8C0221C493BEB2E1CCB4B1AF38C2931D4CEB663895E4B9F673AF1CDB8D4B9B58D76339";
        break;
      case 4:
        var_0 = "_encstr_9A3B28FBCDFB69C6FAD132B3FE1B282F39525BE390A04A43705AFB19D3FFD222DCBF608370A42E5B0AB7";
        var_1 = "_encstr_A60221D83BC6FF931B10954FF30AE5ABA3817B7B2BABC0758551D92D0BA26033373BD5";
        break;
    }

    soundsettimescalefactor("_encstr_8276157368166583C5BB0DC914C1C93D98F0E74F69E3DC", 0);
    soundsettimescalefactor("_encstr_837C16820519BF0BDCD83AF18024B7F990952A0D9F711223", 0);
    soundsettimescalefactor("_encstr_99B3096058CBD19FA93D83", 0);
  } else if(level.defendkill.onping == "_encstr_92EF0C076332FF48B54A36AAF088") {
    var_0 = "_encstr_965F21DA57B9FAF41E1C99AFE9B5267DB2C399A5D8FACC1C63B0E559E4D74B73D139F6";
    var_1 = "_encstr_A6CC1ACA12B95883921814F909FF568CDF90CEEB75EBB04D55E750BD";

    switch (level.defendkill.winners.size) {
      case 1:
        var_0 = "_encstr_A3D0218F90531FE3B9779A895AAB5AD739602B67B00EC90BF987103F462722BE639897";
        var_1 = "_encstr_BA561E31C9D7ACC3CC5AB1F5A7B6C4EBE085C93A89BE891C9593B9F6B97D8D93";
        break;
      case 2:
        var_0 = "_encstr_A30221737F9BAF60C0A2A326488DF85852F3EDE3F3A17EF8FCFE9279725768081BB347";
        var_1 = "_encstr_9A5E1E2613D748FBF278E0E8F2406BB937FB05C51B39C212A25BD6DF75C9CCB5";
        break;
      case 3:
        var_0 = "_encstr_965F21DA57B9FAF41E1C99AFE9B5267DB2C399A5D8FACC1C63B0E559E4D74B73D139F6";
        var_1 = "_encstr_81721E0B106EED0B5D2385719263E28FD3E033DB92C67353A3464A75F05F3A6A";
        break;
      case 4:
        var_0 = "_encstr_8EDF21B6EA6EEB4FE10E99FAD3D698AFAC0FCC96637D0D38362CF2B2E4BEB4B9D1C97B";
        var_1 = "_encstr_A2951E26C9BECA3C995A63EBA75B89F50E85E447897DA183599CB9F673EB6327";
        break;
    }
  } else {
    var_0 = "_encstr_B6F522855BE76FCEF0E2AF8AAAA160CA6FFF10F1862240FF1BFB59C251DBB653C8FB063D";
    var_1 = "_encstr_A6CC1ACA12B95883921814F909FF568CDF90CEEB75EBB04D55E750BD";

    switch (level.defendkill.winners.size) {
      case 1:
        var_0 = "_encstr_849422B2C88789D31BD617250BE1870DB7B00A9B5867715673513141AD4B97946D3053A2";
        var_1 = "_encstr_A3E81A5AC0019ABBC92D5029E09FA8FB0FEEF76B8FE09BB2F68F65ED";
        break;
      case 2:
        var_0 = "_encstr_92712231DBB33F310ABE9148BB3668E1D94438C5722A77F3D03B7890D75AE62332ABAEC0";
        var_1 = "_encstr_86961A6EBB09956BD4336BAF290F93DC1266F272F1D84BD238475303";
        break;
      case 3:
        var_0 = "_encstr_B6F522855BE76FCEF0E2AF8AAAA160CA6FFF10F1862240FF1BFB59C251DBB653C8FB063D";
        var_1 = "_encstr_A6CC1ACA12B95883921814F909FF568CDF90CEEB75EBB04D55E750BD";
        break;
      case 4:
        var_0 = "_encstr_868722B5ABDCAF134ECCEB2B3C99B4C6FA5A9BE89CDEAF0D388D2CCB56C97DD2DCE893ED";
        var_1 = "_encstr_AC711AF8CB393BFA636931A068A763D10AA1C2F0D20A4F506BB7C92E";
        break;
    }
  }

  foreach(var_3 in level.players) {
    var_3 playlocalsound(var_1);
    var_3 playlocalsound(var_0);
  }

  waitframe();
  setmusicstate("_encstr_B40101");

  foreach(var_3 in level.players)
  var_3 setsoundsubmix("_encstr_917111E56971165B383123CA9889B74FE83965", 4);
}

giveteampoints() {
  if(level.defendkill.winners.size == 0) {
    return;
  }
  var_0 = "_encstr_924B19BA0827CF734133EC27D949FFD5FFAA23D2080387035EA7E5";

  switch (level.defendkill.winners.size) {
    case 1:
      var_0 = "_encstr_B2F018C91ABB713D13037371CF2AF0709235162B025C48EB3A4B";
      break;
    case 2:
      var_0 = "_encstr_BABD18C4C9CCFAAC87335AB1AF4BDCE8E47BEB461CB1B0E5CA93";
      break;
    case 3:
      var_0 = "_encstr_B6C118D67637A13D5250CFC381A8FEDB4DB7111ADF211A5999D8";
      break;
    case 4:
      var_0 = "_encstr_A6E91868DA4EB999F8A6CBCB9768A5038AD8C9FB68C861834135";
      break;
  }

  setmusicstate(var_0);
}

glgrenade(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  if(isDefined(level.defendkill.onping) && level.defendkill.onping != "_encstr_A143070DA0DA6B3885") {
    foreach(var_2 in level.players)
    var_2 playlocalsound("_encstr_A14C15117B27E590D721998755BD38A0C3E2AB5B3103A6");
  }
}

glgrenadeparent(var_0) {
  level.defendkill.onkillingblow thread givequestrewardref();
  thread givesuperpointsonprematchdone();

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::turret_headicon())
    setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 17);

  if(isDefined(level.defense_wave_send_support)) {
    level.defendkill._id_12D97 show();

    foreach(var_2 in level.players)
    var_2.player_rig unlink();
  }

  brking_ontimelimit(2.8, 200);
}

glint(var_0) {
  brking_ontimelimit(2.8, 250);
  level.defendkill.onkillingblow thread givequestrewardref();

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_2 in level.defendkill.canspawnontacinsert)
    var_2 show();
  }

  foreach(var_5 in var_0) {
    if(isDefined(var_5))
      var_5 scripts\mp\utility\player::_id_1328C("_encstr_B107031B8F", 1);
  }
}

glintfx(var_0) {
  brking_ontimelimit(2.8, 250);

  if(getdvarint("_encstr_AC2A11B9C6C9AF31E4F5E93C0E7DB23CCC5A1B", 0) == 1) {
    var_1 = 1;
    _encstr_B864178E58B0A00A77332F7B4F30A3EDD8A185D2512B7EF2D4(80, var_1);
  }

  if(!isDefined(level.defense_wave_send_support)) {
    if(level.defendkill.winners.size < 4) {
      if(isDefined(level.defendkill.rope))
        level.defendkill.rope delete();
    }
  }

  level.defendkill.onkillingblow thread givequestrewardref();

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_3 in level.defendkill.canspawnontacinsert)
    var_3 hide();
  } else {
    foreach(var_3 in level.defendkill.canspawnontacinsert)
    var_3 delete();
  }

  var_7 = ["_encstr_A7010904FF5757B753CBFF", "_encstr_93010973A849F7DA5B0B32", "_encstr_8F0109E858D9FA76BACB0D", "_encstr_9101096BBF4A4F97FB983D"];

  foreach(var_9 in var_0) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(!isDefined(var_9._id_145CA)) {
      continue;
    }
    var_9.player_rig linkTo(level.defendkill.onkillingblow, var_7[var_9._id_145CA], (0, 0, 0), (0, 0, 0));
    var_9.x1fin_playerdisconnect = level.defendkill.onkillingblow;
    var_9.x1fin_removequestinstance = var_7[var_9._id_145CA];
  }

  foreach(var_12 in level.defendkill._id_124EA) {
    if(!isDefined(var_12)) {
      continue;
    }
    if(isDefined(var_12.player)) {
      continue;
    }
    if(!isDefined(var_12._id_145CA)) {
      continue;
    }
    var_12 linkTo(level.defendkill.onkillingblow, var_7[var_12._id_145CA], (0, 0, 0), (0, 0, 0));
    var_12.x1fin_playerdisconnect = level.defendkill.onkillingblow;
    var_12.x1fin_removequestinstance = var_7[var_12._id_145CA];
  }

  global_variables(var_0);
}

onjoinspectators(var_0) {
  brking_ontimelimit(4.8, 92, 100, 100);
  brking_onplayerkilled(13);
  level.defendkill._id_127E3 show();
  level.defendkill._id_127E3 hidepart("_encstr_9ABB0968F1402B19E2AFA9");
  level.defendkill._id_127E3 hidepart("_encstr_AADA07DBF19A4A81D7");
  level.defendkill._id_127E3.head show();
  level.defendkill._id_127E3.rifle show();
  level.defendkill._id_12909 show();
  level.defendkill._id_12909.linkedents[0] show();

  if(!isDefined(level.defense_wave_send_support)) {
    if(level.defendkill.winners.size < 4) {
      if(isDefined(level.defendkill.rope))
        level.defendkill.rope delete();
    }
  }

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_2 in level.defendkill.canspawnontacinsert)
    var_2 hide();
  } else {
    foreach(var_2 in level.defendkill.canspawnontacinsert)
    var_2 delete();
  }
}

global_relic_amped_func(var_0) {
  foreach(var_2 in level.players)
  var_2 setclienttriggeraudiozone("_encstr_8A101295D8EEB7E9F13A8A596B4AF02417207DE3", 0.05);

  setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 13);
  brking_onplayerkilled(45);
  brking_ontimelimit(10, 18);
  level.defendkill.onkillingblow thread givequestrewardref();

  if(level.defendkill.winners.size == 1)
    thread glgrenade(1.266);
}

global_relic_landlocked_func(var_0) {
  setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 14);
  brking_onplayerkilled(50);
  brking_ontimelimit(11, 30);
  level.defendkill.onkillingblow thread givequestrewardref();

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_2 in var_0)
    var_2 hide();
  } else
    large_transport_initomnvars(var_0);

  if(level.defendkill.winners.size == 2)
    thread glgrenade(2.033);
}

global_relic_squadlink_func(var_0) {
  setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 15);
  brking_onplayerkilled(50);
  brking_ontimelimit(8, 14.5);
  level.defendkill.onkillingblow thread givequestrewardref();

  if(level.defendkill.winners.size == 3)
    thread glgrenade(2.0);
}

global_relic_team_prox_func(var_0) {
  setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 16);
  brking_onplayerkilled(55);
  brking_ontimelimit(3, 29);
  level.defendkill.onkillingblow thread givequestrewardref();

  if(level.defendkill.winners.size == 4)
    thread glgrenade(2.5);
}

global_stealth_broken_func(var_0) {
  foreach(var_2 in level.players)
  var_2 clearclienttriggeraudiozone(0.1);

  brking_onplayerkilled(65);
  brking_ontimelimit(2.8, 500);
  level.defendkill.onkillingblow thread givequestrewardref();
}

global_variables(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 scripts\mp\utility\player::_id_1328C("_encstr_8D070366C0", 1);
  }
}

globalrelicsfunc(var_0) {
  if(level.defendkill.winners.size == 1)
    _id_138B4();
}

globalstruct(var_0) {
  if(level.defendkill.winners.size == 2)
    _id_138B4();
}

go_investigate_loc(var_0) {
  if(level.defendkill.winners.size == 3)
    _id_138B4();
}

go_patrol_the_maze(var_0) {
  if(!isDefined(level.defense_wave_send_support))
    setomnvarforallclients("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1);
}

_id_138B4() {
  level.defendkill.gameending notify("_encstr_B26B0C62E310EFF82760E3BB9B80", "_encstr_961804BD954A");
}

givexpwithtext() {
  if(!isDefined(level.br_circle)) {
    return;
  }
  if(!isDefined(level.br_circle.dangercircleent)) {
    return;
  }
  level.br_circle.dangercircleent brcirclemoveTo(self.origin[0], self.origin[1], 9000, 0.05);
}

large_transport_initomnvars(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.linkedents))
      scripts\engine\utility::array_delete(var_2.linkedents);

    var_2 delete();
  }
}

givequestrewardref() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_8B95175EB3578BE03908B74B8090A4210558E3D526DF522B60"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

_encstr_BE95165A60D8B36A5065D7EA47C8361F753EE33229ABB320() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.1;
  playFX(scripts\engine\utility::getfx("_encstr_85E41101EAD75FE0072ADBB9266C48B08F129B"), self.origin);
}

go_to_combat() {
  level._effect["_encstr_A5C41283E14EE339B347EA3BB0CEB07D26FD790B"] = loadfx("_encstr_A6E3316799F097A5771CF589E45EEC855B59C1B116F2CBEC99E17D1339EB19A5DCB1DB7337CAC68EEB0E3616E5CAE471D9CC1E");

  if(getdvarint("_encstr_AC2A11B9C6C9AF31E4F5E93C0E7DB23CCC5A1B", 0) == 1) {
    level._effect["_encstr_8B95175EB3578BE03908B74B8090A4210558E3D526DF522B60"] = loadfx("_encstr_ACBA37F64C72C62C9FAA917AC017E7B788A5789457FA7E3355409902A0E70B978219F22F7EA0AFBD036153BA802752DF58707E8181408B8719");
    level._effect["_encstr_85E41101EAD75FE0072ADBB9266C48B08F129B"] = loadfx("_encstr_99F740CE66E1CB4BDDE0BE269C5EECC2B6CA831B16CB976CD24E1BC6955ED9660FF55937C643AFA75BC4AF8D2D4E6CC659FA9DB0B9EB2BF0CCA58DF506C4E2D9CC0F");
    level._effect["_encstr_8ECE1A33787978AB4AA31F951A47A9553718CB61479312972B876BC5"] = loadfx("_encstr_84B13F9D33875E96DD1C7D31C9F2D916B6ACE036852F79E97BAD13A5CA979D33F0D74FB64CEBCA3C99A51BD7D1C90BC6B2C9F5334EDE9BA3AF37A3C9854BCE0D8E");
  } else {
    level._effect["_encstr_8B95175EB3578BE03908B74B8090A4210558E3D526DF522B60"] = loadfx("_encstr_AAC7319D663C5E96BB0ED7139CBC76C25BB21CB18597BC6799F0EBC427AF4CD82D5B2CD7E4BD47F639FA963799961B173BCC87");
    level._effect["_encstr_85E41101EAD75FE0072ADBB9266C48B08F129B"] = loadfx("_encstr_93F73AB399E1E5A5EE0EAF4C395ECE2CADB2078DB02FF28D9627B136CACB9D993CBEC49CEB362D4EB1C6597DD9856EEBCAC399D2C6AF8162E267CCE1");
  }
}

onjoinedteamcb(var_0, var_1) {
  wait(var_0);
  preloadcinematicforall(var_1, 1, 0);
}

_encstr_BAAC1F196C17F847D2435B693B3A8110BF85A1D0577FA8735FB2E31F77935F985C(var_0) {
  level.defendkill.onkillingblow thread givequestrewardref();
  var_0 thread _encstr_BE95165A60D8B36A5065D7EA47C8361F753EE33229ABB320();
  thread givesuperpointsonprematchdone();
  setomnvarforallclients("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 17);

  if(isDefined(level.defense_wave_send_support)) {
    level.defendkill._id_12D97 show();

    foreach(var_2 in level.players)
    var_2.player_rig unlink();
  }

  brking_ontimelimit(2.8, 200);
}

_encstr_B8701FF758F5A81FB73BB902625FD9300DA57D7BFD51E86B8A271BEEDB03070863(var_0) {
  brking_ontimelimit(2.8, 150);
  _encstr_B864178E58B0A00A77332F7B4F30A3EDD8A185D2512B7EF2D4(49);
  var_0 show();
  level.defendkill.onkillingblow thread givequestrewardref();
}

_encstr_A5221F8F3080E3BFE0E363B097FA91206FEF8548AA97D3506BE771E790E3706A81(var_0) {
  var_1 = var_0["_encstr_881108BBB95836E360FF"];
  var_2 = var_0["_encstr_8D48079DD59BE65627"];
  var_3 = var_0["_encstr_AACC0EF4BDDA135A2BDC8ADB09A5232B"];
  var_2 hide();

  foreach(var_5 in var_3)
  var_5 hide();

  brking_ontimelimit(2.8, 250);
  _encstr_B864178E58B0A00A77332F7B4F30A3EDD8A185D2512B7EF2D4(80);
  level.defendkill.onkillingblow thread givequestrewardref();

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_8 in level.defendkill.canspawnontacinsert)
    var_8 show();
  }

  foreach(var_11 in var_1) {
    if(isDefined(var_11))
      var_11 scripts\mp\utility\player::_id_1328C("_encstr_B107031B8F", 1);
  }
}

shoot_gun_from_notetrack(var_0) {
  if(isDefined(self.player) && self.player tagexists("_encstr_A14F0AE336178944BA076F41")) {
    var_1 = self.player gettagorigin("_encstr_A14F0AE336178944BA076F41");
    var_2 = var_1 + anglesToForward(self.player gettagangles("_encstr_A14F0AE336178944BA076F41")) * 100;
    magicbullet(self.player.primaryweaponobj.basename, var_1, var_2);
    playFXOnTag(level._effect["_encstr_8ECE1A33787978AB4AA31F951A47A9553718CB61479312972B876BC5"], self.player, "_encstr_A14F0AE336178944BA076F41");
  }
}

_encstr_85A620D23BCFE26CF618FF8BC14B396B81C09D41945D3A8D1E789FEB78E3FAB2076A(var_0) {
  if(isDefined(self.player) && self.player tagexists("_encstr_A14F0AE336178944BA076F41")) {
    var_1 = self.player gettagorigin("_encstr_A14F0AE336178944BA076F41");
    var_2 = var_1 + anglesToForward(self.player gettagangles("_encstr_A14F0AE336178944BA076F41")) * 100;
    magicbullet("_encstr_8E86126A40892133C04890B9F7E97622C1695273", var_1, var_2);
    playFXOnTag(level._effect["_encstr_8ECE1A33787978AB4AA31F951A47A9553718CB61479312972B876BC5"], self.player, "_encstr_A14F0AE336178944BA076F41");
  }
}

_encstr_ADD519F3F9986F0D7FD0A01BD0D96D706DAFD50714E25BF392DEB7(var_0) {
  var_1 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 = var_1 + anglesToForward(self gettagangles("_encstr_A2B40B8E2C3B7DDB274B9D4B37")) * 100;
  magicbullet("_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1", var_1, var_2);
}

brking_ontimelimit(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 100;

  if(!isDefined(var_3))
    var_3 = 100;

  foreach(var_6 in level.players) {
    if(!isDefined(var_6._id_12F8A)) {
      var_6._id_12F8A = 1;
      var_6 enablephysicaldepthoffieldscripting();
    }

    if(isDefined(var_4)) {
      var_6 setphysicaldepthoffield(var_0, var_1, var_2, var_3, var_4);
      continue;
    }

    if(isDefined(var_3)) {
      var_6 setphysicaldepthoffield(var_0, var_1, var_2, var_3);
      continue;
    }

    if(isDefined(var_2)) {
      var_6 setphysicaldepthoffield(var_0, var_1, var_2);
      continue;
    }

    var_6 setphysicaldepthoffield(var_0, var_1);
  }
}

brking_onplayerkilled(var_0) {
  foreach(var_2 in level.players)
  var_2 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_0);
}

_encstr_B864178E58B0A00A77332F7B4F30A3EDD8A185D2512B7EF2D4(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_0);
    var_3 setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 1);

    if(istrue(var_1))
      var_3 thread _encstr_B29709D0D73391D152F51C();
  }
}

_encstr_B29709D0D73391D152F51C() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::waittill_any_ents(level.defendkill, "_encstr_A2440FB0B1B1FAB936CACDB2B9D7CADC19", level.defendkill, "_encstr_B44E0A0AB9F8BE9A680B0323");
  self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", 65);
  self setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 0);
}

brking_onplayerconnect() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_12F8A)) {
      var_1._id_12F8A = undefined;
      var_1 disablephysicaldepthoffieldscripting();
    }
  }
}

_id_12F84() {}

init_bomb_objective(var_0) {
  var_1 = spawnStruct();
  var_1.ents = [];
  var_1.players = [];
  var_1.gameending = undefined;
  var_1.anime = var_0;
  var_1._id_121B8 = [];
  return var_1;
}

back_struct(var_0, var_1) {
  level.scr_anim[var_0.animname][self.anime] = var_1;
  level.scr_animname[var_0.animname][self.anime] = getanimname(var_1);
  self.ents[self.ents.size] = var_0;
}

backendevent(var_0, var_1) {
  self.startfunc = var_1;
  self._id_121D4 = var_0;
}

back_vector(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_4 = undefined;

  if(!isDefined(var_0.disable_stealth_reinforcement_icon)) {
    var_4 = "_encstr_8BB007E03658CBCAE4" + var_0 getentitynumber();
    var_0.animname = var_4;
    var_0.disable_stealth_reinforcement_icon = var_4;
  } else
    var_4 = var_0.disable_stealth_reinforcement_icon;

  self.players[self.players.size] = var_0;
  var_5 = var_1;

  if(isDefined(var_2)) {
    if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
      var_5 = var_2;
  }

  if(isDefined(var_3)) {
    if(isDefined(var_0.isjuggernaut))
      var_5 = var_3;
  }

  level.scr_anim[var_4][self.anime] = var_5;
  level.scr_eventanim[var_4][self.anime] = getanimname(var_5);
}

awardstadiumblueprint(var_0) {
  self.gameending = 1;
  level.scr_anim["_encstr_87730A95DCC82DCDCE1A855B"][self.anime] = var_0;
}

back_field_clip(var_0, var_1, var_2) {
  self.fx = var_0;
  self.playerzombiemonitorinput = var_1;
  self.playerzombiehud = var_2;
}

#using_animtree("_encstr_B40101");

_id_135CA(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_3 setModel(var_0);

  if(!isDefined(var_1))
    var_1 = var_0;

  var_3.animname = var_1;
  var_3 useanimtree(#animtree);

  if(isDefined(var_2)) {
    var_3.linkedents = [];

    foreach(var_5 in var_2) {
      var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      var_6 setModel(var_5[0]);
      var_6 linkTo(var_3, var_5[1], (0, 0, 0), (0, 0, 0));
      var_3.linkedents[var_3.linkedents.size] = var_6;
    }
  }

  return var_3;
}

#using_animtree("_encstr_B40101");

back_door_enemy_watcher(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_5 setModel(var_0);
  var_5 useanimtree(#animtree);

  if(isDefined(var_4))
    var_6 = var_4;
  else
    var_6 = var_0;

  var_5.animname = var_6;
  level.scr_anim[var_5.animname]["_encstr_A3540A367A77A1CD0F8A5010"] = var_2;

  if(isDefined(var_3))
    level.scr_animname[var_5.animname]["_encstr_A3540A367A77A1CD0F8A5010"] = var_3;

  if(isDefined(var_1)) {
    var_5.linkedents = [];

    foreach(var_8 in var_1) {
      var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      var_9 setModel(var_8[0]);
      var_9 linkTo(var_5, var_8[1], (0, 0, 0), (0, 0, 0));
      var_5.linkedents[var_5.linkedents.size] = var_9;
    }
  }

  self.pack.models[self.pack.models.size] = var_5;
  return var_5;
}