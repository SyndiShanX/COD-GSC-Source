/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_hh.gsc
***********************************************/

spawn_and_enter_cargo_truck_mg() {
  level thread airfield_safehouse_loot();
}

airfield_safehouse_loot() {
  level._id_13443["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
  level.helidrivableenablesiteonflyaway["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_9940466B38F9CDA713EBAF8AE6306F6269A872C20AAF168F893794817B480B2FBF987AAA48555DAB811B5FBA966EFBF5D998E26288AF0617590957B42D33F331636BBAABDA85BF03");
  level.helidrivableenablesiteonflyaway["_encstr_852907B9D8C959B2CD"] = loadfx("_encstr_97D944C36C91960183B2070B1870C99B61774DFF60C70A5DE9D8C30F6858BEA2F715D737B65D268ED180171B280E78CAB123DFAE9BE7BAAFD9481F3FB803179727C5B5E38CF1");
  level._id_1207B = ::airlock_show_back_doors;
  level.playerwaittospawn = ::airlock_button_r;
  level._effect["_encstr_87B21FB3D2A807F10B97F9608F3B1EC7562A6810B944AF083FD47763A79FC08B7D"] = loadfx("_encstr_A10D4310C2B8F7806F8010F6A266C817E51A6808CE97A3D81FD0817F91BED1F38A33A098F36B47F3FBF0AFE67257D85F759BF1207A4601A9471810E971C3A13BD172F8C8C2");

  if(!scripts\mp\flags::levelflag("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  airlock();
  var_0 = getdvarint("_encstr_8E8413CBE01D217BA34881B4F52E0F7569B871F220", 0) == 1;

  if(!var_0) {
    return;
  }
  level.spawn_lot_paratroopers = 1;
  level thread airdrop_givecrateuseweapon();
  var_1 = getdvarint("_encstr_AAE81B38923A17E17BE78BF38F4B4935A37AE1B13B168FB8DBD2057D9B", 0) == 1;

  if(var_1)
    level.spawn_and_enter_little_bird_mg = airduct_locations();
  else
    level.spawn_and_enter_little_bird_mg = airstrike_watchdeployweaponchange();

  all_but_one_player_in_vehicle();
  var_2 = getdvarint("_encstr_B86B1C0F10C5CFDA82C62950914D52F2559F483FD35157EA9F21C721378F", 0) == 1;

  for(var_3 = 0; var_3 < level.spawn_and_enter_little_bird_mg.size; var_3++) {
    if(var_2) {
      airdropbasecashamount(var_3);
      continue;
    }

    airdrop_specialcasecanusecrate(var_3);
  }

  foreach(var_5 in level.spawn_and_enter_little_bird_mg)
  level thread airstrike_canbeused(var_5, 0, 1, 0);

  var_7 = getdvarint("_encstr_B6781CDC6C277D269CAF1A43FABBC2D28EEBCCED39FA1C27ACD6168E6C34", 1) == 1;

  if(var_7)
    level thread airholder();

  level thread airlock_callbutton_think();
  scripts\engine\scriptable::_id_12F5B("_encstr_BDBE0C2627B1F6DE477D6CDB2C8D", ::airdrop_playdeploydialog);
  scripts\engine\scriptable::_id_12F5B("_encstr_AC4D10130810CF5241AF6A25703FFA897860", ::airstrike_movewithplane);
}

airlock_callbutton_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");

    if(!isDefined(level.spawn_and_enter_little_bird_mg)) {
      continue;
    }
    foreach(var_1 in level.spawn_and_enter_little_bird_mg)
    all_modes(var_1._id_13D19);
  }
}

airdrop_givecrateuseweapon() {
  scripts\mp\utility\sound::besttime("_encstr_96EA1513937D5BB719ACF586DE1B4BC8165EEB34BA9BE8");
}

airlock_slot_think(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getdvarint("_encstr_A3C41A376CC9F526C9EB341ABE1D9CACACAF4C1B0B36ADC65A37E8FA" + var_1, 0) == 1;

    if(var_2)
      var_0[var_1].complete_hack_console = 1;
  }

  for(var_1 = var_0.size - 1; var_1 >= 0; var_1--) {
    if(istrue(var_0[var_1].complete_hack_console))
      var_0 = scripts\engine\utility::can_path_to_target(var_0, var_1);
  }

  var_3 = getdvarint("_encstr_8F88149BD8E4AF314EEB0D1AEBE65D5B7DE84E2B95DC", 6);
  var_3 = min(var_3, var_0.size);
  var_4 = [];
  var_5 = scripts\engine\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < var_3; var_1++)
    var_4[var_4.size] = var_5[var_1];

  return var_4;
}

airlock() {
  airlock_stop("_encstr_95DF070DD22319CA9B", "_encstr_997D1D3127FA91598D5B8E3456D02CD8B1B97DC658B11A59FAB17BD6ADBD73");
  airlock_stop("_encstr_95DF070DD22319CA9B", "_encstr_88BD20FAFBE9719DD06DC8748B9067A469FB90AF99DFC1E7D8A8271FEA488AF7DB4B");
  airlock_stop("_encstr_95DF070DD22319CA9B", "_encstr_8CBA1ED67A112971BB7F68802FD889414AA2C0EE160AF9B95F4BA8D807EC41A3");
}

airlock_stop(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4 in var_2)
  var_4 setscriptablepartstate("_encstr_AD9B0589ED9197", var_0, 0);
}

airdrop_specialcasecanusecrate(var_0) {
  var_1 = level.spawn_and_enter_little_bird_mg[var_0].origin;
  var_2 = 5000;
  level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer = getentitylessscriptablearrayinradius("_encstr_997D1D3127FA91598D5B8E3456D02CD8B1B97DC658B11A59FAB17BD6ADBD73", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_1, var_2);
  level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation = getentitylessscriptablearrayinradius("_encstr_88BD20FAFBE9719DD06DC8748B9067A469FB90AF99DFC1E7D8A8271FEA488AF7DB4B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_1, var_2);
  level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar = getentitylessscriptablearrayinradius("_encstr_8CBA1ED67A112971BB7F68802FD889414AA2C0EE160AF9B95F4BA8D807EC41A3", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_1, var_2);
  var_3 = 5;
  var_4 = 5;
  var_5 = 10;
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer, var_0, var_3);
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation, var_0, var_4);
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar, var_0, var_5);
}

airlock_back_blocker(var_0, var_1, var_2) {
  var_3 = randomint(var_2);

  foreach(var_5 in var_0) {
    var_3++;
    var_3 = var_3 % var_2;
    var_5.spawn_maint_wave = var_1;
    var_5._id_11A25 = var_3;
  }
}

airstrike_watchdeployweaponchange() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A6F71582FA5FD24F59BCD3137950C7B23190981BEBD78D", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = airlock_slot_think(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = airstrike_removeactivestrike(var_4.origin);
    var_2[var_2.size] = var_5;
  }

  return var_2;
}

airholder() {
  var_0 = getdvarint("_encstr_B6781CDC6C277D269CAF1A43FABBC2D28EEBCCED39FA1C27ACD6168E6C34", 1) == 1;

  if(var_0)
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  var_1 = 6;
  wait(var_1);
  var_2 = 1;

  for(var_3 = 0; var_3 < level.spawn_and_enter_little_bird_mg.size; var_3++) {
    airstrike_addactivestrike(level.spawn_and_enter_little_bird_mg[var_3], var_2);
    level thread airstrike_canbeused(level.spawn_and_enter_little_bird_mg[var_3], var_2, 1, 0);
    level.spawn_and_enter_little_bird_mg[var_3] setscriptablepartstate("_encstr_ACE50BDF2250298803A850F80D", "_encstr_998806DD1A96D12B", 0);
    level.spawn_and_enter_little_bird_mg[var_3]._id_13D19 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::calloutmarkerping_watchwhenobjectivedeleted(1);
  }
}

airduct_locations() {
  var_0 = [];
  var_1 = (-1852, -1253, 0);
  var_2 = airstrike_removeactivestrike(var_1);
  var_0[var_0.size] = var_2;
  var_1 = (-1859, -3900, 0);
  var_2 = airstrike_removeactivestrike(var_1);
  var_0[var_0.size] = var_2;
  return var_0;
}

airstrike_removeactivestrike(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_B47F1FC57021BB52F61B0F6B6B17ABCF203B3F0FAE50412B442BB77F53459178A2");
  var_1.unset_relic_noregen = 1;
  return var_1;
}

airdropbasecashamount(var_0) {
  level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer = [];
  level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation = [];
  level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar = [];
  var_1 = [];
  var_1[0] = (100, 0, 0);
  var_1[1] = (-100, 0, 0);
  var_1[2] = (0, 100, 0);
  var_1[3] = (0, -100, 0);
  var_2 = (0, 0, 0);

  foreach(var_4 in var_1) {
    var_5 = level.spawn_and_enter_little_bird_mg[var_0].origin + var_4;
    var_6 = spawn_allies_at_defend("_encstr_8B2E22586B9989B8E714C8DF145FA16B7A415850F22BD5F6BF29EE43F5D7A93FA5CA4028", var_5, var_2, 1);
    level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer = scripts\engine\utility::array_add(level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer, var_6);
    var_6 = spawn_allies_at_defend("_encstr_B640255EF299B1880F8BA940F34F01D323D14EDF8EB36D76EBF74043BF4F7813CAC7486D663B0B", var_5, var_2, 1);
    level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation = scripts\engine\utility::array_add(level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation, var_6);
    var_6 = spawn_allies_at_defend("_encstr_8EF923721BF8EB8518812F195930CE471656FBDBC144ABF120930BE85349D45731080272AA", var_5, var_2, 1);
    level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar = scripts\engine\utility::array_add(level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar, var_6);
  }
}

spawn_allies_at_defend(var_0, var_1, var_2, var_3) {
  var_4 = easepower(var_0, var_1, var_2);
  return var_4;
}

airstrike_addactivestrike(var_0, var_1) {
  if(istrue(var_0.stopdragonsbreathburning))
    var_1 = 0;

  var_0._id_13A12 = var_1;

  switch (var_1) {
    case 0:
      var_0 setscriptablepartstate("_encstr_8FE307B3F837B56FEB", "_encstr_95DF070DD22319CA9B", 0);
      break;
    case 1:
      var_0 setscriptablepartstate("_encstr_8FE307B3F837B56FEB", "_encstr_865F0ACA20E55FB316409E8D", 0);
      break;
    case 2:
      var_0 setscriptablepartstate("_encstr_8FE307B3F837B56FEB", "_encstr_9B5F0A99F7CB6328FF4B28F0", 0);
      break;
    case 3:
      var_0 setscriptablepartstate("_encstr_8FE307B3F837B56FEB", "_encstr_B21D0CD8CA9DAC36D747869C2B59", 0);
      break;
  }
}

airstrike_canbeused(var_0, var_1, var_2, var_3) {
  var_0 notify("_encstr_8F3110B8D7FB21CBE5EFE940B32C609D42FA");
  var_0 endon("_encstr_8F3110B8D7FB21CBE5EFE940B32C609D42FA");
  var_0._id_13D1B = var_1;
  wait(var_3);
  airdrop_watchforcrateuseend("_encstr_926318D9125BA160EB3F4F5D02EF29D1835ABAA88A73CB98C260" + var_1 + "_encstr_8A5315B922A5F0FE9A1F09335382EF106A7EBBE98A527A" + var_2);

  if(isDefined(var_0._id_13D19.claimplayer))
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_vehicles(var_0._id_13D19.claimplayer, var_1);

  switch (var_1) {
    case 0:
      var_0 setscriptablepartstate("_encstr_B15F0DD66D607117981949F3C06033", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_92EF05290B9275", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_87BA0CE44B985D433F1B0A52600E", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_A9190527B4E628", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_B85F091C93596E95B98E9B", "_encstr_95DF070DD22319CA9B", 0);

      if(!istrue(var_0._id_12744)) {
        var_0 setscriptablepartstate("_encstr_9AD50BF4237933936F798A1258", "_encstr_95DF070DD22319CA9B", 0);
        var_0 setscriptablepartstate("_encstr_916A0AD8B4761A1DB9EBDE9B", "_encstr_95DF070DD22319CA9B", 0);
      }

      break;
    case 1:
      var_0 setscriptablepartstate("_encstr_B15F0DD66D607117981949F3C06033", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_92EF05290B9275", "_encstr_BE8B08E323FB2BCD6268", 0);
      var_0 setscriptablepartstate("_encstr_87BA0CE44B985D433F1B0A52600E", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_A9190527B4E628", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_B85F091C93596E95B98E9B", "_encstr_95DF070DD22319CA9B", 0);

      if(!istrue(var_0._id_12744)) {
        var_0 setscriptablepartstate("_encstr_9AD50BF4237933936F798A1258", "_encstr_95DF070DD22319CA9B", 0);
        var_0 setscriptablepartstate("_encstr_916A0AD8B4761A1DB9EBDE9B", "_encstr_95DF070DD22319CA9B", 0);
      }

      break;
    case 2:
      var_0 setscriptablepartstate("_encstr_92EF05290B9275", "_encstr_BE8B08E323FB2BCD6268", 0);
      var_0 setscriptablepartstate("_encstr_87BA0CE44B985D433F1B0A52600E", "_encstr_BE8B08E323FB2BCD6268", 0);
      var_0 setscriptablepartstate("_encstr_A9190527B4E628", "_encstr_95DF070DD22319CA9B", 0);
      var_0 setscriptablepartstate("_encstr_B85F091C93596E95B98E9B", "_encstr_95DF070DD22319CA9B", 0);

      if(!istrue(var_0._id_12744)) {
        var_0 setscriptablepartstate("_encstr_9AD50BF4237933936F798A1258", "_encstr_BE8B08E323FB2BCD6268", 0);
        var_0 setscriptablepartstate("_encstr_916A0AD8B4761A1DB9EBDE9B", "_encstr_95DF070DD22319CA9B", 0);
      }

      break;
    case 3:
      var_0 setscriptablepartstate("_encstr_92EF05290B9275", "_encstr_BE8B08E323FB2BCD6268", 0);
      var_0 setscriptablepartstate("_encstr_87BA0CE44B985D433F1B0A52600E", "_encstr_BE8B08E323FB2BCD6268", 0);
      var_0 setscriptablepartstate("_encstr_A9190527B4E628", "_encstr_BE8B08E323FB2BCD6268", 0);
      var_0 setscriptablepartstate("_encstr_B85F091C93596E95B98E9B", "_encstr_BE8B08E323FB2BCD6268", 0);

      if(!istrue(var_0._id_12744)) {
        var_0 setscriptablepartstate("_encstr_9AD50BF4237933936F798A1258", "_encstr_BE8B08E323FB2BCD6268", 0);
        var_0 setscriptablepartstate("_encstr_916A0AD8B4761A1DB9EBDE9B", "_encstr_BE8B08E323FB2BCD6268", 0);
      }

      break;
  }

  if(var_2) {
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    switch (var_1) {
      case 0:
        var_4 = "_encstr_95DF070DD22319CA9B";
        var_5 = "_encstr_95DF070DD22319CA9B";
        var_6 = "_encstr_95DF070DD22319CA9B";
        break;
      case 1:
        var_4 = "_encstr_A350079E35DACF8944";
        var_5 = "_encstr_95DF070DD22319CA9B";
        var_6 = "_encstr_95DF070DD22319CA9B";
        break;
      case 2:
        var_4 = "_encstr_95DF070DD22319CA9B";
        var_5 = "_encstr_A350079E35DACF8944";
        var_6 = "_encstr_95DF070DD22319CA9B";
        break;
      case 3:
        var_4 = "_encstr_95DF070DD22319CA9B";
        var_5 = "_encstr_95DF070DD22319CA9B";
        var_6 = "_encstr_A350079E35DACF8944";
        break;
    }

    foreach(var_8 in var_0.hideintelinstancefromplayer)
    var_8 setscriptablepartstate("_encstr_AD9B0589ED9197", var_4, 0);

    foreach(var_8 in var_0.waypoints_creation)
    var_8 setscriptablepartstate("_encstr_AD9B0589ED9197", var_5, 0);

    foreach(var_8 in var_0.spawn_lootcrates_on_each_traincar)
    var_8 setscriptablepartstate("_encstr_AD9B0589ED9197", var_6, 0);
  }
}

all_but_one_player_in_vehicle() {
  var_0 = getdvarint("_encstr_AAFF1A83A8557923EB30F0F828F3BB3F93B17ADA70B76A674103D5FB", 250);
  var_1 = getdvarint("_encstr_A3EF1A4B867B4FB6CDD99A92F1E96A7F7160A4DF2966DB3F833BA24B", 100);
  var_2 = getdvarint("_encstr_BAB31E0FDF7859F2FB50B730C0010FAD05DBF5D1A76E115D032311C11BE7B80F", 30);
  var_3 = var_2 * 2;

  if(getdvarint("_encstr_8ECF2063506D78F34ADF09135131886B5748CF0863930990A889E8C418338850E1ED", 0) != 0)
    var_3 = getdvarint("_encstr_8ECF2063506D78F34ADF09135131886B5748CF0863930990A889E8C418338850E1ED", 30);

  for(var_4 = 0; var_4 < level.spawn_and_enter_little_bird_mg.size; var_4++) {
    var_5 = level.spawn_and_enter_little_bird_mg[var_4].origin;
    var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_5, 0, var_0, var_1);
    var_6._id_13DC7 = [];
    var_7 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_6, "_encstr_A7A408B9CA5D1D4E2C63");
    var_7._id_13D1A = var_4;
    var_6._id_13D19 = var_7;
    var_7.onuse = ::aitype_counts;
    var_7.onbeginuse = ::all_alive_players;
    var_7.onuseupdate = ::all_alive_players_entities;
    var_7.onenduse = ::all_alive_players_entites;
    var_7._id_128B9 = ::all_but_one_player_downed;
    var_7._id_12079 = ::alertforspawngroupdirection;
    var_7.oncontested = ::alcove_trig;
    var_7.onuncontested = ::alivejuggernauts;
    var_7.forest_barrels = ::airstrikebetweentwopoints;
    var_7.gate_swings_open = 1;
    var_7.id = "_encstr_87D9083A6F628DDB5F1F";
    var_7.pinobj = 0;
    var_7.lockupdatingicons = 1;
    var_7 scripts\mp\gameobjects::setcapturebehavior("_encstr_820E07FAE8780B3A4C");
    var_7 scripts\mp\gameobjects::setusetime(var_3);
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(var_7.objidnum, "_encstr_B40101");
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_7.objidnum);
    var_7.flagmodel delete();
    var_7.flagmodel = undefined;
    var_7.outlineent = undefined;
    var_7.visibilitymanuallycontrolled = 1;
    var_7 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::calloutmarkerping_watchwhenobjectivedeleted(0);
    level.spawn_and_enter_little_bird_mg[var_4]._id_13D19 = var_7;
    level.spawn_and_enter_little_bird_mg[var_4].weapongroupdata = [];
    level.spawn_and_enter_little_bird_mg[var_4].weapongetflinchtype = [];
    level.spawn_and_enter_little_bird_mg[var_4].trial_mount_nag = [];
    level.spawn_and_enter_little_bird_mg[var_4].trial_missionscript_init_funcs = [];
  }
}

airfield_safehouse_edit_loadout(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8BEF1AC06AD86B0990832F6B2D0708FB4871DB61879A6C915897F159");
  self endon("_encstr_8BEF1AC06AD86B0990832F6B2D0708FB4871DB61879A6C915897F159");
  var_1 = getdvarint("_encstr_81E41A3312CAC71B48AF33D439BBF76577ABD95BF19B6F25AD79BB6B", 30);
  wait(var_1);
  var_2 = getdvarint("_encstr_A36D1BE66CE4BE3139EB3434F523B7D6F51B1B2B589CAFE45823A5BA6E", 260);

  if(var_2 <= 0) {
    return;
  }
  var_3 = 520;
  var_4 = scripts\mp\utility\player::getplayersinradius(var_0._id_13D19.trigger.origin, var_3);

  if(var_4.size > 0) {
    thread airfield_safehouse_edit_loadout(var_0);
    return;
  }

  var_5 = canceljoins(undefined, undefined, var_0.origin, var_2);

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(scripts\engine\utility::string_starts_with(var_7.type, "_encstr_93401C4AF8D77DDFB06D0F2909DBAF40F7F9C3E3D82F35E7E9DF3B2895E6")) {
        continue;
      }
      if(scripts\engine\utility::string_starts_with(var_7.type, "_encstr_B4D90E9636AFD277F08057BF3029380A")) {
        continue;
      }
      if(var_7 getscriptableisreserved() && !isDefined(var_7.embassy_main)) {
        continue;
      }
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_7);
    }
  }
}

airstrikebetweentwopoints() {
  var_0 = getdvarint("_encstr_AF2024BB768BBF265D492A2261595DCF866D35239F32776A2368E26990A3558FFB58B0D9A1B9", 13);
  var_1 = getdvarint("_encstr_B8EB245780D3FF824DAFACA468192A851E2087AF386A074B43ADF7116F3DE246E1912B2FA821", 26);
  var_2 = self;
  var_3 = var_2.curprogress > 0.5 * var_2.usetime;
  return scripts\engine\utility::ter_op(var_3, var_1, var_0);
}

alcove_trig() {
  var_0 = self;
  var_1 = "_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509";
  var_0 scripts\mp\gameobjects::setobjectivestatusicons(var_1);
  scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, undefined);
  all_modes(var_0);
  var_2 = "_encstr_B634229D2877CDD591F0E7C04DEB6823985504976158C8B393F292E08B907B7E10399757";
  all_alive_players_near_exfil(var_0, var_2);
}

all_alive_players_near_exfil(var_0, var_1) {
  if(all_obit_models(var_0)) {
    var_2 = airstrikecount(var_0);

    foreach(var_4 in var_2)
    var_4 playsoundtoplayer(var_1, var_4, var_4);
  }
}

alivejuggernauts(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1._id_13D1A];
  var_2.trial_mount_nag = [];
  _encstr_BE892FF37E20B3A7F9EB480F4347E49013405B170BD24FBFAB2B78C8D210D51020A367CF0285029B86D0F3D0D1C242633B::onarmorboxusedbyplayer(var_0, 0);
  all_modes(var_1);
}

aitype_counts(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1._id_13D1A];
  var_2.cheese = 1;
  var_1.claimteam = var_0.team;
  var_1.curprogress = var_1.usetime;
  alertforspawngroupdirection(1);
}

all_but_one_player_downed(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1._id_13D1A];

  if(istrue(var_2.stopdragonsbreathburning))
    return 0;

  var_3 = scripts\engine\utility::array_contains(var_2.weapongetflinchtype, var_1.claimteam);
  var_4 = getdvarint("_encstr_86E22037B1C9AFC44EFA0DD0FA0B8DD87BBB29B2075616E834BDDA07D8AC47D2EDDC", 0) == 1;

  if(var_3 && !var_4) {
    var_1.claimplayer setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 13);
    var_5 = 0;
    return var_5;
  }

  var_6 = istrue(var_1.playerkilled_washitbyvehicle);
  var_7 = !scripts\engine\utility::array_contains(var_2.trial_mount_nag, var_1.claimteam);
  var_8 = var_6 && var_0 && var_7;
  var_5 = !var_8;
  return var_5;
}

all_alive_players_entities(var_0, var_1, var_2, var_3) {
  var_4 = self;
  all_modes(var_4);
}

alertforspawngroupdirection(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1._id_13D1A];
  var_3 = var_1.curprogress / var_1.usetime;

  if(!isDefined(var_2._id_13D1B)) {
    return;
  }
  if(!var_0)
    var_1.playerkilled_washitbyvehicle = 1;

  var_4 = var_0 && istrue(var_1.playerkilled_washitbyvehicle);

  if(var_4)
    var_1.playerkilled_washitbyvehicle = 0;

  if(!scripts\engine\utility::array_contains(var_2.trial_mount_nag, var_1.claimteam))
    var_2.trial_mount_nag = scripts\engine\utility::array_add(var_2.trial_mount_nag, var_1.claimteam);

  var_5 = scripts\engine\utility::ter_op(var_0 && !istrue(var_2.stopdragonsbreathburning), "_encstr_87070365F7", "_encstr_95DF070DD22319CA9B");

  if(var_2 getscriptablehaspart("_encstr_A714098B605A079ABFD072"))
    var_2 setscriptablepartstate("_encstr_A714098B605A079ABFD072", var_5, 0);

  if(!var_0 && istrue(var_2.cheese)) {
    var_2.cheese = undefined;

    if(var_2 getscriptablehaspart("_encstr_B15F0DD66D607117981949F3C06033"))
      var_2 setscriptablepartstate("_encstr_B15F0DD66D607117981949F3C06033", "_encstr_91A70819B51248771F5A", 0);
  }

  var_6 = var_2._id_13D1B;

  if(var_3 == 1) {
    if(var_6 != 3) {
      var_7 = "_encstr_BD931E049199FEA3D99E4B9240ADDF72B015AC894748C583F3D1621BCB101EFA";
      all_alive_players_near_exfil(var_1, var_7);
      var_8 = 265;
      var_9 = scripts\mp\utility\player::getplayersinradius(var_2._id_13D19.trigger.origin, var_8);

      foreach(var_11 in var_9) {
        if(var_11.team == var_1.claimteam) {
          _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_11, "_encstr_A2611DBE2B2101ABDFDBB91FA59F1A10A154F33848074395C1A8B90A59CF57");
          var_11 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_8CD6129A58A70BDBA1B55F9B58481BD50B10F2D2");
          var_11 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_B2A714E84B96B32CB948A20AA98FE5872B216D8C5559");
        }
      }

      all_end_checkpoints_activated(var_1);

      if(var_2 getscriptablehaspart("_encstr_B15F0DD66D607117981949F3C06033"))
        var_2 setscriptablepartstate("_encstr_B15F0DD66D607117981949F3C06033", "_encstr_837C0B9301E83B53409BBB1243", 0);

      var_13 = scripts\engine\utility::array_contains(var_2.weapongetflinchtype, var_1.claimteam);
      var_14 = var_1.claimteam != "_encstr_8BBA05185F8B99" && !var_13;
      var_15 = getdvarfloat("_encstr_A6F72793EB0561537BB150133ED1C0A2A8688513B7F39030CA62AF21A886BF38B00B613F5F68619F08", 1);
      level thread airstrike_canbeused(var_2, 3, var_14, var_15);

      if(!var_13)
        var_2.weapongetflinchtype = scripts\engine\utility::array_add(var_2.weapongetflinchtype, var_1.claimteam);

      if(!istrue(var_2._id_12744))
        airlock_slot(var_1._id_13D1A);
    }
  } else if(var_3 > 0.5) {
    if(var_6 != 2) {
      if(var_0) {
        all_end_checkpoints_activated(var_1);

        if(var_2 getscriptablehaspart("_encstr_B15F0DD66D607117981949F3C06033"))
          var_2 setscriptablepartstate("_encstr_B15F0DD66D607117981949F3C06033", "_encstr_A5A012373885779BBE23B2D87B9C588E4B7BE66E", 0);
      }

      var_16 = scripts\engine\utility::array_contains(var_2.weapongroupdata, var_1.claimteam);
      var_14 = var_1.claimteam != "_encstr_8BBA05185F8B99" && !var_16;
      var_15 = getdvarfloat("_encstr_97542593CF631781B25152338004E0795FB9151C1D13C875178A67CB75D43AC0DC19B207A4FA10", 1);
      level thread airstrike_canbeused(var_2, 2, var_14, var_15);

      if(!var_16)
        var_2.weapongroupdata = scripts\engine\utility::array_add(var_2.weapongroupdata, var_1.claimteam);

      var_17 = "_encstr_A6CF18AA18B9602322A90B0835ABC08BDA086DFA684A5041EB5A";
      all_alive_players_near_exfil(var_1, var_17);
    }
  } else if(var_3 <= 0.01 && !var_0) {
    var_1.curprogress = 0;
    var_1.playerkilled_washitbyvehicle = 0;
    var_2.trial_mount_nag = [];

    if(var_2 getscriptablehaspart("_encstr_A714098B605A079ABFD072"))
      var_2 setscriptablepartstate("_encstr_A714098B605A079ABFD072", "_encstr_95DF070DD22319CA9B", 0);

    var_2 thread airfield_safehouse_edit_loadout(var_2);
  } else if(var_3 < 0.5 && !var_0) {
    if(var_6 != 1) {
      level thread airstrike_canbeused(var_2, 1, 0, 0);
      var_2.trial_mount_nag = [];
    }
  }

  var_18 = var_2._id_13A12;

  if(var_3 > 0.5 && var_0) {
    if(var_18 != 3)
      airstrike_addactivestrike(var_2, 3);
  } else if(var_3 < 0.5 && var_0 || var_3 > 0.5 && !var_0) {
    if(var_18 != 2)
      airstrike_addactivestrike(var_2, 2);
  } else if(var_3 < 0.5) {
    if(var_18 != 1)
      airstrike_addactivestrike(var_2, 1);
  }
}

all_end_checkpoints_activated(var_0) {
  if(isDefined(var_0._id_11E61)) {
    if(gettime() < var_0._id_11E61)
      return;
  }

  var_1 = var_0.trigger.origin;
  level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_1, "_encstr_8218041DF5FA", 3);
  var_2 = 15000;
  var_0._id_11E61 = gettime() + var_2;
}

all_obit_models(var_0) {
  if(isDefined(var_0.isloadinggulag)) {
    if(gettime() < var_0.isloadinggulag)
      return 0;
  }

  var_1 = 5000;
  var_0.isloadinggulag = gettime() + var_1;
  return 1;
}

all_alive_players(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1._id_13D1A];
  var_2 notify("_encstr_8BEF1AC06AD86B0990832F6B2D0708FB4871DB61879A6C915897F159");

  if(!scripts\engine\utility::array_contains(var_1.trigger._id_13DC7, var_0))
    var_1.trigger._id_13DC7 = scripts\engine\utility::array_add(var_1.trigger._id_13DC7, var_0);

  var_1 thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
  var_3 = scripts\engine\utility::array_contains(var_2.weapongetflinchtype, var_0.team);
  var_4 = scripts\engine\utility::array_contains(var_2.trial_mount_nag, var_0.team);

  if(!var_3 && var_4 && istrue(var_1.playerkilled_washitbyvehicle))
    var_1.playerkilled_washitbyvehicle = 0;

  var_5 = var_1.claimteam == "_encstr_8BBA05185F8B99" || istrue(var_1.stalemate);

  if(!istrue(var_2.stopdragonsbreathburning) && !var_3 && !var_5)
    all_end_checkpoints_activated(var_1);

  if(!var_4 && !var_3) {
    var_6 = "_encstr_8E0123B9E3B911BB41EF483BC0D1397309D0C3F39FABC761493C319397EE8B3F7FB3091B5F";
    all_alive_players_near_exfil(var_1, var_6);
  }

  if(!isDefined(var_1._id_11F63) || !var_1._id_11F63) {
    var_1._id_11F63 = 1;
    var_7 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_9 in var_7)
    var_9 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }

  if(!istrue(var_2.stopdragonsbreathburning) && !scripts\engine\utility::array_contains(var_2.trial_missionscript_init_funcs, var_0)) {
    var_2.trial_missionscript_init_funcs = scripts\engine\utility::array_add(var_2.trial_missionscript_init_funcs, var_0);
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_8D820FA9325309B06AEF7B7DECD7E0D8B2");
  }

  all_modes(var_1);
}

all_alive_players_entites(var_0, var_1, var_2) {
  var_3 = self;
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);

  if(var_2)
    aitype_counts(var_1);

  all_modes(var_3);
}

airstrikecount(var_0) {
  var_1 = level.spawn_and_enter_little_bird_mg[var_0._id_13D1A];
  var_2 = getdvarint("_encstr_AAFF1A83A8557923EB30F0F828F3BB3F93B17ADA70B76A674103D5FB", 250);
  var_3 = var_2 + 15;
  var_4 = var_3 * var_3;
  var_5 = [];

  for(var_6 = var_0.trigger._id_13DC7.size - 1; var_6 >= 0; var_6--) {
    var_7 = var_0.trigger._id_13DC7[var_6];
    var_8 = distance2dsquared(var_7.origin, var_0.trigger.origin);
    var_9 = var_8 > var_4;
    var_10 = scripts\engine\utility::array_contains(var_1.weapongetflinchtype, var_7.team);

    if(!var_9 && !var_10)
      var_5[var_5.size] = var_7;
  }

  return var_5;
}

airstrikeid(var_0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return 0;

  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  return distance2dsquared(var_1, var_0) > var_2 * var_2;
}

all_gas_trap_structs(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(var_0.touchlist[var_5].size > 0) {
      var_3++;
      var_6 = var_0.touchlist[var_5];
      var_7 = getarraykeys(var_6);

      for(var_8 = 0; var_8 < var_7.size; var_8++) {
        var_9 = var_6[var_7[var_8]].player;
        var_2[var_2.size] = var_9;
      }
    }
  }

  var_11 = [];

  foreach(var_9 in var_1) {
    if(!scripts\engine\utility::array_contains(var_2, var_9))
      var_11[var_11.size] = var_9;
  }

  return [var_2, var_11, var_3];
}

all_modes(var_0) {
  var_1 = level.spawn_and_enter_little_bird_mg[var_0._id_13D1A];

  if(istrue(var_1.stopdragonsbreathburning)) {
    return;
  }
  var_1.stopdragonsbreathburning = airstrikeid(var_0.trigger.origin);

  if(istrue(var_1.stopdragonsbreathburning)) {
    airstrike_addactivestrike(var_1, 0);
    level thread airstrike_canbeused(var_1, 1, 0, 0);
  }

  var_2 = var_0.trigger._id_13DC7;
  [var_4, var_5, var_6] = all_gas_trap_structs(var_0, var_2);
  var_0.trigger._id_13DC7 = var_4;

  foreach(var_8 in var_5) {
    var_8 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
    var_8 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  }

  var_10 = var_0.curprogress / var_0.usetime;

  foreach(var_12 in var_4) {
    var_13 = scripts\engine\utility::array_contains(var_1.weapongetflinchtype, var_12.team);

    if(var_1.stopdragonsbreathburning) {
      var_12 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
      var_12 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      continue;
    }

    if(var_13) {
      var_12 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 1);
      var_12 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 13);
      continue;
    }

    var_12 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_10);

    if(var_6 > 1 || var_0.claimteam == "_encstr_8BBA05185F8B99" || var_0.claimteam == "_encstr_A7A408B9CA5D1D4E2C63" || istrue(var_0.stalemate)) {
      var_12 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 20);
      continue;
    }

    if(var_0.claimteam == var_12.team) {
      var_12 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 18);
      continue;
    }

    var_12 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 20);
  }

  if(var_1.stopdragonsbreathburning)
    var_1 setscriptablepartstate("_encstr_ACE50BDF2250298803A850F80D", "_encstr_95DF070DD22319CA9B", 0);
  else if(var_6 > 1)
    var_1 setscriptablepartstate("_encstr_ACE50BDF2250298803A850F80D", "_encstr_957407BAC223B9F05B", 0);
  else if(var_6 == 1) {
    var_1 setotherent(var_0.claimplayer);
    var_1 setscriptablepartstate("_encstr_ACE50BDF2250298803A850F80D", "_encstr_AA93094C36EA59FA4EB2C8", 0);
  } else
    var_1 setscriptablepartstate("_encstr_ACE50BDF2250298803A850F80D", "_encstr_998806DD1A96D12B", 0);
}

airlock_doors() {
  var_0 = [];
  var_0[var_0.size] = [26, 36, 2, 0, 18, 19, 36, 0];
  var_0[var_0.size] = [27, 36, 18, 19, 14, 13, 4, 36, 14, 5];
  var_0[var_0.size] = [28, 36, 8, 2, 4, 36, 0, 13, 3, 36, 18, 13, 14, 22];
  var_0[var_0.size] = [29, 36, 8, 13, 19, 14, 36, 12, 14, 11, 19, 4, 13];
  var_0[var_0.size] = [30, 36, 3, 4, 15, 19, 7, 18, 36, 5, 0, 17];
  var_0[var_0.size] = [31, 36, 1, 4, 11, 14, 22, 36, 19, 7, 4, 13];
  var_0[var_0.size] = [32, 36, 8, 11, 4, 36, 15, 17, 4, 24];
  var_0[var_0.size] = [33, 36, 14, 5, 36, 1, 11, 14, 14, 3];
  var_0[var_0.size] = [34, 36, 17, 14, 3, 36, 4, 24, 4, 18];
  var_0[var_0.size] = [26, 35, 36, 11, 0, 24, 36, 3, 14, 22, 13];
  var_0[var_0.size] = [26, 26, 36, 24, 14, 20, 17, 36, 0, 17, 12, 18];
  var_0[var_0.size] = [26, 27, 36, 19, 14, 36, 2, 11, 0, 8, 12];
  var_0[var_0.size] = [26, 28, 36, 24, 14, 20, 17, 36, 15, 17, 8, 25, 4];
  return var_0;
}

airlock_slot(var_0) {
  if(getdvarint("_encstr_8BA61833AAA3CF3AD009D8783F1F4FADB6E3915F7D5F83BFCFB5", 0) == 0) {
    return;
  }
  var_1 = level.spawn_and_enter_little_bird_mg[var_0];
  var_2 = airlock_doors();
  var_3 = randomint(var_2.size);
  var_4 = getdvarint("_encstr_B25A2120F94B610ED53FFB1A401F28CFF520B15971D1A0074B77D1CFAD1FEF9B2B9003", -1);

  if(var_4 != -1)
    var_3 = var_4;

  level thread airlock_show_front_doors(var_2[var_3], var_1, ::airlock_positions, ::airlock_pivot);
}

airlock_callbuttons() {
  var_0 = [];
  var_0[0] = "_encstr_971704C51069";
  var_0[1] = "_encstr_9118081D563636FDB9C2";
  var_0[2] = "_encstr_A21808D204C50169405C";
  var_0[3] = "_encstr_8313063D5A18FA17";
  var_0[4] = "_encstr_BD4C024E";
  var_0[5] = "_encstr_B10E08E208C540691017";
  var_0[6] = "_encstr_821306A504A510B8";
  var_0[7] = "_encstr_8F0E0871408B01C510E2";
  var_0[8] = "_encstr_AD17048B40E2";
  var_0[9] = "_encstr_9339088B046901694096";
  var_0[10] = "_encstr_A51306FDA7E5BEED";
  var_0[11] = "_encstr_8339080AFA55712D6EED";
  var_0[12] = "_encstr_931704309626";
  var_0[13] = "_encstr_A117045A0417";
  var_0[14] = "_encstr_9613066EB929428D";
  var_0[15] = "_encstr_A3390875764629CE80E8";
  var_0[16] = "_encstr_B1EC0823465D81F2E20E";
  var_0[17] = "_encstr_827D061704D240E2";
  var_0[18] = "_encstr_867D064017172F50";
  var_0[19] = "_encstr_884C0296";
  var_0[20] = "_encstr_9B7D0665FFADF6D5";
  var_0[21] = "_encstr_A30E08E2513A5E6A411D";
  var_0[22] = "_encstr_8E7D06C5084B405A";
  var_0[23] = "_encstr_AC1808CBB0058A9002AE";
  var_0[24] = "_encstr_95180802B812627D7A63";
  var_0[25] = "_encstr_BAEC0861D84EF95D0EEE";
  var_0[26] = "_encstr_9B0E0A5C085A804B80960296";
  var_0[27] = "_encstr_8E4C0A88801AA1F3A666BAAA";
  var_0[28] = "_encstr_ABB60AF8DA72AF6062BBAA12";
  var_0[29] = "_encstr_87B60AC8063E12171E9A696B";
  var_0[30] = "_encstr_92B60A5C8071405C04C508C5";
  var_0[31] = "_encstr_8A9F0A2ED98096BE8A4076FD";
  var_0[32] = "_encstr_9A8D0AB4805A028B10C58071";
  var_0[33] = "_encstr_810D0A4E9AC39E268990A056";
  var_0[34] = "_encstr_AB0D0A4B105A01D280A510C5";
  var_0[35] = "_encstr_930D0AE5BFEBB695B9AA4A66";
  var_0[36] = "_encstr_854C021F";
  return var_0;
}

airlock_show_front_doors(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 notify("_encstr_8F370D63FCE9A96D68F74643E9305B");
  var_1 endon("_encstr_8F370D63FCE9A96D68F74643E9305B");
  var_1._id_12744 = 1;
  var_4 = 0.5;
  var_5 = airlock_callbuttons();

  foreach(var_7 in var_0) {
    if(var_5[var_7] == "_encstr_854C021F") {
      [[var_3]](var_1);
      wait(var_4 * 7);
      continue;
    }

    var_8 = var_5[var_7];
    var_9 = strtok(var_8, "_encstr_974C0246");

    foreach(var_11 in var_9) {
      if(var_11 == "_encstr_BD4C024E") {
        [[var_2]](var_1);
        wait(var_4);
        [[var_3]](var_1);
      } else if(var_11 == "_encstr_884C0296") {
        [[var_2]](var_1);
        wait(var_4 * 3);
        [[var_3]](var_1);
      }

      [[var_3]](var_1);
      wait(var_4);
    }

    [[var_3]](var_1);
    wait(var_4 * 3);
  }

  [[var_3]](var_1);
  wait(var_4 * 7);
  var_1._id_12744 = 0;
  level thread airstrike_canbeused(var_1, var_1._id_13D1B, 0, 0);
}

airlock_positions(var_0) {
  var_0 setscriptablepartstate("_encstr_9AD50BF4237933936F798A1258", "_encstr_95DF070DD22319CA9B", 0);
  var_0 setscriptablepartstate("_encstr_916A0AD8B4761A1DB9EBDE9B", "_encstr_BE8B08E323FB2BCD6268", 0);
}

airlock_pivot(var_0) {
  var_0 setscriptablepartstate("_encstr_9AD50BF4237933936F798A1258", "_encstr_BE8B08E323FB2BCD6268", 0);
  var_0 setscriptablepartstate("_encstr_916A0AD8B4761A1DB9EBDE9B", "_encstr_95DF070DD22319CA9B", 0);
}

airlock_show_doors(var_0) {
  var_1 = (11188, 13178, 7261);
  var_2 = distance(var_1, var_0.origin);
  var_3 = 200;
  var_4 = var_2 <= var_3;

  if(var_4)
    var_0._id_13442 = 1;
}

airlock_show_back_doors(var_0) {
  if(istrue(var_0._id_13442)) {
    var_1 = istrue(var_0.play_found_leads_counting_building_two);

    if(var_0 airlock_show_room_doors() && !var_1) {
      var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_B2A714E84B96B32CB948A20AA98FE5872B216D8C5559");
      var_0.play_found_leads_counting_building_two = 1;
      airlock_front_blocker(var_0);
    }
  }
}

airlock_front_blocker(var_0) {
  var_1 = "_encstr_8A071D3933CF9E38FDFF7F53E66389DEDFAAB301E9C74DF814DD456F2F1ABA";
  var_0 playsoundtoplayer(var_1, var_0, var_0);
  var_0 playsoundtoplayer("_encstr_8F401B8E53C61BCB408763B8AF95289FCFEBB793E0BFB79B531D556BD5", var_0);
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_97FA168939EBA393CA2BBE93A53219C659D737B71B3B2B23");
  _encstr_9A7029E33EC32F9A69E086BAE00797C798956C71CF491F756D93897228D9C14F308DC5DFED11D77D1F30B2::ai_ascender_animloop(var_0.origin, var_0.angles);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_vehicle_on_pilot_death(var_0);
}

airlock_show_room_doors() {
  if(!isDefined(self) || !isPlayer(self))
    return 0;

  var_0 = self;
  return istrue(var_0.unset_relic_punchbullets);
}

airdrop_playdeploydialog(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }
  var_5 = getcompleteweaponname("_encstr_AB0B08D8BD58B1EBB607");

  if(var_3 hasweapon(var_5) && var_3 getammocount(var_5) > 0) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_BDBE0C2627B1F6DE477D6CDB2C8D", "_encstr_95DF070DD22319CA9B");
  var_3 thread _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerplaypickupanim();
  var_3 scripts\mp\equipment::giveequipment("_encstr_BAE40BE50A03834317CF40389B", "_encstr_BA7F0830B3A7859B60B0");
  var_3 playlocalsound("_encstr_99360F4C937D39EDD85BD738D2B1D6AEE0");
}

airstrike_movewithplane(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }
  var_5 = getcompleteweaponname("_encstr_BA410C6338E0D79EC39832198839");

  if(var_3 hasweapon(var_5) && var_3 getammocount(var_5) > 0) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_AC4D10130810CF5241AF6A25703FFA897860", "_encstr_95DF070DD22319CA9B");
  var_3 thread _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerplaypickupanim();
  var_3 scripts\mp\equipment::giveequipment("_encstr_AC7B0F58B7054089918260F89B1AF3A874", "_encstr_BA7F0830B3A7859B60B0");
  var_3 playlocalsound("_encstr_99360F4C937D39EDD85BD738D2B1D6AEE0");
  airlock_show_doors(var_3);
}

airstrike_watchgameend() {
  var_0 = self;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", 4);
  wait 2;

  if(isDefined(var_0))
    var_0 delete();
}

airstrike_watchownerdisown(var_0, var_1, var_2) {
  if(var_0 == "_encstr_AB0B08D8BD58B1EBB607") {
    var_2 playlocalsound("_encstr_8B8D1C264A6E6F1581906FC1AAAD095F38B9E551C06B83F7FF5B2BC11BA9");
    airdrop_crushchicken(var_2);
  } else if(var_0 == "_encstr_BA410C6338E0D79EC39832198839")
    playFXOnTag(level._id_13443["_encstr_8BE007AB0FE8607F9B"], var_2, "_encstr_AADA07DBF19A4A81D7");
}

airdrop_crushchicken(var_0) {
  var_0 thread scripts\mp\equipment\gas_grenade::gas_applycough(var_0, 1);
  playfxontagforclients(level.helidrivableenablesiteonflyaway["_encstr_852907B9D8C959B2CD"], var_0, "_encstr_A130084D2FDAD8AA8F62", var_0);
  playFXOnTag(level.helidrivableenablesiteonflyaway["_encstr_8BE007AB0FE8607F9B"], var_0, "_encstr_AADA07DBF19A4A81D7");

  if(isDefined(level.playerentercombatareamessage))
    var_0[[level.playerentercombatareamessage]]();
}

airlock_button_l() {
  var_0 = scripts\cp_mp\utility\game_utility::tutorialzoneenter();
  var_1 = getdvarint("_encstr_A1281960CA62BF49C34F242C77D3908B8A9160E0C3FF5983479635", 1) == 0;
  return !var_0 && !var_1;
}

airlock_button_think() {
  var_0 = [];
  var_0[var_0.size] = "_encstr_A28F2313E41BBDBD3AFABB9585E0B737F5CDDCAFD1C92ED5D236DADCC6BDC12BFA2B1CA5C6";
  var_0[var_0.size] = "_encstr_AAC822982736DEF6A3D7DD2B58C1F6DCD7B99B7DD193C1F6DDCA4EE656B62DBE8D59EC59";
  var_0[var_0.size] = "_encstr_851B21A2BD397750A409908A6250D0788136805E0B73F095DB0B477B846537095F2F83";
  var_0[var_0.size] = "_encstr_978321314ED8B77BE8F5DD2B1683DB377DCD5BD78E4E1B0BE0588D2DA397BE4E169CB2";
  var_0[var_0.size] = "_encstr_82881E989336DBF61DAFEE2BB083DE37F5E65BF5A3E426BA9CB947AF935893AC";
  var_0[var_0.size] = "_encstr_939F2113686C78BD79878F820192BF8B4F11C37E3322A5EB13C4CD530B99F842334A2E";
  var_0[var_0.size] = "_encstr_8A95209ABAA8189AFB077CA9620B0A50B6C920795EC262053A6B322F835001A5EF39";
  return var_0[randomint(var_0.size)];
}

airlock_button_r(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = 0;

  if(var_0.type == "_encstr_8B2E22586B9989B8E714C8DF145FA16B7A415850F22BD5F6BF29EE43F5D7A93FA5CA4028") {
    var_5 = 15;
    var_4 = getdvarint("_encstr_969E23373693BE134EF50D0DAF367BD6B5B79BAF6C166C4356BE37DCF677EBC6A10BCDB1B2", var_5);
    var_6 = 5;
    var_3 = getdvarint("_encstr_A13F239BC6E4AF8927FA34A17D8DDBD6D67B73F51B2CC6342BD76CF6C2D8BEB1A1169BD8AC", var_6);
    var_7 = 5;
    var_2 = verifybunkercode("_encstr_ADAB1AAD0582F8E38B1AAEF162E324689AA72D1BBBEF593EB372C399", var_0._id_11A25);
  } else if(var_0.type == "_encstr_B640255EF299B1880F8BA940F34F01D323D14EDF8EB36D76EBF74043BF4F7813CAC7486D663B0B") {
    var_8 = 15;
    var_4 = getdvarint("_encstr_A39626FFD7C2B988EB11430809FA4BB43B33FC032331F13A07F8BAE3D726D007483F9F628952E928", var_8);
    var_9 = 15;
    var_3 = getdvarint("_encstr_84D2261B30CDF1AB53B8786050787F071BB0F2B29373B9D7699E706548A10FCEA1A10A9AF0056E07", var_9);
    var_7 = 5;
    var_2 = verifybunkercode("_encstr_95911A1995CE996F2B5597EF9DE5C59713B1F4FBDCFA1F4F73412B2B", var_0._id_11A25);
  } else if(var_0.type == "_encstr_8EF923721BF8EB8518812F195930CE471656FBDBC144ABF120930BE85349D45731080272AA") {
    var_10 = 10;
    var_4 = getdvarint("_encstr_8D7724A3DFF2894E7328F48061C8D5937180C948E7133E29E399EEAB9B18502176C3610D7EAF", var_10);
    var_11 = 30;
    var_3 = getdvarint("_encstr_9164240BD64B511A4A376360C938E8D90C7B71179F9106E9C0EF816E974B59801321492DBEDF", var_11);
    var_7 = 5;
    var_2 = verifybunkercode("_encstr_8CF41BA80FEB1B43EBDFD0443743B5A0324F8870D382F177820237550F", var_0._id_11A25);
  } else {}

  var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_A5820FAEC0B1AAE1EB713723A301D431BB");
  var_12 = randomint(100);
  var_13 = var_12 <= var_3;
  var_14 = var_12 > var_3 && var_12 <= var_3 + var_4;

  if(!isDefined(var_1._id_136CA))
    var_1._id_136CA = [];

  var_15 = !scripts\engine\utility::array_contains(var_1._id_136CA, var_0.spawn_maint_wave);
  var_16 = 15;
  var_17 = getdvarint("_encstr_969E23373693BE134EF50D0DAF867BC6A53258BCEB268DAB56E027D2E647EBC6A10BCDB1B2", var_16);
  var_12 = randomint(100);
  var_18 = var_12 <= var_17;

  if((var_18 || var_14) && airlock_button_l())
    var_2[var_2.size] = airlock_button_think();

  if(getdvarint("_encstr_928413BBE1B6EF0E081FC9DC51399567D559F172E9", 0) > 0 && getdvarint("_encstr_968616DCB1C9FA4CC9FACCCCF532ED57896395AF36C2E686", 0) > 0) {
    if(var_0.type == "_encstr_8B2E22586B9989B8E714C8DF145FA16B7A415850F22BD5F6BF29EE43F5D7A93FA5CA4028")
      var_2[var_2.size] = "_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC";
    else if(var_0.type == "_encstr_B640255EF299B1880F8BA940F34F01D323D14EDF8EB36D76EBF74043BF4F7813CAC7486D663B0B")
      var_2[var_2.size] = "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2";
    else if(var_0.type == "_encstr_8EF923721BF8EB8518812F195930CE471656FBDBC144ABF120930BE85349D45731080272AA")
      var_2[var_2.size] = "_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3";
  }

  if(var_15) {
    if(var_13) {
      playFX(scripts\engine\utility::getfx("_encstr_87B21FB3D2A807F10B97F9608F3B1EC7562A6810B944AF083FD47763A79FC08B7D"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
      var_2 = [];
      var_2[var_2.size] = "_encstr_BDBE0C2627B1F6DE477D6CDB2C8D";
      var_19 = "_encstr_8F181DCC9B4E2B024369BB920899B19761084441A0306F8B0FE8D3EB992B22";
      var_1 playsoundtoplayer(var_19, var_1, var_1);
      airdrop_crushchicken(var_1);
      var_1._id_136CA = scripts\engine\utility::array_add(var_1._id_136CA, var_0.spawn_maint_wave);
    } else if(var_14) {
      var_2[var_2.size] = "_encstr_AC4D10130810CF5241AF6A25703FFA897860";
      var_20 = "_encstr_8DB71A92DA78534288578399DDA8C1EF9FF00B4A8648377E906FD930";
      var_1 playsoundtoplayer(var_20, var_1, var_1);
      var_1._id_136CA = scripts\engine\utility::array_add(var_1._id_136CA, var_0.spawn_maint_wave);
    }
  }

  return var_2;
}

airdrop_watchforcrateuseend(var_0) {
  var_1 = getdvarint("_encstr_8613133BA9A3BFCDD88713C091BAF19D7B6AC4DF22", 0) == 1;

  if(var_1)
    iprintlnbold("_encstr_B4CC059021D140" + var_0);
}