/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_soa_tower_ai_event.gsc
**************************************************/

init() {
  if(getdvarint("_encstr_9AE516B0A75ACEE33B4DB6A8E7A22B508F57C0A81BECC191", 1) > 0 && istrue(level.tryupdategenericprogress)) {
    ac130_flight_path::registerscriptedagent();
    module_set_script_origin_other_on_ai();
    level thread object_is_valid();
  }
}

module_set_script_origin_other_on_ai() {
  if(!isDefined(level.ai_event))
    level.ai_event = spawnStruct();

  level.ai_event.bnoself = getdvarint("_encstr_9AB725B936E47D85E46B6EBE235916D87DB04BBEB2B32BCDE8F536DEDB8D8CDEDDB9F5A3B46BB2", 15);
  level.ai_event.bodyonly_guy_in_car_damage_monitor = getdvarfloat("_encstr_8C0E2402B14887C2F6130FC779158AFC79593C81E98045EACD5F1B1743CD923D88E6F394ADA0", 180);
  level.ai_event.binoculars_setuidata = getdvarint("_encstr_A59E2837B1C9F558E46BB9D72359588DFAA3F68E5836AF16EC2BCDA37D0EB7A5DC1DE6F5EEC23B2BFA62", 15);
  level.ai_event.binoculars_showtargetmarker = getdvarint("_encstr_8D9E28CDD8277D85E4B637BE91AC0BB1FAE8B78EC2D8BEB0D959DC47BE83B75A733AB9AF770B67ACD723", 50);
  level.ai_event.binoculars_targetismarked = getdvarint("_encstr_AF9E284776324FC205DAFE3F29B01E086FCBD5D3183BAFFF4C9FFA33F1BB80888EEB8277578EAB07719F", 25);
  level.ai_event.binoculars_updateheadiconvisibilityforplayer = getdvarint("_encstr_ADCB248336820947DBB7EFAF8B729F58170E89D91DEC5106D36FEFC54F7AD028CEA336504638", 8);
  level.ai_event.binoculars_targetisvalidmark = getdvarint("_encstr_AA45252B71265F7EB8EB4B1F817806DBD8A9E2F278FDA73280DB4726DF604D67F863F90A61D607", 6);
  level.ai_event.binoculars_updateprojectiondistance = getdvarint("_encstr_9ACB248F6126C72F83B86BAE5C2791D91041441F3DD957FF3396C3F6BF80DF8582B12182EAA2", 6);
  level.ai_event.binoculars_updateheadiconvisibility = getdvarint("_encstr_8F432E033E8DE693DED55E013755D7A8373A22338E85B183706F4FC8F7A20F6B4B033F9F22647320ABF502F15B9B93F7", 2);
  level.ai_event.binoculars_updateuidata = getdvarint("_encstr_A1DD2F173F2328BB5E204B19DBBFF9A05F6B6035F0E10F3FAF8B20053FF6B2E89B8F028B289BA0B1D3B0D3279F28A5803C", 7);
  level.ai_event.binoculars_registertargetstate = getdvarint("_encstr_A55D2968C26A47D1CB65B6B844BF1999994A50506A830FC84F913125502FA34BBD93C8F9621FA5A167B4C5", 100);
  level.ai_event.binoculars_ontake = getdvarint("_encstr_A9A328B673DBFEDB82F2B0C97A1F93D017193425C66B26236ADA58A8A1F34B281785502D25FBA943D5B3", 250);
  level.ai_event.binoculars_processlosqueue = getdvarint("_encstr_A7302808584DAFF9A25F8A0FE9453755A9F24AED383B91304A55057BD9A7B0F3F889632F8311DF57E83F", 50);
  level.ai_event.binoculars_targetisvalid = getdvarfloat("_encstr_BD642893CA3358F872850767B49FB099DF8269D9828390B84F703737D183C8D0F3D920208B3FBED06674", 5);
  level.ai_event.binoculars_onstateunmarkedexit = getdvarfloat("_encstr_B29C20336A93F858D225A787547F10397FE2097922633080AE03A3D579A019712F0B", 0.45);
  level.ai_event.binoculars_onstatemarkpendingupdate = getdvarfloat("_encstr_82D721B9D8277D584EB69BF58CB2C2637D167695E647D785B136BAE4852FEB988537AC", 0.27);
  level.ai_event.binoculars_onstateunmarkedupdate = getdvarfloat("_encstr_939C2057E072603E75B58721A1D787834F116139B58BD7EB03D3EB65471AF8C2A23A", 0.25);
  level.ai_event.binoculars_onstateunmarkedenter = getdvarfloat("_encstr_A6FB2A93EB05615F7B3D338859F1C7B2A80B845F9B9390987A73ABC3B70331B0901B603F5A686E808BE223D8", 0.12);
  level.ai_event.binoculars_processlosqueuelow = getdvarint("_encstr_A11D29E61B39FA169CD66EEB8C56C28DAF169D959BE87D3193BAA359BEA1590B1B47D0F5462BCCC2578DE8", 10000);
  level.ai_event.binoculars_processlosqueuehigh = getdvarint("_encstr_A5432882D0A281F090E8EF57875FB8909759A701A05161C8F2BB3131D67F3BE807FA116C6F5102F70C83", 10000);
  level.ai_event.binoculars_updatetargetmarker = getdvarfloat("_encstr_8EE332B9C64EEB2CC9ADB9FA23565836EB2CEC5673D1D7B9382CEE37BEC8B2B185E5FAB0993A5639F5264EBA47B2EB3707C2EEE6", 0);
  level.ai_event.binoculars_processtargetlos = getdvarfloat("_encstr_91EB476E1B27FA0B4EB56EFAC856B0C6AFB0D995CDA3AFC29D56731DBE264E5DA3ACF5373A7B83D758762B73D1AF9B38B0DD376ED7C247FA342B0B8D8E43D70E594EB159CD1D85EC95", 0.2);
  level.ai_event.binoculars_removeheadicon = getdvarint("_encstr_8BD12160CA62BF29C37DAEB04CA71191817248A872BB07607794BD951FCB594BF6BAC0", 30);
  level.ai_event.binoculars_processtargetdata = getdvarint("_encstr_9AAF277EAB0326134A0A7811B2A7CB985F518CFD0EA36E5D329378D8F97D8BD0EFFD18E599AF11AFDF", 90);
  level.ai_event._id_11C20 = getdvarfloat("_encstr_8E4D2A26C36B4E6B326220398A8F23608769A495569BB6ABDC7AF8A0F2E2A73BF71E3CAFBC57D9F34312C0F8", 0.5);
  level.ai_event._id_11C1F = getdvarfloat("_encstr_871A2A9B1BC9F5B04E6B6ED7462BB0D8D7C23B59E6A3AF5BD29BD2DAC207BE8396CDB3F596E6D15927D92C36", 2.5);
}

object_is_valid() {
  scripts\cp_mp\vehicles\cargo_truck_mg::init_battlechatter();
  level.agent_funcs["_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::black_screen_overlay;
  level.agent_funcs["_encstr_A7D418B06C477B9CBE59DCB25BBCD7B1BBBE98E4FA4C4EEAA3CA"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::black_screen_overlay;
  level.agent_funcs["_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::blade_trigger_think;
  level.agent_funcs["_encstr_A7D418B06C477B9CBE59DCB25BBCD7B1BBBE98E4FA4C4EEAA3CA"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::blade_trigger_think;
  level.disable_oob_immunity_on_riders = 1;
  level.playerentersafearea = ::_id_1320F;

  if(!isDefined(level.ai_event))
    level.ai_event = spawnStruct();

  level.ai_event.inited = 0;
  level.ai_event.states = ["_encstr_8882099673858D1D4B6756", "_encstr_BE4B0EBB2CB32B7D4B731BF66B5AB9CE", "_encstr_B6FB0CD3A84DC7E7B93EFCE94CC1", "_encstr_840412770BB356BEC2B1E8A567ACBE139CEA8EB2", "_encstr_86350E4338DD775749A87560315123BF", "_encstr_AF9A099E17EA0831658B71"];
  level.ai_event.current_state = "_encstr_8882099673858D1D4B6756";
  level.ai_event._id_13B97 = -1;
  level.ai_event.spawn_points = scripts\engine\utility::getStructArray("_encstr_96191BBFD75AD58B5F3770E03FB6262142FCA0BDA1239B11456F6A620A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ai_event._id_135B5 = [];
  level.ai_event.helidestroyvehiclestouchtrace = [];
  level.ai_event.select_hostage_room_three_spawners = bomb_wires_to_cut();
  level.ai_event.select_hostage_room_two_spawners = [];
  level.ai_event.occupied_rpg_trig = getEnt("_encstr_92441AE552C980A097F98B10837FE6299ED11753FE2F10754743E078", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ai_event scripts\mp\utility\trigger::makeenterexittrigger(level.ai_event.occupied_rpg_trig, ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5);
  level.ai_event._id_12659 = [];
  level.ai_event._id_12662 = [];
  level.ai_event._id_12663 = [];
  level.ai_event._id_12660 = [];
  level.ai_event.brclearscoreboardstats = [];
  level.ai_event._id_13BE2 = 0;
  level.ai_event._id_13BE3 = [];
  level.ai_event._id_13BE4 = 0;
  level.ai_event._id_14525 = [];
  level.ai_event.new_col_map = -1;
  level.ai_event.enemy_mine_damaged_think = 0;
  level.ai_event.binoculars_settargetmarkerstate = [];
  level.ai_event.binoculars_settargetmarkerstate[0] = getdvarint("_encstr_869E284E2ED34FC19A5740295BA599716993C855068A8709776F9068CFE890B3A23BBE481BB26DF167D2", 10);
  level.ai_event.binoculars_settargetmarkerstate[1] = level.ai_event.binoculars_setuidata;
  level.ai_event.binoculars_settargetmarkerstate[2] = level.ai_event.binoculars_setuidata;
  level.ai_event.binoculars_settargetmarkerstate[3] = level.ai_event.binoculars_setuidata;
  level.ai_event.pour = 1;
  level.ai_event.nolandingdamage = [];
  level.ai_event._id_13005 = [];
  level.ai_event.nogroundfoundtime = ["_encstr_BE1904DCDA9D", "_encstr_AFE7099BD676BE66E40B3B", "_encstr_A7C90C1BBD6F687FA77857DB40D3", "_encstr_85DA0AB32834F717F05BD3C0", "_encstr_9155086EDA3BBE3B0BB9", "_encstr_ADA60A9BDAB3FA37D6EDD6B2", "_encstr_AB3508737F830710ACDB", "_encstr_A6740DEF13AF4983753381B0ABCE6F", "_encstr_AC9310C743B2A02308A5E7A5AF79B86CCF06", "_encstr_A1330EC7269BC7ABDB7357A8F02F3A12", "_encstr_8F370C2F7AC7A32B205B5087E938", "_encstr_8BE50E131FE367708CFB069BA56748AD", "_encstr_A6561CC49CAEA3CAFA8CC2B9DC2FAFA30D56FACC2D39561B4EB01BB556E4", "_encstr_A91C1B05B2E31805CF0A48907233C3897B3083874C4FA05863D223785B", "_encstr_865116B27BC83CE311C30832CA3B615328AFE1FB90B862BE", "_encstr_8D3A17BE12DB6129DFE778F88707C39162F12631AC021911DA", "_encstr_912918E0D3AB11517F69382D4897F8B3993A1040FBC669A84F82"];
  level.ai_event.initoperatorunlocks = 0;
  level.ai_event._id_14528 = "_encstr_A3BA05E47B7C51";
  level.ai_event.start_coop_escort_enter_vehicles = 0;
  waittillframeend;
  _encstr_8EF32E0E938861A33D3EFF5D683F77B94F3893C8BF329BC861BA4793874FF9E505DF30A2296D159C7ACBD07BB8717E7F::init();
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  level.ai_event thread objectives_finale();
  level.ai_event thread blockade_get_bomb_icon_on_cell_phone();
}

objectives_finale() {
  var_0 = scripts\engine\utility::getStruct("_encstr_B8AD176B637A1649DCE7E9400193484723C39FF597135D7BFE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 0;
  var_2 = scripts\engine\utility::ter_op(var_1, (8, 17, 3), (0, 0, 0));
  var_3 = scripts\mp\gameobjects::createhintobject(var_0.origin + var_2, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_BAC71F816A2109C80939916E35D5ED9F33D1A9BD9E2F9DB1AFA9A405972D57D673");
  var_3 thread objectivespawner();
  var_3 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_3 notify("_encstr_9A6211849BD87BBF332278E3F2BB0173C1AF90");
  var_3 delete();
  level thread obj_room_fire_05();
}

objectivespawner() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9A6211849BD87BBF332278E3F2BB0173C1AF90");

  for(;;) {
    playsoundatpos(self.origin, "_encstr_A6181638A5A3790337F1DFAEB38F8B9817711751544B0910");
    wait 4.0;
  }
}

obj_room_fire_05() {
  level.ai_event thread objectiveachievementkillcount();
  wait 0.01;

  if(level.ai_event.initoperatorunlocks < 1)
    objective_minimapupdate("_encstr_ADAA1DA51289C0E0D7B9CBD043BF26E95F8E2305BC61A8B6CF53A6B94A87D1");

  level.ai_event.start_coop_escort_enter_vehicles = 1;
  level.ai_event.initoperatorunlocks = level.ai_event.initoperatorunlocks + 1;
  _id_13EE8();
  level.ai_event objectivelocations();
}

objective_hide_for_mlg_spectator() {
  if(!level.ai_event.pour) {
    return;
  }
  var_0 = [];
  var_0[1] = ["_encstr_A6561CC49CAEA3CAFA8CC2B9DC2FAFA30D56FACC2D39561B4EB01BB556E4", "_encstr_A91C1B05B2E31805CF0A48907233C3897B3083874C4FA05863D223785B", "_encstr_865116B27BC83CE311C30832CA3B615328AFE1FB90B862BE", "_encstr_8D3A17BE12DB6129DFE778F88707C39162F12631AC021911DA", "_encstr_912918E0D3AB11517F69382D4897F8B3993A1040FBC669A84F82"];
  var_0[2] = ["_encstr_A7C90C1BBD6F687FA77857DB40D3", "_encstr_AC9310C743B2A02308A5E7A5AF79B86CCF06", "_encstr_85DA0AB32834F717F05BD3C0", "_encstr_A1330EC7269BC7ABDB7357A8F02F3A12"];
  var_0[3] = ["_encstr_AFE7099BD676BE66E40B3B", "_encstr_A6740DEF13AF4983753381B0ABCE6F", "_encstr_9155086EDA3BBE3B0BB9", "_encstr_8F370C2F7AC7A32B205B5087E938"];
  var_0[4] = ["_encstr_BE1904DCDA9D", "_encstr_AB3508737F830710ACDB"];
  var_1 = scripts\engine\utility::random(var_0[1]);
  level.ai_event._id_13005[0] = var_1;
  var_2 = undefined;

  switch (var_1) {
    case "_encstr_A6561CC49CAEA3CAFA8CC2B9DC2FAFA30D56FACC2D39561B4EB01BB556E4":
      var_2 = "_encstr_8DCB085BEF657B4DCF0B";
      break;
    case "_encstr_A91C1B05B2E31805CF0A48907233C3897B3083874C4FA05863D223785B":
      var_2 = "_encstr_8A78055C8D488C";
      break;
    case "_encstr_865116B27BC83CE311C30832CA3B615328AFE1FB90B862BE":
      var_2 = "_encstr_9B1804C793EB";
      break;
    case "_encstr_8D3A17BE12DB6129DFE778F88707C39162F12631AC021911DA":
      var_2 = "_encstr_88A906570DDE7B21";
      break;
    case "_encstr_912918E0D3AB11517F69382D4897F8B3993A1040FBC669A84F82":
      var_2 = "_encstr_BE7206A2D07B1322";
      break;
  }

  var_3 = 2;
  var_4 = [];

  for(var_5 = 1; var_5 <= var_3; var_5++) {
    var_6 = 3;
    var_7 = 5 - var_5;
    var_4[var_5] = [];

    for(var_8 = 4; var_8 >= var_7; var_8--) {
      var_9 = var_0[var_8];

      foreach(var_11 in var_9) {
        if(issubstr(var_11, var_2))
          var_9 = scripts\engine\utility::array_remove(var_9, var_11);
      }

      var_4[var_5] = scripts\engine\utility::array_combine_unique(var_4[var_5], var_9);
    }

    level.ai_event.nolandingdamage[var_5] = var_4[var_5];
  }

  level.ai_event.pour = 0;
}

objectivelocations() {
  level.ai_event obj_room_fire_06();
  level.ai_event objective_hide_for_mlg_spectator();
  var_0 = level.ai_event.nolandingdamage[level.ai_event.initoperatorunlocks];

  switch (level.ai_event.initoperatorunlocks) {
    case 1:
      level.ai_event thread bomb_detonator_holder(var_0, 4, 7, level.ai_event.binoculars_settargetmarkerstate[1]);
      break;
    case 2:
      level.ai_event thread bomb_detonator_holder(level.ai_event._id_13005, 3, 5, 1);
      level.ai_event thread bomb_detonator_holder(var_0, 4, 7, level.ai_event.binoculars_settargetmarkerstate[2], level.ai_event.binoculars_updatetargetmarker);
      break;
    default:
      level.ai_event thread bomb_detonator_holder(level.ai_event.nogroundfoundtime, 3, 6, level.ai_event.binoculars_settargetmarkerstate[0]);
      break;
  }

  level.ai_event obj_room_fire_11();
}

obj_room_fire_06() {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.ai_event.current_state = "_encstr_BE4B0EBB2CB32B7D4B731BF66B5AB9CE";
  _id_13EEA("_encstr_BE4B0EBB2CB32B7D4B731BF66B5AB9CE");
  var_0 = 0;
  var_1 = gettime() / 1000;
  var_2 = gettime() / 1000;
  var_3 = scripts\engine\utility::ter_op(level.ai_event.initoperatorunlocks == 1, 1, 10);

  for(;;) {
    var_4 = gettime() / 1000;
    var_0 = var_3 - (var_4 - var_1);

    foreach(var_6 in level.ai_event._id_12662) {
      if(isDefined(var_6.boardroomdoorcodeentrysuccess)) {
        var_6.boltunlink setvalue(ceil(var_0));

        if(var_4 - var_2 > 1.0) {
          var_7 = objloc(var_0);
          var_6 playlocalsound(var_7);
          var_2 = gettime() / 1000;
        }
      }
    }

    if(var_0 <= 0) {
      break;
    }

    waitframe();
  }

  if(level.ai_event.initoperatorunlocks > 1) {
    foreach(var_6 in level.ai_event._id_12662)
    var_6 playlocalsound("_encstr_96EE184BBBE0D7B358AD5637BEDC83D816DC0DAFB95AD8EC95E4");
  }

  level.ai_event._id_13B97 = gettime();
  level.ai_event.current_state = "_encstr_B6FB0CD3A84DC7E7B93EFCE94CC1";
  level.ai_event.new_col_map = level.ai_event.binoculars_settargetmarkerstate[level.ai_event.initoperatorunlocks];
  _id_13EEA("_encstr_B6FB0CD3A84DC7E7B93EFCE94CC1");
}

obj_room_fire_11() {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = gettime() / 1000;
  var_1 = 0;
  var_2 = undefined;

  for(;;) {
    var_3 = gettime() / 1000;
    var_1 = floor(var_3 - var_0);

    if(var_1 >= level.ai_event.bodyonly_guy_in_car_damage_monitor && level.ai_event._id_12662.size == 0) {
      level.ai_event.initoperatorunlocks = level.ai_event.initoperatorunlocks - 1;
      var_2 = "_encstr_995408F398012F656821";
      break;
    }

    if(level.ai_event.brclearscoreboardstats.size <= 0 && level.ai_event._id_14525.size == 0) {
      var_2 = "_encstr_88E30897BDF1B71F7823";
      break;
    }

    wait 0.1;
  }

  obj_room_fire_10(var_2);
}

obj_room_fire_10(var_0) {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  switch (var_0) {
    case "_encstr_88E30897BDF1B71F7823":
      level.ai_event.current_state = "_encstr_86350E4338DD775749A87560315123BF";
      _id_13EEA("_encstr_86350E4338DD775749A87560315123BF");

      if(level.ai_event.initoperatorunlocks < 2) {
        objective_minimapupdate("_encstr_9B7523BBD5801B4728F60BD5EBD08211671BC73F75359214B1DB469B4129DB5ACDA38BB7C9", int(level.ai_event.initoperatorunlocks));
        wait 0.1;
        level thread obj_room_fire_05();
      } else {
        objective_minimapupdate("_encstr_99253229FA37F0D8620769574FCA9E49A5537120E34F280E9AAFC7593FD2E9017BEDF87B8DDD784DD1D39B417319AEC01CC6A3F0");
        level.ai_event.current_state = "_encstr_AF9A099E17EA0831658B71";
        _id_13EEA("_encstr_AF9A099E17EA0831658B71");
        _encstr_8EF32E0E938861A33D3EFF5D683F77B94F3893C8BF329BC861BA4793874FF9E505DF30A2296D159C7ACBD07BB8717E7F::_id_12D21("_encstr_BDCB11D9B55B818E01C77838936740F3D21D4E");

        foreach(var_2 in level.ai_event._id_12662) {
          if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
            var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_91F5357C9BEE8FE447C82A12C813DDC7C128FDF059F19B6F9F90629AE817D5D73B8E7197E05E0BB5ADD9CBE751EB81BF337DCE0490E333", 1);
        }

        objectiveloc();
      }

      break;
    case "_encstr_995408F398012F656821":
      objective_minimapupdate("_encstr_87C324C4277D9BDE0BD7D17BEEB2C97D5896EB2BEC59CDE8BEA3A55B59E47DACF0072D4E2BC8");

      foreach(var_5 in level.ai_event.brclearscoreboardstats) {
        var_5._id_11E90 = 1;
        var_5[[var_5.isinlaststand]]();
        var_5 kill();
      }

      objectiveloc();
      break;
  }
}

objectiveloc() {
  level.ai_event.pour = 1;
  level.ai_event._id_13005 = [];
  level.ai_event.enemy_mine_damaged_think = 0;
  level.ai_event.start_coop_escort_enter_vehicles = 0;
  level.ai_event._id_13B97 = -1;
  level.ai_event.initoperatorunlocks = 0;
  level.ai_event.current_state = "_encstr_8882099673858D1D4B6756";
  level.ai_event.new_col_map = -1;
  level.ai_event._id_14525 = [];
  _id_13EE9();

  foreach(var_1 in level.ai_event._id_12660) {
    var_1.boardroomopen = 0;
    var_1.body0 = 0;
  }

  level.ai_event._id_12660 = [];
  level thread objectives_finale();
  level.ai_event notify("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
}

objectiveachievementkillcount() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level.ai_event notify("_encstr_A3BD1A43335FB0980B978DB7D743DBF8FCCC487811AFE0C5228B8BBD");
  level.ai_event endon("_encstr_A3BD1A43335FB0980B978DB7D743DBF8FCCC487811AFE0C5228B8BBD");

  for(;;) {
    var_0 = scripts\engine\utility::array_combine_unique(level.ai_event._id_12659, level.ai_event._id_12662);

    foreach(var_2 in var_0) {
      var_3 = var_2 objective_set_hot();

      if(!var_3 && var_2 objectiveids())
        var_2 objective_timers_reset_both();
      else if(isalive(var_2))
        var_2 objectiveicon();
      else
        var_2 objectivedescription();

      var_4 = gettime() / 1000;

      foreach(var_2 in level.ai_event._id_12663) {
        var_6 = gettime() / 1000 - var_2.boltunlinkonnote / 1000;
        var_7 = var_2.boltdeletethread;

        if(isDefined(var_7)) {
          if(var_7.hidden)
            var_7 scripts\mp\hud_util::showelem();

          var_7 setvalue(ceil(10 - var_6));
        }

        if(var_2 objectiveids()) {
          var_2 objective_timers_reset_both();

          if(isDefined(var_7))
            var_7 scripts\mp\hud_util::hideelem();

          continue;
        }

        if(var_6 >= 10) {
          var_2 objectivedescription();
          objective_locations_logic(var_2, "_encstr_8103224C9CBEB9DB0B7D1DEDEEB2C9AF5896D7569D95E6E8D7D5DC6EBA269B1BE4D231B2");
        }
      }
    }

    wait 0.1;
  }
}

objective_timers_reset_both() {
  if(!isDefined(self)) {
    return;
  }
  if(!objective_set_hot()) {
    level.ai_event._id_12662 = scripts\engine\utility::array_add(level.ai_event._id_12662, self);
    self.boardroomopen = 0;
    self.body0 = 0;
    _id_13EF3();

    if(level.ai_event.current_state != "_encstr_8882099673858D1D4B6756")
      objective_locations_logic(self, "_encstr_ADAA1DA51289C0E0D7B9CBD043BF26E95F8E2305BC61A8B6CF53A6B94A87D1");
  } else if(objective_origin()) {
    self.boltunlinkonnote = undefined;
    level.ai_event._id_12663 = scripts\engine\utility::array_remove(level.ai_event._id_12663, self);
  }
}

objectivedescription() {
  if(!isDefined(self)) {
    return;
  }
  if(objective_set_hot()) {
    _id_13EF4();
    level.ai_event._id_12662 = scripts\engine\utility::array_remove(level.ai_event._id_12662, self);
    level.ai_event._id_12663 = scripts\engine\utility::array_remove(level.ai_event._id_12663, self);
  }
}

objectiveicon() {
  if(!isDefined(self)) {
    return;
  }
  if(objective_set_hot() && !objective_origin()) {
    self.boltunlinkonnote = gettime();
    level.ai_event._id_12663 = scripts\engine\utility::array_add(level.ai_event._id_12663, self);
  }
}

objectiveids() {
  if(!isDefined(self))
    return 0;

  var_0 = 150;
  var_1 = abs(self.origin[2] - (level.ai_event.occupied_rpg_trig.origin[2] - var_0)) < 100;

  if(scripts\engine\utility::array_contains(level.ai_event._id_12659, self) && var_1)
    return 1;

  return 0;
}

objective_set_hot() {
  if(!isDefined(self))
    return 0;

  return scripts\engine\utility::array_contains(level.ai_event._id_12662, self);
}

objective_origin() {
  if(!isDefined(self))
    return 0;

  return scripts\engine\utility::array_contains(level.ai_event._id_12663, self);
}

objectives_amount(var_0) {
  foreach(var_2 in level.ai_event.brclearscoreboardstats) {
    if(isDefined(var_2.squadleaderbeacon_fxent)) {
      if(var_0) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.squadleaderbeacon_fxent, self);
        continue;
      }

      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2.squadleaderbeacon_fxent, self);
    }
  }
}

objective_show_for_mlg_spectator() {
  if(!isDefined(self))
    return 0;

  if(!scripts\engine\utility::array_contains(level.ai_event._id_12660, self)) {
    level.ai_event._id_12660 = scripts\engine\utility::array_add(level.ai_event._id_12660, self);
    self.boardroomopen = 0;
    self.body0 = 0;
  }
}

objloc(var_0) {
  return "_encstr_A9B919BAA5F5B507D7E8A56BCA4EBEB1F6EACD8E23DBDDE6AF2603";
  return "_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40";
  return "_encstr_88981FAE96AF5B83EB474B6B5693BE36B75737A332DEBB37F586C21B66AF6EB21B";
  return "_encstr_962A22AB96EBDA07BEE85AD6AC9CFAD8B7D5B947C8BDEEB9FA17BA8539E89593F5B9B28D";
  return "_encstr_B6AF180B8909B0EFAF8BE810E26330885D0DB5B12CED983887F7";
}

_id_13DAB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(issubstr(var_1.targetname, "_encstr_A101062B6759E68E")) {
    if(isPlayer(var_0) && !scripts\engine\utility::array_contains(level.ai_event._id_12659, var_0)) {
      level.ai_event._id_12659 = scripts\engine\utility::array_add(level.ai_event._id_12659, var_0);
      var_0 objectives_amount(1);
    }
  }

  if(issubstr(var_1.targetname, "_encstr_A2D907ECC2C9B09D95")) {
    var_2 = getsubstr(var_1.targetname, 11);

    if(isDefined(var_0.waittill_any_timeout_5)) {
      if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0))
        level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0);
    }

    if(isPlayer(var_0) && !scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0)) {
      level.ai_event.select_hostage_room_three_spawners[var_2].players = scripts\engine\utility::array_add(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0);
      var_0.waittill_any_timeout_5 = var_2;
    }
  }
}

_id_13DAC(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(issubstr(var_1.targetname, "_encstr_A101062B6759E68E")) {
    if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event._id_12659, var_0)) {
      level.ai_event._id_12659 = scripts\engine\utility::array_remove(level.ai_event._id_12659, var_0);
      var_0 objectives_amount(0);

      if(isDefined(var_0.waittill_any_timeout_5)) {
        if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0))
          level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var_0.waittill_any_timeout_5].players, var_0);
      }
    }
  }

  if(issubstr(var_1.targetname, "_encstr_A2D907ECC2C9B09D95")) {
    waitframe();
    var_2 = getsubstr(var_1.targetname, 11);
    var_3 = var_2 != var_0.waittill_any_timeout_5;

    if(isPlayer(var_0) && scripts\engine\utility::array_contains(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0) && var_3)
      level.ai_event.select_hostage_room_three_spawners[var_2].players = scripts\engine\utility::array_remove(level.ai_event.select_hostage_room_three_spawners[var_2].players, var_0);
  }
}

_id_13DA5(var_0, var_1) {
  if(!isDefined(var_0))
    return 1;

  if(!isPlayer(var_0))
    return 1;

  return 0;
}

objective_minimapupdate(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.intvar = var_1;
  }

  foreach(var_4 in level.ai_event._id_12662)
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_4, var_0, var_2);
}

objective_locations_logic(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, var_1, var_3);
}

_id_1320F() {
  if(scripts\mp\utility\game::getgametype() != "_encstr_931D068662634370") {
    return;
  }
  if(!isDefined(level.teamnamelist) || !scripts\engine\utility::array_contains(level.teamnamelist, "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8")) {
    return;
  }
  scripts\mp\utility\teams::setteamdata("_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8", "_encstr_AB580A05672AE35D5FFF50B8", 999);
}

bot_allowed_weapons(var_0, var_1, var_2, var_3) {
  var_4 = issubstr(var_2, "_encstr_BE1D0698E4D5472B");
  var_5 = scripts\mp\mp_agent::spawnnewagent(scripts\engine\utility::ter_op(var_4, "_encstr_A7D418B06C477B9CBE59DCB25BBCD7B1BBBE98E4FA4C4EEAA3CA", "_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B"), "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8", var_0, var_1);

  if(!isDefined(var_5)) {
    return;
  }
  level.ai_event.brclearscoreboardstats = scripts\engine\utility::array_add(level.ai_event.brclearscoreboardstats, var_5);
  var_5 thread bomber_death_thread();
  var_5.type = var_2;
  var_5.enemy_left_monitor = var_4;
  var_5 scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", 1);
  var_5 bomb_detonator_bomb_type();
  var_5 bomber();
  var_5 thread bomber_delay_thread();
  var_5.guid = var_5 getguid();
  var_5.name = var_5.guid;
  var_5.agentname = &"_encstr_A3CF1633A9D613B0CBE007CBC5ED39A79C898BCF914CB9E8";
  var_5 boss_one_minion_watcher();
  var_5 bomb_detonator_waiting_for_pick_up();
  var_5 boss_two_minion_watcher(var_2);
  var_5 boss_fight_combat_forest(var_3);

  if(var_4) {
    var_5 boss_fight_combat_laser_trap();

    foreach(var_7 in level.ai_event._id_12662)
    var_7 playlocalsound("_encstr_8C7A18DB3337BBE018906F0B49F2B0D35FDAA3D7ACD7433983F0");

    if(level.ai_event.initoperatorunlocks == 2) {
      level.ai_event.enemy_mine_damaged_think = 1;
      _id_13EEA("_encstr_840412770BB356BEC2B1E8A567ACBE139CEA8EB2");
    }
  }

  var_5 thread bonuskillscharge();
  var_5 thread bot_choose_attack_zone();
  return var_5;
}

bomber() {
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;
  self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;
  self.pers["_encstr_8305198D5D93D7AD5AD8B1F5B93A9C5616D6BE33BD937DE6ABB6CA"] = 0;
  self.tookweaponfrom = [];
  self.killedplayers = [];
  self._id_1407D = 0;
}

boss_one_minion_watcher() {
  self.maxhealth = level.ai_event.binoculars_registertargetstate;
  self.health = level.ai_event.binoculars_registertargetstate;
  self.health_remaining = level.ai_event.binoculars_registertargetstate;
  self.showseasonalcontent = level.ai_event.binoculars_registertargetstate;
  self.showsplashtoall = level.ai_event.binoculars_registertargetstate;
  self.meleedamageoverride = level.ai_event.binoculars_removeheadicon;
  self.sound_events = 0;
  self._id_12D29 = undefined;
  self._id_12D2A = undefined;
  self._id_12D25 = 0;
  var_0 = level.ai_event.binoculars_onstateunmarkedexit;
  var_1 = level.ai_event.binoculars_onstatemarkpendingupdate;
  var_2 = level.ai_event.binoculars_onstateunmarkedupdate;
  var_3 = level.ai_event.binoculars_onstateunmarkedenter;
  var_4 = var_1 + var_3 * (level.ai_event.initoperatorunlocks - 1);
  var_5 = clamp(var_4, var_2, var_0);
  self.baseaccuracy = var_5;
  self.scripted_long_deaths = 0;
  self.agentdamagefeedback = 1;
  self.isinlaststand = ::blank_relic_func;
  self._id_119EA = _encstr_8EF32E0E938861A33D3EFF5D683F77B94F3893C8BF329BC861BA4793874FF9E505DF30A2296D159C7ACBD07BB8717E7F::_id_119F7;
  self._id_130DF = _encstr_8EF32E0E938861A33D3EFF5D683F77B94F3893C8BF329BC861BA4793874FF9E505DF30A2296D159C7ACBD07BB8717E7F::_id_12D28;
  self.scriptable_carriable_damage = _encstr_8EF32E0E938861A33D3EFF5D683F77B94F3893C8BF329BC861BA4793874FF9E505DF30A2296D159C7ACBD07BB8717E7F::_id_12D22;
  self._id_11E90 = scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370";
  self.enemy_mine_proximity_think = 0;
  self.ignoreall = getdvarint("_encstr_AF0C213EEB4366550A69A838626277F947AFCDBB41BBC893B992A0982AFBBFD19F2AC5", 0);
}

bomber_death_thread() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = randomfloatrange(1.25, 2.75);
  wait(var_0);
  scripts\cp_mp\vehicles\cargo_truck_mg::autoassignquest(self);
  scripts\cp_mp\vehicles\cargo_truck_mg::playorderevent("_encstr_ACA20538F84D39", "_encstr_82EE0B8DE82C13A2187BCEFE14", anim.player);
}

bomb_detonator_waiting_for_pick_up(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(!isDefined(var_0)) {
      var_1 = level.ai_event.binoculars_ontake;
      var_2 = level.ai_event.binoculars_processlosqueue;
      var_0 = var_1 + clamp(level.ai_event.initoperatorunlocks - 1, 0, 10) * var_2;
    }

    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::teamfriendlyto();
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
    boss_fight_combat_cave(var_0);
  }
}

boss_fight_combat_cave(var_0) {
  if(!isDefined(var_0) || var_0 < 0) {
    return;
  }
  self.br_maxarmorhealth = var_0;
  self.br_armorhealth = var_0;
  var_1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", var_1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
  }
}

boss_two_minion_watcher(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(issubstr(var_0, "_encstr_AB3508737F830710ACDB")) {
    bomb_hostage_play_anim("_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6");
    self.goalradius = randomintrange(100, 200);
  }

  if(issubstr(var_0, "_encstr_BE1904DCDA9D")) {
    bomb_hostage_play_anim("_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D");
    self.goalradius = randomintrange(50, 100);
  }

  var_1 = undefined;

  if(issubstr(var_0, "_encstr_8A78055C8D488C"))
    var_1 = "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B";

  if(issubstr(var_0, "_encstr_8DCB085BEF657B4DCF0B"))
    var_1 = "_encstr_BA730BF8AFF178988293F158B9";

  if(issubstr(var_0, "_encstr_88A906570DDE7B21"))
    var_1 = "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683";

  if(issubstr(var_0, "_encstr_9B1804C793EB"))
    var_1 = "_encstr_83B20F81360389C45B1755530BF2AFD0B8";

  if(issubstr(var_0, "_encstr_BE7206A2D07B1322"))
    var_1 = "_encstr_8823119675DAFF897F878020BB99612B219D8F";

  if(isDefined(var_1))
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F(var_1, 2);

  if(self.enemy_left_monitor) {
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", 10);
    self.baseaccuracy = 0.65;
    self.meleedamageoverride = 30;
    self.scripted_long_deaths = 1;
    self.maxhealth = level.ai_event.binoculars_processlosqueuelow;
    self.health = level.ai_event.binoculars_processlosqueuelow;
    self.health_remaining = level.ai_event.binoculars_processlosqueuelow;
    self.showseasonalcontent = level.ai_event.binoculars_processlosqueuelow;
    self.showsplashtoall = level.ai_event.binoculars_processlosqueuelow;
    self.agentdamagefeedback = 0;
    self.eliminate_drone_minigun_speed = 8000;
    self.eliminate_drone_internal = 5;
    self.meleedamageoverride = level.ai_event.binoculars_processtargetdata;
    boss_fight_combat_cave(level.ai_event.binoculars_processlosqueuehigh);

    switch (var_0) {
      case "_encstr_A6561CC49CAEA3CAFA8CC2B9DC2FAFA30D56FACC2D39561B4EB01BB556E4":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_BA730BF8AFF178988293F158B9", 99);
        bomb_hostage_play_anim("_encstr_8C160DAFE71BF161681EB5BCB0F8FC", 30);
        boss_wave(10);
        self.agentname = &"_encstr_B8341971CAC6B95F3FA9CDF9BD8CE128C9A293432B710CBB88FD81";
        break;
      case "_encstr_A91C1B05B2E31805CF0A48907233C3897B3083874C4FA05863D223785B":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", 99);
        bomb_hostage_play_anim("_encstr_8C160DAFE71BF161681EB5BCB0F8FC", 32);
        boss_wave(11);
        self.agentname = &"_encstr_8C4C1AF89770AF35E14FBD5683610B96160F0121DD28B37D8145BE51";
        break;
      case "_encstr_865116B27BC83CE311C30832CA3B615328AFE1FB90B862BE":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_83B20F81360389C45B1755530BF2AFD0B8", 99);
        bomb_hostage_play_anim("_encstr_858110A5BB0EEB16C97DADB134859C1B5AB2", 24);
        boss_wave(12);
        self.agentname = &"_encstr_8ED11970D9377E4779DF530CD765EFEF6DF94F392B3F3480390DF3";
        break;
      case "_encstr_8D3A17BE12DB6129DFE778F88707C39162F12631AC021911DA":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", 99);
        bomb_hostage_play_anim("_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6", 20);
        boss_wave(13);
        self.agentname = &"_encstr_B89218094AD7A6D314BE542B54E4A8F2844AAA152AD71DA049B2";
        break;
      case "_encstr_912918E0D3AB11517F69382D4897F8B3993A1040FBC669A84F82":
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349F("_encstr_8823119675DAFF897F878020BB99612B219D8F", 99);
        bomb_hostage_play_anim("_encstr_95A3130718A2F7BA5518E65D7835B29DB120D3CE9A", 3);
        boss_wave(14);
        self.agentname = &"_encstr_A3AE1BCE76DF512745896FDBA15CF45E3DEE83F355B7087ECF194FB369";
        break;
    }
  } else
    boss_wave(level.ai_event.initoperatorunlocks);
}

boss_fight_combat_forest(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, scripts\engine\utility::random(level.ai_event.select_hostage_room_three_spawners));
  self setgoalvolumeauto(var_1);
}

bomb_hostage_play_anim(var_0, var_1) {
  self.weapon = scripts\mp\class::buildweapon(var_0, ["_encstr_91D30B98AF82FABB1A37C877AA", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", var_1);
  self giveweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
}

bombzone_press_use(var_0) {
  if(level.ai_event.brclearscoreboardstats.size <= var_0 && level.ai_event._id_14525.size == 0) {
    foreach(var_2 in level.ai_event.brclearscoreboardstats) {
      if(!isDefined(var_2.squadleaderbeacon_fxent))
        var_2 boss_fight_combat_laser_trap();
      else
        continue;

      var_3 = scripts\engine\utility::array_randomize(level.ai_event.select_hostage_room_three_spawners);
      var_4 = scripts\engine\utility::random(var_3);

      foreach(var_6 in var_3) {
        if(var_6.players.size > var_4.players.size)
          var_4 = var_6;
      }

      var_2 setgoalvolumeauto(var_4);
    }
  }
}

boss_fight_combat_laser_trap() {
  var_0 = undefined;
  var_1 = undefined;

  if(self.enemy_left_monitor) {
    var_1 = "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF";
    var_0 = "_encstr_A3E7147AC101F9202DC67561D5089990B64FC5EF8789";
    var_2 = undefined;

    switch (self.type) {
      case "_encstr_A6561CC49CAEA3CAFA8CC2B9DC2FAFA30D56FACC2D39561B4EB01BB556E4":
        var_2 = "_encstr_AB58061D6ED8A51E";
        break;
      case "_encstr_A91C1B05B2E31805CF0A48907233C3897B3083874C4FA05863D223785B":
        var_2 = "_encstr_AB0807923D1239C9AC";
        break;
      case "_encstr_865116B27BC83CE311C30832CA3B615328AFE1FB90B862BE":
        var_2 = "_encstr_B47D06F37D137857";
        break;
      case "_encstr_8D3A17BE12DB6129DFE778F88707C39162F12631AC021911DA":
        var_2 = "_encstr_8E72054960E2CB";
        break;
      case "_encstr_912918E0D3AB11517F69382D4897F8B3993A1040FBC669A84F82":
        var_2 = "_encstr_962B080AE48A90F49CB2";
        break;
    }

    if(isDefined(var_2))
      var_0 = var_0 + var_2;
  } else
    var_1 = "_encstr_979016B3038528F88F5A6A33C28F28B0D19F2305AD2AE83E";

  var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.squadleaderbeacon_fxent = var_3;
  objective_state(self.squadleaderbeacon_fxent, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(self.squadleaderbeacon_fxent, self.origin + (0, 0, 100));
  objective_setplayintro(self.squadleaderbeacon_fxent, self.enemy_left_monitor);
  objective_setshowoncompass(self.squadleaderbeacon_fxent, 0);
  objective_setshowdistance(self.squadleaderbeacon_fxent, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(self.squadleaderbeacon_fxent, var_1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.squadleaderbeacon_fxent, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.squadleaderbeacon_fxent, 80);
  scripts\mp\objidpoolmanager::update_objective_onentity(self.squadleaderbeacon_fxent, self);

  if(isDefined(var_0))
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.squadleaderbeacon_fxent, var_0);

  if(self.enemy_left_monitor)
    scripts\mp\objidpoolmanager::objective_set_pulsate(self.squadleaderbeacon_fxent, 1);

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.squadleaderbeacon_fxent);

  foreach(var_5 in level.ai_event._id_12662)
  var_5 objectives_amount(1);
}

boss_wave(var_0) {
  if(!isDefined(var_0))
    var_0 = level.ai_event.initoperatorunlocks;

  var_1 = [];

  switch (var_0) {
    case 1:
      var_1["_encstr_82EA13A1FBB815B3686F507F12755D371C97F84A63"] = randomintrange(30000, 50000);
      var_1["_encstr_84D714386197BF9331AE78574CBB7F4513E0E251F861"] = randomintrange(30000, 50000);
      var_1["_encstr_93E714415B1637AD2FB0B229E82DE70B89A5ED27D15B"] = randomintrange(30000, 50000);
      var_1["_encstr_881D1914A4AFB1B77336D5CDB92DDBDCBE3B27959BB046CAFAB60E"] = randomintrange(30000, 50000);
      var_1["_encstr_81B7155EABAF23689028E793C1A9220AB5C79FCF0863CB"] = randomintrange(30000, 50000);
      var_1["_encstr_B47B0EB6FC377A8F1547F8C86BCF20E3"] = randomintrange(30000, 50000);
      var_1["_encstr_827F0D259877BE28A58C3B19BF8D48"] = randomintrange(30000, 50000);
      var_1["_encstr_B4BD0A2852BEB385E67DB683"] = randomintrange(30000, 50000);
      var_1["_encstr_AD5C12A052FAD9C26EFAEC9CCA9B58192BD75B0E"] = randomintrange(30000, 50000);
      break;
    case 2:
      var_1["_encstr_82EA13A1FBB815B3686F507F12755D371C97F84A63"] = randomintrange(5000, 12000);
      var_1["_encstr_84D714386197BF9331AE78574CBB7F4513E0E251F861"] = randomintrange(5000, 12000);
      var_1["_encstr_93E714415B1637AD2FB0B229E82DE70B89A5ED27D15B"] = randomintrange(5000, 12000);
      var_1["_encstr_881D1914A4AFB1B77336D5CDB92DDBDCBE3B27959BB046CAFAB60E"] = randomintrange(5000, 12000);
      var_1["_encstr_81B7155EABAF23689028E793C1A9220AB5C79FCF0863CB"] = randomintrange(5000, 12000);
      var_1["_encstr_B47B0EB6FC377A8F1547F8C86BCF20E3"] = randomintrange(5000, 12000);
      var_1["_encstr_827F0D259877BE28A58C3B19BF8D48"] = randomintrange(5000, 12000);
      var_1["_encstr_B4BD0A2852BEB385E67DB683"] = randomintrange(5000, 12000);
      var_1["_encstr_AD5C12A052FAD9C26EFAEC9CCA9B58192BD75B0E"] = randomintrange(5000, 12000);
      break;
    case 3:
      var_1["_encstr_82EA13A1FBB815B3686F507F12755D371C97F84A63"] = randomintrange(3000, 6000);
      var_1["_encstr_84D714386197BF9331AE78574CBB7F4513E0E251F861"] = randomintrange(3000, 6000);
      var_1["_encstr_93E714415B1637AD2FB0B229E82DE70B89A5ED27D15B"] = randomintrange(3000, 6000);
      var_1["_encstr_881D1914A4AFB1B77336D5CDB92DDBDCBE3B27959BB046CAFAB60E"] = randomintrange(3000, 6000);
      var_1["_encstr_81B7155EABAF23689028E793C1A9220AB5C79FCF0863CB"] = randomintrange(3000, 6000);
      var_1["_encstr_B47B0EB6FC377A8F1547F8C86BCF20E3"] = randomintrange(3000, 6000);
      var_1["_encstr_827F0D259877BE28A58C3B19BF8D48"] = randomintrange(3000, 6000);
      var_1["_encstr_B4BD0A2852BEB385E67DB683"] = randomintrange(3000, 6000);
      var_1["_encstr_AD5C12A052FAD9C26EFAEC9CCA9B58192BD75B0E"] = randomintrange(3000, 6000);
      break;
    case 10:
      var_1["_encstr_B47B0EB6FC377A8F1547F8C86BCF20E3"] = randomintrange(2000, 4000);
      break;
    case 11:
      var_1["_encstr_82EA13A1FBB815B3686F507F12755D371C97F84A63"] = randomintrange(2000, 6000);
      break;
    case 12:
      var_1["_encstr_B4BD0A2852BEB385E67DB683"] = randomintrange(2000, 4000);
      var_1["_encstr_AD5C12A052FAD9C26EFAEC9CCA9B58192BD75B0E"] = randomintrange(2000, 4000);
      break;
    case 13:
      var_1["_encstr_84D714386197BF9331AE78574CBB7F4513E0E251F861"] = randomintrange(2000, 6000);
      break;
    case 14:
      var_1["_encstr_93E714415B1637AD2FB0B229E82DE70B89A5ED27D15B"] = randomintrange(2000, 5000);
      break;
    default:
      var_1["_encstr_82EA13A1FBB815B3686F507F12755D371C97F84A63"] = randomintrange(5000, 20000);
      var_1["_encstr_84D714386197BF9331AE78574CBB7F4513E0E251F861"] = randomintrange(5000, 20000);
      var_1["_encstr_93E714415B1637AD2FB0B229E82DE70B89A5ED27D15B"] = randomintrange(5000, 20000);
      var_1["_encstr_881D1914A4AFB1B77336D5CDB92DDBDCBE3B27959BB046CAFAB60E"] = randomintrange(5000, 20000);
      var_1["_encstr_81B7155EABAF23689028E793C1A9220AB5C79FCF0863CB"] = randomintrange(5000, 20000);
      var_1["_encstr_B47B0EB6FC377A8F1547F8C86BCF20E3"] = randomintrange(5000, 20000);
      var_1["_encstr_827F0D259877BE28A58C3B19BF8D48"] = randomintrange(5000, 20000);
      var_1["_encstr_B4BD0A2852BEB385E67DB683"] = randomintrange(5000, 20000);
      var_1["_encstr_AD5C12A052FAD9C26EFAEC9CCA9B58192BD75B0E"] = randomintrange(5000, 20000);
      break;
  }

  if(var_1.size > 0)
    scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_134B1(var_1);
}

bot_choose_attack_zone() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0, var_1, var_2, var_3);

    if(!scripts\mp\utility\weapon::grenadethrown(var_0)) {
      continue;
    }
    scripts\mp\weapons::grenadeinitialize(var_0, var_1, var_2, var_3);
    self notify("_encstr_97E30EEC9359DC0B19ACBE47D027BDDD");

    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(var_0.weapon_name)) {
      return;
    }
    var_0.spawnpos = var_0.origin;

    switch (var_0.weapon_name) {
      case "_encstr_BA730BF8AFF178988293F158B9":
        thread scripts\mp\equipment\molotov::molotov_used(var_0);
        break;
      case "_encstr_83B20F81360389C45B1755530BF2AFD0B8":
        thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
        break;
    }
  }
}

bonuskillscharge() {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  self endon("_encstr_AD75063D571AE108");
  var_0 = gettime() / 1000;

  for(;;) {
    var_1 = self getgoalvolume();
    var_2 = distance2d(self.origin, var_1.origin);
    var_3 = var_2 < 600;
    self._id_145D4 = var_3;

    if(var_3) {
      var_4 = gettime() / 1000;
      var_5 = var_4 - var_0;
      self._id_13B6B = var_5;
      var_6 = level.ai_event.binoculars_targetisvalid;
      self._id_13B6C = var_6 - var_5;

      if(var_4 - var_0 >= var_6) {
        var_7 = [];

        foreach(var_9 in level.ai_event.select_hostage_room_three_spawners) {
          if(var_9.players.size > 0 && var_9 != var_1)
            var_7[var_7.size] = var_9;
        }

        if(var_7.size > 0) {
          var_11 = scripts\engine\utility::random(var_7);
          self setgoalvolumeauto(var_11);
        }

        var_0 = gettime() / 1000;
      }
    } else
      var_0 = gettime() / 1000;

    wait 1.0;
  }
}

bomber_delay_thread() {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  self endon("_encstr_AD75063D571AE108");

  while(!self.enemy_left_monitor) {
    self setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level.ai_event._id_11C20);
    self unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level.ai_event._id_11C1F);
  }
}

bomb_detonator_bomb_type() {
  if(!ispointonnavmesh(self.origin, self, 1)) {
    var_0 = getclosestpointonnavmesh(self.origin, self);

    if(isDefined(var_0))
      self forceteleport(var_0, self.angles);
  }
}

black_screen_overlay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_13.agent_type) || var_13.asm.archetype != "_encstr_87E80E37DE63915AB2E4BED8EEF59893") {
    return;
  }
  var_14 = isDefined(var_1) && isPlayer(var_1);
  var_15 = isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_16 = var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && (isDefined(var_8) && var_8 == "_encstr_8BBA05185F8B99") || var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48";
  var_17 = var_4 == "_encstr_9B0D099AD3887D91252954";

  if(var_14 || var_15) {
    var_18 = var_2;
    var_19 = weaponclass(var_5);
    var_20 = scripts\mp\utility\weapon::getweapongroup(var_5);
    var_21 = scripts\mp\utility\weapon::getequipmenttype(var_5.basename);
    var_22 = var_19 == "_encstr_92590EFBF91ED25750D8D7DC30B88E8A";

    if(var_16 && var_19 == "_encstr_8C8D08671D451291C849")
      var_2 = var_18 * 2;

    if(var_22)
      var_2 = var_18 * 2.5;
  }

  if(self.enemy_left_monitor && !self.enemy_mine_proximity_think) {
    var_23 = float(level.ai_event.binoculars_processlosqueuelow) * 0.2;

    if(self.health < var_23) {
      level.ai_event notify("_encstr_8D1F1A239BA0DBC9A0E35E5C93388F1FDF91DA7A23101FFAF0FF4633");
      self.enemy_mine_proximity_think = 1;
    }
  }

  scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

blade_trigger_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0) + scripts\engine\utility::ter_op(isDefined(var_13), var_13, 0);
  [[self._id_130DF]](var_1, var_12, var_4, var_15);

  if(self.enemy_left_monitor)
    var_1 objective_show_for_mlg_spectator();

  scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
}

blank_relic_func(var_0) {
  level.ai_event.brclearscoreboardstats = scripts\engine\utility::array_remove(level.ai_event.brclearscoreboardstats, self);

  if(!isDefined(level.ai_event._id_13BE3[level.ai_event.initoperatorunlocks]))
    level.ai_event._id_13BE3[level.ai_event.initoperatorunlocks] = 0;

  level.ai_event._id_13BE3[level.ai_event.initoperatorunlocks] = level.ai_event._id_13BE3[level.ai_event.initoperatorunlocks] + 1;
  level.ai_event._id_13BE2 = level.ai_event._id_13BE2 + 1;
  bombzone_press_use(3);

  if(isDefined(self.squadleaderbeacon_fxent))
    objective_delete(self.squadleaderbeacon_fxent);

  if(self.enemy_left_monitor) {
    objective_minimapupdate("_encstr_AC4D25130876D3526BAFAB657C1BFBB7BB28CFA7A0C9074A652DB39F7033D259E020332F684174");
    _encstr_8EF32E0E938861A33D3EFF5D683F77B94F3893C8BF329BC861BA4793874FF9E505DF30A2296D159C7ACBD07BB8717E7F::_id_12D21("_encstr_A6851252683E5B59807DD5DC7B41DF5769C18A5A");
    level.ai_event notify("_encstr_8D1F1A239BA0DBC9A0E35E5C93388F1FDF91DA7A23101FFAF0FF4633");
    level.ai_event._id_14525 = [];

    foreach(var_2 in level.ai_event._id_12662) {
      var_2 playlocalsound("_encstr_B837198B90EE7B0BC9A7C23C80D5D220B640CB2FF080AEC2014D0F");
      var_2 playlocalsound("_encstr_852D141A504F6DAA3570CB7F5C0B14A7929320317B69");
    }

    level.ai_event.enemy_mine_damaged_think = 0;
    bombzone_press_use(level.ai_event.brclearscoreboardstats.size);
    _id_13EEA("_encstr_840412770BB356BEC2B1E8A567ACBE139CEA8EB2");
  }

  level.ai_event.new_col_map--;
  _id_13EEC();

  if(!isDefined(var_0)) {
    return;
  }
  self.is_correct_wire_color = var_0;
  var_0.agent = self;
  var_0.eattacker objective_show_for_mlg_spectator();
  var_4 = spawnStruct();
  var_4.eattacker = var_0.eattacker;
  var_4.origin = self.origin;
  var_4.angles = self.angles;

  if(!self._id_11E90) {
    level.ai_event thread[[self._id_119EA]]("_encstr_8F6D10D8BDDEA3BE8E8589B195BEC2B6ADDB", 1, var_4);
    level.ai_event thread[[self._id_119EA]]("_encstr_977F1036EDDE3AFAE816896356FAD8B0CDA1", 1, var_4);
    level.ai_event thread[[self._id_119EA]]("_encstr_B6A31063DEF61DBED1C2C41BB2D73BAC1639", 1, var_4);
    level.ai_event thread[[self._id_119EA]]("_encstr_AD711736DBF6A3F5E8C289362BBE19B207B1F6E5851336B26E", 1, var_4);

    if(self.enemy_left_monitor) {
      level.ai_event thread[[self._id_119EA]]("_encstr_BE1311637BEDE8AFA316C41B95BE984EAEA395", 25, var_4);
      level.ai_event thread[[self._id_119EA]]("_encstr_AD711736DBF6A3F5E8C289362BBE19B207B1F6E5851336B26E", 6, var_4);
      level.ai_event thread[[self._id_119EA]]("_encstr_99322281E7AA65991C3639F0DFCF889EE3131B5F4352A42B2E4F41CBC0E7685D1AEB97B5", 1, var_4);
      playFX(scripts\engine\utility::getfx("_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"), self.origin);

      if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_A95E0A98B78C2FC6F6AB9B1D")
        level.ai_event thread[[self._id_119EA]]("_encstr_8D6223FC4FE88BE7A5898A721168130550337A47E7A816EBD8C3F2DBF8D49FF1E0BFEBC51D", 1, var_4);
    }

    if(level.ai_event.initoperatorunlocks == 2 && level.ai_event.brclearscoreboardstats.size == 0) {
      playFX(scripts\engine\utility::getfx("_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"), self.origin);
      level.ai_event thread[[self._id_119EA]]("_encstr_864D1B51E75D20D0AB6221E80A2F76A87354DBBF86866081737918F1D3", 1, var_4);

      if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_A95E0A98B78C2FC6F6AB9B1D")
        level.ai_event thread[[self._id_119EA]]("_encstr_A27D1FDD70178B8F5BD06B5BD81678E2CF9DA299EC9592FA46E0676FF1AB212A9F", 2, var_4);
    }
  }

  [[self._id_130DF]](var_0.eattacker, var_0.shitloc, var_0.smeansofdeath, var_0.idamage);
  [[self.scriptable_carriable_damage]]("_encstr_85DE0947B06DAC23DBDDB9");
  [[self.scriptable_carriable_damage]]("_encstr_A1BD075837DCD29B47");
  [[self.scriptable_carriable_damage]]("_encstr_92A70DB84263F9805DA70775C44528");
}

bomb_detonator_holder(var_0, var_1, var_2, var_3, var_4) {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level.ai_event endon("_encstr_8D1F1A239BA0DBC9A0E35E5C93388F1FDF91DA7A23101FFAF0FF4633");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_4))
    wait(var_4);

  for(var_5 = undefined; !isDefined(var_5) || scripts\engine\utility::array_contains_key(level.ai_event._id_14525, var_5); var_5 = randomint(1000)) {}

  level.ai_event._id_14525 = scripts\engine\utility::array_add(level.ai_event._id_14525, var_5);
  var_6 = level.ai_event.helidestroyvehiclestouchtrace;
  var_7 = var_3;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = randomintrange(var_1, var_2);
  var_11 = 0;

  while(var_7 > 0) {
    var_12 = level.ai_event.binoculars_updateheadiconvisibilityforplayer;
    var_13 = level.ai_event.binoculars_targetisvalidmark;
    var_14 = level.ai_event.binoculars_updateprojectiondistance;
    var_15 = level.ai_event.binoculars_updateheadiconvisibility * (level.ai_event.initoperatorunlocks - 1);
    var_16 = clamp(var_13 + var_15, var_14, var_12);

    while(level.ai_event.brclearscoreboardstats.size >= var_16)
      wait 1.0;

    if(var_11 >= var_10)
      var_11 = 0;

    if(var_11 == 0) {
      if(var_6.size == 0)
        var_6 = level.ai_event.helidestroyvehiclestouchtrace;

      var_8 = int(clamp(randomint(var_6.size), 0, var_6.size));
      var_9 = var_6[var_8];
      var_6 = scripts\engine\utility::array_remove_index(var_6, var_8, 0);
    }

    var_17 = scripts\engine\utility::random(var_0);
    var_18 = bmoovertime(var_17);
    var_19 = scripts\engine\utility::ter_op(1, 1, bomb_detonator_interact(var_17));

    if(issubstr(var_17, "_encstr_BE1D0698E4D5472B"))
      var_7 = var_19;

    if(var_19 > var_7) {
      var_20 = [];

      foreach(var_22 in var_0) {
        if(var_19 <= var_7)
          var_20[var_20.size] = var_22;
      }

      if(var_20.size > 0)
        var_17 = scripts\engine\utility::random(var_20);
      else
        var_18 = 0;
    }

    if(var_18) {
      var_24 = undefined;
      var_25 = bootcampmodewatcher(var_9);

      if(isDefined(var_25))
        var_24 = bot_arena_think(var_17, var_25);

      if(isDefined(var_24)) {
        var_7 = var_7 - var_19;
        var_11++;
      }
    }

    waitframe();

    while(level.ai_event.brclearscoreboardstats.size > 7 || level.ai_event._id_12662.size == 0)
      wait 1.0;
  }

  level.ai_event._id_14525 = scripts\engine\utility::array_remove(level.ai_event._id_14525, var_5);
}

bomb_detonator_interact(var_0) {
  switch (var_0) {
    case "_encstr_BE1904DCDA9D":
      return 1;
    case "_encstr_AFE7099BD676BE66E40B3B":
      return 2;
    case "_encstr_9155086EDA3BBE3B0BB9":
      return 2;
    case "_encstr_ADA60A9BDAB3FA37D6EDD6B2":
      return 2;
    case "_encstr_A7C90C1BBD6F687FA77857DB40D3":
      return 3;
    case "_encstr_85DA0AB32834F717F05BD3C0":
      return 3;
    case "_encstr_AB3508737F830710ACDB":
      return 1;
    case "_encstr_A6740DEF13AF4983753381B0ABCE6F":
      return 1;
    case "_encstr_8F370C2F7AC7A32B205B5087E938":
      return 2;
    case "_encstr_8BE50E131FE367708CFB069BA56748AD":
      return 2;
    case "_encstr_AC9310C743B2A02308A5E7A5AF79B86CCF06":
      return 3;
    case "_encstr_A1330EC7269BC7ABDB7357A8F02F3A12":
      return 3;
  }

  if(issubstr(var_0, "_encstr_BE1D0698E4D5472B"))
    return 10;

  return 1;
}

bot_add_destination_spot(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_1 < 1) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::random(level.ai_event.helidestroyvehiclestouchtrace);

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = scripts\engine\utility::random(var_2);
    var_7 = bot_allowed_weapons(var_6.origin, var_6.angles, var_0, var_3);

    if(!isDefined(var_7)) {
      return;
    }
    var_4 = scripts\engine\utility::array_add(var_4, var_7);
  }

  return var_4;
}

bot_arena_think(var_0, var_1, var_2) {
  var_3 = bot_allowed_weapons(var_1.origin, var_1.angles, var_0, var_2);
  return var_3;
}

bmoovertime(var_0) {
  return scripts\engine\utility::array_contains(level.ai_event.nogroundfoundtime, var_0);
}

bootcampmodewatcher(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return undefined;

  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    var_4 = [];

    foreach(var_6 in var_3._id_11E34) {
      if(var_6.players.size > 0)
        var_4 = scripts\engine\utility::array_combine_unique(var_4, var_6.players);
    }

    if(var_4.size == 0) {
      var_1 = var_3;
      continue;
    }

    var_8 = 1;

    foreach(var_10 in var_4) {
      var_11 = distance2d(var_10.origin, var_3.origin);
      var_12 = var_11 <= 500;

      if(var_12) {
        var_8 = 0;
        continue;
      }

      var_13 = scripts\engine\utility::within_fov(var_10.origin, var_10.angles, var_3.origin, cos(45));
      var_14 = scripts\engine\utility::ter_op(var_13, spawnsighttrace(var_3, var_10.origin + (0, 0, 75), var_3.origin + (0, 0, 50)) > 0.2, 0);

      if(var_14) {
        var_8 = 0;
        continue;
      }

      if(var_8)
        var_1 = var_3;
    }
  }

  return var_1;
}

blockclasschange(var_0) {
  level.ai_event endon("_encstr_B6B418CDF60BBE3ADBEE2B9CEB9B8E7B38EBC2D2F5B267CAB93A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(level.ai_event.spawn_points.size == 0 || !isDefined(level.ai_event._id_12659))
    wait 0.1;

  for(;;) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1].origin;
      var_3 = (0, 0, 40);
      var_4 = -1;
      var_5 = (0, 1, 0);
      var_6 = 0;
      var_7 = 0;
      var_8 = 3200;
      var_9 = 0;

      foreach(var_11 in level.ai_event._id_12659) {
        var_12 = distance2d(var_11.origin, var_2);
        var_13 = var_11.origin + (0, 0, 75);
        var_14 = var_12 < 3200;
        var_15 = abs(var_2[2] - var_11.origin[2]) < 200;
        var_9 = scripts\engine\utility::within_fov(var_11.origin, var_11.angles, var_2, cos(45));
        var_16 = scripts\engine\utility::ter_op(var_9, spawnsighttrace(var_0[var_1], var_2, var_13) > 0.2, 0);
        var_17 = var_12 <= 500 && var_15;
        var_18 = var_17 || var_14 && var_15 && (var_16 && var_9);

        if(var_18) {
          if(var_12 < var_8)
            var_8 = var_12;

          var_7 = var_7 + var_12;
          var_6 = var_6 + 1;
        }
      }

      var_20 = -1;
      var_21 = 100;

      if(var_6 > 0) {
        var_4 = floor(var_7 / var_6);
        var_20 = (min(var_4, var_8) - 500) / 2700 * 100;
        var_21 = floor(max(var_20, 0));
        var_22 = (1, 0, 0);
        var_23 = (0, 1, 0);
        var_5 = vectorlerp(var_22, var_23, var_20 / 100);
      }

      var_0[var_1]._id_134DA = var_21;
    }

    level.ai_event._id_135B5 = scripts\engine\utility::array_sort_with_func(var_0, ::blockedvariantidsmap);
    wait 0.1;
  }
}

blockedvariantidsmap(var_0, var_1) {
  return var_0._id_134DA > var_1._id_134DA;
}

blockade_get_bomb_icon_on_cell_phone() {
  var_0 = [];
  var_1 = undefined;
  var_2 = 1050;
  var_3 = 0;

  while(var_0.size != level.ai_event.spawn_points.size) {
    level.ai_event.helidestroyvehiclestouchtrace[var_3] = [];

    foreach(var_5 in level.ai_event.spawn_points) {
      if(!scripts\engine\utility::array_contains(var_0, var_5)) {
        if(!isDefined(var_1))
          var_1 = var_5.origin;

        var_6 = distance2d(var_1, var_5.origin);

        if(var_6 <= var_2) {
          var_0 = scripts\engine\utility::array_add(var_0, var_5);
          level.ai_event.helidestroyvehiclestouchtrace[var_3] = scripts\engine\utility::array_add(level.ai_event.helidestroyvehiclestouchtrace[var_3], var_5);
          var_5.helidisabled = var_3;
          var_5.helidisapateextractvfx = var_1;
          var_5.helidrivable = var_2;
          var_7 = 2000;
          var_5._id_11E34 = [];

          foreach(var_9 in level.ai_event.select_hostage_room_three_spawners) {
            var_10 = distance2d(var_5.origin, var_9.origin);

            if(var_10 < var_7)
              var_5._id_11E34 = scripts\engine\utility::array_add(var_5._id_11E34, var_9);
          }
        }
      }
    }

    var_1 = undefined;
    var_3++;
    waitframe();
  }
}

bomb_wires_to_cut() {
  var_0 = [];
  var_1 = ["_encstr_994C023A", "_encstr_8B4C024C", "_encstr_834C02D8"];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    for(var_3 = 1; var_3 <= 5; var_3++) {
      var_4 = var_1[var_2] + scripts\engine\utility::string(var_3);
      var_0[var_4] = getEnt("_encstr_B6390CEC7B63D7CEB03916D9CAD7" + var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0[var_4]._id_12953 = var_4;
      var_0[var_4].players = [];
      level.ai_event scripts\mp\utility\trigger::makeenterexittrigger(var_0[var_4], ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5);
    }
  }

  return var_0;
}

_id_13EF3() {
  if(isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }
  self.boltsinflight = _id_13EE0(&"_encstr_A962188429FA35A705AF542B1527A2BCAB282B8AFA689EAAC98A", -1, 1.0, (1, 1, 1), 0, 50);
  self.boltunlink = _id_13EE0(&"_encstr_973E1B4A2EEE4F2D7B09B881F14DD306473FC6C5C07473E6BF616038F9", -1, 1.0, (1, 1, 1), 0, 62);
  self.boltnumber = _id_13EE0(&"_encstr_82551B09927D4D7A507D2A2B2AC94579BA0AB254AF863DA90562A81551", -1, 1.0, (1, 1, 1), 0, 50);
  self.bolt_trytopickup = _id_13EE0(&"_encstr_B4C1249DF1AF66B1969F331DED0D3110277897E5C93F3029BD914B0FCFE2719927902CEC409F", -1, 1.0, (1, 1, 1), 0, 62);
  self.bolt_watchpickup = _id_13EE0(&"_encstr_A1D825755DF12EE7C7668D5B5F75CCBA273BA115F7834BA338DFD14173C7A1D8D78F500B35D309", undefined, 1.0, (1, 1, 1), 0, 62);
  self.boltdeleteonnote = _id_13EE1();
  self.boltdeletethread = _id_13EE0(&"_encstr_AD3D242194FA9A9E28BE5465A2392ABC28A4BE15CAA8C9A87DAAE44DAA90A93494524852391D", -1, 1.2, (1, 1, 1), -300, 100);
  _id_13EF5();
  _id_13EF6(level.ai_event.current_state);
}

_id_13EF4() {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }
  foreach(var_1 in self.boardroomdoorcodeentrysuccess) {
    var_1 scripts\mp\hud_util::destroyelem();
    self.boardroomdoorcodeentrysuccess = scripts\engine\utility::array_remove(self.boardroomdoorcodeentrysuccess, var_1);
    var_1 = undefined;
  }

  self.boardroomdoorcodeentrysuccess = undefined;
}

_id_13EF5() {
  if(!isDefined(self.boardroomdoorcodeentrysuccess)) {
    return;
  }
  foreach(var_1 in self.boardroomdoorcodeentrysuccess)
  var_1 scripts\mp\hud_util::hideelem();
}

_id_13EEA(var_0) {
  foreach(var_2 in level.ai_event._id_12662)
  var_2 _id_13EF6(var_0);
}

_id_13EEC() {
  foreach(var_1 in level.ai_event._id_12662) {
    var_2 = scripts\engine\utility::ter_op(level.ai_event.initoperatorunlocks < 2, level.ai_event.new_col_map, level.ai_event.brclearscoreboardstats.size);
    var_1.bolt_trytopickup setvalue(var_2);
  }
}

_id_13EE8() {
  foreach(var_1 in level.ai_event._id_12662)
  var_1 _id_13EF3();
}

_id_13EE9() {
  foreach(var_1 in level.ai_event._id_12662)
  var_1 _id_13EF4();
}

_id_13EF6(var_0) {
  _id_13EF5();

  switch (var_0) {
    case "_encstr_8882099673858D1D4B6756":
      break;
    case "_encstr_BE4B0EBB2CB32B7D4B731BF66B5AB9CE":
      self.boltsinflight setvalue(level.ai_event.initoperatorunlocks);
      self.boltsinflight scripts\mp\hud_util::showelem();
      self.boltunlink scripts\mp\hud_util::showelem();
      break;
    case "_encstr_B6FB0CD3A84DC7E7B93EFCE94CC1":
      self.boltsinflight setvalue(level.ai_event.initoperatorunlocks);
      self.boltsinflight scripts\mp\hud_util::showelem();
      self.bolt_trytopickup setvalue(level.ai_event.new_col_map);
      self.bolt_trytopickup scripts\mp\hud_util::showelem();
      break;
    case "_encstr_840412770BB356BEC2B1E8A567ACBE139CEA8EB2":
      self.boltsinflight setvalue(level.ai_event.initoperatorunlocks);
      self.boltsinflight scripts\mp\hud_util::showelem();

      if(level.ai_event.enemy_mine_damaged_think)
        self.bolt_watchpickup scripts\mp\hud_util::showelem();
      else {
        _id_13EEC();
        self.bolt_trytopickup scripts\mp\hud_util::showelem();
      }

      break;
    case "_encstr_86350E4338DD775749A87560315123BF":
      self.boltnumber setvalue(level.ai_event.initoperatorunlocks);
      self.boltnumber scripts\mp\hud_util::showelem();
      self.boltunlink scripts\mp\hud_util::showelem();
      break;
    case "_encstr_AF9A099E17EA0831658B71":
      self.boltnumber setvalue(level.ai_event.initoperatorunlocks);
      self.boltnumber scripts\mp\hud_util::showelem();
      break;
  }
}

_id_13EDF(var_0) {
  if(!isDefined(self.boardroomdoorcodeentrysuccess))
    self.boardroomdoorcodeentrysuccess = [];

  self.boardroomdoorcodeentrysuccess = scripts\engine\utility::array_add(self.boardroomdoorcodeentrysuccess, var_0);
}

_id_13EE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6))
    var_6 = "_encstr_AF9F08DB601069806D49";

  var_7 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", var_2);
  var_8 = 40;
  var_9 = (1.0 - getdvarfloat("_encstr_B1B90BF18220754798F7C9D19B", 0)) * var_8;
  var_10 = (1.0 - getdvarfloat("_encstr_8C180BDB616CA32853516D1229", 0)) * var_8 / 2;
  var_7 scripts\mp\hud_util::setpoint(var_6, var_6, 143 + var_9, var_5 + var_10);
  var_7.color = var_3;
  var_7.label = var_0;

  if(isDefined(var_1))
    var_7 setvalue(var_1);

  var_7 scripts\mp\hud_util::setparent(level.uiparent);
  _id_13EDF(var_7);
  return var_7;
}

_id_13EE1() {
  var_0 = newclienthudelem(self);
  var_0.elemtype = "_encstr_9A6C06E43B201F1A";
  var_0.font = "_encstr_8B1608EC43B8D647A113";
  var_0.fontscale = 1.25;
  var_0.basefontscale = 1.25;
  var_0.width = 0;
  var_0.height = 10;
  var_0.x = 45;
  var_0.y = 60;
  var_0.xoffset = 0;
  var_0.yoffset = 0;
  var_0.children = [];
  var_0.hidden = 0;
  var_0 scripts\mp\hud_util::setparent(level.uiparent);
  _id_13EDF(var_0);
  return var_0;
}