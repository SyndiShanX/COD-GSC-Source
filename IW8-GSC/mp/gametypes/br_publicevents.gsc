/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevents.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_A3B91302B14887F2F677032F0F950AE388397D0FC9", 0)) {
    return;
  }
  level.delayeventfired = getdvarint("_encstr_8181120B20DDE1BB6388507DA0E933B625C0D2C2", 0) == 1;
  level.delayedeventtypes = [];
  level.delay_thirdpersoncamera = [];
  level.delayedunsetbettermissionrewards = getdvarint("_encstr_BD8A22026E05118AA3093B97F1B9567AE57D81FAC569CAC4E87857B750D63A235D9C9772", 2);
  level.delayedshowtablets = relic_squadlink_flash_squadlink_icon("_encstr_AF6F1057974F3142C221DE3FEA222F092977");
  level._encstr_B4371613E4AF0E597D851B8E5AEC95D71C2BF51BB7ABE6A3 = 0;
  all_players_within_distance2d();
  _encstr_86272063EE5BD1037B9032D850808A4F614F53F7470393A82283E9789593B5978ED7::_id_12B21(::setup_nuke_vault_door_open);

  if(_encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_83651A839F53ED480C3C01D9E3EDE0A57A2F211323AA38285A55C9F1())
    level thread _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::init();

  if(_id_12932()) {
    if(unset_relic_healthpacks())
      level thread _id_12934();
    else
      level thread _id_12933();
  }
}

all_players_within_distance2d() {
  _encstr_A39634FFD7C234188B1A3AA870CE4FB72B1FEC33032D33FE0B70C9C97FAE9001E84BB5B286F36E10580D60BA4AB871118D833A07AB63::init();
  _encstr_AD7E3137364EA583A36EF25BE097CE85B6B2A32F83569BCB13E4EBC1571336A5C62BEC2B73A3EB1B0DB71C1C5993B9C59DCDC6::init();
  _encstr_831531634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B938987085120BF88E78897FEB5E153E1923A53BF81C22510CBAE::init();
  _encstr_8249320F07862AC810C36DC59BF2E762D1939BDFC9A533DFC88B798AD37024BABE3B0B274D55B94208F0AD162B107152A04797A7::init();
  _encstr_8DCA3367E3E2304FA35B80F053F68C387D7DE10B988F583813A3865B6BAB31A016D57DBB3E33F1D217EA99E103437F086B66D70FDB::init();
  _encstr_A68B30E6D8392DE08EE6E55B83BCECB0B6568E2F832B37BC31C9BE0E57C46396C6563BCACD47FA4EB2E61DBDB16DC5B3CD1B::init();
  _encstr_A10632BBE1B6378A384787DD59BA175F515943832B858795606DFFC83BF81D878EF11BCA70E57FFA4099FDAC315823FF8029C312::init();
  _encstr_97F43428822A6BB313BB5861905619C3554A88F04B07976013C268E78D9BA09BBED210E8021B97C0CFF98D5065EBE97565EB6A704B76::init();
  _encstr_AACB36DC3639D207A3DCCB6B1CBC76C25BB21DE5C156CDF289E4EBE057318DD26C59CE59DCD1F5C6B77B47B19C161DB2324EF6838B9DCD8D::init();
  _encstr_913131DC6C93B41C47DC5EDAC15E3B2C5B2B8EE5C1AC37BC31937DC1D589D8B41BAC9DAC73A37D0BAE2CECB9360BB9B876378D::init();
  _encstr_951835F0FBF028202BDFA2536BCE7F43E1786B98B0B5B29E9E1BE1EB0F2AC9AFFFC85612E5CB90C712BB580252B403CE739650568797DE::init();
  _encstr_B6F63393B845C45B1B36A7ED4F88FF0E93106B8B88333A6EF19ECF08E5099B5437F8D3C273B9F9C34906ED02F4B14B1E531A4A3BC0::init();
  _encstr_8D682EE66CE4D2838ECDBCAD38BC9D0BDA568E2F3856E6CB139CD7835D136396B1B267ACE6E8EB8EDBBB5939C5766E36::init();
  _encstr_ADA92F8703C2106F837BA0903396AC185D9D012BB8EF3818F343A63B4B8BD18076F59D9B5E1311F46B2A3BE0F2621C188E::init();
  _encstr_B6D83DDCD82796C18EDCF26B1C5E9D0BAD56E8E50EACB95E4C9CD7E057311B2DD859D9CACDE8D72D9BA3B2E43659C11D2DF673F5360DF638C12B9317766E36::init();
  _encstr_A3CA2E6B3166C77AC89757ED69EA472F01699373FBB5D7E550BD2FF84BA8CD57BE812B3A4095AF6F108D01E2E5D8D2B7::init();
  _encstr_914831CDB1934B83D1CD97DA07793B0B5B2BD1BC0E5637CB269CBE1C57C4D84B1B2BD956E6A3FAF6AB3A98392BB0AD1776E66C::init();

  if(unset_relic_healthpacks()) {
    var_0 = spawnStruct();
    var_0.weight = 0;
    _id_12B35(0, var_0);
  }

  _encstr_BA7610699170FB98E2F340909373BD6B3B5A();
}

_encstr_BA7610699170FB98E2F340909373BD6B3B5A() {
  foreach(var_2, var_1 in level.delayedeventtypes) {
    if(var_1.weight <= 0.0 && !_encstr_BDC0192DB91CEA266396B1ACB32BCDD15BCA8EAC93851BE8A5ECCA(var_1)) {
      continue;
    }
    if(isDefined(var_1._id_140CF) && ![[var_1._id_140CF]]()) {
      continue;
    }
    if(isDefined(var_1._encstr_8BC10D10BFF87BCF58583BE223A02F))
      var_1[[var_1._encstr_8BC10D10BFF87BCF58583BE223A02F]]();
  }
}

relic_squadlink_init_vfx(var_0, var_1) {
  var_2 = getDvar("_encstr_96B40B6E1B4EBEC493D738B2D7" + var_0 + "_encstr_993716EB1BA5396C1B2BD7B2ECB2DC8EBEEEB22DB3438ECD", var_1);
  var_3 = [];

  if(var_2 != "_encstr_B40101") {
    var_4 = strtok(var_2, "_encstr_974C0246");

    foreach(var_6 in var_4)
    var_3[var_3.size] = float(var_6);
  }

  return var_3;
}

relic_squadlink_flash_squadlink_icon(var_0) {
  var_1 = getDvar("_encstr_A2921F378DE4BE319CD783ACF5D8A5276CB1CAF52BD92B731DD7B1860BCD1B569B", var_0);
  var_2 = [];

  if(var_1 != "_encstr_B40101") {
    var_3 = strtok(var_1, "_encstr_974C0246");

    foreach(var_5 in var_3)
    var_2[var_2.size] = float(var_5);
  }

  return var_2;
}

_id_12B35(var_0, var_1) {
  if(!isDefined(var_1.weight))
    var_1.active = 0;

  if(!isDefined(var_1.weight))
    var_1.weight = 1.0;

  if(unset_relic_healthpacks()) {
    if(!isDefined(var_1._id_11B78))
      var_1._id_11B78 = 1;

    if(!isDefined(var_1.compass))
      var_1.compass = [];
  }

  level.delayedeventtypes[var_0] = var_1;
  return var_1;
}

generic_waittill_button_press() {
  level notify("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  level._encstr_B4371613E4AF0E597D851B8E5AEC95D71C2BF51BB7ABE6A3 = 0;
}

_id_12932() {
  var_0 = getdvarint("_encstr_8C4E15B9D893BEC44EAF0EACAFCCDE39B159FA1D5E832B", 0);

  if(var_0 != 0)
    return 1;

  if(scripts\mp\utility\game::updatex1stashhud())
    return 0;

  var_1 = revive_wounded_out_handlerr();

  if(!var_1)
    return 0;

  var_2 = revive_wounded_out_handler();

  if(var_2 <= 0.0)
    return 0;

  return 1;
}

_id_132F7(var_0) {
  var_1 = revive_wounded_out_handler();

  if(unset_relic_healthpacks() && isDefined(var_0)) {
    if(isDefined(level.delayedshowtablets[var_0]))
      var_1 = level.delayedshowtablets[var_0];
    else {
      allsupportboxes("_encstr_B6C4545AF59592313162FFAB5048E49E47071ADED0274B201950B3DF2081BCB2C90F2703CDE183870928FF4BB058652E93BCEF7D2D094AD8C968DF1FC2305733F1DE7734983F360B11A0CA0BA06B508ADB6E7EEDF5D9" + var_0);
      return 0;
    }
  }

  if(var_1 <= 0.0)
    return 0;

  return randomfloat(1.0) <= var_1;
}

_encstr_9BA920A5370B9BE5E0BA89362D1BCA672BB98E6CAEE4275937D1B1CB16C6E8D23BCA() {
  return level._encstr_B4371613E4AF0E597D851B8E5AEC95D71C2BF51BB7ABE6A3 > 0;
}

revive_wounded_out_handlerr() {
  return getdvarint("_encstr_BDD410CD1BC9FAC4C9FAC1567D1BEDD5DC8E", 1);
}

revive_wounded_out_handler() {
  return getdvarfloat("_encstr_A7B611FBA1F6AF4E485F98954718149F105912", 0.0);
}

_id_11E05() {
  var_0 = revive_wounded_out_handlerr();
  return var_0 != 1;
}

_id_12933() {
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(_id_11E05()) {
    var_0 = getdvarfloat("_encstr_BA5819B98D9CEB134ED7C156F5B6EA8DE8A57DBB0BD2A3D7B54B37", 240);
    var_1 = getdvarfloat("_encstr_A75819B2685EE14292C9C2AA860BFDB54B79492CF99AF359678AC3", 360);
    var_2 = revive_wounded_out_handlerr();

    while(var_2) {
      var_3 = randomfloatrange(var_0, var_1);
      wait(var_3);

      if(_id_132F7()) {
        give_intel_data(1);
        var_2--;
      }
    }
  } else if(_id_132F7())
    give_intel_data(0);
}

_id_140CC() {
  var_0 = [];

  foreach(var_3, var_2 in level.delayedeventtypes) {
    if(var_2.weight <= 0.0) {
      allsupportboxes(ai_ignore_all_until_goal(var_3) + "_encstr_994A212E90EBFAA230206669C9D87B8639E8F2A6B06B37DACB983830F72327CCB7187B");
      continue;
    }

    if(isDefined(var_2._id_140CF) && ![[var_2._id_140CF]]()) {
      allsupportboxes(ai_ignore_all_until_goal(var_3) + "_encstr_926F32975B92677911CBD868EB39C9FB6B473DEFF78B03B1D4377268C7418023326F874C0EF2C361A9735052B375186F3B14A8D8");
      continue;
    }

    allsupportboxes(ai_ignore_all_until_goal(var_3) + "_encstr_B4520FDE3BD8A3CEFC030B17612FD3ED58");
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

safehouse_create_loot(var_0, var_1, var_2) {
  var_3 = 0.0;

  foreach(var_5 in var_0) {
    var_6 = level.delayedeventtypes[var_5];
    var_7 = var_6.weight;
    var_8 = scripts\engine\utility::ter_op(var_2, var_6._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB, var_6.guard_door_clip);

    if(isDefined(var_1) && isDefined(var_8) && isDefined(var_8[var_1]))
      var_7 = var_8[var_1];

    var_3 = var_3 + var_7;
  }

  return var_3;
}

play_sound_on_pa_systems(var_0, var_1, var_2, var_3) {
  var_4 = 0.0;

  if(!var_0.size)
    return 0;

  foreach(var_6 in var_0) {
    var_7 = level.delayedeventtypes[var_6];
    var_8 = var_7.weight;
    var_9 = scripts\engine\utility::ter_op(var_3, var_7._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB, var_7.guard_door_clip);

    if(isDefined(var_2) && isDefined(var_9) && isDefined(var_9[var_2]))
      var_8 = var_9[var_2];

    var_4 = var_4 + var_8;

    if(var_1 <= var_4)
      return var_6;
  }

  return 0;
}

give_intel_data(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = undefined;

  if(unset_relic_healthpacks()) {
    allsupportboxes("_encstr_B8101EA1EFF239481B417E975207AE87D38587766F8AFE2607786B7417F99A6F" + var_1);
    var_3 = _id_140CD(var_1, var_2);
  } else
    var_3 = _id_140CC();

  if(unset_relic_healthpacks()) {}

  var_4 = safehouse_create_loot(var_3, var_1, var_2);
  var_5 = randomfloat(var_4);
  var_6 = play_sound_on_pa_systems(var_3, var_5, var_1, var_2);
  allsupportboxes("_encstr_A94A11352B1BB28DA3B2C80295EC56E63A8E04" + ai_ignore_all_until_goal(var_6));
  var_7 = getdvarint("_encstr_8C4E15B9D893BEC44EAF0EACAFCCDE39B159FA1D5E832B", 0);

  if(var_7 != 0) {
    allsupportboxes("_encstr_96D321FDF0550383430C9BC05F769BCF993758CDB74CB9A524F3F0ED42145839A89256" + ai_ignore_all_until_goal(var_7));
    var_6 = var_7;
  }

  level _id_12E1F(var_6, var_0, var_1, var_2);
}

_encstr_AB2C0E29DE7C403402CBEBE3EB6A70F0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");

  if(isDefined(var_0.attackerswaittime))
    var_0[[var_0.attackerswaittime]]();

  level._encstr_B4371613E4AF0E597D851B8E5AEC95D71C2BF51BB7ABE6A3 = level._encstr_B4371613E4AF0E597D851B8E5AEC95D71C2BF51BB7ABE6A3 - 1;
  level notify("_encstr_8F2A0A31E4D71C56AFB23723");
}

_id_12E1F(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");

  if(var_0 == 0 && !unset_relic_healthpacks())
    allsupportboxes("_encstr_A26321A8FAD623EBDFCD0B0EAC9BDB82B641F9084DF946954E2AB5DA634A469B0B0675");
  else {
    var_4 = level.delayedeventtypes[var_0];

    if(isDefined(var_4._id_14382) && !var_1)
      var_4[[var_4._id_14382]]();

    if(getdvarint("_encstr_9B791A325E15019AB3F9CB87E1895E2A8D613FA13F73FAB579A0BB87", 1) > 0) {
      while(_encstr_9BA920A5370B9BE5E0BA89362D1BCA672BB98E6CAEE4275937D1B1CB16C6E8D23BCA()) {
        level scripts\engine\utility::_id_143A5("_encstr_8F2A0A31E4D71C56AFB23723", "_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
        waitframe();
      }
    }

    level._encstr_B4371613E4AF0E597D851B8E5AEC95D71C2BF51BB7ABE6A3 = level._encstr_B4371613E4AF0E597D851B8E5AEC95D71C2BF51BB7ABE6A3 + 1;
    var_4.active = 1;
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::devspectatetest(var_0);

    if(unset_relic_healthpacks()) {
      level.delete_after_objective_a = 1;
      allsupportboxes("_encstr_82B2139117708C036F6B7A12111707832BE53C6229" + ai_ignore_all_until_goal(var_0));
      level thread _encstr_AB2C0E29DE7C403402CBEBE3EB6A70F0(var_4);

      if(!istrue(var_3)) {
        if(!isDefined(level.delete_bad_trucks[var_0]))
          level.delete_bad_trucks[var_0] = 0;

        level.delete_bad_trucks[var_0]++;

        if(isDefined(var_2))
          level.delay_vehicle_to_push_explode_sequence[var_0] = var_2;
      }

      var_5 = level.delayedeventtypes[var_0].compass;
      activeparachuters(var_5);
      level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
      neurotoxin_mask_monitor(var_0);
      level notify("_encstr_AB8411DCCA8DAC368EF5B9B2DDD795ECCA73A3");
      return;
    }

    level _encstr_AB2C0E29DE7C403402CBEBE3EB6A70F0(var_4);
    var_4.active = 0;
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::devspectateloc(var_0);
  }
}

neurotoxin_mask_monitor(var_0) {
  if(upload_station_interact_used_think(var_0)) {
    var_1 = level.delayedeventtypes[var_0];

    if(isDefined(var_1.isfeaturedisabled))
      var_1[[var_1.isfeaturedisabled]]();

    var_1.active = 0;
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::devspectateloc(var_0);
  }
}

upload_station_interact_used_think(var_0) {
  var_1 = level.delayedeventtypes[var_0];

  if(!isDefined(var_1))
    return 0;

  return istrue(var_1.active);
}

_id_13371(var_0) {
  foreach(var_2 in level.players)
  var_2 scripts\mp\hud_message::showsplash(var_0);
}

dangercircletick(var_0, var_1) {
  _encstr_AD7E3137364EA583A36EF25BE097CE85B6B2A32F83569BCB13E4EBC1571336A5C62BEC2B73A3EB1B0DB71C1C5993B9C59DCDC6::dangercircletick(var_0, var_1);
}

_encstr_B2D3127BF1E6F77B6BA316E95398826B0D48E3B2(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    wait(var_0);

  setomnvar("_encstr_838C1D0DEC415103CA13D0881FF6D9B51B99899B859A23C9A0C72020C32B91", 0);
}

setup_nuke_vault_door_open(var_0, var_1) {}

unset_relic_healthpacks() {
  return istrue(level.delayeventfired);
}

_id_12934() {
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.delete_bad_trucks = [];
  level.delay_vehicle_to_push_explode_sequence = [];
  var_0 = 0;
  var_1 = getdvarint("_encstr_85E31A37B14EEB139CD7C1CA7D5B16C3F595D959733ABE1BED5D9B1D", level.br_level.br_circleradii.size - 1);

  for(var_2 = level.br_level.br_circleradii.size - 1; var_0 < var_2; var_0++) {
    if(var_0 == 0) {
      level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
      var_3 = 5;
      var_4 = getdvarint("_encstr_992218E6D8C9D7989C7D0E95BEA537D2D1D2581BAF91956316CB", var_3);
      wait(var_4);
    } else {
      if(istrue(level.delete_after_objective_a))
        level waittill("_encstr_AB8411DCCA8DAC368EF5B9B2DDD795ECCA73A3");
      else
        level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");

      var_5 = 8;
      var_6 = getdvarint("_encstr_A1891B9BCA882ECAC2A1C9EFC070C8B8D3BB59BF37F830D1624919B0A2", var_5);
      wait(var_6);
    }

    if(isDefined(level._encstr_A3601745F2A9F8C50F1A2B7172C38F08F16BDF2B980BC81B4B) && level._encstr_A3601745F2A9F8C50F1A2B7172C38F08F16BDF2B980BC81B4B == 0)
      var_7 = 0;
    else
      var_7 = 1;

    var_8 = level.br_circle.circleindex;

    if(_id_132F7(var_8)) {
      level thread give_intel_data(var_7, var_8, 0);
      continue;
    }

    level.delete_after_objective_a = 0;
  }
}

_id_140CD(var_0, var_1) {
  var_2 = [];

  foreach(var_11, var_4 in level.delayedeventtypes) {
    if(var_4.weight <= 0.0) {
      allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_994A212E90EBFAA230206669C9D87B8639E8F2A6B06B37DACB983830F72327CCB7187B");
      continue;
    }

    if(isDefined(var_4._id_140CF) && ![[var_4._id_140CF]]()) {
      allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_926F32975B92677911CBD868EB39C9FB6B473DEFF78B03B1D4377268C7418023326F874C0EF2C361A9735052B375186F3B14A8D8");
      continue;
    }

    if(isDefined(level.delay_thirdpersoncamera) && istrue(level.delay_thirdpersoncamera[var_11])) {
      allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_BDA83A9F539A6F81E9C3C060D331C183737F2517EFB31BB9DC2F7AC0EB597BB98A232D48433EDD59B913B85A8F66D959020F37C6DD82A740946710F0");
      continue;
    }

    if(isDefined(var_4.compass)) {
      var_5 = 0;

      foreach(var_7 in var_4.compass) {
        if(isDefined(level.delete_bad_trucks[var_7])) {
          if(level.delete_bad_trucks[var_7] > 0) {
            var_5 = 1;
            break;
          }
        }
      }

      if(var_5) {
        allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_8BC352408F68BAEADBB81B928D2333F61803BCC831A047B27DB0769AA18713AFA0E33F0577D0887A26EB8A9611DC87A5C8D9BC976948D767C0C1666A181F9B9C88E760E52D28DD5B5C7B5E8260870F1478BBCB7C");
        continue;
      }
    }

    var_9 = scripts\engine\utility::ter_op(var_1, var_4._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB, var_4.guard_door_clip);

    if(isDefined(var_9)) {
      if(isDefined(var_9[var_0]) && var_9[var_0] <= 0) {
        allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_994A212E90EBFAA230206669C9D87B8639E8F2A6B06B37DACB983830F72327CCB7187B");
        continue;
      } else if(!isDefined(var_9[var_0])) {
        allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_8B7E3F8077B09B085A73D92C36968C58D15923088CBA5604D1ED01ADB4CDE65A733B108DD24E36D8AC02CAB32BB9D180DD95B47643E88099B739086CD2278D8DAC" + var_0);
        continue;
      }
    }

    if(!istrue(var_1)) {
      if(isDefined(level.delete_bad_trucks) && isDefined(level.delete_bad_trucks[var_11])) {
        if(isDefined(var_4._id_11B78) && level.delete_bad_trucks[var_11] >= var_4._id_11B78) {
          allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_A5973539E321D857DAEBB5A3DBE24D80ECFF39C1CF9DD01F638711AB33BB05D894502961B6E4F8ECEAF39BAD07C65910307E2BF85D5DF0");
          continue;
        }
      }

      if(isDefined(level.delay_vehicle_to_push_explode_sequence) && isDefined(level.delay_vehicle_to_push_explode_sequence[var_11])) {
        var_10 = var_0 - level.delay_vehicle_to_push_explode_sequence[var_11];

        if(var_10 >= level.delayedunsetbettermissionrewards + 1)
          level.delay_vehicle_to_push_explode_sequence[var_11] = undefined;
        else {
          allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_B4F56540DD16CD4096B9B3B063D22358E82B46048CABCA043ADB80C4AC967376108508E04EB2EC2DDBAE6E1BBC089C85E604AC6795DCE808BBB4E8432D9B10D134B2806E3885E610DB9908A3D02B012B9DB2E6A3013995C1563A5A1D967B37101357336656E4C5");
          continue;
        }
      }
    }

    allsupportboxes(ai_ignore_all_until_goal(var_11) + "_encstr_B4520FDE3BD8A3CEFC030B17612FD3ED58");
    var_2[var_2.size] = var_11;
  }

  if(var_2.size == 0)
    var_2[var_2.size] = 0;

  return var_2;
}

allsupportboxes(var_0) {
  if(getdvarint("_encstr_AAF110A7A06B31D6C23983C59121E15AED59", 0) == 1)
    logstring("_encstr_8F0D05828A8E01" + var_0);
}

ai_ignore_all_until_goal(var_0) {
  switch (var_0) {
    case 0:
      return "_encstr_93511606E793C71961985131D18F577F6740BD800E6FACF3";
    case 1:
      return "_encstr_BE431A13E8840753FF2911D9A193D953DECF9D9716ACAF6AC9791911";
    case 2:
      return "_encstr_A9D01AA1F4C94DA8BE9029FA058AEB45CAA0A2EBC84A25A2A9289854";
    case 3:
      return "_encstr_ABBE1BA13DE46A45D7244AD78254FA2ACA05A87DA4054A314892A8A02D";
    case 4:
      return "_encstr_A74C1C538F61C24BB06D09C137E52F4BA1D9CDC73D111FFF5547C028FF45";
    case 5:
      return "_encstr_B40F1D732875A9D36978C9D91AAFCFE351B8417F72B9417D3B321538856D97";
    case 6:
      return "_encstr_ACC61986F4C99A45AF0994F514A8BEA2AC052ABEA451D451E90D5A";
    case 7:
      return "_encstr_86991B261C81A3A9486593AF691D41FC51872FB937416C702961C79B3B";
    case 8:
      return "_encstr_96F91D079720315401BD7A31D7F997F9030187FFE9F8587C59A7E3CF8FD1C0";
    case 9:
      return "_encstr_849D20E961FD67432F0E8F71FF514E597E9F31E9F808FCCBA72549240DB943A3A7F2";
    case 10:
      return "_encstr_ABCD1AD0F4933545EB2192BE28157D2A560A8ABE055528CA6A1A059C";
    case 11:
      return "_encstr_8F921ED07A72A9A8D72129AF0A157D8AB21454FA05946AF4948A22454AAA1AB4";
    case 12:
      return "_encstr_BE93245884483F638105DACF398979EB6BDFB0010F317FAD71E3D2C73759B653BDD618597497";
    case 13:
      return "_encstr_85C62326C7B3E73941B83151B1EF775F87A05DA077276DF9BD6061A9E9B6A9B5471C5E30E8";
    case 20:
      return "_encstr_96A12434F472A6A2EB244AEB2854FA45652851AFA954884A3482C4BE342528A815FA8829A728";
    case 14:
      return "_encstr_91251CE9F4655F777F4A26B8703FDEE918594181A9CF176F93B7A5387B47";
    case 15:
      return "_encstr_8A9117BB87ECF929491AEEEE71DF098176F8997913CD81151A";
    case 16:
      return "_encstr_ACDE185B87A53E81EFD2AE01C275EFEC70A12D083CE789910C08";
    case 17:
      return "_encstr_A76A1E0DE993A98ABE2449D7412AD78ACA05A2FA94E48A2A92A1A8824552A739";
    case 18:
      return "_encstr_994517A1253DD725E9AD7A5FC98931D4615101B6CBE0EB0819";
    case 19:
      return "_encstr_A65C1A4801E5A2238646320767ED473B93915001997BABA3DFDD291B";
    default:
      scripts\mp\utility\script::laststand_dogtags("_encstr_9B6A2338679EA8FE275552A1BFF6298DFE5A9843751F8A752D9EE9B349EE8BDBD8EB87EDC9" + var_0);
      return "_encstr_8FA80DF5B94BFDE12F4B41E3EF27ED";
  }
}

activeparachuters(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(level.delay_thirdpersoncamera[var_2]))
      level.delay_thirdpersoncamera[var_2] = 1;
  }
}

_encstr_BDC0192DB91CEA266396B1ACB32BCDD15BCA8EAC93851BE8A5ECCA(var_0) {
  if(isDefined(var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB)) {
    foreach(var_2 in var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB) {
      if(var_2 > 0)
        return 1;
    }
  }

  return 0;
}