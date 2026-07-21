/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_lootcratedrop.gsc
*********************************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_11B78 = getdvarint("_encstr_A94A22371B9CAF8993AFE0567DE0C6573719ACE4EB1B930B472BBEB52C0FD73A4BDACACD", 2);
  var_0.isfeaturedisabled = ::deactivate;
  var_0._id_140CF = ::_id_140D1;
  var_0.attackerswaittime = ::atv_initdamage;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_952515A2B723D089E0A2834BD9ABB35B9F4247EDAB2BBD;
  var_0.weight = getdvarfloat("_encstr_96491FF7716EFE25330E4A351F63011BB3E49DEE1F6F40A7BB15C9ECB5186F0873", 0);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_B6560EE0D315909102D2E88EAA3AC9B9", "_encstr_A675284650E2612922277A829F9AE1A97EF8C7F7D88A19714E5E728AB7B299F1D6055F7FA172D1B95247");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_B6560EE0D315909102D2E88EAA3AC9B9");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(12, var_0);
  var_0 = spawnStruct();
  var_0._id_11B78 = getdvarint("_encstr_A2AF216E1BE4FA894EF51CACEBDD590B07B79BBE6CC916D1B2F5B6583CBEE8A5B5AC6E", 2);
  var_0.isfeaturedisabled = ::deactivate;
  var_0.attackerswaittime = ::aud_breached_exit_wind;
  var_0._id_140CF = ::_id_140D8;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8CC814B8A00FFB04D8BC6CB7DA6B50073BBE60B7CBD1;
  var_0.weight = getdvarfloat("_encstr_8D0E1E8BB66E8102526FE39027BBDFEBF8B07331C062670543C997658C31ABB8", 0);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_8FCA0DBB95C207F6DCBE36932CA359", "_encstr_9BA728F2A24059194703572F7A2F6111393AEADA4A98A1D17E6E5F275207A9C981467252FA20E9898733");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_8FCA0DBB95C207F6DCBE36932CA359");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(13, var_0);
  var_0 = spawnStruct();
  var_0._id_11B78 = getdvarint("_encstr_858322CD1B9CEB26C97D0EB2AFB559195AB158B1EB36E4C2A356F56B0BC3D7472D6B95CD", 2);
  var_0.isfeaturedisabled = ::deactivate;
  var_0._id_140CF = ::_encstr_836F15636FA0E8319F4BABB2A59129C0BEB25E121B94BF;
  var_0.attackerswaittime = ::_encstr_AD6415C10E73929BC1B84513A391ECCEEBB0DE5A733020;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_ACFD157B7B9F6BD7A0D31435FDC99FF6E37032D3E839E7;
  var_0.weight = getdvarfloat("_encstr_92B31F6A264B0969CE2F3333195308C22D68FE7C863B8B6311E707C34570C0B310", 0);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_B2AD0EADE3C1932783ABA66E30DB3448", "_encstr_9BA728F2A24059194703572F7A2F6111393AEADA4A98A1D17E6E5F275207A9C981467252FA20E9898733");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_B2AD0EADE3C1932783ABA66E30DB3448");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(20, var_0);
}

_encstr_952515A2B723D089E0A2834BD9ABB35B9F4247EDAB2BBD() {
  _encstr_8BC10D10BFF87BCF58583BE223A02F();
}

_encstr_8CC814B8A00FFB04D8BC6CB7DA6B50073BBE60B7CBD1() {
  _encstr_8BC10D10BFF87BCF58583BE223A02F();
}

_encstr_ACFD157B7B9F6BD7A0D31435FDC99FF6E37032D3E839E7() {
  _encstr_8BC10D10BFF87BCF58583BE223A02F();
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  if(isDefined(level._encstr_8EAD12E157ED909EE33293B90BBF4E4884BE1359)) {
    return;
  }
  level._encstr_8EAD12E157ED909EE33293B90BBF4E4884BE1359 = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87DF0A3616CDA1D7C89CED1C"] = "_encstr_97D311E350B1FDBE17A04BE1A394CADF923F31";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA1F0CFB892850EA20AF9BCB27D7"] = "_encstr_A6300EC8CB35111E3365BEB568E3A0CB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82F40D222FF1DA7F01258E64D8B03A"] = "_encstr_95E215ADCA235AC658D8AF0BE6E6BD5DDC3656B52B373A";
  level.conf_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");

  if(istrue(level._id_1406F)) {
    level._id_11A1F = level.minigun_warning_time;
    level._id_1395A = [];
  }
}

_id_140D1() {
  var_0 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::resetarenaomnvardata();
  return var_0 >= 1;
}

_id_140D8() {
  return 1;
}

_encstr_836F15636FA0E8319F4BABB2A59129C0BEB25E121B94BF() {
  return 1;
}

atv_initdamage() {
  attackpressed(3);
}

aud_breached_exit_wind() {
  attackpressed(1);
}

_encstr_AD6415C10E73929BC1B84513A391ECCEEBB0DE5A733020() {
  attackpressed(2);
}

attackpressed(var_0) {
  level._encstr_ABB31C8927FAE056AF1B93B03A95FAD59B561D96B5AC7BD9B227C996C8AC = getdvarfloat("_encstr_A39319F79F72E9326BCFC82117B140D25408BF0BEEF84783F4BA7F", 5);
  var_1 = spawnStruct();

  switch (var_0) {
    case 1:
      if(!isDefined(level.shutdownattractionicontrigger))
        level thread _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::init();

      var_1.delayeddetachbreak = "_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC";
      var_1.delaydropbags = "_encstr_8C2414DAF1EFBB38919F1DE169E805D78F6BF222D8B6";
      var_1.delayed_depositing = "_encstr_A79511C1CAFAC686EDE0072B39FAB1E4853A95";
      var_1.delayedattach = "_encstr_A3BD0E23776F2803CA83A99B9391D808";
      var_1.delayeddetach = "_encstr_836119959BA16F703FBBC15962E7E0309A730B317F09B68059D2EB";
      var_1.delaydestroyhudelem = "_encstr_BA1F0CFB892850EA20AF9BCB27D7";
      level.delete_ai = 1;
      break;
    case 2:
      if(!isDefined(level._encstr_84870FAFD32582730B88292EA3E8AC9A06))
        level thread _encstr_86252F63EE5BD1037B9032D850808A4F614F53F7470393A82283E93095B23B8787C997478210444F91820B708BF2544A37::init();

      var_1.delayeddetachbreak = "_encstr_B2AD0EADE3C1932783ABA66E30DB3448";
      var_1.delaydropbags = "_encstr_97731188B2FF3B81779450BE65DB2BE9641AC0";
      var_1.delayed_depositing = "_encstr_A79511C1CAFAC686EDE0072B39FAB1E4853A95";
      var_1.delayedattach = "_encstr_A3BD0E23776F2803CA83A99B9391D808";
      var_1.delayeddetach = "_encstr_95F11A120D9958D7019D8D3CC046A2E4A9470A4FCB31118333D90AC0";
      var_1.delaydestroyhudelem = "_encstr_82F40D222FF1DA7F01258E64D8B03A";
      level.delete_ai = 0;
      level._encstr_ABB31C8927FAE056AF1B93B03A95FAD59B561D96B5AC7BD9B227C996C8AC = _encstr_86252F63EE5BD1037B9032D850808A4F614F53F7470393A82283E93095B23B8787C997478210444F91820B708BF2544A37::_encstr_85A81360514BCF522ACB4F4BF287E5E3723BAFCBB7();
      break;
    case 3:
      level.delayed_explosion_things = getdvarint("_encstr_8E121D6B32CB50E86AAF092B87D5B8073B6A23F32A93F0B0C9692B07B53D28", 15000);
      level thread _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::init();
      level thread scripts\cp_mp\killstreaks\airdrop::teamplunderexfil();
      var_1.delayeddetachbreak = "_encstr_992A1BB5F7334D18E551C378C0C9D00D39573927CB1B9DD007756870AB";
      var_1.delaydropbags = "_encstr_930B07BB1B6B3854FF";
      var_1.delayed_depositing = "_encstr_8685168D0BDC34234EBD0EFAB1DBB6D67B9BD7EEDBE43619";
      var_1.delayedattach = "_encstr_AB0703DBB9";
      var_1.delayeddetach = "_encstr_837817820519FA7F4099EA330DB8AFB230A13D379F28C67BFD";
      var_1.delaydestroyhudelem = "_encstr_87DF0A3616CDA1D7C89CED1C";
      level.delete_ai = 0;
      break;
  }

  var_2 = scripts\cp_mp\killstreaks\airdrop::getleveldata(var_1.delayeddetachbreak);
  var_2.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_2.minimapicon = undefined;

  if(isDefined(var_2._encstr_850C166F3B1205A0B49C0379848B88C8FAC3E3DD83CA5DA8))
    var_1.delaydropbags = var_2._encstr_850C166F3B1205A0B49C0379848B88C8FAC3E3DD83CA5DA8;

  if(!istrue(var_2._encstr_930D0EB71B57A2DA30E80713B8C9837A))
    _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371(var_1.delayeddetach);

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog(var_1.delaydestroyhudelem, 1);
  var_3 = scripts\mp\utility\teams::resetchallengetimer();
  var_4 = getdvarint("_encstr_A17F28AB2FD31F3135098B42C718C8AE0430578BF1169828316AAFAD21E726807E8B3ABD48CB5E936AA2", 3);

  if(var_0 == 2)
    var_5 = getdvarint("_encstr_82FD2023792E6786B097405DFF200FF3DB119A5A21866FFA01CB412EDFE0D67B758B", 5);
  else
    var_5 = getdvarint("_encstr_AB0A20DC8D9C7D4C39F5C1B2BE637B8519B7AB478C93DE38FAD6B43734E4B0D156DC", 10);

  var_6 = int(max(var_5, var_3 / var_4));
  var_7 = [];
  var_8 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_9 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

  for(var_10 = 0; var_10 < var_6; var_10++) {
    if(istrue(level._id_1406F)) {
      var_7[var_7.size] = return_same_module_as_next_module(var_8, var_9);
      continue;
    }

    var_7[var_7.size] = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_8, var_9, 0.1, 0.9, 1);
  }

  level.delete_covernodes = [];

  foreach(var_12 in var_7) {
    if(isDefined(var_12)) {
      var_13 = undefined;
      var_14 = undefined;
      var_15 = var_1.delayeddetachbreak;
      var_16 = (var_12[0], var_12[1], var_12[2] + 10000);
      var_17 = (0, randomfloat(360), 0);
      var_18 = var_12;
      var_19 = scripts\cp_mp\killstreaks\airdrop::dropcrate(var_13, var_14, var_15, var_16, var_17, var_18);

      if(!isDefined(var_19)) {
        continue;
      }
      if(!istrue(var_2._encstr_A98414E0521A0B8163BD6EDE912BA9D982DAB8F83A70)) {
        var_19 setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 0);
        var_19._id_13428 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_16 + (0, 0, 58));
        var_19._id_13428 setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
        var_19._id_13428 linkTo(var_19);
        var_19._id_13428 setscriptablepartstate("_encstr_A27B0C1A71177AB53E782B6FB870", "_encstr_AB0703DBB9");
      }

      if(isDefined(var_1.delaydropbags))
        var_19 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", var_1.delaydropbags);

      if(isDefined(var_1.delayed_depositing))
        var_19 setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", var_1.delayed_depositing);

      var_20 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_19);
      var_20._id_140A0 = level._encstr_ABB31C8927FAE056AF1B93B03A95FAD59B561D96B5AC7BD9B227C996C8AC;
      level.delete_covernodes[level.delete_covernodes.size] = var_19;
    }
  }
}

deactivate() {
  foreach(var_1 in level.delete_covernodes) {
    if(!isDefined(var_1)) {
      continue;
    }
    playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], var_1.origin);

    if(isDefined(var_1._id_13428)) {
      var_1._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
      var_1._id_13428 delete();
    }

    var_1 scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
    level.delete_covernodes = scripts\engine\utility::array_remove(level.delete_covernodes, var_1);
  }
}

return_same_module_as_next_module(var_0, var_1) {
  var_2 = undefined;
  var_3 = [];

  foreach(var_5 in level._id_11A1F) {
    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_5.origin))
      var_3 = scripts\engine\utility::array_add(var_3, var_5);
  }

  level._id_11A1F = var_3;
  var_7 = freight_lift_dogtag_revive(level._id_11A1F);

  for(var_8 = 5; var_8 >= 0; var_8--) {
    var_9 = randomfloat(var_7);
    var_10 = play_scramble_for_player_until_cleared(level._id_11A1F, var_9);

    if(isDefined(var_10)) {
      var_11 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_10.origin, var_10.radius, 0.1, 0.85, 1, 1);

      if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_11))
        var_11 = riskspawn_flagcaptured(var_0, var_10.origin, var_10.radius);

      if(!istrue(update_objective_mlgicon(var_11)))
        var_2 = var_11;

      if(var_8 == 0)
        var_2 = var_11;

      if(isDefined(var_2)) {
        break;
      }
    }
  }

  if(!isDefined(var_2))
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_0, var_1, 0.1, 0.85, 1, 1);

  level._id_1395A[level._id_1395A.size] = var_2;
  return var_2;
}

update_objective_mlgicon(var_0) {
  var_1 = getdvarint("_encstr_8B011D9BC6ED71ED1B492A1DE9488AC75569FBE94B4ACFB19F6318843A0858", 2500);
  var_2 = var_1 * var_1;

  foreach(var_4 in level._id_1395A) {
    if(distance2dsquared(var_0, var_4) < var_2)
      return 1;
  }

  return 0;
}

freight_lift_dogtag_revive(var_0) {
  var_1 = 0.0;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3.radius;

  return var_1;
}

play_scramble_for_player_until_cleared(var_0, var_1) {
  var_2 = 0.0;

  foreach(var_4 in var_0) {
    var_2 = var_2 + var_4.radius;

    if(var_1 <= var_2)
      return var_4;
  }

  return undefined;
}

riskspawn_flagcaptured(var_0, var_1, var_2) {
  var_3 = init_silo_platforms(var_0, var_1, var_2);
  var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_3.origin, var_3.radius, 0, 0.85, 1, 1);
  return var_4;
}

init_silo_platforms(var_0, var_1, var_2) {
  var_3 = distance2d(var_0, var_1);
  var_4 = int(var_2 / 2);

  if(var_3 != 0.0) {
    var_5 = int(var_1[0] - var_4 / var_3 * (var_1[0] - var_0[0]));
    var_6 = int(var_1[1] - var_4 / var_3 * (var_1[1] - var_0[1]));
  } else {
    var_5 = int(var_0[0]);
    var_6 = int(var_0[1]);
  }

  var_7 = 0;
  var_8 = spawnStruct();
  var_8.origin = (var_5, var_6, var_7);
  var_8.radius = var_4;
  return var_8;
}