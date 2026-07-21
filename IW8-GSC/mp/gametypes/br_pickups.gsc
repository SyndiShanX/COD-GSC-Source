/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_pickups.gsc
***********************************************/

delete_objective_on_death_safe() {
  level.br_pickups = spawnStruct();
  level.forcegivesuper = ::forcegivesuper;
  level.showuseresultsfeedback = ::showuseresultsfeedback;
  level._id_12C1F = ::_id_12C1F;
  level.plunderrepositoryrestricted = ::plunderrepositoryref;
  level.plunderrepositories = ::plunderrankupdate;
  level._encstr_A12410C0EA22DB29C77BA72D5BA391910EF3 = getdvarint("_encstr_AA6D16FF6F73CE211930895950604B0FE9683BBAD979C23B", 1);
  level._encstr_8E95132CE966B5E1A722C55B358BE8C33FABDA685B = getdvarint("_encstr_BD951913A7F0B1F7D99E6A428D207F79E823B5982B78C7FFF27073", 1);
  level._encstr_93F6163B58CDAD856EDA35AEB6E0E66D2D38D62C37AE16B1 = getdvarint("_encstr_ADA5209BC639FA76D6EBC2361BB7DD7D9AD5DAE0A5DC76E6DA96C1BED6C237D5B08D", 0);
  level._encstr_B18215C07F8B5833DB3CE56017B26101C4371878EB3C91 = getdvarint("_encstr_96820AE445CD8D41873C2131", 0);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_encstr_ADD714F0F1E843852570989EC9396F722B9FC7170CE2);
  initarrays();
  toppercentagetoadjusteconomy();
}

initarrays() {
  level.brloottablename = getDvar("_encstr_84340A968BF76C551AC18199", "_encstr_88012655037264F248114E6305408AA58089CB9DFB1A3CCA90F98747211D42277891872218A0EB13");

  if(!isDefined(level.br_pickups))
    level.br_pickups = spawnStruct();

  level.br_pickups.init_relic_ammo_drain = [];
  level.br_pickups._encstr_9BBE191AA36BB5ABC5F1E27ADB266BEED81B8391D970BEBFFE084B = [];
  level.br_pickups.modetype = [];
  _id_12B33("_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28", ::plundermusicfirst);
  _id_12B33("_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253", ::plundermusicfirst);
  level.br_pickups.br_equipname = [];
  level.br_pickups.stackable = [];
  level.br_pickups.maxcounts = [];
  level.br_pickups.counts = [];
  level.br_pickups.br_itemtype = [];
  level.br_pickups.br_itemrow = [];
  level.br_pickups.delay_hide_player_clip = [];
  level.br_pickups.br_equipnametoscriptable = [];
  level.br_pickups.br_weapontoscriptable = [];
  level.br_pickups.br_pickupsfx = [];
  level.br_pickups.br_killstreakreference = [];
  level.br_pickups.br_killstreaktoscriptable = [];
  level.br_pickups.br_superreference = [];
  level.br_pickups.delay_delete_rpg_missile = [];
  level.br_pickups._id_13F09 = [];
  level.br_pickups.delay_give_lethal_grenade = [];
  level.br_pickups.br_allguns = [];
  level.br_pickups.br_lootguns = [];
  level.br_pickups.delay_safe_spawn_chopper_boss = [];
  level.br_pickups.br_crateguns = [];
  level.br_pickups.br_crateitems = [];
  level.br_pickups.br_gulagpickups = [];
  level.br_pickups.br_perkpoints = [];
  level.br_pickups.delay_push_player_clear_door_way = [];
  level.br_pickups.deletesoundents = [];
  level.br_lootiteminfo = [];
  level.br_weaponsprimary = [];
  level.br_weaponssecondary = [];
  level.br_throwables = [];
  level.br_usables = [];
  var_0 = [];
  var_1 = 0;
  var_2 = "_encstr_BE4C0295";

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    var_3 = tablelookupgetnumrows(level.brloottablename);
    var_4 = _encstr_92A90F7F75A4CB6073684EBB5013070F13();

    for(var_5 = 0; var_5 < var_3; var_5++) {
      var_6 = tablelookupbyrow(level.brloottablename, var_5, 0);

      if(!isDefined(var_6)) {
        continue;
      }
      if(var_6 == "_encstr_B2C5059803B560") {
        var_7 = tablelookupbyrow(level.brloottablename, var_5, 2);

        if(!isDefined(var_7)) {
          continue;
        }
        if(var_7 == "_encstr_AC20072B9FA9487832") {
          var_8 = tablelookupbyrow(level.brloottablename, var_5, 1);
          var_9 = tablelookupbyrow(level.brloottablename, var_5, 3);
          var_10 = tablelookupbyrow(level.brloottablename, var_5, 5);
          var_11 = tablelookupbyrow(level.brloottablename, var_5, 15);

          if(isDefined(var_10) && var_10.size > 0) {
            var_12 = int(var_10);
            var_13 = tablelookup("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", 0, var_12, 1);

            if(var_13 == "_encstr_B40101") {
              scripts\mp\utility\script::laststand_dogtags("_encstr_85A22E15B8CF53519522938F984136AA83409F9E1365CE97590BE3872086E1E227C826C2042156884088A793211DFAEE" + var_10 + "_encstr_B1A10908D2DC0893DEDD80" + var_5 + "_encstr_B4850D327D965AC5A213CE16085050" + level.brloottablename);
              continue;
            }

            var_14 = tablelookup("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", 0, var_12, 6);
            var_15 = scripts\mp\utility\weapon::getweaponvarianttablename(var_13);
            var_16 = int(tablelookup(var_15, 1, var_14, 0));
            var_17 = tablelookupbyrow(level.brloottablename, var_5, 10);
            var_18 = [];
            var_19 = [];

            if(isDefined(var_17) && var_17.size)
              var_18 = strtok(var_17, var_2);

            if(isDefined(var_18)) {
              foreach(var_21 in var_18) {
                var_22 = strtok(var_21, "_encstr_854C021F");

                if(var_22.size > 1) {
                  var_19[var_22[0]] = int(var_22[1]);
                  continue;
                }

                var_19[var_22[0]] = 0;
              }
            }

            var_24 = var_13;
            var_25 = undefined;
            var_26 = tablelookupbyrow(level.brloottablename, var_5, 11);
            var_27 = [];

            if(isDefined(var_26) && var_26.size)
              var_27 = strtok(var_26, var_2);

            if(isDefined(var_27)) {
              foreach(var_29 in var_27) {
                var_22 = strtok(var_29, "_encstr_854C021F");

                if(var_22[0] == "_encstr_B19005D885B5F6") {
                  var_25 = var_22[1];
                  break;
                }
              }
            }

            if(getdvarint("_encstr_BE8413F37E20A8AEF56E810BC337E1E001403E6F7A", 0))
              var_25 = "_encstr_9AC809AF21A9F7D7EB5A29";

            var_31 = undefined;

            if(!isDefined(var_19))
              var_31 = scripts\mp\class::fixcollision(var_13, var_25, undefined, var_16);
            else
              var_31 = scripts\mp\class::buildweapon_attachmentidmap(var_13, var_19, var_25, undefined, var_16);

            var_32 = createheadicon(var_31);
          } else {
            var_24 = tablelookupbyrow(level.brloottablename, var_5, 8);
            var_17 = tablelookupbyrow(level.brloottablename, var_5, 10);
            var_18 = [];

            if(isDefined(var_17) && var_17.size)
              var_18 = strtok(var_17, var_2);

            if(getdvarint("_encstr_BE8413F37E20A8AEF56E810BC337E1E001403E6F7A", 0))
              var_31 = scripts\mp\class::buildweapon(var_24, var_18, "_encstr_9AC809AF21A9F7D7EB5A29", "_encstr_8BBA05185F8B99", -1);
            else
              var_31 = scripts\mp\class::buildweapon(var_24, var_18, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);

            var_32 = createheadicon(var_31);
          }

          var_44 = int(var_9);
          level.br_pickups.br_itemrow[var_8] = int(var_5);
          level.br_pickups.br_itemtype[var_8] = var_7;
          level.br_pickups.br_pickupsfx[var_8] = var_11;
          level.br_pickups.delay_hide_player_clip[var_8] = var_44;
          level.br_pickups.br_lootguns[level.br_pickups.br_lootguns.size] = var_8;

          if(!isDefined(level.br_pickups.delay_safe_spawn_chopper_boss[var_44]))
            level.br_pickups.delay_safe_spawn_chopper_boss[var_44] = [];

          level.br_pickups.delay_safe_spawn_chopper_boss[var_44][level.br_pickups.delay_safe_spawn_chopper_boss[var_44].size] = var_8;
          level.br_lootiteminfo[var_8] = spawnStruct();
          level.br_lootiteminfo[var_8].baseweapon = var_24;
          level.br_lootiteminfo[var_8].playerstartbesttimeupdate = var_32;
          level.br_lootiteminfo[var_8].playerstartjailsetcontrols = var_31;

          if(var_44 != 10)
            level.br_pickups.br_weapontoscriptable[var_32] = var_8;
        } else {
          var_8 = tablelookupbyrow(level.brloottablename, var_5, 1);
          level.br_pickups.br_itemrow[var_8] = int(var_5);
          var_45 = tablelookupbyrow(level.brloottablename, var_5, 8);

          if(isDefined(var_45) && var_45.size > 0) {
            var_45 = tolower(var_45);
            level.br_pickups.br_equipname[var_8] = var_45;
            level.br_pickups.br_equipnametoscriptable[var_45] = var_8;
          }

          level.br_pickups.delay_delete_rpg_missile[var_8] = int(tablelookupbyrow(level.brloottablename, var_5, 24));
          var_46 = tablelookupbyrow(level.brloottablename, var_5, 16);

          if(var_46 != "_encstr_B40101") {
            switch (var_46) {
              case "_encstr_A34C02BB":
                if(isDefined(var_45) && var_45.size > 0)
                  level.equipment.table[var_45].defaultslot = "_encstr_BA7F0830B3A7859B60B0";

                level.br_throwables[level.br_throwables.size] = var_8;
                break;
              case "_encstr_A74C0222":
                if(isDefined(var_45) && var_45.size > 0)
                  level.equipment.table[var_45].defaultslot = "_encstr_AC8F0AE74163F85AAA380AD8";

                level.br_usables[level.br_usables.size] = var_8;
                break;
              case "_encstr_A14C023B":
                if(isDefined(var_45) && var_45.size > 0)
                  level.equipment.table[var_45].defaultslot = "_encstr_91B50734CA58631D1A";

                break;
              case "_encstr_AC4C024A":
                if(isDefined(var_45) && var_45.size > 0)
                  level.equipment.table[var_45].defaultslot = "_encstr_BEB406F03B72BB3B";

                break;
              default:
                break;
            }
          }

          if(var_7 == "_encstr_85CE0B9770B02C73A1760F06D2" || var_7 == "_encstr_BEEC12F34BF8856F9DE3E2AAA860633DD0E57F50") {
            var_47 = tablelookupbyrow(level.brloottablename, var_5, 19);
            level.br_pickups.br_killstreakreference[var_8] = var_47;
            level.br_pickups.br_killstreaktoscriptable[var_47] = var_8;
          } else if(var_7 == "_encstr_BEB406F03B72BB3B" || var_7 == "_encstr_96DD0D9BAE0ECAE4FA9BBD329CF683") {
            var_48 = tablelookupbyrow(level.brloottablename, var_5, 19);
            level.br_pickups.br_superreference[var_8] = var_48;
          } else if(var_7 == "_encstr_9A430AA072BAFF238F51087D" || var_7 == "_encstr_9B0911C12BC9DA83B7D29BD1BEB9DE4693DBC1") {
            var_49 = tablelookupbyrow(level.brloottablename, var_5, 19);
            level.br_pickups.br_perkpoints[level.br_pickups.br_perkpoints.size] = var_8;
          } else if(var_7 == "_encstr_B116071BCAD186858D" || var_7 == "_encstr_B62F0EE14DFBD8211917639FF3A328BB")
            level.br_pickups.delay_push_player_clear_door_way[level.br_pickups.delay_push_player_clear_door_way.size] = var_8;
          else if(var_7 == "_encstr_99C209E34FC743616118AB" || var_7 == "_encstr_AAA4105B80E1E4025F2FBD79801F8AAA0870")
            level.br_pickups.deletesoundents[level.br_pickups.deletesoundents.size] = var_8;

          var_50 = int(tablelookupbyrow(level.brloottablename, var_5, 4));
          var_51 = int(tablelookupbyrow(level.brloottablename, var_5, 18));

          if(var_7 == "_encstr_B483058670B0B7")
            level.br_ammo_max[var_8] = var_51;

          level.br_pickups.maxcounts[var_8] = var_51;
          level.br_pickups.stackable[var_8] = var_51 > 1;
          level.br_pickups.counts[var_8] = var_50;
          var_7 = tolower(var_7);
          level.br_pickups.br_itemtype[var_8] = var_7;
          level.br_pickups.br_pickupsfx[var_8] = tablelookupbyrow(level.brloottablename, var_5, 15);
          var_52 = tablelookupbyrow(level.brloottablename, var_5, 3);
          level.br_pickups.delay_hide_player_clip[var_8] = int(var_52);
        }

        var_53 = tablelookupbyrow(level.brloottablename, var_5, 6);
        var_53 = strtok(var_53, "_encstr_854C0289");
        var_54 = scripts\engine\utility::_encstr_AFF0174ACA3BE6E9C9D8F8174ECB28CD89ED530580D968E088(var_53, var_4);
        level.br_pickups.delay_give_lethal_grenade[var_8] = var_54;
        continue;
      }

      if(var_6 == "_encstr_8F9E06C26033F37F") {
        var_8 = tablelookupbyrow(level.brloottablename, var_5, 1);
        var_55 = int(tablelookupbyrow(level.brloottablename, var_5, 2));

        if(var_55 > 0) {
          if(isDefined(level.br_lootiteminfo[var_8]) && isDefined(level.br_lootiteminfo[var_8].baseweapon)) {
            for(var_56 = 0; var_56 < var_55; var_56++) {
              level.br_pickups.br_crateguns[level.br_pickups.br_crateguns.size] = var_8;
              level.br_pickups.br_allguns[level.br_pickups.br_allguns.size] = var_8;
            }
          } else {
            for(var_56 = 0; var_56 < var_55; var_56++)
              level.br_pickups.br_crateitems[level.br_pickups.br_crateitems.size] = var_8;
          }
        }

        continue;
      }

      if(var_6 == "_encstr_9B220634456A5747") {
        var_8 = tablelookupbyrow(level.brloottablename, var_5, 1);
        var_57 = tablelookupbyrow(level.brloottablename, var_5, 2);

        if(!isDefined(level.br_pickups.br_gulagpickups[var_57]))
          level.br_pickups.br_gulagpickups[var_57] = [];

        var_58 = level.br_pickups.br_gulagpickups[var_57].size;
        level.br_pickups.br_gulagpickups[var_57][var_58] = var_8;
      }
    }

    _id_12183("_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28", getdvarint("_encstr_8ECB16CD8D93AF89C97DEC166ED42C9BD6AFA195C2C68EA1", 108));
    _id_12183("_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253", getdvarint("_encstr_A3CE1EF720731F62ADE08F06DEEB6AFBF8591357D8688C8A9F0513FACF5D72B5", 216));
    _id_12183("_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3", 8);
  }

  setdvarifuninitialized("_encstr_A37B1C0F078649DA2046BFC4FB80E2B2D5C1F787C135239F584F32CE5063", 0);
  level.br_pickups.br_pickupdenyammonoroom = "_encstr_A3E0185B9075A99ECFB80C3460F75D59F501F7A567C19148E710";
  level.br_pickups.br_pickupdenyequipnoroom = "_encstr_A1F0195382BC2449F5A854AAA441FA44A2E456F59CD37D499E7AD4";
  level.br_pickups.br_pickupdenyalreadyhaveweapon = "_encstr_8AE11FA5892FEB6DD9C73549516F5451C533F5931E30C18EBF2EF953D1F1FED7F5";
  level.br_pickups.br_pickupdenyarmornotbetter = "_encstr_8FFB1C4FF998C2A1372F02CDA715498C7D91977F61CC6CB9E5D59BB31D7D";
  level.br_pickups.br_pickupdenyalreadyhaveks = "_encstr_8D8B2309A3E02372F97C0769D427674AF0B67F2805B08E11617331A208333941B7637835DB";
  level.br_pickups._encstr_A3BC2661B26FB0830AEFA3B1CB3258B0E98DEB199EBC20CB02F38BBDE7CA15408C2532B385EB88F0 = "_encstr_8F95285382FA21A4D7A427A3283515E58213252A0511CAF51282B254EB4A2A35280AD5C9FAA8E9D28AE4";
  level.br_pickups._encstr_992D23B5BB814F30E35C239B87CDC003DA6B0D338F5A934339F32971EBBCE0B463FFB74B1B = "_encstr_83CF265305AF0925AF25E41D50A9A897A0C4258A0A88B2BE12A0AC2AD774AA31823AFAA29E961572";
  level.br_pickups.delete_fan_blades = "_encstr_87D92BA850410D2340946E0718B08D6FA748A9EFC9817701DC39CC504839A59815B922F8042CEC8FA6B0FB2119";
  level.br_pickups.delete_furthest_respawn_enemy = "_encstr_9AB81CA6055E0949BE0A4A9A7A94F5881527CABEA0926AE9A4F564AA1389";
  level.br_pickups.delete_ents_to_clean_up = "_encstr_9A502B6CEA4783E9C1602B376B9D58BED621B9ED3B7B2BFF330F1989373B882019957650FC1FD141B7D30B6FB1";
  level.br_pickups.delete_intro_lights = "_encstr_813831A43971A22E17A9CD717BD591E2CF7CBE39AF1E295FC78EA817C938FD071335D9AFE1E631C5C9883519FF97B8FD0921B2";
  level.br_pickups.delete_headicon = "_encstr_AAA02789604F7D9DE9D039694835FB98CBD4079D8DA7E79F431801A120DD094F875FB69F348FAC43FD";
  level.br_pickups.delete_headicon_on_death = "_encstr_8C9928D482AF2494FA94938E82A951CBA0620AA88ABE82F4AA8609D79129C4C494933AAFA03114458AD4";
  level.br_pickups.delete_light = "_encstr_A7DE1E1D873F3523EF6AEB5F52C528F7B1B0798139EB6F916907F1173393CD1F";
  level.br_pickups.delete_exfil_ai_structs = "_encstr_8C9E2321935FBA997938A11FB3A03DAF7989AD11F747D7E92086305D1F085D55F925BDAFE5";
  level.br_pickups.delete_me = "_encstr_9B4C28F7D3C1EEFAB9D4ED0F576F2F6F91692141D9D7EAC9C81750D18958C40D2159C099BD419E70A57D";
  level.br_pickups.delete_laser_entities = "_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F";
  level.br_pickups.delete_keypad_display_models = "_encstr_8B2922B48CAC814EA9BB7383272188796D97BD8E63CD910931EF73B95F19F579D3BC6565";
  level.br_pickups.delete_enemies_if_reaching_max_ai = "_encstr_AC0E30C7287F0A7F5FA7294D792915F0F63C2A83893F20C8F043EDFD21F1A98F19F9E72D439699AF1D9829A3D70608E35F11";
  level.br_pickups.delete_elevator = "_encstr_AFD925D482F51294BE25E41D0AA9A279058992540A4456EB09822BA2AF0A7A52C92A7D0A1549D2";
  level.br_pickups.delete_ent = "_encstr_ACF71FEB338156E9DFD4447DCEE59928F8FF4D7F3B4880C11D3FEC76A59981A361";
  level.br_pickups.delete_entarray = "_encstr_ADB41F439B29FE71B7BC3C15565D31B0347FCDC977B0BD518F45642EC971F1CD58";
  level.br_pickups.delete_objective_on_death = "_encstr_AD7727A91AF98D4F5FDF81D1E795659FF1F6B6A12721EFD77A2F89D9B7E43DFB88E93C5F8C78333F15";
  level.br_pickups.delete_name_fx = "_encstr_ADAC26FB3089497E2FD88CD5201FBD6A56AA73479A61E9A8373007BFE927C031BAC2EFDF625F716E";
  level.br_pickups.br_dropoffsets = [(24, 24, 6), (-24, -24, 6), (24, -24, 6), (-24, 24, 6), (48, 0, 6), (-48, 0, 6), (0, -48, 6), (0, 48, 6), (72, 0, 6), (-72, 0, 6), (0, -72, 6), (0, 72, 6), (72, -72, 6), (-72, 72, 6), (-72, -72, 6), (72, 72, 6)];
  level.br_pickups._id_12CB7 = getdvarint("_encstr_8F9E15C3E8153963AB70AAB57EB3377B45713B9A5B83AD", 1);
  level.br_pickups._id_12CB5 = getdvarint("_encstr_BEB91BF05AF2CF39B3DFBE3DEB6381575D214088B24FF5D6CF1D4927D7", 1);
  level.br_pickups._encstr_99ED1952C78253E4F3C8AF624837C8A863A37797E363077FB9FB07 = getdvarint("_encstr_BA8F1937C639EBC49CFAB3BA1B0BD9BE8EEDDAB2DCEB76D5B12C3B", 1);
  level.br_pickups.modifydamagetohunter = getdvarint("_encstr_B15E1ED367307123965EFAE320EF9F3278C37B41FB2804BFBD76B35A894ACF2A", 0);
  scripts\engine\scriptable::scriptable_addusedcallback(::lootused);
  scripts\engine\scriptable::_id_12F57(::lootused);
}

_id_12183(var_0, var_1) {
  if(isDefined(level.br_pickups.counts[var_0]) && isDefined(var_1))
    level.br_pickups.counts[var_0] = var_1;
}

remove_roof_nodes(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;

  if(isDefined(var_1))
    var_4.angles = var_1;
  else
    var_4.angles = (0, 0, 0);

  if(isDefined(var_2))
    var_4._id_12223 = var_2;
  else
    var_4._id_12223 = 0;

  var_4.set_force_aitype_armored = var_3;
  return var_4;
}

getitemdroporiginandangles(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1;
  var_9 = 1;
  var_10 = getdvarint("_encstr_8D3F140EA2C9E1D85FFBD9B8DB69913B11CF7586FBE2", 0);
  var_11 = 14;
  var_12 = 50.0;
  var_13 = 40.0;
  var_14 = -5.0;
  var_15 = 5.0;
  var_16 = 10.0;
  var_17 = 360.0 / var_11;
  var_18 = -5.0;
  var_19 = 5.0;
  var_20 = 40.0;
  var_21 = 20.0;
  var_22 = 60.0;
  var_23 = -6.0;
  var_24 = 16.0;
  var_25 = -18.0;
  var_26 = 0;
  var_27 = 0;
  var_28 = undefined;
  var_29 = var_24;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(isDefined(var_6))
    var_29 = var_6;

  var_30 = int(var_0.ml_p3_to_safehouse_transition / var_11);
  var_31 = var_0.ml_p3_to_safehouse_transition - var_30 * var_11;
  var_32 = var_2[1] + (var_31 * var_17 + var_30 * var_16) + randomfloatrange(var_18, var_19);
  var_33 = var_12 + var_30 * var_13 + randomfloatrange(var_14, var_15);

  if(isDefined(var_4))
    var_32 = var_2[1] + var_4;

  if(isDefined(var_5))
    var_33 = var_5;

  var_34 = (0.0, var_32, 0.0);
  var_35 = anglesToForward(var_34);
  var_36 = var_1 + var_35 * var_33;

  if(var_9) {
    var_37 = scripts\engine\utility::array_combine(tablesort(var_36, 500, 500), level._id_1403D);

    if(isDefined(var_3))
      var_37[var_37.size] = var_3;

    var_38 = var_1 + (0.0, 0.0, var_21);
    var_39 = var_36 + (0.0, 0.0, var_21);
    var_40 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 0, 1);
    var_41 = scripts\engine\trace::ray_trace(var_38, var_39, var_37, var_40);

    if(var_41["_encstr_A53009A25003666B9818C6"] < 1.0) {
      var_36 = var_41["_encstr_BD260953AA97E3F014279D"];
      var_36 = var_36 + var_35 * var_25;
    } else
      var_36 = var_39;

    var_38 = var_36;
    var_39 = var_36 + (0.0, 0.0, var_22);
    var_41 = scripts\engine\trace::ray_trace(var_38, var_39, var_37, var_40);

    if(var_41["_encstr_A53009A25003666B9818C6"] < 1.0)
      var_36 = var_41["_encstr_BD260953AA97E3F014279D"] + (0.0, 0.0, var_23);
    else
      var_36 = var_39;

    var_41 = undefined;

    if(istrue(var_7))
      var_41 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(var_36, 0.0, undefined, undefined, var_37);
    else {
      var_38 = var_36;
      var_42 = -1 * getdvarfloat("_encstr_A6E01526D9BEB6858726F6BDE8884EBD1C1295A576D01D", 2000.0);
      var_39 = var_36 + (0.0, 0.0, var_42);
      var_41 = scripts\engine\trace::ray_trace(var_38, var_39, var_37, var_40);
    }

    if(var_41["_encstr_A53009A25003666B9818C6"] < 1.0) {
      var_36 = var_41["_encstr_BD260953AA97E3F014279D"] + (0.0, 0.0, var_29);
      var_28 = var_41["_encstr_850E077B0BF30318B9"];
    } else {
      var_36 = (0, 0, 0);
      var_26 = 1;
    }
  } else
    var_36 = var_36 + (0, 0, var_29);

  if(var_8 && !var_26) {
    var_43 = scripts\engine\utility::ter_op(isDefined(self.intro_heli_add_player), self.intro_heli_add_player, var_20);
    var_27 = getscriptablereservedremaining(var_1 + (0, 0, var_43), var_36);
  }

  var_0.ml_p3_to_safehouse_transition++;
  return remove_roof_nodes(var_36, var_34, var_27, var_28);
}

relics_monitor_on_player(var_0) {
  if(isDefined(var_0) && isDefined(level.br_lootiteminfo[var_0]) && isDefined(level.br_lootiteminfo[var_0].playerstartjailsetcontrols))
    return level.br_lootiteminfo[var_0].playerstartjailsetcontrols;

  return undefined;
}

relic_vampire_globalfunc(var_0) {
  if(isDefined(var_0) && isDefined(var_0.scriptablename))
    return relics_monitor_on_player(var_0.scriptablename);

  return undefined;
}

respawnplayer(var_0) {
  if(isDefined(var_0) && isDefined(var_0.scriptablename) && isDefined(level.br_pickups.delay_hide_player_clip[var_0.scriptablename]))
    return level.br_pickups.delay_hide_player_clip[var_0.scriptablename];

  return undefined;
}

getgulagpickupsforclass(var_0) {
  var_1 = ["_encstr_8BBA05185F8B99"];

  if(isDefined(var_0) && isDefined(level.br_pickups.br_gulagpickups[var_0]))
    var_1 = level.br_pickups.br_gulagpickups[var_0];

  return var_1;
}

_id_119ED(var_0) {
  return var_0.count >> 0 & 2047;
}

_id_119EF(var_0) {
  return var_0.count >> 11 & 2047;
}

_id_119EE(var_0) {
  return var_0.count >> 22 & 31;
}

_id_119F5(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_4 = var_4 + ((var_1 & 2047) << 0);

  if(isDefined(var_2))
    var_4 = var_4 + ((var_2 & 2047) << 11);

  if(isDefined(var_3))
    var_4 = var_4 + ((var_3 & 31) << 22);

  var_0.count = var_4;
}

_id_11A48(var_0) {
  if(var_0.type == "_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1" || var_0.type == "_encstr_AC4D12130876D0524D95EE26F11B2983D878DF8F" || var_0.type == "_encstr_91361613EE974BD9233224936601C9C72707C3D8E2378029")
    return 1;

  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A9D90F1DB0D74B457B30B30F08F02773AB", var_0)))
    return 1;

  if(istrue(var_0._id_11A48))
    return 1;

  return 0;
}

lootused(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(istrue(var_3 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ADBB1538C49859E5C29B60B8A33047CAA3AF31F1D38BE8", var_0)) || istrue(level.stop_end_breach_fx)) {
    return;
  }
  if(var_0 getscriptableisloot() && !_id_11A48(var_0)) {
    var_5 = spawnStruct();
    var_5.scriptablename = var_0.type;
    var_5.origin = var_0.origin;
    var_5.count = _id_119ED(var_0);
    var_5.impulsefx = _id_119EF(var_0);
    var_5.impactfunc_fire = _id_119EE(var_0);
    var_5.tracknonoobplayerlocation = var_0;
    var_5.customweaponname = var_0.customweaponname;
    var_5.maxcount = level.br_pickups.maxcounts[var_5.scriptablename];
    var_5.stackable = level.br_pickups.stackable[var_5.scriptablename];

    if(!var_5.count && isDefined(level.br_pickups.counts[var_5.scriptablename]))
      var_5.count = level.br_pickups.counts[var_5.scriptablename];

    var_5.isweaponfromcrate = var_0.isweaponfromcrate;
    var_5.turretsactive = var_4;

    if(isDefined(var_0.weapon)) {
      var_5.weapon = var_0.weapon;
      var_5._encstr_8DD712B603A09C5BF7F8EA5243CFDF5710C95726 = 1;
    }

    var_6 = var_3 cantakepickup(var_5);

    if(var_6 == 1) {
      var_7 = var_3 onusecompleted(var_5, undefined, var_4);

      if(isDefined(var_0) && var_7)
        _id_119F5(var_0, var_5.count, var_5.impulsefx, var_5.impactfunc_fire);

      if(!isDefined(var_0) || var_7) {
        return;
      }
      _id_11A21(var_0);
    } else {
      var_8 = 1;
      var_9 = level.br_pickups.delay_delete_rpg_missile[var_5.scriptablename];

      if(var_4 && istrue(var_9) && var_2 == "_encstr_BE8B08E323FB2BCD6268")
        var_8 = 0;

      if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E07("_encstr_837E130AB898A0C97307176749BCC2ED5821069650", var_5, var_4, var_2, var_3)))
        var_8 = 0;

      if(var_6 == 17 || var_6 == 21)
        var_8 = 0;

      if(var_8) {
        var_10 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E06("_encstr_915D1570E2CDF1B7EF4D1D942993F9ED372AA888BA6607", var_5, var_3, var_6);

        if(!isDefined(var_10)) {
          if(var_6 == 3)
            var_3 playlocalsound("_encstr_8B070FEE952CE0FA2CB56B7BF566AB6336");
          else if(var_6 == 25)
            var_3 playlocalsound("_encstr_B6C00FD676EF53313138BFB381A9FD4A77");
          else
            var_3 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");

          var_3 showuseresultsfeedback(var_6);
        }
      }
    }
  }
}

_encstr_BD490C3AC3990F6D1807A9B309C8(var_0) {
  return var_0.type == "_encstr_B4D90E9636AFD277F08057BF3029380A" || var_0.type == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D" || var_0.type == "_encstr_95D0174C277D9CAC5D37B0263659AF63EDED8EFA6C0BD8A156" || var_0.type == "_encstr_8E0114B5E6B9D0CF40C4293F21FF4AB13730A0FFCB2D";
}

update_gamebattles_char_loc(var_0, var_1) {
  if(_encstr_BD490C3AC3990F6D1807A9B309C8(var_0))
    return var_1;

  if(var_0.type == "_encstr_BE7B14B6634847D225A787C7C747EB85298BEEBFB8F8" || var_0.type == "_encstr_82BC0EA97AB7F05FD367DFE1DB0A9340" || var_0.type == "_encstr_8E5615586B9997799307D0550A07A04571E2B0E8726DC3" || var_0.type == "_encstr_BDD60E89937D0BE4B57BC947C90B2DB9" || var_0.type == "_encstr_B23615422BC8EFF218A7F2FC7590FC0B10613A9AD038B7" || var_0.type == "_encstr_B6390BC493FA1DE4B0B67758F2")
    return 0;

  return 1;
}

_id_11A21(var_0, var_1) {
  if(var_0 getscriptableislinked()) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = var_0.type;

  if(usb(var_0.type)) {
    if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      level notify("_encstr_83EC19E3F31EEA4D80104C17A9019B72E111C7275BB1B20FE0BBC9" + var_0.origin);

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1207A(var_0);
  }

  if(var_0 getscriptableisreserved() && !istrue(var_0.keepinmap)) {
    lastunrulyscore(var_0);
    var_0 freescriptable();
  } else
    var_0 setscriptablepartstate(var_1, "_encstr_95DF070DD22319CA9B");
}

_encstr_A58619826BA7933D70E6CB278B943828D026E3C85D06B9EFA0568B(var_0, var_1, var_2, var_3) {
  var_4 = _encstr_B6411A5EF299AF2B05DFF060CF4D43C9E25DCF530E725B93E1A37028(var_0, var_1, var_3);
  var_0 onusecompleted(var_4, var_2, undefined, 0);
}

br_forcegivecustompickupitem(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(var_5)) {
    var_0 minsteps(var_1, var_3, var_4, var_5);
    return 1;
  }

  var_6 = _encstr_B6411A5EF299AF2B05DFF060CF4D43C9E25DCF530E725B93E1A37028(var_0, var_1, var_3);
  var_7 = var_0 cantakepickup(var_6);

  if(var_7 == 1) {
    var_0 onusecompleted(var_6, var_2, undefined, var_4);
    return 1;
  }

  return 0;
}

_encstr_B6411A5EF299AF2B05DFF060CF4D43C9E25DCF530E725B93E1A37028(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.scriptablename = var_1;
  var_3.origin = var_0.origin;
  var_3.count = 0;
  var_3.maxcount = level.br_pickups.maxcounts[var_3.scriptablename];
  var_3.stackable = level.br_pickups.stackable[var_3.scriptablename];

  if(isDefined(var_2))
    var_3.count = var_2;

  if(!var_3.count && isDefined(level.br_pickups.counts[var_3.scriptablename]))
    var_3.count = level.br_pickups.counts[var_3.scriptablename];

  return var_3;
}

resetplayerinventorywithdelay(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_0);
  resetplayerinventory(var_1);
}

resetplayerinventory(var_0) {
  var_1 = scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B18D0B5281530117EDEAC82033";
  self.br_inventory_slots = [];

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A"))
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::disable_map_ammo_munitions();

  disable_near_snake_cam_after_open();

  if(isDefined(self.streakdata) && !var_1 && !istrue(level._id_133D7))
    scripts\mp\killstreaks\killstreaks::clearkillstreaks();

  if(!level.allowsupers)
    _id_12C81();

  if(!istrue(var_0)) {
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::stripweaponsfromplayer();
    scripts\mp\equipment::takeequipment("_encstr_BA7F0830B3A7859B60B0");
    scripts\mp\equipment::takeequipment("_encstr_AC8F0AE74163F85AAA380AD8");
    scripts\mp\weapons::_id_1316B(getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"));
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldgetnewspawnpoint())
    _id_12C1F();
}

_id_12C81() {
  scripts\mp\supers::clearsuper();
  self setclientomnvar("_encstr_857F16D54BD70E56C9ADEB38B08DDA58D9B2D7CD8E16E8CA", 0);
  self setclientomnvar("_encstr_8C0B120DAB81A257BF21B369AB96071F402B8373", 0);
}

resetdefaultweaponammo(var_0) {
  var_1 = self getweaponslistall();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = 0;

    if(var_3.inventorytype == "_encstr_BA7F0830B3A7859B60B0") {
      if(isDefined(var_0)) {
        var_5 = var_3.clipsize;
        var_4 = var_5 * (var_0 - 1);
      } else if(level.magcount > 0) {
        var_5 = var_3.clipsize;
        var_4 = var_5 * (level.magcount - 1);
      } else
        var_5 = 0;

      self setweaponammoclip(var_3, var_5);
    }
  }
}

initplayer(var_0) {
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  resetplayerinventory(var_0);
}

spawndebugpickupfromdevgui(var_0) {
  foreach(var_2 in level.players) {
    if(!isbot(var_2) && isalive(var_2)) {
      var_3 = var_2.origin + anglesToForward(var_2.angles) * 100 + (0, 0, 12);
      var_4 = 0;

      if(isDefined(level.br_pickups.counts[var_0]))
        var_4 = level.br_pickups.counts[var_0];

      var_5 = remove_roof_nodes(var_3);
      var_6 = spawnpickup(var_0, var_5, var_4);

      if(isDefined(var_6)) {
        var_7 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
        var_8 = [var_6];
        var_9 = var_6.origin + (0, 0, 50);
        var_10 = var_9 + (0, 0, -200);
        var_11 = scripts\engine\trace::ray_trace(var_9, var_10, var_8, var_7);

        if(isDefined(var_11["_encstr_850E077B0BF30318B9"]) && isDefined(var_11["_encstr_850E077B0BF30318B9"].targetname) && var_11["_encstr_850E077B0BF30318B9"].targetname == "_encstr_8B4C098E39162DE6D777E9") {
          var_12 = var_11["_encstr_850E077B0BF30318B9"];
          var_13 = rotatevectorinverted(var_6.origin - var_12.origin, var_12.angles);
          var_14 = combineangles(invertangles(var_12.angles), var_6.angles);
          var_6 validatecollision(var_12, var_13, var_14);
        }
      }
    }
  }
}

isweaponpickup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_AC20072B9FA9487832";
}

isweaponpickupitem(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.weapon))
    return istrue(var_0.weapon.iscustomweapon) || istrue(var_0._encstr_8DD712B603A09C5BF7F8EA5243CFDF5710C95726);
  else if(isDefined(var_0.scriptablename))
    return isweaponpickup(var_0.scriptablename);

  return 0;
}

takearmorpickup(var_0) {
  var_1 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_2 = _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::isarmorbetterthanequipped(var_1);

  if(var_2)
    tryequiparmor(var_0);
}

takeequipmentpickup(var_0, var_1) {
  var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_3 = level.equipment.table[var_2].defaultslot;
  var_4 = 0;

  if(pickupissameasequipmentslot(var_2, var_3)) {
    if(equipmentslothasroom(var_2, var_3)) {
      if(var_3 != "_encstr_91B50734CA58631D1A")
        scripts\mp\damagefeedback::hudicontype("_encstr_97DB08C666DF7205C008");

      var_5 = scripts\mp\equipment::getequipmentslotammo(var_3);
      var_6 = scripts\mp\equipment::getequipmentmaxammo(var_2);

      if(var_5 + var_0.count > var_6) {
        var_7 = var_6 - var_5;
        scripts\mp\equipment::setequipmentammo(var_2, var_6);
        var_0.count = var_0.count - var_7;
        var_4 = 1;
      } else
        scripts\mp\equipment::incrementequipmentslotammo(var_3, var_0.count);
    } else if(!getdvarint("_encstr_84DF147B21762FCEC8DF061FC7C8154315788322AB4B", 1))
      trypickupitem(var_0.scriptablename, var_0.count);
  } else if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::getequipmentslotammo(var_3) == 0) {
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::setequipmentammo(var_2, var_0.count);
  } else if(!getdvarint("_encstr_84DF147B21762FCEC8DF061FC7C8154315788322AB4B", 1)) {
    var_8 = 1;

    if(isDefined(var_0.count))
      var_8 = var_0.count;

    trypickupitem(var_0.scriptablename, var_8);
  } else {
    var_9 = test_ai_anim();
    dropequipmentinslot(var_9, var_3, var_1);
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::setequipmentammo(var_2, var_0.count);
  }

  return var_4;
}

dropequipmentinslot(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\equipment::getequipmentslotammo(var_1);

  if(isDefined(var_3))
    var_4 = var_3;

  var_5 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment[var_1]);

  if(isDefined(var_5)) {
    var_6 = undefined;

    if(istrue(var_2))
      var_6 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::removefromdismembermentlist();

    var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
    var_8 = 0;
    var_9 = spawnpickup(var_5, var_7, var_4, 1);

    if(isDefined(var_9))
      var_9 modeloadoutupdateammo(self, var_5);
  }
}

modeloadoutupdateammo(var_0, var_1) {
  var_2 = self;

  if(var_1 == "_encstr_853E1DF62308079265E7EFD38D033A4E30EE2FBFF8F8D5BB36AF8FFBC1BDD3") {
    var_2.owner = var_0;
    var_0.modespawnclient = var_2;
  }
}

pickupissameasequipmentslot(var_0, var_1) {
  if(isDefined(self.equipment[var_1]) && self.equipment[var_1] == var_0)
    return 1;

  return 0;
}

equipmentslothasroom(var_0, var_1) {
  if(scripts\mp\equipment::getequipmentslotammo(var_1) < scripts\mp\equipment::getequipmentmaxammo(var_0))
    return 1;

  return 0;
}

takerespawntokenpickup(var_0) {
  if(!_id_12CB6() && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken()) {
    addrespawntoken();
    return 1;
  }

  return 0;
}

addrespawntoken(var_0) {
  var_1 = self;
  var_1.hasrespawntoken = 1;
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1315B(1);

  if(!istrue(var_0))
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_918418134EAF39B2E6C1C2BBB9EBE8BDB59537BE835A1BB5D5C1");
}

removerespawntoken() {
  var_0 = self;
  var_0.hasrespawntoken = 0;
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1315B(0);
}

_encstr_A1A015933F47C2FF33C02F2F1828BB8A35CF5CCE92D34B(var_0) {
  if(istrue(level.usegulag) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_86D90E342CE676ABC6C29D3ABDD6B29B()) {
    _encstr_93A80E858CC8EC57D8B0B38E7BB6AC37();
    return 1;
  }

  return 0;
}

_encstr_93A80E858CC8EC57D8B0B38E7BB6AC37(var_0) {
  var_1 = self;
  var_1._encstr_86D90E342CE676ABC6C29D3ABDD6B29B = 1;
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_925B180318D9F6AFE8A56B75B45343BE17E03BEB084B2CDB8180(1);

  if(!istrue(var_0))
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_BD0216BAEE3E4F9311C8CA41087F4C1FB0C010398E40CF1A");
}

_encstr_8205111BD158BFA34162A5C131A7055F73FB53() {
  var_0 = self;
  var_0._encstr_86D90E342CE676ABC6C29D3ABDD6B29B = 0;
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_925B180318D9F6AFE8A56B75B45343BE17E03BEB084B2CDB8180(0);
}

_id_13A39(var_0) {
  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldgetnewspawnpoint()) {
    bdroppingshield();
    return 1;
  }

  return 0;
}

bdroppingshield(var_0) {
  var_1 = self;
  var_1.shouldgetnewspawnpoint = 1;
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1315C(1);

  if(!istrue(var_0))
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_8C181C6B700E9BBA29C4299ABDF5B24691B18BD72021CE41296B2ED49DA1");

  var_2 = level.maxteamsize == 1;

  if(var_2 && !var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
    var_1 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
}

_id_12C1F() {
  var_0 = self;
  var_0.shouldgetnewspawnpoint = 0;
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1315C(0);
  var_1 = level.maxteamsize == 1;

  if(var_1 && var_0 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
    var_0 scripts\mp\utility\perk::removeperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
}

_id_12CB6() {
  return getdvarint("_encstr_92FD1C6B801AEE65D8BFD9720B0E0A63AB735B3F4310593B62A3EED37BE0", 0) || !istrue(level.br_pickups._id_12CB7) || istrue(level.br_pickups._id_12CB5) && isDefined(level.gulag) && istrue(level.gulag.shutdown);
}

battle_tracks_tryplayingbattletrackswhenstandingonvehicle(var_0) {
  var_1 = self;
  self playsoundtoplayer("_encstr_81D3194C4EFA3656769573190B392F7D36BD7BA3D71C4BB1B65D0E", self);
  var_1.should_use_velo_forward = 1;
  var_1 setclientomnvar("_encstr_938B169BE839A29B18612F6F27B74219C8F19922C0B06B72", 1);
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_AA5F1AE33D032BDE67F8B27AC09352FF9B96706DCB6B1BE67BE01A92(1);

  if(!istrue(var_0))
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_AF3416D296466BBD6338C27983A733EF58E84841A66827C2");
}

_id_12C16() {
  var_0 = self;
  var_0 setclientomnvar("_encstr_938B169BE839A29B18612F6F27B74219C8F19922C0B06B72", 0);
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_AA5F1AE33D032BDE67F8B27AC09352FF9B96706DCB6B1BE67BE01A92(0);
  var_0.should_use_velo_forward = 0;
}

play_hud_reminder_vo() {
  var_0 = self;
  var_1 = spawnStruct();
  var_1.scriptablename = "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
  var_1.nvgvisionsetoverride = level.br_pickups.br_equipname[var_1.scriptablename];
  var_1.origin = self.origin;
  var_1.maxcount = scripts\mp\equipment::getequipmentmaxammo(var_1.nvgvisionsetoverride);
  var_1.count = var_1.maxcount;
  var_1.stackable = level.br_pickups.stackable[var_1.scriptablename];
  var_0 takeequipmentpickup(var_1);
}

_id_13A2F(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss()) {
    var_1 = test_ai_anim();
    var_2 = undefined;
    var_3 = getitemdroporiginandangles(var_1, self.origin, self.angles, self, var_2);
    spawnpickup(self.armorylights, var_3, 1, 1);
  }

  battle_tracks_getbattletracksid(var_0.scriptablename);
}

_encstr_B4121530824C53F337CB9605B417F83DB7DA70B86B259B(var_0) {
  if(!isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B))
    self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B = [];

  if(!isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"]))
    self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"] = 1;
  else if(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"] >= level._encstr_93E61C7349D14BED4FA0D31AD815A7CFCB25EB0AD5DB8FF9FFA0CB83A049._encstr_A5E51297D7D3F3E8350D5088751C9838CB13512F["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"]) {
    var_1 = test_ai_anim();
    var_2 = undefined;
    var_3 = getitemdroporiginandangles(var_1, self.origin, self.angles, self, var_2);
    spawnpickup("_encstr_A5A61D9E150D8818A357232312C369A51CD147C057EB28F5571AE763C1C87F", var_3, 1, 1);
    return;
  } else
    self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"] = self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"] + 1;
}

_encstr_A70611F179CC38B69F32B359AB2FE3B023D579(var_0) {
  if(!isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B))
    self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B = [];

  if(!isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_8EFC0773D1789B9F39"])) {
    self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_8EFC0773D1789B9F39"] = 1;

    foreach(var_2 in level._encstr_8D6816C4AEE4D22B8C7DD14EB285CDABE456EB0EB4C6CADC) {
      var_2 enablescriptablepartplayeruse("_encstr_95EA186E09573BF989C7DD1B3E9307C1134ED8CB3076C31D7BC3", self);
      var_2 disablescriptablepartplayeruse("_encstr_9ABB224B7F4BB89D734785A39B7BD358E45913E3E7B1784D2BB7878DD77126F8B76BB9B8", self);
    }
  } else if(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_8EFC0773D1789B9F39"] >= level._encstr_93E61C7349D14BED4FA0D31AD815A7CFCB25EB0AD5DB8FF9FFA0CB83A049._encstr_A5E51297D7D3F3E8350D5088751C9838CB13512F["_encstr_8EFC0773D1789B9F39"]) {
    var_4 = test_ai_anim();
    var_5 = undefined;
    var_6 = getitemdroporiginandangles(var_4, self.origin, self.angles, self, var_5);
    spawnpickup("_encstr_AFD81D2693C67BDBE87D46C97B0E382B91EB9B561B27598EEBE634B73BAC63", var_6, 1, 1);
    return;
  }
}

battle_tracks_getbattletracksid(var_0) {
  var_1 = self;
  var_1.armorylights = var_0;
  var_2 = int(tablelookup("_encstr_A21A15D60EE51393C2C636B29B6EBE6CC24E8CC5D86ED9", 1, var_0, 0));
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_9538120198883B2B4B77B73836219379374A3295", var_2);
  var_1 _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_11FF9(var_0);
}

_id_12BFC() {
  var_0 = self;

  if(!getdvarint("_encstr_813D20BF3BCAA97E83B1719BCA8FA59822BE3F47A5F08037BB1A0F81032F6B50FFEC", 0)) {}

  var_0 _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::_id_1207D(var_0.armorylights);
  var_0.armorylights = undefined;
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_9538120198883B2B4B77B73836219379374A3295", 0);
}

_id_13A33(var_0) {
  var_1 = var_0.scriptablename;

  if(var_1 == "_encstr_AB771761D5317A0D74C7233F4735C8400853930FEFDB6AD6C8")
    return;
}

takequestitem(var_0) {
  var_1 = var_0.scriptablename;

  if(var_1 == "_encstr_A23715C66A322FED9C9F1842B7B33B6BAB94D05E859AFD")
    var_0 _encstr_95C72B37BED07BE0A5578FA077561F818A503BD14358184F82B8071BB281A303723073E0B8D5DD423390040873::_id_14654(self);
}

battle_tracks_togglethink(var_0) {
  var_1 = self;
  var_2 = scripts\mp\perks\perks::hudcost(var_0.scriptablename);
  self playsoundtoplayer("_encstr_81D3194C4EFA3656769573190B392F7D36BD7BA3D71C4BB1B65D0E", self);

  if(isDefined(var_2) && var_2 != "_encstr_B40101")
    var_1 scripts\mp\perks\perks::battle_tracks_tryinittogglestate(var_2);
}

bearsetup(var_0) {
  var_1 = self;
  self playsoundtoplayer("_encstr_81D3194C4EFA3656769573190B392F7D36BD7BA3D71C4BB1B65D0E", self);
  var_1.should_enter_combat_after_checking_decoy_grenade = 1;
  var_1 scripts\mp\perks\perks::bears();

  if(!istrue(var_0))
    var_1 thread scripts\mp\hud_message::showsplash("_encstr_8A0F16B7C8A936CB116ADA5265E973273A603182270EDB4B");
}

_id_12C26() {
  var_0 = self;
  var_0.should_enter_combat_after_checking_decoy_grenade = 0;
  var_0 scripts\mp\perks\perks::_id_12C25();
}

playerpackdataintogulagomnvar(var_0, var_1, var_2, var_3) {
  self notify("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");

  if(istrue(var_3)) {
    var_4 = test_ai_anim();
    missing_window_blockers(var_4, var_2, var_3, var_0);
    return;
  }

  if(istrue(var_1)) {
    var_4 = test_ai_anim();
    missing_window_blockers(var_4, var_2);
  } else
    scripts\mp\killstreaks\killstreaks::clearkillstreaks();

  scripts\mp\killstreaks\killstreaks::awardkillstreak(var_0, "_encstr_8261067B1D34AC27", undefined, undefined, undefined, 1);
}

takekillstreakpickup(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation.spawnprojectile))
    self.spawnx1stashlootcache = var_0.tracknonoobplayerlocation.spawnprojectile;

  send_notify_after_player_tac_vis(var_0.scriptablename, var_1);
}

send_notify_after_player_tac_vis(var_0, var_1) {
  var_2 = level.br_pickups.br_killstreakreference[var_0];

  if(unset_relic_dogtags(var_2))
    playerkilledspawn(var_2);
  else
    playerpackdataintogulagomnvar(var_2, 1, var_1);
}

should_do_vo_call() {
  if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0)
    return isDefined(self.streakdata.streaks[1]);

  return 0;
}

haskillstreak(var_0) {
  return should_do_vo_call() && self.streakdata.streaks[1].streakname == var_0;
}

show_getcash_hint() {
  return haskillstreak("_encstr_8F770E0752D834A2F69B9BAF8F16EA67");
}

unset_relic_dogtags(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_8B820C8D96391B1B59FAC1ACB2B6":
      var_1 = 1;
      break;
  }

  return var_1;
}

playerkilledspawn(var_0) {
  var_1 = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(var_0);

  if(isDefined(var_1) && isDefined(var_1.linkedtotag))
    self[[var_1.linkedtotag]]();
}

forceusekillstreak(var_0) {
  if(should_do_vo_call())
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);

  scripts\mp\killstreaks\killstreaks::awardkillstreak(var_0, "_encstr_8261067B1D34AC27", undefined, undefined, undefined, 1);
  var_1 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);
  var_2 = scripts\mp\killstreaks\killstreaks::triggerkillstreak(var_1, 1);

  if(!var_2)
    scripts\mp\killstreaks\killstreaks::removekillstreak(1);

  return var_2;
}

_givebrsuper(var_0, var_1, var_2) {
  if(level.allowsupers) {
    scripts\mp\perks\perkpackage::_id_12300(var_1);
    var_2 = scripts\mp\supers::getcurrentsuperpoints() >= scripts\mp\supers::getsuperpointsneeded();
  } else {
    scripts\mp\perks\perkpackage::perkpackage_giveimmediate(var_1);
    self setclientomnvar("_encstr_857F16D54BD70E56C9ADEB38B08DDA58D9B2D7CD8E16E8CA", 3);
    self setclientomnvar("_encstr_BE551757D2BEC1B227AD7D0E2CB1B6169DCABECDBAE0B23913", scripts\mp\supers::getsuperid(var_1));
    self setclientomnvar("_encstr_8C0B120DAB81A257BF21B369AB96071F402B8373", 1);
  }

  if(isDefined(var_0)) {
    scripts\mp\equipment::giveequipment(var_0, "_encstr_BEB406F03B72BB3B");
    scripts\mp\equipment::setequipmentammo(var_0, var_2);

    if(istrue(self.issuperdisabled))
      self.loadoutextraperksfromgamemode = var_2;
  }
}

takesuperpickup(var_0, var_1) {
  var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_3 = level.br_pickups.br_superreference[var_0.scriptablename];
  var_4 = undefined;

  if(isDefined(self.equipment["_encstr_BEB406F03B72BB3B"])) {
    var_4 = scripts\mp\equipment::getequipmentslotammo("_encstr_BEB406F03B72BB3B");

    if(!isDefined(var_4))
      scripts\mp\utility\script::laststand_dogtags("_encstr_A2B3140A63C2CB954E021A2C6E80DCAB07B29C580480" + self.equipment["_encstr_BEB406F03B72BB3B"] + "_encstr_9A7E198ED11213F5A89B8B400F394B3F1A83FB3FB9BB7818F53532");
  }

  if(isDefined(self.equipment["_encstr_BEB406F03B72BB3B"]) && isDefined(var_4) && (var_4 > 0 || mortar_add_fov_user_scale())) {
    var_5 = test_ai_anim();
    dropequipmentinslot(var_5, "_encstr_BEB406F03B72BB3B", var_1);
  }

  _givebrsuper(var_2, var_3, var_0.count);

  if(level.allowsupers)
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
}

mortar_add_fov_user_scale() {
  if(istrue(self.unmark_on_death)) {
    if(isDefined(self.super) && !self.super.usepercent)
      return 1;
  }

  return 0;
}

forcegivesuper(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  foreach(var_7, var_6 in level.br_pickups.br_superreference) {
    if(var_6 == var_0) {
      var_4 = var_7;
      break;
    }
  }

  var_8 = undefined;

  if(isDefined(var_4)) {
    var_8 = level.br_pickups.br_equipname[var_4];

    if(istrue(var_3)) {
      var_9 = test_ai_anim();
      mintokensdropondeath(var_9, var_2, var_3, var_8);
      return;
    }

    if(istrue(var_1)) {
      if(isDefined(self.equipment["_encstr_BEB406F03B72BB3B"]) && scripts\mp\equipment::getequipmentslotammo("_encstr_BEB406F03B72BB3B") > 0) {
        var_9 = test_ai_anim();
        dropequipmentinslot(var_9, "_encstr_BEB406F03B72BB3B", var_2);
      }
    }
  }

  _givebrsuper(var_8, var_0, 1);
}

takegasmask(var_0, var_1) {
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var_2 = undefined;

    if(istrue(var_1))
      var_2 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::removefromdismembermentlist();

    var_3 = test_ai_anim();
    var_4 = getitemdroporiginandangles(var_3, self.origin, self.angles, self, var_2);
    spawnpickup(self.plundersilentcountdownendtime, var_4, int(self.gasmaskhealth), 1);
  }

  scripts\cp_mp\gasmask::init(var_0.count, var_0.scriptablename);

  if(scripts\cp_mp\gasmask::unlocked_escape_door(var_0.scriptablename))
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_886A17607773632913E797DB3201D7B05BF8132D27F36E2E07(2);
  else
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_886A17607773632913E797DB3201D7B05BF8132D27F36E2E07(1);
}

plunderrepositoryref(var_0) {
  if(!isDefined(self.plunderrepositorywidget))
    self.plunderrepositorywidget = [];

  if(isDefined(self.plunderrepositorywidget[var_0])) {
    return;
  }
  self.plunderrepositorywidget[var_0] = 1;
  thread ai_push_forward_watcher();
}

plunderrankupdate(var_0) {
  if(!isDefined(self.plunderrepositorywidget))
    self.plunderrepositorywidget = [];

  if(!isDefined(self.plunderrepositorywidget[var_0])) {
    return;
  }
  self.plunderrepositorywidget[var_0] = undefined;
  thread ai_push_forward_watcher();
}

ai_push_forward_watcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(level._encstr_B18215C07F8B5833DB3CE56017B26101C4371878EB3C91)) {
    var_0 = self _meth_87EB();

    if(var_0)
      return;
  }

  if(istrue(self.gasmaskswapinprogress)) {
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_B80A17578188F1900632FBB19027E38BA74F875D0BA57FF39F", 2.0);
    waitframe();
  }

  self notify("_encstr_A71513CF583B154A87D23B6A4D4BD3C544C8F743D8");
  self endon("_encstr_A71513CF583B154A87D23B6A4D4BD3C544C8F743D8");
  waittillframeend;

  if(istrue(self.gasmaskequipped) && (!isDefined(self.plunderrepositorywidget) || !self.plunderrepositorywidget.size))
    thread _id_12C05();
  else if(!istrue(self.gasmaskequipped) && isDefined(self.plunderrepositorywidget) && self.plunderrepositorywidget.size)
    thread numkilled();
}

ks_circlecount(var_0) {
  var_1 = 0;
  var_1 = var_1 | var_0 isreloading();
  var_1 = var_1 | var_0 isthrowinggrenade();

  if(level._encstr_A12410C0EA22DB29C77BA72D5BA391910EF3 != 0)
    var_1 = var_1 | var_0 scripts\mp\utility\player::isplayerads();

  return var_1;
}

get_area_clear_alias() {
  var_0 = 0;
  var_1 = self;
  var_0 = var_0 | var_1 scripts\cp_mp\utility\player_utility::isinvehicle(1);
  var_0 = var_0 | var_1 isinfreefall();
  var_0 = var_0 | var_1 isparachuting();
  var_0 = var_0 | var_1 setautoboxcalculationusingdobj();

  if(level._encstr_8E95132CE966B5E1A722C55B358BE8C33FABDA685B != 0 && (!var_1 _encstr_84CD17D3C5812855CB533BE79702A640599A38EBADEFA09992() || level._encstr_93F6163B58CDAD856EDA35AEB6E0E66D2D38D62C37AE16B1 != 0))
    var_0 = var_0 | var_1 isjumping();

  return !var_0;
}

_encstr_84CD17D3C5812855CB533BE79702A640599A38EBADEFA09992() {
  if(!getdvarint("_encstr_96820AE445CD8D41873C2131")) {
    var_0 = self _meth_87EB();
    return var_0;
  }

  return 0;
}

numkilled() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self playsoundtoplayer("_encstr_951A1378EA9958313787B04B678A715F60A9EB30A0", self);
  self.gasmaskswapinprogress = 1;
  thread kiosksetupfiresaleforplayer(0.2);
  var_0 = self getgestureanimlength("_encstr_B4DD16D7BDF7E17531189FB7C1A9316BD7C1DE4A12073A8E");

  if(get_area_clear_alias())
    thread _id_12735("_encstr_A94F18B4EE1CD7D9AC9BEB1C8D9793D7CE2CCDB658E6ADF5EDCD", var_0);

  self setclientomnvar("_encstr_97B00C57D27DD92C6EFAB5859BDA", 2);
  wait(var_0);
  self.gasmaskswapinprogress = 0;
  self notify("_encstr_B80A17578188F1900632FBB19027E38BA74F875D0BA57FF39F");
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_956C0F5F17A32190D37C4679E7A5D8E9BA");
  else
    self _meth_87AA("_encstr_A54F0D51AA7701B872C31F43F19D50");

  if(isDefined(self.gasmaskhealth) && self.gasmaskhealth <= 0)
    disable_near_snake_cam_after_open();
}

_id_12735(var_0, var_1) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = getcompleteweaponname(var_0);
  self giveandfireoffhand(var_2);

  while(get_area_clear_alias() && var_1 > 0) {
    if(var_1 > 1) {
      var_3 = 1;
      var_1 = var_1 - 1;
    } else {
      var_3 = var_1;
      var_1 = 0;
    }

    wait(var_3);
  }

  if(self hasweapon(var_2))
    self takeweapon(var_2);
}

_id_12C05() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }
  self playsoundtoplayer("_encstr_9675140B106EEF9A7738C5FE166F31BF11D887CB7863", self);
  var_0 = self getgestureanimlength("_encstr_9547172842CAA7B0A74F99871FD77987B9AA809B1A690F2963");
  thread knock_player_forward(1.3);

  if(get_area_clear_alias())
    thread _id_12735("_encstr_B1FA196F27DB31A790DB79BA1058FA89DCA39FF7F3A6BAA798012F", var_0);

  self.gasmaskswapinprogress = 1;
  self setclientomnvar("_encstr_97B00C57D27DD92C6EFAB5859BDA", 1);
  wait(var_0);
  self.gasmaskswapinprogress = 0;
  self setclientomnvar("_encstr_97B00C57D27DD92C6EFAB5859BDA", 0);
  self notify("_encstr_B80A17578188F1900632FBB19027E38BA74F875D0BA57FF39F");
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");

  if(!isDefined(self.gasmaskhealth) || self.gasmaskhealth <= 0)
    handleweaponreloadammodrop();
}

disable_near_snake_cam_after_open() {
  if(!istrue(self.gasmaskequipped)) {
    return;
  }
  self playsoundtoplayer("_encstr_BED616F65A310F91CBCFC0A857FB6EBF4B06FE8AF91BD1BB", self);
  thread kothlaststarttime(0.6);

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");

  self playsoundtoplayer("_encstr_ADD619E2CD197F8727B1F897C67837F56F80D11314E21B21835985", self);
  handleweaponreloadammodrop();
  var_0 = self getgestureanimlength("_encstr_8D9519B3566E7D5B2CD9D6C2BE3B85CDFAD65837DAF513C92BC2B5");

  if(self isonground())
    thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_AA491B6944FA872F3B7011DBB03B22CF4927FB15D73BEFF9DD90BAC2E0", var_0);
  else {
    var_1 = self.origin;
    var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(var_1, 0, -100000);
    var_3 = var_1[2] - var_2["_encstr_BD260953AA97E3F014279D"][2];

    if(var_3 < getdvarfloat("_encstr_AB3424573F9318A8B21121F90285F846BA67EBE5EF8ADF20F1750836AD71E8E8E217730F4343", 40))
      thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_AA491B6944FA872F3B7011DBB03B22CF4927FB15D73BEFF9DD90BAC2E0", var_0);
  }

  self.gasmaskswapinprogress = 1;
  self setclientomnvar("_encstr_97B00C57D27DD92C6EFAB5859BDA", 3);
  wait(var_0);
  self.gasmaskswapinprogress = 0;
  self notify("_encstr_B80A17578188F1900632FBB19027E38BA74F875D0BA57FF39F");
}

kiosksetupfiresaleforplayer(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0) && var_0 > 0.0)
    wait(var_0);

  self attach("_encstr_AB5F1FC0DA1B68D8A4D16961FF8C804DD743BEA922EFA090BEA36F1FFF35A906D3", "_encstr_AADA07DBF19A4A81D7");
}

knock_player_forward(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0) && var_0 > 0.0)
    wait(var_0);

  if(self.gasmaskequipped) {
    self detach("_encstr_AB5F1FC0DA1B68D8A4D16961FF8C804DD743BEA922EFA090BEA36F1FFF35A906D3", "_encstr_AADA07DBF19A4A81D7");
    self.gasmaskequipped = 0;
  }
}

kothlaststarttime(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0) && var_0 > 0.1)
    wait(var_0 - 0.1);

  playFXOnTag(scripts\engine\utility::getfx("_encstr_83DF13ECCC0F7D762CE6EBD6B0E6B6BE3127AC0B5B"), self, "_encstr_A98C10F0117A694307579828C090CC85ED33");
  wait 0.1;

  if(self.gasmaskequipped) {
    self detach("_encstr_AB5F1FC0DA1B68D8A4D16961FF8C804DD743BEA922EFA090BEA36F1FFF35A906D3", "_encstr_AADA07DBF19A4A81D7");
    self.gasmaskequipped = 0;
  }
}

_encstr_ADD714F0F1E843852570989EC9396F722B9FC7170CE2(var_0, var_1) {
  if(!getdvarint("_encstr_96820AE445CD8D41873C2131")) {
    if(var_0 == "_encstr_8503103B0B9BD7DA0BCDB5AF47BD3B3B8D2B" && scripts\cp_mp\gasmask::hasgasmask(self) && !istrue(self.gasmaskswapinprogress)) {
      var_2 = self _meth_87EB();

      if(var_2) {
        if(istrue(self.gasmaskequipped))
          thread _id_12C05();
        else if(!istrue(self.gasmaskequipped))
          thread numkilled();
      }
    }
  }
}

canholdammobox(var_0) {
  if(!isDefined(self.br_ammo[var_0]))
    return 1;

  return !_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_player_full(self, var_0);
}

isvest(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_A7B606DA83796F4A" && issubstr(var_0, "_encstr_9301057B88CBDC");
}

isgasmask(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_BE7105ECB20BE4" && issubstr(var_0, "_encstr_88EA08EC2CCDDAB037B5");
}

usereload(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_BAAE0B0FF9C056F999C9F4D008" && issubstr(var_0, "_encstr_825711CD83958D4B58B14BB9A3EB267B73AB9B");
}

isplunder(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_83A20883C6EA378C2B93";
}

usb(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_86DB073A2CC4C62B47";
}

uniquelootitemlookup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_868D11A8F74573F18213B54921AA3F39BC3F90";
}

usablecarriables(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_ABDE0FC3F7729E88592B91E8993528D64A";
}

isperkpointpickup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_9A430AA072BAFF238F51087D";
}

istokenpickup(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_857D06B318080D8A";
}

use_milcrate(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_9695073995D94BD959";
}

iskillstreak(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && (level.br_pickups.br_itemtype[var_0] == "_encstr_85CE0B9770B02C73A1760F06D2" || level.br_pickups.br_itemtype[var_0] == "_encstr_BEEC12F34BF8856F9DE3E2AAA860633DD0E57F50");
}

issuperpickup(var_0) {
  return !update_operator_east_char_loc(var_0) && (isDefined(level.br_pickups.br_itemtype[var_0]) && (level.br_pickups.br_itemtype[var_0] == "_encstr_BEB406F03B72BB3B" || level.br_pickups.br_itemtype[var_0] == "_encstr_96DD0D9BAE0ECAE4FA9BBD329CF683"));
}

isplunderextract(var_0) {
  return var_0 == "_encstr_82371705B2A5C0B76359AB10C3334D58FA0783C95C8A085E0B";
}

updatecollectionui(var_0) {
  return var_0 == "_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3";
}

turn_on_red_lights_along_track(var_0) {
  return issubstr(var_0, "_encstr_AFC60C7A01DEE7AAE03FEBF17D80");
}

update_operator_east_char_loc(var_0) {
  return var_0 == "_encstr_B4D90E9636AFD277F08057BF3029380A" || usb(var_0);
}

update_player_about_remaining_enemies(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_9A2B0A12F03587575B7BBEA5";
}

_encstr_A9EF0C543E3A303CD5B5F1C3D8D5(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && level.br_pickups.br_itemtype[var_0] == "_encstr_A98F06181E4BCA85";
}

_encstr_AA7E13510F73B33E8360D137233D22CD70A0B57131(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && var_0 == "_encstr_A5A61D9E150D8818A357232312C369A51CD147C057EB28F5571AE763C1C87F";
}

_encstr_ACB50FE22338D7FB2099DB637A1806D9D4(var_0) {
  return isDefined(level.br_pickups.br_itemtype[var_0]) && var_0 == "_encstr_AFD81D2693C67BDBE87D46C97B0E382B91EB9B561B27598EEBE634B73BAC63";
}

cantakepickup(var_0) {
  if(self isskydiving())
    return 9;

  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8503121B0B7315C25B9528B436ADAB83897BDEA3", var_0);

  if(isDefined(var_1))
    return var_1;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isammo(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut) && !scripts\mp\juggernaut::vehicle_damage_setdeathcallback())
      return 16;

    if(!canholdammobox(var_0.scriptablename))
      return 3;
    else
      return 1;
  }

  if(isweaponpickupitem(var_0)) {
    if(istrue(self.isjuggernaut) && !scripts\mp\juggernaut::vehicle_damage_setdeathcallback())
      return 16;

    if(istrue(self.tracking_max_health))
      return 13;

    if(scripts\cp_mp\utility\player_utility::isinvehicle())
      return 17;

    if(_debug_rooftop_activesat::closedangles())
      return 21;

    return 1;
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isequipment(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(var_0.scriptablename == "_encstr_853E1DF62308079265E7EFD38D033A4E30EE2FBFF8F8D5BB36AF8FFBC1BDD3") {
      if(self != var_0.tracknonoobplayerlocation.owner)
        return 20;
      else
        self.modespawnclient = undefined;
    }

    var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
    var_3 = level.equipment.table[var_2].defaultslot;
    var_4 = istrue(var_0.turretsactive);

    if(!isDefined(var_3)) {
      scripts\mp\utility\script::laststand_dogtags("_encstr_BD02309660D11FD51760BED2D04B0D1B795C0F222F81DF5B235812FAE09156AA21BE8BBA138BB366DD909A40708B7F7A6A8F" + var_0.scriptablename + "_encstr_9AFD0F8540B25CBA2DE07216DACA08F408" + scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_9B4C023E"));
      return 4;
    }

    var_5 = 1;

    if(isDefined(var_0.count))
      var_5 = var_0.count;

    if(var_4 && (var_3 == "_encstr_BA7F0830B3A7859B60B0" || var_3 == "_encstr_AC8F0AE74163F85AAA380AD8")) {
      if(isDefined(self.equipment[var_3]) && pickupissameasequipmentslot(var_2, var_3) && equipmentslothasroom(var_2, var_3))
        return 1;

      return 12;
    }

    if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::getequipmentslotammo(var_3) == 0)
      return 1;

    if(pickupissameasequipmentslot(var_2, var_3)) {
      if(equipmentslothasroom(var_2, var_3))
        return 1;
      else if(getdvarint("_encstr_84DF147B21762FCEC8DF061FC7C8154315788322AB4B", 1))
        return 4;
    }

    if(getdvarint("_encstr_84DF147B21762FCEC8DF061FC7C8154315788322AB4B", 1))
      return 1;

    if(!canslotitem(var_0.scriptablename, var_5))
      return 4;
    else
      return 1;
  }

  if(isplunder(var_0.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder._id_127BF) && self.plundercount >= level.br_plunder._id_127BF)
      return 11;

    return 1;
  }

  if(isgasmask(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    return 1;
  }

  if(usb(var_0.scriptablename)) {
    if(var_0.scriptablename == "_encstr_845B1F61B25C48807B3F8D898F3257E8E10D2B19D8AC784F22FBFFB1F7AA91E894" || var_0.scriptablename == "_encstr_BDAA2BBE124A5768F4076008B73D43A5A2BD2DB5E8A33591CB4381C0CF5298339B692DCF827BD3BBB573A828E3")
      return 1;
    else if(istrue(level.questinfo._id_132E8) && scripts\engine\utility::array_contains(level.questinfo._id_13745, self.team + self.squadindex) || scripts\engine\utility::array_contains(level.questinfo.teamsonquests, self.team))
      return 10;
    else {
      logstring("_encstr_994E1B4AB3306B531FA1877329559BF040987E4C2950401B0F618F2399" + gettime() + "_encstr_ABCA0AC2041D2B16DA409E80" + self.team + "_encstr_AF1F18E4D7AB636553D0EAB018719D9FE7E8033195319BFE9BCA" + istrue(level.questinfo._id_132E8) + "_encstr_858310B001DC2E578591293732951E084F10" + scripts\engine\utility::ter_op(isDefined(self.squadindex), self.squadindex, -1));
      return 1;
    }
  }

  if(isperkpointpickup(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    var_6 = scripts\mp\perks\perks::hudcost(var_0.scriptablename);

    if(!getdvarint("_encstr_BD2E22FA49B07F1BA5F5A77F195872B66856B7C3831801628FC187375F776AFC08BB6F0F", 0) && scripts\mp\utility\perk::_hasperk(var_6))
      return 27;

    if(var_6 == "_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC")
      thread scripts\mp\events::killeventtextpopup("_encstr_8C3A13F6BAB7E10BCA8AC011F3A7ED785F5C88F814", 0, 0);

    if(var_6 == "_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8")
      thread scripts\mp\events::killeventtextpopup("_encstr_AB681D5EF299AD49148B30603F5001C5525FC055CF315131FADFA120977F7B", 0, 0);

    if(var_6 == "_encstr_91111BD740773093A7DA9B22F173D6198EAC556BF65E586D8702F0ABAB")
      thread scripts\mp\events::killeventtextpopup("_encstr_A2C31A26867FF2A760C05F33119B63FAF31DE15AE58DCACF28C06F3B", 0, 0);

    if(var_6 == "_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735")
      thread scripts\mp\events::killeventtextpopup("_encstr_B60C1619CA07706812CFADB317AB3820D522A036F56F681D", 0, 0);

    if(var_6 == "_encstr_92B519E6C12BC6D22C8D1D2FEB56F0474EC2D76E434E2C83DC95C6")
      thread scripts\mp\events::killeventtextpopup("_encstr_975516828BD73BC0B2A0D32B9D0CF8F7B7851B88141FD075", 0, 0);

    if(var_6 == "_encstr_A925123F2B991E48CFE833A7EF1C3D73384F6733")
      thread scripts\mp\events::killeventtextpopup("_encstr_B82E158E2249511BDE3F593053D773BB438CE801FDE2E9", 0, 0);

    if(var_6 == "_encstr_A98E15C8705AAAC417D19C23490BD537C957A61343BFAB")
      thread scripts\mp\events::killeventtextpopup("_encstr_8ECB1589C9FA3AC9858D6D564EF50E2BE4B57DB1DEF68E", 0, 0);

    if(var_6 == "_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2")
      thread scripts\mp\events::killeventtextpopup("_encstr_AD77133E92F9C7086F37501123BD831741BD20306B", 0, 0);

    if(var_6 == "_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F")
      thread scripts\mp\events::killeventtextpopup("_encstr_8CEA161DAA01907F038230984A3738082702B7EF2CF5603D", 0, 0);

    if(var_6 == "_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95")
      thread scripts\mp\events::killeventtextpopup("_encstr_8505181393FA1AD23BA1AFB0C69593A3EB83CA93DA7D8D7BDE1D", 0, 0);

    if(var_6 == "_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765")
      thread scripts\mp\events::killeventtextpopup("_encstr_A2E11659B06F70A01D2B0C6AB56440FA8A3B5BC9DD103A35", 0, 0);

    if(var_6 == "_encstr_A15715DCE059D85A0B631D2FEB9BE89C0B47AC3BD237E8")
      thread scripts\mp\events::killeventtextpopup("_encstr_B4CC16C4C9FAE0ED96DCD1B60B9BEB0ECA9CD67DB1BDF6D1", 0, 0);

    if(var_6 == "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F")
      thread scripts\mp\events::killeventtextpopup("_encstr_A31915C493D7C92BE68EDED8DAD70E594ED6FA1B7B7BD1", 0, 0);

    if(var_6 == "_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32")
      thread scripts\mp\events::killeventtextpopup("_encstr_A12216050B31FDE0BDCA71ABB79CF9374AE3EFF7EB9AC830", 0, 0);

    if(var_6 == "_encstr_BDD614CD83951BD28563D1977D8BAEA5C66D7D99963C")
      thread scripts\mp\events::killeventtextpopup("_encstr_869417E64A213363A14FE04933C99A377B3766FAE9EAC7E884", 0, 0);

    if(var_6 == "_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F")
      thread scripts\mp\events::killeventtextpopup("_encstr_8F6F1AC4C9BE1BDE8D917D89B1DEDE32AC197D38569CDAEBB1BDDEA3", 0, 0);

    if(var_6 == "_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B")
      thread scripts\mp\events::killeventtextpopup("_encstr_AA06194C39FA19DEBA138D56F5D1A5AD56AF1CB293B5BED8DEF647", 0, 0);

    if(var_6 == "_encstr_9A360EC74F39AA043E1D2333C71D30C3")
      thread scripts\mp\events::killeventtextpopup("_encstr_AA90114C39BE597B8CAFE0959CDAF563DBBDE8", 0, 0);

    if(var_6 == "_encstr_AF8F161B6A1D60CB923B796BDF2A05C8A680065057543871")
      thread scripts\mp\events::killeventtextpopup("_encstr_8E4418894EBEDAB48DC67D36860B5ADCFA1CCA9C6DF536BDDEE8", 0, 0);

    if(var_6 == "_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6")
      thread scripts\mp\events::killeventtextpopup("_encstr_A5A2179E15C1861E017E08E292926DB8085F45B02F2878787C", 0, 0);

    if(var_6 == "_encstr_823218E6832B1B96C2B1A3E5BE989CFACDB2270ECAB9A3A5B956")
      thread scripts\mp\events::killeventtextpopup("_encstr_831918FDF3F7A7B5F20819F34338C87718876D1A784F65B8D0C9", 0, 0);

    if(var_6 == "_encstr_957407BAC223B9F05B")
      thread scripts\mp\events::killeventtextpopup("_encstr_BDFE150EA2C9CB995C9B58A06F785115520A68817D6269", 0, 0);

    if(var_6 == "_encstr_8419044EB232")
      thread scripts\mp\events::killeventtextpopup("_encstr_B620125190F9A6632C016335FACACB0FD4354803", 0, 0);

    if(var_6 == "_encstr_B29B0550F33591")
      thread scripts\mp\events::killeventtextpopup("_encstr_BD41134CE4AF98B1EAACEBC1B293B5CDBEB1DBB73A", 0, 0);

    return 1;
  }

  if(istokenpickup(var_0.scriptablename)) {
    var_7 = var_0.scriptablename == "_encstr_ADD9169D2A4D28F89BB130FB4B5F2320629F5F39AF74B0B0";
    var_8 = var_0.scriptablename == "_encstr_B18819130810CF5241AFAC23FC6FBB817860978740AE2C9A572535";
    var_9 = var_7 || var_8;

    if(istrue(self.isjuggernaut) && !var_9)
      return 16;

    if(var_0.scriptablename == "_encstr_865216B27B6327F74871ABB25A03183310A8E1FB9020A238") {
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken())
        return 8;
      else
        return 1;
    }

    if(var_0.scriptablename == "_encstr_97C613F92AD4C00883B71F3353FA44F964C54091D5") {
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_86D90E342CE676ABC6C29D3ABDD6B29B() || _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::checkgulagusecount())
        return 28;
      else
        return 1;
    }

    var_4 = istrue(var_0.turretsactive);

    if(var_9) {
      if(var_4) {
        if(isDefined(self._encstr_88C60DC6B09BA3439D9DE87BB695CD)) {
          if(self._encstr_88C60DC6B09BA3439D9DE87BB695CD == 1 && var_7 || self._encstr_88C60DC6B09BA3439D9DE87BB695CD == 2 && var_8)
            return 1;
        }

        return 12;
      } else
        return 1;
    }

    return 1;
  }

  if(use_milcrate(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(var_0.scriptablename == "_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1") {
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldgetnewspawnpoint())
        return 14;
      else
        return 1;
    }

    return 1;
  }

  if(iskillstreak(var_0.scriptablename)) {
    var_10 = level.br_pickups.br_killstreakreference[var_0.scriptablename];

    if(var_0.scriptablename == "_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537" && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink())
      return 18;

    if(istrue(self.isjuggernaut))
      return 16;

    if(unset_relic_dogtags(var_10)) {
      if(var_10 == "_encstr_8B820C8D96391B1B59FAC1ACB2B6") {
        if(!isDefined(level._id_13ACA[self.team]))
          level._id_13ACA[self.team] = 0;

        var_11 = level._id_13ACA[self.team] + level.br_circle.circleindex + 1;

        if(var_11 >= level.gulag_tutorial_vo.size)
          return 19;
      }

      return 1;
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(self getcurrentweapon()))
      return 7;

    if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks) && self.streakdata.streaks.size > 0 && self.streakdata.streaks[1].streakname == level.br_pickups.br_killstreakreference[var_0.scriptablename])
      return 7;
    else
      return 1;
  }

  if(issuperpickup(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(scripts\mp\supers::issuperinuse())
      return 4;

    return 1;
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isarmor(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(_encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::isarmorbetterthanequipped(level.br_pickups.br_equipname[var_0.scriptablename]))
      return 1;
    else
      return 6;
  }

  if(updatecollectionui(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(getdvarint("_encstr_99EA17139F632FE5B0CFBDF21051D07861B93DA726EB171B3D", 0) == 1 && isDefined(var_0.tracknonoobplayerlocation)) {
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_use_velo_forward()) {
        var_12 = scripts\engine\utility::ter_op(isDefined(self.equipment["_encstr_91B50734CA58631D1A"]), scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A"), 0);
        var_13 = scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"]);
        var_14 = var_0.tracknonoobplayerlocation.count;

        if(var_12 >= var_13)
          return 4;
        else if(var_14 <= 0)
          return 26;
        else {
          thread playerplaypickupanim(var_0);
          play_hit_marker_to_player(var_0, 0);
          return 25;
        }
      } else
        return 1;
    }

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_use_velo_forward())
      return 15;
    else
      return 1;
  }

  if(turn_on_red_lights_along_track(var_0.scriptablename))
    return 1;

  if(_encstr_AA7E13510F73B33E8360D137233D22CD70A0B57131(var_0.scriptablename))
    return 1;

  if(_encstr_ACB50FE22338D7FB2099DB637A1806D9D4(var_0.scriptablename))
    return 1;

  if(usablecarriables(var_0.scriptablename)) {
    if(isDefined(var_0.tracknonoobplayerlocation.team) && self.team == var_0.tracknonoobplayerlocation.team)
      return 1;
    else
      return 4;
  }

  if(usereload(var_0.scriptablename)) {
    if(istrue(self.isjuggernaut))
      return 16;

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink())
      return 18;

    return 1;
  }

  if(var_0.scriptablename == "_encstr_B4AA141ECBE0EF8A4DCFEFD783F8B15FB8B195A661F0") {
    if(istrue(self.isjuggernaut))
      return 16;

    var_15 = scripts\mp\equipment::getequipmentslotammo("_encstr_BA7F0830B3A7859B60B0");
    var_16 = scripts\mp\equipment::getequipmentslotammo("_encstr_AC8F0AE74163F85AAA380AD8");

    if(isDefined(var_15) && var_15 < 2 || isDefined(var_16) && var_16 < 2)
      return 1;
    else
      return 3;
  }

  if(var_0.scriptablename == "_encstr_A9AC0EAFFCC4C81FC22F7F4F57EAD3D8")
    return 1;

  if(update_player_about_remaining_enemies(var_0.scriptablename) || _encstr_A9EF0C543E3A303CD5B5F1C3D8D5(var_0.scriptablename))
    return 1;

  return 2;
}

unlocked_armory(var_0) {
  if(scripts\mp\weapons::isfistweapon(var_0) || scripts\mp\utility\weapon::unset_relic_mythic(var_0) || scripts\mp\utility\weapon::update_health_bar_to_player(var_0))
    return 0;

  return 1;
}

uavfastsweepid(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "_encstr_8D811789E37308C0ABEF4163FB93C8C6EF9AA6B17AC3B3E887":
    case "_encstr_A924171D6BB818889B8EB286EF1B3C788878CF51422374673E":
    case "_encstr_A23715C66A322FED9C9F1842B7B33B6BAB94D05E859AFD":
    case "_encstr_853E1DF62308079265E7EFD38D033A4E30EE2FBFF8F8D5BB36AF8FFBC1BDD3":
      return 1;
    default:
      return 0;
  }
}

spawnpickup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.origin == (0, 0, 0)) {
    return;
  }
  var_8 = 0;
  var_9 = undefined;

  if(isDefined(level.br_pickups.br_weapontoscriptable[var_0]))
    var_9 = level.br_pickups.br_weapontoscriptable[var_0];
  else if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_4) && scripts\mp\riotshield::isriotshield(var_4)) {
    var_8 = 1;
    var_9 = "_encstr_92F01C89C9D8EDBDA3FADDB20B83DB37AF6B2BEB2796F68E37A196AC3623";
  } else if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_4)) {
    var_10 = undefined;

    if(getsubstr(var_4.basename, 0, 3) == "_encstr_81190403FB70")
      var_10 = getsubstr(var_4.basename, 3, 5);
    else
      var_10 = getsubstr(var_4.basename, 4, 6);

    if(var_10 == "_encstr_BE0703A54C")
      var_10 = "_encstr_AA07038DB6";

    if(var_10 == "_encstr_BA0703D5C3")
      var_10 = "_encstr_A10703BB40";

    if(var_10 != "_encstr_820703E04B" && var_10 != "_encstr_A607036B40" && var_10 != "_encstr_A30703C763" && var_10 != "_encstr_990703B843" && var_10 != "_encstr_AD07034A38" && var_10 != "_encstr_AA07038DB6" && var_10 != "_encstr_9707038CB6" && var_10 != "_encstr_A10703BB40" && var_10 != "_encstr_8707037C7F" && var_10 != "_encstr_A50703B5B9") {
      return;
    }
    var_8 = 1;
    var_9 = "_encstr_8A9D17137DA162FF286EA32F41E037AA90FFB7ABCBD64AAB49" + var_10;
  } else if(unlocked_armory(var_0))
    var_9 = var_0;

  if(!isDefined(var_9)) {
    return;
  }
  if(issubstr(var_9, "_encstr_8BA00E0F9056B25217F50AC4533B3A6C") || issubstr(var_9, "_encstr_8D690BDAACBEE44BCD91A5ECB7") || _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_4) && scripts\mp\riotshield::isriotshield(var_4))
    var_1.angles = (var_1.angles[0] - 90, var_1.angles[1], var_1.angles[2]);

  heardparachuteoverheadtime();

  if(var_8) {
    var_11 = getnodecount(var_9, var_1.origin, var_1.angles, var_1._id_12223, var_4);

    if(isDefined(var_11)) {
      var_11.customweaponname = createheadicon(var_4);
      var_11.weapon = var_4;
    }
  } else
    var_11 = easepower(var_9, var_1.origin, var_1.angles, var_1._id_12223);

  if(!isDefined(var_11)) {
    return;
  }
  if(isDefined(var_1.set_force_aitype_armored)) {
    var_12 = rotatevectorinverted(var_1.origin - var_1.set_force_aitype_armored.origin, var_1.set_force_aitype_armored.angles);
    var_13 = combineangles(invertangles(var_1.set_force_aitype_armored.angles), var_1.angles);
    var_11 validatecollision(var_1.set_force_aitype_armored, var_12, var_13);
    var_11.set_force_aitype_armored = var_1.set_force_aitype_armored;
  }

  _id_12B3A(var_11);

  if(isDefined(var_2))
    _id_119F5(var_11, var_2, var_6, var_7);
  else
    _id_119F5(var_11, 0);

  if(!isDefined(var_5))
    var_5 = 1;

  if(!istrue(level.br_pickups.delay_delete_rpg_missile[var_9]))
    var_5 = 1;

  if(uavfastsweepid(var_0))
    var_11.init_weapon_placements = 1;

  if(!getdvarint("_encstr_A37B1C0F078649DA2046BFC4FB80E2B2D5C1F787C135239F584F32CE5063")) {
    if(istrue(var_3)) {
      if(var_5)
        var_11 setscriptablepartstate(var_9, "_encstr_88C60846397B83835919");
      else
        var_11 setscriptablepartstate(var_9, "_encstr_99F00E8C4EBD8307958C72BD82D5477B");
    }
  }

  var_14 = level.br_pickups.init_relic_ammo_drain[var_9];

  if(isDefined(var_14))
    var_11[[var_14]]();

  return var_11;
}

_id_12B33(var_0, var_1) {
  level.br_pickups.init_relic_ammo_drain[var_0] = var_1;
}

_encstr_BE3226989F6F28E7BBAFD6DF84E21F13C06BB8E8CF16E1F142D5CE66DABA57D93BBF789853D9F9A7(var_0) {
  level.br_pickups._encstr_9BBE191AA36BB5ABC5F1E27ADB266BEED81B8391D970BEBFFE084B = scripts\engine\utility::array_add(level.br_pickups._encstr_9BBE191AA36BB5ABC5F1E27ADB266BEED81B8391D970BEBFFE084B, var_0);
}

showuseresultsfeedback(var_0) {
  switch (var_0) {
    case 5:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    case 3:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyammonoroom);
      return;
    case 4:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
      return;
    case 6:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyarmornotbetter);
      return;
    case 7:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveks);
      return;
    case 8:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._encstr_A3BC2661B26FB0830AEFA3B1CB3258B0E98DEB199EBC20CB02F38BBDE7CA15408C2532B385EB88F0);
      return;
    case 28:
      scripts\mp\hud_message::showerrormessage(level.br_pickups._encstr_992D23B5BB814F30E35C239B87CDC003DA6B0D338F5A934339F32971EBBCE0B463FFB74B1B);
      return;
    case 14:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_fan_blades);
      return;
    case 9:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_light);
      return;
    case 10:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_exfil_ai_structs);
      return;
    case 11:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_me);
      return;
    case 13:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_name_fx);
      return;
    case 15:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_ents_to_clean_up);
      return;
    case 24:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_intro_lights);
      return;
    case 26:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_headicon);
      return;
    case 25:
      scripts\mp\hud_message::showmiscmessage("_encstr_B89214C18D58E859F5E0F6BA3686BE66D28DD85A73D9");
      return;
    case 16:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_laser_entities);
      return;
    case 23:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_keypad_display_models);
      return;
    case 18:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_enemies_if_reaching_max_ai);
      return;
    case 27:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_elevator);
      return;
    case 19:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_ent);
      return;
    case 20:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_entarray);
      return;
    case 22:
      scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_objective_on_death);
      return;
    case 2:
      break;
  }
}

_removecashstateforplayer(var_0, var_1) {
  var_0 notify("_encstr_A1411093CAE6B2D1F51BB0CDA17DDD1696A3");
  var_0 endon("_encstr_A1411093CAE6B2D1F51BB0CDA17DDD1696A3");
  wait(var_1);
  var_0.br_cash_count = undefined;
  var_0.br_cash_time = undefined;
}

getcashsoundaliasforplayer(var_0, var_1) {
  var_2 = "_encstr_9BAE0F13C9BE072DB1B6BAC17D360BCD1A";
  var_3 = 5000.0;
  var_4 = var_3 / 1000.0;
  var_5 = gettime();
  var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6();

  if(isPlayer(var_0)) {
    if(!isDefined(var_0.br_cash_count))
      var_0.br_cash_count = 0;

    if(!isDefined(var_0.br_cash_time))
      var_0.br_cash_time = var_5;

    var_7 = var_5 - var_0.br_cash_time;
    var_0.br_cash_time = var_5;

    if(var_7 < var_3)
      var_0.br_cash_count = var_0.br_cash_count + 1;

    var_0 thread _removecashstateforplayer(var_0, var_4);
    var_8 = "_encstr_B49005512AF703";

    if(var_6)
      var_8 = "_encstr_937205B83FECF1";

    switch (var_1) {
      case "_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996":
      case "_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922":
      case "_encstr_B2B01D8673D045F77D990F34EB05875150FF8B8E87CBC86068055D822009FA":
      default:
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_8B1A0437CA6B";
            break;
          case 2:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_991A0487CF93";
            break;
          case 3:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_9B1A04FF31E3";
            break;
          case 4:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_8D1A04EBC0D0";
            break;
          case 5:
          default:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_AF1A045F4185";
            break;
        }

        break;
      case "_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A":
      case "_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC":
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_810208EB5BCA32D781C4";
            break;
          case 2:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_AA0208216FBD596FCF4A";
            break;
          case 3:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_97020877D3B5425F7A93";
            break;
          case 4:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_AD0208BE6B2B91EB060D";
            break;
          case 5:
          default:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_850208FA6B2B19BE81D4";
            break;
        }

        break;
      case "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2":
      case "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926":
      case "_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3":
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_AF3008EF99E33771C112";
            break;
          case 2:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_863008C150D5F7572306";
            break;
          case 3:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_A5300831A02567C7B336";
            break;
          case 4:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_83300840F5CB270ED00A";
            break;
          case 5:
          default:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_8B300819F8DE77C9E703";
            break;
        }

        break;
      case "_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72":
        switch (var_0.br_cash_count) {
          case 1:
          case 0:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_950609EBECD8C9B3FA0C98";
            break;
          case 2:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_B40609E945EB4E1F4771DA";
            break;
          case 3:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_B6060959EB202ACAE19FC7";
            break;
          case 4:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_A6060999A359BBAF81E1BC";
            break;
          case 5:
          default:
            var_2 = "_encstr_9A990B5B4591D283367A5DD999" + var_8 + "_encstr_B20609DF44F0B3AFCFEA37";
            break;
        }

        break;
    }
  }

  return var_2;
}

onusecompleted(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = 0;

  if(!isDefined(var_0.count))
    var_0.count = 0;

  if(!istrue(var_1)) {
    var_5 = "_encstr_8B9A129827D71C5AD8D6570EFAEC5637B29CA58D";
    var_6 = undefined;

    if(isDefined(var_0.scriptablename)) {
      if(isplunder(var_0.scriptablename))
        var_5 = getcashsoundaliasforplayer(self, var_0.scriptablename);
      else if(isDefined(level.br_pickups.br_pickupsfx[var_0.scriptablename]) && level.br_pickups.br_pickupsfx[var_0.scriptablename].size > 0)
        var_5 = level.br_pickups.br_pickupsfx[var_0.scriptablename];
      else if(isweaponpickupitem(var_0))
        var_5 = "_encstr_8E130F49237FC7B02E9B03018713E8076B";
      else
        var_5 = "_encstr_B6C00FD676EF53313138BFB381A9FD4A77";

      if(isplunder(var_0.scriptablename))
        var_6 = "_encstr_9BA40B70AB3F538103D5758DAA";
      else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isammo(var_0.scriptablename))
        var_6 = "_encstr_97DB08C666DF7205C008";
      else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isarmorplate(var_0.scriptablename))
        var_6 = "_encstr_925809A3CD88325270F892";
    }

    self playsoundtoplayer(var_5, self);
    var_7 = var_5 + "_encstr_A91A047FF3A7";

    if(soundexists(var_7))
      self playsoundtoteam(var_7, self.team, self, self);

    if(isDefined(var_6))
      scripts\mp\damagefeedback::hudicontype(var_6);

    if(!istrue(var_2))
      thread playerplaypickupanim(var_0);
  }

  level notify("_encstr_BAA71D50AB71B74FD9A0038BD82BC26F0818C3F1B1F81F96FB40CA02702971" + var_0.scriptablename + var_0.origin);

  if(isplunder(var_0.scriptablename))
    self notify("_encstr_86FA1ACD95C699FAC14B1BADB219EA8396472BDABEC11BD573322BC9");
  else if(isweaponpickupitem(var_0))
    self notify("_encstr_BDFA195B95A8BBC9F9583AB2D039BB1BE085D5CD2093FF0EA150F2");
  else
    self notify("_encstr_83D013DC563699F538A536AD598CAE38B44756DAFA" + var_0.scriptablename);

  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A3520F98B579CF8963A77888B39D632B92", var_0))) {
    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_BDB80B883AF4FB3F9F23F2F528"))
      var_4 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_BDB80B883AF4FB3F9F23F2F528", var_0);
  } else if(isweaponpickupitem(var_0)) {
    scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
    generatespawnpoint();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::takeweaponpickup(var_0);
    var_8 = respawnplayer(var_0);
    var_9 = 0;

    if(isDefined(var_8))
      var_9 = 1 << var_8;

    scripts\cp\vehicles\vehicle_compass_cp::_id_1205F("_encstr_AC20072B9FA9487832", var_9);
    var_10 = isDefined(var_0.scriptablename) && var_0.scriptablename == "_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656";

    if(var_10)
      _id_11AAC();
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isammo(var_0.scriptablename))
    var_4 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::takeammopickup(var_0);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isequipment(var_0.scriptablename)) {
    var_4 = takeequipmentpickup(var_0, var_3);
    var_11 = 0;

    if(level.br_pickups.br_itemtype[var_0.scriptablename] == "_encstr_B116071BCAD186858D")
      var_11 = 1;
    else if(level.br_pickups.br_itemtype[var_0.scriptablename] == "_encstr_99C209E34FC743616118AB")
      var_11 = 2;
    else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isarmorplate(var_0.scriptablename))
      var_11 = 4;
    else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::ishealitem(var_0.scriptablename))
      var_11 = 8;

    scripts\cp\vehicles\vehicle_compass_cp::_id_1205F("_encstr_BE8F0A272F9B2BE97268AE8B", var_11);
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isarmor(var_0.scriptablename))
    takearmorpickup(var_0);
  else if(var_0.scriptablename == "_encstr_A9AC0EAFFCC4C81FC22F7F4F57EAD3D8" && isDefined(level.givetagsfromcache))
    self[[level.givetagsfromcache]]();
  else if(isplunder(var_0.scriptablename)) {
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::takeplunderpickup(var_0);
    scripts\cp\vehicles\vehicle_compass_cp::_id_1205F("_encstr_83A20883C6EA378C2B93", var_0.count);
  } else if(istokenpickup(var_0.scriptablename)) {
    if(issubstr(var_0.scriptablename, "_encstr_B1C50F932BC89507367B5EEB3AEDB6CAB9"))
      takerespawntokenpickup(var_0);

    if(issubstr(var_0.scriptablename, "_encstr_96860CD9BAB10BEC7DA3DED65637"))
      _encstr_A1A015933F47C2FF33C02F2F1828BB8A35CF5CCE92D34B(var_0);

    if(issubstr(var_0.scriptablename, "_encstr_81B30F6883DBF9742D90C02F804F6003D5") || issubstr(var_0.scriptablename, "_encstr_85A2121434FDE16E30409BB770880F1BB7C2DF0D"))
      _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_8AF01BA32C6DCAA1B24EB7B396B18D0B4B9BA3F6DA56371CA5B15BAB38(var_0);
  } else if(use_milcrate(var_0.scriptablename))
    _id_13A39(var_0);
  else if(isperkpointpickup(var_0.scriptablename))
    battle_tracks_togglethink(var_0);
  else if(iskillstreak(var_0.scriptablename)) {
    if(var_0.scriptablename == "_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537")
      bearsetup();
    else {
      takekillstreakpickup(var_0, var_3);

      if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation._id_11A40) && issubstr(var_0.tracknonoobplayerlocation._id_11A40, "_encstr_AF3A063777C2C3D0") || istrue(var_3))
        scripts\cp\vehicles\vehicle_compass_cp::_id_1205F("_encstr_85CE0B9770B02C73A1760F06D2", 0);
    }
  } else if(issuperpickup(var_0.scriptablename)) {
    takesuperpickup(var_0, var_3);
    scripts\cp\vehicles\vehicle_compass_cp::_id_1205F("_encstr_BE8F0A272F9B2BE97268AE8B", 16);
  } else if(isgasmask(var_0.scriptablename))
    takegasmask(var_0, var_3);
  else if(usb(var_0.scriptablename))
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13A38(var_0.tracknonoobplayerlocation);
  else if(updatecollectionui(var_0.scriptablename)) {
    if(getdvarint("_encstr_99EA17139F632FE5B0CFBDF21051D07861B93DA726EB171B3D", 0) == 1) {
      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_use_velo_forward()) {
        battle_tracks_tryplayingbattletrackswhenstandingonvehicle();
        play_hit_marker_to_player(var_0, 1);
      }
    } else {
      battle_tracks_tryplayingbattletrackswhenstandingonvehicle();
      play_hud_reminder_vo();
    }
  } else if(var_0.scriptablename == "_encstr_B4AA141ECBE0EF8A4DCFEFD783F8B15FB8B195A661F0")
    takegenericgrenadepickup(var_0);
  else if(turn_on_red_lights_along_track(var_0.scriptablename))
    _id_13A2F(var_0);
  else if(_encstr_AA7E13510F73B33E8360D137233D22CD70A0B57131(var_0.scriptablename))
    _encstr_B4121530824C53F337CB9605B417F83DB7DA70B86B259B(var_0.scriptablename);
  else if(_encstr_ACB50FE22338D7FB2099DB637A1806D9D4(var_0.scriptablename))
    _encstr_A70611F179CC38B69F32B359AB2FE3B023D579(var_0.scriptablename);
  else if(uniquelootitemlookup(var_0.scriptablename))
    _id_13A33(var_0);
  else if(usablecarriables(var_0.scriptablename))
    takequestitem(var_0);
  else if(usereload(var_0.scriptablename))
    bearsetup();
  else if(update_player_about_remaining_enemies(var_0.scriptablename)) {
    if(var_0.scriptablename == "_encstr_BE7B14B6634847D225A787C7C747EB85298BEEBFB8F8") {
      if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_A2961348389F517A7C8303D8EBFACF3B01231FDC9F") && isDefined(var_0.tracknonoobplayerlocation))
        var_0.tracknonoobplayerlocation thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A2961348389F517A7C8303D8EBFACF3B01231FDC9F", self);
      else
        var_0 thread _encstr_81032C6ED8E4B41CA3CDCBAD0E979DB05B561D971C95375E98C9BE2C3647FA6BDEC8B2AF56E68D0B38955C76B9C6::obj_heli_assault3_fob(self);
    } else if(var_0.scriptablename == "_encstr_8D811789E37308C0ABEF4163FB93C8C6EF9AA6B17AC3B3E887")
      thread _encstr_A1AF2E47361A237BCB8BB657837A4F09550B0B3B90D06B98EE1A37F14AF8D595FFF98B3793980B7D71BA377AD280DAF6::_id_13A1E(self);
    else if(var_0.scriptablename == "_encstr_B60F1819CA3420E82317ABB33BCA20A3D169A3B1726518916A9B")
      var_0 thread _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::_encstr_82730F3BB0916B53E9B6CE8295F3EA2D1B(self);
    else if(var_0.scriptablename == "_encstr_A378104B25894AD7104638C5D971F333D383")
      var_0.tracknonoobplayerlocation thread _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::onuse(self);
  } else {
    var_12 = 1;

    if(isDefined(var_0.count))
      var_12 = var_0.count;

    trypickupitem(var_0.scriptablename, var_12);
  }

  var_12 = 1;

  if(isDefined(var_0.count))
    var_12 = var_0.count;

  if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation._id_13F0A))
    _id_128B5(var_0.tracknonoobplayerlocation._id_13F0A, self);

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_lootpickup(self, var_0.scriptablename, var_12);
  return var_4;
}

playerplaypickupanim(var_0) {
  self notify("_encstr_B6AE15018C8610651BC9489123EB2B885C0D89DB266C48");
  self endon("_encstr_B6AE15018C8610651BC9489123EB2B885C0D89DB266C48");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isweaponpickupitem(var_0) || !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12518()) {
    return;
  }
  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ADE213BB6277F7A91DAF5111C146C83DBB789060EA", var_0))) {
    return;
  }
  var_1 = getcompleteweaponname("_encstr_A52119A7D36A1134E0C317B215FB9E6969E79FEB09C9C95B6D93F1");

  if(self hasweapon(var_1)) {
    if(self isgestureplaying("_encstr_B10F1296DD07BE3BB2B9FA0EA51BADD51CAF89C9"))
      self stopgestureviewmodel("_encstr_B10F1296DD07BE3BB2B9FA0EA51BADD51CAF89C9", 0, 1);

    self takeweapon(var_1);
    waitframe();
  }

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_A52119A7D36A1134E0C317B215FB9E6969E79FEB09C9C95B6D93F1", 1.17);
}

test_ai_anim() {
  var_0 = spawnStruct();
  var_0.ml_p3_to_safehouse_transition = 0;
  return var_0;
}

droponplayerdeath(var_0) {
  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A549125D02CF7BE7E581E8980BFF55355FB9DDC3", var_0))) {
    return;
  }
  if(istrue(level.usegulag) && (_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag() || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1443C())) {
    return;
  }
  var_1 = test_ai_anim();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A21B15168C8C2293DEE0F437828DC22FCA4E88AC588EA1", var_1, var_0);

  if(scripts\mp\utility\killstreak::isjuggernaut())
    _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::droponplayerdeath(var_1);

  var_2 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AFF616E3B8631BCA703B9D99E5C0C3B79F33BABAE5462FBA");
  minplunderextractions(var_1);

  if(!istrue(level._id_133EA) && !istrue(var_2))
    missiontime(var_1);

  if(!istrue(level._id_133CD))
    mintokensdropondeath(var_1);

  if(getdvarint("_encstr_971B1C6636E311B0A807A2480F59CF8963B1CBC7EE154DB9FBA3B0C83814", 1) == 1 || !istrue(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_use_velo_forward()))
    missedinfilplayerhandler(var_1);

  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playerdropplunderondeath(var_1, var_0);
  missed_shots(var_1);

  if(!istrue(level._id_133D7) && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_B18D0B5281530117EDEAC82033")
    missing_window_blockers(var_1);

  if(!istrue(level._id_133E6))
    mix_loot_pickups(var_1);

  missions_clearinappropriaterewards(var_1);
  missionparticipation(var_1);
  minigun_turret_info(var_1);
  _encstr_BA9A122176A83013FDC07057F36897134302B383(var_1);
  _encstr_82A411080BF5D15BAF237EFD2CAF60A71BC2C0(var_1);
  modifycrushdamage(var_1);
  mlgmodifyheadshotdamage(var_1);
  modifydamagetoprop();
  _encstr_976F13234EBD83B9B1C9AC2C5BAC3932953BD28D2B(var_1);
  var_0 = self.lastkilledby;

  if(isDefined(var_0))
    minshotstostage2acc(var_1, var_0);
}

minplunderextractions(var_0) {
  foreach(var_2 in level.br_ammo_types) {
    if(self.br_ammo[var_2] > 0 && isDefined(level.br_pickups.br_itemrow[var_2])) {
      var_3 = var_2;
      var_4 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup(var_3, var_4, self.br_ammo[var_2], 1);
    }
  }
}

missiontime(var_0) {
  foreach(var_2 in self.equippedweapons) {
    if(_id_132F9(var_2, self))
      ml_p1_func(var_2, var_0);
  }
}

ml_p1_func(var_0, var_1) {
  var_2 = undefined;
  var_3 = 1;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_0)) {
    if(issameweapon(var_0)) {
      var_2 = var_0;
      var_3 = self getweaponammoclip(var_2);
      var_4 = self getweaponammoclip(var_2, "_encstr_A5AD056A019C63");

      if(var_2.hasalternate) {
        var_6 = var_2 getaltweapon();

        if(!_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawn_crate_on_train(var_2, var_6))
          var_5 = self getweaponammoclip(var_6);
      }
    } else if(isstring(var_0)) {
      var_2 = relicsquadlink(var_0);

      if(isDefined(var_2))
        var_3 = var_2.clipsize;
      else if(isDefined(level.br_ammo_clipsize[var_0]))
        var_3 = level.br_ammo_clipsize[var_0];
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_7 = getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  var_8 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::weaponspawn(var_2, self, var_7, 0, 1);

  if(isDefined(var_8))
    _id_119F5(var_8, var_3, var_4, var_5);

  return var_8;
}

relicsquadlink(var_0) {
  var_1 = undefined;

  if(!isDefined(level.br_lootiteminfo) && !isDefined(level.br_lootiteminfo[var_0])) {
    return;
  }
  return level.br_lootiteminfo[var_0].playerstartjailsetcontrols;
}

_id_132F9(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_2 == "_encstr_A7ED0AD79F73990E28334B92" || var_2 == "_encstr_82200E7710825F228B4362D2DBEB8E1A" || var_2 == "_encstr_9A0D0C4B54606F8F63C84B8B53EE")
    return 0;

  if(var_2 == "_encstr_B1FD1078CA47B0A67257F7DDC70BE5991D62")
    return 0;

  if(!issameweapon(var_0))
    return 0;

  if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0")
    return 0;

  if(var_1 _encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::operatorsfxalias(var_0))
    return 0;

  return 1;
}

mintokensdropondeath(var_0, var_1, var_2, var_3) {
  var_4 = istrue(var_2) && isDefined(var_3);

  if(var_4) {
    var_5 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_3);

    if(isDefined(var_5)) {
      var_6 = undefined;

      if(istrue(var_1))
        var_6 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::removefromdismembermentlist();

      var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
      spawnpickup(var_5, var_7, 1, 1);
    }

    return;
  }

  if(isDefined(self.equipment["_encstr_BA7F0830B3A7859B60B0"])) {
    var_8 = scripts\mp\equipment::getequipmentslotammo("_encstr_BA7F0830B3A7859B60B0");

    if(var_8 > 0) {
      var_9 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["_encstr_BA7F0830B3A7859B60B0"]);

      if(isDefined(var_9)) {
        var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
        spawnpickup(var_9, var_7, var_8, 1);
      }
    }
  }

  if(isDefined(self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"])) {
    var_8 = scripts\mp\equipment::getequipmentslotammo("_encstr_AC8F0AE74163F85AAA380AD8");

    if(var_8 > 0) {
      var_9 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"]);

      if(isDefined(var_9)) {
        var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
        var_10 = spawnpickup(var_9, var_7, var_8, 1);

        if(isDefined(var_10))
          var_10 modeloadoutupdateammo(self, var_9);
      }
    }
  }
}

mix_loot_pickups(var_0, var_1, var_2, var_3) {
  var_4 = istrue(var_2) && isDefined(var_3);

  if(var_4) {
    var_5 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_3);

    if(isDefined(var_5)) {
      var_6 = undefined;

      if(istrue(var_1))
        var_6 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::removefromdismembermentlist();

      [var_8, var_9, var_10] = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
      spawnpickup(var_5, var_8, var_9, 1, 1, var_10);
    }

    return;
  }

  if(isDefined(self.equipment["_encstr_BEB406F03B72BB3B"])) {
    var_11 = int(max(scripts\mp\equipment::getequipmentslotammo("_encstr_BEB406F03B72BB3B"), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::roundnumber()));

    if(var_11 > 0) {
      var_3 = scripts\mp\supers::getcurrentsuperref();

      if(isDefined(var_3) && var_3 == "_encstr_91440DDF879B1B636071FBB97127EB") {
        if(!istrue(level.brjuggsettings))
          return;
      }

      dropequipmentinslot(var_0, "_encstr_BEB406F03B72BB3B", var_1, var_11);
    }
  }
}

missionparticipation(var_0) {
  if(isDefined(self.override_supply_drop_vfx) && isDefined(self.overridefieldupgrade2)) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_2 = spawnpickup(self.override_supply_drop_vfx, var_1, 1, 1);

    if(isDefined(var_2))
      var_2 _encstr_95383423288639018B079E98F2E8A8D910C93389D36A2397E9ADBF3D201532EB1343165DFF4BD0C93B8A4353F6D89389E865EA9F8363::controlslinked(self.overridefieldupgrade2);
  }
}

missedinfilplayerhandler(var_0) {
  var_1 = 0;
  var_2 = undefined;

  if(isDefined(self.equipment["_encstr_91B50734CA58631D1A"])) {
    var_2 = level.br_pickups.br_equipnametoscriptable[self.equipment["_encstr_91B50734CA58631D1A"]];
    var_1 = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
  } else if(istrue(level.playerismatchedplayerready)) {
    var_2 = level.br_pickups.br_equipnametoscriptable["_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D"];
    var_1 = level.playerismatchedplayerready;
  }

  if(istrue(level._id_11BF1) && var_1 < level._id_11BF1) {
    var_1 = level._id_11BF1;

    if(!isDefined(var_2))
      var_2 = level.br_pickups.br_equipnametoscriptable["_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D"];
  }

  if(var_1 > 0 && isDefined(var_2)) {
    if(var_1 > level.br_pickups.maxcounts[var_2]) {
      var_1 = var_1 - level.br_pickups.maxcounts[var_2];
      var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup(var_2, var_3, level.br_pickups.maxcounts[var_2], 1);
    }

    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup(var_2, var_3, var_1, 1);
  }
}

missed_shots(var_0) {
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_2 = spawnpickup(self.plundersilentcountdownendtime, var_1, int(self.gasmaskhealth), 1);

    if(isDefined(var_2))
      var_2.plunderpads = self.plunderpads;

    hangar_doors_opening_quadrace();
  }
}

missing_window_blockers(var_0, var_1, var_2, var_3) {
  var_4 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E07("_encstr_87C111C827BD838492D2A563D8B9D1C959166D", var_0, var_1, var_2, var_3);

  if(istrue(var_4)) {
    return;
  }
  var_5 = istrue(var_2) && isDefined(var_3);

  if(var_5) {
    var_6 = undefined;

    if(istrue(var_1))
      var_6 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::removefromdismembermentlist();

    var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
    spawnpickup(level.br_pickups.br_killstreaktoscriptable[var_3], var_7);
    return;
  }

  if(should_do_vo_call()) {
    var_6 = undefined;

    if(istrue(var_1))
      var_6 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::removefromdismembermentlist();

    var_7 = getitemdroporiginandangles(var_0, self.origin, self.angles, self, var_6);
    var_8 = spawnpickup(level.br_pickups.br_killstreaktoscriptable[self.streakdata.streaks[1].streakname], var_7);

    if(show_getcash_hint() && isDefined(self.spawnx1stashlootcache)) {
      var_8.spawnprojectile = self.spawnx1stashlootcache;
      self.spawnx1stashlootcache = undefined;
    }

    scripts\mp\killstreaks\killstreaks::removekillstreak(1);
  }
}

minshotstostage2acc(var_0, var_1) {
  if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_8D111B8B3FE5600941A3A37027198397E9B17F3D4026670443DAD7654A")) {
    var_2 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_1.currentweapon);
    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_3.scavengerammo = 1;
    spawnpickup(var_2, var_3, var_1.currentweapon.startammo, 1);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_813E1CBF280F48FBCF82B31AD9AB2EF1A6823B0FB2728037AB0A88C14233")) {
    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup("_encstr_8D3F0C9FA2EAE77B6F6B4010C36D", var_3, 1, 1);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_81801C0BB8F3EE9701115461A04933393BF88222B877A6EF9B8D46774593")) {
    var_3 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup("_encstr_BAAA0ABD2C0AE045718F4351", var_3, 1, 1);
  }

  if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_A5BF1E12877FE3CC02C4DCDA6F75C601A34347F8328768B7D6AB255036CF491B"))
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplunderbyrarity(100, var_0);
}

missions_clearinappropriaterewards(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_use_velo_forward()) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    var_2 = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
    spawnpickup("_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3", var_1, var_2);
    _id_12C16();
  }
}

play_hit_marker_to_player(var_0, var_1) {
  var_2 = var_0.tracknonoobplayerlocation;

  if(!isDefined(var_2))
    var_2 = var_0;

  var_3 = 0;

  if(isDefined(scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A")))
    var_3 = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
  else {
    br_forcegivecustompickupitem(self, "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69", 1, 0, 0);
    scripts\mp\equipment::setequipmentslotammo("_encstr_91B50734CA58631D1A", 0);
    var_3 = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
  }

  if(var_2.count > 0 && var_3 < scripts\mp\equipment::getequipmentmaxammo("_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D")) {
    if(var_2.count + var_3 <= scripts\mp\equipment::getequipmentmaxammo("_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D")) {
      scripts\mp\equipment::incrementequipmentslotammo("_encstr_91B50734CA58631D1A", var_2.count);

      if(!var_1)
        var_2.count = 0;
    } else {
      var_4 = var_2.count + var_3 - scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"]);
      var_5 = scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"]) - var_3;
      scripts\mp\equipment::incrementequipmentslotammo("_encstr_91B50734CA58631D1A", var_5);

      if(var_1) {
        if(getdvarint("_encstr_9A80147B570256FDFA87B10118B3C677DBC5C73BB9EF", 1) == 1) {
          var_6 = test_ai_anim();
          var_7 = getitemdroporiginandangles(var_6, self.origin, self.angles, self);
          spawnpickup("_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69", var_7, var_4, 1);
        }
      } else
        var_2.count = var_2.count - var_5;
    }
  }
}

minigun_turret_info(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss()) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup(self.armorylights, var_1);
    _id_12BFC();
  }
}

_encstr_BA9A122176A83013FDC07057F36897134302B383(var_0) {
  if(isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B) && isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"])) {
    for(var_1 = 0; var_1 < self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"]; var_1++) {
      var_2 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup("_encstr_A5A61D9E150D8818A357232312C369A51CD147C057EB28F5571AE763C1C87F", var_2);
    }

    self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_93A40EEA9928427A1D9F93AFE1C5328D"] = 0;
  }
}

_encstr_82A411080BF5D15BAF237EFD2CAF60A71BC2C0(var_0) {
  if(isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B) && isDefined(self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_8EFC0773D1789B9F39"])) {
    for(var_1 = 0; var_1 < self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_8EFC0773D1789B9F39"]; var_1++) {
      var_2 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup("_encstr_AFD81D2693C67BDBE87D46C97B0E382B91EB9B561B27598EEBE634B73BAC63", var_2);
    }

    self._encstr_A31917E66B58B163BE2DE61B589B8CD76DCACBD74BA3955B9B["_encstr_8EFC0773D1789B9F39"] = 0;
  }
}

mix(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldgetnewspawnpoint()) {
    var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
    spawnpickup("_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1", var_1);
    _id_12C1F();
  }
}

minsteps(var_0, var_1, var_2, var_3) {
  var_4 = istrue(var_3) && isDefined(var_0);

  if(var_4) {
    var_5 = undefined;

    if(istrue(var_2))
      var_5 = _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::removefromdismembermentlist();

    var_6 = test_ai_anim();
    var_7 = getitemdroporiginandangles(var_6, self.origin, self.angles, self, var_5);
    spawnpickup(var_0, var_7, var_1);
  }
}

modifycrushdamage(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    if(level.br_pickups.modifydamagetohunter) {
      var_1 = getitemdroporiginandangles(var_0, self.origin, self.angles, self);
      spawnpickup("_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537", var_1);
    }

    _id_12C26();
  }
}

mlgmodifyheadshotdamage(var_0) {
  if(isDefined(level.obit_activation) && isDefined(level.obit_activation.radio) && isDefined(level.obit_activation.radio.owner) && level.obit_activation.radio.owner == self)
    thread _encstr_81032C6ED8E4B41CA3CDCBAD0E979DB05B561D971C95375E98C9BE2C3647FA6BDEC8B2AF56E68D0B38955C76B9C6::mlgmodifyheadshotdamage(var_0);
  else
    thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A5BD111588FBF24D13EDD0390369D68E21572F", var_0);
}

modifydamagetoprop() {
  if(isDefined(level._id_12CE8) && isDefined(level._id_12CE8._id_13A17) && isDefined(level._id_12CE8._id_13A17.owner) && level._id_12CE8._id_13A17.owner == self)
    thread _encstr_A1AF2E47361A237BCB8BB657837A4F09550B0B3B90D06B98EE1A37F14AF8D595FFF98B3793980B7D71BA377AD280DAF6::modifydamagetoprop();
}

_encstr_976F13234EBD83B9B1C9AC2C5BAC3932953BD28D2B(var_0) {
  if(isDefined(level._id_11E18) && isDefined(level._id_11E18._id_12F3F) && isDefined(level._id_11E18._id_12F3F.owner) && level._id_11E18._id_12F3F.owner == self)
    thread _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::_encstr_AFDE0DC8937B0EE6C69CCA0BD62BC9(var_0);
}

ispickupstackable(var_0) {
  return istrue(level.br_pickups.stackable[var_0]);
}

isitemslotopen() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(!isDefined(self.br_inventory_slots[var_0]))
      return 1;
  }

  return 0;
}

isitemfull(var_0, var_1) {
  return var_1 + var_0.count > var_0.maxcount;
}

canstackpickup(var_0, var_1) {
  foreach(var_3 in self.br_inventory_slots) {
    if(isDefined(var_3.scriptablename) && var_3.scriptablename == var_0) {
      if(!isitemfull(var_3, var_1))
        return 1;
    }
  }

  return 0;
}

canslotitem(var_0, var_1) {
  if(ispickupstackable(var_0)) {
    if(canstackpickup(var_0, var_1))
      return 1;
  }

  return isitemslotopen();
}

getfirstopenslot() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(!isDefined(self.br_inventory_slots[var_0]))
      return var_0;
  }

  return -1;
}

pickupitemintoinventory(var_0) {
  if(ispickupstackable(var_0.scriptablename)) {
    if(canstackpickup(var_0.scriptablename, var_0.count)) {
      foreach(var_3, var_2 in self.br_inventory_slots) {
        if(isDefined(var_2.scriptablename) && var_2.scriptablename == var_0.scriptablename) {
          if(!isitemfull(var_2, var_0.count)) {
            var_2.count = var_2.count + var_0.count;
            var_2.count = int(min(var_2.count, var_0.maxcount));
            return;
          }
        }
      }
    }
  }

  var_4 = getfirstopenslot();

  if(var_4 == -1) {
    return;
  }
  self.br_inventory_slots[var_4] = var_0;
}

dropitemfrominventory(var_0) {
  if(isDefined(self.br_inventory_slots[var_0])) {
    var_1 = self.br_inventory_slots[var_0];
    var_2 = remove_roof_nodes(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
    var_3 = spawnpickup(var_1.scriptablename, var_2, var_1.count);

    if(isDefined(var_1.armorhealth))
      var_3.armorhealth = var_1.armorhealth;
    else if(isDefined(var_1.helmethealth))
      var_3.helmethealth = var_1.helmethealth;
    else if(isDefined(var_1.gasmaskhealth))
      var_3.gasmaskhealth = var_1.gasmaskhealth;

    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_lootdrop(self, var_1.scriptablename);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::removeitemfrominventory(var_0);
  }
}

useitemfrominventory(var_0) {
  if(isDefined(self.br_inventory_slots[var_0]))
    tryuseitemfrominventory(self.br_inventory_slots[var_0], var_0);
  else {}
}

_id_126E1(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AD6412D486A3F1ABD3307F19A39BADC1CFB0DDDB");

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A")) {
    return;
  }
  if(!isalive(self) || scripts\mp\utility\player::isusingremote() || istrue(self.isdeploying) || self.br_armorhealth >= self.br_maxarmorhealth) {
    return;
  }
  var_1 = self.equipment["_encstr_91B50734CA58631D1A"];
  var_2 = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
  var_3 = self.br_maxarmorhealth;
  var_4 = 1;

  if(isDefined(var_3) && var_0)
    var_4 = var_3;

  if(istrue(self.tracking_max_health)) {
    if(isDefined(self.cam) && get_axis_vehicles())
      self.cam = self.cam + var_4;
  } else {
    self.cam = var_4;

    if(isDefined(var_1) && isDefined(var_2) && var_2 > 0)
      thread scripts\mp\equipment\bandage::usequickslothealitem(var_1, var_2);
  }
}

get_axis_vehicles() {
  return !scripts\engine\utility::is_player_gamepad_enabled();
}

takegenericgrenadepickup(var_0) {
  var_1 = scripts\mp\equipment::getequipmentslotammo("_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(var_1) && var_1 < 2)
    scripts\mp\equipment::incrementequipmentslotammo("_encstr_BA7F0830B3A7859B60B0");

  var_1 = scripts\mp\equipment::getequipmentslotammo("_encstr_AC8F0AE74163F85AAA380AD8");

  if(isDefined(var_1) && var_1 < 2)
    scripts\mp\equipment::incrementequipmentslotammo("_encstr_AC8F0AE74163F85AAA380AD8");
}

trypickupitemfroment(var_0) {
  if(canslotitem(var_0.scriptablename, var_0.count))
    pickupitemintoinventory(var_0);
  else {
    self iprintlnbold("_encstr_A63D15F4E560D0F0BAE719B3D376CBF8EEFF784B0D9A30");
    self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
  }
}

trypickupitem(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(level.br_pickups.maxcounts[var_0]) || !isDefined(level.br_pickups.stackable[var_0])) {
    return;
  }
  var_2 = spawnStruct();
  var_2.scriptablename = var_0;
  var_2.count = var_1;
  var_2.maxcount = level.br_pickups.maxcounts[var_0];
  var_2.stackable = level.br_pickups.stackable[var_0];
  var_2.itemtype = level.br_pickups.br_itemtype[var_0];

  if(canslotitem(var_2.scriptablename, var_2.count))
    pickupitemintoinventory(var_2);
  else {
    self iprintlnbold("_encstr_A63D15F4E560D0F0BAE719B3D376CBF8EEFF784B0D9A30");
    self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
  }
}

tryequipmentfrominventory(var_0, var_1) {
  var_2 = level.br_pickups.br_equipname[var_0.scriptablename];
  var_3 = level.equipment.table[var_2].defaultslot;

  if(isDefined(self.equipment[var_3]) && self.equipment[var_3] == var_2) {
    if(equipmentslothasroom(var_2, var_3)) {
      scripts\mp\equipment::incrementequipmentslotammo(var_3, level.br_pickups.counts[var_0.scriptablename]);
      self.br_inventory_slots[var_1] = undefined;
    }
  } else if(!isDefined(self.equipment[var_3]) || scripts\mp\equipment::getequipmentslotammo(var_3) == 0) {
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::setequipmentslotammo(var_3, var_0.count);
    self.br_inventory_slots[var_1] = undefined;
  } else {
    var_4 = self.equipment[var_3];
    var_5 = scripts\mp\equipment::getequipmentslotammo(var_3);
    scripts\mp\equipment::giveequipment(var_2, var_3);
    scripts\mp\equipment::setequipmentslotammo(var_3, var_0.count);
    self.br_inventory_slots[var_1] = undefined;
    var_6 = level.br_pickups.br_equipnametoscriptable[var_4];
    trypickupitem(var_6, var_5);
  }
}

droparmor(var_0, var_1) {
  var_2 = remove_roof_nodes(self.origin + level.br_pickups.br_dropoffsets[0], self.angles);
  var_3 = spawnpickup(var_0, var_2);
  var_3.count = 1;
  var_3.helmethealth = 0;
  var_3.armorhealth = 0;
  var_3.gasmaskhealth = 0;

  if(issubstr(var_0, "_encstr_A6CC076A05751852B3")) {
    var_3.helmethealth = var_1;

    if(var_0 == "_encstr_87E1162627B1BDDBE8D72C9CDABDE4FA345663D6591DEB99")
      scripts\mp\utility\perk::removeperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA");
  }

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_lootdrop(self, var_0);
}

trydroparmorfornewarmor(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::ishelmet(var_0)) {
    if(isDefined(self.br_helmetlevel)) {
      var_1 = _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::helmetitemtypeforlevel(self.br_helmetlevel);

      if(isDefined(var_1))
        droparmor(var_1, self.br_helmethealth);
    }
  }
}

tryequiparmor(var_0, var_1) {
  if(isDefined(var_1))
    self.br_inventory_slots[var_1] = undefined;

  trydroparmorfornewarmor(var_0.scriptablename);

  if(var_0.scriptablename == "_encstr_82E116229E8558408BD1E3FB551D182FA8EDB89577A05FBA")
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::takehelmet(var_0, 1);
  else if(var_0.scriptablename == "_encstr_96E116CE235227BA3B27F6D8806ACABF8B6D612A672CD9A3")
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::takehelmet(var_0, 2);
  else if(var_0.scriptablename == "_encstr_87E1162627B1BDDBE8D72C9CDABDE4FA345663D6591DEB99")
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::takehelmet(var_0, 3);
}

tryuseitemfrominventory(var_0, var_1) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isequipment(var_0.scriptablename))
    tryequipmentfrominventory(var_0, var_1);
}

initpickupusability() {
  scripts\common\interactive::interactive_addusedcallback(::brpickupsusecallback, "_encstr_9B990BA22539DA6F7EB88BE383");
}

brpickupsusecallback(var_0, var_1) {
  var_2 = var_1 cantakepickup(var_0);
  var_1 showuseresultsfeedback(var_2);

  if(var_2 != 1) {
    return;
  }
  var_1 onusecompleted(var_0);
  lastunrulyscore(var_0);

  if(var_0 isscriptable())
    var_0 freescriptable();
  else
    var_0 delete();
}

setup_train_array(var_0, var_1) {
  if(isDefined(self.equipment[var_1]) && scripts\mp\equipment::getequipmentslotammo(var_1) > 0) {
    var_2 = test_ai_anim();
    dropequipmentinslot(var_2, var_1);
  }

  scripts\mp\equipment::giveequipment(var_0, var_1);
  scripts\mp\equipment::setequipmentammo(var_0, 1);
}

_id_1398A(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !level.allowsupers)
    var_0 scripts\mp\equipment::takeequipment("_encstr_BEB406F03B72BB3B");
}

hangar_doors_opening_quadrace() {
  if(istrue(self.gasmaskequipped)) {
    self detach("_encstr_AB5F1FC0DA1B68D8A4D16961FF8C804DD743BEA922EFA090BEA36F1FFF35A906D3", "_encstr_AADA07DBF19A4A81D7");
    self.gasmaskequipped = 0;
  }

  self.gasmaskswapinprogress = 0;
  handleweaponreloadammodrop();
}

handleweaponreloadammodrop() {
  self.plunderpads = undefined;
  self.gasmaskhealth = undefined;
  self.plunderrepositorywidget = undefined;
  self.plundermusicthird = 0;
  self setclientomnvar("_encstr_97B00C57D27DD92C6EFAB5859BDA", 0);
  self setclientomnvar("_encstr_A55C145862212951876CA0A551FF18A1996A0870BB42", 0);
  self setclientomnvar("_encstr_A2E4127B2D80AF6EA09B29238F9977FF31B9D2E2", 0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_886A17607773632913E797DB3201D7B05BF8132D27F36E2E07(0);
}

riotshieldtaken(var_0) {
  var_1 = "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
  var_2 = level.br_pickups.br_equipname[var_1];
  var_3 = level.equipment.table[var_2].defaultslot;

  if(isDefined(self.equipment[var_3])) {
    var_4 = scripts\mp\equipment::getequipmentslotammo(var_3);

    if(var_4 > 0) {
      if(istrue(var_0))
        return var_4;
      else
        return 1;
    }
  }

  return 0;
}

riotshieldswitchaway(var_0, var_1) {
  var_2 = self.br_ammo[var_0];
  var_3 = level.br_ammo_clipsize[var_0];

  if(!isDefined(var_2) || !isDefined(var_3))
    return 0;

  if(istrue(var_1))
    return int(var_2);

  return int(min(var_3, var_2));
}

risk_currentflagstier(var_0) {
  var_1 = 5;

  if(istrue(var_0))
    return int(self.plundercount);

  return int(min(self.plundercount, var_1));
}

riotshieldswitchawaytimer(var_0) {
  switch (var_0) {
    case 5:
      return "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
    case 7:
      return "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
    case 9:
      return "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6";
    case 6:
      return "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";
    case 8:
      return "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014";
    default:
  }
}

risk_currentlocsinuse(var_0) {
  var_1 = self.lastdroppableweaponobj;
  var_2 = createheadicon(var_1);
  return var_2;
}

risk_currentflagsactive(var_0, var_1) {
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = undefined;

  switch (var_0) {
    case 3:
      var_3 = int(self.gasmaskhealth);
      var_2 = scripts\cp_mp\gasmask::hasgasmask(self) && !istrue(self.plundermusicthird);
      break;
    case 4:
      var_3 = riotshieldtaken(var_1);
      var_2 = var_3 > 0;
      break;
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      var_7 = riotshieldswitchawaytimer(var_0);
      var_3 = riotshieldswitchaway(var_7, var_1);
      var_2 = var_3 > 0;
      break;
    case 0:
      if(istrue(self.iszombie)) {
        var_2 = 0;
        break;
      }

      var_3 = risk_currentflagstier(var_1);
      var_2 = var_3 > 0;
      break;
    case 1:
      var_3 = scripts\engine\utility::ter_op(istrue(self.hasrespawntoken), 1, 0);
      var_2 = var_3 > 0;
      break;
    case 2:
      var_3 = scripts\engine\utility::ter_op(istrue(self.shouldgetnewspawnpoint), 1, 0);
      var_2 = var_3 > 0;
      break;
    case 10:
      var_8 = self.lastdroppableweaponobj;

      if(!isDefined(var_8) || nullweapon(var_8) || !self hasweapon(var_8) || var_8 == getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") || self isskydiving() || istrue(self.usingascender))
        var_2 = 0;
      else {
        var_3 = self getweaponammoclip(var_8);
        var_4 = self getweaponammoclip(var_8, "_encstr_A5AD056A019C63");

        if(var_8.hasalternate) {
          var_9 = var_8 getaltweapon();

          if(!_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawn_crate_on_train(var_8, var_9))
            var_5 = self getweaponammoclip(var_9);
        }

        var_6 = var_8;
      }

      break;
    default:
      var_2 = 0;
      break;
  }

  return [var_2, var_3, var_4, var_5, var_6];
}

_id_12993(var_0, var_1) {
  var_2 = "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
  var_3 = level.br_pickups.br_equipname[var_2];
  var_4 = level.equipment.table[var_3].defaultslot;
  scripts\mp\equipment::decrementequipmentslotammo(var_4, var_1);

  if(istrue(self.tracking_max_health)) {
    var_5 = scripts\mp\equipment::getcurrentequipment(var_4);
    var_6 = scripts\mp\equipment::getequipmentammo(var_5);

    if(var_6 < 1)
      self notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");
  }
}

_id_12992(var_0, var_1) {
  var_2 = riotshieldswitchawaytimer(var_0);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_take_type(self, var_2, var_1);
}

_id_12995(var_0, var_1) {
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1261E(var_1);
}

_id_12996(var_0, var_1) {
  removerespawntoken();
}

_id_12997(var_0, var_1) {
  _id_12C1F();
}

_id_12998(var_0, var_1) {
  var_2 = self.lastdroppableweaponobj;
  var_3 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  var_4 = var_3;
  var_5 = self getweaponslistprimaries();

  foreach(var_7 in var_5) {
    if(var_7.inventorytype != "_encstr_BA7F0830B3A7859B60B0") {
      continue;
    }
    if(var_7 != var_3 && var_7 != var_2 && !scripts\mp\utility\weapon::update_health_bar_to_player(var_7)) {
      var_4 = var_7;
      break;
    }
  }

  if(!scripts\mp\riotshield::isriotshield(var_2)) {
    var_9 = self getweaponammostock(var_2);
    var_10 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_2);

    if(isDefined(var_10))
      self.br_ammo[var_10] = var_9;
  }

  if(scripts\mp\utility\weapon::update_health_on_spawn(var_2))
    self notify("_encstr_A66D1055FA9281533DC3B1289F5E08D75B65");

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264D();

  if(!self hasweapon(var_3))
    self giveweapon(var_3);

  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
  self switchtoweaponimmediate(var_4);
  scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
  generatespawnpoint();
}

_id_12994(var_0, var_1) {
  switch (var_0) {
    case 3:
      if(!istrue(self.plundermusicthird)) {
        self.plundermusicthird = 1;
        thread _id_12C05();
      }

      break;
    case 4:
      _id_12993(var_0, var_1);
      break;
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      _id_12992(var_0, var_1);
      break;
    case 0:
      _id_12995(var_0, var_1);
      break;
    case 1:
      _id_12996(var_0, var_1);
      break;
    case 2:
      _id_12997(var_0, var_1);
      break;
    case 10:
      _id_12998(var_0, var_1);
      break;
    default:
      return;
  }
}

_id_1298E(var_0, var_1) {
  switch (var_0) {
    case 3:
      return self.plundersilentcountdownendtime;
    case 4:
      return "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      return riotshieldswitchawaytimer(var_0);
    case 0:
      for(var_2 = level.br_plunder._id_12954.size - 1; var_2 >= 0; var_2--) {
        if(var_1 > level.br_plunder._id_12954[var_2])
          return level.br_plunder.names[var_2];
      }

      return level.br_plunder.names[0];
    case 2:
      return "_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1";
    case 1:
      return "_encstr_92DD158AA878E89FF1F87E0B1F6B1EDFD5011DC78C6D38";
    case 10:
      return risk_currentlocsinuse(var_0);
    default:
  }
}

_id_1298C() {
  var_0 = 120;
  self notify("_encstr_97B11617EAA5D86D8893BDC11A1B56C273BAC134586C8656");
  self endon("_encstr_97B11617EAA5D86D8893BDC11A1B56C273BAC134586C8656");
  wait(var_0);
  self._id_12989 = undefined;
}

_id_12986(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_12989))
    self._id_12989 = [];

  var_5 = spawnStruct();
  var_5.vehicle_collision_updateinstanceend = var_0;
  var_5.slot = var_1;
  var_5.ent = var_2;
  var_5.moderemovefromteamlives = var_3;
  var_5.minigun_wait_between_shots = var_4;
  var_5._id_1260B = self.origin;
  var_5._id_126F7 = self.angles[1];
  self._id_12989[self._id_12989.size] = var_5;
  thread _id_1298C();
}

_id_1298B(var_0) {
  var_1 = 60.0;
  var_2 = squared(var_1);
  var_3 = 45.0;
  var_4 = distancesquared(self.origin, var_0._id_1260B);

  if(var_4 > var_2)
    return 0;

  var_5 = abs(self.angles[1] - var_0._id_126F7);

  if(var_5 > var_3)
    return 0;

  return 1;
}

_id_1298D(var_0) {
  if(!isDefined(self._id_12989)) {
    return;
  }
  foreach(var_2 in self._id_12989) {
    if(isDefined(var_2.ent) && var_2.vehicle_collision_updateinstanceend == var_0) {
      if(!_id_1298B(var_2)) {
        continue;
      }
      return var_2;
    }
  }
}

_id_1298A() {
  if(!isDefined(self._id_12989))
    return 0;

  var_0 = [];

  foreach(var_2 in self._id_12989) {
    if(isDefined(var_2.ent)) {
      if(!_id_1298B(var_2)) {
        continue;
      }
      var_0[var_2.slot] = 1;
    }
  }

  var_4 = undefined;
  var_5 = 0;
  var_6 = 0;
  var_7 = [0, 13, 1];

  for(;;) {
    var_4 = var_6 * 14 + var_7[var_5];

    if(!istrue(var_0[var_4])) {
      break;
    }

    var_5++;

    if(var_5 >= var_7.size) {
      var_5 = 0;
      var_6++;
    }
  }

  return var_4;
}

_id_12991(var_0, var_1, var_2) {
  var_3 = undefined;

  switch (var_0) {
    case 3:
      var_3 = "_encstr_A5021E1327BE4BB9D92BCD477BC95E7D32E47B0E7DCD2B3633EB9CB2ECB49D56";
      break;
    case 4:
      var_3 = "_encstr_A54E18F19BC703C033CD7D71FF1AB0C0F373A83BD197C6800DB2";
      break;
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      var_3 = "_encstr_A198177236E6AF9DEDD012AB983D90BF399EF7F8D849E765F7";
      break;
    case 0:
      if(var_2 == "_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922")
        var_3 = "_encstr_A3D31D13E4FAB49BCE959B3ABDC9CBAF8C93B70ED7E063AB9B23B2C97DDCB6";
      else if(var_2 == "_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996")
        var_3 = "_encstr_A3D31D13E4FAB49BCE959B3ABDC9CBAF8C93B70ED7E063AB9B23B2C97DDCB6";
      else if(var_2 == "_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC")
        var_3 = "_encstr_A3D31D13E4FAB49BCE959B3ABDC9CBAF8C93B70ED7E063AB9B23B2C97DDCB6";
      else if(var_2 == "_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A")
        var_3 = "_encstr_8DFA1E3280AF54B3CB4D96845093371171386A8B81894D97E025659A60180F67";
      else if(var_2 == "_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3")
        var_3 = "_encstr_8DFA1E3280AF54B3CB4D96845093371171386A8B81894D97E025659A60180F67";
      else if(var_2 == "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926")
        var_3 = "_encstr_B1FA1E432D6852AE081935BB7093F1895D85EF838F27CA8D9041EF026E082242";
      else if(var_2 == "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2")
        var_3 = "_encstr_B1FA1E432D6852AE081935BB7093F1895D85EF838F27CA8D9041EF026E082242";
      else if(var_2 == "_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72")
        var_3 = "_encstr_AD0524C493FAA5CDCE599B3ADEC9977D19C9ED83F5C1C6AEB94695E4F5CAF0D1C90BBE3693B3";
      else
        var_3 = "_encstr_A3D31D13E4FAB49BCE959B3ABDC9CBAF8C93B70ED7E063AB9B23B2C97DDCB6";

      break;
    case 1:
      break;
    case 2:
      var_3 = "_encstr_A5021E1327BE4BB9D92BCD477BC95E7D32E47B0E7DCD2B3633EB9CB2ECB49D56";
      break;
    case 10:
      var_3 = "_encstr_86321712A08F7493EBAD7664B0B3173111584AAB61672FE743";
      break;
    default:
  }

  if(isDefined(var_3))
    playsoundatpos(var_1, var_3);
}

_id_12987(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_1298D(var_0);

  if(isDefined(var_5)) {
    var_6 = var_5.ent;
    var_7 = var_5.moderemovefromteamlives;
    var_8 = var_5.minigun_wait_between_shots;
    var_9 = _id_119ED(var_6);
    var_10 = _id_119EF(var_6);
    var_11 = _id_119EE(var_6);

    if(!ispickupstackable(var_5.ent.type) && !issubstr(var_5.ent.type, "_encstr_ACDF0647ABFB2EF9"))
      return 0;

    var_12 = undefined;

    if(isDefined(var_6.set_force_aitype_armored))
      var_12 = var_6.set_force_aitype_armored;

    var_13 = var_9 + var_1;
    var_14 = var_10 + var_2;
    var_15 = var_11 + var_3;
    var_16 = _id_1298E(var_0, var_13);
    var_17 = getscriptablereservedremaining(var_7 + (0, 0, 12), var_7);
    var_18 = remove_roof_nodes(var_7, var_8, var_17, var_12);
    var_19 = spawnpickup(var_16, var_18, var_13, 1, var_4, 0, var_14, var_15);

    if(istrue(level._encstr_811920E0AC66133323D8D948B379526B1ED2EB3927E8156FF9E75FF16812787A05AD))
      level notify("_encstr_A35F17CBA5903B5128407B02FE4074A251675B7377AF831578", var_19, self);

    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_lootdrop(self, var_16, undefined, var_1);

    if(isDefined(var_4))
      level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_19, self, var_4);

    _id_12991(var_0, var_7, var_16);
    var_5.ent = var_19;
    thread _id_1298C();
    lastunrulyscore(var_6);

    if(isent(var_6))
      var_6 delete();
    else
      var_6 freescriptable();

    return 1;
  }

  return 0;
}

_id_12990(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_1298E(var_0, var_1);

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = _id_1298A();
  var_7 = test_ai_anim();
  var_7.ml_p3_to_safehouse_transition = var_6;
  var_8 = getitemdroporiginandangles(var_7, self.origin, self.angles, self);
  var_9 = isgasmask(var_5);
  var_10 = _encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::operatorsfxalias(var_4);
  var_11 = get_base_focus_fire_multipler(var_4);

  if(!var_10 && var_11) {
    if(var_9 && istrue(self.gasmaskswapinprogress)) {
      scripts\engine\utility::waittill_notify_or_timeout("_encstr_B80A17578188F1900632FBB19027E38BA74F875D0BA57FF39F", 2.0);
      waitframe();
    }

    var_12 = spawnpickup(var_5, var_8, var_1, 1, var_4, 0, var_2, var_3);

    if(var_9 && isDefined(var_12))
      var_12.plunderpads = self.plunderpads;

    if(istrue(level._encstr_811920E0AC66133323D8D948B379526B1ED2EB3927E8156FF9E75FF16812787A05AD))
      level notify("_encstr_A35F17CBA5903B5128407B02FE4074A251675B7377AF831578", var_12, self);

    _id_12986(var_0, var_6, var_12, var_8.origin, var_8.angles);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_lootdrop(self, var_5, undefined, var_1);

    if(isDefined(var_4))
      level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_12, self, var_4);
  }

  _id_12991(var_0, var_8.origin, var_5);

  if(var_9)
    hangar_doors_opening_quadrace();
}

get_base_focus_fire_multipler(var_0) {
  if(scripts\mp\utility\weapon::unset_jugg_ignoreall_after_notify(var_0))
    return 0;

  return 1;
}

_id_1298F(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  setuproundstarthud(var_0);
  [var_2, var_3, var_4, var_5, var_6] = risk_currentflagsactive(var_0);

  if(!var_2) {
    return;
  }
  _id_12994(var_0, var_3);
  scripts\mp\class::disableclassswapallowed();
  var_7 = _id_12987(var_0, var_3, var_4, var_5, var_6);

  if(var_7) {
    return;
  }
  _id_12990(var_0, var_3, var_4, var_5, var_6);
}

_id_12988(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  setuproundstarthud(var_0);
  var_1 = 1;
  [var_3, var_4, var_5, var_6, var_7] = risk_currentflagsactive(var_0, 1);

  if(!var_3) {
    return;
  }
  _id_12994(var_0, var_4);
  scripts\mp\class::disableclassswapallowed();
  var_8 = _id_12987(var_0, var_4, var_5, var_6, var_7);

  if(!var_8)
    _id_12990(var_0, var_4, var_5, var_6, var_7);

  if(isDefined(level._id_1207B))
    [[level._id_1207B]](self);
}

gethighestscore(var_0) {
  switch (var_0) {
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
      return 1;
    default:
      return 0;
  }
}

setuproundstarthud(var_0) {
  if(gethighestscore(var_0)) {
    var_1 = undefined;

    while(self isreloading()) {
      if(!istrue(var_1)) {
        var_1 = 1;
        self disableautoreload();
      }

      self cancelreload();
      waitframe();
    }

    if(istrue(var_1))
      self enableautoreload();

    waitframe();
  }
}

dangercircletick(var_0, var_1) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_8EAD05E157ED90")) {
    return;
  }
  var_2 = var_1 * var_1;
  var_3 = level.br_circle.circleindex;

  if(var_3 > level.br_circle.damagetick.size - 1)
    var_3 = level.br_circle.damagetick.size - 1;

  var_4 = level.br_circle.damagetick[var_3];

  if(isDefined(level.circledamagemultiplier))
    var_4 = var_4 * level.circledamagemultiplier;

  level.br_pickups.modetype = scripts\engine\utility::array_removeundefined(level.br_pickups.modetype);

  for(var_5 = level.br_pickups.modetype.size - 1; var_5 >= 0; var_5--) {
    var_6 = level.br_pickups.modetype[var_5];

    if(distance2dsquared(var_6.origin, var_0) > var_2) {
      var_7 = var_6.count;
      var_8 = int(var_7 - var_4);

      if(var_8 <= 0) {
        var_6 setscriptablepartstate(var_6.type, "_encstr_AD75063D571AE108");
        var_6 lastgunkilltime(1.0);
        level thread lastunruly(var_5);
      } else {
        if(var_6 scripts\cp_mp\gasmask::lights_setup_plane(var_7, var_8))
          var_6 setscriptablepartstate(var_6.type, "_encstr_B2BE0788BAF573592F");

        _id_119F5(var_6, var_8);
      }
    }
  }
}

plundermusicfirst() {
  level.br_pickups.modetype[level.br_pickups.modetype.size] = self;
}

lastunruly(var_0) {
  waittillframeend;

  if(isDefined(level.br_pickups.modetype))
    level.br_pickups.modetype[var_0] = undefined;
}

toppercentagetoadjusteconomy() {
  var_0 = level.br_pickups;
  var_0.scriptables = [];
  var_0._id_12F7C = 0;
  var_0._id_12F7A = 0;
  var_0._id_12F7B = removestuckenemyondeathordisconnect();
  var_0._id_12F79 = getdvarint("_encstr_B8DC290327C3F9D68527FBC2564728E33AC65BF030A3D1DDD89FB7EB30B206A2AFC836DF9987219761E093", 10);
}

removestuckenemyondeathordisconnect() {
  var_0 = _func_0434();
  var_1 = getdvarint("_encstr_B8A615C0C63A895A6E2973F74810B7BFD8CF72F2BB62FD", 0);

  if(var_1 > 0 && var_1 < var_0)
    var_2 = var_1;
  else {
    var_3 = getdvarint("_encstr_87750A3D9EA82A699EA24953", 150);
    var_4 = getdvarint("_encstr_820F192BEE786F0A5209C0D798E076133C02D38DA0F72055411DA2", 5);
    var_2 = var_3 * var_4;
  }

  if(var_2 > var_0)
    var_2 = int(var_0 / 2);

  return var_2;
}

_id_12B3A(var_0) {
  var_1 = level.br_pickups._id_12F7A;
  var_0.embassy_main = var_1;
  level.br_pickups.scriptables[var_1] = var_0;
  level.br_pickups._id_12F7A++;
}

lastunrulyscore(var_0) {
  level.br_pickups.scriptables[var_0.embassy_main] = undefined;
  var_0.embassy_main = undefined;
}

heardparachuteoverheadtime() {
  var_0 = level.br_pickups;

  if(var_0.scriptables.size < var_0._id_12F7B && enabledismembermenttag() > 0) {
    return;
  }
  var_1 = 0;

  for(var_2 = var_0._id_12F7C; var_2 < var_0._id_12F7A; var_2++) {
    if(var_1 == var_0._id_12F79) {
      break;
    }

    var_3 = var_0.scriptables[var_2];

    if(isDefined(var_3)) {
      if(istrue(var_3.init_weapon_placements)) {
        continue;
      }
      foreach(var_5 in level.br_pickups._encstr_9BBE191AA36BB5ABC5F1E27ADB266BEED81B8391D970BEBFFE084B)
      var_3[[var_5]]();

      var_0.scriptables[var_2] = undefined;

      if(isent(var_3))
        var_3 delete();
      else
        var_3 freescriptable();

      var_1++;
    } else
      var_0.scriptables[var_2] = undefined;

    var_0._id_12F7C++;
  }
}

lastgoodjobplayer() {
  lastunrulyscore(self);

  if(isent(self))
    self delete();
  else
    self freescriptable();
}

lastgunkilltime(var_0) {
  thread lastheatupdate(var_0);
}

lastheatupdate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);

  if(isDefined(self))
    lastgoodjobplayer();
}

_id_12B3F(var_0, var_1) {
  while(!isDefined(level.br_pickups))
    waitframe();

  level.br_pickups._id_13F09["_encstr_A51F10D7F040F33DE024777513F89DE76B27" + var_0] = var_1;
}

_id_128B5(var_0, var_1) {
  if(isDefined([[level.br_pickups._id_13F09[var_0]]](var_1)))
    return;
  else {}
}

_id_11AAC() {
  thread _id_14484();
  thread _id_144EF();
  thread _id_144E7();
}

calculateaveragevelocities() {
  self.playerstreakspeedscale = scripts\mp\juggernaut::jugg_getmovespeedscalar();
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\playeractions::allowactionset("_encstr_BD2C09BF097845B8ADDF97", 0);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(0, "_encstr_BD2C09BF097845B8ADDF97");
    scripts\common\utility::allow_mount_side(0, "_encstr_BD2C09BF097845B8ADDF97");
  }
}

_id_12C12() {
  self.playerstreakspeedscale = undefined;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\mp\playeractions::allowactionset("_encstr_BD2C09BF097845B8ADDF97", 1);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(1, "_encstr_BD2C09BF097845B8ADDF97");
    scripts\common\utility::allow_mount_side(1, "_encstr_BD2C09BF097845B8ADDF97");
  }
}

_id_14484() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A66D1055FA9281533DC3B1289F5E08D75B65");
  self endon("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_97EA14CDBBD2A3D834B2C87DA3F6D7B65AB94BCEEAE6");
    calculateaveragevelocities();
  }
}

_id_144EF() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143B5("_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37", "_encstr_A66D1055FA9281533DC3B1289F5E08D75B65", "_encstr_AD75063D571AE108");

    if(isDefined(var_0)) {
      _id_12C12();

      if(var_0 == "_encstr_A66D1055FA9281533DC3B1289F5E08D75B65" || var_0 == "_encstr_AD75063D571AE108") {
        break;
      }
    }
  }
}

_id_144E7() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A66D1055FA9281533DC3B1289F5E08D75B65");
  self endon("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  for(;;) {
    if(!scripts\mp\utility\weapon::update_health_on_spawn(self getcurrentweapon())) {
      if(istrue(var_0)) {
        var_0 = 0;
        self notify("_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37");
      }
    } else if(!istrue(var_0)) {
      var_0 = 1;
      self notify("_encstr_97EA14CDBBD2A3D834B2C87DA3F6D7B65AB94BCEEAE6");
    }

    waitframe();
  }
}

make_chair_ai_spawner(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(self.streakdata))
    return 0;

  if(!isDefined(self.streakdata.streaks) || !isDefined(self.streakdata.streaks[1]))
    return 0;

  var_1 = self.streakdata.streaks[1];

  if(!isDefined(var_0.streakname) || !isDefined(var_1.streakname) || var_0.streakname != var_1.streakname)
    return 0;

  if(!isDefined(var_0.id) || !isDefined(var_1.uniqueid) || var_0.id != var_1.uniqueid)
    return 0;

  return 1;
}

addspawnlocation() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_A7AA11C616DCD8561BE933990DB09BC81422D4");
  self endon("_encstr_A7AA11C616DCD8561BE933990DB09BC81422D4");
  self notify("_encstr_BDC410ED3399D0167346AF2C239BEBBD99CC");
  wait 0.5;
  self notify("_encstr_BDC410ED3399D0167346AF2C239BEBBD99CC");
}

generatespawnpoint() {
  thread addspawnlocation();
}

_encstr_92A90F7F75A4CB6073684EBB5013070F13() {
  var_0 = getDvar("_encstr_A9F30BA9494AC9896A96984531");
  var_1 = strtok(var_0, "_encstr_854C0289");
  var_1 = scripts\engine\utility::array_add(var_1, "_encstr_91D20888978AABF71F0B");
  return var_1;
}