/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_warp_door.gsc
***********************************************/

init() {
  setdvarifuninitialized("_encstr_ACCD179B1B27AF4C9CAFEE16278323BDDE27AF5BB03CCD5DB6", 100);
  setdvarifuninitialized("_encstr_AD521760D6C2CF1655E148D7B0C32DC0604A88331B73D83A0B", 4);
  setdvarifuninitialized("_encstr_8A461CF8F69877BAC67F3B9832339B57D7661CDB19B7936BDB1F57B3C8AD", 10);
  setdvarifuninitialized("_encstr_8CA81BA770232F529DD05BD6AE41E8D72840D777C0FC586A8D4D24CD1D", 30);
  setdvarifuninitialized("_encstr_ADBE1A20CB937FE2C297E3B983F311CAC0BE0DF3DD0860376CED27DF", 1);
  setdvarifuninitialized("_encstr_A2381C4E2ED34FA19A9F60D803B03D776A12DF5945BAD7AF794FC8B067EC", 0);
  setdvarifuninitialized("_encstr_922E1F3FBB4A29FE033153998B63B5F0A502F7832C35B93E67EBCB81A3B7EDD0FA", 1);
  setdvarifuninitialized("_encstr_8CDA1C676F9E51C2087E53DE33F02CAAF8A513FFDB4D0A9DB0810E65C968", 0);
  scripts\engine\scriptable::_id_12F5B("_encstr_86C709978B7E432440D8B2", ::_id_1442E);
  level._effect["_encstr_A35B0D9F83063B6710C0FD82FE406E"] = loadfx("_encstr_842733EC993CCBB4BB1C7D139397ECC2B6560ED82C2FF293592323DBED4ECB3B33E17D8927BE27CA2346F6EDE4FABBC2E483EB5A9B");
  level._effect["_encstr_8F8A0E8F07039B19CCFF2FD2698D15EC"] = loadfx("_encstr_998A344092E8A7D0DF30A0265296D983150AE8189AC0EF8B4F9435A8579B88653F43191003918D2123BC489022074B13622BA1F0EBF3");

  if(getdvarint("_encstr_ADBE1A20CB937FE2C297E3B983F311CAC0BE0DF3DD0860376CED27DF", 1))
    thread _id_136B0();

  _encstr_AC75328B0AE228D33443DE90AF5D1F611F60D4AF89756F3D4DA249F3EDA9F011F050CB9EED54DAE98510614768D7235B76DC639E::init();
  thread initdropbagvo();
  thread zombiepowersenabled();
  thread zombieregendelayscaleoutgas();

  if(getdvarint("_encstr_8CDA1C676F9E51C2087E53DE33F02CAAF8A513FFDB4D0A9DB0810E65C968", 0)) {
    _encstr_AC75328B0AE228D33443DE90AF5D1F611F60D4AF89756F3D4DA249F3EDA9F011F050CB9EED54DAE98510614768D7235B76DC639E::supersbyextraweapon();
    thermiteboltburnout();
  }
}

thermiteboltburnout() {
  level._effect["_encstr_849E15481085EB81C398281878384B4AF958E13A2ABB7B"] = loadfx("_encstr_8CD3377B28E9DDB7E31B5F9AD6E547961B98A35288839583992D6C9F60F31E1BA588D92A78773A17D198748708DB1724FFC8E262A9E5B66BEB");
  level._effect["_encstr_96241BA7988B4249F79037B207FBABC21305FE2FBF6F3003A2437D2482"] = loadfx("_encstr_83083D035158B70234F9FFF395F02A3128993A0D2938CFEB05691BCF8706D67ED8C2791623B15A52ED0703D79F2E19A828C96F9D3E901FCA3D3153C7F5D583");
  level._effect["_encstr_93D416F853F31B7E2060E023AFD8442F80C6EF602B0F7F65"] = loadfx("_encstr_97E93813F8C2FF4237C33176CE5F7A79881883E3685AA7BB7BF5C72DB8CDB616B158C75368F6323241AFCF2590B589C03B28A7DB692990DA87AD");
  level._effect["_encstr_95A5197FA8EBD85979B7655A60099395517867E760E10CF24BA8AF"] = loadfx("_encstr_962D3BB3660F5E96EE70D7264ECB3B58B695C1C6C2E55EC92B4632BDB7E4BCB3663CAF89C9FAC92B19F591BDF639BED0DDCACAB9FADCB62BC6A10B73C8");
}

get_bulletwhizby_alias() {
  if(!isDefined(level.audio_start_obj_room_fires)) {
    level.audio_start_obj_room_fires = [];
    return 1;
  }

  if(level.audio_start_obj_room_fires.size < getdvarint("_encstr_ACCD179B1B27AF4C9CAFEE16278323BDDE27AF5BB03CCD5DB6", 100))
    return 1;

  return 0;
}

_id_136AF(var_0, var_1, var_2) {
  if(!get_bulletwhizby_alias()) {
    return;
  }
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 setModel("_encstr_A18820EB6FE10B0ADDA1E1C7D87899B813AD43FFF271F85F63C919418B5361830C4F");
  var_3.angles = var_1;
  var_3.usable = 1;
  var_3 cargobaywatch();

  if(getdvarint("_encstr_91F41E7BB64B7F661D099BF24831D70740A6D8E159D0976ED32112CAD071D7E3", 1))
    var_3 _id_13288(2);
  else
    var_3 _id_13288(1);

  if(isDefined(var_2))
    var_3.doorid = var_2;

  level.audio_start_obj_room_fires[level.audio_start_obj_room_fires.size] = var_3;

  if(!istrue(level.br_circle_disabled))
    var_3 thread _id_1449A();

  return var_3;
}

_id_13288(var_0) {
  var_1 = relic_nuketimer_waitforobjectives();
  var_2 = "_encstr_B40101";

  if(isDefined(var_1.launcherfired)) {
    var_2 = var_1 getscriptablepartstate("_encstr_86C709978B7E432440D8B2");

    if(validateplundereventtype(var_1.launcherfired))
      var_2 = getsubstr(var_2, 8, var_2.size);
  } else
    var_2 = "_encstr_A350079E35DACF8944";

  var_3 = var_2;
  var_1.launcherfired = var_0;

  if(validateplundereventtype(var_1.launcherfired))
    var_3 = "_encstr_BD4C09EBE31F73AA900997" + var_2;

  if(var_1.launcherfired != 2 && !isDefined(var_1._id_13A98))
    thread _id_136A0(var_1);

  var_1 setscriptablepartstate("_encstr_86C709978B7E432440D8B2", var_3);
}

_id_13289() {
  _id_13288(5);
}

_id_136A0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 0.2;
  var_1 = var_0.origin + anglestoleft(var_0.angles) * 25 + anglesToForward(var_0.angles) * -5 + (0, 0, 16);
  var_0._id_13A98 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1, 0, 16, 32);
  var_0._id_13A98._id_121D7 = var_0;
  scripts\mp\utility\trigger::makeenterexittrigger(var_0._id_13A98, ::_id_13A99, undefined);
}

_id_13A99(var_0, var_1) {
  if(isDefined(var_1.should_wait_before_spawn_chopper_boss)) {
    return;
  }
  var_2 = ["_encstr_AAD918E383E93A929539211940898710089D6090B84D6857EF3B", "_encstr_8ED81BDB33CF43954B31F19863191D87A84AEFB0551093DBD428B1AFCF", "_encstr_AB35167953418628AD11E159C5B7A0482A67E7E79BA9F702", "_encstr_8C5D1932F0BE319CADD7584636FA93B285322F7D1DA12DB97D98C0"];
  var_3 = ["_encstr_889A1C8C87AF9893ADF59BA336FAC6F63927B21B3ABE0B369667CAD71318", "_encstr_84C41BD520016A53C85110B57E3EEFEF33C382D7D95F92A3C803A1BA6F", "_encstr_A1F71C3C60DF4165581713ACCA3F388A96A1BF63F1A2A8C1BEB977305EF3", "_encstr_9B631C8C1911763B4116334B79B0BB6E309F05023F88BC077B89AAE10B5F", "_encstr_AD3A1B8AC2605B4AB05F9B843FF955CF14F98202E9D80745D803BFC971", "_encstr_81D41B8C0FFA3127D67D9B1D1BAFADD53399632B19D77B38569BEB130C", "_encstr_97C31EB5F0F7C175CD6938088269137B7B96C9BD444F2B93B6A3B010FB31631B"];
  var_1.should_wait_before_spawn_chopper_boss = 1;

  if(var_1._id_121D7 unload_vehicles_on_weapons_free_thread())
    playsoundatpos(var_1.origin, scripts\engine\utility::random(var_3));
  else
    playsoundatpos(var_1.origin, scripts\engine\utility::random(var_2));
}

runjoininprogresstimeout() {
  return relic_nuketimer_waitforobjectives().launcherfired;
}

relic_nuketimer_waitforobjectives() {
  var_0 = self;

  if(!isDefined(var_0.entity))
    var_0 = var_0 getlinkedscriptableinstance();

  return var_0;
}

_id_13281() {
  level._id_145A7 = [];
  level._id_145A7[0] = [1.0, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_9B220634456A5747", "_encstr_A12309057F2275CBB14A51", "_encstr_8B410851CDC7EDE732ED", "_encstr_883E0978CAE2A1689B3161", "_encstr_9BD70814BBB0A55B35C3"];
  level._id_145A7[1] = [0.3, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095"];
  level._id_145A7[2] = [0.3, "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1"];
  level._id_145A7[3] = [0.3, "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7"];
  level._id_145A7[4] = [1.0, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7"];
  level._id_145A7[5] = [0.4, "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_883E0978CAE2A1689B3161"];
  level._id_145A7[6] = [0.4, "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1"];
  level._id_145A7[7] = [0.4, "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_A12309057F2275CBB14A51"];
  level._id_145A7[8] = [0.4, "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_9BD70814BBB0A55B35C3"];
  level._id_145A7[9] = [0.5, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_883E0978CAE2A1689B3161"];
  level._id_145A7[10] = [0.5, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_8B410851CDC7EDE732ED"];
  level._id_145A7[11] = [0.5, "_encstr_AAAB06A89862980B", "_encstr_A77808BB284B9F27D3C1", "_encstr_A12309057F2275CBB14A51", "_encstr_883E0978CAE2A1689B3161"];
  level._id_145A7[12] = [0.5, "_encstr_993D09FA68C1D1B7D0C095", "_encstr_BD0208BE67B903152D08", "_encstr_9BD70814BBB0A55B35C3"];
  level._id_145A7[13] = [1.0, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_9B220634456A5747", "_encstr_A12309057F2275CBB14A51", "_encstr_8B410851CDC7EDE732ED", "_encstr_9BD70814BBB0A55B35C3"];
  level._id_145A7[14] = [0.6, "_encstr_A19407CB0D1807F441", "_encstr_AAAB06A89862980B", "_encstr_BAC106FFE6F8C842", "_encstr_883E0978CAE2A1689B3161"];
  level._id_145A7[15] = [0.6, "_encstr_883009BD28232B4B688B98"];
  level._id_145A7[16] = [0.6, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_8B410851CDC7EDE732ED", "_encstr_883E0978CAE2A1689B3161", "_encstr_9BD70814BBB0A55B35C3"];
  level._id_145A7[17] = [1.0, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_9B220634456A5747", "_encstr_883E0978CAE2A1689B3161", "_encstr_9BD70814BBB0A55B35C3"];
  level._id_145A7[18] = [1.0, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_9B220634456A5747", "_encstr_A12309057F2275CBB14A51", "_encstr_9BD70814BBB0A55B35C3"];
  level._id_145A7[19] = [1.0, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_9B220634456A5747", "_encstr_A12309057F2275CBB14A51", "_encstr_8B410851CDC7EDE732ED"];
  level._id_145A7[20] = [1.0, "_encstr_883009BD28232B4B688B98", "_encstr_A19407CB0D1807F441", "_encstr_993D09FA68C1D1B7D0C095", "_encstr_AAAB06A89862980B", "_encstr_BD0208BE67B903152D08", "_encstr_A77808BB284B9F27D3C1", "_encstr_BAC106FFE6F8C842", "_encstr_81B70AD2BFC95347B06893A7", "_encstr_9B220634456A5747", "_encstr_A12309057F2275CBB14A51", "_encstr_8B410851CDC7EDE732ED", "_encstr_883E0978CAE2A1689B3161", "_encstr_9BD70814BBB0A55B35C3"];
}

unset_vehicle_only_wave() {
  var_0 = self;

  if(!isDefined(var_0._id_14728))
    var_0._id_14728 = "_encstr_8BBA05185F8B99";

  var_1 = getdvarint("_encstr_BEF0161A183B514228C7C84643D0B3E002E62113EFF7195D", 0);
  var_2 = level._id_145A7[var_1];
  var_3 = var_2[0];

  for(var_4 = 1; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(var_5 == var_0._id_14728) {
      if(randomfloat(1.0) > var_3)
        return 0;

      return 1;
    }
  }

  return 0;
}

latetoinfil() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0) || istrue(var_0.dead)) {
    return;
  }
  var_0.dead = 1;

  while(istrue(var_0.tv_station_fastrope_one_infil_rider_start_targetname))
    waitframe();

  if(isDefined(var_0._id_13A98))
    var_0._id_13A98 delete();

  var_0 notify("_encstr_A39B0FD3E347B920DA5AC0EE786B4BBD3B");
  var_0.entity.usable = 0;
  var_0.entity notify("_encstr_85BD111B608D7AF3B0E022170D99E702D3B812");
  level.audio_start_obj_room_fires = scripts\engine\utility::array_remove(level.audio_start_obj_room_fires, var_0 getscriptablelinkedentity());
  var_0 setscriptablepartstate("_encstr_86C709978B7E432440D8B2", "_encstr_A111068033FC7541");

  while(var_0 getscriptablepartstate("_encstr_86C709978B7E432440D8B2") != "_encstr_84670547C3E9F4")
    waitframe();

  var_0 getscriptablelinkedentity() delete();
}

_id_136B0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 5;
  _encstr_8A312CFE2B8360B14B6B1A6B73B547B917D5857390676B47B2127889CA7D1F93877480E6194B903F9D1B22409316::traceresults();
  _id_13281();

  foreach(var_1 in level.disable_super_in_turret._id_1442C) {
    var_2 = _id_136AF(var_1.origin, var_1.angles, var_1.id);

    if(!var_2 unset_vehicle_only_wave()) {
      var_2 = var_2 getlinkedscriptableinstance();
      var_2 latetoinfil();
    }
  }

  if(isDefined(level._id_1442D))
    level thread[[level._id_1442D]]();
}

cargobaywatch() {
  var_0 = self;

  if(!isDefined(level.calloutglobals.calloutzones))
    level.calloutglobals.calloutzones = getEntArray("_encstr_B8EE102BE0F1C1E37B182D69FC0F1A9D5828", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!level.calloutglobals.calloutzones.size) {
    return;
  }
  var_1 = var_0 getscriptablelinkedentity();

  foreach(var_3 in level.calloutglobals.calloutzones) {
    if(var_1 istouching(var_3)) {
      var_0._id_14728 = var_3.script_noteworthy;
      return;
    }
  }

  var_0._id_14728 = "_encstr_8BBA05185F8B99";
}

initdropbagvo() {
  var_0 = "_encstr_95C026550FD0EF76CDA05AE270E5216730F8B4C2288DB3BD8F50D1CA881FE673A8D0265B10890F03";
  var_1 = tablelookupgetnumrows(var_0);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = [];
    var_3[0] = (int(tablelookupbyrow(var_0, var_2, 1)), int(tablelookupbyrow(var_0, var_2, 2)), int(tablelookupbyrow(var_0, var_2, 3)));
    var_3[1] = (int(tablelookupbyrow(var_0, var_2, 4)), int(tablelookupbyrow(var_0, var_2, 5)), int(tablelookupbyrow(var_0, var_2, 6)));
    var_3[2] = (int(tablelookupbyrow(var_0, var_2, 7)), int(tablelookupbyrow(var_0, var_2, 8)), int(tablelookupbyrow(var_0, var_2, 9)));
    var_3[3] = (int(tablelookupbyrow(var_0, var_2, 10)), int(tablelookupbyrow(var_0, var_2, 11)), int(tablelookupbyrow(var_0, var_2, 12)));

    foreach(var_5 in var_3) {
      var_6 = 500;
      _encstr_8EDD2B8782956F91793A38D0131E9C9BB88F43E04020974FC220B1066D7A904B3A58F75B61491F3C33D57CBE30::little_bird_mg_playercontrolmg(var_5, var_6);
    }
  }
}

zombiepowersenabled() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\mp\flags::levelflag("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  while(!isDefined(level.disable_super_in_turret))
    waitframe();

  var_0 = "_encstr_95C026550FD0EF76CDA05AE270E5216730F8B4C2288DB3BD8F50D1CA881FE673A8D0265B10890F03";
  var_1 = tablelookupgetnumrows(var_0);
  level.hud_set_progress = [];
  _encstr_8A312CFE2B8360B14B6B1A6B73B547B917D5857390676B47B2127889CA7D1F93877480E6194B903F9D1B22409316::teleport_reference_juggmaze();
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = spawnStruct();
    var_4.id = int(tablelookupbyrow(var_0, var_3, 0));
    var_4.ignore_spawn_scoring_pois = [];
    var_4.ignore_spawn_scoring_pois[0] = (int(tablelookupbyrow(var_0, var_3, 1)), int(tablelookupbyrow(var_0, var_3, 2)), int(tablelookupbyrow(var_0, var_3, 3)));
    var_4.ignore_spawn_scoring_pois[1] = (int(tablelookupbyrow(var_0, var_3, 4)), int(tablelookupbyrow(var_0, var_3, 5)), int(tablelookupbyrow(var_0, var_3, 6)));
    var_4.ignore_spawn_scoring_pois[2] = (int(tablelookupbyrow(var_0, var_3, 7)), int(tablelookupbyrow(var_0, var_3, 8)), int(tablelookupbyrow(var_0, var_3, 9)));
    var_4.ignore_spawn_scoring_pois[3] = (int(tablelookupbyrow(var_0, var_3, 10)), int(tablelookupbyrow(var_0, var_3, 11)), int(tablelookupbyrow(var_0, var_3, 12)));
    var_4.doors = play_sound_countdown(var_0, var_3);
    var_4.doors heli_group_nextspawntime();
    var_4.debug_reach_icbm_launch = int(tablelookupbyrow(var_0, var_3, 19));
    var_4.debug_reach_pipe_room = int(tablelookupbyrow(var_0, var_3, 20));
    var_4.crates = play_smuggler_arriving_vo(var_4);
    var_4.index = var_2;
    var_4.visited = 0;
    var_4.shouldburnfromdamage = 0;
    var_4._id_12699 = [];
    _id_12218(var_4.crates);
    var_5 = getdvarint("_encstr_BE581D37C6E47D31277DDD2C4E3844F6BDE4BE8536D8B7BB94CEB9B74E56B9", 1) == 1;
    var_6 = int(tablelookupbyrow(var_0, var_3, 21)) != 0;
    var_7 = var_5 && var_6;

    if(!var_7) {
      level.hud_set_progress[var_2] = var_4;
      var_2++;
    }
  }

  if(!istrue(level.br_circle_disabled))
    level thread _id_11D01();
}

_id_13D00(var_0) {
  var_0._id_13D02 = 1;

  if(isDefined(var_0.crates) && var_0.crates.size > 0)
    _id_13D01(var_0);
}

play_sound_countdown(var_0, var_1) {
  var_2 = [];

  for(var_3 = 13; var_3 <= 18; var_3 = var_3 + 3) {
    var_4 = (int(tablelookupbyrow(var_0, var_1, var_3)), int(tablelookupbyrow(var_0, var_1, var_3 + 1)), int(tablelookupbyrow(var_0, var_1, var_3 + 2)));

    if(var_4 == (0, 0, 0)) {
      continue;
    }
    var_5 = getentitylessscriptablearrayinradius(undefined, undefined, var_4, 64, "_encstr_B16705D9AFE22E");

    if(!isDefined(var_5[0]) || !var_5[0] scriptableisdoor()) {
      continue;
    }
    var_2[var_2.size] = var_5[0];
  }

  return var_2;
}

_id_13626(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.disable_super_in_turret.hoverjet_watchgameend) {
    if(distance2d(var_3.origin, var_0) <= 35) {
      var_1 = easepower("_encstr_91B0197EAB19832AE039037F61AF83F7F0D0B945A02043E1CE2B1B", var_3.origin, var_3.angles);
      break;
    }
  }

  return var_1;
}

_id_13625(var_0) {
  if(!isDefined(var_0))
    return undefined;

  if(getdvarint("_encstr_922E1F3FBB4A29FE033153998B63B5F0A502F7832C35B93E67EBCB81A3B7EDD0FA", 1) == 0)
    return undefined;

  var_1 = var_0.origin + anglestoleft(var_0.angles) * -45 + (0, 0, -40);
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1, 0, 30, 64);
  var_2 thread _id_11D00();
  return var_2;
}

_id_138D8(var_0) {
  if(getdvarint("_encstr_922E1F3FBB4A29FE033153998B63B5F0A502F7832C35B93E67EBCB81A3B7EDD0FA", 1) == 0) {
    return;
  }
  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2.vindia_assault3))
        var_2.vindia_assault3 delete();
    }
  }
}

_id_11D00() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isPlayer(var_0))
      var_0 dodamage(10000, var_0.origin, self, self, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
  }
}

heli_group_nextspawntime() {
  var_0 = self;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("_encstr_ACAD05F147D03F") != "_encstr_A7C5056BD931D1") {
      continue;
    }
    var_0[var_1] setscriptablepartstate("_encstr_ACAD05F147D03F", "_encstr_96DF07C9F2A22F1A3A");
    var_0[var_1] scriptabledoorfreeze(1);
    var_0[var_1]._id_1199C = _id_13626(var_0[var_1].origin);
    var_0[var_1].vindia_assault3 = _id_13625(var_0[var_1]._id_1199C);
  }
}

_id_12122() {
  var_0 = self;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("_encstr_ACAD05F147D03F") != "_encstr_96DF07C9F2A22F1A3A") {
      continue;
    }
    var_0[var_1] setscriptablepartstate("_encstr_ACAD05F147D03F", "_encstr_BD820A6B5DA4B07E627F3D27");
    var_0[var_1] scriptabledoorfreeze(0);

    if(isDefined(var_0[var_1]._id_1199C))
      var_0[var_1]._id_1199C freescriptable();
  }
}

play_smuggler_arriving_vo(var_0) {
  var_1 = canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[0], var_0.debug_reach_pipe_room);
  var_1 = scripts\engine\utility::array_combine_unique(var_1, canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[1], var_0.debug_reach_pipe_room));
  var_1 = scripts\engine\utility::array_combine_unique(var_1, canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[2], var_0.debug_reach_pipe_room));
  var_1 = scripts\engine\utility::array_combine_unique(var_1, canceljoins(undefined, undefined, var_0.ignore_spawn_scoring_pois[3], var_0.debug_reach_pipe_room));

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!uav_dangernotifyplayersinbrrange(var_1[var_2].type)) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_1[var_2]);
      var_2--;
      continue;
    }

    if(abs(var_1[var_2].origin[2] - var_0.debug_reach_icbm_launch) > 3) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_1[var_2]);
      var_2--;
      continue;
    }
  }

  return var_1;
}

_id_12218(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("_encstr_AD9B0589ED9197") != "_encstr_A350079E35DACF8944") {
      continue;
    }
    var_0[var_1] setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_BDBC0F36C6BD37CA467DCDDB2CAE324B7B");
  }
}

_id_1245B(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] getscriptablepartstate("_encstr_AD9B0589ED9197") != "_encstr_BDBC0F36C6BD37CA467DCDDB2CAE324B7B") {
      continue;
    }
    var_0[var_1] setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_BA560EB9951DEBA3EDD78DC6F6B9CA8C");
  }
}

_id_13D01(var_0) {
  var_1 = scripts\engine\utility::array_randomize(var_0.crates);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3.type != "_encstr_BA2116BE6BD94CEAA0F9778F3B5E62BD31F3F787017B0773") {
      var_0._id_13D03 = _encstr_B4592F0E100E4B7AE3FFCE28D07637E34BDF98D048C1736E91C0BED2306F13E1165F43C2FD17A942D3013B53B4963F3AEF::_id_136A2(var_3.origin, var_3.angles);
      var_3 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_95DF070DD22319CA9B");
      var_0.crates = scripts\engine\utility::array_remove(var_1, var_3);
      var_0._id_13D03.hud_racetrack_timer = var_0.index;
      return;
    }
  }
}

uav_dangernotifyplayersinbrrange(var_0) {
  if(var_0 == "_encstr_B4D90E9636AFD277F08057BF3029380A" || var_0 == "_encstr_BA2116BE6BD94CEAA0F9778F3B5E62BD31F3F787017B0773" || var_0 == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D")
    return 1;

  return 0;
}

show_regroup_text() {
  foreach(var_1 in level.hud_set_progress) {
    if(!var_1.visited)
      return 0;
  }

  return 1;
}

_id_11B05() {
  self.visited = 1;
}

_id_11D01() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(!isDefined(level.hud_set_progress)) {
    return;
  }
  for(;;) {
    wait 1.0;

    foreach(var_1 in level.hud_set_progress) {
      if(updaterotatedebug(var_1.ignore_spawn_scoring_pois[0]) && !var_1.visited)
        var_1 _id_11B05();
    }

    if((!isDefined(level.hud_set_progress) || show_regroup_text()) && isDefined(level.audio_start_obj_room_fires)) {
      heli_go_to_exfil_point();
      return;
    }
  }
}

_id_1442E(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_86C709978B7E432440D8B2" && (var_2 == "_encstr_A350079E35DACF8944" || var_2 == "_encstr_82A00F0B1AE908B7C20B1F6F034A7EF884") && istrue(var_0.entity.usable))
    var_0 thread _id_12130();
}

_id_1442B(var_0, var_1) {
  var_2 = var_1._id_121D7;

  if(!istrue(var_2.entity.usable)) {
    return;
  }
  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_0.vehicle)) {
    if(getdvarint("_encstr_826B1E7316DA2EBA482953878313CFBF20A2B1E332E904C9763594B09949D577", 0) == 0) {
      return;
    }
    var_3 = var_0;

    if(!var_0 scripts\cp_mp\vehicles\vehicle::isvehicle())
      var_3 = var_0.vehicle;

    setupprop(var_2, var_3);
    return;
  }

  if(var_0 isinexecutionvictim() || var_0 isinexecutionattack()) {
    return;
  }
  var_4 = var_0.origin - var_2.origin;

  if(vectordot(var_4, anglestoleft(var_2.angles)) < 0) {
    return;
  }
  var_5 = var_0 huddopulse(var_2._id_14429[0]);
  var_6 = "_encstr_BAB31B77F91197FF784DB3D0F00103A5045EFD5097AA4F5D03A0704F18";

  if(getdvarint("_encstr_8CDA1C676F9E51C2087E53DE33F02CAAF8A513FFDB4D0A9DB0810E65C968", 0) && veh_updateomnvarsperframeforclient(var_2) && validateplundereventtype(var_2 runjoininprogresstimeout()))
    var_6 = "_encstr_8E5225AD87562B6D6D80E3ABC837E2E7E9F82C57905B7F3709B89BD348A39EBFE6D5A5DEB8C1FB";

  var_0 thread _id_1386B(var_5, (0, 90, 0), var_2, var_6);

  if(var_2 runjoininprogresstimeout() == 2) {
    if(!isDefined(var_2._id_13B99))
      var_2._id_13B99 = 0;

    var_2._id_13B99++;

    if(var_2._id_13B99 >= 4) {
      var_2._id_13B99 = 0;
      var_2 thread helicleanup();
    }
  }
}

_id_1386B(var_0, var_1, var_2, var_3) {
  var_4 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 endon("_encstr_AD75063D571AE108");
  var_4 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 thread _id_126EF(var_2);
  var_4 _id_12853(var_3);
  var_4 _id_1277F();
  wait 0.15;
  var_4 _id_1277C(var_3);
  var_4 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
  wait 0.1;

  if(var_4 scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(var_4.vehicle)) {
    var_4 clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);
    var_4 notify("_encstr_8B5B141C1BB0CBACE4FAC8BD9BCAEBEE85E438B49B9D");
    var_4 _id_138F8();
    return;
  }

  if(isDefined(var_2)) {
    var_2 _id_12869(var_4);
    var_2 battle_tracks_updatetogglestate(var_4);
  }

  var_4 setOrigin(var_0);
  var_4 setplayerangles(var_1);
  wait 4;
  var_4._id_12A4A = 1;
}

_id_12869(var_0) {
  var_1 = self;

  if(veh_updateomnvarsperframeforclient(var_1)) {
    var_0 notify("_encstr_B20318B0CE192F7A90B92FA022075BE6229069AA73E073DFB7C3");
    nuke_vault_key(var_1);
  }

  switch (var_1.launcherfired) {
    case 3:
    case 1:
      _id_138D8(var_1.hoverpos);
      level.hud_set_progress[var_1.hud_racetrack_timer] thread _id_1449D(var_0);
      level.hud_set_progress[var_1.hud_racetrack_timer] battle_tracks_updatebattletracksfromplayerdata(var_0);

      if(!level.hud_set_progress[var_1.hud_racetrack_timer].shouldburnfromdamage)
        level.hud_set_progress[var_1.hud_racetrack_timer] hud_lap_scoreboard();

      break;
    case 4:
      break;
    case 2:
      if(isDefined(var_1.setteamhealthhud))
        var_0 _id_12549(var_1.setteamhealthhud);

      break;
    case 5:
      break;
  }
}

_id_12548(var_0) {
  var_1 = self;
  var_1.show_charge = 1;

  if(isDefined(var_0.hud_racetrack_info)) {
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_99A4208939BE39CA46D732EDB7937D8DB7B9D1E4BD63FAC9DBDEB5BE9B1CC6C2DCA1", var_0.hud_racetrack_info);
    var_2 = level.hud_set_progress[var_0.hud_racetrack_timer];
    var_3 = var_2.ignore_spawn_scoring_pois[0];
    level thread _encstr_AC75328B0AE228D33443DE90AF5D1F611F60D4AF89756F3D4DA249F3EDA9F011F050CB9EED54DAE98510614768D7235B76DC639E::_id_13871(var_0.hud_racetrack_info, var_3);
    var_4 = relic_grounded_reload_monitor(var_0.hud_racetrack_info);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_monitor_waitreload(var_1, var_0.entity.doorid, var_4);
  }
}

hud_lap_scoreboard() {
  var_0 = self;
  var_0.shouldburnfromdamage = 1;

  if(isDefined(var_0.doors))
    var_0.doors _id_12122();

  _id_1245B(var_0.crates);
  var_0.maxkills = [];
  var_1 = 32;
  var_2 = 64;

  foreach(var_4 in var_0.doors) {
    var_5 = var_4.origin + anglesToForward(var_4.angles) * 26 + (0, 0, 16);
    var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_5, 0, var_1, var_2);
    var_6.door = var_4;
    var_6.hud_racetrack_timer = var_0.index;
    var_6.matchstarttimer_black_screen = var_6.door.angles;
    scripts\mp\utility\trigger::makeenterexittrigger(var_6, ::maxelderrank, ::maxextractions);
    var_0.maxkills[var_0.maxkills.size] = var_6;
  }

  level thread _id_13E21(var_0);
}

_id_1449D(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_B86708270BC7CFAA9EA1");
  var_2 = 1;

  while(var_2) {
    var_3 = var_0 scripts\engine\utility::_id_143AF("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8F7E1226FA2A63A25FB8699620F06760D0306B23", "_encstr_91F4136BB0C8D362279019C3A00F9DC701A8E4E556");

    switch (var_3) {
      case "_encstr_91F4136BB0C8D362279019C3A00F9DC701A8E4E556":
        var_1 battle_tracks_updatebattletracksfromplayerdata(var_0);
        break;
      case "_encstr_8F7E1226FA2A63A25FB8699620F06760D0306B23":
        var_1 _id_12C19(var_0);
        break;
      case "_encstr_AD75063D571AE108":
        var_1 _id_12C19(var_0);
        break;
      case "_encstr_8D820B49520F0EC02DDE6367EC":
        var_1._id_12699 = scripts\engine\utility::array_removeundefined(var_1._id_12699);
        var_2 = 0;
        break;
      default:
        break;
    }
  }
}

battle_tracks_updatebattletracksfromplayerdata(var_0) {
  var_1 = self;

  if(!updatefobindanger(var_0))
    var_1._id_12699[var_1._id_12699.size] = var_0;
}

_id_12C19(var_0) {
  var_1 = self;
  var_1._id_12699 = scripts\engine\utility::array_remove(var_1._id_12699, var_0);
}

_id_13E21(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = getdvarfloat("_encstr_B4122C08A20A27D16BF71407B20B5D3F35DB1160CA23B588CBC21008B5A320F31F40A890327AC345E31726739E87", 30) * 1000;
  var_2 = getdvarfloat("_encstr_8B171BFB4F18591BAE76D3BAFB87DB0D9815437CFFA81F13DF090AE3A3", 350);
  var_3 = 1;

  while(var_3) {
    if(var_0._id_12699.size <= 0 && gettime() - var_0._id_13B7A > var_1) {
      var_4 = 1;

      foreach(var_6 in var_0.doors) {
        var_7 = var_6.origin;
        var_8 = var_2;
        var_9 = scripts\mp\utility\player::getplayersinradius(var_7, var_8);

        if(var_9.size > 0)
          var_4 = 0;
      }

      if(var_4) {
        foreach(var_6 in var_0.doors) {
          scripts\mp\equipment\tactical_cover::_id_139F1(var_6.origin);
          latespawnsnatchtoc130(var_6.origin, 75, 0);
        }

        waitframe();

        foreach(var_6 in var_0.doors)
        var_6 vehicle_getinputvalue();

        wait(getdvarfloat("_encstr_AB3528573F9318A8B21123F94298D148FAD3AFE7F31B56F8F43A2830AD5450F0438F791F2F520D4B1DCF", 1.2));

        foreach(var_6 in var_0.doors)
        var_6 setscriptablepartstate("_encstr_B16705D9AFE22E", 0);

        var_17 = 1;

        foreach(var_6 in var_0.doors) {
          if(!var_6 scriptabledoorisclosed()) {
            var_17 = 0;
            break;
          }
        }

        if(var_17) {
          foreach(var_6 in var_0.doors) {
            var_6 setscriptablepartstate("_encstr_ACAD05F147D03F", "_encstr_96DF07C9F2A22F1A3A");
            var_6 scriptabledoorfreeze(1);
            var_6._id_1199C = _id_13626(var_6.origin);
          }

          var_3 = 0;
        }
      }
    }

    wait 0.1;
  }
}

updatefobindanger(var_0) {
  var_1 = self;
  return scripts\engine\utility::array_contains(var_1._id_12699, var_0);
}

playac130animinternal(var_0, var_1, var_2) {
  var_3 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!istrue(var_3._id_12A4A))
    waitframe();

  var_3._id_12A4A = 0;
  var_4 = 7.5;
  var_5 = var_2;
  var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_5, var_4);
  var_3 waittill("_encstr_87A218DB78315972CD07AA67FEB97B0D59E89F1FD8CBB4BAE9A5");

  if(isDefined(var_0))
    var_5 = var_3 give_objective_xp_to_all_players(var_0._id_14429);

  var_3 setOrigin(var_5);
  waitframe();
  var_3 _id_1277E();
  wait 0.25;
  var_3 clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);
  var_3 _id_138F8();

  if(isDefined(var_0)) {
    switch (var_0.launcherfired) {
      case 1:
        var_6 = ["_encstr_8C5D1932F0BE319CADD7584636FA93B285322F7D1DA12DB97D98C0", "_encstr_811C1CE1E8704B1D2FD839297079156B16536807452E9B4375CB939672E7"];
        var_3 playsoundtoplayer(scripts\engine\utility::random(var_6), var_3);
        _id_12548(var_0);
        break;
      case 3:
        var_7 = ["_encstr_B8701BF948F9381E97E97B83328754700DA67717EC1A7864DFF2F623EF", "_encstr_8C701B17304FFD25288FB6B527AE372B6086AA875D22C0FB80E086C682"];
        var_3 playsoundtoplayer(scripts\engine\utility::random(var_7), var_3);
        _id_12548(var_0);
        break;
      case 4:
        break;
      case 2:
        if(isDefined(var_0.setteamhealthhud))
          var_3 thread _id_1384F();

        break;
      case 5:
        break;
    }
  }

  var_3 notify("_encstr_8B5B141C1BB0CBACE4FAC8BD9BCAEBEE85E438B49B9D");
}

_id_126EF(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 playerhide();
  var_1 freezecontrols(1);
  var_1 vehiclepinonminimap(1);
  var_1.validateboltent = 1;

  if(isDefined(var_0))
    var_0._id_1269A[var_1.guid] = var_1;

  var_2 = 7.5;
  var_3 = scripts\engine\utility::_id_143BD(var_2, "_encstr_8B5B141C1BB0CBACE4FAC8BD9BCAEBEE85E438B49B9D", "_encstr_878B0D2B0D55328178B9D41111C0CC", "_encstr_B84717F4166BA96B35AF982B5F7CE0DDA2316C772AA343B00F", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0)) {
    if(var_3 == "_encstr_8D820B49520F0EC02DDE6367EC") {
      var_0._id_1269A = scripts\engine\utility::array_removeundefined(var_0._id_1269A);
      return;
    } else
      var_0._id_1269A = scripts\engine\utility::array_remove(var_0._id_1269A, var_1);
  }

  var_1 vehiclepinonminimap(0);
  var_1 freezecontrols(0);
  var_1 playershow();
  var_1.validateboltent = undefined;
}

setupprop(var_0, var_1) {
  var_0.entity.usable = 0;
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_1418F(var_1.vehiclename);

  if(isDefined(var_2))
    var_1[[var_2]]();

  wait 2;
  var_0 helicleanup();
  var_0.entity.usable = 1;
}

_id_12342() {
  var_0 = undefined;

  if(!isDefined(var_0))
    var_0 = give_killstreak_airstrike();

  if(show_regroup_text())
    heli_go_to_exfil_point();

  return var_0;
}

heli_go_to_exfil_point() {
  foreach(var_1 in level.audio_start_obj_room_fires) {
    if(var_1 runjoininprogresstimeout() == 2) {
      var_2 = var_1 getscriptablepartstate("_encstr_86C709978B7E432440D8B2");

      if(!(var_2 == "_encstr_ADB405071B8AE8" || var_2 == "_encstr_93CF08C7684F60BBB372"))
        var_1 thread heli_goto_pos();
    }
  }
}

give_killstreak_airstrike() {
  var_0 = 0;
  var_1 = spawnStruct();
  var_2 = level.hud_set_progress;
  var_3 = getdvarint("_encstr_B84E1DCB91C67F9E98AF6F41CDB02FF7E02B1112FB136BDA70335D49A9406C", 0);

  while(!var_0) {
    if(var_2.size <= 0)
      return spawnStruct();

    var_4 = randomint(var_2.size);
    var_1 = var_2[var_4];
    var_2 = scripts\engine\utility::array_remove(var_2, var_1);

    if(!var_1.visited) {
      var_0 = 1;
      level.hud_set_progress[var_1.index] _id_11B05();

      if(!istrue(level.br_circle_disabled) && var_3 == 0)
        var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_1.ignore_spawn_scoring_pois[0]);
    }
  }

  return level.hud_set_progress[var_1.index];
}

give_objective_xp_to_all_players(var_0) {
  foreach(var_2 in var_0) {
    if(capsuletracepassed(var_2, 16, 32))
      return huddopulse(var_2);
  }

  return huddopulse(var_0[0]);
}

huddopulse(var_0) {
  if(isDefined(var_0))
    return var_0 + (0, 0, -45);

  return self.origin;
}

updaterotatedebug(var_0) {
  var_1 = distance2dsquared(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin(), var_0);
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius() * _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

  if(var_2 == 0)
    return 0;

  return var_1 > var_2;
}

_id_14431() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A39B0FD3E347B920DA5AC0EE786B4BBD3B");

  if(!isDefined(var_0._id_14430))
    var_0._id_14430 = [];

  for(;;) {
    waitframe();

    if(!isDefined(var_0._id_14430) || var_0._id_14430.size <= 0) {
      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      continue;
    }

    var_0.tv_station_fastrope_one_infil_rider_start_targetname = 1;
    var_1 = var_0._id_14430[0];

    if(!isDefined(var_1) || !isalive(var_1)) {
      var_0._id_14430 = var_0 _id_12C1B(var_1);
      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      var_1 notify("_encstr_B84717F4166BA96B35AF982B5F7CE0DDA2316C772AA343B00F");
      continue;
    }

    var_1 thread playac130animinternal(var_0, (0, 90, 0), var_0._id_14429[0]);
    var_1 scripts\engine\utility::_id_143A5("_encstr_8B5B141C1BB0CBACE4FAC8BD9BCAEBEE85E438B49B9D", "_encstr_AD75063D571AE108");
    var_0._id_14430 = var_0 _id_12C1B(var_1);
    var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
    var_1 notify("_encstr_B84717F4166BA96B35AF982B5F7CE0DDA2316C772AA343B00F");
  }
}

battle_tracks_updatetogglestate(var_0) {
  var_1 = self;

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(!isDefined(var_1._id_14430))
    var_1._id_14430 = [];

  if(scripts\engine\utility::array_contains(var_1._id_14430, var_0)) {
    return;
  }
  var_1._id_13B7C = gettime();
  var_1._id_14430[var_1._id_14430.size] = var_0;
}

_id_12C1B(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::array_remove(var_1._id_14430, var_0);
  return var_2;
}

_id_1338A() {
  var_0 = self;

  if(!isDefined(var_0._id_14430)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 0.1;

  while(istrue(var_0.tv_station_fastrope_one_infil_rider_start_targetname))
    waitframe();

  var_0 notify("_encstr_A39B0FD3E347B920DA5AC0EE786B4BBD3B");
  var_0._id_14430 = undefined;
  var_0._id_1442F = undefined;
}

wp_watchforsmokedisowned(var_0, var_1) {
  var_2 = level.hud_set_progress[var_1];
  var_0.hud_racetrack_info = var_2.id;
  var_0._id_14429 = var_2.ignore_spawn_scoring_pois;
  var_0.hoverpos = var_2.doors;
  var_0.crates = var_2.crates;
  var_0.hud_racetrack_timer = var_2.index;

  if(!isDefined(var_0._id_14429)) {
    var_0._id_14429 = [];

    if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
      var_0._id_14429[0] = (3307, -2480, 64);
    else {
      var_3 = risktokencountroll();
      var_0._id_14429[0] = var_3;
      var_0._id_1442F = 1;
    }
  }

  var_2._id_13B7A = gettime();
  return var_2;
}

maxelderrank(var_0, var_1) {
  if(!isDefined(var_1.linkedto)) {
    var_2 = level.hud_set_progress[var_1.hud_racetrack_timer];
    var_3 = var_0.origin - var_1.origin;
    var_4 = anglestoleft(var_1.matchstarttimer_black_screen);

    if(var_2 updatefobindanger(var_0)) {
      if(vectordot(var_3, var_4) > 0)
        var_1.linkedto = var_4;
      else
        var_1.linkedto = -1 * var_4;
    } else if(vectordot(var_3, var_4) > 0)
      var_1.linkedto = -1 * var_4;
    else
      var_1.linkedto = var_4;
  }
}

maxextractions(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_3 = anglestoleft(var_1.matchstarttimer_black_screen);

  if(vectordot(var_1.linkedto, var_2) > 0)
    var_0 notify("_encstr_91F4136BB0C8D362279019C3A00F9DC701A8E4E556");
  else
    var_0 notify("_encstr_8F7E1226FA2A63A25FB8699620F06760D0306B23");
}

wp_watchgameend(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_1442A.size; var_2++) {
    if(!istrue(level._id_1442A[var_2].inuse)) {
      level._id_1442A[var_2].inuse = 1;
      var_1 = 1;
      break;
    }
  }

  if(!var_1)
    var_2 = undefined;

  var_0.setteamhealthhud = var_2;

  if(isDefined(var_0.setteamhealthhud)) {
    var_0._id_14429 = [level._id_1442A[var_2].ignore_spawn_scoring_pois[0]];
    level._id_1442A[var_2].maxagents = [];
    var_3 = [0, 1, 2, 3, 4, 5];
    var_3 = scripts\engine\utility::array_randomize(var_3);
    var_4 = 0;
    var_5 = _id_12342();

    for(var_6 = 0; var_6 < 4; var_6++) {
      var_7 = var_3[var_6];
      var_8 = level._id_1442A[var_2].maxcastsperframe[var_7].origin;
      var_9 = level._id_1442A[var_2].maxcastsperframe[var_7].angles;
      var_10 = _id_136AF(var_8, var_9);
      var_11 = var_10 relic_nuketimer_waitforobjectives();

      switch (var_6) {
        case 0:
          var_11 _id_13288(1);
          var_11.hud_racetrack_timer = var_5.index;
          var_11.setteamhealthhud = var_2;
          break;
        case 2:
        case 1:
          var_11 _id_13288(3);
          var_11.hud_racetrack_timer = var_5.index;
          var_11.setteamhealthhud = var_2;
          break;
        case 3:
          var_11 _id_13288(4);
          var_11.setteamhealthhud = var_2;
          break;
        default:
          var_11 _id_13288(4);
          var_11.setteamhealthhud = var_2;
          break;
      }

      level._id_1442A[var_2].maxagents[level._id_1442A[var_2].maxagents.size] = var_10;
    }

    level thread _id_144DD(var_2, var_0);
  } else {
    var_12 = risktokencountroll();
    var_0._id_14429 = [var_12];
    var_0._id_1442F = 1;
  }
}

veh_updateomnvarsperframeforclient(var_0) {
  if(isDefined(var_0.setteamhealthhud) && var_0.launcherfired != 2)
    return 1;

  return 0;
}

risktokencountroll() {
  var_0 = undefined;

  if(level.br_circle_disabled)
    var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle((0, 0, 0), getdvarfloat("_encstr_9B382A2646BB27D9E2F73870BB18D58FB2AA04A71D3225E1DB0F1978E324C8D3D894963E751A8D29841F38F0", 20000));
  else
    var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_modifyflagstieronrespawn();

  var_1 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::relic_ammo_drain_take_ammo();
  return (var_0[0], var_0[1], var_1);
}

wp_watchplanedisowned(var_0) {
  var_1 = undefined;

  if(getdvarint("_encstr_95A51E6FB8EBF78A5518639EF639A09F10983B9798C51282693D2D96D6D94A5C", 1) != 0)
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::relic_focusfire_modifyplayerdamage(getdvarint("_encstr_95DF1F6EC693D7C49CBEBB0B270711DBDE2784BDA33239BD838636BA6E3ACA9CCD", 6));

  if(!isDefined(var_1) || isDefined(var_1) && updaterotatedebug(var_1))
    var_1 = risktokencountroll();

  var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::relic_ammo_drain_take_ammo();
  var_0._id_14429 = [(var_1[0], var_1[1], var_2)];
  var_0._id_1442F = 1;
}

wrapindex(var_0, var_1) {
  var_2 = var_1.origin;
  var_3 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::relic_ammo_drain_take_ammo();
  var_0._id_14429 = [(var_2[0], var_2[1], var_3)];
  var_0._id_1442F = 1;
}

_id_12130() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_91570FEEC293E0237BB793F58D63DEB9B2");
  var_0.entity endon("_encstr_85BD111B608D7AF3B0E022170D99E702D3B812");
  var_0._id_1269A = [];

  if(var_0 unload_vehicles_on_weapons_free_thread())
    var_0 setscriptablepartstate("_encstr_86C709978B7E432440D8B2", "_encstr_B4B710981B66A14BDF34F8E818E7B05B0DD2");
  else
    var_0 setscriptablepartstate("_encstr_86C709978B7E432440D8B2", "_encstr_93CF08C7684F60BBB372");

  var_0 notify("_encstr_8F6A0EDD2CE43891DBB79CF57B1CB273");

  if(getdvarint("_encstr_8CDA1C676F9E51C2087E53DE33F02CAAF8A513FFDB4D0A9DB0810E65C968", 0) && veh_updateomnvarsperframeforclient(var_0))
    var_0 _id_1277D();

  switch (var_0.launcherfired) {
    case 3:
    case 1:
      if(!isDefined(var_0.hud_racetrack_timer)) {
        var_1 = _id_12342();

        if(!isDefined(var_1.index)) {
          var_0.launcherfired = 4;
          wp_watchplanedisowned(var_0);
          break;
        }

        var_0.hud_racetrack_timer = var_1.index;
      }

      wp_watchforsmokedisowned(var_0, var_0.hud_racetrack_timer);
      break;
    case 4:
      wp_watchplanedisowned(var_0);
      break;
    case 5:
      var_4 = _encstr_A3872A932672483F4BDF47FBEBC68C40353FFBAA8ACD2058C233AFF5978A46B8C2120683F52758AE5E7FEFF7::propheight();

      if(isDefined(var_4)) {
        wrapindex(var_0, var_4);
        var_0 thread _id_13C64();
        break;
      }
    case 2:
      wp_watchgameend(var_0);
      var_0 thread _id_13C64();
      break;
  }

  wait 1;
  var_5 = var_0.origin + anglestoleft(var_0.angles) * 15 + anglesToForward(var_0.angles) * 26 + (0, 0, 16);
  var_0._id_14432 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_5, 0, 25, 32);
  var_0._id_14432._id_121D7 = var_0;
  scripts\mp\utility\trigger::makeenterexittrigger(var_0._id_14432, ::_id_1442B, undefined);
  var_0 thread _id_14431();
}

_id_13C64() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_91570FEEC293E0237BB793F58D63DEB9B2");
  var_0.entity endon("_encstr_85BD111B608D7AF3B0E022170D99E702D3B812");
  var_0._id_13B81 = gettime();
  var_0._id_13B7C = undefined;

  for(;;) {
    if(isDefined(var_0._id_13B7C) && (gettime() - var_0._id_13B7C) / 1000 >= getdvarint("_encstr_8A461CF8F69877BAC67F3B9832339B57D7661CDB19B7936BDB1F57B3C8AD", 10)) {
      var_0 thread helicleanup(1);
      return;
    }

    if((gettime() - var_0._id_13B81) / 1000 >= getdvarint("_encstr_8CA81BA770232F529DD05BD6AE41E8D72840D777C0FC586A8D4D24CD1D", 30)) {
      var_0 thread helicleanup(1);
      return;
    }

    wait 1;
  }
}

validateplundereventtype(var_0) {
  return var_0 == 3 || var_0 == 4;
}

unload_vehicles_on_weapons_free_thread() {
  var_0 = relic_nuketimer_waitforobjectives();

  if(isDefined(var_0.launcherfired))
    return validateplundereventtype(var_0.launcherfired);

  return 0;
}

helicleanup(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8F6A0EDD2CE43891DBB79CF57B1CB273");

  if(isDefined(var_1._id_14432))
    var_1._id_14432 delete();

  var_1._id_13B99 = 0;

  if(var_1 unload_vehicles_on_weapons_free_thread())
    var_1 setscriptablepartstate("_encstr_86C709978B7E432440D8B2", "_encstr_8D80104BE3478738EFD41767F45518C3D32A");
  else
    var_1 setscriptablepartstate("_encstr_86C709978B7E432440D8B2", "_encstr_BEE608BF50D84BAA9DF4");

  var_1.entity.usable = 0;

  while(var_1._id_1269A.size != 0)
    wait 0.1;

  var_1.entity.usable = 1;
  var_1.setteamhealthhud = undefined;
  var_1 notify("_encstr_91570FEEC293E0237BB793F58D63DEB9B2");
  var_1 thread _id_1338A();

  if(isDefined(level.hud_set_progress) && show_regroup_text() && var_1 runjoininprogresstimeout() == 2)
    var_1 thread heli_goto_pos();
}

_id_1449B() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8F6A0EDD2CE43891DBB79CF57B1CB273");
  var_0.entity endon("_encstr_85BD111B608D7AF3B0E022170D99E702D3B812");
  var_0 waittill("_encstr_A39B0FD3E347B920DA5AC0EE786B4BBD3B");
  wait 5.0;
  var_0 thread latetoinfil();
}

unload_type() {
  var_0 = self getscriptablepartstate("_encstr_86C709978B7E432440D8B2");
  return var_0 == "_encstr_ADB405071B8AE8" || var_0 == "_encstr_93CF08C7684F60BBB372" || var_0 == "_encstr_85E60DE34BEF5FE0073CEF97306F58" || var_0 == "_encstr_B4B710981B66A14BDF34F8E818E7B05B0DD2";
}

heli_goto_pos() {
  var_0 = self;

  if(!isDefined(var_0.entity))
    var_0 = var_0 getlinkedscriptableinstance();

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.entity endon("_encstr_85BD111B608D7AF3B0E022170D99E702D3B812");
  var_0.entity.usable = 0;

  if(var_0 unload_type())
    var_0 helicleanup();

  while(!(var_0 getscriptablepartstate("_encstr_86C709978B7E432440D8B2") == "_encstr_A350079E35DACF8944" || var_0 getscriptablepartstate("_encstr_86C709978B7E432440D8B2") == "_encstr_82A00F0B1AE908B7C20B1F6F034A7EF884"))
    waitframe();

  wait 1.0;
  var_0 thread latetoinfil();
}

_id_1449A() {
  var_0 = self;
  var_1 = var_0 getlinkedscriptableinstance();
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_AD75063D571AE108");
  wait 5;

  if(var_1.launcherfired != 2) {
    return;
  }
  while(!updaterotatedebug(var_0.origin))
    wait 1.0;

  var_0 heli_goto_pos();
}

zombieregendelayscaleoutgas() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\mp\flags::levelflag("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  while(!isDefined(level.disable_super_in_turret))
    waitframe();

  var_0 = "_encstr_87CD22B5C15EBB164E0E19B77BE4F5D0B036C6BB2CF27D8DDE3685A34BDE73B9B8D8E63B";
  var_1 = tablelookupgetnumrows(var_0);
  level._id_1442A = [];

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = spawnStruct();
    var_4 = var_2;
    var_3.id = int(tablelookupbyrow(var_0, var_4, 0));
    var_3.ignore_spawn_scoring_pois = [];
    var_3.ignore_spawn_scoring_pois[0] = (int(tablelookupbyrow(var_0, var_4, 1)), int(tablelookupbyrow(var_0, var_4, 2)), int(tablelookupbyrow(var_0, var_4, 3)));
    var_3.inuse = 0;
    var_3._id_126BE = [];
    var_3.maxcastsperframe = remove_flag_trigs(var_3.ignore_spawn_scoring_pois[0]);
    level._id_1442A[level._id_1442A.size] = var_3;
  }
}

remove_flag_trigs(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray("_encstr_812B13C096BCB06CCA07573947F236E15B2A69BBFD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(abs(var_0[0] - var_4.origin[0]) <= 500)
      var_1[var_1.size] = var_4;
  }

  return var_1;
}

unset_relic_no_ammo_mun() {
  if(!isDefined(level._id_1442A))
    return 0;

  foreach(var_1 in level._id_1442A) {
    if(var_1.inuse)
      return 0;
  }

  return 1;
}

_id_12549(var_0) {
  var_1 = self;
  var_1.unset_relic_thirdperson = 1;
  var_2 = getdvarint("_encstr_A9462917A7D350A6C8590C82D3ABDD5530A0B7F01AAFAF3C688C70DB1C8BABF804B3CC9D43E9F91A60FFD0", 0) != 0;

  if(!var_2) {
    var_1 scripts\common\utility::allow_killstreaks(0);
    var_1 disableoffhandweapons();
  }

  level._id_1442A[var_0]._id_126BE[level._id_1442A[var_0]._id_126BE.size] = var_1;
  var_1 thread _id_11D19(var_0);
}

_id_144DD(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 waittill("_encstr_91570FEEC293E0237BB793F58D63DEB9B2");
  wait 3;

  while(level._id_1442A[var_0]._id_126BE.size != 0)
    wait 1;

  _id_13389(var_0);
}

mark_coop_bomb_defusal_ended() {
  var_0 = self;

  if(istrue(var_0.validateboltent)) {
    return;
  }
  var_0 notify("_encstr_B29F0DF00AE36D58551785DD557E40");
  var_1 = risktokencountroll();
  var_2 = var_1;
  var_0 thread _id_1386B(var_2, var_0.angles, undefined, "_encstr_9AFF24ADE0AF19B7CDCAA337D6BE9C9519BE19DEDE4EFA3AAE73E659B1AFAD958DA319F6DD37");
  var_0 thread playac130animinternal(undefined, var_0.angles, var_2);
}

_id_11D19(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::_id_143AF("_encstr_B20318B0CE192F7A90B92FA022075BE6229069AA73E073DFB7C3", "_encstr_AD75063D571AE108", "_encstr_B29F0DF00AE36D58551785DD557E40", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(var_2 == "_encstr_8D820B49520F0EC02DDE6367EC")
    level._id_1442A[var_0]._id_126BE = scripts\engine\utility::array_removeundefined(level._id_1442A[var_0]._id_126BE);
  else {
    level._id_1442A[var_0]._id_126BE = scripts\engine\utility::array_remove(level._id_1442A[var_0]._id_126BE, var_1);
    var_1.unset_relic_thirdperson = 0;
    var_3 = getdvarint("_encstr_A9462917A7D350A6C8590C82D3ABDD5530A0B7F01AAFAF3C688C70DB1C8BABF804B3CC9D43E9F91A60FFD0", 0) != 0;

    if(!var_3) {
      var_1 scripts\common\utility::allow_killstreaks(1);
      var_1 enableoffhandweapons();
    }

    var_1 notify("_encstr_A7FB0E63B2C2D9ACEB0D58C61BDD8597");
  }
}

_id_1384F() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B20318B0CE192F7A90B92FA022075BE6229069AA73E073DFB7C3");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A7FB0E63B2C2D9ACEB0D58C61BDD8597");
  var_1 = getdvarint("_encstr_A22B1EE61B4EF5134EFABB2C933822EDDE9390B0C61BEE852FA82DD659EDEA1D", 20);
  var_2 = getdvarint("_encstr_8C7E253FE8BBA7DAE5A8D34E26C9702FA0C84BFFE810C7D22B4EDD4337B92AE74BB0AFD3280B1C", 5);
  wait(var_1 - var_2);

  for(var_3 = var_2; var_3 >= 0; var_3--) {
    var_4 = "_encstr_B25514191ED7984EB5AF6E3AD8D7E657AD26599CE6D7";
    var_4 = var_4 + var_3;
    var_4 = var_4 + "_encstr_931A04C92127";
    var_0 playsoundtoplayer(var_4, var_0);
    wait 1;
  }

  var_0 mark_coop_bomb_defusal_ended();
}

_id_13389(var_0) {
  wait 7.5;

  foreach(var_2 in level._id_1442A[var_0].maxagents)
  var_2 thread heli_goto_pos();

  wait 3;
  var_4 = level._id_1442A[var_0].ignore_spawn_scoring_pois[0];
  var_5 = getdvarfloat("_encstr_8C471DCDD8C9EB269CD7BBB093C144F6DEC9683659C273AB1C292C912D5DDC", 500);
  latespawnsnatchtoc130(var_4, var_5, getdvarint("_encstr_849E29681B8557CE9B802B80EEF82DEAB8DB418AFA3A1F2BE3736D0208F547539DBC9B8B19311A4F121BB0", 1));
  level._id_1442A[var_0]._id_126BE = [];
  level._id_1442A[var_0].inuse = 0;
}

latespawnsnatchtoc130(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::sphere_trace_get_all_results(var_0, var_0, var_1, undefined, undefined, 0, 1);

  for(var_4 = 0; var_4 < var_3.size - 1; var_4++) {
    var_5 = var_3[var_4]["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_5)) {
      if(isPlayer(var_5) && (!var_2 || istrue(var_5.validateboltent))) {
        continue;
      }
      var_5 dodamage(15000, var_5.origin, var_5, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    }
  }
}

nuke_vault_key(var_0) {
  if(isDefined(var_0.hud_racetrack_timer)) {
    var_1 = level.hud_set_progress[var_0.hud_racetrack_timer];

    if(var_1.shouldburnfromdamage)
      return;
  }

  var_2 = level._id_1442A[var_0.setteamhealthhud];

  switch (var_0.launcherfired) {
    case 1:
      foreach(var_4 in var_2.maxagents) {
        if(var_4 relic_nuketimer_waitforobjectives() != var_0) {
          var_4 _id_13288(4);
          wp_watchplanedisowned(var_4 relic_nuketimer_waitforobjectives());
        }
      }

      break;
    case 3:
      var_1 = level.hud_set_progress[var_0.hud_racetrack_timer];
      _id_13D00(var_1);

      foreach(var_4 in var_2.maxagents) {
        if(var_4 runjoininprogresstimeout() == 1)
          var_4 _id_13288(3);
      }

      break;
  }
}

_id_12853(var_0) {
  var_1 = self;
  var_1 skydive_cutparachuteon(var_0);
  var_1 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 10);
}

_id_1277C(var_0) {
  var_1 = self;
  var_1 preloadcinematicforplayer(var_0);
}

_id_138F8() {
  var_0 = self;
  var_0 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
  var_0 skydive_cutparachuteoff();
}

_id_1277F() {
  var_0 = self;
  playFX(level._effect["_encstr_8F8A0E8F07039B19CCFF2FD2698D15EC"], var_0.origin);
}

_id_1277E() {
  var_0 = self;
  playFX(level._effect["_encstr_A35B0D9F83063B6710C0FD82FE406E"], var_0.origin);
}

_id_1277D() {
  var_0 = self;
  var_1 = randomint(4);
  var_2 = "_encstr_B1A611BB0B4E07AF91DBDBE4FA43BB959537F5";

  switch (var_1) {
    case 0:
      var_2 = var_2 + "_encstr_AA9B0531161D9B";
      break;
    case 1:
      var_2 = var_2 + "_encstr_8BE30BEB37C8C37396E35D537B";
      break;
    case 2:
      var_2 = var_2 + "_encstr_ADF80637DB2FC38C";
      break;
    case 3:
      var_2 = var_2 + "_encstr_966409DB120913845BE0CA";
      break;
    default:
      var_2 = var_2 + "_encstr_AA9B0531161D9B";
  }

  playFX(level._effect[var_2], var_0.origin, anglesToForward(var_0.angles));
}

relic_grounded_reload_monitor(var_0) {
  var_1 = "_encstr_B40101";

  if(var_0 < 10)
    var_1 = "_encstr_934C0218";

  var_2 = "_encstr_86BE2AF19949294C93F59D16836EB56BE5C069897191FDC593C78D60AFB3FEB79D88293938FDAF7F67CF0160" + var_1 + var_0;
  return var_2;
}