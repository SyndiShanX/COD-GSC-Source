/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_br_syrk\objectives\cp_morales_objective.gsc
******************************************************************/

registermoralesobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\cp\cp_objectives::registerobjective("_encstr_A97E16A0DF904751A25EA92BC6AA58EB718B25F3CAE321D9", ::initmoralesinfilobj, ::startmoralesinfilobj, ::completemoralesinfilobj, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A", ::initmoraleshackobj, ::startmoraleshackobj, ::completemoraleshackobj, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_878215214DB3538DED4F81E0FF1339A36AF92B34E319BF", ::initmoralesrescueobj, ::startmoralesrescueobj, ::completemoralesrescueobj, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_95441678E28ADB90B75B808E29D798A37589C8B06AE46F63", ::initmoralessignalobj, ::startmoralessignalobj, ::completemoralessignalobj, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53", ::initmoralesholdoutobj, ::startmoralesholdoutobj, ::completemoralesholdoutobj, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_82C518F0AA93E730173BFFDF5CFDA0A0B302C9593113A428A156", ::initmoralesslowloadobj, ::startmoralesslowloadobj, ::completemoralesslowloadobj, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_841C18ADB7395863B2B97D33B09B47BE1BDE1619D743EC47F51B", ::initmoralesfastloadobj, ::startmoralesfastloadobj, ::completemoralesfastloadobj, undefined, ::debugmoralesobjectivesstart);
  scripts\cp\cp_interaction::registerinteraction("_encstr_9B081BB57BC95863B2E6D7B1C2C1E8F683D7A5B93ACA9C586CE896DE9B", ::hintmoraleslaptop, ::activationmoraleslaptop, ::initmoraleslaptop, 0, "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  initobjspawners();
  scripts\cp\cp_pickup_hostage::registerhvtscriptmodels();
}

waitforoneplayernearpoint(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  for(;;) {
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(distance(var_6.origin, var_0) <= var_1)
        var_3 = 1;
    }

    if(var_2) {
      if(!isDefined(level.moraleshostage))
        initmoraleshvtmodel();

      if(distance(level.moraleshostage.origin, var_0) > var_1)
        var_4 = 1;

      if(var_3 && var_4) {
        break;
      }
    } else if(var_3) {
      break;
    }

    wait 0.5;
  }
}

waitforallplayersnearpoint(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  while(!var_3) {
    var_3 = 1;

    foreach(var_5 in level.players) {
      if(distance(var_5.origin, var_0) > var_1) {
        var_3 = 0;
        continue;
      }
    }

    if(var_2) {
      if(distance(level.moraleshostage.origin, var_0) > var_1)
        var_3 = 0;
    }

    wait 0.5;
  }
}

waitformoralesdropnearpoint(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 waittill("_encstr_88C60846397B83835919");

    if(scripts\engine\utility::distance_2d_squared(var_1.origin, var_0) <= var_2 * var_2)
      return 1;

    waitframe();
  }
}

initmoraleshvtmodel(var_0) {
  if(!isDefined(var_0))
    var_0 = scripts\engine\utility::getStruct("_encstr_979813D56728E67375A3215A2BD587DD13F55523B9", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  level.moraleshostage = scripts\cp\cp_pickup_hostage::initdefaulthvtmodel(var_0, "_encstr_A1292AE80AE7F3EEB76024A85ABF91F74D9273A0623D0743778A369032FF1B7979DF1118DA15B57E6385BE15", "_encstr_849412E248A3472799FD252101815F8ECF01EFCF", &"_encstr_8B9923D005D79094D7A6954A5AEBF42125510D514A652A4D97145268D2EB9A3D941462159A", "_encstr_B4E2158C93DE83F5B6DE93581BB2CDFA1ADECD1D859DCA");
}

initmoraleslaptop(var_0) {
  if(var_0.size > 0) {
    level.morales_laptop_int_struct = var_0[0];
    level.morales_laptop_int_struct.laptopactive = 0;

    if(isDefined(level.objectivestabledata["_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A"]))
      level.morales_laptop_int_struct.objectivestruct = level.objectivestabledata["_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A"];
  }
}

hintmoraleslaptop(var_0, var_1) {
  if(istrue(level.morales_laptop_int_struct.laptopactive))
    return &"_encstr_BD1B10FB19416A97EEE4B1C86C78DB5609B7";
  else
    return "_encstr_B40101";
}

initmoralessignal(var_0) {
  if(var_0.size > 0) {
    level.morales_signal_struct = var_0[0];
    level.morales_signal_struct.available = 0;
  }
}

hintmoralessignal(var_0, var_1) {
  if(istrue(level.morales_signal_struct.available))
    return &"_encstr_8E95213ED8707E8717A1A315BC792C7365C8CECFC8BBB79F90E73F9F67C9E7F1F1CE14";
  else
    return "_encstr_B40101";
}

activationmoralessignal(var_0, var_1) {
  if(!istrue(level.morales_signal_struct.available)) {
    return;
  }
  level notify("_encstr_AD0219DA7B93858DACDCD7B9D29DE6851B7D2C1B47A5672CD15691");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level.morales_signal_struct.available = 0;
}

activationmoraleslaptop(var_0, var_1) {
  if(!istrue(level.morales_laptop_int_struct.laptopactive)) {
    return;
  }
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.objectivestruct notify("_encstr_99CD1DDBA060C2AB5668EE30D057D857D889600BAA787FD319DAA1731BB783", var_0);
  scripts\cp\cp_objective_mechanics::starthackingdefense(var_0.objectivestruct, scripts\engine\utility::getStruct("_encstr_841817ED31354CFA242B51AF340B36D6D7D8F6D858A3D2F6E6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin + (0, 150, 50), 120, "_encstr_9642192A25DD194099CBC1FD29826B70BB7F0B403360DEC3D8DDF8");
}

initobjspawners() {
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_A97E16A0DF904751A25EA92BC6AA58EB718B25F3CAE321D9", 6, 8, 8, 0.5, undefined, "_encstr_93CC0DC3778A18399F331618CA4B4F", undefined, undefined, undefined);
  [[var_0]]("_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A", 8, 12, 200, [::waitbetweenspawnwaveswithtimeout, 0.1, 15], undefined, "_encstr_91CC0D7045F51A8A58BE2F887575AF", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_B8CB17A7CF361A64289321724940B39305173B5391C8671F21", 3, 3, 6, 0.05, undefined, "_encstr_95700F4B2FB327F8C57A465826A24A70F8", undefined, undefined, undefined);
  [[var_0]]("_encstr_ACCB17DAF64E0BC6B2CDD727596EC6ABB2F543ECE8D7CC7D48", 3, 3, 6, 0.05, undefined, "_encstr_B4700F80C8BEB303472BEF785B2AB26E1B", undefined, undefined, undefined);
  [[var_0]]("_encstr_91CB175BED392C63ACE6D739B26E8DD5AC7DA19D8EEB66BE34", 3, 3, 6, 0.05, undefined, "_encstr_B6700FADDE4EC2B1AC6E7DB789A6CCEBA1", undefined, undefined, undefined);
  [[var_0]]("_encstr_8FCB17B6BDE416C6CAE6F593AC9BD8EAACF53467E8F5CCFA22", 3, 3, 6, 0.05, undefined, "_encstr_A6700FD1BD43A3D03D9FB138B35A43A748", undefined, undefined, undefined);
  [[var_0]]("_encstr_95441678E28ADB90B75B808E29D798A37589C8B06AE46F63", 6, 10, 10, 0.05, undefined, "_encstr_B8CC0DD09F75E7E92FDB07EDF21B25", undefined, undefined, undefined);
  [[var_0]]("_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B", 2, 7, 7, [::waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "_encstr_83501071927B6934B54FF192DDA04B59EB54", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149", 2, 7, 7, [::waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "_encstr_8A50101065B2C8F19A1F673F635265F14BF3", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9", 2, 7, 7, [::waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "_encstr_A3501099F50BEBA845D7E9708B924B5FE197", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A", 2, 7, 7, [::waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "_encstr_974B1792A87ECF5578BF3F07B528CBEF2863EAEBB35D978AB0", ::watchforstopwaves, ::getnextholdoutspawnmodule, undefined);
  [[var_0]]("_encstr_8BBC1A995FFB19E16773B110AA7DB9905FEC082D97D3EDDB8E7AD0C0", 1, 2, 200, ::waitbetweenbomberwaves, undefined, "_encstr_A24814B398964FC03B97FE78BB7033806EB007B1D8CB", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_82C518F0AA93E730173BFFDF5CFDA0A0B302C9593113A428A156", 5, 18, 200, [::waitbetweenspawnwaves, 0.1, 0.1], undefined, "_encstr_AD8D13A57AC0EEDC2D8719A0A15F03BF73A3C0D7AA", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_841C18ADB7395863B2B97D33B09B47BE1BDE1619D743EC47F51B", 5, 18, 200, [::waitbetweenspawnwaves, 0.1, 0.1], undefined, "_encstr_9B4912772FA87F75685AA95FC6F3E21FFD331090", ::watchforstopwaves, undefined, undefined);
}

waitbetweenspawnwaves(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount <= var_0.max_size && var_0.activecount)
      wait 0.1;

    wait 1;
  }

  if(var_0.activecount <= var_0.min_size)
    return var_1;
  else
    return var_2;
}

waitbetweenspawnwaveswithtimeout(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = gettime();
  var_5 = var_4 + var_2 * 1000;

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount <= var_0.max_size && var_0.activecount && gettime() <= var_5)
      wait 0.1;

    wait 1;
  }

  return var_1;
}

waitbetweenbomberwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53");

  if(!isDefined(var_1.currentteam)) {
    return;
  }
  while(are_all_players_on_watchtower(var_1.currentteam))
    wait 2;

  return randomint(10) + 5;
}

are_all_players_on_watchtower(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_953313E8DEDD959C89EBAE8338CA39AF8DCAEC561B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(var_1))
    return 0;

  var_2 = scripts\cp\utility::getplayersinteam(var_0);
  var_3 = 1;

  foreach(var_5 in var_2) {
    if(distance(var_5.origin, var_1.origin) > 300) {
      var_3 = 0;
      break;
    }
  }

  return var_3;
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);

  if(var_0.group_name == "_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A")
    level thread watchforoverseerskilled(var_0);
  else if(issubstr(var_0.group_name, "_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53"))
    level thread swapcoverselector(var_0);
}

swapcoverselector(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");

  for(;;) {
    if(!isDefined(var_0.ai_spawned)) {
      wait 3;
      continue;
    }

    foreach(var_2 in var_0.ai_spawned) {
      if(!istrue(var_2.swappedcoverselector)) {
        var_2.defaultcoverselector = "_encstr_958A118DDBECB29C7DDCD0EDA3B3D5B9B92B9C";
        var_2.swappedcoverselector = 1;
      }
    }

    wait 1;
  }
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\engine\utility::_id_143A7("_encstr_9642192A25DD194099CBC1FD29826B70BB7F0B403360DEC3D8DDF8", "_encstr_A94819D67B9CB0B12BB9BE86BDD846F6BA1DEBCC2D734B9B862BC8", "_encstr_B67E107A409637AD902797B529D0B44BB599", "_encstr_AA8120557F53BBFDDFD0874B25BDE2B775C0BCF310573447E9EA73E3775187E88635");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

watchforoverseerskilled(var_0) {
  level endon("_encstr_93671AB6B793B03659DC7D0DB7D891BD5747AF1B7BDA07C6ACE8B28C");
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");

  while(var_0.currentmodulekills < 10)
    wait 0.5;

  if(isDefined(level.objectivestabledata["_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53"]))
    level.objectivestabledata["_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53"].earnedfastexfil = 1;
}

blockedwaittillgrouptimerdone(var_0) {
  wait 5;
}

getnextholdoutspawnmodule(var_0) {
  if(!istrue(level.inmoralesholdout))
    return undefined;

  for(var_1 = 0; var_0.activecount > 3 && var_1 <= 10; var_1++)
    wait 1;

  var_2 = undefined;

  switch (var_0.group_name) {
    case "_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B":
      if(!areplayersnearspawnarea("_encstr_827E1BA0FAC3B760A78B4F398FCDE80867E37EEB73E7F4487F6247479F"))
        var_2 = "_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149";
      else if(!areplayersnearspawnarea("_encstr_B17E1B90478AD929BA3A70E315027140D54379E8A331D3F542624866E7"))
        var_2 = "_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9";
      else
        var_2 = "_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B";

      break;
    case "_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149":
      if(!areplayersnearspawnarea("_encstr_B17E1B90478AD929BA3A70E315027140D54379E8A331D3F542624866E7"))
        var_2 = "_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9";
      else if(!areplayersnearspawnarea("_encstr_847E1B25C86592E42108E703D038A43A33DD21DA2FEB4B3EC9E8EF9379"))
        var_2 = "_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B";
      else
        var_2 = "_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149";

      break;
    case "_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9":
      var_2 = "_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A";
      break;
    case "_encstr_9AB415B6F6E485B1CA9BEBD07B1B46DED53AFA6AAF7A9A":
      if(!areplayersnearspawnarea("_encstr_847E1B25C86592E42108E703D038A43A33DD21DA2FEB4B3EC9E8EF9379"))
        var_2 = "_encstr_8AB415F5B82A1909A58A91B4502C4ABAC54159CB499D6B";
      else if(!areplayersnearspawnarea("_encstr_827E1BA0FAC3B760A78B4F398FCDE80867E37EEB73E7F4487F6247479F"))
        var_2 = "_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149";
      else
        var_2 = "_encstr_86B415681DBAC0F982175F394F3A35685533D6EB8923A9";

      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

areplayersnearspawnarea(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(var_1))
    return 0;

  var_2 = 300;

  foreach(var_4 in level.players) {
    if(scripts\engine\utility::distance_2d_squared(var_4.origin, var_1.origin) <= var_2 * var_2)
      return 1;
  }

  return 0;
}

playsmokeflarevisualmarker(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_1 = var_1 + (0, 0, 1);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3 setModel("_encstr_B231139B17092E334F8B5AE1B097FBE460BD371569");
  var_3 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9", 0);
  thread watchfordeletesmokeflarevisualmarker(var_2, var_3);
  wait 20;
  self notify("_encstr_8ED81187F3AF0BCF77BD30E047191C81D84A07");
}

watchfordeletesmokeflarevisualmarker(var_0, var_1) {
  self waittill("_encstr_8ED81187F3AF0BCF77BD30E047191C81D84A07");
  var_0 delete();
  var_1 delete();
}

debugmoralesobjectivesstart(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_96F31821F753B179FF9B4998925633098F7335AF4293BEB1A5A2");
}

glstopmoralesquest() {
  var_0 = ["_encstr_A97E16A0DF904751A25EA92BC6AA58EB718B25F3CAE321D9", "_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A", "_encstr_878215214DB3538DED4F81E0FF1339A36AF92B34E319BF", "_encstr_95441678E28ADB90B75B808E29D798A37589C8B06AE46F63", "_encstr_8AAC12D67B272C36CAE6EBD07BB119BDEA1D7D53", "_encstr_82C518F0AA93E730173BFFDF5CFDA0A0B302C9593113A428A156", "_encstr_841C18ADB7395863B2B97D33B09B47BE1BDE1619D743EC47F51B"];

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_objectives::getobjectivestructfromref(var_2);
    scripts\cp\cp_objectives::overridenextstep(var_3, undefined);
  }

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8E3C1D46F0D71B1CB9BEDE3BD87D8C9536A5CD4BDBE6EB1C5A36B7D1D79803", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_9AC0241A05BE0992BE35659269F53AC47D229450C4E97455A25E353D291426A835AFA6A2E9A0");
  level.savedmorales = 0;
  level notify("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
}

glstarthelidownevent() {
  scripts\cp\cp_objectives_events::try_start_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB", "_encstr_81383D635FA3893F41930F5019B7D090CB9B254AE21EB862EF82BB3A980E9F4A2FF1F2AF97E8106DC9AA517D170E3BF82B20BAF7D50B4F3BBB237EA0365FC6", 1);
}

glstophelidownevent() {
  scripts\cp\cp_objectives_events::stop_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
  scripts\cp\cp_objectives_events::disable_repeating_event("_encstr_84FD1A1FB5202FF745A8EBC2769327A580678C97E768F98F6D41A3DB");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B8521BBAF2508F1A90AF7756F1C927DFE64843127890C7D4502B4F1921", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_BEAE228F016ECAA92F3EC8320A07B09C36C9DF0F79C40701E3E882FCE17FB9475FF14FD3");
  level.savedmorales = 1;

  if(isDefined(level.escort_vip)) {
    level.escort_vip setCanDamage(1);
    level.escort_vip dodamage(level.escort_vip.health + 100, level.escort_vip.origin);
  }

  level notify("_encstr_8DB01DF631A6AC6CD12DCEB2FA34591B2DBE91BDEE9BFAB6B41B8DBE86EC8E");
  level notify("_encstr_A9ED14D2BD5AF317D8F7C1E3CCDFB028E6612609F529");
}

waittostarthelidown() {
  wait 5;
  level thread _encstr_951A3BF0FBF028202BDFA24F6BCEFD436FC8E548B08FF6EBAF1F83AB7767D7CB87F052B1DF1B06C259BF301A52B303431317D61BA7AD545F0B2AA75FD7::convoy_go_to_helidown_location();
  glstarthelidownevent();
  level waittill("_encstr_A3AC0E689D58D2870256B720A28B8AA7");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A2D51EA7837FF2B8A329673B881E645ADF93EA1CE0B589E5AB98573B28F60957", "_encstr_9A8507BA4040188D08");
  wait 2;
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A65221BF68E121065711365FB87F548909945333EC5D41CD47CE2CA530FF1081553FD5");
  wait 1;
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_855B230D417D844AD74D954AA57D8E26F588528213D31D55A8E524A88925F588E9EA39AF4C");
  wait 1;
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AA5B23D3A76683123FE1E14939E79F73DE055149D10CCFEB23EAF83029A3C1EB3414EEDF46");
  wait 3;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_851529A08FA12ABF91BF8B5B3C972D2DE0395819FDBFB0C93FAFD9011721CFFF895D4DF84791ED47A8B059", "_encstr_9A8507BA4040188D08", 5);
}

initmoralesinfilobj(var_0, var_1) {}

threadedbcloop() {}

startmoralesinfilobj(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  level thread _encstr_951A3BF0FBF028202BDFA24F6BCEFD436FC8E548B08FF6EBAF1F83AB7767D7CB87F052B1DF1B06C259BF301A52B303431317D61BA7AD545F0B2AA75FD7::spawn_convoy_and_drive();

  if(getdvarint("_encstr_9B5510E6B139F5D8DBB9D9BDF2AF27ED586B", 0) != 0) {
    glstopmoralesquest();
    return;
  }

  level notify("_encstr_BE7812F2A35058D1A6DB8B9FD140BB93F82E2B7D");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_88BB20FCBAE97F17508610F399762BAD57FA85B7A7C9FDE4D8607313AA459A0FEFD9", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_837021C5AB39B15D80D7D341B2E707B93130D4DE41AF37CFD770250F85C9F4DD0FFEDF");
  wait 2;
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_9B7021D028F54825AF3565922DAF8EC4AF44291489A7D1558ABC359E9405C4544DEB91");
  level thread waittostarthelidown();
  waitforoneplayernearpoint(var_0.iconpos[0], 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A97E16A0DF904751A25EA92BC6AA58EB718B25F3CAE321D9");
  waitforoneplayernearpoint(var_0.iconpos[0], 500, 0);
  level thread glstophelidownevent();
  wait 2;
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_9970214D39319A69DFA1098D29B6C5E14759F1F9BCCF576F3B6E74BFB1DBA96FB62FAA");
  wait 2;
}

changetomorales2() {
  scripts\cp\cp_objectives::update_objective(self.ref, "_encstr_AF5A081BBAC993AC73A3", (0, 0, 0), "_encstr_ABF7206841FA21A4FA3565495ABEF48494156815949551A95E6A9E4A0A312A6AAF91", "_encstr_820213DF77C9FF73A440BEDD34EB9D2737A1EF9BE7", 2, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9", 1, 1, 1);
}

changetomorales3() {
  scripts\cp\cp_objectives::update_objective(self.ref, "_encstr_AF5A081BBAC993AC73A3", (4000, 0, 0), &"_encstr_A7F7201A28BE094AEB6A5625D2D73D2425541AA8522B2AA6F29A9E94A0988A4DAFCC", &"_encstr_A265232E09216DA937B7D992B2E718918A65A7E1DB15659AE0192BB839411D6FC229B13FAA", 3, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9", 1, 1, 1);
}

completemoralesinfilobj(var_0) {}

initmoraleshackobj(var_0, var_1) {
  if(isDefined(level.morales_laptop_int_struct))
    level.morales_laptop_int_struct.laptopactive = 1;
}

startmoraleshackobj(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B16B20D9F3E1A69853F1C0FB2517C0ED5BF76353D73AF4A8A71509334B1F0808D722", "_encstr_9A8507BA4040188D08");
  thread nag_player_for_laptop(var_0);
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_AB7021BF173E2D865921DB7377D9C7398130EBA129F8DFB7EFBE753CB1A97049E9A739");
  var_0 waittill("_encstr_99CD1DDBA060C2AB5668EE30D057D857D889600BAA787FD319DAA1731BB783");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B1DD16BFD73E126CD09B39FCF1C8A34999635353AF67B90A");
  var_0 waittill("_encstr_9642192A25DD194099CBC1FD29826B70BB7F0B403360DEC3D8DDF8");
  level notify("_encstr_9642192A25DD194099CBC1FD29826B70BB7F0B403360DEC3D8DDF8");
  wait 2;
}

completemoraleshackobj(var_0) {}

nag_player_for_laptop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_99CD1DDBA060C2AB5668EE30D057D857D889600BAA787FD319DAA1731BB783");

  for(;;) {
    wait 30;
    thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BD6B202D585F49C9F2C140F08A8185C1B7EB2D15E76B1323D1DA38C823A5795E1AC0", "_encstr_9A8507BA4040188D08");
  }
}

initmoralesrescueobj(var_0, var_1) {
  var_2 = randomint(2);
  var_3 = undefined;

  switch (var_2) {
    case 0:
    default:
      var_3 = "_encstr_994C0238";
      break;
    case 1:
      var_3 = "_encstr_8B4C0248";
      break;
  }

  var_4 = scripts\engine\utility::getStructArray("_encstr_B4D410B6F64EB036CA6EFA43B3D1EBB17BC6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(var_7.targetname == var_3) {
      var_5 = var_7;
      break;
    }
  }

  var_0.spawngroup = var_3;
  initmoraleshvtmodel(var_5.origin);
  objective_onentity(var_0.objectiveindex, level.moraleshostage);
}

startmoralesrescueobj(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_976B206D181F0989B2817B304A41450177AB6D55A7ABD3E3919A7808E365391EDE30", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A770211A14F52129AF35CA49B4F51D31F511251498F48E558ABCD4A7258289A86AFA9A");
  waitforoneplayernearpoint(level.moraleshostage.origin, 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_87861630AAC2A3E8FF03D846ED5FF143EF319050B3D17FC6" + var_0.spawngroup);
  level waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_2);
  var_2 thread scripts\cp\cp_vo::try_to_play_vo("_encstr_A1F12019C37D36C137EB193935B5FA27B237D857CAD7A1D9D2FA66B7EA9B91F54618", "_encstr_99140ED629C9C62FA399EFB01B5F748F");
  wait(scripts\cp\cp_vo::get_sound_length("_encstr_A1F12019C37D36C137EB193935B5FA27B237D857CAD7A1D9D2FA66B7EA9B91F54618"));
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AA301FE350914F4078F977139027FB89CB63E5824FB053D2F1847BF308BD78D2BF", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A170216337F61382AF9191D9A9570FE32E95E1D9A19C7F1BB35AD8F44943B59F07E006");
}

completemoralesrescueobj(var_0) {}

initmoralessignalobj(var_0, var_1) {
  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel((-1962.19, -8728.35, 300.997));

  var_0.customwaypointid = scripts\cp\cp_objectives::requestworldid("_encstr_AF6511B2885EEF75589FDFFB43A03D3789269F", 15);
  var_2 = scripts\engine\utility::getStruct("_encstr_8D5A16F64C9A98EB246515FA32ACCCCA9B91FA8E7B772B93", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  objective_setplayintro(var_0.customwaypointid, 1);
  objective_setplayoutro(var_0.customwaypointid, 1);
  objective_state(var_0.customwaypointid, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_0.customwaypointid, var_2.origin);
  objective_setdescription(var_0.customwaypointid, &"_encstr_91F720A1417D1229F59A659269FAD321A4A8A145292B2AA6E59A9E9482628A6AD71A");
  objective_setlabel(var_0.customwaypointid, &"_encstr_A11323860AAF844AAF4DCA495AAF7A9029A81AA825B25435CB22293D82F524F4D41505A3A2");
  objective_icon(var_0.customwaypointid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setbackground(var_0.customwaypointid, 1);
}

startmoralessignalobj(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_95441678E28ADB90B75B808E29D798A37589C8B06AE46F63");
  var_2 = scripts\engine\utility::getStruct("_encstr_8D5A16F64C9A98EB246515FA32ACCCCA9B91FA8E7B772B93", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  waitformoralesdropnearpoint(var_2.origin, level.moraleshostage, 300);

  if(isDefined(level.moraleshostage))
    level.moraleshostage scripts\cp\cp_pickup_hostage::togglehvtusable(0);

  var_3 = scripts\engine\utility::getStruct("_encstr_93E016E50E95571744E10B1FF058E76A5B91619FEB256A7C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  objective_state(var_0.customwaypointid, "_encstr_8267056410C669");
  wait 1;
  objective_position(var_0.customwaypointid, var_3.origin);
  objective_state(var_0.customwaypointid, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlabel(var_0.customwaypointid, &"_encstr_AB1C23AB49117EBB589791297CB017A611DB23241321F7F7588F6860E4E753A9B1099EB181");

  if(isDefined(level.morales_signal_struct))
    level.morales_signal_struct.available = 1;

  level waittill("_encstr_AD0219DA7B93858DACDCD7B9D29DE6851B7D2C1B47A5672CD15691");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A7272046F0BEB10E37EBF6EC8D7D9C566E36AE56AF1A9DB4BE912B995973C8AF1303", "_encstr_9A8507BA4040188D08");
  var_4 = scripts\engine\utility::getStruct("_encstr_8255158D0BB9A59B1D9593AF838D161B2B437BC632CAC9", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_4))
    level thread playsmokeflarevisualmarker(var_4.origin);

  level notify("_encstr_AAF22DA7382770D5EFB5F845C020E167E15838392397EB1FC8B747D2CE71D9F3D8F0BCBF3DA768A0271FC032EB3503");
  objective_delete(var_0.customwaypointid);
  scripts\cp\cp_objectives::freeworldid("_encstr_AF6511B2885EEF75589FDFFB43A03D3789269F");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_9370218641AF2429BE35564A69D71D98AF229450893D1DAA8ACBD4F4921431A29AD7DC");
  wait 1;
}

completemoralessignalobj(var_0) {}

initmoralesholdoutobj(var_0, var_1) {
  var_0.earnedfastexfil = 0;
}

startmoralesholdoutobj(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  level.inmoralesholdout = 1;
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B2B415087A2E565D350BB92C2FB84F1D654B218B89D149");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8BBC1A995FFB19E16773B110AA7DB9905FEC082D97D3EDDB8E7AD0C0");
  level thread moralesholdoutmagicgrenadewatcher(var_0);

  if(1)
    wait 60;

  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A37021860ABE8429AF6AAC29B4FAA3C4F522520A13D3A3AA517935A74A143154D4F5C1");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_92F9262008495EE00E48F2B3E9B196F07FEEA328C79CC62D8694BBE07703CDCF838FC35F369E7A71", "_encstr_9A8507BA4040188D08");
  wait 30;
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_8F70218641BE12A4EB4D65492DBE8E26EB1125A0C4D3D1AA15BC9A7A4A501354A6D79C");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B87B2651AB9FD6DBBB3067EE98F84B0B9F673B5A066B537929747A9EE1628559EB21C24BF2C96E73", "_encstr_9A8507BA4040188D08");
  wait 30;
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B2F923D741618A5BA39FF70B98EF63BD0FEBC320F752F3233F363DD3BAC8F97342F2863EFF", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_B4E3226882BE1225AFA6CA94D2AF1D62D7882550313D8EAAA2CB9AA79282C4516AD79813");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_82C518F0AA93E730173BFFDF5CFDA0A0B302C9593113A428A156");
  level.inmoralesholdout = undefined;

  if(isDefined(level.moraleshostage))
    level.moraleshostage scripts\cp\cp_pickup_hostage::togglehvtusable(1);

  level notify("_encstr_A94819D67B9CB0B12BB9BE86BDD846F6BA1DEBCC2D734B9B862BC8");
}

completemoralesholdoutobj(var_0) {
  level notify("_encstr_93671AB6B793B03659DC7D0DB7D891BD5747AF1B7BDA07C6ACE8B28C");
}

moralesholdoutmagicgrenadewatcher(var_0) {
  level endon("_encstr_93671AB6B793B03659DC7D0DB7D891BD5747AF1B7BDA07C6ACE8B28C");
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::getStruct("_encstr_953313E8DEDD959C89EBAE8338CA39AF8DCAEC561B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = scripts\engine\utility::getStruct("_encstr_8212168EEDEEB2C998D7EC3995E6588C59FABDC9D2CEB437", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  for(;;) {
    var_3 = scripts\cp\utility::getplayersinteam(var_0.currentteam);

    foreach(var_5 in var_3) {
      if(distance(var_5.origin, var_1.origin) <= 300)
        magicgrenademanual("_encstr_8A78055C8D488C", var_2.origin, var_5.origin);
    }

    wait(randomfloat(10) + 5);
  }
}

initmoralesslowloadobj(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("_encstr_BD17144B985A7965AF4BE64B50CD305FC845AD63AF98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_BEE91D87487B59FA8BFE994FEDAD23E766D8736B31B39CF2F7809A42C77F4A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_0.exfilstruct = var_2;

  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel(var_3.origin);
}

startmoralesslowloadobj(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_B1E3221A0AAF8425FAA965A4A5BEA3C4D7889450987A3AAA54BCD4A7290526A84DEB4C46");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_82C518F0AA93E730173BFFDF5CFDA0A0B302C9593113A428A156");
  thread exfil_morales(level.moraleshostage, var_0);
  level waittill("_encstr_B67E107A409637AD902797B529D0B44BB599");

  foreach(var_3 in level.players)
  var_3 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_8BB90A8813BC2E27AA2B1D95");

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A5DB1F461ED7361C9BAFBDB3B1D74EACB91BBA95BE86D996BE2B0F33B4D8BE4C06", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A2E3227DA16F1981273980D97C574CF529E37939D511B8A5210FD8E44B10637F77D763C7");
  wait(scripts\cp\cp_vo::get_sound_length("_encstr_A5DB1F461ED7361C9BAFBDB3B1D74EACB91BBA95BE86D996BE2B0F33B4D8BE4C06"));
}

completemoralesslowloadobj(var_0) {}

initmoralesfastloadobj(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("_encstr_A1171DDAED39C28DB2CDFA912B31ABD97D0DB3E87D3316371DFAB9C10B7737", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_3 = scripts\engine\utility::getStruct("_encstr_99A514B5B7E4B0D856DCAFCCB09BD17D3495B1D27D12", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.exfilstruct = var_3;

  if(!isDefined(level.moraleshostage))
    initmoraleshvtmodel(scripts\engine\utility::drop_to_ground(var_2.origin));
}

startmoralesfastloadobj(var_0, var_1) {
  level endon("_encstr_815C1C5F6B4A8739A5159BF1FD9560A892FBD9FFEF4242A0C3ABE02BA76B");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_841C18ADB7395863B2B97D33B09B47BE1BDE1619D743EC47F51B");
  thread exfil_morales(level.moraleshostage, var_0);
  level waittill("_encstr_B67E107A409637AD902797B529D0B44BB599");

  foreach(var_3 in level.players)
  var_3 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_8BB90A8813BC2E27AA2B1D95");

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A5DB1F461ED7361C9BAFBDB3B1D74EACB91BBA95BE86D996BE2B0F33B4D8BE4C06", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A2E3227DA16F1981273980D97C574CF529E37939D511B8A5210FD8E44B10637F77D763C7");
  wait(scripts\cp\cp_vo::get_sound_length("_encstr_A5DB1F461ED7361C9BAFBDB3B1D74EACB91BBA95BE86D996BE2B0F33B4D8BE4C06"));
}

completemoralesfastloadobj(var_0) {}

exfil_morales(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_992C09B5C322C558EFDB03");

  if(!isDefined(var_1.exfilstruct))
    var_1.exfilstruct = scripts\engine\utility::getStruct("_encstr_99A514B5B7E4B0D856DCAFCCB09BD17D3495B1D27D12", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_2 = var_1.exfilstruct;
  objective_setlabel(var_1.objectiveindex, "_encstr_8D5C24340AD7214AAF355692A5EBE98492151A8A4A652A9AF254B0329413BEA9E99405628AA9");
  objective_setshowprogress(var_1.objectiveindex, 0);
  objective_icon(var_1.objectiveindex, "_encstr_8FEC166198B7CB394FEB2798CD97BAEB1110B0BC7237A031");
  objective_position(var_1.objectiveindex, var_2.origin + (0, 0, -100));
  var_3 = spawn_evac_chopper(var_2);
  var_3.godmode = 1;
  var_3.health = 10000;
  var_3.maxhealth = 10000;
  vehicle_anims();
  var_3 script_model_anims();
  scripts\cp\cp_pickup_hostage::init_anims();
  var_3 _encstr_B1113D37D84ED2833AB9796CC179B5851CB9BC8D83EB9839BE37CB9C6DCBC638D72627EB3797E4DAF57B2635CAB11DA5B3CABE86AC1B2D23DEBBCD8B76E6D8::spawnhelihvtexfilactors();
  var_3 thread leave_if_vip_dies(var_0, var_1);
  thread start_nag_for_morales_exfil(var_1);

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(!var_6 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(!isDefined(var_6.hostagecarried)) {
        continue;
      }
      if(distancesquared(var_6.origin, var_3.exfil_struct.origin) < 6250000)
        var_4 = 1;
    }

    if(var_4) {
      break;
    }

    wait 1;
  }

  var_1 notify("_encstr_9A2218B9D1B707FAADB7C92CC62B9B7DCA3C995A1BEB730B3BE6");
  thread defend_while_chopper_arrives(var_1);
  var_1 waittill("_encstr_A9710C79AF9ED0C84277D9C79B7A");
  level notify("_encstr_9AD60EF02518379757389A8148BFCDDF");
  var_3 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var_3.exfil_struct, 1);
  var_8 = anglesToForward(var_3.angles);
  var_9 = anglestoleft(var_3.angles);
  var_10 = var_3.origin;
  var_11 = var_10 + var_8 * 10 + var_9 * 64 + (0, 0, -110);
  objective_position(var_1.objectiveindex, var_11);
  objective_setlabel(var_1.objectiveindex, "_encstr_8D5C24340AD7214AAF355692A5EBE98492151A8A4A652A9AF254B0329413BEA9E99405628AA9");
  var_12 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_11 + (0, 0, -200), 0, 64, 500);

  for(;;) {
    var_12 waittill("_encstr_8F5C086405E70FBA4B4A", var_6);

    if(!var_6 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!isDefined(var_6.hostagecarried)) {
      continue;
    }
    var_13 = var_6.hostagecarried;
    var_13 notify("_encstr_A51E14CFB380E328D82063F7179A1DA30F8B93C8AACD");
    scripts\cp\cp_pickup_hostage::load_hvt(var_6, var_3);
    wait 1;
    break;
  }

  level thread evac_hvt(var_3, var_0);
}

start_nag_for_morales_exfil(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_9A2218B9D1B707FAADB7C92CC62B9B7DCA3C995A1BEB730B3BE6");

  for(;;) {
    wait 30;
    thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B6C0235773EF62283399D7AB186EE2CA4F069B8F48296B49DE6083E3D8209702C3ACE91267", "_encstr_9A8507BA4040188D08");
  }
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");

spawn_evac_chopper(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(scripts\engine\utility::getStruct("_encstr_8A1A0DABC86BF837D338F5F04C58DB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_1.vehicle_skipdeathmodel = 1;
  var_1.script_disconnectpaths = 0;
  var_1.death_fx_on_self = 1;
  var_1.exfil_struct = var_0;
  var_1 vehicleplayanim(%_encstr_BEEC15FD7F38492B918062AA2EFD673D60E74F4FD168CD);
  var_0.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_0.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_1);
  var_1 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  return var_1;
}

#using_animtree("_encstr_B40101");

vehicle_anims() {
  level.scr_animtree["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"] = #animtree;
}

evac_hvt(var_0, var_1) {
  var_0 vehicle_setspeed(5, 10);
  var_0 cleartargetyaw();
  var_0 setvehgoalpos(var_0.origin + (0, 0, 800), 1);
  wait 4;
  level notify("_encstr_B67E107A409637AD902797B529D0B44BB599");
  wait 4;
  var_0 vehicle_setspeed(90, 10);
  var_0 setvehgoalpos(var_0.origin + (10000, 10000, 500));
  wait 20;

  if(isDefined(var_1))
    var_1 scripts\cp\cp_pickup_hostage::deletepickuphostage();

  if(isDefined(var_0.minigun))
    var_0.minigun delete();

  if(isDefined(var_0.vmhvt)) {
    if(isDefined(var_0.vmhvt.head))
      var_0.vmhvt.head delete();

    var_0.vmhvt delete();
  }

  if(isDefined(var_0.vmexfilally)) {
    if(isDefined(var_0.vmexfilally.head))
      var_0.vmexfilally.head delete();

    var_0.vmexfilally delete();
  }

  var_0 delete();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_95A70A376069C16A0F04E398"] = #animtree;
  level.scr_anim["_encstr_95A70A376069C16A0F04E398"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = % _encstr_8BB81CD00B976931DAEC990806525BD0111F10F0E37F803511D28E2B5E3A;
  level.scr_animname["_encstr_95A70A376069C16A0F04E398"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = "_encstr_8BB81CD00B976931DAEC990806525BD0111F10F0E37F803511D28E2B5E3A";
  level.scr_anim["_encstr_95A70A376069C16A0F04E398"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = % _encstr_8F3F21CE5BC67A4B10837C8F5BD528A3EBF0ABF3754FB18DEF1ADEBAD30D78E40B9C3D;
  level.scr_animname["_encstr_95A70A376069C16A0F04E398"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = "_encstr_8F3F21CE5BC67A4B10837C8F5BD528A3EBF0ABF3754FB18DEF1ADEBAD30D78E40B9C3D";
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = % _encstr_B22D1A3823F1E322AB5109E832EB48AB2679D818FB19393977480C75;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = "_encstr_B22D1A3823F1E322AB5109E832EB48AB2679D818FB19393977480C75";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = % _encstr_88D81FD8039F1149D2F491300E4A53D809270888FB47883D29DC94ADA9F281A075;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = "_encstr_88D81FD8039F1149D2F491300E4A53D809270888FB47883D29DC94ADA9F281A075";
  level.scr_animtree["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"] = #animtree;
  level.scr_anim["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = % _encstr_8D2425CDC8C9AFC6E0F5A1BDE6E82CD9CAEBC8E47B07F66633BE4CC65AB616AFC6AF1336B46B85;
  level.scr_animname["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_B2D10D8DB84A58F9504C35D8EB29B4"] = "_encstr_8D2425CDC8C9AFC6E0F5A1BDE6E82CD9CAEBC8E47B07F66633BE4CC65AB616AFC4AF1336B46B85";
  level.scr_anim["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = % _encstr_82192596370B974950675070CF8CC12F8211859E4D83AF912E4F08604FBD99275B890E29A40A7B;
  level.scr_animname["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"]["_encstr_ACD10D136396B62CD7324EF607FA93"] = "_encstr_82192596370B974950675070CF8CC12F8211859E4D83AF912E4F08604FBD992759890E29A40A7B";
}

spawnactors() {
  if(!isDefined(self.exfil_helpers))
    self.exfil_helpers = [];

  self.exfil_helpers[self.exfil_helpers.size] = spawn_anim_model("_encstr_95A70A376069C16A0F04E398", "_encstr_9AD01136187923E791B06F67D06B9509DD203B", "_encstr_BDD61A99ABB163C4BD23E5F5A12B4EBDBE0EC95A36B2BED5274C2CE6");
}

spawn_anim_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_4 setModel(var_2);

  if(isDefined(var_3)) {
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_5 setModel(var_3);
    var_5 linkTo(var_4, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_4.head = var_5;
    var_4 thread scripts\engine\utility::delete_on_death(var_5);
  }

  var_4.animname = var_0;
  var_4 useanimtree(level.scr_animtree[var_4.animname]);

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_4);
    var_4 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_4;
}

actor_animloop(var_0, var_1, var_2, var_3) {
  self endon(var_2);
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\common\anim::anim_single(var_0, var_1, var_3);
    var_4 = getanimlength(level.scr_anim[var_0[0].animname][var_1]);
    wait(var_4);
  }
}

hostage_price_idle(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 scriptmodelplayanim(level.scr_anim[var_0.animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);

    if(isDefined(var_0.head))
      var_0.head scriptmodelplayanim(level.scr_anim[var_0.head.animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);

    self.exfil_helpers[0] scriptmodelplayanim(level.scr_anim[self.exfil_helpers[0].animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);
    var_1 = getanimlength(level.scr_anim[self.exfil_helpers[0].animname]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"]);
    wait(var_1);
  }
}

defend_while_chopper_arrives(var_0) {
  objective_setlabel(var_0.objectiveindex, &"_encstr_AB7F2490AF08A33A491F999A472135FBDAA52869146477A2F22BE0967B61C92F703F60E15F55");
  objective_setshowprogress(var_0.objectiveindex, 1);
  objective_setprogress(var_0.objectiveindex, 0);
  var_1 = 20;
  var_2 = 20;

  for(;;) {
    wait 1;
    var_2--;
    objective_setprogress(var_0.objectiveindex, var_2 / var_1);

    if(var_2 <= 15) {
      var_0 notify("_encstr_A9710C79AF9ED0C84277D9C79B7A");
      level notify("_encstr_AA8120557F53BBFDDFD0874B25BDE2B775C0BCF310573447E9EA73E3775187E88635");
    }

    if(var_2 <= 0)
      return;
  }
}

leave_if_vip_dies(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B67E107A409637AD902797B529D0B44BB599");
  var_0 endon("_encstr_8A12060D5BA9C745");
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "_encstr_9369093BB483AF325A5991", var_0, "_encstr_992C09B5C322C558EFDB03");
  self notify("_encstr_912D0C88C37F03B7D2A6CE5ABFFB");

  if(self vehicle_getspeed() > 1)
    self waittill("_encstr_8B7205D9ED5958");

  if(istrue(self.going_to_exfil))
    thread evac_hvt(self);
  else {
    if(isDefined(var_0) && isalive(var_0)) {
      var_0.nocorpse = 1;
      var_0 dodamage(var_0.health + 100, var_0.origin);
    }

    self delete();
  }
}