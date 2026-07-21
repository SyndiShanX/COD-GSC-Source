/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_embassy\cp_so_embassy.gsc
***************************************************/

main() {
  _id_11C1E();
  thread labelpc();
  thread _id_12BCF((-3688.5, -1275.5, 128));
  thread _id_12BCE((-2009.28, -486.884, 60), "_encstr_8C1E0E1E71911A29BED8B7A73096B8D7");
  thread _id_13927((-3718.76, -1644.87, 40), 100);
  thread lb_dmg_factor_main_rotor((2156, 1629, 92), 200);
  thread lb_dmg_factor_main_rotor((-1022.36, -1363.69, 84), 100);
  scripts\cp\laser_traps\cp_laser_traps::init_minigun_lifetime_shot_count("_encstr_92410E9F11F2E8C8EF0B3BC3B28F80AA", (2311.76, 1671.9, 54.1039), (2311.76, 1595.9, 54.1039), (0, 270, 0), "_encstr_81E5133403D99507481F071978AFCD2277A7ED5B93", (2324, 1641.94, 127.054));
  scripts\cp\laser_traps\cp_laser_traps::init_minigun_lifetime_shot_count("_encstr_BE62101B9BDDC5C7A8B95E8F6AB05DB5616B", (-166.454, 139.447, 46.5), (-165.454, 183.947, 195), (0, 90, 0), "_encstr_AD070A9AA0DA58ED2376F073");
  level.increase_total_count_per_module_call = 1;
  _id_12844();
  init_flags();
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  thread monitoraveragevelocityandupdate();
  scripts\cp\utility::coop_mode_enable();
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::registerscriptedagents();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  _encstr_BEE539FF287B513BA9FE858E6737A2E1839B1637483683F2A79D1DC6C7779BB1E518E33FF868F79A2B2666BA364B11607340174FE02005760746EE::main();
  _encstr_83CA381B42BBDBE87B13079738F55897DB3B1881DBB70ED8591DBB8D51CA60637ED229A8B6AFC7216AFFD78B7576C82EA7ABE6F18BAB502802CB::main();
  _encstr_BEB433F05AF2A37BABF3103EE81EAD7BDAE39AE803C1CFD02F0DC9A6D1078BF3D50AD881AB655FA99F32C726BB17F6856846E89802::main();
  setdvarifuninitialized("_encstr_AA5C11E338661FDD4570435BA8E79293191E6C", 0);

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\vehicle::init_vehicles();
  level thread scripts\cp\cp_objectives::objectives_init();
  level._id_12177 = 1;
  level.hostdamagefactorlow = 0;
  level._id_133BA = 1;
  level.map_interaction_func = _encstr_B24A3DEF386B412BD98EF59E7707B2117310262738269302B7AD6DD6D767ABC130E8D34FC898C7EA3B36768AC65B2169E0F81F73E071241267D8FAD524373A::register_interactions;
  level.custom_onspawnplayer_func = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_124A6;
  level.custom_onplayerconnect_func = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::onplayerconnect;
  level.weapon_rank_event_table = "_encstr_961D41B6D62BDB0B74378AF023F76003B37A97366A91B7D0778790F04FC3FB8BAEE62750024A27D93DA308407FF1B6DF528E9FC0DD332360133F20600F0EABB59AB214";
  level.player_interaction_monitor = _encstr_B24A3DEF386B412BD98EF59E7707B2117310262738269302B7AD6DD6D767ABC130E8D34FC898C7EA3B36768AC65B2169E0F81F73E071241267D8FAD524373A::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_B24A3DEF386B412BD98EF59E7707B2117310262738269302B7AD6DD6D767ABC130E8D34FC898C7EA3B36768AC65B2169E0F81F73E071241267D8FAD524373A::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1247B;
  level.mud_sfx = ::mud_sfx;

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  level thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::wait_for_pre_game_period();
  level thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::wait_for_strike_init_complete();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  level.devgui_setup_func = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  var_0 = getDvar("_encstr_A347188E303F2B97990230707AAA67A2E7DB8D77AA3B16CFBE9A", "_encstr_B40101");

  if(isDefined(var_0) && var_0 != "_encstr_B40101")
    level thread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::rundebugstartobjective(var_0);

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_A9B21A36DEB5380B6EB9FAD658E07DD807AF377BF559AD2685E637F2");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_init("_encstr_9BB1136BBDDE462FAF473985D95693CD588DF57B73");
  level.vehicle.templates.deathmodel["_encstr_B4C21F1B8273D3311EA9550FC405B028AB3A3140CA572EA832AC3317F7EA708D9B"] = "_encstr_917D2AB3B2D01CFAC6A5ECD71BE691AF1DB21BD0B7EB9C5931AC8DFA37D1C2D1D2D8AF32E6D1F53BC99595CD";
  thread monitorcontrolscallback();
}

mud_sfx(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    return 0;

  var_1 = 60000;

  if(level.time_survived < 12 * var_1)
    return 3;
  else if(level.time_survived < 14 * var_1)
    return 2;
  else if(level.time_survived < 20 * var_1)
    return 1;

  return 0;
}

handle_train_collision_items(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = sortbydistance(var_3, var_0);

  foreach(var_6, var_5 in var_3) {
    if(var_6 > 5) {
      break;
    }

    var_5 delete();
  }
}

lb_dmg_factor_main_rotor(var_0, var_1) {
  var_2 = getnodesinradius(var_0, var_1, 0, 200);

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.type, "_encstr_845E066577577837"))
      destroynavlink(var_4);
  }
}

player_fired_gun() {
  var_0 = getnodesinradius((2156, 1629, 92), 100, 0, 500);
  var_1 = [];

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.type, "_encstr_845E066577577837")) {
      var_1[var_1.size] = var_3;

      if(isDefined(var_3.target)) {
        var_4 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_1[var_1.size] = var_4;
        var_5 = getnode(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_1[var_1.size] = var_5;
      }
    }
  }

  foreach(var_8 in var_1)
  var_8.origin = var_8.origin + (150, 0, 0);

  var_1[0] connectpaths();
}

labelpc() {
  var_0 = [];
  var_0[var_0.size] = "_encstr_8F0321E859D843E6B41B58C6FA47395DB16DFACDC1B0EE3795C9FA0689FA3ACAB186DB";
  var_0[var_0.size] = "_encstr_BE291BDC63B0B40B03D1D20A3EE523AB18C77F43A158BBC33DEB49D7CB";
  var_0[var_0.size] = "_encstr_9BFA213A2BD81AB9961B8536EB4739D56CB6F5CD070BEE732BE4D70353AFA3956C0DED";
  var_0[var_0.size] = "_encstr_91291B50A22E2930A76BBF217FFB7BAB96EA91E08BC65F084F82A8070D";
  var_0[var_0.size] = "_encstr_B2AF218D91A884F6F396873461310253D897B70A8B4FDC0829C26F770D09D03D86D0D7";
  var_0[var_0.size] = "_encstr_AC291B71FD4ED0B82FB251F899B36EE0E65B9FF770B660F027BB6E6B17";
  var_0[var_0.size] = "_encstr_96E6211D7F12F1D0719F0B608784AB33FA64AF26926A879825E3E97A2E97235B424C80";
  var_0[var_0.size] = "_encstr_B8291BE388678423B83EE9ECD8E3AB0B8F60D92B883B3B6B119ECF48C6";

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_2 == "_encstr_BE291BDC63B0B40B03D1D20A3EE523AB18C77F43A158BBC33DEB49D7CB") {
      var_4 = getvehiclenode(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level._id_13DE1 = var_4;
    } else if(var_2 == "_encstr_96E6211D7F12F1D0719F0B608784AB33FA64AF26926A879825E3E97A2E97235B424C80") {
      var_4 = getvehiclenode(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level._id_13DE2 = var_4;
    } else if(var_2 == "_encstr_B2AF218D91A884F6F396873461310253D897B70A8B4FDC0829C26F770D09D03D86D0D7") {
      var_4 = getvehiclenode(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      level._id_13DE3 = var_4;
    }

    var_5 = getaiarrayinradius(var_3.origin, 500, "_encstr_8E8405EA382B2A");

    foreach(var_7 in var_5)
    var_7 kill();

    var_3 delete();
  }
}

_id_12BCF(var_0) {
  var_1 = getentarrayinradius(undefined, undefined, var_0, 1500);

  foreach(var_3 in var_1) {
    if(var_3.classname == "_encstr_A17F1AAC0D6227911B6037C2ED18ABAC10B11727B119E83F31BBEF23")
      var_3 delete();
  }
}

_id_12BCE(var_0, var_1) {
  var_2 = getentarrayinradius(undefined, undefined, var_0, 1500);

  foreach(var_4 in var_2) {
    if(var_4.classname == "_encstr_A17F1AAC0D6227911B6037C2ED18ABAC10B11727B119E83F31BBEF23") {
      if(scripts\engine\utility::is_equal(var_4.script_flag, "_encstr_A3E40C5E30F0BA286BA39398FE9C"))
        var_4 delete();
    }
  }
}

_id_13927(var_0, var_1) {
  var_2 = getnodesinradius(var_0, var_1, 0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_flag_wait))
      var_4.script_flag_wait = undefined;
  }
}

_id_11CF3(var_0, var_1) {
  var_2 = getnodesinradius(var_0, var_1, 0, 200);

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.type, "_encstr_845E066577577837"))
      var_4 _id_11CF4();
  }
}

_id_11CF4() {
  scripts\engine\utility::flag_set("_encstr_9BB1136BBDDE462FAF473985D95693CD588DF57B73");
  badplace_global("_encstr_AC6310E037E70973896B56D7C302AD535193", 10, "_encstr_8E8405EA382B2A");
  wait 10;
  scripts\engine\utility::flag_clear("_encstr_9BB1136BBDDE462FAF473985D95693CD588DF57B73");
}

_id_11CF5() {
  self endon("_encstr_AD75063D571AE108");

  while(isalive(self)) {
    self waittill("_encstr_9AC60F8143AFEE3F8348A9AE5A27975B88");

    if(!scripts\engine\utility::flag("_encstr_9BB1136BBDDE462FAF473985D95693CD588DF57B73"))
      getcorpstablestate(self.origin, 200);
  }
}

getcorpstablestate(var_0) {
  var_1 = getnodesinradius(var_0, 100, 0, 100);

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.type, "_encstr_845E066577577837"))
      var_3 _id_11CF4();
  }
}

_id_11C1E() {
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1[0] = (5128.15, 2125.27, 25);
  var_1[1] = (-5632.05, -4150.08, 25);

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_1[var_4])) {
      var_3 delete();
      continue;
    }

    var_3.origin = var_1[var_4];
  }
}

display_ai() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (1, 1, 0);
  var_1 = (0, 1, 0);
  var_2 = (1, 0, 0);
  var_3 = ["_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08", "_encstr_BE7D0633C08849E2"];

  for(;;) {
    var_4 = 30;

    foreach(var_6 in var_3) {
      if(var_6 == "_encstr_BE7D0633C08849E2")
        var_7 = getaiarray().size;
      else
        var_7 = getaiarray(var_6).size;

      if(var_7 < 20)
        var_8 = var_1;
      else if(var_7 < 30)
        var_8 = var_0;
      else
        var_8 = var_2;

      var_4 = var_4 + 15;
    }

    waitframe();
  }
}

_id_12844() {}

monitoraveragevelocityandupdate() {
  setsaveddvar("_encstr_8D9E0B35D2E439399E27C4A62D", 4);
  setsaveddvar("_encstr_A55E0B9920E56534475B253D6C", 5);
  setsaveddvar("_encstr_A7F10BDB5966F39BFA13DB52CD", 1);
  setsaveddvar("_encstr_916D0BC529F15CBF309770E97C", "_encstr_8A601113198304991CA102D80D03024C0C91A1");
  setsaveddvar("_encstr_BE360B89A215A69A0AD229B47A", 6);
  level.spotupdatelimit = getdvarint("_encstr_BE360B89A215A69A0AD229B47A");
  setsaveddvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  level.roundrobinlimit = getdvarint("_encstr_91070B6BA23D9140AB28DFA4C4");
  setsaveddvar("_encstr_88060B49BC98F12F2F63C13907", 750);
  level.spotdistcull = getdvarint("_encstr_88060B49BC98F12F2F63C13907");
  var_0 = getEnt("_encstr_ABFB1C0EC94BB1CAFA76C9952BDCF5C4CA85ADD7665A1B36BE63D2EC43D1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 setlightintensity(0);
  var_1 = getEnt("_encstr_8CF41B1853F1F95B795F46C53782E70125B748E9CB99707772C4345B4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 setlightintensity(0);
  level.flare_light = getEnt("_encstr_A1EF0FF073A1F37341379B308D1A4F781C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.flare_light_up = getEnt("_encstr_866412CC8D859C95EB330FD71B2D9D0D8EFAD5E0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.flare_light.og_angles = level.flare_light.angles;
  level.flare_light setlightintensity(0);
  level.flare_light_up setlightintensity(0);
  level.flare_light.intensity = undefined;
  level.flare_lifetime = 20;
  level._id_13AF4 = 0;
  level.jumpcomandsregistered = 0;
  level.vfx_htown_stab_blink_2 = 0;
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::_id_13AF6();
  createthreatbiasgroup("_encstr_9775086022BE1B413B8B");
  createthreatbiasgroup("_encstr_9A8507BA4040188D08");
  createthreatbiasgroup("_encstr_8E8405EA382B2A");
  setthreatbias("_encstr_9775086022BE1B413B8B", "_encstr_8E8405EA382B2A", 10000);
  setthreatbias("_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", 9000);
  var_2 = getEnt("_encstr_88290C99EF93882D0B5976074F4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 hide();
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::starscores();
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::openbunkerdoor();
  thread mid_encounter_package_thread();
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::_id_13D20();
  thread wavetime();
  thread _id_12A61();
  thread _id_11C4A();
  thread _id_13D1F();
  thread chopper_boss_fight_stage_trigger_think();
  thread set_relic_healthpacks();
  thread _id_1305C();
  thread set_relic_hideobjicons();
  thread playscorestatusdialog();
  thread _id_12D3C();
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::createheliextractobjectiveicons();
}

_id_12D3C() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_833F1B9FBD9F1DEBA9E3392FAFCB1A36FE84B7DAE1D601BF0B8C01437B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(var_2.origin[1] < 20)
      var_2.origin = var_2.origin + (1870, 0, 0);
  }
}

_id_11C4A() {
  var_0 = [(-3522, -1400, 94), (-3475, -1400, 94), (-3381, -1400.5, 94), (-3334, -1400.5, 94)];

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_3.angles = (0, 90, 0);
    var_3 setModel("_encstr_BA521E5B3355CAFF7B61374B1011BA423FD62955ADD9523486901F7B31495F0F");
  }

  var_5 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = [(-3493, -1398, 61), (-3345, -1398, 61)];

  foreach(var_2 in var_6) {
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_8.angles = (0, 0, -90);
    var_8 clonebrushmodeltoscriptmodel(var_5);
  }
}

playscorestatusdialog() {
  var_0 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [(977.5, -899, 20), (969, -885.5, 20), (952, -858.5, 20), (965, -848.5, 20), (982, -875.5, 20), (990.5, -889, 20)];

  foreach(var_3 in var_1) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_4.angles = (0, 32.647, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

_id_13D1F() {
  var_0 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [(-605, 380.5, 58), (-605, 380.5, 100)];

  foreach(var_3 in var_1) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_4.angles = (270, 182, 70.4329);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

chopper_boss_fight_stage_trigger_think() {
  var_0 = getEnt("_encstr_ADAC10810C0690E59B1F637BB3FE878218C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [(3235, 1478, 162), (3235, 966, 162), (3235, 452, 162), (3235, -60, 162), (3235, -572, 162), (3235, -1084, 162), (3235, -1595, 162), (258, -1944, 162)];

  foreach(var_3 in var_1) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_4.angles = (360, 270, 90);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

set_relic_healthpacks() {
  var_0 = getEnt("_encstr_815E0C7F0B2A8702B0C0DA9BABC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [(-3618.5, -1283, 12), (-3626, -1280, 12), (-3633.5, -1277, 12), (-3641, -1274, 12), (-3648.5, -1271, 12)];

  foreach(var_3 in var_1) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_4.angles = (0, 337.95, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

_id_1305C() {
  var_0 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [(-13.5, 682.5, 91), (-13.5, 682.5, 59), (-13.5, 682.5, 26), (19, 682.5, 91), (19, 682.5, 59), (19, 682.5, 26)];

  foreach(var_3 in var_1) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_4.angles = (0, 0, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

set_relic_hideobjicons() {
  var_0 = getEnt("_encstr_919109AA5148539DA0FDAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [(-2979, -945, 75)];

  foreach(var_3 in var_1) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_4.angles = (0, 270, 0);
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

wavetime() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_93AE1A8013CD0853694AB737A392A3130FD31810876E616702F7A445", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0];
  var_0.origin = (1774.81, 2060.01, 24.617);
  var_0 = scripts\engine\utility::getStructArray("_encstr_93AE1A8013CD0853694AB737A392A3130FD31810876E616702F7A445", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[4];
  var_0.origin = (1476.15, 2064.08, 25.617);
}

_id_12A61() {}

mid_encounter_package_thread() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1461.5, -166.5, 14));
  var_0 setModel("_encstr_88BC19F0993B7194C02340B9A11007BF6F3A0D5F9ADBF5E7D84A76");
  var_0.angles = (360, 270, 15.1987);
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1463.5, -166.5, 14));
  var_0 setModel("_encstr_88BC19F0993B7194C02340B9A11007BF6F3A0D5F9ADBF5E7D84A76");
  var_0.angles = (360, 270, 15.1987);
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2226, -742, 56));
  var_0 setModel("_encstr_88BC19F0993B7194C02340B9A11007BF6F3A0D5F9ADBF5E7D84A76");
  var_0.angles = (360, 270, 6.49972);
}

init_hacking_table() {
  scripts\cp\cp_hacking::parsehackingtable("_encstr_A5E224963AD6E71347A7406073918B1339A41F2E54EAB5B91F9713A877AB2343130F20A62AB3");
}

monitorcontrolscallback() {
  init_spawners();
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::laser_control_station_use_monitor();
  setdvarifuninitialized("_encstr_8E47138D0EBEDCB7EB46BD77E663DBC2231DD25BAC", 240);
  _id_14379();
  scripts\cp\laser_traps\cp_laser_traps::_id_13067();
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::supportboxmaxammo();
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("_encstr_8E8405EA382B2A", ::bomber_radiusdamage);
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("_encstr_9A8507BA4040188D08", ::brinitloadoutoption);
  thread handle_roof_spawning();
  thread _encstr_A98D36C8132B0A82435EC72E30A8CD87C12F35114231BBAF494F0DD6CBF8637326E2F1A9CB9D398FF141B14B18FBF040C5C99211B8F04BB3::_id_119E5();
  thread _encstr_A98D36C8132B0A82435EC72E30A8CD87C12F35114231BBAF494F0DD6CBF8637326E2F1A9CB9D398FF141B14B18FBF040C5C99211B8F04BB3::brloadoutcratepostcapture();
  thread _id_1321E("_encstr_8F440FE2BCBFA133FDE7DF8CF652872B6F");
  thread _id_1321E("_encstr_97C00CBEED476671CCAAF8ABB362");
  _id_1321F();
  _id_128BB();
}

handle_roof_spawning() {
  var_0 = [];
  var_0[var_0.size] = [(-1134.05, -846.12, 16.0001), (0, 231.999, 0)];
  var_0[var_0.size] = [(-984.887, 167.193, 17.677), (0, 231.999, 0)];
  var_0[var_0.size] = [(-1900.98, -476.227, 56), (0, 203, 0)];
  var_0[var_0.size] = [(-3451.62, -1114.86, 24), (0, 143, 0)];

  foreach(var_3, var_2 in var_0)
  thread scripts\cp\laser_traps\cp_laser_traps::_id_13542(var_2[0], var_2[1], 1);

  var_0 = [];
  var_0[var_0.size] = [(-1408.69, -274.433, 40.0001), (0, 231.999, 0)];
  var_0[var_0.size] = [(-2667.88, -1463.29, 24), (0, 143, 0)];
  var_0[var_0.size] = [(-506.67, -618.25, 56.9131), (0, 91, 0)];
  var_0[var_0.size] = [(-833.092, -258.4, 31.9999), (0, 234, 0)];
  var_0[var_0.size] = [(-717.092, 213.6, 31.9999), (0, 303, 0)];
  var_0[var_0.size] = [(-1133.09, -86.3998, 31.9999), (0, 303, 0)];
  var_0[var_0.size] = [(160.908, -1084.4, 31.9999), (0, 303, 0)];
  var_0[var_0.size] = [(124.908, 45.6002, 31.9999), (0, 303, 0)];
  var_0[var_0.size] = [(390.908, 281.6, 31.9999), (0, 303, 0)];
  var_0[var_0.size] = [(396.4, -619.092, 31.9999), (0, 34, 0)];
  var_0[var_0.size] = [(-254.626, -905.811, 168), (0, 171, 0)];
  var_0[var_0.size] = [(-136.314, 268.619, 26), (0, 307, 0)];
  var_0[var_0.size] = [(-215.711, 212.019, 162), (0, 303, 0)];
  var_0[var_0.size] = [(-2042.67, -1077.1, 56), (0, 303, 0)];
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_3, var_2 in var_0) {
    if(var_3 > 7) {
      break;
    }

    thread scripts\cp\laser_traps\cp_laser_traps::_id_13542(var_2[0], var_2[1], 1);
  }
}

bonuswingamescharge() {
  while(getaiarray("_encstr_8E8405EA382B2A").size > 10)
    wait 0.5;

  for(;;) {
    while(getaiarray("_encstr_8E8405EA382B2A").size > 6 || getaiarray("_encstr_8E8405EA382B2A").size < 1) {
      if(scripts\engine\utility::flag("_encstr_84880F9FCBB81365900829EA60E8A19A86"))
        scripts\engine\utility::flag_clear("_encstr_84880F9FCBB81365900829EA60E8A19A86");

      wait 0.5;
    }

    if(!scripts\engine\utility::flag("_encstr_84880F9FCBB81365900829EA60E8A19A86")) {
      var_0 = _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::_id_12BCC(getaiarray("_encstr_8E8405EA382B2A"));
      lootchopper_findunoccupiedpatrolzone(var_0);
      scripts\engine\utility::flag_set("_encstr_84880F9FCBB81365900829EA60E8A19A86");
    }

    wait 5;
  }
}

lootchopper_findunoccupiedpatrolzone(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(!_encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::bomb_carrier(var_3)) {
      continue;
    }
    if(var_1 > level.players.size - 1)
      var_1 = 0;

    var_3 setgoalpos(level.players[var_1].origin);
    var_3 setgoalentity(level.players[var_1], 1000);
    var_3.goalradius = 1000;
    var_1++;
  }
}

brinitloadoutoption() {
  self setthreatbiasgroup("_encstr_9A8507BA4040188D08");
  self.health = self.health + 100;
  self.accuracy = 0.4;
  childthread brleaderdialogteam();
}

brleaderdialogteam() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F");

    if(scripts\engine\utility::is_equal(self.damagemod, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")) {
      self dodamage(self.health, self.origin);
      return;
    }

    waitframe();
  }
}

_id_1321E(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = _id_12BF4(var_1);
  var_2 = "_encstr_A7E34314142896EFC2A9F91FC3F10A91EBB2F1204006F5404865BBC73DBF833D434398FBD8C30B0BCD0DDE491069D87A0A0FBA11DAFE2B5A6ADB976691F2B7937379DB31D8";
  var_3 = "_encstr_817930C2E82199878890555992B1D60B4780DB7E1879CF4BC0E72C4CB9BBA7636B182347AA57C53FFBDD3A41C5A3DFEE8B88";
  var_4 = "_encstr_9285401A6393EFCE081FC5D96FE8C3A751FBB6920A0683045037D4D01B785DA70938BA8AD36DCBBE40A9F9AE2F3827C6A4E9C3631B350B352891BBAFE5706A135B23";
  var_5[0] = var_2;
  var_5[1] = var_3;
  var_5[2] = var_4;
  var_5[3] = var_3;

  foreach(var_8, var_7 in var_1) {
    if(isDefined(var_5[var_8]))
      var_7.weaponinfo = var_5[var_8];
  }

  waitframe();
  teamanchoredwidget(var_1);
}

_id_12BF4(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.origin[2] < 85)
      var_1[var_1.size] = var_3;
  }

  return scripts\engine\utility::array_remove_array(var_0, var_1);
}

teamanchoredwidget(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.weaponinfo)) {
      continue;
    }
    var_3 = strtok(var_2.weaponinfo, "_encstr_BE4C0295");
    var_4 = var_3[0];
    var_5 = scripts\engine\utility::array_remove(var_3, var_4);
    var_6 = scripts\cp\cp_weapon::buildweapon(var_4, var_5);
    var_7 = "_encstr_B2010820C5337B67C8CF" + var_4;
    var_8 = scripts\cp\utility::array_merge(var_6.attachments, var_5);

    foreach(var_10 in var_8)
    var_7 = var_7 + ("_encstr_BE4C0295" + var_10);

    var_12 = spawn(var_7, var_2.origin, 1);
    var_12.angles = var_2.angles;
    var_12 itemweaponsetammo(1, 200, 0, 1);
  }
}

_id_1321F() {
  var_0 = [];
  var_0[var_0.size] = "_encstr_92188FC3C79ACE0B934FBD1E69927B58B8DB590D473A44BBE74B678165EF9F39A2CB9117129249B0D7AEE081B237E61B02B972908053186339AAD7711DA08F220313C278FB3E7A61B3D9051DC10303D226C21BC033DAC88377C891CB1286310BDD9ABA3A22D0AD7A9967D14F7AFA033BEA874AB810DE055492539838CB99DBAB8A21D976EACB1AEAA640DE314A4EE037D8";
  var_0[var_0.size] = "_encstr_817930C2E82199878890555992B1D60B4780DB7E1879CF4BC0E72C4CB9BBA7636B182347AA57C53FFBDD3A41C5A3DFEE8B88";
  var_0[var_0.size] = "_encstr_967595273882D79A7538C57E9B7BE3BCF0C087BF984828C3AD46CCB768097A7D7B38F72349F88AEA9DDE44AD6FEF6212C1B05B9F3811D5A24F7CDE62CDD53AC40828F30ED86B01AB2183620C3C8302AF90A04B8FD0600B0223286A971E572955B960FF7F7859B68E63B1350D897752DFC0300BBFB093BB729D5B7A86601F4BBAA89A8367D84B270A9FEE04FA779F717DF1683F83B84065";
  var_0[var_0.size] = "_encstr_B82B230B633F0738D1D7F03023E1D199910D7FA23DF2C7E0AA0FB0E8BB05AEFD5BF57B1D93";
  var_0[var_0.size] = "_encstr_95D0992D77E0D72C9CF5B037B45939932C2646FAAD839DC8B2632C6EAC39C42C6316CD8D2B8CACEC395A07A19638EBD94BB9E82C3BB25647345627B65863AF7756378E0C4CCADCB2362BD84737595B5A591623375A32D856B233B06ED1395963B78546AC165B6B7BDAF632AFB9D54CCDDEB9B4C6AC2CDAB5F6D6DE23EBD2E6D8CAB98CD285C9BCAC3BEACD0EB29CDAF56E8EB0B96CCA3783AC5619";
  var_0[var_0.size] = "_encstr_AD8B78A1FB9261C32937BBE8935983BF63A740BADED1F956878E355F2AA7D82768D2E2A99617BB23689B7470DDCF109DA06D48830723D43502638909390728503B2A5F539EC31BE5B0F125C551A3CAB578DB3A7953E388D01029B24A3772DDCBC2CCBD9A8F272C78A3F6771037410310914DE87B7F6945A36DC9";
  var_0[var_0.size] = "_encstr_ACFF4DEAC009A1BF60C81237F9E987204F92F1226087E50F58CB1A350591BFFB9F90ABFAC8C55F2B33AF0227B0BB77C5BB38979732D754BFEB1F112D92A1338DCFF02E9A103FCF9B21F5F367DE8993";
  var_0[var_0.size] = "_encstr_831A96EBE76A17B7F2279987E0B9C6B207273A37B860E352F2F971BBCB2D8E4F70575556BDF204F7BBD9BA9333A99EFBF8E89B07B9F5C3483CB742BF416090870A13C84389CF5369E53DB6E3D308F5D8AACE29EB93F9F29302E1A603214DCD64974F87EFEA551998E1E72DB9AE83EB28DF50683FDA720F0B58DB63029F282BFBB77581488799EA5AB5A813BDB0E21DAA495FD0A7AF30063B";
  var_0[var_0.size] = "_encstr_92188FC3C79ACE0B934FBD1E69927B58B8DB590D473A44BBE74B678165EF9F39A2CB9117129249B0D7AEE081B237E61B02B972908053186339AAD7711DA08F220313C278FB3E7A61B3D9051DC10303D226C21BC033DAC88377C891CB1286310BDD9ABA3A22D0AD7A9967D14F7AFA033BEA874AB810DE055492539838CB99DBAB8A21D976EACB1AEAA640DE314A4EE037D8";
  var_0[var_0.size] = "_encstr_953330D2EE0E7D1B0BEB6D3BB7D833AFADE056C69BC634C96EC6BD382BEBD6D9DB6366951ED616EC6EF53607D76D9DDED8CC";
  var_0[var_0.size] = "_encstr_859090DC3CF979FC38610F0FD050F9F78340A5128AD9C23D23E81F03310B652BD14F3A5C8B03EA472B911F7B19605F92498C24C2FD59E28B93C81F77B05011EA0F937FBD557F5AC218900F6B80F1CB0293B914B7CF37630A6140C75708E086FA4BC08EAC82B50A2A4E68F71378013302236796641977426972F8DF5720B037EB9BFF5C9C7F9F8AB13BF0AB6F5093D7326316";
  var_1 = [];
  var_1[var_1.size] = [(-111.5, 682, 90.5), (289.61, 89.9978, 0.000248305)];
  var_1[var_1.size] = [(-91, 682.5, 90.5), (-91, 682.5, 90.5)];
  var_1[var_1.size] = [(-65, 682, 90.5), (289.61, 89.9978, 0.000248305)];
  var_1[var_1.size] = [(-245.5, 416.209, 65.8858), (357.958, 148.873, 1.23062)];
  var_1[var_1.size] = [(-44.5, 682.5, 90), (289.61, 89.9978, 0.000248305)];
  var_1[var_1.size] = [(-36, -1403.06, 65.5424), (359.999, 41.9993, 89.9987)];
  var_1[var_1.size] = [(-3740.78, -2231.96, 44), (2.38684, 332.692, -81.71)];
  var_1[var_1.size] = [(-3401.67, -1368.77, 74.5001), (0, 0, 90)];
  var_1[var_1.size] = [(-3738.08, -2349.85, 44), (0, 0, 90)];
  var_1[var_1.size] = [(-75.7344, 500.682, 60.5), (359.514, 338.066, 82.1878)];
  var_1[var_1.size] = [(-1933.5, -654.593, 74.5435), (288.63, 89.9983, -89.9992)];
  var_2 = [];

  foreach(var_5, var_4 in var_0)
  var_2[var_2.size] = [var_0[var_5], var_1[var_5][0], var_1[var_5][1]];

  _id_1238F(var_2);
}

_id_1238F(var_0) {
  foreach(var_2 in var_0) {
    var_3 = var_2[0];
    var_4 = var_2[1];
    var_5 = var_2[2];
    var_6 = strtok(var_3, "_encstr_BE4C0295");
    var_7 = var_6[0];
    var_8 = scripts\engine\utility::array_remove(var_6, var_7);
    var_9 = scripts\cp\cp_weapon::buildweapon(var_7, var_8);
    var_10 = "_encstr_B2010820C5337B67C8CF" + var_7;
    var_11 = scripts\cp\utility::array_merge(var_9.attachments, var_8);

    foreach(var_13 in var_11)
    var_10 = var_10 + ("_encstr_BE4C0295" + var_13);

    var_15 = spawn(var_10, var_4, 1);
    var_15.angles = var_5;
    var_16 = createheadicon(var_9);
    var_15 itemweaponsetammo(weaponclipsize(var_16), weaponmaxammo(var_16));
  }
}

bomber_radiusdamage() {
  self.grenadeweapon = getcompleteweaponname("_encstr_BA730BF8AFF178988293F158B9");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

borntime() {
  self.grenadeweapon = getcompleteweaponname("_encstr_92A70ABB8267F5E0D89F6351");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

init_flags() {
  scripts\engine\utility::flag_init("_encstr_BE4310237BA097919940C26BD9DDD5E3595E");
  scripts\engine\utility::flag_init("_encstr_A77911BAF0539A3FD3401437EED8DF66D50852");
  scripts\engine\utility::flag_init("_encstr_9B93128E4E16739B9956E47D8DBD6B0E8DB28EAC");
  scripts\engine\utility::flag_init("_encstr_8D5A0D46AC99B2CD32F5DCA3B04E8E");
  scripts\engine\utility::flag_init("_encstr_AD6110D48622E2CBC6305277899BEBCAE3F0");
  scripts\engine\utility::flag_init("_encstr_AA5F11E4B6A1335A4D505399F8B1168BBB957C");
  scripts\engine\utility::flag_init("_encstr_BAD117F9794B88BD77D2D09BDB4760B869C34153F7F51070AF");
  scripts\engine\utility::flag_init("_encstr_864715CDC158EE73B473B3FAB437D71C27B7B327ACB9E6");
  scripts\engine\utility::flag_init("_encstr_A7C80BB9FD63FE5F9FE157FBCD");
  scripts\engine\utility::flag_init("_encstr_B15D1BC979C0FB1F1B78AA83E0605B39C8D1795AF3B107CB37D1729A69");
  scripts\engine\utility::flag_init("_encstr_B4FD0FD383052A67A0813B82382076A2D5");
  scripts\engine\utility::flag_init("_encstr_924E0BCA87665A8D7DB12CE646");
  scripts\engine\utility::flag_init("_encstr_AA0F10F833B6E01131A3B7157E1A59680FD3");
  scripts\engine\utility::flag_init("_encstr_B4150DB8130F4B10DFDD980EA15379");
  scripts\engine\utility::flag_init("_encstr_A6C811DC8E85E4D1AF99A5B263C8BE38D5370D");
  scripts\engine\utility::flag_init("_encstr_84880F9FCBB81365900829EA60E8A19A86");
  scripts\engine\utility::flag_init("_encstr_ABA008615A631510C7EA");
  scripts\engine\utility::flag_init("_encstr_B457128F6887433F83FFC9E9287313EB579B1097");
  scripts\engine\utility::flag_init("_encstr_AADC14E3F26BFA8C15B6817E8BDA49F3499D7EC048C5");
  scripts\engine\utility::flag_init("_encstr_9182142577C7D0F9FD3A10C11742E76BE7F23E2DDE13");
  scripts\engine\utility::flag_init("_encstr_85BF142A1087FDD3B0E73417A4935702DB90C2B2A029");
  scripts\engine\utility::flag_init("_encstr_95B411439A6F401755EA174DC8AF70F0A0A0E9");
  scripts\engine\utility::flag_init("_encstr_8BE714196FA3E0B88FBE611E323DE9277AF38F93D33B");
  scripts\engine\utility::flag_init("_encstr_B23218933360AF87C7293AA23194A7E9D0B9091B43613717E160");
  scripts\engine\utility::flag_init("_encstr_A2A3086439CBF1DF3C8A");
  scripts\engine\utility::flag_init("_encstr_92D90DDB303BEDAF7DF8FE293B635B");
  scripts\engine\utility::flag_init("_encstr_B1A40DBB0BCE56AFC4D7DCE80B933A");
  scripts\engine\utility::flag_init("_encstr_BEFA0D4F27C315518361D34B96AA40");
  scripts\engine\utility::flag_init("_encstr_851E18F2C825E7C7BB1FCBCB276117A18520B93B48DB58571074");
}

init_spawners() {
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::subscriptions();
}

_id_14379() {
  scripts\cp\laser_traps\cp_laser_traps::_id_1437A();
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_set("_encstr_B457128F6887433F83FFC9E9287313EB579B1097");
}

_id_128BB() {
  thread bonuswingamescharge();
  _encstr_A98D36C8132B0A82435EC72E30A8CD87C12F35114231BBAF494F0DD6CBF8637326E2F1A9CB9D398FF141B14B18FBF040C5C99211B8F04BB3::alley_start();
}

_id_134F3() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BD3813408A55A3BE9710D7D41617C37F7132E8B072", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::is_equal(var_4.script_type, "_encstr_8BFE1672095DD7F289BBECE463617E731063EB3A91A0A7AA")) {
      var_4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
      var_2++;

      if(var_2 >= 2) {
        break;
      }
    }
  }

  var_6 = getEnt("_encstr_B1CF0B9159332BB991F5B3F6D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = getaiarray("_encstr_9A8507BA4040188D08");
  var_8 = -108;

  foreach(var_10 in var_7) {
    var_10.target = undefined;
    var_10 notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
    var_10 clearpath();
    var_10 setgoalpos((-108.179, -141.79, 32));
    var_10 setgoalvolumeauto(var_6);
    var_10 forceteleport((var_8, -141.79, 32), (0, 0, 0));
    var_8 = var_8 + -10;
  }
}

_id_12F4B() {
  var_0 = scripts\engine\utility::getStruct("_encstr_B632141D2893DBE9886BBFA84321F03FB04303881A8A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.origin = var_0.origin + (-768, 0, 0);
  var_1 = scripts\engine\utility::getStruct("_encstr_B43214FA6865FC1376A3F5E4CB9ED385996803D19273", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.origin = var_1.origin + (-768, 0, 0);
  scripts\engine\utility::flag_set("_encstr_BAD117F9794B88BD77D2D09BDB4760B869C34153F7F51070AF");
  visionsetnaked("_encstr_829D14E99AD71038610F7B6D378B7E18BF77D0A10554", 5);
  wait 1;

  while(getaiarray("_encstr_8E8405EA382B2A").size > level.players.size)
    wait 0.1;

  foreach(var_3 in getaiarray("_encstr_9A8507BA4040188D08")) {
    var_3.health = 10;
    var_3.goalradius = 1200;
    var_3 setgoalpos((1650, -59, -4));
  }

  scripts\engine\utility::flag_clear("_encstr_B4150DB8130F4B10DFDD980EA15379");
  var_5 = getEnt("_encstr_B2D90C6A4B9BAFBFDFD73B866FB2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.onlaststandkillenemy = var_5 scripts\common\vehicle::spawn_vehicle_and_gopath();
  level.onlaststandkillenemy thread givequestrewardgroup();
  thread onkioskpurchaseitem();
  thread _id_1352A();
  level.onlaststandkillenemy thread scripts\common\vehicle::godon();
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::omnvars();
  level.onlaststandkillenemy waittill("_encstr_8B7205D9ED5958");
  thread giveloadouteverytime();

  while(!_encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brevent1playerthink(level.oncrateactivate, 500))
    wait 0.1;

  level.onlaststandkillenemy setneargoalnotifydist(100);
  level.onlaststandkillenemy sethoverparams(0, 0, 0);
  level.onlaststandkillenemy vehicle_setspeed(5);
  level.onlaststandkillenemy settargetyaw(90);
  level.onlaststandkillenemy setvehgoalpos(level.onlaststandkillenemy.origin + (-75, 70, -320));
  level.onlaststandkillenemy._id_13BFE = level.onlaststandkillenemy.origin + (-75, 70, -330);
  level.onlaststandkillenemy waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  var_6 = _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::_id_135EB(level._id_13DE3, "_encstr_B4ED09734525AAF3698B8B");
  thread skipfriendlyfire();
  scripts\engine\utility::flag_clear("_encstr_BAD117F9794B88BD77D2D09BDB4760B869C34153F7F51070AF");
  thread audio_chopper_struggling();
  thread _id_11A6D();
  scripts\engine\utility::flag_set("_encstr_B4150DB8130F4B10DFDD980EA15379");
  wait 2;
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::play_nags_from_array();
  thread _encstr_8F0137E6D89C4B073A9BCB3683F2B658386E798DC1AFE6B77D956B4C0B9BB9F297361CBEDCDB7D59ADC4C2CD9BBCF519CA33957323E276CDB1::old_getspawnpoint_func();
  thread skipburndownforclass();
  wait 5;
  thread skipequipmentdropondeath();

  while(level._id_12DC6.size > 1)
    wait 0.1;

  while(getaiarray("_encstr_8E8405EA382B2A").size > 3)
    wait 0.1;

  scripts\engine\utility::flag_clear("_encstr_B4150DB8130F4B10DFDD980EA15379");
  scripts\engine\utility::flag_set("_encstr_95B411439A6F401755EA174DC8AF70F0A0A0E9");

  while(!_encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::brevent1playerthink(level.oncrateactivate, 500))
    wait 0.1;

  scripts\engine\utility::flag_set("_encstr_924E0BCA87665A8D7DB12CE646");
  scripts\engine\utility::flag_wait("_encstr_AA0F10F833B6E01131A3B7157E1A59680FD3");
  setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 0);
  level notify("_encstr_B2200FB2C399D236D76CF6DA381BCA472B");
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

_id_1352A() {
  var_0 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_BDFA104911A8C7C9DF90F953602B3EA7E186", level.onlaststandkillenemy, 0);
  var_0 thread _encstr_A98D36C8132B0A82435EC72E30A8CD87C12F35114231BBAF494F0DD6CBF8637326E2F1A9CB9D398FF141B14B18FBF040C5C99211B8F04BB3::_id_11A6E();
  var_0 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_134EB("_encstr_BDFA104911A8C7C9DF90F953602B3EA7E186", level.onlaststandkillenemy, 1);
  var_0 thread _encstr_A98D36C8132B0A82435EC72E30A8CD87C12F35114231BBAF494F0DD6CBF8637326E2F1A9CB9D398FF141B14B18FBF040C5C99211B8F04BB3::_id_11A6E();
}

audio_chopper_struggling() {
  level waittill("_encstr_A5BA0E520867EBCF53F7C15831734ECB");
  level.onlaststandkillenemy playLoopSound("_encstr_932E1C687BF234A60A9B69FC4B30A3FB653B217C7701D8771079F883AA96");
  level.onlaststandkillenemy playLoopSound("_encstr_A1C61B2410485CC11BE393BFD7B0FB84C89B11AF8AD8EE1AF89997AF19");
  wait 6;
  level.onlaststandkillenemy thread givequestrewardsinstance(0.3, 1);
}

giveloadouteverytime() {
  var_0 = scripts\engine\utility::spawn_tag_origin(level.onlaststandkillenemy gettagorigin("_encstr_B801093B97E7D9579BF09E"), (0, 0, 90));
  var_0 show();
  wait 0.15;
  var_0.origin = level.onlaststandkillenemy gettagorigin("_encstr_B801093B97E7D9579BF09E");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AB090F9D991E7DEC36F6DDAFE6A34B8DDA"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 = (var_0.origin[0], var_0.origin[1], -20);
  var_0 moveTo(level.oncrateactivate + (100, 0, -10), 0.9);
}

givequestrewardsinstance(var_0, var_1) {
  if(istrue(var_1))
    scripts\engine\utility::delaycall(var_0 + 0.05, ::stoploopsound);
  else
    scripts\engine\utility::delaycall(var_0 + 0.05, ::stopsounds);
}

onkioskpurchaseitem() {
  level endon("_encstr_B2200FB2C399D236D76CF6DA381BCA472B");
  childthread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_12758("_encstr_836F2A210B39C8199FE78B532D811FF0F812DC95018FE7481D79A153C5FAD1EED7FE71F873C8AD3FC30FAE4A");
  wait 3;
  childthread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_12758("_encstr_B1AE1B79C879181017693BE083BEC028CD3CDDF7479F90636F5276C36F");
  level.onlaststandkillenemy waittill("_encstr_8B7205D9ED5958");
  scripts\engine\utility::flag_wait("_encstr_B4150DB8130F4B10DFDD980EA15379");
  wait 5;
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_12758("_encstr_8C411C2083D1E5E0A747A59240FEAE83C52BE8F0693719FA4F6EB8B779A2");
  wait 1;
  _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_12758("_encstr_88411C18BBE9ADA8FF0FEDEA18B6965B0DE320B8217F21228756E0FFB25A");
  scripts\engine\utility::flag_waitopen("_encstr_B4150DB8130F4B10DFDD980EA15379");
  childthread _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_12758("_encstr_836F2A210B39C8199FE78B532D811FF0F812DC95018FE7481D79A153C5FAD1EED7FE71F873C8AD3FC30FAE4A");
}

givequestrewardgroup() {
  self setscriptablepartstate("_encstr_8C550F4EAE9B73A5B93BF51B5AEC86A3E6", "_encstr_AB0703DBB9");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_878819489A04BB49171CC3CCE043766F6DF28860621BA761F32DDD"), self, "_encstr_BD8E14C36F2F1184C0C85BD3F1794F1AEF7F0C7B6FEB");
}

skipfriendlyfire() {
  level.onlaststandkillenemy waittill("_encstr_8B7205D9ED5958");
  level.onlaststandkillenemy vehicle_setspeed(0);
  level waittill("_encstr_A5BA0E520867EBCF53F7C15831734ECB");
  level endon("_encstr_95B411439A6F401755EA174DC8AF70F0A0A0E9");
  var_0 = [];
  var_0[var_0.size] = scripts\engine\utility::getStruct("_encstr_8132145703A08131594C889C126E2D6A3F9DEA0730EE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\engine\utility::getStruct("_encstr_8A3214F530D3608981DA4808E2A9557833D50660D022", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\engine\utility::getStruct("_encstr_8432140DB85BE8111952F0807A21DDE08B4D8EE868BE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\engine\utility::getStruct("_encstr_AD32142BC3CC961B7DD0B2B14BF59BB723B2E6EB60B1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\engine\utility::getStruct("_encstr_85321478B3366091B12485197CE9CDE89C7F40317A9F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0[var_0.size] = scripts\engine\utility::getStruct("_encstr_B632141D2893DBE9886BBFA84321F03FB04303881A8A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.onlaststandkillenemy sethoverparams(50, 10, 0);
  level.onlaststandkillenemy setneargoalnotifydist(700);
  level.onlaststandkillenemy.goalradius = 300;
  wait 1;

  for(;;) {
    for(var_1 = 0; var_1 < 6; var_1++) {
      level.onlaststandkillenemy vehicle_setspeed(15);
      level.onlaststandkillenemy setvehgoalpos(var_0[var_1].origin + (0, 0, 700));
      scripts\engine\utility::delaythread(2, ::_id_14680, var_0[var_1]);
      level.onlaststandkillenemy settargetyaw(var_0[var_1].angles[1]);
      level.onlaststandkillenemy waittill("_encstr_B4D10ADC950BE4EB76DE8536");
    }
  }
}

skipequipmentdropondeath() {
  scripts\engine\utility::flag_wait("_encstr_95B411439A6F401755EA174DC8AF70F0A0A0E9");
  var_0 = scripts\engine\utility::getStruct("_encstr_B632141D2893DBE9886BBFA84321F03FB04303881A8A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_B43214FA6865FC1376A3F5E4CB9ED385996803D19273", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.onlaststandkillenemy settargetyaw(180);
  level.onlaststandkillenemy vehicle_setspeed(75);
  level.onlaststandkillenemy setvehgoalpos(var_1.origin + (-75, 70, -150), 1);
  level.onlaststandkillenemy settargetyaw(90);
  level.onlaststandkillenemy scripts\engine\utility::_id_143B9(8, "_encstr_8B7205D9ED5958");
  level.onlaststandkillenemy sethoverparams(0, 0, 0);
  level.onlaststandkillenemy vehicle_setspeed(0);
  scripts\engine\utility::flag_wait("_encstr_924E0BCA87665A8D7DB12CE646");
  level.onlaststandkillenemy vehicle_setspeed(5);
  level.onlaststandkillenemy setvehgoalpos(var_1.origin + (-75, 70, -330));
  level.onlaststandkillenemy waittill("_encstr_8B7205D9ED5958");
  level.onlaststandkillenemy vehicle_setspeed(0.1);
  scripts\engine\utility::flag_set("_encstr_AA0F10F833B6E01131A3B7157E1A59680FD3");
}

_id_14680(var_0) {
  level.onlaststandkillenemy settargetyaw(var_0.angles[1]);
}

skipburndownforclass() {
  var_0 = level.onlaststandkillenemy gettagorigin("_encstr_9101096BBF4A4F97FB983D");
  var_1 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B("_encstr_BDFA104911A8C7C9DF90F953602B3EA7E186", var_0, (0, 0, 0), undefined, 1);
  var_1 forceteleport(var_0);
  var_1 linkTo(level.onlaststandkillenemy, "_encstr_9101096BBF4A4F97FB983D");
  var_1.baseaccuracy = 1.8;
  var_1 allowedstances("_encstr_B13D076BED70539F23");
  wait 0.1;
  var_0 = level.onlaststandkillenemy gettagorigin("_encstr_B801093B97E7D9579BF09E");
  var_2 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B("_encstr_BDFA104911A8C7C9DF90F953602B3EA7E186", var_0, (0, 0, 0), undefined, 1);
  var_2 forceteleport(var_0);
  var_2 linkTo(level.onlaststandkillenemy, "_encstr_B801093B97E7D9579BF09E");
  var_2.baseaccuracy = 1.8;
  var_2 allowedstances("_encstr_B13D076BED70539F23");
  wait 4;
  var_3 = level.vehicle.templates.aianims[level.onlaststandkillenemy scripts\common\vehicle_code::get_vehicle_classname()];
  var_4 = var_3[0].vehicle_getoutanim;
  thread scripts\cp\vehicle::matchdata_logweaponstat(level.onlaststandkillenemy, var_4);
}

_id_11A6D() {
  var_0 = spawnStruct();
  var_0.origin = (1756, 2309, 307);
  var_0.angles = (0, 270, 0);
  var_1 = (2648, 2623, 169);
  var_2 = (1750, -165, -10);
  level._id_12DC6 = [];
  var_3 = scripts\engine\utility::spawn_tag_origin((2733, 2051, 320), (0, 270, 0));
  _id_1353F(var_1, var_3, "_encstr_85DB18D248353FD0695FD0F773D89AAFED41CB5A53153FCAE84F");
  var_4 = getaiarray("_encstr_8E8405EA382B2A")[0];
  var_5 = magicbullet("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", var_0.origin, level.onlaststandkillenemy.origin + (0, 0, -150), var_4);
  var_5 waittill("_encstr_860808CB78E2984063BA");
  level notify("_encstr_A5BA0E520867EBCF53F7C15831734ECB");
  var_3 = scripts\engine\utility::spawn_tag_origin((2783, 2051, 320), (0, 270, 0));
  thread _id_1353F(var_1, var_3, "_encstr_85DB18D248353FD0695FD0F773D89AAFED41CB5A53153FCAE84F");
  var_3 = scripts\engine\utility::spawn_tag_origin((1717, 2335, 267), (0, 270, 0));
  thread _id_1353F(var_1, var_3, "_encstr_85DB18D248353FD0695FD0F773D89AAFED41CB5A53153FCAE84F");
  var_3 = scripts\engine\utility::spawn_tag_origin((1575, 2301, 565), (0, 270, 0));
  thread _id_1353F(var_1, var_3, "_encstr_83DB1813B68FB873B7F2B35EBA132F716715879B3233E13147AA");
  var_3 = scripts\engine\utility::spawn_tag_origin((1500, 2301, 565), (0, 270, 0));
  thread _id_1353F(var_1, var_3, "_encstr_83DB1813B68FB873B7F2B35EBA132F716715879B3233E13147AA");
  wait 4;
  magicbullet("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", var_0.origin, level.onlaststandkillenemy.origin + (200, 0, 500));
}

_id_1353F(var_0, var_1, var_2) {
  var_3 = _encstr_AAA6354790C3F99371266D768F9F1AB9EB68BE9FA0DE3BAACF35C52E7F0F3359D840BBE720305F72935ECE625EE3C91D1B88439A68EBDB::_id_1352B(var_2, var_0, (0, 0, 0), undefined, 1);
  var_3.og_fov = 1;
  var_3 allowedstances("_encstr_922406F1A6FD5E05");
  level._id_12DC6[level._id_12DC6.size] = var_3;
  var_3 thread _id_13540();
  wait 1;
  var_3 forceteleport(var_1.origin);
  var_3.baseaccuracy = 0.1;
  var_3.ignoresuppression = 1;
  var_3 allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  var_3 linkTo(var_1);
}

_id_13540() {
  self waittill("_encstr_AD75063D571AE108");
  level._id_12DC6 = scripts\engine\utility::array_remove(level._id_12DC6, self);
}