/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_analytics.gsc
***********************************************/

destroycrateinbadtrigger() {
  level._id_11B22 = ::_id_1205B;
  level._encstr_BA3A1A5DFBA9FD5D6F65B08429A1986AC329FB3323C8FB92A897151B = ::branalytics_revive;

  if(getdvarint("_encstr_9BF30B8BC17CE9895FEFDD04F6", 0)) {
    level.kothtotaltime = [];
    analyticsaddevent();
  }
}

add_outline() {
  return isDefined(level.kothtotaltime);
}

add_pack_characteranim() {
  var_0 = gettime();

  if(!isDefined(level._id_12855))
    var_0 = 0;
  else
    var_0 = var_0 - level._id_12855;

  return var_0;
}

add_object_to_trap_room_ents(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = "_encstr_B40101";

  var_4 = add_pack_characteranim();
  analyticswritecsv(var_1, var_0, var_2, var_4, var_3);
}

ai_roof_think(var_0) {
  if(!isDefined(var_0))
    return -1;

  switch (var_0) {
    case "_encstr_9AD91946CA2C3AD02A9707ACFA6E77B43A1B0D5AE69D15B22C6B6E":
      var_1 = 6;
      break;
    case "_encstr_833C15DF7F8F5B63F143392D0FAFBA369884FFEA61CC19":
      var_1 = 3;
      break;
    case "_encstr_B8BB12B16ABF0D703B51C1D34FDA505B6F424919":
      var_1 = 5;
      break;
    case "_encstr_8346176F85ABDBD39FE3B2B009A62AE7F823785C311DE335C2":
      var_1 = 4;
      break;
    case "_encstr_8E96168C23E0F353DDD2035AFEAB932548B7142369983D2B":
      var_1 = 2;
      break;
    case "_encstr_B82D118DE7AA51B8E44F20B0EFE69095B20E71":
      var_1 = 1;
      break;
    case "_encstr_8FAE0723DEEECDCA19":
      var_1 = 0;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

add_pack_camanim(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = "_encstr_B40101";

  if(!isDefined(level.kothtotaltime[var_0]))
    level.kothtotaltime[var_0] = [];

  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4.origin = var_1;
  var_4.ent = var_2;
  var_4.data = var_3;
  var_4.state = 0;
  var_4.time = add_pack_characteranim();
  var_5 = level.kothtotaltime[var_0].size;
  level.kothtotaltime[var_0][var_5] = var_4;
}

dialog_grenade_update(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(level.kothtotaltime) || !isDefined(level.kothtotaltime[var_0])) {
    return;
  }
  foreach(var_4 in level.kothtotaltime[var_0]) {
    if(var_4.ent == var_1) {
      var_4.time = add_pack_characteranim();
      var_4.state = var_2;
      return;
    }
  }
}

dialog_monitor_shieldraise() {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    return 0;

  return 1;
}

branalytics_equipmentuse(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = var_1.basename;
  var_3 = _branalytics_header(var_0);
  var_3[var_3.size] = "_encstr_8A5A0AA8237DA5218DFF9320";
  var_3[var_3.size] = var_2;
  var_0 dlog_recordplayerevent("_encstr_B88C1CF9B2CFDC913F16938D3CE9201E675AD3434A0B0188150CDFA3434F", var_3);
}

dialog_monitor_hurry(var_0) {
  if(!isDefined(var_0))
    return 1;

  switch (var_0) {
    case "_encstr_85FE0DD5727A27098513298817CA23":
    case "_encstr_BD4E0B7B104D6AD4DB384717A0":
    case "_encstr_97710C6B2DCD1BAF3AD54E4E598E":
    case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
    case "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56":
    case "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B":
    case "_encstr_956B0F193B6244C0659AE65B464C78857B":
      return 1;
    default:
      break;
  }

  return 0;
}

branalytics_down(var_0, var_1, var_2, var_3, var_4) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(isDefined(var_0.classname) && var_0.classname == "_encstr_AA15062C769537A3") {
    return;
  }
  var_5 = dialog_monitor_hurry(var_0.classname);

  if(!var_5 && !isPlayer(var_0)) {
    var_6 = "_encstr_AA491561C5737F2E27C0C33EC811E67FCBA0E915D512C2" + var_0.classname;
    scripts\mp\utility\script::laststand_dogtags(var_6);
  }

  if(var_5) {
    var_7 = "_encstr_8D5E0677ED9C368C";
    var_0 = var_1;
  } else if(isDefined(var_2))
    var_7 = var_2.basename;
  else {
    var_8 = var_0 getcurrentweapon();
    var_7 = var_8.basename;
  }

  var_9 = var_1 getcurrentweapon();
  var_10 = var_9.basename;
  var_11 = [];
  var_11[var_11.size] = "_encstr_8AB40733883B0C03AD";
  var_11[var_11.size] = var_1;
  var_12 = _branalytics_header(var_0, "_encstr_AA7B09475984AF0F6F0F0B");

  foreach(var_14 in var_12)
  var_11[var_11.size] = var_14;

  var_11[var_11.size] = "_encstr_9BB6101F8D831BF25C4BCB41A7729190ADDB";
  var_11[var_11.size] = var_7;
  var_16 = var_0 calloutmarkerping_entityzoffset("_encstr_A7AE16D39FC90ED0179519103F13D833F3370F136BA245C8");

  if(!isDefined(var_16))
    var_17 = "_encstr_8BBA05185F8B99";
  else
    var_17 = tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 0, var_16, 1);

  var_11[var_11.size] = "_encstr_86891885A31DB01B6D954EFAB0D83A96B359D7DA5AE6B95AB7CD";
  var_11[var_11.size] = var_17;
  var_18 = add_pack_fx([], var_1, "_encstr_8AB40733883B0C03AD");

  foreach(var_14 in var_18)
  var_11[var_11.size] = var_14;

  var_11[var_11.size] = "_encstr_AB8B0E2368F69B1438E7170DB3F85D2B";
  var_11[var_11.size] = var_10;
  var_16 = var_1 calloutmarkerping_entityzoffset("_encstr_A7AE16D39FC90ED0179519103F13D833F3370F136BA245C8");

  if(!isDefined(var_16))
    var_17 = "_encstr_8BBA05087F0B9D";
  else
    var_17 = tablelookup("_encstr_B468129A5318AD6BD8338F9B6A9F73E01059A86B", 0, var_16, 1);

  var_11[var_11.size] = "_encstr_935E16B35A361D2D5BFAB06C8E5AD9CA7DB6B49BDC5A7BDC";
  var_11[var_11.size] = var_17;
  var_11[var_11.size] = "_encstr_BA990B21FDD83470C7782803B7";
  var_11[var_11.size] = var_3;
  var_11[var_11.size] = "_encstr_993E0FDA20CB9DCF164096B7ED794FA361";
  var_11[var_11.size] = var_4;
  var_21 = scripts\mp\utility\teams::getfriendlyplayers(var_1.team, 1);
  var_22 = 2147483647;

  foreach(var_24 in var_21) {
    if(var_24 == var_1) {
      continue;
    }
    var_25 = distance(var_1.origin, var_24.origin);

    if(var_25 < var_22 || var_22 == 2147483647)
      var_22 = var_25;
  }

  var_11[var_11.size] = "_encstr_A6C3210B93BFCA87BF3D5063226EC8C9F9A0533F29F85A97051F171C2A6F4D6AB00E0D";
  var_11[var_11.size] = int(var_22);
  var_0 dlog_recordplayerevent("_encstr_BDD7139163BD3BBE95B395E6D1FA4CC9BE8CBDDDE6", var_11);

  if(add_outline())
    add_object_to_trap_room_ents("_encstr_9767056D0FBFA8", var_1.origin, ai_roof_think(var_3), var_7);
}

branalytics_revive(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "_encstr_B8420876172B9B8B25AF";
  var_2[var_2.size] = var_1;
  var_3 = _branalytics_header(var_0, "_encstr_B442086D6763FB3D4F0A");

  foreach(var_5 in var_3)
  var_2[var_2.size] = var_5;

  var_7 = add_pack_fx([], var_1, "_encstr_B8420876172B9B8B25AF");

  foreach(var_5 in var_7)
  var_2[var_2.size] = var_5;

  var_0 dlog_recordplayerevent("_encstr_95741519522F3C71DFF6B3AD1C89407E470BB1C36A3365", var_2);

  if(add_outline())
    add_object_to_trap_room_ents("_encstr_9695073995D94BD959", var_1.origin);
}

dialog_grenade_missed(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = _branalytics_header(var_0, "_encstr_B8420876172B9B8B25AF");
  var_0 dlog_recordplayerevent("_encstr_B1D71932C6F69DAFAC672BDCD1F598E4EBDCCA1B334EAC67B4CE95", var_1);

  if(add_outline())
    add_object_to_trap_room_ents("_encstr_BAAE0B0FD38817C219C4F4F880", var_0.origin);
}

diablecachesaroundorigin(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_11 = [];
  var_11[var_11.size] = "_encstr_A95C121BB06E8EA6470B9B1914D1E82C36AD2B93";
  var_11[var_11.size] = var_1;
  var_11[var_11.size] = "_encstr_8AB40733883B0C03AD";
  var_11[var_11.size] = var_2;
  var_12 = _branalytics_header(var_0, "_encstr_B8420876172B9B8B25AF");

  foreach(var_14 in var_12)
  var_11[var_11.size] = var_14;

  var_16 = add_pack_fx([], var_1, "_encstr_A95C121BB06E8EE6470B9B1916D1E82C36AD2B93");

  foreach(var_14 in var_16)
  var_11[var_11.size] = var_14;

  var_19 = add_pack_fx([], var_2, "_encstr_8AB40733883B0C03AD");

  foreach(var_14 in var_19)
  var_11[var_11.size] = var_14;

  var_11[var_11.size] = "_encstr_AF060DD8AD54F09072FB9B9BDB3B4F";
  var_11[var_11.size] = var_7;
  var_11[var_11.size] = "_encstr_AB880CDBDC8D2FF58CF6DD375919";
  var_11[var_11.size] = var_8;
  var_11[var_11.size] = "_encstr_8A8C09A5D33255911F2BF3";
  var_11[var_11.size] = var_9;
  var_11[var_11.size] = "_encstr_A38B0F41A0304E520366E7305F17E52DF6";
  var_11[var_11.size] = var_10;

  if(!isDefined(var_3))
    var_3 = "_encstr_B40101";

  var_11[var_11.size] = "_encstr_993E0FDA20CB9DCF164096B7ED794FA361";
  var_11[var_11.size] = var_3;

  if(!isDefined(var_4))
    var_4 = "_encstr_B40101";

  var_11[var_11.size] = "_encstr_95CC0CEE56851CED9BF53716B659";
  var_11[var_11.size] = var_4;

  if(!isDefined(var_5))
    var_5 = "_encstr_B40101";

  var_11[var_11.size] = "_encstr_8EB0196AA04FBB6F1327FEECD0D8FF068DD8C1D220BFF74FE995F0";
  var_11[var_11.size] = var_5;

  if(!isDefined(var_6))
    var_6 = "_encstr_B40101";

  var_11[var_11.size] = "_encstr_AC8D16D9C173758BAB38163051032DF827BF43C76A3001BB";
  var_11[var_11.size] = var_6;
  var_0 dlog_recordplayerevent("_encstr_878719789A85AF8EFF06C548FCEFD14D61F3F8F8029DD1C3E7365D", var_11);

  if(add_outline())
    add_object_to_trap_room_ents("_encstr_B1AA0B7F40CE72B3BFB95F75B8", var_0.origin);
}

dialog_monitor_waitreload(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = [];
  var_3[var_3.size] = "_encstr_B2B408407AA0929139E9";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_85850B71AA374380B69C3307BE";
  var_3[var_3.size] = var_2;
  var_0 dlog_recordplayerevent("_encstr_AC5B1F1359C80A2758A33FC5DBB1326215A7D77F0DEF31D4E068F28193B8699A7D", var_3);
}

branalytics_deployallowed() {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_8BF01D3210AFB717C9643D3E7DD6BBBAA728AAEBB817E8DFA1410C2794B96B", []);
}

branalytics_deploytriggered(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("_encstr_823C1F216A171459C7EE5B55F4A178662F02992BD2BF5321DBC24B4F0F17A0A56B", var_1);
}

detachriotshield(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("_encstr_86141AD948725FB7602395C65B0911BDF15AEDC09288CAE9A10BDD71", var_1);

  if(add_outline())
    add_object_to_trap_room_ents("_encstr_AAAD0588994299", var_0.origin);
}

detonatedripfx(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(add_outline())
    add_object_to_trap_room_ents("_encstr_9B0C0CE01BC2E559C9A1F6BAB9A3", (0, 0, 0), 0, var_0);
}

determine_starting_breadcrumb(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = _branalytics_header(var_0);
  var_3[var_3.size] = "_encstr_B2310D943398AE674DEE4B0270958B";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_91480E91B06B0B3B957DB9DE57931B2B";
  var_3[var_3.size] = var_2;
  var_0 dlog_recordplayerevent("_encstr_9BAF2423B1DE76EBB267B2B9D1F583B1582F5693FA630BE4D92B23166B2CB3CAF5A3586DACB9", var_3);
}

branalytics_lootpickup(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = _branalytics_header(var_0);
  var_3[var_3.size] = "_encstr_8A5A0AA8237DA5218DFF9320";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_857E07856BDBAEE6D1";
  var_3[var_3.size] = var_2;
  var_0 dlog_recordplayerevent("_encstr_88281A79EC9730384F3BFD65798FA1EB99C3A03793278B67F8072352", var_3);
}

branalytics_lootdrop(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = istrue(var_2);
  var_4 = _branalytics_header(var_0);
  var_4[var_4.size] = "_encstr_8A5A0AA8237DA5218DFF9320";
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = "_encstr_B8CA1BB7F7A04A7A78F32177ABA0BD310C631F4BA750A1339038E33EC0";
  var_4[var_4.size] = var_2;
  var_4[var_4.size] = "_encstr_857E07856BDBAEE6D1";
  var_4[var_4.size] = var_3;
  var_0 dlog_recordplayerevent("_encstr_8D3A18BD957A476EE5A35818B30701A5C13DA0B0EB1119F3C753", var_4);
}

destroyawardlaunchonly(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = _branalytics_header(var_0);
  var_2[var_2.size] = "_encstr_81EF05D197C12B";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_B6E21A819C38B0F75DBB2563C197A9A0672AFD3C8148B0F3C5AF56F9", var_2);
}

destroyaward(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = _branalytics_header(var_0);
  var_2[var_2.size] = "_encstr_81EF05D197C12B";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_8D56180ABD2042911B1BED0DED8F46EB281F4F6009CFDE196891", var_2);

  if(add_outline()) {
    var_3 = 0;

    switch (var_1) {
      case "_encstr_A6EA07CF498568A5DB":
        var_3 = 1;
        break;
      case "_encstr_995408F398012F656821":
        var_3 = 2;
        break;
      case "_encstr_ABEF097343AB23ABD89446":
        var_3 = 3;
        break;
      case "_encstr_8E75065022EE9391":
        var_3 = 4;
        break;
      default:
        var_3 = 0;
        break;
    }

    add_object_to_trap_room_ents("_encstr_9B220634456A5747", (0, 0, 0), var_3);
  }
}

devspectatetesthost(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(add_outline())
    add_object_to_trap_room_ents("_encstr_A20A088EDD77B3031B2A", (0, 0, 0), var_1);
}

detonatesound(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(add_outline())
    add_object_to_trap_room_ents("_encstr_8FEB0F58E0ADCBE05DCD8B8DCAF34ADB98", var_0, var_1, var_2);
}

destpoint(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(add_outline())
    add_object_to_trap_room_ents("_encstr_8D820B49520F0EC02DDE6367EC", (0, 0, 0), var_1);
}

dialog_intro(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = _branalytics_header(var_0);
  var_3[var_3.size] = "_encstr_AB7E0E932B1763B3495FB4A939903D4B";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_8C4B0D3A71E3333170199974DB6885";
  var_3[var_3.size] = var_2;
  var_0 dlog_recordplayerevent("_encstr_AF591AC96C25C058678B491093B78E2071EB63BD1F0E8880CF334159", var_3);
}

destroy_vehicles(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = _branalytics_header(var_0);
  var_2[var_2.size] = "_encstr_82030B033318AB076042244590";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_917F252574A7F19F7F4B184803999D2B0FE6BC30C40B792329D22BF00A6D2F814780B3953EFF01", var_2);
}

destroy_vehicle_on_pilot_death(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("_encstr_8C5122321B7BCEBEAC3BACCD3ABEC439AF9933D79C4B23191BCAAFC6BDDA0ED8B28E9591", var_1);
}

destroy_vehicle_if_driver_dies(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = _branalytics_header(var_0);
  var_2[var_2.size] = "_encstr_B46E0A81A8B4CF03477BD518";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_9B9B24A419B81FB77D1B8A0263588B92E1E55E179308E7EF9111B3BA88B0BF8E3043D5A63B30", var_2);
}

destprogress(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_4 = _branalytics_header(var_0);
  var_4[var_4.size] = "_encstr_B8F50770738DB9B683";
  var_4[var_4.size] = var_1[0];
  var_4[var_4.size] = "_encstr_8EF5078582607851BB";
  var_4[var_4.size] = var_1[1];
  var_4[var_4.size] = "_encstr_91F5076C3EE8C3290D";
  var_4[var_4.size] = var_1[2];
  var_4[var_4.size] = "_encstr_AA520BC3AB70BFC879738BDBA7";
  var_4[var_4.size] = var_2;
  var_0 dlog_recordplayerevent("_encstr_B2F21F099DE7B020C2436B756349F640BFF7B3E0025248E4991353517B1243305C", var_4);

  if(add_outline())
    add_pack_camanim("_encstr_ADC60861729F70426AD3", var_1, var_3, 0);
}

destroy_intro_tank(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = _branalytics_header(var_0);
  var_3[var_3.size] = "_encstr_B8F50770738DB9B683";
  var_3[var_3.size] = var_1[0];
  var_3[var_3.size] = "_encstr_8EF5078582607851BB";
  var_3[var_3.size] = var_1[1];
  var_3[var_3.size] = "_encstr_91F5076C3EE8C3290D";
  var_3[var_3.size] = var_1[2];
  var_0 dlog_recordplayerevent("_encstr_8D091B8CB1BDECEB56ECB237A37D4C39FA469CF61C31B09DD7EA9B5619", var_3);

  if(add_outline())
    dialog_grenade_update("_encstr_ADC60861729F70426AD3", var_2, 1);
}

destroy_bad_traversals(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "_encstr_BE580A46E4DEC1AF479585AD";
  var_2[var_2.size] = var_0;
  var_2[var_2.size] = "_encstr_B8F50770738DB9B683";
  var_2[var_2.size] = var_1[0];
  var_2[var_2.size] = "_encstr_8EF5078582607851BB";
  var_2[var_2.size] = var_1[1];
  var_2[var_2.size] = "_encstr_91F5076C3EE8C3290D";
  var_2[var_2.size] = var_1[2];
  getentitylessscriptablearray("_encstr_834E20F5A2AA6F07B55B5282F1099E12AFCDB3CA7B70ABC167D7C97AE9BD554B5FD3", var_2);
}

descendpos(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = _branalytics_header(var_0);
  var_2[var_2.size] = "_encstr_AA3A135CFB40774F8E3312AADBF0D72B2077C9D40B";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_83851B1F31D77A4FB9A8B79390D62A73DFDE24122E6992874170CBA7D8", var_2);
}

descendsolostarts(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = _branalytics_header(var_0);
  var_2[var_2.size] = "_encstr_B24412D3B8210F493849D5D629318C5B56D04A4A";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_8D591A0ABD2042911B1BED0DED8F46EB281E3F900BD9995E09A9273B", var_2);
}

destinations(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = [];
  var_3[var_3.size] = "_encstr_8E8719EA382B2A8F81508EACF6E937B34769B28208B125BF9B4D8C";
  var_3[var_3.size] = var_0;
  var_3[var_3.size] = "_encstr_83FC1BC07BA4E80B8B611E1005D36D5113B3C8B9BF4FA01922978D2D9F";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_AC6E09881A36337B5F6F30";
  var_3[var_3.size] = var_2;
  getentitylessscriptablearray("_encstr_8A1F282363F6ECFAB23B2B9B3AF59827EB8DD858CD43EB1BB79B479385C6D1CDF56CBDB683B1CA3ACA23", var_3);
}

desired_landing_spot(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = [];
  var_3[var_3.size] = "_encstr_8E230B850F2D37F5DC8DB79C2B";
  var_3[var_3.size] = var_0;
  var_3[var_3.size] = "_encstr_A5390D87D9C96A9D68063A063858A5";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_AC6E09881A36337B5F6F30";
  var_3[var_3.size] = var_2;
  getentitylessscriptablearray("_encstr_8A1F282363F6ECFAB23B2B9B3AF59827EB8DD858CD43EB1BB79B479385C6D1CDF56CBDB683B1CA3ACA23", var_3);
}

determinewinnertype(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  getentitylessscriptablearray("_encstr_BAAF1953C19057CF19C4F7380801432E3FBBF920936F4F5F42E3B0", ["_encstr_B88709128910FB77A08738", var_0[0], "_encstr_8E8709CAD025EB67A34899", var_0[1], "_encstr_9187091BAC373AB2E47DF4", var_0[2], "_encstr_AF1904C7E3A4", var_1, "_encstr_8CE208F2A3205A63B0E9", var_2[0], "_encstr_A9E20893A363024B7E33", var_2[1], "_encstr_BAE2086E47589C477DD3", var_2[2], "_encstr_92BE06F03AC75FEA", var_3[0], "_encstr_82BE06497D8C1153", var_3[1], "_encstr_BDBE0656E691F5F4", var_3[2]]);
}

destroy_jammer_relocate(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = [];
  var_2 = 0;
  var_3 = 0;
  var_4 = 5000;
  var_5 = 0;
  var_6 = 5000;

  foreach(var_8 in var_0) {
    if(!isDefined(var_1[var_8.team]))
      var_1[var_8.team] = 0;

    if(isDefined(var_8.plundercount)) {
      var_2 = var_2 + var_8.plundercount;
      var_1[var_8.team] = var_1[var_8.team] + var_8.plundercount;

      if(var_8.plundercount > var_3)
        var_3 = var_8.plundercount;

      if(var_8.plundercount < var_4)
        var_4 = var_8.plundercount;
    }

    if(var_1[var_8.team] > var_5)
      var_5 = var_1[var_8.team];

    if(var_1[var_8.team] < var_6)
      var_6 = var_1[var_8.team];
  }

  var_10 = int(_id_12E53(var_2, var_0.size));
  var_11 = int(_id_12E53(var_2, var_1.size));
  var_12 = [];
  var_12[var_12.size] = "_encstr_BA591237D55BEB838D58E55627B9BE2CD8A5D9B2";
  var_12[var_12.size] = _id_12E4E(var_0.size);
  var_12[var_12.size] = "_encstr_B88D10B823C7C0C83F0183B717665093C35A";
  var_12[var_12.size] = _id_12E4E(var_1.size);
  var_12[var_12.size] = "_encstr_9B2513F3588D3FA53929BCAD3DC8AFCBA0107AFAC1";
  var_12[var_12.size] = _id_12E4E(var_2);
  var_12[var_12.size] = "_encstr_B1CA18D59F331E19E512C0383BF1D1B09F3655C5FAE7A00BCDAA";
  var_12[var_12.size] = _id_12E4E(var_3);
  var_12[var_12.size] = "_encstr_95361CC348870F09A9239709F3E030D9308E329C73DA5203EBF7D133209D";
  var_12[var_12.size] = _id_12E4E(var_5);
  var_12[var_12.size] = "_encstr_96F31827EE077641BDBA7890E3193968276E3DAD423F58A365D2";
  var_12[var_12.size] = _id_12E4E(var_10);
  var_12[var_12.size] = "_encstr_BE5D1C67261779631FDB72B74958F5B2CC77F78840F002D9DEC9B89113B3";
  var_12[var_12.size] = _id_12E4E(var_11);
  var_12[var_12.size] = "_encstr_B6031809E45A07BBDC2F68B05BD773A933CD7585BAE1D141B453";
  var_12[var_12.size] = _id_12E4E(var_4);
  var_12[var_12.size] = "_encstr_92B11CED238A09AB4511474740578092A089BA7CC336EA6B1D69DB814CD1";
  var_12[var_12.size] = _id_12E4E(var_6);
  var_12[var_12.size] = "_encstr_8D7D181023E54041D2E2D8DB7B0A8B2B67EB5010578D597FFB8A";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder._id_12790);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_9A5218CBE513338A4FD36FF32BBC5B1A51590A296FFF51FFC797";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder._id_127AD);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_8DA61638C6BA7346CA27AFD2D1CAB66EEBC84EDB1C079532";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder._id_1278F);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_818916FB44E3AA39FF43A79DEEE07FB126133257B859676F";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder._id_127AC);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_8107223B24EFC0D13992CE769CD1B3AC8BEF695DE9D778A2D707F0AAF06289839A131F20";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder._id_12784);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_81A51263DB70D2BFB873237AF805374B1899E1FC";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.wait_for_all_players_in_airlock);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_8B1914E74BA023E2E7683B35D861DBEAC9F0471FC89B";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_887E1F56C3D1C9581B4796F69B7D262CC6B1B7BDE67DE8BDD1B0D8F567B063AECA";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.oscope_freq_think);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_ADCD250DA8C05520F783888F1BDF12B6D1088F9DE8A9AD15BC59A3E17511882E11178B01707E7F";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.oscope_freq);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_929022696A2545778854A03760388810115336EA4B38474201D3402BC14CEECB5ABDD5CA";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.oscope_sign_think);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_8CF92840EB739559F7F43338F6DFA073DD42F888030BF7732F1CC8ADD17B0ECB1E7BC870AAA333E89323";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.oscope_sign);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_A56818E778F4F91DE520B1B82B4DC0803B3ED6755872BAC5414F";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_8D6818D2CDCEC26BAC7D8DEDBAB9D1FAEAE66CEDB6D6DE9BFA8C";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_AF681889E8315F8D1B31F24A187583EF2B400B37F1989F95477A";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_AC191443FE5780311789198033E375B9AA49FDC3A7AA";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_BE19145ADC9D166BB2F5C6B7AB37D1EB9C854E2BBE91";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_B65B144BDCB3B0B6ACBED8ED5D9B8EFACAC12D1BF54C";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_845B142DB55738816A3F8F8F8F825581ED8A88D911EA";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_9AAB19D2CD7616B52BF5C6DBBADC8EFA362BB3B2E6198527F2BE98";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_A32216EE4733123017EBD55F2BE1C2FB41E1C1638317A17A";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_B4D90E9636AFD277F08057BF3029380A"]);
  else
    var_12[var_12.size] = 0;

  var_12[var_12.size] = "_encstr_819A1973B8A3B31BBFF093FAA801964B3815C7E5C30B9F64F760CB";

  if(isDefined(level.br_plunder))
    var_12[var_12.size] = _id_12E4E(level.br_plunder.vehicle_collision_updateinstance["_encstr_BAD50F704A176E9815A6697BD2BDB0B54F"]);
  else
    var_12[var_12.size] = 0;

  getentitylessscriptablearray("_encstr_A6D127AA0CB548F1A2E01D7001075E8A390761BBF08A2B0A370FB1870D97FB53161BB3C0A218A3F2AD", var_12);
}

defusebomb(var_0) {
  var_1 = var_0 getcurrentweapon();
  var_2 = undefined;

  if(isDefined(var_0.primaryweaponobj) && var_1 != var_0.primaryweaponobj)
    var_2 = var_0.primaryweaponobj;
  else if(isDefined(var_0.secondaryweaponobj) && var_1 != var_0.secondaryweaponobj)
    var_2 = var_0.secondaryweaponobj;

  return [var_1, var_2];
}

destroyscorelaunchonly(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = defusebomb(var_0);
  var_3 = _branalytics_header(var_0);
  var_3[var_3.size] = "_encstr_85F307A6C78A7F78FE";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_96230F62465352E9C358E77F8099B03A05";
  var_3[var_3.size] = _id_12E51(var_2[0]);
  var_3[var_3.size] = "_encstr_8C5D11B9CAC6B79B8C589C97AFBB2BB0C1B7CD";
  var_3[var_3.size] = _id_12E51(var_2[1]);
  var_3[var_3.size] = "_encstr_AACC12E0C9D26B58935EEB592ED54B83AD56E6D1";
  var_3[var_3.size] = _id_12E4F(var_0.equipment["_encstr_BA7F0830B3A7859B60B0"]);
  var_3[var_3.size] = "_encstr_AA64146E568D7B739158E4E5D759E2AB4B0E6BB273E8";
  var_3[var_3.size] = _id_12E4F(var_0.equipment["_encstr_AC8F0AE74163F85AAA380AD8"]);
  var_3[var_3.size] = "_encstr_AFAB10378080C4E23053575F534FBA0520CB";
  var_3[var_3.size] = _id_12E4F(var_0.equipment["_encstr_BEB406F03B72BB3B"]);
  var_3[var_3.size] = "_encstr_A3B30C44EF87910F41E8CF0710F8";
  var_3[var_3.size] = isDefined(var_0.gasmaskequipped) && var_0.gasmaskequipped == 1;
  var_3[var_3.size] = "_encstr_953E0D584EB57B27BE831B161DCAB9";
  var_3[var_3.size] = _id_12E4E(var_0 scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A"));
  var_3[var_3.size] = "_encstr_BD940E10B9C8FDFBDD3B89C360AD27B5";
  var_3[var_3.size] = _id_12E4E(var_0.plundercount);
  var_3[var_3.size] = "_encstr_AF880F60C3A7C531DBABE78650F578BBD0";
  var_3[var_3.size] = _id_12E4E(var_0.plunderbanked);

  if(!isDefined(var_0.br_ammo))
    var_0.br_ammo = [];

  var_3[var_3.size] = "_encstr_BD0109B961786F192FA8CA";
  var_3[var_3.size] = _id_12E4E(var_0.br_ammo["_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9"]);
  var_3[var_3.size] = "_encstr_976C0C0BADB57BAFB0C9EB8D5BEC";
  var_3[var_3.size] = _id_12E4E(var_0.br_ammo["_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"]);
  var_3[var_3.size] = "_encstr_A3B10D06E9BB92370330C753B03BCE";
  var_3[var_3.size] = _id_12E4E(var_0.br_ammo["_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18"]);
  var_3[var_3.size] = "_encstr_9A640C0699D077BF072290C9E59D";
  var_3[var_3.size] = _id_12E4E(var_0.br_ammo["_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6"]);
  var_3[var_3.size] = "_encstr_8E1A0DB17960771125C0821A887152";
  var_3[var_3.size] = _id_12E4E(var_0.br_ammo["_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"]);
  var_4 = [];

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

    if(isDefined(var_0.classstruct) && isDefined(var_0.classstruct.loadoutstandardperks[var_5]))
      var_6 = var_0.classstruct.loadoutstandardperks[var_5];

    var_4[var_5] = var_6;
  }

  var_3[var_3.size] = "_encstr_9684061CB2C95B26";
  var_3[var_3.size] = var_4[0];
  var_3[var_3.size] = "_encstr_8284061C2B39DA23";
  var_3[var_3.size] = var_4[1];
  var_3[var_3.size] = "_encstr_BD8406C159E46D33";
  var_3[var_3.size] = var_4[2];
  var_7 = var_3.size;
  var_3[var_7] = "_encstr_AFC506037F86EADB";
  var_3[var_7 + 2] = "_encstr_8BFE08638E54A3B57391";
  var_3[var_7 + 4] = "_encstr_AF43071B384AAF57F7";
  var_3[var_7 + 6] = "_encstr_ABC506E0F5B50BD9";
  var_3[var_7 + 8] = "_encstr_A5AE074ABE28261A7E";
  var_3[var_7 + 10] = "_encstr_8AC5062BF15B3098";
  var_3[var_7 + 12] = "_encstr_B24408937E2D2387884D";
  var_3[var_7 + 14] = "_encstr_92C5061CEBB5F619";
  var_3[var_7 + 16] = "_encstr_A3C50607EBD99637";
  var_3[var_7 + 18] = "_encstr_AAC506B789B84B33";
  var_3[var_7 + 20] = "_encstr_A20309E091FAD781BB1147";
  var_3[var_7 + 22] = "_encstr_8ECC0753B161EEDF5F";
  var_3[var_7 + 24] = "_encstr_8A0E05B1B1A9F0";
  var_3[var_7 + 26] = "_encstr_B4C506DB216FF588";

  if(isDefined(var_2[0])) {
    var_3[var_7 + 1] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0]._id_12A95));
    var_3[var_7 + 3] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].frontpiece));
    var_3[var_7 + 5] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].backpiece));
    var_3[var_7 + 7] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].magazine));
    var_3[var_7 + 9] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].override));
    var_3[var_7 + 11] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].scope));
    var_3[var_7 + 13] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].underbarrel));
    var_3[var_7 + 15] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].modifier));
    var_3[var_7 + 17] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].visual));
    var_3[var_7 + 19] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].muzzle));
    var_3[var_7 + 21] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].reargrip));
    var_3[var_7 + 23] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].trigger));
    var_3[var_7 + 25] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[0].extra));
    var_3[var_7 + 27] = "_encstr_B40101";
    var_8 = var_2[0].others;

    foreach(var_11, var_10 in var_8) {
      var_3[var_7 + 27] = var_3[var_7 + 27] + scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_10));

      if(var_11 < var_8.size - 1)
        var_3[var_7 + 27] = var_3[var_7 + 27] + "_encstr_964C0249";
    }
  } else {
    for(var_5 = 1; var_5 <= 27; var_5 = var_5 + 2)
      var_3[var_7 + var_5] = "_encstr_B40101";
  }

  var_7 = var_3.size;
  var_3[var_7] = "_encstr_A1F006DCFAC9568D";
  var_3[var_7 + 2] = "_encstr_872E080B91FB6620CD24";
  var_3[var_7 + 4] = "_encstr_ABA107C3592317B844";
  var_3[var_7 + 6] = "_encstr_8DEF063ED73FA15F";
  var_3[var_7 + 8] = "_encstr_99BD072F48DFDB5FE3";
  var_3[var_7 + 10] = "_encstr_AFF0066B812B66FF";
  var_3[var_7 + 12] = "_encstr_88BC08EB5E4B651DE023";
  var_3[var_7 + 14] = "_encstr_82EF0693F0A107D2";
  var_3[var_7 + 16] = "_encstr_8EF0060EAFA86193";
  var_3[var_7 + 18] = "_encstr_BEEF06EB27F0C34B";
  var_3[var_7 + 20] = "_encstr_A3BF0943F942C9841BE7A9";
  var_3[var_7 + 22] = "_encstr_A21707C31ECD33A438";
  var_3[var_7 + 24] = "_encstr_A31905E6FA59E1";
  var_3[var_7 + 26] = "_encstr_97EF06CDAFDEA31A";

  if(isDefined(var_2[1])) {
    var_3[var_7 + 1] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1]._id_12A95));
    var_3[var_7 + 3] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].frontpiece));
    var_3[var_7 + 5] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].backpiece));
    var_3[var_7 + 7] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].magazine));
    var_3[var_7 + 9] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].override));
    var_3[var_7 + 11] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].scope));
    var_3[var_7 + 13] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].underbarrel));
    var_3[var_7 + 15] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].modifier));
    var_3[var_7 + 17] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].visual));
    var_3[var_7 + 19] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].muzzle));
    var_3[var_7 + 21] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].reargrip));
    var_3[var_7 + 23] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].trigger));
    var_3[var_7 + 25] = scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_2[1].extra));
    var_3[var_7 + 27] = "_encstr_B40101";
    var_8 = var_2[1].others;

    foreach(var_11, var_10 in var_8) {
      var_3[var_7 + 27] = var_3[var_7 + 27] + scripts\mp\utility\weapon::attachmentmap_tobase(_id_12E50(var_10));

      if(var_11 < var_8.size - 1)
        var_3[var_7 + 27] = var_3[var_7 + 27] + "_encstr_964C0249";
    }
  } else {
    for(var_5 = 1; var_5 <= 27; var_5 = var_5 + 2)
      var_3[var_7 + var_5] = "_encstr_B40101";
  }

  var_0 dlog_recordplayerevent("_encstr_91EA218C63F63BFAACD9AC73E8F53127AFB49BD9AC733ADEC997FADCDC160EDC43ED47", var_3);

  if(var_1 == "_encstr_84510D999BA26F4801BF86DBA2EDB0")
    var_0 dlog_recordplayerevent("_encstr_85B21F2FB84857D995CD8FABE150D29A2141227593981912E0DF9B8F116E3ACF20", var_3);
}

destructiblevehiclesetup(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = _branalytics_header(var_0);
  var_3[var_3.size] = "_encstr_A2E10E1B403B78301D2B01CBB26DD8FB";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_B6201E13600823633A0163B13B482935CA394F87392B36DFC35353A3884F03CD";
  var_3[var_3.size] = var_0.plundercount;
  var_3[var_3.size] = "_encstr_96230F62465352E9C358E77F8099B03A05";
  var_3[var_3.size] = _id_12E4F(var_2.loadoutprimaryfullname);
  var_3[var_3.size] = "_encstr_8C5D11B9CAC6B79B8C589C97AFBB2BB0C1B7CD";
  var_3[var_3.size] = _id_12E4F(var_2.loadoutsecondaryfullname);
  var_3[var_3.size] = "_encstr_AACC12E0C9D26B58935EEB592ED54B83AD56E6D1";
  var_3[var_3.size] = _id_12E4F(var_2.loadoutequipmentprimary);
  var_3[var_3.size] = "_encstr_AA64146E568D7B739158E4E5D759E2AB4B0E6BB273E8";
  var_3[var_3.size] = _id_12E4F(var_2.loadoutequipmentsecondary);
  var_3[var_3.size] = "_encstr_9A0B071C2B4E5BF513";
  var_3[var_3.size] = _id_12E4F(var_2.loadoutperks[0]);
  var_3[var_3.size] = "_encstr_A50B07389527DAEB23";
  var_3[var_3.size] = _id_12E4F(var_2.loadoutperks[1]);
  var_3[var_3.size] = "_encstr_8D0B070E95C96DEB33";
  var_3[var_3.size] = _id_12E4F(var_2.loadoutperks[2]);
  var_0 dlog_recordplayerevent("_encstr_AA0F25F063BF217792230598BB6955CB27C71030F743FEE1BB4A0E93D64393D64CBFE8E01FF5D3", var_3);
}

destructiblecarlightssetup(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_4 = _branalytics_header(var_0);
  var_4[var_4.size] = "_encstr_A2E10E1B403B78301D2B01CBB26DD8FB";
  var_4[var_4.size] = _id_12E4E(var_1);
  var_4[var_4.size] = "_encstr_B6201E13600823633A0163B13B482935CA394F87392B36DFC35353A3884F03CD";
  var_4[var_4.size] = _id_12E4E(var_0.plundercount);
  var_4[var_4.size] = "_encstr_934A0E3857E41BD0B0B9ACD7A3CB0759";
  var_4[var_4.size] = var_2;
  var_4[var_4.size] = "_encstr_8A5A0AA8237DA5218DFF9320";
  var_4[var_4.size] = var_3;
  var_0 dlog_recordplayerevent("_encstr_A7CC22D7F90FA28771507F4B58EE723B97821C8DDEAF79D01B586F5B18432D9153A5E785", var_4);

  if(add_outline())
    add_object_to_trap_room_ents("_encstr_A36F09E0AEE4C634B06EB2", var_0.origin, var_0 getentitynumber(), var_3);
}

destructable_car(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = _branalytics_header(var_0, "_encstr_A1DC11272BF23EAFC82089559F31F7789B63C8");
  var_3[var_3.size] = "_encstr_BE021714E0B0BB72106327134B387AF773C9CA919990751ADD";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_A69B1D18E2CFD630B10D938D3DE9489CA35AB3068A1305D09327818B424E90";

  if(isDefined(var_2))
    var_3[var_3.size] = var_2;
  else
    var_3[var_3.size] = "_encstr_8BBA05185F8B99";

  var_3[var_3.size] = "_encstr_B8941CAD2DDBE6DAF5DA563757F5DE77DCACE4D72B9D9537D1BEE896B52B";
  var_3[var_3.size] = gettime() - level.starttime;
  var_3[var_3.size] = "_encstr_8198177BBBE0C7DCBF90A20A4867151F7815EAD7C248EFE2FF";

  if(isDefined(var_0.delay_kick_inactive_player))
    var_3[var_3.size] = var_0.delay_kick_inactive_player.index;
  else
    var_3[var_3.size] = -1;

  var_3[var_3.size] = "_encstr_995C195B4BF637D67DDA5973D57DEDEEB995E4BE581B8DB7BBB246";
  var_3[var_3.size] = istrue(var_0.armorykioskpurchaseallowed);
  var_3[var_3.size] = "_encstr_922517C72BFD430B374F27C8753F9FD0A5E3AB19E8C245C8F3";

  if(var_1 != "_encstr_8F330B39D76A636EE3CB08F0F7" && !isDefined(var_0.delay_kick_inactive_player))
    var_3[var_3.size] = "_encstr_97431B3BA848185BE5979BD7F180737628517784CD90CC61CABBEFF7F7";
  else
    var_3[var_3.size] = "_encstr_8BBA05185F8B99";

  var_0 dlog_recordplayerevent("_encstr_B8871F62A890B7F918D52526B9A1FEBBD0E00A5AD37A9FAD20FD4D0FA330C703ED", var_3);
}

detonatefxair(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_4 = [];
  var_4[var_4.size] = "_encstr_9A441208A33BCD01BF4C8BF03E27C8BB630AE088";
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = "_encstr_845D1F23354540056A8BF7B1EB72DE50EC418878DBB7114D93FBA59BFFCB13B88E";
  var_4[var_4.size] = var_3;
  var_4[var_4.size] = "_encstr_910C13FB4833B897AF5B38E0E287D7988CA65117E0";
  var_4[var_4.size] = var_2[0];
  var_4[var_4.size] = "_encstr_8F0C132BF01D932CB147A5DBB9D71CF64BDCE8F55E";
  var_4[var_4.size] = var_2[1];
  var_4[var_4.size] = "_encstr_B80C13C29B73DB58DE5C799F6BEFA8AFCF88AD4F3B";
  var_4[var_4.size] = var_2[2];
  var_0 dlog_recordplayerevent("_encstr_A11C2DC863B73BF55967ACCD8EF5C44EAF07B1D59BC89539FA386358C69519FA5AE6E8F6F52BF0E8272CC6472DB7CD", var_4);
}

detonatefx(var_0, var_1, var_2, var_3, var_4) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_5 = [];
  var_5[var_5.size] = "_encstr_881E0F1873FA97A945DB6890A78C4105E3";
  var_5[var_5.size] = var_0;
  var_5[var_5.size] = "_encstr_8BE912316383E0F8857A0659E07C80AF1AEB8391";
  var_5[var_5.size] = var_1;
  var_5[var_5.size] = "_encstr_B8E5079D75214ABF59";
  var_5[var_5.size] = var_2;
  var_5[var_5.size] = "_encstr_BDCD17B1BDDCE82C5AE69BAF5973B26BCBAFC1B1577319B2C9";
  var_5[var_5.size] = var_3;
  var_5[var_5.size] = "_encstr_BDE014951EA393C26CD15AF6DCFADBE44B9D2D377DF0";
  var_5[var_5.size] = var_4[0];
  var_5[var_5.size] = "_encstr_82E014529B83B047D71BF38F9511F075A0EC1896F9C8";
  var_5[var_5.size] = var_4[1];
  var_5[var_5.size] = "_encstr_92E014D7ABEB8B415E3488E71ED17ADBD827479E5738";
  var_5[var_5.size] = var_4[2];
  getentitylessscriptablearray("_encstr_A56B29D379F0392FE5B471B06B0170166F2015F338E21AFD410AA06DABFAFF73DB5742E7AFA3D3827F26E2", var_5);
}

detonatefunc(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_4 = [];
  var_4[var_4.size] = "_encstr_8CAC10AB08C31E32B3465197AE7FABC869F0";
  var_4[var_4.size] = var_0;
  var_4[var_4.size] = "_encstr_B8E5079D75214ABF59";
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = "_encstr_BDE014951EA393C26CD15AF6DCFADBE44B9D2D377DF0";
  var_4[var_4.size] = var_2[0];
  var_4[var_4.size] = "_encstr_82E014529B83B047D71BF38F9511F075A0EC1896F9C8";
  var_4[var_4.size] = var_2[1];
  var_4[var_4.size] = "_encstr_92E014D7ABEB8B415E3488E71ED17ADBD827479E5738";
  var_4[var_4.size] = var_2[2];
  var_4[var_4.size] = "_encstr_886E15C8ACCD3A39ABB1A35ABD37EBBD39A5D95A73D7E1";
  var_4[var_4.size] = var_3[0];
  var_4[var_4.size] = "_encstr_816E159D955E51066507A308BF6347CA6661F9AC203F90";
  var_4[var_4.size] = var_3[1];
  var_4[var_4.size] = "_encstr_AA6E15D17753AB83152E9CDB30E0C9CF8B4B7A6AB81F73";
  var_4[var_4.size] = var_3[2];
  getentitylessscriptablearray("_encstr_BAD92970510A5F1737C30245D53F63E26EE3D85B4612BA538113DBBB5849BFE8F2B008F71CA0310295A5C5", var_4);
}

deregisterscriptableinstance(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(isDefined(self))
    var_2 = self getentitynumber() + "_encstr_82070352C1" + var_1;
  else
    var_2 = "_encstr_846E07CDBD9BCA7604" + var_1;

  var_0 = int(var_0);

  if(add_outline())
    add_object_to_trap_room_ents("_encstr_A3C70D7AB068B7BAA9913CE54D3847", (0, 0, 0), var_0, var_2);
}

_encstr_9A601EC616B073C3395378FBE39F8635402F787B4830AFB90F0A9033BF80D227(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = "_encstr_8DC7086BEEA408C0AF8A";

  if(!isDefined(var_1))
    var_1 = 1;

  var_1 = int(var_1);
  var_0 dlog_recordplayerevent("_encstr_8BBD231D5C8FD987672360201BB191F00FE1158E976FEDC94F1B582053D717696772288D04", ["_encstr_88201217353ADB89526770409B9D063332DF059B", var_0.matchdatalifeindex, "_encstr_843F140B117753A5285E727E7093ED89DDA39BFBFB2D", var_1, "_encstr_A7380C6ED87B39ACFA95CE2BE6A3", var_2]);

  if(add_outline()) {
    if(isDefined(var_0))
      var_3 = self getentitynumber() + "_encstr_82070352C1" + var_2;
    else
      var_3 = "_encstr_846E07CDBD9BCA7604" + var_2;

    add_object_to_trap_room_ents("_encstr_95970ADADB46CAD4B1ED27AC", var_0.origin, var_1, var_3);
  }
}

dialog_low_health(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = [];
  var_1[var_1.size] = "_encstr_857E07856BDBAEE6D1";
  var_1[var_1.size] = 1;
  var_0 dlog_recordplayerevent("_encstr_B4C33E59126F7C319FB6736DDC4980BE075BF3E0EABF2E7877B90741F9AD2890EB5289288313F0B80D913B6B0A9908CB0B5A80539A031589A6673F270B7C8899", var_1);
}

dialog_kill_watcher_civ(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = [];
  var_1[var_1.size] = "_encstr_9BA20CD8F7015387B299FD866F6A";
  var_1[var_1.size] = var_0;
  getentitylessscriptablearray("_encstr_A3D53223D87BB3D7ACD95937D17D1339EB9BBAAD5BCA937B990BB1D1A5DB37F5B267CADCA3FA3686DB0E0E95E4F5B6B41B362B23", var_1);
}

detonatingplayer(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_4 = [];
  var_4[var_4.size] = "_encstr_857E07856BDBAEE6D1";
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = "_encstr_885B0FC236365EBEC6DB36D8CA8DE82B19";
  var_4[var_4.size] = var_2;
  var_4[var_4.size] = "_encstr_8E7A10AC9B59DAF2AF8DB7B18D2B6C8E2B46";
  var_4[var_4.size] = var_3;
  var_0 dlog_recordplayerevent("_encstr_A356313564B7E1AF4F7B085873E98D1B1F70C834C57B293DB622E1B08A3E73317387C5A05F8B516F1A190840A2957389C3255D", var_4);
}

detonation_time(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "_encstr_92290FC92DBB550C377F3FCB6905FB4027";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_B8843562A890B7F918D52526B9A1FEBBD0836ADB11F67F6A0BE56720B188C02FEE1E3362BBC753A719D1552E4BC801879E501AEA23ADC3", var_2);
}

detonation_color_omnvar_value(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "_encstr_857E07856BDBAEE6D1";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_A9B93B32B1F69DF559EC9573E8EBC439F5E0EDEE2B9CD927B04CF50E1B16CB569C7DA1D2D9342BE63AEBB287E8390BEB8D5A9D59CDFA3959B0D8349519", var_2);
}

detonation_code_omnvar_value(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "_encstr_857E07856BDBAEE6D1";
  var_2[var_2.size] = var_1;
  var_0 dlog_recordplayerevent("_encstr_8C2B306B6060E4CF694BE82575AFE13BDFB18880823A12BEC7883923C87EBBD2C3AFFAF190FD1BC97502E368EFC7BB0BDAED", var_2);
}

devspectateenemyteam1(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_3 = [];
  var_3[var_3.size] = "_encstr_857E07856BDBAEE6D1";
  var_3[var_3.size] = var_0;
  var_3[var_3.size] = "_encstr_885B0FC236365EBEC6DB36D8CA8DE82B19";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "_encstr_8E7A10AC9B59DAF2AF8DB7B18D2B6C8E2B46";
  var_3[var_3.size] = var_2;
  getentitylessscriptablearray("_encstr_A26236BDCA222779DFFD1A9D2DE7CA109F50FFF8CD5D47D2C738206B53CB16C3811CF77326F30F99C8928471379E1E60C8607BDD101945B3", var_3);
}

devscriptedtests(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = [];
  var_1[var_1.size] = "_encstr_99591593190C3F22E077BCBD0DC0ED7F36B13A0A40EDE3";
  var_1[var_1.size] = var_0;
  getentitylessscriptablearray("_encstr_8793353263DE9D7DCAB3ACCDE8F589E4AF0EF6EEB2C976C985C4EBCD5CD51623BE0DA5D9A12B3747D79C95EEC2E432F539952CC6A15923", var_1);
}

devspectateenemyteam2() {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "_encstr_857E07856BDBAEE6D1";
  var_0[var_0.size] = 1;
  getentitylessscriptablearray("_encstr_B16225B9C382C481E51B215883F7A086391B37179F3B9CD039F66E73ECBE1136B33FAB713B52D1", var_0);
}

dialog_monitor_shieldstow(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  if(add_outline() && isDefined(level._id_12855))
    add_pack_camanim("_encstr_9A50080BA7292FFA0DA2", var_0.origin, var_0, var_1);
}

_encstr_BA6B1C12A0F3B5AFA8A36C79B6938F3A0FCB3A5AE05FEAF7C185506458FA(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("_encstr_A1761C5298A087C908C55556A9B18ACFD3707A6AC0101BBFD8DB582C87B8", var_1);
}

destroypropspecatehud(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_8CA41BF278B881C11D74F82D2459D872F1EFD45A3A122F5087BBD06323", ["_encstr_86A80DB957B6FAADB4E6CDD27BCDB9", var_0, "_encstr_A7A414B9EA5BD7AD2D9BE64BDB736EEB0B8D3AD2B395", var_1, "_encstr_BEF9147D777208C0D96AD3E815B678407AAFD1E1AFAA", var_2, "_encstr_81120DA449DFAB0F38D0A359E280A3", var_3]);
}

destorder(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_87E02146C6BD9DD7CA9DAC9BE87DC493AFD64B37DC5AED737D93CA38BD0E5DC6581D56", ["_encstr_BAA70D43AB53970DDBF1921AD023C0", var_0, "_encstr_9BA80DCD867BDD7DE0B2C9B1AC73E8", var_1, "_encstr_93FE0ACA80F3F1FB3121796C", var_2, "_encstr_A90F0ADCAEB6AFDC86B7DD73", var_3]);
}

dialog_hurry(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_82391C09AC65801827CB0950D3F74EE0B1359BDF5B4C78D8A7F3A3B90BDB", ["_encstr_840703024B", scripts\engine\utility::ter_op(isDefined(var_0.index), "_encstr_B40101" + var_0.index, "_encstr_975C08DAFD6501713F9D"), "_encstr_81EF05D197C12B", var_0._id_139EB, "_encstr_962D097B272DCE96DCBE1E", var_0.origin[0], "_encstr_872D098843C7EC10CD0FBB", var_0.origin[1], "_encstr_BD2D09FD6B68478A20AFE3", var_0.origin[2]]);

  if(add_outline() && isDefined(var_0.index))
    add_pack_camanim("_encstr_B8C808A7C3B63B617830", var_0.origin, "_encstr_B40101" + var_0.index, var_0._id_139EB);
}

destroyscoreevent(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_A1901EDC81582F796310CA72283FEEA3B6F92943A620477D6FF042EB788164B3", ["_encstr_840703024B", scripts\engine\utility::ter_op(isDefined(var_0.index), "_encstr_B40101" + var_0.index, "_encstr_975C08DAFD6501713F9D"), "_encstr_81EF05D197C12B", var_0._id_139EB, "_encstr_962D097B272DCE96DCBE1E", var_0.origin[0], "_encstr_872D098843C7EC10CD0FBB", var_0.origin[1], "_encstr_BD2D09FD6B68478A20AFE3", var_0.origin[2]]);
}

reset_ability_invulnerable(var_0) {
  var_1 = 0;

  if(var_0.questcategory == "_encstr_9A3F1133610DE2C03888058B21400C4BEF9793") {
    if(isDefined(var_0.overwatch_soldiers_05_bombers))
      var_1 = var_0.overwatch_soldiers_05_bombers;
  }

  return var_1;
}

determinetrackingcirclesize(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  var_2 = [];
  var_3 = scripts\mp\utility\teams::getfriendlyplayers(var_1.team, 1);
  var_2 = add_pack_modelanim(var_2, var_3);
  var_2[var_2.size] = "_encstr_840703024B";
  var_2[var_2.size] = scripts\engine\utility::ter_op(isDefined(var_0._id_11C4E), var_0._id_11C4E, "_encstr_975C08DAFD6501713F9D");

  if(isDefined(level.br_circle))
    var_4 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_circle.circleindex);
  else
    var_4 = -1;

  var_2[var_2.size] = "_encstr_BAA70D43AB53970DDBF1921AD023C0";
  var_2[var_2.size] = var_4;
  var_2[var_2.size] = "_encstr_81EF05D197C12B";
  var_2[var_2.size] = var_0.questcategory;
  var_2[var_2.size] = "_encstr_91CC129185FB5A4BE0B31E500F797ADD7B56E031";
  var_2[var_2.size] = reset_ability_invulnerable(var_0);
  var_1 dlog_recordplayerevent("_encstr_86161CD948725FB7602395C65B0911BDF1CAE1C3638B08A5382FE97B9283", var_2);

  if(add_outline() && isDefined(var_0._id_11C4E))
    dialog_grenade_update("_encstr_B8C808A7C3B63B617830", var_0._id_11C4E, -1);
}

determinetrackingcircleoffset(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_8DC31A2F3288EF0E7F8337B0CB5E327EB7F3C14FF049F21AD6ED35AF", ["_encstr_840703024B", scripts\engine\utility::ter_op(isDefined(var_0._id_11C4E), var_0._id_11C4E, "_encstr_975C08DAFD6501713F9D"), "_encstr_9B7C07725D17A39473", scripts\engine\utility::ter_op(isDefined(var_0.result), var_0.result, "_encstr_8DC7086BEEA408C0AF8A"), "_encstr_ADBB0C28CD2841F2479783B8F2D3", var_1, "_encstr_B607032B8B", scripts\engine\utility::ter_op(isDefined(var_2["_encstr_B607032B8B"]), var_2["_encstr_B607032B8B"], 0), "_encstr_BEDE0A8359473B2570B76868", scripts\engine\utility::ter_op(isDefined(var_2["_encstr_BEDE0A8359473B2570B76868"]), var_2["_encstr_BEDE0A8359473B2570B76868"], 0), "_encstr_83A20883C6EA378C2B93", scripts\engine\utility::ter_op(isDefined(var_2["_encstr_83A20883C6EA378C2B93"]), var_2["_encstr_83A20883C6EA378C2B93"], 0), "_encstr_86B31698BBB54F7B6F61B1B979F381DF9142D878A38F6331", scripts\engine\utility::ter_op(isDefined(var_3), var_3, 0), "_encstr_81EF05D197C12B", var_0.questcategory, "_encstr_91CC129185FB5A4BE0B31E500F797ADD7B56E031", reset_ability_invulnerable(var_0)]);

  if(add_outline() && isDefined(var_0._id_11C4E)) {
    if(isDefined(var_0.result) && var_0.result == "_encstr_88E30897BDF1B71F7823")
      dialog_grenade_update("_encstr_B8C808A7C3B63B617830", var_0._id_11C4E, var_1);
    else
      dialog_grenade_update("_encstr_B8C808A7C3B63B617830", var_0._id_11C4E, -1);
  }
}

dialog_monitor_getoffground(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_BDF71E4C11C8BFC9D3A05AE2584F7E132685D5C13996FF4D9340821AE821F703", ["_encstr_8AEF05472BC2D6", var_0, "_encstr_99480A2B48EBFEB7B0A57E7C", var_1, "_encstr_BA2A0EDCAB9CB32D3B2C8DAFA3B45B95", gettime() - level.starttime]);
}

devspectatetest(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_BD3A21688A959FBECF16D5580CFFC17D71B368C022ACCFF6A73EED40E4D7AB09A63B98", ["_encstr_81EF05D197C12B", var_0]);
}

devspectateloc(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }
  getentitylessscriptablearray("_encstr_AA751F8CD87B3BBE2B9D56731DAFC4E4BEE0AB261BD2B1BEB2ECAC73D1F5953719", ["_encstr_81EF05D197C12B", var_0]);
}

_branalytics_header(var_0, var_1) {
  var_2 = [];

  if(!isstring(var_1))
    var_1 = "_encstr_8BB007E03658CBCAE4";

  var_2 = add_pack_fx(var_2, var_0, var_1);

  if(isDefined(level.br_circle))
    var_3 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_circle.circleindex);
  else
    var_3 = -1;

  var_2[var_2.size] = "_encstr_BAA70D43AB53970DDBF1921AD023C0";
  var_2[var_2.size] = var_3;
  return var_2;
}

add_pack_fx(var_0, var_1, var_2) {
  if(!isstring(var_2))
    var_2 = "_encstr_8BB007E03658CBCAE4";

  var_0[var_0.size] = var_2 + "_encstr_810703C930";
  var_0[var_0.size] = var_1.origin[0];
  var_0[var_0.size] = var_2 + "_encstr_880703C030";
  var_0[var_0.size] = var_1.origin[1];
  var_0[var_0.size] = var_2 + "_encstr_970703EB3D";
  var_0[var_0.size] = var_1.origin[2];
  var_0[var_0.size] = var_2 + "_encstr_A3F707C728248448F8";
  var_0[var_0.size] = scripts\engine\utility::getplayerpitch(var_1);
  var_0[var_0.size] = var_2 + "_encstr_B84305E0105AA7";
  var_0[var_0.size] = scripts\engine\utility::getplayeryaw(var_1);
  return var_0;
}

add_pack_modelanim(var_0, var_1) {
  var_0[var_0.size] = "_encstr_8BFB12080818E780FF310B34827B2B45A14F30A6";
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2[var_2.size] = "_encstr_814C02A2";
    var_2[var_2.size] = var_4.origin[0];
    var_2[var_2.size] = "_encstr_AA4C0279";
    var_2[var_2.size] = var_4.origin[1];
    var_2[var_2.size] = "_encstr_964C02E5";
    var_2[var_2.size] = var_4.origin[2];
    var_2[var_2.size] = "_encstr_BD6506F36A2B46B0";
    var_2[var_2.size] = scripts\engine\utility::getplayerpitch(var_4);
    var_2[var_2.size] = "_encstr_AF1904C7E3A4";
    var_2[var_2.size] = scripts\engine\utility::getplayeryaw(var_4);
  }

  var_0[var_0.size] = var_2;
  return var_0;
}

_id_12E4F(var_0) {
  if(isDefined(var_0))
    return var_0;
  else
    return "_encstr_83B306C13570D0CB";
}

_id_12E50(var_0) {
  if(isDefined(var_0))
    return var_0;
  else
    return "_encstr_B40101";
}

_id_12E51(var_0) {
  if(isDefined(var_0))
    return var_0.basename;
  else
    return "_encstr_83B306C13570D0CB";
}

_id_12E4E(var_0) {
  if(isDefined(var_0))
    return var_0;
  else
    return 0;
}

_id_12E53(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0)
    return var_0 / 1;
  else
    return var_0 / var_1;
}

destroy_lmgs() {
  if(add_outline()) {
    if(isDefined(level.kothtotaltime["_encstr_9A50080BA7292FFA0DA2"])) {
      foreach(var_1 in level.kothtotaltime["_encstr_9A50080BA7292FFA0DA2"]) {
        if(!isDefined(var_1.ent)) {
          var_1.state = 1;
          continue;
        }

        if(distancesquared(var_1.origin, var_1.ent.origin) > squared(1000))
          var_1.state = 1;
      }
    }

    if(isDefined(level.br_armory_kiosk)) {
      foreach(var_4 in level.br_armory_kiosk.scriptables) {
        if(istrue(var_4.visible)) {
          analyticswritecsv(var_4.origin, "_encstr_B48D064CB8E8E33A", 1, 0, "_encstr_B40101");
          continue;
        }

        analyticswritecsv(var_4.origin, "_encstr_B48D064CB8E8E33A", 0, 0, "_encstr_B40101");
      }
    }

    if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
      var_6 = level.br_level.default_class_chosen.size - 1;
      var_7 = 0;

      for(var_8 = 0; var_8 < var_6; var_8++) {
        var_9 = level.br_level.default_class_chosen[var_8 + 1];
        var_10 = level.br_level.br_circleradii[var_8 + 1];
        var_11 = level.br_level.br_circledelaytimes[var_8];
        var_12 = level.br_level.br_circleclosetimes[var_8];
        var_7 = var_7 + var_11 + var_12;
        analyticswritecsv(var_9, "_encstr_A78F076CA54E1B1B56", int(var_10), int(var_7), "_encstr_B40101");
      }
    }

    foreach(var_14 in level.kothtotaltime) {
      foreach(var_16 in var_14)
      analyticswritecsv(var_16.origin, var_16.type, var_16.state, var_16.time, var_16.data);
    }
  }

  objective_setspecialobjectivedisplay();
}

teamvehicles() {
  level.get_vehicle_driver_hint_string_func = [];
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_8EAD05E157ED90";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_B8C808A7C3B63B617830";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_AA7C07466F9DA30713";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_AF3A063777C2C3D0";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_84CA10D2E827C44F3EF9ADA7056033CE6DB0";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_9B49104F1720FB37B95AA643CCCF8327FB15";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_A7B30DE187CA05B92B54B8537A15E8";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "_encstr_8771099F9E6F47990AB57A";
  level.get_veh_spawn_test_spawners = [];

  foreach(var_1 in level.teamnamelist) {
    var_2 = spawnStruct();
    var_2.sources = [];
    var_2._id_13BF0 = [];

    foreach(var_4 in level.get_vehicle_driver_hint_string_func) {
      var_2.sources[var_4] = 0;
      var_2._id_13BF0[var_4] = 0;
    }

    level.get_veh_spawn_test_spawners[var_1] = var_2;
  }

  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level thread _id_12AA6();
}

_id_12AA6() {
  for(var_0 = 60.0; !istrue(level.gameended); var_0 = max(60.0 - var_12, 0)) {
    level scripts\engine\utility::waittill_notify_or_timeout("_encstr_9B1D0BC7932875276230426AA1", var_0);
    var_1 = gettime();
    var_2 = scripts\mp\gamescore::run_common_functions_stealth();

    foreach(var_4 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_4)) {
        continue;
      }
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
      var_6 = [];
      var_6[var_6.size] = "_encstr_8C170FBFCB3D3268019935BDD3B0ADFB1D";
      var_6[var_6.size] = 0;
      var_6[var_6.size] = "_encstr_84EF055338A18F";
      var_6[var_6.size] = var_5;
      var_6[var_6.size] = "_encstr_8AEF05472BC2D6";
      var_6[var_6.size] = var_4;
      var_6[var_6.size] = "_encstr_99480A2B48EBFEB7B0A57E7C";
      var_6[var_6.size] = var_2[var_4];

      foreach(var_8 in level.get_vehicle_driver_hint_string_func) {
        var_9 = level.get_veh_spawn_test_spawners[var_4].sources[var_8];
        var_6[var_6.size] = "_encstr_952D0DEE066B89BE23F7E8A8BF4DF6" + var_8;
        var_6[var_6.size] = var_9;
        level.get_veh_spawn_test_spawners[var_4]._id_13BF0[var_8] = level.get_veh_spawn_test_spawners[var_4]._id_13BF0[var_8] + var_9;
        level.get_veh_spawn_test_spawners[var_4].sources[var_8] = 0;
      }

      getentitylessscriptablearray("_encstr_A77E20C836BD9DF52BD959E6D1FA4CD8BD7B467DDAF6B9CACBFAA5734756939D2C63", var_6);
      waitframe();
    }

    var_12 = (gettime() - var_1) * 0.001;
  }

  var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2 = scripts\mp\gamescore::run_common_functions_stealth();

  foreach(var_4 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_4)) {
      continue;
    }
    var_6 = [];
    var_6[var_6.size] = "_encstr_8C170FBFCB3D3268019935BDD3B0ADFB1D";
    var_6[var_6.size] = 1;
    var_6[var_6.size] = "_encstr_84EF055338A18F";
    var_6[var_6.size] = var_5;
    var_6[var_6.size] = "_encstr_8AEF05472BC2D6";
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = "_encstr_99480A2B48EBFEB7B0A57E7C";
    var_6[var_6.size] = var_2[var_4];

    foreach(var_8 in level.get_vehicle_driver_hint_string_func) {
      var_9 = level.get_veh_spawn_test_spawners[var_4]._id_13BF0[var_8];
      var_6[var_6.size] = "_encstr_952D0DEE066B89BE23F7E8A8BF4DF6" + var_8;
      var_6[var_6.size] = var_9;
    }

    getentitylessscriptablearray("_encstr_A77E20C836BD9DF52BD959E6D1FA4CD8BD7B467DDAF6B9CACBFAA5734756939D2C63", var_6);
  }
}

_id_13C44(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_0.team)) {
    return;
  }
  if(add_outline())
    add_object_to_trap_room_ents("_encstr_85FC0ED7F5BB3569851329C01FD9E369", var_0.origin, var_2, var_0.team + "_encstr_82070352C1" + var_0 getentitynumber() + "_encstr_82070352C1" + var_1);

  if(!isDefined(level.get_veh_spawn_test_spawners)) {
    return;
  }
  var_3 = var_0.team;
  level.get_veh_spawn_test_spawners[var_3].sources[var_1] = level.get_veh_spawn_test_spawners[var_3].sources[var_1] + var_2;
}

_id_1205B() {
  thread allowed_objectives();
}

allowed_objectives() {
  waittillframeend;
  var_0 = level.disable_super_in_turret.name;
  var_1 = scripts\engine\utility::remove_player_rig_laser_panel(level.maxteamsize);
  var_2 = scripts\engine\utility::remove_player_rig_laser_panel(level.players.size);
  var_3 = scripts\engine\utility::remove_player_rig_laser_panel(level.teamswithplayers.size);
  var_4 = 0;

  foreach(var_6 in level.players) {
    if(isbot(var_6) || var_6 calloutmarkerping_getEnt()) {
      continue;
    }
    var_4++;
  }

  if(isDefined(level.br_armory_kiosk))
    var_8 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_armory_kiosk._id_13AC2);
  else
    var_8 = 0;

  var_9 = scripts\engine\utility::remove_player_rig_laser_panel(level.usegulag);

  if(isDefined(level.gulag)) {
    var_10 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag.maxuses);
    var_11 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag._id_11F2D);
    var_12 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag._id_13672);
  } else {
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
  }

  var_13 = [];

  if(isDefined(level.questinfo)) {
    foreach(var_16, var_15 in level.questinfo.tabletinfo) {
      var_13[var_13.size] = "_encstr_84BA05A8CA852B";
      var_13[var_13.size] = var_16;
      var_13[var_13.size] = "_encstr_819F0B7B3B89018832D239453D";
      var_13[var_13.size] = isDefined(var_15) && istrue(var_15.enabled);
    }
  }

  var_17 = scripts\engine\utility::remove_player_rig_laser_panel(getplaylistid());

  if(isDefined(level._id_12855))
    var_18 = level._id_12855;
  else
    var_18 = -1;

  var_19 = _func_042D();
  getentitylessscriptablearray("_encstr_B2B32185B0C847C7F5D38536AB6706B339A78D4A934D5E81280644422309E8B50693BB", ["_encstr_966215CA9E4E17C47F081A7208CF7BBF438D6F49383157", var_13, "_encstr_AB1904852B68", level.script, "_encstr_82DB0EC6DD98A0DC51A1D3F7859F3348", var_0, "_encstr_AC880E67D8DA879B2B57B52146DBB345", var_1, "_encstr_A7E60D8363F85FA2B6F17737DDA0C8", var_2, "_encstr_AC8313B8ABA5C3C8776021AF51A773F78E92D8F0D3", var_4, "_encstr_82A60B887A76EBDEB72FFD782C", var_3, "_encstr_9269134727801220395B675E4FDB775EA697CAF6EC", var_8, "_encstr_93610D999B99124FD8F39694A1D8DD", var_9, "_encstr_92980F76BA36B0EC7DD6581EF5D53759CD", var_10, "_encstr_843D155723F1D2A741DBB3FED330E19ADCDFD78BEBA82B", var_11, "_encstr_99B01130583AD98FA9FAA39B23F81F1028F02D", var_12, "_encstr_9AF912133B8FA118136BD147957DF86013220839", var_18, "_encstr_87680C38B1B05E364BCDA3D7D232", var_17, "_encstr_87D40E83D81697C65ADC8EFAB9B0DAAC", var_19]);
}