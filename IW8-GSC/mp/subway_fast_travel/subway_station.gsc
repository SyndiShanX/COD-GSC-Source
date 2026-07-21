/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\subway_fast_travel\subway_station.gsc
****************************************************/

register_ai_damage_callbacks() {
  level.agent_funcs["_encstr_A99A17D70BBB8095A12AF0A042C017381F8FEE5F7387CEFDD2"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_A99A17D70BBB8095A12AF0A042C017381F8FEE5F7387CEFDD2"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_A99A17D70BBB8095A12AF0A042C017381F8FEE5F7387CEFDD2"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_A5661FC7FE7D3802F83D10E82D8899193F0F96F69BF2B9CDCB2A67E5AB0AF77755"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_A5661FC7FE7D3802F83D10E82D8899193F0F96F69BF2B9CDCB2A67E5AB0AF77755"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_A5661FC7FE7D3802F83D10E82D8899193F0F96F69BF2B9CDCB2A67E5AB0AF77755"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_A7D418B06C477B9CBE59DCB25BBCD7B1BBBE98E4FA4C4EEAA3CA"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_A7D418B06C477B9CBE59DCB25BBCD7B1BBBE98E4FA4C4EEAA3CA"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_A7D418B06C477B9CBE59DCB25BBCD7B1BBBE98E4FA4C4EEAA3CA"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_A7461D077A43FFD097C36E2D35C031A4D7F7D64B87756D7438A10BEE210393"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_A7461D077A43FFD097C36E2D35C031A4D7F7D64B87756D7438A10BEE210393"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_A7461D077A43FFD097C36E2D35C031A4D7F7D64B87756D7438A10BEE210393"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
}

callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = self;

  if(!isDefined(var_14.agent_type)) {
    return;
  }
  if(!isDefined(var_12))
    var_12 = var_5;

  if(!isDefined(var_13))
    var_13 = var_2;

  if(var_4 != "_encstr_AB590C99ED78875F650F3951034D") {
    if(is_friendly_damage(var_14, var_0))
      return;
  }

  if(!isDefined(var_1))
    var_1 = var_14;

  var_15 = should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_14);

  if(!var_15) {
    return;
  }
  var_3 = var_3 | 4;
  var_16 = var_2;
  var_17 = var_12.basename;
  var_18 = var_12.classname;
  var_19 = is_suicide_bomber();
  var_20 = istrue(var_1.inlaststand);
  var_21 = var_4 == "_encstr_8DED0A21C79B660BC7588981";
  var_22 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && var_8 != "_encstr_8BBA05185F8B99";
  var_23 = isDefined(var_1) && isPlayer(var_1);
  var_24 = isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_25 = isDefined(var_14.unittype) && var_14.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  var_26 = var_22 && scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1);
  var_27 = var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && (isDefined(var_8) && var_8 == "_encstr_8BBA05185F8B99") || var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48";
  var_28 = var_4 == "_encstr_9B0D099AD3887D91252954";
  var_29 = var_23 && var_1 _hasperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
  var_30 = isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_31 = var_30 && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3";
  var_32 = isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && !isDefined(var_1.owner);
  var_33 = var_32 && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3";
  var_34 = 0;
  var_35 = 0;

  if((var_23 || var_24) && istrue(var_14.invulnerable) && var_4 != "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  if(var_25) {
    if(var_21)
      var_2 = 0;
    else {
      var_2 = var_2 * 0.3;

      if(var_17 == "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1" || var_17 == "_encstr_AC5911C3C04BE2CF58550D3F6F03FFAC971B0B")
        var_2 = var_2 * 15;

      if(var_17 == "_encstr_8DCB0F47F22330CEE7996B13A2E390583A")
        var_2 = self.health + 1000;
    }

    if(var_31) {
      var_36 = ["_encstr_8C190467402B"];

      if(scripts\engine\utility::array_contains(var_36, var_1.vehiclename))
        var_1 dodamage(10000, var_1.origin, var_14);
      else {
        playsoundatpos(self.origin + (0, 0, 40), "_encstr_92B30D6F234A09E94D1C433D9841E8");
        var_2 = self.health + 1000;
      }
    }
  } else if(var_23) {
    if(var_17 == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83")
      var_2 = self.health + 1000;

    if((var_17 == "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8" || var_17 == "_encstr_BADF128E579CD726C90B46D895F2EBB537FAB6E0") && var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F")
      var_2 = self.health + 1000;
  }

  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    if(_id_132EB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
      return;
    }
    if(var_8 == "_encstr_A32D07CFD14BAA94D0" && (var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F") && var_2 > 175) {
      var_2 = var_2 * 0.05;
      var_8 = "_encstr_9B7A0CF35815C3971660B7CF306B";
    }
  }

  if(var_19) {
    if(var_17 == "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18")
      var_2 = self.health + 1000;
  }

  if(var_31)
    playsoundatpos(self.origin + (0, 0, 40), "_encstr_92B30D6F234A09E94D1C433D9841E8");

  if(var_33) {
    if(istrue(self.trial_target_think_func)) {
      var_2 = 0;
      var_14 notify("_encstr_AB5011CE5943D71BE4EA3786D79158DA2CCE95", var_1);
    }
  }

  if(var_23) {
    var_14.damaged_by_player = 1;

    if(var_26) {
      if(var_25)
        var_2 = bink_save_hack(var_2, var_5, var_18, var_4, var_1);
    }

    if(var_29)
      var_2 = var_2 * 2;

    if(var_27) {
      var_37 = var_2 * 2.5;

      if(isDefined(level.explosivedamagemod))
        var_37 = var_37 * level.explosivedamagemod;

      var_2 = var_2 + var_37;
    }

    if(var_28)
      var_2 = var_2 + var_2 * 3.5;

    if(var_21 && !var_25) {
      if(istrue(var_14.immune_to_melee_damage)) {
        var_2 = 0;
        var_14 notify("_encstr_8B721A986F54108DB1EB83B11F9A4079FDC7201197BFB8B1CAE795AB", var_1);
      } else {
        var_2 = 150;

        if(issubstr(var_17, "_encstr_BED80D7C9C59D95BF870DBDFA9F018"))
          var_2 = 350;

        if(issubstr(var_17, "_encstr_85E10896BB07EB6B59D7"))
          var_2 = 350;
        else if(isDefined(var_12.muzzle)) {
          if(issubstr(var_12.muzzle, "_encstr_AC0F0C470DEB32B82B377028583D"))
            var_2 = 350;

          if(issubstr(var_12.muzzle, "_encstr_B282081385F2F6B9B2D1"))
            var_2 = 350;
        }
      }
    }

    if(var_22) {
      if(!var_26) {
        if(!isDefined(level.bullet_damage_scalar))
          level.bullet_damage_scalar = 1;

        var_2 = var_2 * level.bullet_damage_scalar;
      }

      var_2 = var_2 * 1;
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      var_38 = isDefined(var_12) && scripts\mp\utility\weapon::iskillstreakweapon(var_12.basename);
      var_39 = scripts\mp\damage::cac_modified_damage(var_14, var_1, var_2, var_4, var_12, var_6, var_7, var_8, var_0, 0, var_3, var_38, var_13);
      var_2 = var_39[0];
      var_34 = var_39[1];
      var_35 = var_39[2];

      if(scripts\mp\damage::armorvest_washit(var_1) || scripts\mp\damage::helmet_washit(var_1)) {
        var_3 = var_3 | level.ss_circletick;
        var_1 playsoundtoplayer("_encstr_A1BB141A961DBE6B169CB6599CFA9946BEB093ADBD27", var_1);
      }

      if(scripts\mp\damage::armorvest_wasbroke(var_1) || scripts\mp\damage::helmet_wasbroke(var_1)) {
        var_3 = var_3 | level.sr_next_ammo_restock_time;
        var_1 playsoundtoplayer("_encstr_B17B1AC857E3D90A898228DD1389AF5F9E276E5A57DAE1D533C588CA", var_1);
      }

      if(isDefined(level._id_11FFB))
        var_3 = var_3 | [[level._id_11FFB]](var_14);
    }
  }

  if(isDefined(var_17) && var_17 == "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8" && isDefined(var_4) && var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B")
    var_2 = var_2 * 2;

  if(var_23 || var_24 || var_31) {
    if(isDefined(var_12)) {
      if(var_24)
        var_1 = var_1.owner;

      binoculars_onstateupdatefunc(self, var_1, var_0, var_12, var_2, var_6, var_7, var_8, var_9, var_4);
    }

    if(var_2 >= var_14.health) {
      if(var_12.basename == "_encstr_8BBA05185F8B99") {
        if(isDefined(var_0) && isDefined(var_0.weapon_name))
          var_12 = getcompleteweaponname(var_0.weapon_name);
      }

      var_40 = spawnStruct();
      var_40.einflictor = var_0;
      var_40.eattacker = var_1;
      var_40.idamage = var_2;
      var_40.idflags = var_3;
      var_40.smeansofdeath = var_4;
      var_40.sweapon = var_5;
      var_40.vpoint = var_6;
      var_40.vdir = var_7;
      var_40.shitloc = var_8;
      var_40.timeoffset = var_9;
      var_40.modelindex = var_10;
      var_40.partname = var_11;
      var_40.objweapon = var_12;
    }
  }

  var_2 = int(min(var_2, var_14.maxhealth));

  if(is_flashbang(var_17, var_12, var_0) && var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    var_14 notify("_encstr_ABE70A08F0C68B546D12A8E7", var_8, 1, undefined, var_1, "_encstr_9A8507BA4040188D08");

  if(is_gas(var_17) && var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    var_14 notify("_encstr_ABE70A08F0C68B546D12A8E7", var_8, 1, undefined, var_1, "_encstr_9A8507BA4040188D08");

  if(isDefined(var_14.unittype) && isDefined(level.agent_funcs[var_14.unittype]) && isDefined(level.agent_funcs[var_14.unittype]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]))
    var_14[[level.agent_funcs[var_14.unittype]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11, var_34, var_35);
  else
    var_14[[level.agent_funcs[var_14.agent_type]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11, var_34, var_35);
}

callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(var_4 == "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_7, var_7, var_8, var_9, self, var_13, var_14);
  var_3 = 0;

  if(!isDefined(self.painsound)) {
    return;
  }
  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound))
      self playSound(self.painsound);

    self.next_dmg_sound = gettime() + 500;
  }
}

callbacksoldieragentgametypekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  deactivateagent();

  if(isDefined(level.spawnloopupdatefunc))
    [[level.spawnloopupdatefunc]](var_1, var_4);

  if(isDefined(var_3) && var_3 == "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  if(istrue(self.marked_for_death))
    self.marked_for_death = undefined;

  if(isDefined(self.isinlaststand)) {
    var_9 = spawnStruct();
    var_9.einflictor = var_0;
    var_9.eattacker = var_1;
    var_9.idamage = var_2;
    var_9.smeansofdeath = var_3;
    var_9.sweapon = var_4;
    var_9.vdir = var_5;
    var_9.shitloc = var_6;
    var_9.timeoffset = var_7;
    var_9.deathanimduration = var_8;
    thread[[self.isinlaststand]](var_9);
  }

  if(isPlayer(var_1))
    level thread handle_death_sounds(var_1, self, var_3);

  if(isDefined(level.removefromtargetmarkeronkillfunc))
    level thread[[level.removefromtargetmarkeronkillfunc]](self);

  var_10 = 0;
  process_damage_feedback(var_0, var_1, var_2, var_10, var_3, var_4, var_5, var_5, var_6, var_7, self, 0, 0);
}

is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team)
      return 1;

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team)
      return 1;
  }

  return 0;
}

should_do_damage_checks(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    return 0;
  else if(var_0 != var_5 && isDefined(var_0.team) && var_0.team == var_5.team)
    return 0;
  else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](var_0, var_1, var_2, var_3, var_4, var_5))
    return 0;

  return 1;
}

is_suicide_bomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B");
}

bink_save_hack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;

  switch (var_2) {
    case "_encstr_965306392D3336B2":
      var_5 = min(var_0, 84);
      break;
    case "_encstr_BE1904DCDA9D":
      var_5 = min(var_0, 110);
      break;
    case "_encstr_BE0703A54C":
      var_5 = min(var_0, 105);
      break;
    case "_encstr_A1100738A33A638123":
      var_5 = min(var_0, 84);
      break;
    case "_encstr_8D940738966ED1DB8D":
      var_5 = min(var_0, 75);
      break;
    case "_encstr_850707F7E5833355B8":
      var_5 = min(var_0, 130);
      break;
    default:
      var_5 = var_0;
      break;
  }

  return var_0;
}

binoculars_onstateupdatefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0.attackerdata))
    var_0.attackerdata = [];

  if(!isDefined(var_1.guid) && (isagent(var_1) || isPlayer(var_1)))
    var_1.guid = var_1 scripts\mp\utility\player::getuniqueid();

  if(!isDefined(var_1.guid)) {
    return;
  }
  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hitcount = 1;
  } else
    var_0.attackerdata[var_1.guid].hitcount++;

  if(scripts\mp\utility\weapon::iscacprimaryweapon(var_3) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_3))
    var_0.attackerdata[var_1.guid].diddamagewithprimary = 1;

  if(isDefined(var_9) && var_9 != "_encstr_8DED0A21C79B660BC7588981")
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;

  var_10 = scripts\mp\utility\weapon::getequipmenttype(var_3.basename);

  if(isDefined(var_10)) {
    if(var_10 == "_encstr_B116071BCAD186858D")
      var_0.attackerdata[var_1.guid].diddamagewithlethalequipment = 1;

    if(var_10 == "_encstr_99C209E34FC743616118AB")
      var_0.attackerdata[var_1.guid].diddamagewithtacticalequipment = 1;
  }

  var_0.attackerdata[var_1.guid].damage = var_0.attackerdata[var_1.guid].damage + var_4;
  var_0.attackerdata[var_1.guid].weapon = createheadicon(var_3);
  var_0.attackerdata[var_1.guid].objweapon = var_3;
  var_0.attackerdata[var_1.guid].vpoint = var_5;
  var_0.attackerdata[var_1.guid].vdir = var_6;
  var_0.attackerdata[var_1.guid].shitloc = var_7;
  var_0.attackerdata[var_1.guid].psoffsettime = var_8;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
  var_0.attackerdata[var_1.guid].attackerent = var_1;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon))
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
  else if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon()))
    var_0.attackerdata[var_1.guid].sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
  else
    var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

is_flashbang(var_0, var_1, var_2) {
  if(isDefined(var_1.underbarrel)) {
    var_3 = scripts\mp\utility\weapon::attachmentmap_tobase(var_1.underbarrel);

    if(var_3 == "_encstr_873708FFA8104C0AAEC1" || var_3 == "_encstr_ADBD0780C4884FEE86")
      return 1;
  }

  return var_0 == "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683";
}

is_gas(var_0) {
  return var_0 == "_encstr_B8D30758E3EE7827BA";
}

deactivateagent() {
  if(scripts\mp\utility\entity::isgameparticipant(self))
    removefromparticipantsarray();

  removefromcharactersarray();
  self.isactive = 0;
  self.hasdied = 0;
  self.marked_by_hybrid = undefined;
  self.mortartarget = undefined;
  self.owner = undefined;
  self.connecttime = undefined;
  self.waitingtodeactivate = undefined;
  self.is_burning = undefined;
  self.is_electrified = undefined;
  self.stun_hit = undefined;
  self.targetname = undefined;
  self.script_noteworthy = undefined;
  self.script_linkname = undefined;
  self.script_linkto = undefined;
  self.target = undefined;
  self.mutations = undefined;

  foreach(var_1 in level.characters) {
    if(isDefined(var_1.attackers)) {
      foreach(var_4, var_3 in var_1.attackers) {
        if(var_3 == self)
          var_1.attackers[var_4] = undefined;
      }
    }
  }

  if(isDefined(self.headmodel))
    self.headmodel = undefined;

  scripts\mp\mp_agent::deactivateagent();
  self notify("_encstr_8D820B49520F0EC02DDE6367EC");
}

removefromparticipantsarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      for(var_0 = 1; var_1 < level.participants.size - 1; var_1++)
        level.participants[var_1] = level.participants[var_1 + 1];

      level.participants[var_1] = undefined;
      break;
    }
  }
}

removefromcharactersarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      for(var_0 = 1; var_1 < level.characters.size - 1; var_1++)
        level.characters[var_1] = level.characters[var_1 + 1];

      level.characters[var_1] = undefined;
      break;
    }
  }
}

handle_death_sounds(var_0, var_1, var_2) {
  if(!scripts\engine\utility::isbulletdamage(var_2)) {
    return;
  }
  if(isDefined(var_1.deathsound) && soundexists(var_1.deathsound))
    playsoundatpos(var_1.origin, var_1.deathsound);

  var_3 = var_1;

  if(var_2 == "_encstr_87280E1FB705D168313D1FD197B1A799") {
    var_3 playsoundtoplayer("_encstr_8C69178993738990ABEF7B7BE8D6984D17DAE1116AD73388C3", var_0);
    var_3 playsoundtoteam("_encstr_8DB01B26BAC68DACD1EB2DB683B0D81DEBD095858CDC43F63AD7CDE036", var_0.team, var_0);
  } else {
    var_3 playsoundtoplayer("_encstr_8C6C0E55704FEF130843A03F39E9234B", var_0);
    var_3 playsoundtoteam("_encstr_AA1917D607EB432DE8F5161B5993E8FACCB49BC263F5DCE0B1", var_0.team, var_0);
  }
}

process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = isDefined(var_1) && isDefined(var_1.classname) && isDefined(var_1.classname) && !isDefined(var_1.gunner) && (var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" || var_1.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
  var_14 = undefined;

  if(!isDefined(var_11))
    var_11 = 0;

  if(!isDefined(var_12))
    var_12 = 0;

  if(var_13 && isDefined(var_1.gunner))
    var_14 = var_1.gunner;
  else if(isDefined(var_1) && isDefined(var_1.owner))
    var_14 = var_1.owner;
  else
    var_14 = var_1;

  var_15 = scripts\engine\utility::isbulletdamage(var_4);
  var_16 = scripts\engine\utility::ter_op(var_15 && scripts\mp\utility\weapon::isprimaryweapon(var_5), "_encstr_A9950FF76456783587DB7983E3137DC8AF", "_encstr_A5AE098ADB583E0AF7A5AB");
  var_17 = 0;

  if(isDefined(var_1) && isDefined(var_1.class) && var_1.class == "_encstr_8CFF09D56D88EC030D69EB") {
    if(isDefined(var_4) && scripts\engine\utility::isbulletdamage(var_4))
      var_17 = 1;
  }

  if(isDefined(var_14) && var_14 != var_10 && var_2 + var_11 + var_12 > 0 && (!isDefined(var_8) || var_8 != "_encstr_A32D07CFD14BAA94D0")) {
    var_18 = !isalive(var_10) || isagent(var_10) && var_2 >= var_10.health;

    if(self.asm.archetype == "_encstr_87E80E37DE63915AB2E4BED8EEF59893")
      var_18 = !isalive(var_10);

    if(istrue(self._id_14693))
      var_18 = !isalive(var_10);

    if(istrue(var_10.isjuggernaut))
      var_16 = "_encstr_9A1B0E432D3A9AEA76B35939DC855DA3";
    else if(var_10 scripts\mp\heavyarmor::hasheavyarmor() || var_10 scripts\mp\heavyarmor::hasheavyarmorinvulnerability() || scripts\mp\damage::_encstr_81F016C3636EFE4F5E5299D7FD65B2B2B451037058081FA3(var_1))
      var_16 = "_encstr_A5D20E0DD2E8C2C9D6F627D09516675E";
    else if(var_3 &level.idflags_stun)
      var_16 = "_encstr_9B1905D3B92BF0";
    else if(scripts\mp\utility\damage::istacticaldamage(var_5, var_4) && var_10 _hasperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA") && !var_10 _hasperk("_encstr_BD0612A92DDD4809EBA3C64B5BC73001B58F350B"))
      var_16 = "_encstr_8D760DB8F77343CF62BEB7E3D01013";
    else if(isexplosivedamagemod(var_4) && var_10 _hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_1, var_10, var_5, var_4, var_0, var_8))
      var_16 = "_encstr_A3450F0B299309911663F8F8EA2C4B8D0B";
    else if(scripts\mp\utility\damage::hashealthshield(var_10))
      var_16 = "_encstr_A7CA0E78BC497703A3606DD843979453";
    else if(scripts\mp\damage::armorvest_wasbroke(var_1))
      var_16 = "_encstr_A24E13F383755A3A28D0AA3508207843C60D4F4F6F";
    else if(scripts\mp\damage::helmet_wasbroke(var_1))
      var_16 = "_encstr_815B14691FFB8BE8A4957953FD99C03353ABD58BD7D2";
    else if(scripts\mp\damage::armorvest_washit(var_1))
      var_16 = "_encstr_A7CA0E78BC497703A3606DD843979453";
    else if(scripts\mp\damage::helmet_washit(var_1))
      var_16 = "_encstr_8CFE0FD86310AC2F89689A9350536FE4A8";
    else if(var_11 > 0)
      var_16 = "_encstr_A7CA0E78BC497703A3606DD843979453";
    else if(var_10 _hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743") && isDefined(var_10.inlaststand) && var_10.inlaststand == 1 && !var_10.hasshownlaststandicon) {
      var_10.hasshownlaststandicon = 1;
      var_16 = "_encstr_BEF30DDC48FB9D412091E803212033";
    }

    if(isDefined(var_10.playerforcespawn) && var_10.playerforcespawn.size > 1)
      var_16 = "_encstr_97B50E2F204EDAFA69036611FE338296";

    var_19 = "_encstr_A5AE098ADB583E0AF7A5AB";

    if(var_16 == "_encstr_A24E13F383755A3A28D0AA3508207843C60D4F4F6F") {
      if(var_19 == "_encstr_A9950FF76456783587DB7983E3137DC8AF")
        var_19 = "_encstr_879414B9A3C2B991C2938C6EE02795C2322C27ADB7C9";
      else
        var_19 = "_encstr_814B0EC3B18F08B59AB390C120D0B25E";
    }

    var_20 = weaponclass(var_5);
    var_21 = var_20 == "_encstr_A1100738A33A638123";
    var_22 = !var_21 && scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1);
    var_23 = 1;
    var_24 = var_4 == "_encstr_8DED0A21C79B660BC7588981";
    var_25 = "_encstr_B40101" + gettime();

    if(!var_24 && var_21 && isDefined(var_14.pelletdmg) && isDefined(var_14.pelletdmg[var_25]) && isDefined(var_14.pelletdmg[var_25][var_10.guid]) && var_14.pelletdmg[var_25][var_10.guid] > 1) {
      if(var_18)
        var_24 = 1;
      else
        var_23 = 0;
    }

    var_26 = undefined;

    if(var_10.health <= var_2)
      var_26 = 1;

    if(self.asm.archetype == "_encstr_87E80E37DE63915AB2E4BED8EEF59893")
      var_26 = var_10.health <= 0;

    if(istrue(self._id_14693))
      var_26 = var_10.health <= 0;

    var_22 = scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1);

    if(var_23) {
      if(isDefined(var_1)) {
        if(isDefined(var_1.owner))
          var_1.owner thread scripts\mp\damagefeedback::updatedamagefeedback(var_16, var_26, var_22, var_19);
        else
          var_1 thread scripts\mp\damagefeedback::updatedamagefeedback(var_16, var_26, var_22, var_19);
      }
    }
  }
}

_hasperk(var_0) {
  var_1 = self.perks;

  if(!isDefined(var_1))
    return 0;

  if(isDefined(var_1[var_0]))
    return 1;

  return 0;
}

_id_132EB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_12.basename;
  var_14 = 0;

  if(isDefined(var_0) && (issubstr(var_13, "_encstr_8D7609A4F337C2C9C2BDB7") || isDefined(var_12.magazine) && issubstr(var_12.magazine, "_encstr_B47E094630B8ACB27B2D57") || isDefined(var_0.weapon_name) && issubstr(var_0.weapon_name, "_encstr_AD360B5ACD7E474DF83389820B"))) {
    var_14 = 1;
    var_15 = var_8 == "_encstr_A32D07CFD14BAA94D0";

    if(var_15) {
      var_16 = scripts\engine\trace::create_character_contents();
      var_17 = vectorNormalize(var_7);
      var_18 = var_6 - var_17 * 12;
      var_19 = var_6 + var_17 * 12;
      var_20 = scripts\engine\trace::ray_trace_detail(var_18, var_19, undefined, var_16);

      if(var_20["_encstr_A53009A25003666B9818C6"] > 0 && var_20["_encstr_A53009A25003666B9818C6"] < 1) {
        var_21 = var_6 - self.origin;
        var_21 = (var_21[0], var_21[1], 0);

        if(vectordot(var_21, var_20["_encstr_820E07FAE8780B3A4C"]) < 0)
          var_15 = 0;
      } else
        var_15 = 0;
    }

    if(var_15) {
      var_22 = var_0 getlinkedparent();

      if(isDefined(var_22) && var_22 == self) {
        self.clearspaceforscriptableinstance = 1;
        self._id_13B2A = 0;
      }
    } else if(var_8 != "_encstr_8BBA05185F8B99") {
      self.clearspaceforscriptableinstance = undefined;
      self._id_13B2A = undefined;
    }
  }

  if(var_8 == "_encstr_A32D07CFD14BAA94D0") {
    if(var_14)
      return 1;
  } else if(var_8 == "_encstr_8BBA05185F8B99" && isDefined(var_0)) {
    var_23 = var_0 getlinkedparent();

    if(istrue(self.clearspaceforscriptableinstance) && var_14 && isDefined(var_23) && var_23 == self) {
      if(!isDefined(self._id_13B2C))
        self._id_13B2C = [var_0];
      else if(!scripts\engine\utility::array_contains(self._id_13B2C, var_0))
        self._id_13B2C[self._id_13B2C.size] = var_0;

      self._id_13B2A++;
      return 1;
    } else if(issubstr(var_13, "_encstr_8DCB085BEF657B4DCF0B")) {
      var_24 = var_0.origin - self.origin;
      var_25 = vectorNormalize((var_24[0], var_24[1], 0));
      var_24 = vectorNormalize(var_24);

      if(vectordot(anglesToForward(self.angles), var_25) > 0.5 && -0.98 < var_24[2] && var_24[2] < 0.98)
        return 1;
    }
  }

  if(var_4 == "_encstr_8DED0A21C79B660BC7588981") {
    if(isDefined(var_1))
      var_26 = vectorNormalize(var_1.origin - self.origin);
    else
      var_26 = vectorNormalize(var_6 - self.origin);

    var_27 = anglesToForward(self.angles);

    if(vectordot(var_27, var_26) > 0.5)
      return 1;
  }

  return 0;
}