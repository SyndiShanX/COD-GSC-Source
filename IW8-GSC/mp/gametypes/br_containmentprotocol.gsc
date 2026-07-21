/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_containmentprotocol.gsc
***************************************************/

init() {
  var_0 = any_player_within_distance2d();

  if(!var_0) {
    return;
  }
  level._effect["_encstr_861F0DB5BB2FB868E6BB9AF6477013"] = loadfx("_encstr_B4CF34EC99C35E2D77707D3193CBEC2CDA59E0B185E5F295CEAC9BA35E3B33E1FA9BD6B5A39C2CD28DFA6796E6E816EB27EDD8D62B8E");
  thread allassassin_give();
  thread actorid();
  thread add_player_to_focus_fire_attacker_list();
}

allassassin_give() {
  wait 3.0;
  scripts\mp\utility\sound::besttime("_encstr_97810F314EBE3D6BC4F5917B67FADC33E1");
}

any_player_within_distance2d() {
  if(getdvarint("_encstr_BD0D3062D128E79296172F274DBD6A1910F81FADAB90721AED1F272FA1F0024D18431779A1083F32433F370789836B811029", 0) == 1)
    level.hostskipburndownlow = 1;

  if(getdvarint("_encstr_99FE1BEA59A06F0A1E9F97AFD5C5E281A860E73513080A9275E7AFB729", 0) == 0 && !istrue(level.hostskipburndownlow))
    return 0;

  level.hostskipburndownhigh = spawnStruct();
  level.hostskipburndownhigh.intensity = getdvarint("_encstr_B8DC250327C3F9D6852799A2157988C075C107C834A2C2C7DBB797C7301104A2ABDD3D97A3DB03", 1);
  var_0 = getdvarfloat("_encstr_AD4830371B39EB9827EBC6B7B91D5896DCADCAB947E09CDEA3DBB1ED8DD74BB94795CD6E2DA3E5F5B15A6D95634B43DEB78C", 0.05);
  var_1 = randomfloat(1.0) < var_0;
  return var_1 || istrue(level.hostskipburndownlow);
}

actorid() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");

  if(level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    level waittill("_encstr_B4DE144C93BE1B139960FA1B5933D1FA98DED59B91CD");

  for(;;) {
    var_0 = scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || istrue(level.hostskipburndownlow);

    if(var_0)
      thread actorloopanim();

    var_1 = 0;
    var_2 = scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8F94079C2BB3B2C21B";

    if(!var_2 && isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      var_3 = getdvarint("_encstr_B48D354AF993CFAABE3FF7CFB5654221488047957368AA3295470FD789980A6DF0E8FF1DEB705809666343EFE1BD02CDE0B637A7409011", 5);
      var_1 = 5 * max(0, level.br_circle.circleindex);
    }

    var_4 = var_1 + getdvarint("_encstr_964B2FF7716EFE25330E8E3F7DE38723B3ED9DE0B32340A0BB1028E0BCDEEEA8F68FCB9D6BDC30D7744509C92FFF0B62E6", 25);
    var_5 = var_1 + getdvarint("_encstr_A24B2F8F9E96B701152779788B80269B6DF0273050EB5225CBD7F9A73421B655A5B7C548B88EFB07699771BFCB47E0AF2B", 70);
    var_6 = randomfloatrange(var_4, var_5);
    wait(var_6);
  }
}

actorloopanim() {
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");

  for(var_0 = getdvarint("_encstr_9B94316E6C27FA13C9F5C6BDB9D10B2DCDB6ACCDA3074EDB47ED1BB71BF52C5B4CA5ACCDE899F0D74E7B1B6D953A8DDB57E6D1", 3); var_0 > 0; var_0--) {
    wait(randomfloat(15.0));
    thread actorthinkpath_default();
  }

  var_1 = getdvarint("_encstr_8DB53FE3B9EEA74670579397DDA84E8718901ABAE3475B7D180F8B6FC1C916DFB68892028B14ABB9B0738C69C3A11E27ECE01B3A76F7B36E186B8763A110E66385", 3);
  wait(var_1);
  actorrope();
}

actorthinkpath_default() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");
  var_0 = (randomintrange(-10000, 10000), randomintrange(-10000, 10000), 0);
  var_1 = level.br_level.br_mapcenter + var_0;
  var_2 = getdvarint("_encstr_826E329B56AB9F463D29FA32C859FE3F40C9150E7533E3CDE990E24AC03736E779A39DB68D599399CD78EA02A0892C9FF01CE824", -700);
  var_1 = (var_1[0], var_1[1], var_2);
  var_3 = vectorNormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
  var_4 = scripts\mp\utility\game_utility_mp::removespawns(0);
  var_5 = getdvarfloat("_encstr_B64141D6B64BD72912274830FB4C01F3F25D45D0CBC35570FCCF40389B4FD9039AC4CD68237A093EC2377860879C5671722B33E1FF928F83B017C0502BA98B919A97B6", 1.7);
  var_6 = var_4 * var_5;
  var_7 = var_1 - var_3 * (var_6 / 2.0);
  var_8 = var_1 + var_3 * (var_6 / 2.0);
  var_9 = getdvarint("_encstr_9538342328860F254B5FAF88758398D870C8779E533B33172B97C72720AF729F11431D50A94DD09F3B6A43B0B1E0D20BC07B38919F6E", 14);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);

  if(!isDefined(var_10)) {
    return;
  }
  var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_10 unmarkkeyframedmover(1);
  waitframe();
  waitframe();
  var_10 playLoopSound("_encstr_8A03174348D6973688257457C780F1878B236BFAF03DDFAD48");
  playFXOnTag(level._effect["_encstr_861F0DB5BB2FB868E6BB9AF6477013"], var_10, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_11 = -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800);
  var_12 = trajectorycalculateinitialvelocity(var_7, var_8, (0, 0, var_11), var_9);
  var_10 movegravity(var_12, var_9);

  if(getdvarint("_encstr_A9A726B673DBFEDD82D13048DA5B9370D31535A0DC7B833FEBFA384092B941094B954CB02CDF694F", 0) == 1) {
    var_13 = "_encstr_A93B1419D7C2C05A1E32B71FAA2F2821171DDEF20BAD" + var_7 + "_encstr_81500F30D99B7D976CC7A869FD2FCFE8EA" + var_8;
    iprintlnbold(var_13);
    logstring(var_13);
  }

  var_14 = gettime();
  var_15 = gettime() + var_9 * 1000;

  while(gettime() < var_15) {
    var_16 = var_10.origin;
    waitframe();
    var_17 = var_10.origin;
    var_18 = var_17 - var_16;
    var_10.angles = vectortoangles(var_18);
    var_10 addpitch(90);
  }

  waitframe();
  var_10 delete();
}

actorrope() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");
  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincurrentcircle();

  if(getdvarint("_encstr_96BA33ABF20B10A82AEF6F7FF69388C3D38AE1F06BDB3E88C3A77747ECB1689D9BA3395E93C3FF585F9351530E67E950731AB12D1A", 0) == 1)
    var_0 = (0, 0, 0);

  var_1 = getdvarint("_encstr_BE2F322BE61B2FD6ADB90AC258C94EAF305985BE85A3535D992072DA70478677E9330D261DC903697DD89A02981B3AFFC1AB85B3", 10000);
  var_2 = var_1 * var_1;
  var_3 = undefined;
  var_4 = [];

  foreach(var_6 in level.players) {
    if(var_6 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal()) {
      continue;
    }
    var_3 = var_6;
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_2)
      var_4[var_4.size] = var_6;
  }

  foreach(var_6 in var_4) {}

  while(istrue(level.hostskipburndownhigh.monitorexitbutton) || istrue(level.hostskipburndownhigh._id_123AD))
    waitframe();

  level.hostskipburndownhigh._id_123AD = 1;
  add_practice_bots(1, var_4);
  add_rider_to_decho();
  var_11 = undefined;

  if(var_4.size > 0)
    var_11 = var_4[0];
  else
    var_11 = var_3;

  if(isDefined(var_11)) {
    wait 3.0;
    add_to_ents_to_clean_up(var_4);
    var_11 scripts\cp_mp\killstreaks\airstrike::game_end_watcher(var_0, 1, 1);

    if(getdvarint("_encstr_A9A726B673DBFEDD82D13048DA5B9370D31535A0DC7B833FEBFA384092B941094B954CB02CDF694F", 0) == 1)
      iprintlnbold("_encstr_83B01467751173C57ECF61751FC21DBAA94E083B5F22" + var_0);

    wait 12.0;
    add_to_emp_drone_target_list(var_4);

    if(istrue(level.hostskipburndownhigh._id_12ABE)) {
      add_rider_to_decho(1, level.hostskipburndownhigh.instant_revive_buffer);
      wait 3.0;
      var_11 scripts\cp_mp\killstreaks\airstrike::game_end_watcher(var_0, 1, 1);

      if(getdvarint("_encstr_A9A726B673DBFEDD82D13048DA5B9370D31535A0DC7B833FEBFA384092B941094B954CB02CDF694F", 0) == 1)
        iprintlnbold("_encstr_93971D0A215AFD237187604558D6C52E673AFD4306660826CA5AE7DB254B6A" + var_0);

      wait 12.0;
      add_to_emp_drone_target_list(var_4);
      wait 3.0;
    }
  }

  level.hostskipburndownhigh.instant_revive_buffer = undefined;
  level.hostskipburndownhigh._id_12ABE = undefined;
  level.hostskipburndownhigh._id_123AD = undefined;
}

add_player_to_focus_fire_attacker_list() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");

  if(level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    level waittill("_encstr_B4DE144C93BE1B139960FA1B5933D1FA98DED59B91CD");

  var_0 = add_scriptable_setup();

  if(!var_0) {
    return;
  }
  add_to_fulton_actors();
  add_stealth_logic_to_group();
}

add_scriptable_setup() {
  if(level.hostskipburndownhigh.intensity == 0 || level.hostskipburndownhigh.intensity == 1) {
    if(getdvarint("_encstr_BD0D3062D128E79296172F274DBD6A1910F81FADAB90721AED1F272FA1F0024D18431779A1083F32433F370789836B811029", 0) != 1)
      return 0;

    level.hostskipburndownhigh.intensity = 2;
  }

  if(level.hostskipburndownhigh.intensity == 2) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9187111BED373AB0D2B9DAB2B98EBED9B77D98"] = "_encstr_A3BE10013555A00DC98399939732F781B99A";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F87111BDBDC3AB02DCDAD59CD47D79DBDBE46"] = "_encstr_BEBE10417515E04D8943595357F23741FADA";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3871191256EA0B79AABC3EB937390F837B113"] = "_encstr_8FBE101A80BDDB0BE1C14051DF680227FE73";
  } else if(level.hostskipburndownhigh.intensity == 3) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9187111BED373AB0D2B9DAB2B98EBED9B77D98"] = "_encstr_B8D51068F9E5EE4371910BCFB3BD8AB7E683";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F87111BDBDC3AB02DCDAD59CD47D79DBDBE46"] = "_encstr_A7D510B08D56931DBE1CD0B0DCB28C7D9160";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3871191256EA0B79AABC3EB937390F837B113"] = "_encstr_ACD510491189EB03A7908A12603B6AA7ABA7";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9387118DEDB9A316B4B9ADACB91DEBCEBDFAD0"] = "_encstr_A6D5100B3659C98EFAC10D0BCD5923F586C0";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A187119A0A684BFAD9B2F3EF5848991850CF1D"] = "_encstr_93DD1416C656393ABE8E9D7DE6E8B0D196ED73FA4C81";
  } else if(level.hostskipburndownhigh.intensity == 4) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9187111BED373AB0D2B9DAB2B98EBED9B77D98"] = "_encstr_9ACF10F6997B93CC56406B574049C3096B0F";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F87111BDBDC3AB02DCDAD59CD47D79DBDBE46"] = "_encstr_95CF102CC6959C8ED7073416B95999FA4606";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3871191256EA0B79AABC3EB937390F837B113"] = "_encstr_84CF10F1C58570DD193329C3C74286D10B4A";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9387118DEDB9A316B4B9ADACB91DEBCEBDFAD0"] = "_encstr_8823149F357ACDAB7FD7B888978A8309225A0508DA87";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A187119A0A684BFAD9B2F3EF5848991850CF1D"] = "_encstr_93CF10DB744F80357703F0D9DB774E31F380";
  } else if(level.hostskipburndownhigh.intensity == 5) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9187111BED373AB0D2B9DAB2B98EBED9B77D98"] = "_encstr_8BE810136382EE78BFFAE0D9226DB2B03FFA";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F87111BDBDC3AB02DCDAD59CD47D79DBDBE46"] = "_encstr_A7E8108863D873B3203A5B2BDEC1CA67EEC2";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3871191256EA0B79AABC3EB937390F837B113"] = "_encstr_A5810D2E41B35BF46EA8172F598B88";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9387118DEDB9A316B4B9ADACB91DEBCEBDFAD0"] = "_encstr_8BE810136382EE78BFFAE0D9226DB2B01FFA";
    var_0 = "_encstr_B40101";
    var_1 = randomintrange(0, 4);

    switch (var_1) {
      case 0:
        var_0 = "_encstr_A1E810AB0171E054E128F987CB4933C74A4F";
        break;
      case 1:
        var_0 = "_encstr_B8E8109EF103EBA43E58436F68513CE14B37";
        break;
      case 2:
        var_0 = "_encstr_97E8104FA861A29367E7FCB64ECB4F47C3B2";
        break;
      case 3:
        var_0 = "_encstr_9BE8104A3893CA83A67F28599689CAD97172";
        break;
      default:
        var_0 = "_encstr_A1E810AB0171E054E128F987CB4933C74A4F";
        break;
    }

    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A187119A0A684BFAD9B2F3EF5848991850CF1D"] = var_0;
  } else
    return 0;

  if(getdvarint("_encstr_9B5B2416768B17E9D2E788F03B0C41B3B21D85100B011530BC0F80F8DB0FFBC709470BA8269A", 0) == 1) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9187111BED373AB0D2B9DAB2B98EBED9B77D98"] = "_encstr_8BE810136382EE78BFFAE0D9226DB2B03FFA";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F87111BDBDC3AB02DCDAD59CD47D79DBDBE46"] = "_encstr_A7E8108863D873B3203A5B2BDEC1CA67EEC2";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3871191256EA0B79AABC3EB937390F837B113"] = "_encstr_8BE810136382EE78BFFAE0D9226DB2B01FFA";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9387118DEDB9A316B4B9ADACB91DEBCEBDFAD0"] = "_encstr_BEB21013F84BB97943A007FC9907D78FFB6A";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A187119A0A684BFAD9B2F3EF5848991850CF1D"] = "_encstr_A1E810AB0171E054E128F987CB4933C74A4F";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A787118DDBB9471696736BB2378ED7CEF6F56C"] = "_encstr_B8E8109EF103EBA43E58436F68513CE14B37";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB8711D8DECD8E162DE6B5B29B1D7DECDEFAB9"] = "_encstr_B40101";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_968711D8B7B9A32CA573DACAE63AEB67BDFAE0"] = "_encstr_B40101";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87871140AAC58949CF1EC1CDE64376456D311A"] = "_encstr_B40101";
  }

  return 1;
}

add_to_fulton_actors() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");
  var_0 = getdvarint("_encstr_8E15286B32CB50E86AAF2F3FB6D3C803134A21B02B9B7E4803673707AC7138D82F72B978C257206B1C4E", 90);
  var_1 = getdvarint("_encstr_921528A397D391C29E8F328AF214D2A0D85F513AB301EB688B804F50180904F7799AA988B6C0295502D0", 360);
  var_2 = getdvarint("_encstr_AB232D8F8706C95AA0C6FEC5D8A86162D0035F0341AFA31FF8A8F6CD7019BE5A20B9C783D35339C730F1AA92C898F5", -1);
  var_3 = var_1;

  if(var_2 != -1)
    var_3 = var_2;
  else
    var_3 = randomintrange(var_0, var_1);

  if(getdvarint("_encstr_9B5B2416768B17E9D2E788F03B0C41B3B21D85100B011530BC0F80F8DB0FFBC709470BA8269A", 0) == 1 && level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    level waittill("_encstr_856510879DB3E03139D5D210B1398E51EF01");
  else
    wait(var_3);
}

add_stealth_logic_to_group() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");

  while(istrue(level.hostskipburndownhigh._id_123AD))
    waitframe();

  level.hostskipburndownhigh.monitorexitbutton = 1;
  add_practice_bots(1);
  add_struct();
  add_to_fulton_actor_players();
  wait 4.0;
  var_0 = 0;

  if(getdvarint("_encstr_9B5B2416768B17E9D2E788F03B0C41B3B21D85100B011530BC0F80F8DB0FFBC709470BA8269A", 0) == 1) {
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_9187111BED373AB0D2B9DAB2B98EBED9B77D98");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_8F87111BDBDC3AB02DCDAD59CD47D79DBDBE46");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_A3871191256EA0B79AABC3EB937390F837B113");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_87B405E01221E9", "_encstr_9387118DEDB9A316B4B9ADACB91DEBCEBDFAD0", undefined, 1);
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_A187119A0A684BFAD9B2F3EF5848991850CF1D");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_A787118DDBB9471696736BB2378ED7CEF6F56C");
    var_0 = var_0 + 1.0;
    thread elevatordoors(var_0);
  } else {
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_9187111BED373AB0D2B9DAB2B98EBED9B77D98");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_8F87111BDBDC3AB02DCDAD59CD47D79DBDBE46");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_A3871191256EA0B79AABC3EB937390F837B113");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_9387118DEDB9A316B4B9ADACB91DEBCEBDFAD0");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_A187119A0A684BFAD9B2F3EF5848991850CF1D");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_A787118DDBB9471696736BB2378ED7CEF6F56C");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_AB8711D8DECD8E162DE6B5B29B1D7DECDEFAB9");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_968711D8B7B9A32CA573DACAE63AEB67BDFAE0");
    var_0 = var_0 + add_to_bomb_detonator_waiting_for_pick_up_array("_encstr_8460054D166B5F", "_encstr_87871140AAC58949CF1EC1CDE64376456D311A");
  }

  wait(var_0);
  add_to_fulton_actor_players();
  wait 4.0;
  setomnvarforallclients("_encstr_A6B50D67F85EDA9B7F75538FE801C3", 0);
  level.hostskipburndownhigh.monitorexitbutton = undefined;
}

add_to_bomb_detonator_waiting_for_pick_up_array(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");

  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_1]) || game["_encstr_B2DA070A5F8BAB87AF"][var_1] == "_encstr_B40101")
    return 0.0;

  var_4 = "_encstr_8E750850F3A1BD3337D7" + var_0 + game["_encstr_B2DA070A5F8BAB87AF"][var_1];
  var_4 = tolower(var_4);
  var_5 = lookupsoundlength(var_4, 1) / 1000;
  var_5 = var_5 + 1;
  var_6 = undefined;

  if(isDefined(var_2))
    var_6 = var_2;
  else
    var_6 = level.players;

  foreach(var_8 in var_6) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(!istrue(var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) || istrue(var_3))
      var_8 queuedialogforplayer(var_4, var_1, var_5);
  }

  return var_5;
}

add_to_fulton_actor_players() {
  foreach(var_1 in level.players) {
    if(add_spawn_disable_struct(var_1))
      var_1 playsoundtoplayer("_encstr_9AC515AB96BE8993DE16911B2C37A3F5DD0B279B96CD76", var_1);
  }
}

add_struct() {
  var_0 = max(0, level.hostskipburndownhigh.intensity - 1);
  setomnvarforallclients("_encstr_A6B50D67F85EDA9B7F75538FE801C3", int(var_0));

  foreach(var_2 in level.players) {
    if(!add_spawn_disable_struct(var_2))
      var_2 setclientomnvar("_encstr_A6B50D67F85EDA9B7F75538FE801C3", 0);
  }
}

elim_hud() {
  if(istrue(level.hostskipburndownhigh.monitorexitbutton))
    self setclientomnvar("_encstr_A6B50D67F85EDA9B7F75538FE801C3", 0);
}

elevatordoors(var_0) {
  if(getdvarint("_encstr_99FE1BEA59A06F0A1E9F97AFD5C5E281A860E73513080A9275E7AFB729", 0) == 0 && !istrue(level.hostskipburndownlow)) {
    return;
  }
  if(getdvarint("_encstr_9B5B2416768B17E9D2E788F03B0C41B3B21D85100B011530BC0F80F8DB0FFBC709470BA8269A", 0) != 1) {
    return;
  }
  if(!isDefined(level.hostskipburndownhigh._id_146F9)) {
    level.hostskipburndownhigh._id_146F9 = scripts\engine\utility::play_loopsound_in_space("_encstr_95061E4FDAC47D3A0BDAB27BD9594EBEE416325ABDD789B0D8B59DC9F6D5E623", (0, 0, 0));
    level.hostskipburndownhigh._id_146F9 unmarkkeyframedmover(1);
    level.hostskipburndownhigh._id_146F9 hide();
  }

  foreach(var_2 in level.players) {
    if(!add_spawn_disable_struct(var_2)) {
      continue;
    }
    level.hostskipburndownhigh._id_146F9 showtoplayer(var_2);
    var_2 thread add_to_mine_list(var_0);
  }
}

add_to_mine_list(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_A2B10C6E83C2BBB94BF65B4C2D95", var_0);

  if(!isDefined(level.hostskipburndownhigh._id_146F9)) {
    return;
  }
  level.hostskipburndownhigh._id_146F9 hidefromplayer(self);

  if(istrue(level.hostskipburndownhigh.monitorexitbutton) && !add_spawn_disable_struct(self))
    self setclientomnvar("_encstr_A6B50D67F85EDA9B7F75538FE801C3", 0);
}

elevator_trigger_wait_for_spawn() {
  if(!isDefined(level.hostskipburndownhigh._id_146F9)) {
    return;
  }
  level.hostskipburndownhigh._id_146F9 delete();
  level.hostskipburndownhigh._id_146F9 = undefined;
}

add_spawn_disable_struct(var_0) {
  var_1 = istrue(var_0.delay_enter_combat_after_investigating_grenade);
  var_2 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
  var_3 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal();
  return !var_1 && !var_2 && !var_3;
}

add_rider_to_decho(var_0, var_1) {
  var_2 = -1;
  var_3 = "_encstr_B40101";
  var_2 = randomintrange(0, 3);

  switch (var_2) {
    case 0:
      var_3 = "_encstr_8F9105D863B3AF";
      break;
    case 1:
      var_3 = "_encstr_BD71053AEBD72F";
      break;
    case 2:
      var_3 = "_encstr_A37005CEC670BE";
      break;
    default:
      var_3 = "_encstr_8F9105D863B3AF";
      break;
  }

  if(isDefined(var_1))
    var_3 = var_1;

  level.hostskipburndownhigh.instant_revive_buffer = var_3;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_B40101";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_B40101";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_B40101";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_B40101";

  switch (var_3) {
    case "_encstr_8F9105D863B3AF":
      var_2 = randomintrange(0, 5);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_AA271012180753BBA0954969EB193B87F262";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_822710E9046BBF783CDFB930EF4932AF27FA";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_B40101";
          break;
      }

      break;
    case "_encstr_BD71053AEBD72F":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_889E169BE84E85332DCDB3FAB9D12758CD9D56C9DCAF8981";
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_B40101";
          break;
      }

      break;
    case "_encstr_A37005CEC670BE":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_889E169BE84E85332DCDB3FAB9D12758CD9D56C9DCAF8981";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_B65F159BE839B0332DDCD9EBDCDD2C93DAA5CD3BF54C60";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_B40101";
          break;
      }

      break;
    default:
      break;
  }

  switch (var_3) {
    case "_encstr_8F9105D863B3AF":
      var_2 = randomintrange(0, 6);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_87E613D6D29BCD5A36CABED2DC26DBABB9C8FAC460";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_8FC31CA51B501277E171112AD945B3CE608F233FBD40DC5319699A012B3F";
          break;
        case 2:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_99C31CA54BE7336180386793209B2E7A89C8AE5DA0652AA248D08357D25B";
          break;
        case 3:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_952014D919BF1BAB65D271F08AFB6DD16BBDD55839DA";
          break;
        case 4:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_8A20146B4B376E4B36B2FA1BB0579B360D95C8D7C881";
          break;
        case 5:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_81201438F723239B826798197E4BCD69907FF8317698";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_B40101";
          break;
      }

      break;
    case "_encstr_BD71053AEBD72F":
      var_2 = randomintrange(0, 3);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_8B4E1537E82716CCB4E676BEB1EDAD5BCACDB1B27D4C0C";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_960A14287033C79A88921A2033A8E5A7EDE8FA58BBBF";
          break;
        case 2:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_937818E68E4E859996DCD9FAEE2B0B07BDCDFA9193BDE0F59806";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_B40101";
          break;
      }

      break;
    case "_encstr_A37005CEC670BE":
      var_2 = randomintrange(0, 2);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_95931ABB1D4EB353DAD0AFA19FE5F7FFD202C7F355EB634FE2863E81";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_A13118CEA58BC79ACFD2B761F32F7AE22D2DDF9AB0BB10B98199";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_B40101";
          break;
      }

      break;
    default:
      break;
  }

  switch (var_3) {
    case "_encstr_8F9105D863B3AF":
      var_2 = randomintrange(0, 3);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_A95A105BB46E6ED2C62BD75B96CDE6EB13C0";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_915A107882CAFF30934D808129873BDFE27F";
          break;
        case 2:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_AB5A10605A077E88A5DD0F73C94A10D0BE67";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_B40101";
          break;
      }

      break;
    case "_encstr_BD71053AEBD72F":
      var_2 = randomintrange(0, 9);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_968613DC3AC90BCCA573CEBE13AF6D96B1637D9803";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_A3F9139F2CE29160D84D04D97AB7AAB0A5C4816630";
          break;
        case 2:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_AF7D1760695ADFA2A05697CFA5186122C16021431DDFE123FA";
          break;
        case 3:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_9587113FAC4AD8FC6F22515ECA2723E8A94101";
          break;
        case 4:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_8C8711035523EFFFB32822B970FB7493FE1EC8";
          break;
        case 5:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_9587113FAC4AD8FC6F22515ECA2723E8A94301";
          break;
        case 6:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_92A611BB931B7FF89CAE770FC0C4303E077F5B";
          break;
        case 7:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_BD3519CD47390B3396DC9DBEB557361D960E1B56BEA12DE8AF130C";
          break;
        case 8:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_A7791BBB286DDE1B50401737E6DB8366ED184223685FD7074BB827515F";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_B40101";
          break;
      }

      break;
    case "_encstr_A37005CEC670BE":
      var_2 = randomintrange(0, 6);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_968613DC3AC90BCCA573CEBE13AF6D96B1637D9803";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_AAAC1B703B8339A9330377A71D614C777A6747250B897160CF78F7C701";
          break;
        case 2:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_A3F9139F2CE29160D84D04D97AB7AAB0A5C4816630";
          break;
        case 3:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_8D30136EA3398566D2CDB3AF99EB5BA58D1B7D1306";
          break;
        case 4:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_9587113FAC4AD8FC6F22515ECA2723E8A94101";
          break;
        case 5:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_8C8711035523EFFFB32822B970FB7493FE1EC8";
          break;
        case 6:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_9587113FAC4AD8FC6F22515ECA2723E8A94301";
          break;
        case 7:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_BE8816F3BB20B7ACC34841C7A006F8380BF839674B7146A0";
          break;
        case 8:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_AFB01A37A34E2CCCD2DC3BAF9BD1C9C23776AC9CAF19B7DDDC7D1318";
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93"] = "_encstr_B40101";
          break;
      }

      break;
    default:
      break;
  }

  switch (var_3) {
    case "_encstr_8F9105D863B3AF":
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_B40101";
      break;
    case "_encstr_BD71053AEBD72F":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_82EA1793652E1BF2287D4C7104706FB027D363CA433099F6E7";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_857015E6D19358CCD273CEF5392BCAE6B385EC2BEBC419";
          level.hostskipburndownhigh._id_12ABE = 1;
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_B40101";
          break;
      }

      break;
    case "_encstr_A37005CEC670BE":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_82EA1793652E1BF2287D4C7104706FB027D363CA433099F6E7";
          break;
        case 1:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_8470156ED19CC2CC2D9BECF54E95AC37B3B03BCA7D1306";
          level.hostskipburndownhigh._id_12ABE = 1;
          break;
        default:
          game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_B40101";
          break;
      }

      break;
    default:
      break;
  }

  if(istrue(var_0)) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_860B0DE77462F0C4570A0936D3030D"] = "_encstr_B40101";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E7310E833EABBB127E63C38C23F791F528A"] = "_encstr_B40101";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDD0E67419EB2C6D058575173081B1B"] = "_encstr_B40101";
  }
}

add_to_ents_to_clean_up(var_0) {
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");
  var_1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "_encstr_860B0DE77462F0C4570A0936D3030D", var_0);

  if(var_1 != 0)
    wait(var_1 + 3.0);

  add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "_encstr_8E7310E833EABBB127E63C38C23F791F528A", var_0);
}

add_to_emp_drone_target_list(var_0) {
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");
  var_1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "_encstr_A7670FCD8E9CB0CCD2E69DD785331DAC93", var_0);

  if(var_1 != 0)
    wait(var_1 + 3.0);

  var_1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "_encstr_8CDD0E67419EB2C6D058575173081B1B", var_0);

  if(var_1 != 0)
    wait(var_1);
}

add_practice_bots(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_814713250D49E14805E8C1E7CC68E08A3ABB20D493");
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = level.players;

  var_3 = gettime();
  var_4 = var_3 + 10000;

  while(var_3 < var_4) {
    waitframe();
    var_5 = 0;

    foreach(var_7 in var_2) {
      if(!isDefined(var_7)) {
        continue;
      }
      if(!var_7 _meth_87C3()) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      var_3 = gettime();
      continue;
    }

    break;
  }
}