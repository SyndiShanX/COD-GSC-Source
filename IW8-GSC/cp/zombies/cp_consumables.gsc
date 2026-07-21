/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\zombies\cp_consumables.gsc
***********************************************/

init_consumables() {
  level.consumables = [];
  setup_irish_luck_consumables();
  parse_consumables_table();
}

setup_irish_luck_consumables() {
  level.irish_luck_consumables = [];
  level.irish_luck_consumables["_encstr_9B5E111C32FA7589C40F69903F17E0A9A29B37"] = [];
  level.irish_luck_consumables["_encstr_AC3D1648D38E37109F9A5DC66F8F5BE9F94B4B282AA57FCB"] = [];
  level.irish_luck_consumables["_encstr_83430BEE958D98E799AF7530C3"] = [];
  level.irish_luck_consumables["_encstr_97F01C80A26A51110B97FB65815B7BD1D93B2B3B1AC5CF2B5BD7FE6F9C87"] = [];
  level.irish_luck_consumables["_encstr_958E14CD9BD23859C9D7E6ED333A7DD5C13B9C584656"] = [];
  level.irish_luck_consumables["_encstr_B4E615F1A3E3DA0E5E9B0D2B4280A537111B981A70E99F"] = [];
  level.irish_luck_consumables["_encstr_A96514E6347B36B57DB6563695B2FAD538EC39C223AC"] = [];
  level.irish_luck_consumables["_encstr_8C9210A7C77A531BE20F2030CF06B69F13AD"] = [];
  level.irish_luck_consumables["_encstr_B4DD1D96B8CD436BF623AF8730A935A9B740518D175F8BBFB9A0938B78E3FB"] = [];
  level.irish_luck_consumables["_encstr_97DB17C2EDB99209E189EB07E0B9C7FA07734D3ECEC30A43E9"] = [];
  level.irish_luck_consumables["_encstr_851110790F428E41A29BE23E428DC045EA8B"] = [];
  level.irish_luck_consumables["_encstr_8FB11633C2E68ECA9CD7EED23732B7DDAF2795C4F6164E23"] = [];
  level.irish_luck_consumables["_encstr_B667130DAC85326E86F6A3F595F08363F6DCD2F6E6"] = [];
  level.irish_luck_consumables["_encstr_AB821732681663F7B85FA5AC6FB0BF434DA1E96A11F9E7AFA0"] = [];
  level.irish_luck_consumables["_encstr_BAFA16E6431627077DB943DBF6E895C9FAD538EC9CC2462B"] = [];
  level.irish_luck_consumables["_encstr_BAF513CD0E58DD9BAFC8ED57268DACEBADF637B22F"] = [];
  level.irish_luck_consumables["_encstr_A7011211786BF78B527BAA3998DFEB3759153AFA"] = [];
  level.irish_luck_consumables["_encstr_BEB30D072068E51A652502711C5322"] = [];
  level.irish_luck_consumables["_encstr_87D00789A1BE3B57CD"] = [];
  level.irish_luck_consumables["_encstr_846C096CB158EEBEEC5DCD"] = [];
  level.irish_luck_consumables["_encstr_A2E31799280B0B281DF94E0A757BD5BFFB8F45B01FF8DA3D20"] = [];
  level.irish_luck_consumables["_encstr_8F3010BBD79A41EBE8C7D091AB3DC09F223F"] = [];
  level.irish_luck_consumables["_encstr_8AC61310ABD8A94B356382BB29AF6FDAE8059164DB"] = [];
  level.irish_luck_consumables["_encstr_AD410DB55A6363D2CDCEF547B4B5B2"] = [];
  level.irish_luck_consumables["_encstr_A60D1483231FDF86F84007C5BBC0932F062A10771823"] = [];
  level.irish_luck_consumables["_encstr_83BD143B7F699FA58778CA4250CD5C2B4170B1AD1970"] = [];
  level.irish_luck_consumables["_encstr_874010977036D0501FCA982303BF9A680D64"] = [];
  level.irish_luck_consumables["_encstr_85460FD341A87B13AF18AA43266757B580"] = [];
  level.irish_luck_consumables["_encstr_881D0B3738B0BB37FAE6D5ADB2"] = [];
  level.irish_luck_consumables["_encstr_BEF80B4F27629151C06D536952"] = [];
  level.irish_luck_consumables["_encstr_87DC162A7032E9DF5D5A4151F93218E1276A20E7E5C3AB58"] = [];
  level.irish_luck_consumables["_encstr_938F0F1A69D8B2EA8D0F67377DB4121B40"] = [];
  level.irish_luck_consumables["_encstr_93680AB1B0733AAF5B5ACD6E"] = [];
  level.irish_luck_consumables["_encstr_B16910F7D302AC687FBF2D7B6717C8EFAAEF"] = [];
  level.irish_luck_consumables["_encstr_951B0CF0FD63500F33F3685B736A"] = [];
  level.irish_luck_consumables["_encstr_8E7D134D5DDCE8BEB07D33B1AC9B0DEBBBF6AE3723"] = [];
  level.irish_luck_consumables["_encstr_8369168308625705CEFF93A723B075D27F936FC74D913383"] = [];
  level.irish_luck_consumables["_encstr_96CD13B92B3C1DFAC1D527B186C2DC2BF599279559"] = [];
  level.irish_luck_consumables["_encstr_92900A6849A67F76D049E301"] = [];
  level.irish_luck_consumables["_encstr_97D614DFD1BFFBAB9968C830ABD5819B901F35367959"] = [];
  level.irish_luck_consumables["_encstr_87570DB9E859ACC6EB8CC98576F673"] = [];
  level.irish_luck_consumables_gotten = [];
}

parse_consumables_table() {
  if(isDefined(level.consumable_table))
    var_0 = level.consumable_table;
  else
    var_0 = "_encstr_AC022E3369B788A087D3B00317BB01B845D54B241DF4F03BCA58903BEBD048B2B740DFDDA3104A612753471B9E8F6B6C";

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 6);
    var_4 = int(tablelookupbyrow(var_0, var_1, 7));
    var_5 = int(tablelookupbyrow(var_0, var_1, 8));
    var_6 = int(tablelookupbyrow(var_0, var_1, 9));
    register_consumable(var_2, var_3, var_4, var_5, var_6, ::give_consumable, ::remove_consumable);
    var_1++;
  }

  consumable_setup_functions("_encstr_87DC162A7032E9DF5D5A4151F93218E1276A20E7E5C3AB58", ::use_ephemeral_enhancement, undefined, undefined, 1);
  consumable_setup_functions("_encstr_9B5E111C32FA7589C40F69903F17E0A9A29B37", ::use_grenade_cooldown, undefined, ::turn_off_grenade_cooldown, undefined);
  consumable_setup_functions("_encstr_97DB17C2EDB99209E189EB07E0B9C7FA07734D3ECEC30A43E9", ::use_reload_damage_increase, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_8F3010BBD79A41EBE8C7D091AB3DC09F223F", ::use_headshot_reload, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_A7011211786BF78B527BAA3998DFEB3759153AFA", ::use_anywhere_but_here, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_9BD30F16A7C0A967302361AB091DC79DF8", ::use_now_you_see_me, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_AD410DB55A6363D2CDCEF547B4B5B2", ::use_killing_time, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_BE140B8343EDCA374B87BE5DC1", ::use_phoenix_up, undefined, undefined, 1);
  consumable_setup_functions("_encstr_874010977036D0501FCA982303BF9A680D64", ::use_spawn_instakill, undefined, undefined, 1);
  consumable_setup_functions("_encstr_B16910F7D302AC687FBF2D7B6717C8EFAAEF", ::use_spawn_fire_sale, undefined, undefined, 1);
  consumable_setup_functions("_encstr_881D0B3738B0BB37FAE6D5ADB2", ::use_spawn_nuke, undefined, undefined, 1);
  consumable_setup_functions("_encstr_BAF513CD0E58DD9BAFC8ED57268DACEBADF637B22F", ::use_spawn_double_money, undefined, undefined, 1);
  consumable_setup_functions("_encstr_85460FD341A87B13AF18AA43266757B580", ::use_spawn_max_ammo, undefined, undefined, 1);
  consumable_setup_functions("_encstr_AC3D1648D38E37109F9A5DC66F8F5BE9F94B4B282AA57FCB", ::use_spawn_reboard_windows, undefined, undefined, 1);
  consumable_setup_functions("_encstr_83BD143B7F699FA58778CA4250CD5C2B4170B1AD1970", ::use_spawn_infinite_ammo, undefined, undefined, 1);
  consumable_setup_functions("_encstr_87D00789A1BE3B57CD", ::use_bh_gun, undefined, undefined, 1);
  consumable_setup_functions("_encstr_BEB30D072068E51A652502711C5322", ::use_atomizer_gun, undefined, undefined, 1);
  consumable_setup_functions("_encstr_846C096CB158EEBEEC5DCD", ::use_claw_gun, undefined, undefined, 1);
  consumable_setup_functions("_encstr_87570DB9E859ACC6EB8CC98576F673", ::use_steel_dragon, undefined, undefined, 1);
  consumable_setup_functions("_encstr_8C9210A7C77A531BE20F2030CF06B69F13AD", ::use_penetration_gun, undefined, undefined, 1);
  consumable_setup_functions("_encstr_845C0AA074561898FAE79587", ::use_life_link, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_A60D1483231FDF86F84007C5BBC0932F062A10771823", ::use_slow_enemy_movement, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_8E631A5FF0973EED8FE3EF49512422A393D79D64277897A3BDF366A3", ::use_increased_team_efficiency, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_85ED080FB318E707BE21", ::use_welfare, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_93680AB1B0733AAF5B5ACD6E", ::use_cant_miss, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_951B0CF0FD63500F33F3685B736A", ::use_self_revive, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_8369168308625705CEFF93A723B075D27F936FC74D913383", ::use_force_push_near_death, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_92900A6849A67F76D049E301", ::use_masochist, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_8F1D0FDC130837856B69CB72E8953FE3C3", ::use_timely_torrent, undefined, undefined, 1);
  consumable_setup_functions("_encstr_A5EA079BCBEAD0AC33", ::use_purify, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_9B7910B7D31132979348D387E1AB5F6B8F63", ::use_explosive_touch, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_A26F0C9A686FE3607BA673D3543B", ::use_shared_fate, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_AB7D0C4E936BB7C9DF501A928817", ::use_fire_chains, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_926D0B331A12677027C3C078F7", ::use_irish_luck, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_8AF612C565B70BD7920278D9BAAD8703CF09CE35", ::use_temporal_increase, undefined, undefined, undefined);
  consumable_setup_functions("_encstr_A35A0E93AF8B0B4CC9C0BFC9D90B74A2", ::use_twister, undefined, undefined, undefined);
}

register_consumable(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.type = var_1;
  var_7.uses = var_2;
  var_7.usageperiod = var_3;
  var_7.passiveuses = var_4;
  var_7.set = var_5;
  var_7.unset = var_6;
  var_7.timeupnotify = var_0 + "_encstr_A70608A76C4C78BDDF03";
  level.consumables[var_0] = var_7;

  foreach(var_10, var_9 in level.irish_luck_consumables) {
    if(var_10 == var_0) {
      level.irish_luck_consumables[var_0] = level.consumables[var_0];
      level.irish_luck_consumables[var_0].name = var_0;
    }
  }
}

consumable_setup_functions(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.consumables[var_0];

  if(isDefined(var_1))
    var_5.usefunc = var_1;

  if(isDefined(var_2))
    var_5.set = var_2;

  if(isDefined(var_3))
    var_5.unset = var_3;

  if(isDefined(var_4))
    var_5.testforsuccess = var_4;
}

init_player_consumables() {}

init_consumable_meter() {
  thread meter_fill_up();
}

init_consumables_used() {
  self.consumables_used = [];
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8BB80FB81FA5AD1F5A6A1511C6B251D103", 0);

  for(var_0 = 0; var_0 < 32; var_0++)
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_B1C9105E9F4B9B13A51218704AFA9B53DF3C", var_0, 0);
}

set_player_consumables() {
  self.consumables = [];

  for(var_0 = 0; var_0 < 5; var_0++) {
    var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BDB813F8DA75F518AF1FF6F836AFC3A3DEB2C098F3", var_0);
    self.consumables[var_1] = spawnStruct();
    self.consumables[var_1].uses = level.consumables[var_1].uses;
    self.consumables[var_1].on = 0;
    self.consumables[var_1].times_used = 0;
  }

  self.consumables_pre_irish_luck_usage = self.consumables;
}

turn_on_cards(var_0) {
  var_1 = get_card_deck_size(self);
  self.slot_array = [];
  self playlocalsound("_encstr_AC20128A9DAA31FC32435F0D67FB31384E745340");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self.slot_array[self.slot_array.size] = var_2;
    self setclientomnvarbit("_encstr_872818C3F38812418899D9DA51908DEAF5130F1B2FCE9A2D30A3", var_2, 1);
  }

  update_lua_consumable_slot(0);
}

reset_meter() {
  self notify("_encstr_843E0E571BFC929FC819737111B8EBCA");
  self.consumable_meter = 0;
  init_consumable_meter();
  thread lightbar_off();
}

get_card_deck_size(var_0) {
  var_1 = var_0 isitemunlocked("_encstr_850811A3FB0D626F3009820FE698941AE56F12", "_encstr_975B0D2AE36105610F1EA8A0CB90DD", 1);
  var_2 = var_0 isitemunlocked("_encstr_AD08113AA0DB50D767B1C8F187BBF9C7A3C045", "_encstr_975B0D2AE36105610F1EA8A0CB90DD", 1);
  var_3 = 3;

  if(var_1 && var_2)
    var_3 = 5;
  else if(var_1 && !var_2)
    var_3 = 4;
  else if(!var_1 && !var_2)
    var_3 = 3;

  return var_3;
}

setup_dpad_slots() {
  self setactionslot(1, "_encstr_B40101");
  self setactionslot(2, "_encstr_B40101");
  self setactionslot(3, "_encstr_B40101");
  self setactionslot(4, "_encstr_B40101");
  self notifyonplayercommand("_encstr_86660911BEE01619EB570E", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  self notifyonplayercommand("_encstr_84E20B08A677D74FA1A90707A5", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  thread watch_for_super_button("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
}

watch_for_super_button(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_1);
    var_2 = createheadicon(var_1);

    if(var_2 == var_0) {
      if(istrue(self.inlaststand)) {
        self setweaponammoclip(var_0, 1);
        continue;
      }

      self notify("_encstr_83090C07B008FDD2206F57BBBB5E");
      self setweaponammoclip(var_0, 1);
    }
  }
}

dpad_consumable_selection_watch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_84B714C67BDCE6BAB55889D8CAAF6E2B36958D47CA32");
  self endon("_encstr_843E0E571BFC929FC819737111B8EBCA");
  var_0 = 0;
  update_lua_consumable_slot(var_0);
  self.deck_select_ready = 1;

  for(;;) {
    var_1 = scripts\engine\utility::_id_143AE("_encstr_86660911BEE01619EB570E", "_encstr_84E20B08A677D74FA1A90707A5", "_encstr_83090C07B008FDD2206F57BBBB5E");

    if(self.slot_array.size <= 0 || istrue(self.disable_consumables) || istrue(self.spectating) || istrue(self.inlaststand)) {
      self playlocalsound("_encstr_8C2A132F4878E6FF08EB6823FF5B20D9DF99C94843");
      wait 0.25;
      continue;
    }

    if(var_1 == "_encstr_83090C07B008FDD2206F57BBBB5E") {
      self.deck_select_ready = undefined;
      thread consumable_activate(self.slot_array[var_0], var_0);
    } else if(var_1 == "_encstr_86660911BEE01619EB570E" && self.slot_array.size > 1) {
      var_0 = get_selection_index_loop_around(var_0 + 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_0);
      self playlocalsound("_encstr_99B4154DEBC1E6FF7023038A495ECBDF6947D3B20F80ED");
    } else if(var_1 == "_encstr_84E20B08A677D74FA1A90707A5" && self.slot_array.size > 1) {
      var_0 = get_selection_index_loop_around(var_0 - 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_0);
      self playlocalsound("_encstr_99B4154DEBC1E6FF7023038A495ECBDF6947D3B20F80ED");
    }

    waitframe();
  }
}

update_lua_consumable_slot(var_0) {
  wait 0.1;
}

get_selection_index_loop_around(var_0, var_1, var_2) {
  if(var_0 > var_2)
    return var_1;

  if(var_0 < var_1)
    return var_2;

  return var_0;
}

remove_card_from_use(var_0) {
  self.slot_array = scripts\engine\utility::array_remove(self.slot_array, self.slot_array[var_0]);
}

consumable_activate(var_0, var_1) {
  var_2 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BDB813F8DA75F518AF1FF6F836AFC3A3DEB2C098F3", var_0);
  var_3 = "_encstr_AB6708523599AF4912CB" + (var_0 + 1) + "_encstr_8148074691068F336A";
  var_4 = "_encstr_AC6B06F0DA2281E1" + (var_0 + 1) + "_encstr_8B560678AD177129";
  self.consumables[var_2].usednotify = var_4;

  if(var_2 == "_encstr_926D0B331A12677027C3C078F7")
    thread consumable_activate_internal_irish(var_2, var_3, "_encstr_A29310A7B5BEC8385819FAAE07D7D537ACCD", "_encstr_B2991590F71FB1D9223788A50AF9C3999C7F78B07BFD09", var_4, var_0, var_1);
  else
    thread consumable_activate_internal(var_2, var_3, "_encstr_A29310A7B5BEC8385819FAAE07D7D537ACCD", "_encstr_B2991590F71FB1D9223788A50AF9C3999C7F78B07BFD09", var_4, var_0, var_1);
}

consumable_activate_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACC90AC8072C23F5B2B919F5" + var_0);
  self endon("_encstr_843E0E571BFC929FC819737111B8EBCA");

  if(self.consumables[var_0].uses > 0 && self.consumables[var_0].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self setclientomnvar("_encstr_A27D12587177AAB15BF09F67F8B36CE1CB966757", var_5);
    self.consumables[var_0].processing = 1;
    var_7 = undefined;
    var_8 = "_encstr_83090C07B008FDD2206F57BBBB5E";
    thread set_consumable(var_0);

    if(isDefined(level.consumables[var_0].usefunc)) {
      if(isDefined(level.consumables[var_0].testforsuccess))
        var_7 = self[[level.consumables[var_0].usefunc]](var_0);
      else
        var_7 = self thread[[level.consumables[var_0].usefunc]](var_0);
    }

    if(!isDefined(var_7) || isDefined(var_7) && var_7) {
      consume_from_inventory(self, var_0);
      self.consumables[var_0].times_used++;
      scripts\cp\cp_merits::processmerit("_encstr_B2030CF0D44F236988CF05188277");
      thread scripts\cp\cp_vo::try_to_play_vo("_encstr_8A330FFC27F3C19BCAA9781092A2633837", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_BE19041BDEDD", 10, 0, 1, 0, 40);

      if(self.consumables[var_0].times_used == 1)
        thread decrement_counter_of_consumables(var_0);

      self setclientomnvar(var_1, 1);
      thread lightbar_off();
      self setclientomnvarbit("_encstr_965E15F4D6AF1BC29C19AF33A5B1C67D324BDCC1D80B5E", var_5, 1);
      remove_card_from_use(var_6);
      thread meter_fill_up();
      self playlocalsound("_encstr_82BF154BBCB7F0581237EBD3973A11181F92F1E027F3A3");
      play_consumable_activate_sound(self);
      self notify("_encstr_84B714C67BDCE6BAB55889D8CAAF6E2B36958D47CA32");
      thread scripts\cp\utility::firegesturegrenade(self, self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_AAC6149B16B3BE579B59D73358D156C29B3299BDC947");
      var_9 = level.consumables[var_0].type;

      if(var_9 == "_encstr_AD22118EA5AD2BC8B08D8ED23B164796DBB96E")
        thread dpad_drain_time(var_0, level.consumables[var_0].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      else if(var_9 == "_encstr_A9F60584665BF3")
        thread dpad_drain_wave(var_0, level.consumables[var_0].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      else if(var_9 == "_encstr_B4590B8D98834CBFF2FDDA68E8" || level.consumables[var_0].type == "_encstr_A3BC0CA3B25908846A8BA793FF23")
        thread dpad_drain_activations(var_0, level.consumables[var_0].type, self.consumables[var_0].uses, var_1, var_8, var_2, var_3, var_4, var_5);
      else if(var_9 == "_encstr_A9DA0F1B3EDB7A77B988E3AFA8532133AB")
        thread dpad_drain_triggerpassive(var_0, level.consumables[var_0].passiveuses, var_1, var_8, var_2, var_3, var_4, var_5);

      if(isDefined(var_7)) {
        scripts\cp\utility::notify_used_consumable(var_0);
        return;
      }
    } else {
      self playlocalsound("_encstr_8C2A132F4878E6FF08EB6823FF5B20D9DF99C94843");
      self.consumables[var_0].processing = undefined;
    }
  }
}

decrement_counter_of_consumables(var_0) {
  var_1 = get_consumable_index_in_player_data(self, var_0);

  if(isDefined(var_1)) {
    var_2 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_8B4E1436DEE637EAB61626D8B26EEBD8DEAE373A959C", var_1);
    var_3 = var_2 - 1;
    self setplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_8B4E1436DEE637EAB61626D8B26EEBD8DEAE373A959C", var_1, var_3);
  }
}

play_consumable_activate_sound(var_0) {
  switch (var_0.fate_card_weapon) {
    case "_encstr_A5ED10B84BAF61AA5227677F47EBE5198AA5":
      var_0 playlocalsound("_encstr_B2791CD338F26C457562AF66108995A73162A94D2A3BB959EB1324FD32E0");
      break;
    case "_encstr_87F410506BD39FE8BF42058E299BD1D7E852":
      var_0 playlocalsound("_encstr_87AC1C7FD77817872E71320BB990F30FF0B9DFE5479811475D6B5B6303D5");
      break;
    case "_encstr_99AA16C9247BE70B53E8422AB8A7049BC886496A351E0B95":
      var_0 playlocalsound("_encstr_B87B2277DAAE558AAB2E69EA99F80B03E35B3F9B01EB437C29651B9DA6F2053803AB824B");
      break;
    case "_encstr_A71712F7E8B3077BA35F722F464F82D22141236F":
      var_0 playlocalsound("_encstr_B61B1EBB7B3719CA9336B093467D270B38E0CA93D7AECDACAF3B2BDCE8AE9359");
      break;
    case "_encstr_B10912CC2CF769C7EBAB0B27E8A1B9C339509045":
      var_0 playlocalsound("_encstr_8AE71ADDB7DC8C59C93685C9C87DB356DC3AAEC9CAD79D93D5B99DCA");
      break;
    case "_encstr_A18F11D277B9D7D8A1EDB12CB10B3932D7F4AD":
      var_0 playlocalsound("_encstr_B2B0190CD0C087FD7E96872AAF67475158A99D4ADF50D638684551");
      break;
    case "_encstr_A6A91144C75B2756026B9A234A3FE230094515":
      var_0 playlocalsound("_encstr_A3C11977EDB94656C96CB09CC8D7D9AC6E3AAE9C2BF5C9169D56E4");
      break;
    case "_encstr_A5A9123A4334CFACF021A0BF39F8B63335FE83E2":
      var_0 playlocalsound("_encstr_936E1AEEBD3746B2E436584E8CD79DCAB9A3579CAC7DA14BE01AF607");
      break;
    case "_encstr_8F1D14C11C43DF427393EB12C8AFFAD76106547F3250":
      var_0 playlocalsound("_encstr_87B01C08422D71110BAB7FEE849719CBD25B80A81A89972B53C673E497DB");
      break;
    default:
      var_0 playlocalsound("_encstr_B2791CD338F26C457562AF66108995A73162A94D2A3BB959EB1324FD32E0");
  }
}

consume_from_inventory(var_0, var_1) {
  var_2 = get_consumable_loot_id(var_1);

  if(scripts\engine\utility::array_contains(var_0.consumables_used, var_2)) {
    return;
  }
  var_3 = var_0.consumables_used.size;

  if(isDefined(level.consumable_table))
    var_4 = level.consumable_table;
  else
    var_4 = "_encstr_AC022E3369B788A087D3B00317BB01B845D54B241DF4F03BCA58903BEBD048B2B740DFDDA3104A612753471B9E8F6B6C";

  var_5 = tablelookup(var_4, 1, var_1, 3);

  if(isDefined(var_5)) {
    if(var_5 == "_encstr_911108BD5FB2889D9B4A") {
      var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_B1C9105E9F4B9B13A51218704AFA9B53DF3C", var_3, int(var_2));
      var_6 = var_0 getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8BB80FB81FA5AD1F5A6A1511C6B251D103");
      var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8BB80FB81FA5AD1F5A6A1511C6B251D103", var_6 + 1);
      var_0.consumables_used = scripts\engine\utility::array_add(var_0.consumables_used, var_2);
    }
  }
}

get_consumable_index_in_player_data(var_0, var_1) {
  for(var_2 = 0; var_2 < 5; var_2++) {
    var_3 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BDB813F8DA75F518AF1FF6F836AFC3A3DEB2C098F3", var_2);

    if(var_1 == var_3)
      return var_2;
  }

  return undefined;
}

lightbar_on() {
  self setclientomnvar("_encstr_842812D898AFD9B91BAF8D7B733A4EDE36C6ACC8", 1);
  self setclientomnvar("_encstr_934609C2D61F8A1DB80D9A", 0);
  self setclientomnvar("_encstr_A1B50E326346D31838FBF0EFA3CBA39F", 1);
}

lightbar_off() {
  self setclientomnvar("_encstr_842812D898AFD9B91BAF8D7B733A4EDE36C6ACC8", 0);
}

dpad_drain_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;
  wait(getcharactercardgesturelength());

  for(;;) {
    if(!istrue(self.spectating) && !istrue(self.inlaststand)) {
      self setclientomnvar(var_2, var_8);
      var_8 = var_8 - var_9;

      if(var_8 <= 0) {
        self setclientomnvar(var_2, 0);
        disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
        break;
      }
    }

    wait 1.0;
  }
}

dpad_drain_wave(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;

  for(;;) {
    self setclientomnvar(var_2, var_8);
    level waittill("_encstr_99E110E8B31183B59183E7741FC9F9C8769F");
    var_8 = var_8 - var_9;

    if(var_8 <= 0) {
      self setclientomnvar(var_2, 0);
      disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
      break;
    }

    wait 1.0;
  }
}

dpad_drain_activations(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  thread watchforearlyexit(var_0, var_5, var_3, var_6, var_7, var_8);
  var_9 = self.consumables[var_0].usednotify;
  var_10 = 1;

  if(var_1 == "_encstr_A3BC0CA3B25908846A8BA793FF23")
    self waittill(var_9);

  wait 1.0;

  for(;;) {
    if(!istrue(self.spectating) && !istrue(self.inlaststand)) {
      var_10 = var_10 - 0.05;
      self setclientomnvar(var_3, var_10);

      if(var_10 <= 0) {
        self setclientomnvar(var_3, 0);
        disable_consumable(var_0, var_5, var_3, var_6, var_7, var_8);
        break;
      }
    }

    wait 0.05;
  }
}

dpad_drain_triggerpassive(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1 / var_1;
  var_9 = self.consumables[var_0].usednotify;
  var_10 = 1;

  for(;;) {
    self waittill(var_9);

    if(!istrue(self.spectating) && !istrue(self.inlaststand) || var_0 == "_encstr_B2690A66E0F1EFDB0321FDD3") {
      var_10 = var_10 - var_8;
      self setclientomnvar(var_2, var_10);

      if(var_10 < 0.0001) {
        self setclientomnvar(var_2, 0);
        disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
        break;
      }
    }
  }
}

getcharactercardgesturelength() {
  if(scripts\cp\utility::map_check(0)) {
    switch (self.vo_prefix) {
      case "_encstr_B119045043D9":
        return self getgestureanimlength("_encstr_AA9F1B9C55FFDED7E5A268787BBEB3331BC79C07A46B41F3C15A08C8B2");
      case "_encstr_831904D9F2F7":
        return self getgestureanimlength("_encstr_BE6414379356588F40AA9FCF2A08DEAAB8A6166DC253");
      case "_encstr_B4190483CCFA":
        return self getgestureanimlength("_encstr_A7B116F7AF0B90F827D5D9F1FA1370BED2DF550313E34598");
      case "_encstr_86190483D0AF":
        return self getgestureanimlength("_encstr_B1461480EA627F2B77BEE56D9A7FD1ED0FD1603862BC");
      default:
        return 2;
    }
  } else if(scripts\cp\utility::map_check(1)) {
    switch (self.vo_prefix) {
      case "_encstr_B119045043D9":
        return self getgestureanimlength("_encstr_A294157695E6BEBBDB9B23AC27D885278C7DC6867BB10B");
      case "_encstr_831904D9F2F7":
        return self getgestureanimlength("_encstr_88C91576B29BFABBDB9BC82B278D2C9C19FA9C5867CA39");
      case "_encstr_B4190483CCFA":
        return self getgestureanimlength("_encstr_84C416543DC35703D81DA83DF6B9E79BF166A2F5DB6E17A7");
      case "_encstr_86190483D0AF":
        return self getgestureanimlength("_encstr_8E9A168F2370392F4030425A5BAEAFAA60EF081961D07D7B");
      default:
        return 2;
    }
  } else {
    switch (self.vo_prefix) {
      case "_encstr_B119045043D9":
        return self getgestureanimlength("_encstr_AA9F1B9C55FFDED7E5A268787BBEB3331BC79C07A46B41F3C15A08C8B2");
      case "_encstr_831904D9F2F7":
        return self getgestureanimlength("_encstr_BE6414379356588F40AA9FCF2A08DEAAB8A6166DC253");
      case "_encstr_B4190483CCFA":
        return self getgestureanimlength("_encstr_A7B116F7AF0B90F827D5D9F1FA1370BED2DF550313E34598");
      case "_encstr_86190483D0AF":
        return self getgestureanimlength("_encstr_B1461480EA627F2B77BEE56D9A7FD1ED0FD1603862BC");
      default:
        return 2;
    }
  }
}

watchforearlyexit(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_ACC90AC8072C23F5B2B919F5" + var_0);
  self waittill(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self setclientomnvar(var_2, 0);
  thread disable_consumable(var_0, var_1, var_2, var_3, var_4, var_5);
}

meter_fill_up() {
  self notify("_encstr_AAD714E6E8584E3AB49BCED75BCA1D9539D73396B1B1");
  self endon("_encstr_AAD714E6E8584E3AB49BCED75BCA1D9539D73396B1B1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self.slot_array.size == 0) {
    thread scripts\cp\cp_vo::add_to_nag_vo("_encstr_91EC15CD0B76FA73AC958CFACC163A56B0371999ED933A", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", 60, 300, 6, 1);
    thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_AAC6149B16B3BE579B59D73358D156C29B3299BDC947");
    return;
  }

  self.consumable_meter = 0;
  self.consumable_meter_max = get_max_meter();

  while(self.consumable_meter < self.consumable_meter_max) {
    self waittill("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", var_0);

    if(istrue(self.disable_consumables)) {
      continue;
    }
    var_1 = self.consumable_meter_max - self.consumable_meter;

    if(var_0 > var_1)
      var_0 = var_1;

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }
    self.consumable_meter = self.consumable_meter + var_0;
  }

  self notify("_encstr_92290BCB2D3B5512376367C96C");
  thread scripts\cp\cp_vo::add_to_nag_vo("_encstr_AAC6149B16B3BE579B59D73358D156C29B3299BDC947", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", 60, 180, 6, 1);
  self playlocalsound("_encstr_8F8C198B03B7AA15C6C71BCD8ACE0CFDA14A3AD3256AFE63F5581B");
  self setweaponammoclip("_encstr_BEB611F03B72BB3B07E435BCF9772051117388", 1);
  thread lightbar_on();
  self.consumable_meter_full = 1;
  thread dpad_consumable_selection_watch();

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player)
    thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("_encstr_833B0660FF0AF997", 5);
}

get_max_meter() {
  var_0 = 1250;

  if(self.card_refills == 1)
    var_0 = 3000;
  else if(self.card_refills == 2)
    var_0 = 5000;

  return var_0;
}

disable_consumable(var_0, var_1, var_2, var_3, var_4, var_5) {
  turn_off_consumable(var_0, var_3);
  self.consumables[var_0].uses = self.consumables[var_0].uses - 1;
  self.consumables[var_0].processing = undefined;
  self setclientomnvar(var_1, self.consumables[var_0].uses);

  if(self.consumables[var_0].uses == 0) {
    self.consumables[var_0].uses = level.consumables[var_0].uses;
    self notify("_encstr_ACC90AC8072C23F5B2B919F5" + var_0);
    self setclientomnvarbit("_encstr_872818C3F38812418899D9DA51908DEAF5130F1B2FCE9A2D30A3", var_5, 0);
    self setclientomnvarbit("_encstr_965E15F4D6AF1BC29C19AF33A5B1C67D324BDCC1D80B5E", var_5, 0);
  } else
    self setclientomnvar(var_2, 1);
}

turn_off_consumable(var_0, var_1) {
  self.consumables[var_0].on = 0;
  scripts\cp\utility::notify_timeup_consumable(var_0);
  thread unset_consumable(var_0);
}

give_consumable(var_0, var_1) {
  var_2 = level.consumables[var_0];

  if(isDefined(var_2.usednotify))
    self notify(var_2.usednotify);
  else
    self notify(var_0 + "_encstr_84380BDEF9C8A45AFC036B2761");

  if(isDefined(level.random_consumable_chosen) && level.random_consumable_chosen.name == var_0)
    return;
  else
    self.consumables[var_0].on = 1;
}

remove_consumable(var_0) {
  if(isDefined(self.consumables[var_0]))
    self.consumables[var_0].on = 0;
}

use_reload_damage_increase(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.reload_damage_increase = undefined;

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    self.reload_damage_increase = 1;
    wait 5;
    self.reload_damage_increase = undefined;
  }
}

use_ephemeral_enhancement(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  var_1 = self getcurrentweapon();
  var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);

  if(isDefined(self.pap[var_2]) && scripts\cp\cp_weapon::can_upgrade(var_1, 1)) {
    thread fnf_upgrade_weapon(self, var_0, var_2, var_1);
    return 1;
  } else {
    self.consumables["_encstr_87DC162A7032E9DF5D5A4151F93218E1276A20E7E5C3AB58"].on = 0;
    return 0;
  }
}

fnf_upgrade_weapon(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = undefined;
  var_0.isusingsupercard = 1;
  var_5 = "_encstr_88190407B038" + var_0.pap[var_2].lvl;
  var_6 = getweaponattachments(var_3);
  var_7 = 0;
  var_8 = var_3;

  if(issubstr(var_3.basename, "_encstr_AD2C069D62077D4F")) {
    foreach(var_10 in var_6) {
      if(issubstr(var_10, "_encstr_AD9C07E0478148252A")) {
        var_7 = 1;
        var_6 = scripts\engine\utility::array_remove(var_6, var_10);
      }
    }
  }

  var_12 = createheadicon(var_3);

  if(isDefined(level.custom_epehermal_attachment_func)) {
    var_13 = [[level.custom_epehermal_attachment_func]](var_0, var_2, var_12);

    if(isDefined(var_13)) {
      if(var_13 == "_encstr_ABCB0B27AC1C6316C6CAAFB595")
        var_5 = undefined;
      else
        var_5 = var_13;
    }
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_3)]))
    var_12 = level.weapon_upgrade_path[getweaponbasename(var_3)];
  else if(isDefined(level.custom_epehermal_weapon_func))
    var_12 = [[level.custom_epehermal_weapon_func]](var_0, var_2, var_3);

  var_3 = asmdevgetallstates(var_12);

  if(isDefined(level.custom_ephermal_camo_func))
    var_4 = [[level.custom_ephermal_camo_func]](var_0, var_2, var_3);
  else {
    if(isDefined(var_2)) {
      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_2))
        var_4 = undefined;
      else if(isDefined(level.pap_1_camo) && var_0.pap[var_2].lvl == 1)
        var_4 = level.pap_1_camo;
      else if(isDefined(level.pap_2_camo) && var_0.pap[var_2].lvl == 2)
        var_4 = level.pap_2_camo;

      var_14 = var_0 scripts\cp\cp_weapon::get_weapon_level(var_3);

      switch (var_2) {
        case "_encstr_AB7E09E2881E27B4C85DA4":
          var_15 = "_encstr_B4B615704BF3FFC9EF23E66B07BBF13708724940C2FA9B";
          var_4 = "_encstr_8392077BDB70C5EA3F";
          break;
        case "_encstr_87D80B1A6182E9DF5DDD54432B":
          var_15 = "_encstr_A5A11796BBDCF599C21BB25B2B1B1DAC93FAA7ADD738B00726";
          var_4 = "_encstr_869207668E020F8BFA";
          break;
        case "_encstr_82BB0BE8BF89C85EA32BE9C3DB":
          var_15 = "_encstr_BE65170FB77458F3105A9FD7EBB09BBD08A60269EF03D078C6";
          var_4 = "_encstr_9B92076C2CD67B91C4";
          break;
        case "_encstr_92C90C99ED393B95339395AC3DCA":
          if(var_14 == 2)
            var_15 = "_encstr_AF5918D3773301C44FCB0971B2030D9838FD378D0581C09FDB17";
          else if(var_14 == 3)
            var_15 = "_encstr_A959185ABBDCEB997B279D5699E4592BD3B2D7A75BFAE02C38C8";

          var_16 = 1;
          break;
        case "_encstr_961904BF105A":
          if(var_14 == 2)
            var_15 = "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3";
          else if(var_14 == 3)
            var_15 = "_encstr_A20A1003CF665603D89A290832391929D312";

          break;
        case "_encstr_B62609371A9C594619569C":
          var_15 = "_encstr_8A6F15B4EE73BECDD04E2B2323599CBE4FADBE83160789";
          var_4 = "_encstr_8B92075E37537AA2F3";
          break;
        case "_encstr_87910A37ABDC8DA1EA1B6D6E":
        case "_encstr_ABCC07DA161D16E62C":
          var_4 = "_encstr_849E08E810BB97DA9A36";
          break;
      }
    }

    var_16 = 0;

    if(isDefined(var_2)) {
      switch (var_2) {
        case "_encstr_A6F307234BEFF26827":
        case "_encstr_A77205F710E016":
        case "_encstr_AF1904F3CFA8":
        case "_encstr_961904BF105A":
        case "_encstr_B1CB0859917FF833E352":
          var_16 = 1;
        default:
          var_16 = 0;
      }
    } else
      var_16 = 0;

    var_5 = undefined;

    if(isDefined(var_2)) {
      switch (var_2) {
        case "_encstr_A6F307234BEFF26827":
        case "_encstr_A77205F710E016":
        case "_encstr_AF1904F3CFA8":
        case "_encstr_B1CB0859917FF833E352":
        case "_encstr_87910A37ABDC8DA1EA1B6D6E":
        case "_encstr_ABCC07DA161D16E62C":
          var_5 = "_encstr_ABCB0B27AC1C6316C6CAAFB595";
          break;
        default:
          if(isDefined(var_0.pap[var_2]))
            var_5 = "_encstr_88190407B038" + var_0.pap[var_2].lvl;
          else
            var_5 = "_encstr_8A0D05B1400BA2";
      }
    }

    if(isDefined(var_5) && var_5 == "_encstr_ABCB0B27AC1C6316C6CAAFB595")
      var_5 = undefined;

    var_17 = getweaponattachments(var_3);

    if(issubstr(var_3.basename, "_encstr_AD2C069D62077D4F")) {
      foreach(var_10 in var_17) {
        if(issubstr(var_10, "_encstr_AD9C07E0478148252A"))
          var_17 = scripts\engine\utility::array_remove(var_17, var_10);
      }
    }
  }

  var_20 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, var_5, var_6, undefined, var_4);
  var_21 = asmdevgetallstates(var_20);

  if(isDefined(var_21)) {
    var_0.pap[var_2].lvl++;
    var_0 notify("_encstr_A56D15C7BF3A174856E9C8E1CB0508D8B233636D5F82D5");
    var_0.ephemeralweapon = var_21 getbaseweapon();
    var_0 thread downgradeweaponaftertimeout(var_1, var_0, var_21, var_7);
    var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
    wait(getcharactercardgesturelength());
    var_21 = var_0 scripts\cp\utility::_giveweapon(var_21, undefined, undefined, 1);

    if(isDefined(var_8))
      var_0 takeweapon(var_8);
    else
      var_0 takeweapon(var_3);

    var_0 switchtoweapon(var_21);
  }
}

downgradeweaponaftertimeout(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = undefined;

  if(issameweapon(var_2))
    var_4 = var_2;
  else
    var_4 = asmdevgetallstates(var_2);

  var_5 = var_1.ephemeralweapon;
  var_6 = 0;
  var_7 = scripts\cp\utility::getrawbaseweaponname(var_4);
  var_8 = "_encstr_88190407B038" + (var_1.pap[var_7].lvl - 1);
  var_9 = var_1.pap[var_7].lvl - 2;

  switch (var_7) {
    case "_encstr_ABCC07DA161D16E62C":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("_encstr_A9210EC85FB796AF6273D7680EB9B598");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("_encstr_BAA91358AB4F81CA925B534527598AA88FC2C1F342");
      }

      break;
    case "_encstr_87910A37ABDC8DA1EA1B6D6E":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("_encstr_AF5711D3773301C0270A89D083470A2871E253");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("_encstr_99B71651D782E9FBFD8062DACBDED75A6955DD9F31E8EACE");
      }

      break;
    case "_encstr_AF1904F3CFA8":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("_encstr_BE63160FB774588380BA51FBEF189FBDB8A619E3D5BFB078");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("_encstr_851C1BA9B7941788A70AD15A224188FD5820A1BA4FBF6B1FBF87473AC1");
      }

      break;
    case "_encstr_B1CB0859917FF833E352":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("_encstr_999B0FC47322C7423F4F23EF99D5A93DC0");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("_encstr_AB9E1480DB7608C8C6FB4143F42F91E993B13B0913C6");
      }

      break;
    case "_encstr_A77205F710E016":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("_encstr_8D7511B98FA389CCA2B1776680E853AB47C8EB");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("_encstr_A3E41651E8423934E8A01129F319903938A8578ECA78FB57");
      }

      break;
    case "_encstr_A6F307234BEFF26827":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("_encstr_83EA1297DFB4D95BA030CC57890192F2ED770F6B");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("_encstr_A260173B7BA757BB8BC3FA5F25E7CA88B47FFBC0D0594152EF");
      }

      break;
  }

  var_4 = downgradeweapon(var_1, var_4, var_7, var_8, var_9, var_3);
  var_1.base_weapon = undefined;
  var_1.ephemeral_downgrade = undefined;
  var_10 = var_1 scripts\engine\utility::_id_143AD("_encstr_A7481D75F1504FAFAD6B3AF2D6F5EB4460A5EBFD739055335883B2EAF9D54B", "_encstr_8CBE0BD1BED30936AB03C0B02B");

  if(var_10 != "_encstr_A7481D75F1504FAFAD6B3AF2D6F5EB4460A5EBFD739055335883B2EAF9D54B")
    var_1 notify(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");

  var_1.isusingsupercard = undefined;
  var_11 = var_1 scripts\cp\utility::getvalidtakeweapon();
  var_12 = scripts\cp\utility::getrawbaseweaponname(var_11);

  if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_5)) {
    var_13 = var_1 getweaponslistall();

    foreach(var_15 in var_13) {
      var_16 = scripts\cp\utility::getrawbaseweaponname(var_15);

      if(var_16 == scripts\cp\utility::getrawbaseweaponname(var_5)) {
        var_1 takeweapon(var_15);
        var_6 = 1;
        var_4 = var_1 scripts\cp\utility::_giveweapon(var_4, undefined, undefined, 1);

        if(scripts\cp\utility::getrawbaseweaponname(var_4) == var_12)
          var_1 switchtoweaponimmediate(var_4);

        var_1.pap[var_7].lvl = int(max(var_1.pap[var_7].lvl - 1, 1));
        var_1 notify("_encstr_A56D15C7BF3A174856E9C8E1CB0508D8B233636D5F82D5");
        break;
      }
    }
  }

  if(isDefined(var_1.copy_fullweaponlist)) {
    var_18 = var_1.copy_fullweaponlist;

    foreach(var_20 in var_18) {
      var_16 = var_20 getbaseweapon();

      if(var_16 == var_5) {
        var_21 = createheadicon(var_20);
        var_22 = var_1.copy_weapon_ammo_clip[var_21];
        var_23 = var_1.copy_weapon_ammo_stock[var_21];
        var_1.copy_fullweaponlist = scripts\engine\utility::array_remove(var_1.copy_fullweaponlist, var_20);
        var_24 = createheadicon(var_4);

        if(var_16 == var_1.copy_weapon_current getbaseweapon())
          var_1.copy_weapon_current = var_4;

        var_1.copy_fullweaponlist = scripts\engine\utility::array_add(var_1.copy_fullweaponlist, var_24);
        var_1.copy_weapon_ammo_clip[var_24] = var_22;
        var_1.copy_weapon_ammo_stock[var_24] = var_23;
        break;
      }
    }
  }

  if(isDefined(var_1.last_stand_pistol)) {
    if(var_1.last_stand_pistol getbaseweapon() == var_1.ephemeralweapon)
      var_1.last_stand_pistol = var_4;
  }

  if(isDefined(var_1.saved_last_stand_pistol)) {
    if(var_1.saved_last_stand_pistol getbaseweapon() == var_1.ephemeralweapon)
      var_1.saved_last_stand_pistol = var_4;
  }

  if(isDefined(var_1.lost_and_found_ent)) {
    var_18 = var_1.lost_and_found_ent.copy_fullweaponlist;

    foreach(var_20 in var_18) {
      var_16 = var_20 getbaseweapon();

      if(var_16 == var_5) {
        var_21 = createheadicon(var_20);
        var_22 = var_1.copy_weapon_ammo_clip[var_21];
        var_23 = var_1.copy_weapon_ammo_stock[var_21];
        var_1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_remove(var_1.lost_and_found_ent.copy_fullweaponlist, var_20);
        var_24 = createheadicon(var_4);

        if(var_16 == var_1.lost_and_found_ent.copy_weapon_current getbaseweapon())
          var_1.lost_and_found_ent.copy_weapon_current = var_4;

        var_1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_add(var_1.lost_and_found_ent.copy_fullweaponlist, var_4);
        var_1.copy_weapon_ammo_clip[var_24] = var_22;
        var_1.copy_weapon_ammo_stock[var_24] = var_23;
        break;
      }
    }
  }

  var_1.ephemeralweapon = undefined;
}

downgradeweapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(var_4 >= 1) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_2))
      var_6 = undefined;
    else if(isDefined(level.pap_1_camo))
      var_6 = level.pap_1_camo;

    var_7 = "_encstr_88190407B038" + var_4;

    switch (var_2) {
      case "_encstr_AB7E09E2881E27B4C85DA4":
        var_6 = "_encstr_8392077BDB70C5EA3F";
        break;
      case "_encstr_87D80B1A6182E9DF5DDD54432B":
        var_6 = "_encstr_869207668E020F8BFA";
        break;
      case "_encstr_82BB0BE8BF89C85EA32BE9C3DB":
        var_6 = "_encstr_9B92076C2CD67B91C4";
        break;
      case "_encstr_B62609371A9C594619569C":
        var_6 = "_encstr_8B92075E37537AA2F3";
        break;
      case "_encstr_87910A37ABDC8DA1EA1B6D6E":
      case "_encstr_ABCC07DA161D16E62C":
        var_6 = "_encstr_849E08E810BB97DA9A36";
        break;
    }
  } else
    var_7 = undefined;

  switch (var_2) {
    case "_encstr_87910A37ABDC8DA1EA1B6D6E":
    case "_encstr_ABCC07DA161D16E62C":
      var_7 = undefined;
      break;
    case "_encstr_AF1904F3CFA8":
      var_7 = undefined;
      break;
    case "_encstr_A77205F710E016":
      var_7 = undefined;
      break;
    case "_encstr_B1CB0859917FF833E352":
      var_7 = undefined;
      break;
    case "_encstr_A6F307234BEFF26827":
      var_7 = undefined;
      break;
  }

  var_8 = getweaponattachments(var_1);

  if(istrue(var_5))
    var_8 = scripts\engine\utility::array_add(var_8, "_encstr_AD9C07E0478148252A");

  foreach(var_10 in var_8) {
    if(issubstr(var_10, var_3))
      var_8 = scripts\engine\utility::array_remove(var_8, var_10);
  }

  var_12 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_1, var_7, var_8, undefined, var_6);
  return asmdevgetallstates(var_12);
}

use_spawn_instakill(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "_encstr_8B660D237D362360DC5A29418E5EF8", var_0))
    return 1;
  else {
    self.consumables["_encstr_874010977036D0501FCA982303BF9A680D64"].on = 0;
    return 0;
  }
}

use_spawn_fire_sale(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "_encstr_97C60879ECCA9010F70A", var_0))
    return 1;
  else {
    self.consumables["_encstr_97C60879ECCA9010F70A"].on = 0;
    return 0;
  }
}

use_spawn_nuke(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "_encstr_9A1208DAA5C6C6BEA618", var_0))
    return 1;
  else {
    self.consumables["_encstr_881D0B3738B0BB37FAE6D5ADB2"].on = 0;
    return 0;
  }
}

use_spawn_double_money(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "_encstr_824A074F03063AE722", var_0))
    return 1;
  else {
    self.consumables["_encstr_BAF513CD0E58DD9BAFC8ED57268DACEBADF637B22F"].on = 0;
    return 0;
  }
}

use_spawn_max_ammo(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "_encstr_B602090FE56A675EDD2F60", var_0))
    return 1;
  else {
    self.consumables["_encstr_85460FD341A87B13AF18AA43266757B580"].on = 0;
    return 0;
  }
}

use_spawn_reboard_windows(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "_encstr_B1CA0EDE9F77BB31297340605AFDDF53", var_0))
    return 1;
  else {
    self.consumables["_encstr_AC3D1648D38E37109F9A5DC66F8F5BE9F94B4B282AA57FCB"].on = 0;
    return 0;
  }
}

use_spawn_infinite_ammo(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "_encstr_AB3D0CE95DB0DC333B1BCA51EBAF", var_0))
    return 1;
  else {
    self.consumables["_encstr_83BD143B7F699FA58778CA4250CD5C2B4170B1AD1970"].on = 0;
    return 0;
  }
}

spawn_power_up(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = (0, 128, 0);
  var_5 = self getplayerangles();
  var_6 = 7;
  var_3 = var_3 + var_4[0] * anglestoright(var_5);
  var_3 = var_3 + var_4[1] * anglesToForward(var_5);
  var_3 = var_3 + var_4[2] * anglestoup(var_5);
  var_7 = rotatepointaroundvector(anglestoup(var_5), anglesToForward(var_5), var_6);
  var_8 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_A34817931A7F2ED856FB47A71E7B70789303CE9952236F80AD", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_3 + var_7, self, var_8);
  var_3 = scripts\engine\utility::drop_to_ground(var_9["_encstr_BD260953AA97E3F014279D"] + var_7 * -18, 32, -2000);

  if(!scripts\cp\cp_weapon::isinvalidzone(var_3, level.invalid_spawn_volume_array, undefined, undefined, 1))
    return 0;

  return 0;
}

use_steel_dragon(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "_encstr_8FD113A5BBE6F5B9D19595361939C29DBDE6F5DA1C");
  return 1;
}

use_claw_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "_encstr_81D10C96DDE67D8D8D2CDDD7B683");
  return 1;
}

use_atomizer_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "_encstr_870F1EA577CDAFB03AF6D65A4FAC4E7DDAE0592C8EDEDAA59EAC39B98DDB1C56");
  return 1;
}

use_penetration_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "_encstr_82D32CB4DD737D1CAC372B474EB0E84BBDE6278596C6D7B538B238CAB9AC8E9C85472DBDDCC92C96369B8DEDE095");
  return 1;
}

use_bh_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "_encstr_B1F6266F275C31A2D899767C90E8E42ADC8BEB3FEB27BE9A80E16E4488103C62A41363775FC05355");
  return 1;
}

give_mp_super_weapon(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = undefined;

  if(issameweapon(var_1))
    var_2 = var_1;
  else
    var_2 = asmdevgetallstates(var_1);

  var_3 = self getcurrentweapon();
  var_4 = 0;

  if(nullweapon(var_3))
    var_4 = 1;
  else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_3))
    var_4 = 1;
  else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_3 getbaseweapon()))
    var_4 = 1;
  else if(scripts\cp\utility::is_melee_weapon(var_3, 1))
    var_4 = 1;

  if(var_4) {
    self.copy_fullweaponlist = self getweaponslistall();
    var_3 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  self.last_weapon = var_3;
  self.copy_fullweaponlist = undefined;
  thread removeweaponaftertimeout(var_0, var_2, var_3);
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  wait(getcharactercardgesturelength());
  var_2 = scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 0);
  self switchtoweaponimmediate(var_2);
  var_5 = ammo_round_up(var_2);

  while(self getcurrentweapon() != var_2)
    wait 0.05;

  self notify("_encstr_A9C2139BEAC1AC9CF5EE56851CDBCDBECEA5D92BB9");
  thread unlimited_ammo(var_5, var_2);
}

removeweaponaftertimeout(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.isusingsupercard = 1;
  self.mpsuperpreviousweapon = var_2;
  scripts\common\utility::allow_reload(0);
  scripts\engine\utility::_id_143B9(getcharactercardgesturelength() + 1, "_encstr_A9C2139BEAC1AC9CF5EE56851CDBCDBECEA5D92BB9");
  self allowmelee(0);

  while(self isswitchingweapon())
    wait 0.05;

  self allowmelee(1);

  if(self getcurrentweapon() == var_1 && scripts\cp\utility::is_consumable_active(var_0))
    var_3 = scripts\engine\utility::_id_143B1(var_0 + "_encstr_A70608A76C4C78BDDF03", "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC", "_encstr_A10511BB565807ED37BE38BA4EB1A1B0DC2B8C", "_encstr_A28F171BDE58CDD1B293AFC9A5C8B2AF2695CEB4B9732DB9CE", "_encstr_A616123F996AD05697C371DB0A5780E042F84BB9");
  else
    var_3 = undefined;

  scripts\common\utility::allow_reload(1);

  if(!isDefined(var_3) || var_3 != var_0 + "_encstr_A70608A76C4C78BDDF03")
    self notify(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");

  self.isusingsupercard = undefined;

  if(!isDefined(var_3) || isDefined(var_3) && var_3 != "_encstr_8CBE0BD1BED30936AB03C0B02B") {
    if(self hasweapon(var_2))
      self switchtoweapon(var_2);
    else
      self switchtoweapon(self getweaponslistprimaries()[1]);
  }

  if(self hasweapon(var_1))
    self takeweapon(var_1);

  thread deactivate_infinite_ammo();
  self.mpsuperpreviousweapon = undefined;
  self.last_weapon = undefined;
}

ammo_round_up(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = [];

  if(isDefined(var_0))
    var_1[createheadicon(var_0)] = self getammocount(var_0);
  else {
    foreach(var_3 in self.weaponlist)
    var_1[createheadicon(var_3)] = self getammocount(var_3);
  }

  return var_1;
}

unlimited_ammo(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.weaponlist))
    self.weaponlist = self getweaponslistprimaries();

  var_2 = self.weaponlist;

  if(isDefined(var_1))
    var_2[var_2.size] = var_1;

  self.has_fnf_weapon = 1;
  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_fnf_weapon)) {
    var_3 = 0;

    foreach(var_5 in var_2) {
      if(var_5 == self getcurrentweapon() && weapon_no_unlimited_check(var_5)) {
        var_3 = 1;
        self setweaponammoclip(var_5, weaponclipsize(var_5), "_encstr_A5AD056A019C63");
      }

      if(var_5 == self getcurrentweapon() && weapon_no_unlimited_check(var_5)) {
        var_3 = 1;
        self setweaponammoclip(var_5, weaponclipsize(var_5), "_encstr_8253060E2B5FE330");
      }

      if(var_3 == 0)
        ammo_round_up(var_1);
    }

    wait 0.05;
  }
}

weapon_no_unlimited_check(var_0) {
  var_1 = 1;

  if(isDefined(level.opweaponsarray)) {
    foreach(var_3 in level.opweaponsarray) {
      if(var_0.basename == var_3)
        var_1 = 0;
    }
  }

  return var_1;
}

deactivate_infinite_ammo() {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.has_fnf_weapon = undefined;
  wait 0.2;
  scripts\cp\utility::enable_infinite_ammo(0);
}

use_cant_miss(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AF8F0C1B6C17D8D0522F777F37EA", var_1);

    if(!scripts\cp\cp_weapon::isbulletweapon(var_1)) {
      continue;
    }
    if(var_1 hasattachment("_encstr_841808EC981C1C0B3898", 1) || var_1 hasattachment("_encstr_992309CE4CE01C5858C146")) {
      continue;
    }
    var_2 = self getweaponammoclip(var_1);
    self setweaponammoclip(var_1, var_2 + 1);
  }
}

use_force_push_near_death(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_990C0F38C6859795397D2385B52CEC9519");

    if(self.health <= 45) {
      thread setandremoveinvulnerability();
      thread killnearbyzombies();
      scripts\cp\utility::notify_used_consumable(var_0);
    }
  }
}

setandremoveinvulnerability() {
  self notify("_encstr_BE2A1C2BE5DB57D581D16AE250CD4F2F30D495BC880153DEB51082BAB00B");
  self endon("_encstr_BE2A1C2BE5DB57D581D16AE250CD4F2F30D495BC880153DEB51082BAB00B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\utility::adddamagemodifier("_encstr_86231685A30B889981597A7D4BA162E82D521B2D69F90860", 0.0, 0);
  scripts\engine\utility::_id_143C0(1, "_encstr_AD75063D571AE108", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  scripts\cp\utility::removedamagemodifier("_encstr_86231685A30B889981597A7D4BA162E82D521B2D69F90860", 0);
}

killnearbyzombies(var_0) {
  var_1 = 128;
  var_2 = vectorNormalize(anglesToForward(self.angles));
  var_3 = var_2 * var_1;
  var_4 = self.origin + var_3;
  physicsexplosionsphere(var_4, var_1, 1, 2.5);
  var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_6 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, 24, 256);

  foreach(var_8 in var_6) {
    if(istrue(var_8.immune_against_repulsor)) {
      continue;
    }
    if(isDefined(var_8.agent_type) && (var_8.agent_type == "_encstr_8D7811402FFDC15BD2A9CEDFBA4BBB694CA758" || var_8.agent_type == "_encstr_9BE008764102938025A5" || var_8.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73" || var_8.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_8.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_8.agent_type == "_encstr_88EC0D4FEDB5C4B456AF3636BDBBDC")) {
      continue;
    }
    var_8 playSound("_encstr_B67D199EAD267D669B33D79B2BB1DEDC8CEBEE2D3723D707AE3786");
    var_9 = 0;
    var_10 = var_8.origin;
    var_11 = var_8.maxhealth;
    var_2 = anglesToForward(self.angles);
    var_12 = vectorNormalize(var_2) * -100;
    var_8 setvelocity(vectorNormalize(var_8.origin - (self.origin + var_12)) * 800 + (0, 0, 300));
    var_8 killrepulsorvictim(self, var_11, var_10, self.origin);
  }
}

killrepulsorvictim(var_0, var_1, var_2, var_3) {
  self.do_immediate_ragdoll = 1;

  if(var_1 >= self.health)
    self.customdeath = 1;

  self dodamage(var_1, var_2, var_0, var_0, "_encstr_A1ED0BA9FF84562B60BA073E83", "_encstr_95E8104FDBDA7D272B1CAE3637B793AFAD0E");
}

select_random_vector_in_radius(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = var_0.origin;
  var_5 = (0, 128, 0);
  var_6 = var_0 getplayerangles();
  var_7 = 7;
  var_8 = 0;
  var_4 = var_4 + var_5[0] * anglestoright(var_6);
  var_4 = var_4 + var_5[1] * anglesToForward(var_6);
  var_4 = var_4 + var_5[2] * anglestoup(var_6);
  var_9 = rotatepointaroundvector(anglestoup(var_6), anglesToForward(var_6), var_7);
  var_10 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_A34817931A7F2ED856FB47A71E7B70789303CE9952236F80AD", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
  var_11 = scripts\engine\trace::ray_trace(var_0 getEye(), var_4 + var_9, var_0, var_10);
  var_4 = scripts\engine\utility::drop_to_ground(var_11["_encstr_BD260953AA97E3F014279D"] + var_9 * -18, 32, -2000);
  var_12 = 0;

  foreach(var_15, var_14 in var_2) {
    if(scripts\engine\utility::within_fov(self getEye(), self.angles, var_14.origin, cos(65))) {
      if(distance2dsquared(self.origin, var_14.origin) < 1000000) {
        if(var_12 <= 5) {
          self.closestenemies_array[var_15] = var_14;
          var_3[var_12] = var_14.origin;
          var_12++;
          continue;
        }

        break;
      }
    }
  }

  var_3 = getrandomnavpoints(var_0.origin, var_1, 5, undefined, var_4, 1200);
  return var_3;
}

torrent_start(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_3 == 0 || var_3 == 3 || var_3 == 6)
    playsoundatpos(var_1, "_encstr_96CB1CEBC33E07DD30E7CFFB545DDF7AFB19C4E0126203BA01DF9C162BB1");

  playFX(level._effect["_encstr_83240D907786C157A305EEF69F5A59"], self.origin, undefined, anglestoup((0, 0, 90)));

  foreach(var_6 in var_2) {
    var_7 = (var_6.origin[0], var_6.origin[1], 90);

    if(isDefined(var_6.flung) || isDefined(var_6.agent_type) && (var_6.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_6.agent_type == "_encstr_A60E0DA22F1BF540F8660F84DAD6A1" || var_6.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_6.agent_type == "_encstr_9BE008764102938025A5" || var_6.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73")) {
      continue;
    }
    if(distancesquared(var_6.origin, var_1) < 5184) {
      var_6.flung = 1;
      var_6.do_immediate_ragdoll = 1;
      var_6.disable_armor = 1;
      var_6 setsolid(0);
      var_6 setvelocity((0, 0, 600));
      wait 0.1;

      if(isDefined(var_6))
        var_6 dodamage(10000, var_1, var_4, var_4, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    }
  }

  self delete();
}

use_timely_torrent(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread run_timely_torrent(var_0);
}

select_spot_array(var_0, var_1) {
  if(!isDefined(var_0.array_of_torrent_points))
    var_0.array_of_torrent_points = [];

  var_2 = var_0.origin;
  var_3 = (0, 128, 0);
  var_4 = var_0 getplayerangles();
  var_5 = 7;
  var_6 = 0;
  var_2 = var_2 + var_3[0] * anglestoright(var_4);
  var_2 = var_2 + var_3[1] * anglesToForward(var_4);
  var_2 = var_2 + var_3[2] * anglestoup(var_4);
  var_7 = rotatepointaroundvector(anglestoup(var_4), anglesToForward(var_4), 0);
  var_8 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_A34817931A7F2ED856FB47A71E7B70789303CE9952236F80AD", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_2 + var_7, var_0, var_8);
  var_2 = var_9["_encstr_BD260953AA97E3F014279D"] + var_7;

  if(var_1 == 0)
    var_0.array_of_torrent_points[var_1] = var_2 + anglesToForward(var_4) * 60;
  else
    var_0.array_of_torrent_points[var_1] = var_2 + anglesToForward(var_4) * (var_1 + 1) * 60;

  return var_0.array_of_torrent_points;
}

run_timely_torrent(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = [];
  var_2 = 0;

  for(;;) {
    self waittill("_encstr_83470C2D85B1F9E7FEDDF40887A4");

    for(var_3 = 0; var_3 <= 5; var_3++)
      var_1 = select_spot_array(self, var_3);

    var_4 = 1200;
    self.closestenemies_array = [];
    var_5 = scripts\cp\cp_agent_utils::get_alive_enemies();

    foreach(var_8, var_7 in var_1)
    var_1[var_8] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_7);

    foreach(var_8, var_7 in var_1) {
      if(!isDefined(var_7)) {
        continue;
      }
      var_7 thread torrent_start(var_0, var_7.origin, var_5, var_8, self);
    }

    scripts\cp\utility::notify_used_consumable("_encstr_8F1D0FDC130837856B69CB72E8953FE3C3");
  }
}

use_purify(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::is_valid_player())
      var_2 thread purify_activate(var_0, var_2, self);
  }

  return 1;
}

purify_activate(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  var_3 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 24, 99999, 0);

  foreach(var_1 in var_3) {
    var_1 thread dealaoedamage(var_0);
    wait 0.5;
  }

  var_2 scripts\cp\utility::notify_used_consumable("_encstr_A5EA079BCBEAD0AC33");
}

dealaoedamage(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_agent_utils::get_alive_enemies();
  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_1, undefined, 24, 128, 0);

  if(var_2.size > 0) {
    self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");

    foreach(var_4 in var_2) {
      if(isDefined(var_4.agent_type) && (var_4.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_4.agent_type == "_encstr_A60E0DA22F1BF540F8660F84DAD6A1" || var_4.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_4.agent_type == "_encstr_9BE008764102938025A5" || var_4.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73"))
        continue;
      else {
        playFX(level._effect["_encstr_BD401E0ECA3759D1E42C8EA5B773AFC9C2A51BB3BAB9F556E1E063F6374B7BB9"], self.origin);
        var_4 dodamage(var_4.health + 100, var_4.origin, self, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A63217A09B234F591B7031B86B87E3F3911318D8B28C17F267");
      }
    }

    self playSound("_encstr_84C415DA35D25712D01F71B7759BC7CB526682E1D16C15");
  }
}

calcfrontposbasedonvelocity(var_0) {
  var_1 = (0, 0, 0);
  var_2 = self.origin + var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoright(self.angles);
  var_5 = self getvelocity();
  var_6 = vectordot(var_5, self.angles);
  var_7 = length(var_5);

  if(var_7 < 64)
    var_7 = 64;

  if(var_7 > 64 && var_7 < 128)
    var_7 = 92;

  if(var_7 > 350)
    var_7 = 500;

  if(var_7 > 200)
    var_7 = 256;

  if(var_7 > 128)
    var_7 = 164;

  if(var_6 < 1)
    var_7 = 64;

  if(isDefined(var_0))
    var_7 = var_0;

  return var_2 + var_3 * var_7;
}

watchmelee() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_874B0D4B40B3BDBBF17E35290799E3");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (0, 0, 32);

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_83470C2D85B1F9E7FEDDF40887A4", "_encstr_B10707CEA57F69C968", "_encstr_BA1B089143070130736B");
    var_1 = self.origin + var_0;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoright(self.angles);
    self playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
    earthquake(0.2, 0.1, self.origin, 32);
    var_4 = calcfrontposbasedonvelocity();
    var_4 = var_4 + var_0;
    var_5 = var_1 + var_3 * 64;
    var_6 = var_1 - var_3 * 32;
    var_7 = rotatevector(var_3, (0, 45, 0));
    var_8 = var_1 + var_7 * 64;
    var_9 = rotatevector(var_3, (0, 135, 0));
    var_10 = var_1 + var_9 * 32;
    var_11 = gettime();
    self.meleeorigin.origin = var_5;
    wait 0.05;
    playFXOnTag(level._effect["_encstr_96010CDCDDB40E56AF474E584B8D"], self.meleeorigin, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.05;
    self.meleeorigin.origin = var_8;
    wait 0.05;
    self.meleeorigin.origin = var_4;
    thread applyradiusdamageasmelee(var_4);
    wait 0.05;
    self.meleeorigin.origin = var_10;
    wait 0.05;
    self.meleeorigin.origin = var_6;
    wait 0.05;
    stopFXOnTag(level._effect["_encstr_96010CDCDDB40E56AF474E584B8D"], self.meleeorigin, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }
}

applyradiusdamageasmelee(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_874B0D4B40B3BDBBF17E35290799E3");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = distance2d(self.origin, var_0) / 2;
  self radiusdamage(self.origin, var_1, 600, 300, self, "_encstr_8DED0A21C79B660BC7588981", "_encstr_B81913B4EEB9F5C95658C1AC9C3136858C567DDAE0");
}

use_masochist(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread removeslowmoveonlaststand(var_0);

  for(;;) {
    self waittill("_encstr_990C0F38C6859795397D2385B52CEC9519");
    scripts\cp\cp_persistence::give_player_currency(100, undefined, undefined, 1, "_encstr_B2B20686D0C0C3EB");
  }
}

use_explosive_touch(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  thread remove_explosive_touch(var_0);

  for(;;) {
    if(!istrue(self.has_explosive_touch)) {
      self.has_explosive_touch = 1;
      thread watch_for_zombie_touch(var_0);
      scripts\cp\utility::adddamagemodifier("_encstr_8FF90DDB5051ECC359200E451057FB", 0.1, 0);
      self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
      self playlocalsound("_encstr_AB62189EC2279951A452B8E829FC3BD1C36C1685298B86438DEB");
    }

    waitframe();
  }
}

watch_for_zombie_touch(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");

  while(istrue(self.has_explosive_touch)) {
    var_1 = scripts\cp\cp_agent_utils::get_alive_enemies();

    foreach(var_3 in var_1) {
      if(scripts\engine\utility::distance_2d_squared(var_3.origin, self.origin) <= 5184) {
        var_3.exp_touch = 1;

        if(var_3 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }
        if(var_3 scripts\cp\utility::is_zombie_agent() && (!istrue(var_3.is_skeleton) && var_3.agent_type != "_encstr_9BE008764102938025A5" && var_3.agent_type != "_encstr_97630D0B93F8274B3E8D82ABA81D73" && var_3.agent_type != "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" && var_3.agent_type != "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B")) {
          var_3.nocorpse = 1;
          var_3.full_gib = 1;
          playsoundatpos(var_3 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"), "_encstr_8C441EE95B89EB669B99FAB2C3C1C6F6E6A5CEB2D7E87BABD834EB950F1C1BF6");
          wait 0.1;
          playFX(scripts\engine\utility::getfx("_encstr_B8410ACFB37BA850BF5F9EE0"), var_3 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"));
          self radiusdamage(self.origin, 100, var_3.maxhealth, 1000, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A63217A09B234F591B7031B86B87E3F3911318D8B28C17F267");
          wait 0.3;
        }
      }
    }

    waitframe();
  }
}

remove_explosive_touch(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A5(var_0 + "_encstr_A70608A76C4C78BDDF03", var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self.has_explosive_touch = 0;
  scripts\cp\utility::removedamagemodifier("_encstr_8FF90DDB5051ECC359200E451057FB", 0);

  if(isDefined(self.explosivetrigger))
    self.explosivetrigger delete();
}

use_shared_fate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self.marked_ents = [];
  thread look_at_and_outline_enemies(var_0);
  thread outline_enemeies(var_0);
  thread damage_on_marked_enemies(var_0);
}

damage_on_marked_enemies(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");

  for(;;) {
    self waittill("_encstr_BDAB1934D79A6968EE073020B307E08313FCA53521A313F3CF07D8", var_1, var_2, var_3, var_4, var_5);
    self.marked_ents = scripts\engine\utility::array_removeundefined(self.marked_ents);
    self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var_5);

    foreach(var_7 in self.marked_ents) {
      if(var_5 == var_7) {
        continue;
      }
      if(var_7.health >= var_7.maxhealth)
        var_7 setscriptablepartstate("_encstr_A5BF0F128B6FF2CF52F7CED9397B504FA2", "_encstr_8882099673858D1D4B6756", 1);

      self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var_7);
      var_7 dodamage(var_2, var_7.origin, var_1, var_1, var_3, "_encstr_91A61703A703317E63AAFB01E2E7BC886B0DE7A75D7E904853");
    }
  }
}

play_vfx_between_points_marked(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_3 = spawnfx(scripts\engine\utility::getfx("_encstr_964A15FBD1E0FE2BF0498E0F65C1872B77E995EFE76F70"), var_1);
    triggerfx(var_3);
  }

  if(isDefined(var_2)) {
    var_4 = spawnfx(scripts\engine\utility::getfx("_encstr_964A15FBD1E0FE2BF0498E0F65C1872B77E995EFE76F70"), var_2);
    triggerfx(var_4);
  }

  wait 3;

  if(isDefined(var_3))
    var_3 delete();

  if(isDefined(var_4))
    var_4 delete();
}

deletevfx(var_0) {
  scripts\engine\utility::_id_143A5(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0", var_0 + "_encstr_A70608A76C4C78BDDF03");
}

outline_enemeies(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");

  for(;;) {
    foreach(var_2 in self.marked_ents) {
      if(var_2 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }
      if(isDefined(var_2.agent_type) && (var_2.agent_type == "_encstr_8D7811402FFDC15BD2A9CEDFBA4BBB694CA758" || var_2.agent_type == "_encstr_9BE008764102938025A5" || var_2.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73" || var_2.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_2.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_2.agent_type == "_encstr_88EC0D4FEDB5C4B456AF3636BDBBDC" || var_2.agent_type == "_encstr_824C070F170FFBDD20")) {
        continue;
      }
      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc2_melee(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      if(istrue(var_2.marked_shared_fate_fnf)) {
        var_2 setscriptablepartstate("_encstr_A5BF0F128B6FF2CF52F7CED9397B504FA2", "_encstr_930B07BB1B6B3854FF", 1);
        continue;
      }

      if(isDefined(var_2))
        var_2 setscriptablepartstate("_encstr_A5BF0F128B6FF2CF52F7CED9397B504FA2", "_encstr_8882099673858D1D4B6756", 1);
    }

    waitframe();
  }
}

look_at_and_outline_enemies(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  var_1 = 0;

  for(;;) {
    if(self adsButtonPressed() && !var_1) {
      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      var_1 = 1;
      var_2 = self getplayerangles();
      var_3 = self getEye();
      var_4 = anglesToForward(var_2);
      var_5 = var_3 + var_4 * 500;
      var_6 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0);
      var_7 = physics_raycast(var_3, var_5, var_6, self, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

      if(var_7.size <= 0) {
        waitframe();
        continue;
      }

      var_8 = var_7[0]["_encstr_850E077B0BF30318B9"];

      if(isDefined(var_8)) {
        if(isDefined(var_8.agent_type) && (var_8.agent_type == "_encstr_8D7811402FFDC15BD2A9CEDFBA4BBB694CA758" || var_8.agent_type == "_encstr_9BE008764102938025A5" || var_8.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73" || var_8.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_8.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_8.agent_type == "_encstr_88EC0D4FEDB5C4B456AF3636BDBBDC")) {
          continue;
        }
        if(var_8 scripts\cp\utility::is_zombie_agent()) {
          if(!scripts\engine\utility::array_contains(self.marked_ents, var_8)) {
            self playlocalsound("_encstr_A3581E3A6583E6DD8D7AD9B0B266ADF9F32F4C3FD4272E09B4725850DABF5113");
            var_8.marked_shared_fate_fnf = 1;
            self.marked_ents = scripts\engine\utility::array_add(self.marked_ents, var_8);
          }
        }
      }

      var_1 = 0;
    } else
      var_1 = 0;

    waitframe();
  }
}

use_fire_chains(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var_1 = "_encstr_8EEC09159F6238030BFA23";
  var_2 = ["_encstr_8EEC09159F6238030BFA23", "_encstr_813B0D4027B390B37585BBC819FD28", "_encstr_83890D9CA8EF0B79D830939788913A", "_encstr_AADA07DBF19A4A81D7", "_encstr_BD500A3C087F4AD519410B6F", "_encstr_AC500A7A366A5BBFC04F9465", "_encstr_A78B0B4D7DAC6398F6DDEB27A5", "_encstr_8D8B0B309FA99B7EFA735F68F1", "_encstr_A1D50BD4BE2CDC6D36B2EBC695", "_encstr_83D50BE2875F1037FDBA096892", "_encstr_A1190BD4FABB9396DC47EB8DAC", "_encstr_83190BED4757A3B3B20C5E83E0"];
  thread removefirechainsdamagemodifierontimeout(var_0);
  thread removefirechainsdamagemodifieronlaststand(var_0);
  var_3 = self;

  for(;;) {
    var_4 = getfirechainstarget(self);

    if(isDefined(var_4)) {
      self.besttarget = var_4;
      self.linked_to_player = 1;
      thread playfirechainsfx(var_4, var_1, var_0);
      var_3.life_link_active = 1;
      linktoplayer_fire_chains(self, var_4, var_2);
    } else {
      var_3.life_link_active = undefined;
      wait 0.5;
    }

    waitframe();
  }
}

getfirechainstarget(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_6 = sighttracepassed(var_0 getEye(), var_5 getEye(), 0, var_0);

    if(!var_6) {
      continue;
    }
    if(istrue(var_5.inlaststand)) {
      continue;
    }
    var_3 = var_5;
    break;
  }

  return var_3;
}

linktoplayer_fire_chains(var_0, var_1, var_2) {
  while(istrue(var_0.linked_to_player)) {
    thread deal_damage_to_zombies_entering_the_link(self, var_2);

    if(istrue(var_1.inlaststand)) {
      var_0.linked_to_player = undefined;
      var_0 notify("_encstr_B186182BE0F3D451411F2A677539298ED890875F284839FA5D2E");
      break;
    } else if(distance(var_0.origin, var_1.origin) > 512) {
      var_0.linked_to_player = undefined;
      var_0 notify("_encstr_B186182BE0F3D451411F2A677539298ED890875F284839FA5D2E");
      break;
    }

    waitframe();
  }
}

deal_damage_to_zombies_entering_the_link(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\trace::create_character_contents();
  var_2 = [var_0, var_0.besttarget];

  foreach(var_5 in var_1) {
    var_6 = scripts\engine\trace::ray_trace(var_0 gettagorigin(var_5), var_0.besttarget gettagorigin(var_5), var_2, var_3);

    if(isDefined(var_6["_encstr_850E077B0BF30318B9"])) {
      if(var_6["_encstr_850E077B0BF30318B9"] scripts\cp\utility::is_zombie_agent() && (!istrue(var_6["_encstr_850E077B0BF30318B9"].is_skeleton) && var_6["_encstr_850E077B0BF30318B9"].agent_type != "_encstr_9BE008764102938025A5" && var_6["_encstr_850E077B0BF30318B9"].agent_type != "_encstr_97630D0B93F8274B3E8D82ABA81D73" && var_6["_encstr_850E077B0BF30318B9"].agent_type != "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" && var_6["_encstr_850E077B0BF30318B9"].agent_type != "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B")) {
        scripts\engine\utility::array_add(var_2, var_6["_encstr_850E077B0BF30318B9"]);
        var_6["_encstr_850E077B0BF30318B9"].nocorpse = 1;
        var_6["_encstr_850E077B0BF30318B9"].full_gib = 1;
        var_6["_encstr_850E077B0BF30318B9"] dodamage(1000000, var_6["_encstr_850E077B0BF30318B9"].origin, var_0, var_0);
      }
    }
  }
}

playfirechainsfx(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players)
  var_3[var_3.size] = playfxontagsbetweenclients(level._effect["_encstr_AB7D0C4E936BB7C9DF501A928817"], self, var_1, var_0, var_1, var_5);

  self.fx_array_fire_chains = var_3;
  self playLoopSound("_encstr_992F1785C752D848EE1F6659C4DA9810FA7B2B2BB32B802028");
  var_0 playLoopSound("_encstr_992F1785C752D848EE1F6659C4DA9810FA7B2B2BB32B802028");
  var_7 = scripts\engine\utility::waittill_any_ents_return(self, "_encstr_8D820B49520F0EC02DDE6367EC", self, "_encstr_B186182BE0F3D451411F2A677539298ED890875F284839FA5D2E", self, "_encstr_8CBE0BD1BED30936AB03C0B02B", self, var_2 + "_encstr_A70608A76C4C78BDDF03", var_0, "_encstr_8D820B49520F0EC02DDE6367EC", var_0, "_encstr_8CBE0BD1BED30936AB03C0B02B", level, "_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self))
    self stoploopsound();

  if(isDefined(var_0))
    var_0 stoploopsound();

  foreach(var_9 in var_3) {
    if(isDefined(var_9))
      var_9 delete();
  }
}

removefirechainsdamagemodifieronlaststand(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player))
    self.linked_to_player = undefined;

  self notify(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
}

removefirechainsdamagemodifierontimeout(var_0) {
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self waittill(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player))
    self.linked_to_player = undefined;
}

use_irish_luck(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
}

irish_luck_choose_random_consumable(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.stored_fnf))
    var_0.stored_fnf = [];

  foreach(var_3, var_2 in var_0.consumables)
  var_0.stored_fnf[var_3] = var_3;

  for(;;) {
    var_4 = scripts\engine\utility::random(level.irish_luck_consumables);

    if(scripts\engine\utility::array_contains(var_0.stored_fnf, var_4.name)) {
      waitframe();
      continue;
    } else {
      waitframe();
      return var_4;
    }

    waitframe();
  }
}

clear_omnvar(var_0) {
  wait 5;
  self setclientomnvar(var_0, 0);
}

consumable_activate_internal_irish(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACC90AC8072C23F5B2B919F5" + var_0);
  self endon("_encstr_843E0E571BFC929FC819737111B8EBCA");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level.random_consumable_chosen = irish_luck_choose_random_consumable(self);

  if(self.consumables[var_0].uses > 0 && self.consumables[var_0].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self.consumables[level.random_consumable_chosen.name] = spawnStruct();
    self.consumables[level.random_consumable_chosen.name].uses = level.consumables[level.random_consumable_chosen.name].uses;
    self.consumables[level.random_consumable_chosen.name].on = 1;
    self.consumables[level.random_consumable_chosen.name].times_used = 0;
    self.consumables[level.random_consumable_chosen.name].usednotify = var_4;
    level.random_consumable_chosen.ref = int(tablelookup("_encstr_AC022E3369B788A087D3B00317BB01B845D54B241DF4F03BCA58903BEBD048B2B740DFDDA3104A612753471B9E8F6B6C", 1, level.random_consumable_chosen.name, 0));
    self setclientomnvar("_encstr_A27D12587177AAB15BF09F67F8B36CE1CB966757", var_5);
    self.consumables[var_0].processing = 1;
    var_7 = undefined;
    var_8 = "_encstr_83090C07B008FDD2206F57BBBB5E";
    thread set_consumable(var_0);

    if(isDefined(level.consumables[level.random_consumable_chosen.name].usefunc)) {
      if(isDefined(level.consumables[level.random_consumable_chosen.name].testforsuccess))
        var_7 = self[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
      else
        var_7 = self thread[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
    }

    self.consumables[var_0].on = 0;

    if(!isDefined(var_7) || isDefined(var_7) && var_7) {
      consume_from_inventory(self, var_0);
      self.consumables[var_0].times_used++;
      scripts\cp\cp_merits::processmerit("_encstr_B2030CF0D44F236988CF05188277");
      thread scripts\cp\cp_vo::try_to_play_vo("_encstr_8A330FFC27F3C19BCAA9781092A2633837", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_BE19041BDEDD", 10, 0, 1, 0, 40);

      if(self.consumables[var_0].times_used == 1)
        thread decrement_counter_of_consumables(var_0);

      thread lightbar_off();
      self setclientomnvarbit("_encstr_965E15F4D6AF1BC29C19AF33A5B1C67D324BDCC1D80B5E", var_5, 1);
      remove_card_from_use(var_6);
      thread meter_fill_up();
      self playlocalsound("_encstr_82BF154BBCB7F0581237EBD3973A11181F92F1E027F3A3");
      play_consumable_activate_sound(self);
      self notify("_encstr_84B714C67BDCE6BAB55889D8CAAF6E2B36958D47CA32");
      self setweaponammostock(self.fate_card_weapon, 1);
      self giveandfireoffhand(self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_AAC6149B16B3BE579B59D73358D156C29B3299BDC947");
      var_9 = level.consumables[level.random_consumable_chosen.name].type;

      if(var_9 == "_encstr_AD22118EA5AD2BC8B08D8ED23B164796DBB96E")
        thread dpad_drain_time(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      else if(var_9 == "_encstr_A9F60584665BF3")
        thread dpad_drain_wave(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      else if(var_9 == "_encstr_B4590B8D98834CBFF2FDDA68E8" || level.consumables[level.random_consumable_chosen.name].type == "_encstr_A3BC0CA3B25908846A8BA793FF23")
        thread dpad_drain_activations(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].type, self.consumables[level.random_consumable_chosen.name].uses, var_1, var_8, var_2, var_3, var_4, var_5);
      else if(var_9 == "_encstr_A9DA0F1B3EDB7A77B988E3AFA8532133AB")
        thread dpad_drain_triggerpassive(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].passiveuses, var_1, var_8, var_2, var_3, var_4, var_5);

      if(isDefined(var_7)) {
        scripts\cp\utility::notify_used_consumable(var_0);
        return;
      }
    } else {
      self playlocalsound("_encstr_8C2A132F4878E6FF08EB6823FF5B20D9DF99C94843");
      self.consumables[var_0].processing = undefined;
    }
  }
}

use_temporal_increase(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self.temporal_increase = 2;
  thread remove_temporal_increase(var_0);
}

remove_temporal_increase(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A7(var_0 + "_encstr_A70608A76C4C78BDDF03", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_AD75063D571AE108", var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self.temporal_increase = undefined;
  return 1;
}

use_twister(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self getplayerangles();
  var_2 = self getEye();
  var_3 = (0, 0, 0);
  var_4 = anglesToForward(var_1);
  var_5 = var_2 + var_4 * 100;
  thread remove_twister(var_0, self);
  thread activate_twister_homing(self.origin, var_0);
}

remove_twister(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 scripts\engine\utility::_id_143A7(var_0 + "_encstr_A70608A76C4C78BDDF03", var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0", "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_AD75063D571AE108");
  level notify("_encstr_BE3B116EA3F638FA8EDDB437A3564EEBE6330F");

  if(isDefined(var_1.fx_ent))
    var_1.fx_ent delete();

  if(isDefined(var_1.trigger_move_ent))
    var_1.trigger_move_ent delete();
}

activate_twister_homing(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_1 + "_encstr_A70608A76C4C78BDDF03");
  self endon(var_1 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");

  if(!isDefined(self.twister_array_zombie))
    self.twister_array_zombie = [];

  self.trigger_move_ent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0, 0, 512, 128);
  self.trigger_move_ent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.trigger_move_ent_sfx = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0, 0, 512, 128);
  level.trigger_move_ent_sfx linkTo(self.trigger_move_ent);
  wait 0.5;
  level.trigger_move_ent_sfx thread twister_sfx();
  playFXOnTag(level._effect["_encstr_910E08D94774B01DB73B"], self.trigger_move_ent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.trigger_move_ent setotherent(self);
  self.trigger_move_ent thread deal_damage_to_enemies(self, var_1);
  thread move_ent_function(self.trigger_move_ent, var_1);
}

twister_sfx() {
  self playSound("_encstr_A6F915C2E62D610BD8FA909759B0D8433D0B0E1B5FF306");
  wait 0.4;
  self playLoopSound("_encstr_A5E9128DFB22E8E83FCA9049771779B9BBD76129");
  level waittill("_encstr_BE3B116EA3F638FA8EDDB437A3564EEBE6330F");
  level thread scripts\engine\utility::play_sound_in_space("_encstr_9566143D4B9258586F9AC0390747C9860BE789C73BBB", self.origin);
  wait 0.15;
  self stoploopsound();
  self delete();
}

get_zombie_targets(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon(var_1 + "_encstr_A70608A76C4C78BDDF03");
  var_0 endon(var_1 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");

  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::get_alive_enemies();
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 24, 2048);

    if(var_3.size <= 0) {
      waitframe();
      var_0.twister_array_zombie = [];
      var_0.twister_array_zombie[var_0.twister_array_zombie.size] = getclosestpointonnavmesh(self.origin) + (0, 10, 0);
      continue;
    } else {
      foreach(var_5 in var_3) {
        if(istrue(var_5.entered_playspace))
          var_0.twister_array_zombie = var_0 findpath(var_0.origin, scripts\engine\utility::drop_to_ground(var_3[var_3.size - 1].origin, 1, 1));
      }
    }

    wait 2.5;
  }
}

deal_damage_to_enemies(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon(var_1 + "_encstr_A70608A76C4C78BDDF03");
  var_0 endon(var_1 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::get_alive_enemies();

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(!var_4 scripts\cp\utility::is_zombie_agent()) {
        continue;
      }
      if(var_4 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }
      if(distance2dsquared(self.origin, var_4.origin) < 22500) {
        if(isDefined(var_4.agent_type) && (var_4.agent_type == "_encstr_9BE008764102938025A5" || var_4.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73")) {
          var_4 dodamage(1000, var_4.origin, var_0, var_0, "_encstr_BDB50C41D83F8F9F030B60E80F5B");
          continue;
        }

        var_4 thread fling_zombie_thundergun_harpoon(var_4.health + 1000, var_4, var_0, self);
      }
    }

    wait 1;
  }
}

fling_zombie_thundergun_harpoon(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_1.origin - var_3.origin;
  var_5 = anglestoup(self.angles);
  self setvelocity(vectorNormalize((var_3.origin - self.origin) * 400) + (0, 0, 800));
  wait 0.16;

  if(isDefined(var_2)) {
    var_1.do_immediate_ragdoll = 1;
    var_1.disable_armor = 1;
    var_1.customdeath = 1;
    wait 0.1;
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
    self dodamage(self.health + 1000, var_1.origin, var_2, var_2, "_encstr_BDB50C41D83F8F9F030B60E80F5B", "_encstr_A1390FBF7B06B9E1281C3BFD1572307308");
  } else {
    self.nocorpse = 1;
    self.full_gib = 1;
    self dodamage(self.health + 1000, var_1.origin, var_1, var_1, "_encstr_BDB50C41D83F8F9F030B60E80F5B", "_encstr_A1390FBF7B06B9E1281C3BFD1572307308");
  }
}

move_ent_function(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_1 + "_encstr_A70608A76C4C78BDDF03");
  self endon(var_1 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  var_2 = 0;
  thread get_zombie_targets(self, var_1);

  for(;;) {
    if(!isDefined(self.twister_array_zombie[var_2]) && var_2 >= self.twister_array_zombie.size) {
      if(self.twister_array_zombie.size > 0) {
        if(isDefined(self.twister_array_zombie[0])) {
          if([[level.active_volume_check]](self.twister_array_zombie[0]))
            var_0 moveTo(self.twister_array_zombie[0], 0.5, 0.25, 0);
          else {
            var_3 = getclosestpointonnavmesh(self.twister_array_zombie[0]) + (0, 10, 0);
            var_0 moveTo(var_3, 0.5, 0.25, 0);
          }

          var_2--;
        }
      } else
        var_2 = 0;

      waitframe();
      continue;
    } else
      var_0 moveTo(self.twister_array_zombie[var_2], 0.5, 0, 0);

    var_2 = var_2 + 1;
    waitframe();
  }
}

use_self_revive(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  scripts\cp\cp_laststand::enable_self_revive(self);
  thread removeselfreviveonearlyexit(var_0);

  for(;;) {
    self waittill("_encstr_A5F6170E6358CBACE4EBD02C6ED76E956333FAE42BECD2B3CA", var_1);

    if(var_1) {
      continue;
    }
    self waittill("_encstr_9695073995D94BD959");
    scripts\cp\cp_laststand::disable_self_revive(self);

    if(scripts\cp\utility::has_zombie_perk("_encstr_AB671357374BBF8E0DDF4808E756819F53DD4D54CC")) {
      self.maxhealth = 200;
      self.health = self.maxhealth;
    }

    scripts\cp\utility::notify_used_consumable(var_0);
    break;
  }
}

removeselfreviveonearlyexit(var_0) {
  self endon(var_0 + "_encstr_84380BDEF9C8A45AFC036B2761");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
  scripts\cp\cp_laststand::disable_self_revive(self);
}

use_welfare(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_persistence::get_player_currency();
  var_2 = int(var_1 / level.players.size);
  scripts\cp\cp_persistence::set_player_currency(var_2);

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    var_4 scripts\cp\cp_persistence::give_player_currency(var_2, undefined, undefined, 1, "_encstr_B2B20686D0C0C3EB");
  }

  scripts\cp\utility::notify_used_consumable(var_0);
  return 1;
}

use_increased_team_efficiency(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(level.consumable_cash_scalar))
    level.consumable_cash_scalar = 0;

  thread update_team_multiplier(var_0);
  thread cleanupaftertimeoutordeath(var_0);
  setomnvar("_encstr_8BA81C7A18BDB181F3DA8F7891CF4788650BC51020F5199BA958B823EAAE", 1);

  for(;;) {
    var_1 = scripts\engine\utility::_id_143AD("_encstr_AF8F0C1B6C17D8D0522F777F37EA", "_encstr_8AE911DDB2C20EDBB9F5A1A5E87DB2E659B62F");

    if(var_1 == "_encstr_AF8F0C1B6C17D8D0522F777F37EA")
      level.consumable_cash_scalar = level.consumable_cash_scalar - 0.02;
    else
      level.consumable_cash_scalar = level.consumable_cash_scalar + 0.02;

    if(level.consumable_cash_scalar < 0)
      level.consumable_cash_scalar = 0;

    self notify("_encstr_862617A32A03D9136AF1E8D941C8094DE48F149FCB038E2193");
  }
}

update_team_multiplier(var_0) {
  while(isDefined(level.consumable_cash_scalar)) {
    self waittill("_encstr_862617A32A03D9136AF1E8D941C8094DE48F149FCB038E2193");
    var_1 = 1 + level.consumable_cash_scalar;
    setomnvar("_encstr_8BA81C7A18BDB181F3DA8F7891CF4788650BC51020F5199BA958B823EAAE", var_1);
  }

  setomnvar("_encstr_8BA81C7A18BDB181F3DA8F7891CF4788650BC51020F5199BA958B823EAAE", -1);
}

cleanupaftertimeoutordeath(var_0) {
  var_1 = scripts\engine\utility::_id_143AF(var_0 + "_encstr_A70608A76C4C78BDDF03", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_AD75063D571AE108");
  level.consumable_cash_scalar = undefined;
}

use_slow_enemy_movement(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread removeslowmoveonlaststand(var_0);

  foreach(var_2 in scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A"))
  var_2 thread adjustmovespeed(var_2, var_0, self);

  for(;;) {
    level waittill("_encstr_A62B0E0EE493BA148EF0B3FF3840FDE2", var_4);
    var_4 thread adjustmovespeed(var_4, var_0, self, 1);
  }
}

adjustmovespeed(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.agent_type) && (var_0.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_0.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_0.agent_type == "_encstr_A60E0DA22F1BF540F8660F84DAD6A1")) {
    return;
  }
  if(istrue(var_0.is_suicide_bomber)) {
    return;
  }
  if(istrue(var_3))
    wait 0.5;

  if(!isDefined(var_0.asm.cur_move_mode))
    var_4 = var_0.movemode;
  else
    var_4 = var_0.asm.cur_move_mode;

  switch (var_4) {
    case "_encstr_97BC0AB9C67BDD7DDD851B6D":
      break;
    case "_encstr_99F605EE16B1DA":
    case "_encstr_B4190493D573":
    case "_encstr_92100762872552A643":
      var_0 scripts\asm\asm_bb::bb_requestmovetype("_encstr_97BC0AB9C67BDD7DDD851B6D");
      break;
  }

  var_2 scripts\engine\utility::_id_143A6(var_1 + "_encstr_A70608A76C4C78BDDF03", "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 scripts\asm\asm_bb::bb_requestmovetype(var_4);
}

removeslowmoveonlaststand(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self notify(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
}

use_life_link(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var_1 = "_encstr_8EEC09159F6238030BFA23";
  thread removedamagemodifierontimeout(var_0);
  thread removedamagemodifieronlaststand(var_0);
  var_2 = self;

  for(;;) {
    var_3 = getlifelinktarget(self);

    if(isDefined(var_3)) {
      self notify("_encstr_8E2D0CCA70EF1B7F7347828F6D5B", var_3);
      self.linked_to_player = 1;
      thread playlifelinkfx(var_3, var_1, var_0);
      var_2.life_link_active = 1;
      linktoplayer(self, var_3);
      continue;
    }

    var_2.life_link_active = undefined;
    wait 0.5;
  }
}

getlifelinktarget(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_6 = sighttracepassed(var_0 getEye(), var_5 getEye(), 0, var_0);

    if(!var_6) {
      continue;
    }
    if(istrue(var_5.inlaststand)) {
      continue;
    }
    var_3 = var_5;
    break;
  }

  return var_3;
}

linktoplayer(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(istrue(var_0.linked_to_player)) {
    if(istrue(var_1.inlaststand)) {
      var_0.linked_to_player = undefined;
      var_0 notify("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
      break;
    } else if(distance(var_0.origin, var_1.origin) > 512) {
      var_0.linked_to_player = undefined;
      var_0 notify("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
      break;
    } else {
      var_2 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0);

      if(!var_2) {
        var_0.linked_to_player = undefined;
        var_0 notify("_encstr_8E2D0CCA70EF1B7F7347828F6D5B");
      }
    }

    wait 0.25;
  }
}

playlifelinkfx(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = [];
  playFXOnTag(level._effect["_encstr_B61911364B3359BE6396375BF5D11693B3CAE8"], var_0, var_1);

  foreach(var_5 in level.players)
  var_3[var_3.size] = playfxontagsbetweenclients(level._effect["_encstr_845C0AA074561898FAE79587"], self, var_1, var_0, var_1, var_5);

  self playLoopSound("_encstr_BE0C19CD8F1A907026D7BED03C1650B1021B677F73B247687F2D43");
  var_0 playLoopSound("_encstr_BE0C19CD8F1A907026D7BED03C1650B1021B677F73B247687F2D43");
  var_7 = scripts\engine\utility::waittill_any_ents_return(self, "_encstr_8D820B49520F0EC02DDE6367EC", self, "_encstr_8E2D0CCA70EF1B7F7347828F6D5B", self, "_encstr_8CBE0BD1BED30936AB03C0B02B", self, var_2 + "_encstr_A70608A76C4C78BDDF03", var_0, "_encstr_8D820B49520F0EC02DDE6367EC", var_0, "_encstr_8CBE0BD1BED30936AB03C0B02B", level, "_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self))
    self stoploopsound();

  if(isDefined(var_0))
    var_0 stoploopsound();

  foreach(var_9 in var_3) {
    if(isDefined(var_9))
      var_9 delete();
  }

  if(isDefined(var_0))
    killfxontag(level._effect["_encstr_B61911364B3359BE6396375BF5D11693B3CAE8"], var_0, var_1);
}

removedamagemodifieronlaststand(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player))
    self.linked_to_player = undefined;

  self notify(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
}

removedamagemodifierontimeout(var_0) {
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self waittill(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player))
    self.linked_to_player = undefined;
}

use_phoenix_up(var_0) {
  var_1 = level.players;
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_5 = var_4;

    if(isDefined(var_4.owner))
      var_5 = var_4.owner;

    if(scripts\cp\cp_laststand::player_in_laststand(var_5)) {
      var_2 = 1;
      scripts\cp\cp_laststand::instant_revive(var_5);
      scripts\cp\cp_laststand::record_revive_success(self, var_5);
    }
  }

  if(!var_2) {
    self.consumables["_encstr_BE140B8343EDCA374B87BE5DC1"].on = 0;
    waitframe();
    return 0;
  }

  wait 0.25;
  scripts\cp\utility::notify_used_consumable("_encstr_BE140B8343EDCA374B87BE5DC1");
  return 1;
}

use_killing_time(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.killing_time))
      var_2.killing_time = 0;

    var_2.killing_time++;
  }

  waitframe();
  scripts\cp\utility::notify_used_consumable("_encstr_AD410DB55A6363D2CDCEF547B4B5B2");
  scripts\engine\utility::_id_143BB(20, "_encstr_AD75063D571AE108", "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_8D820B49520F0EC02DDE6367EC");

  foreach(var_2 in level.players) {
    if(isDefined(var_2.killing_time)) {
      var_2.killing_time--;

      if(var_2.killing_time <= 0)
        var_2.killing_time = undefined;
    }
  }
}

use_now_you_see_me(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread removenowyouseemeonlaststand(var_0);

  foreach(var_2 in level.players) {
    if(var_2 == self) {
      if(var_2 scripts\cp\utility::isignoremeenabled())
        var_2 scripts\cp\utility::allow_player_ignore_me(0);

      continue;
    }

    var_2 scripts\cp\utility::allow_player_ignore_me(1);
  }

  wait 10;

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::isignoremeenabled())
      var_2 scripts\cp\utility::allow_player_ignore_me(0);
  }
}

removenowyouseemeonlaststand(var_0) {
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  var_1 = scripts\engine\utility::_id_143AD("_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_8D820B49520F0EC02DDE6367EC");

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::isignoremeenabled())
      var_3 scripts\cp\utility::allow_player_ignore_me(0);
  }

  if(isDefined(var_1) && var_1 == "_encstr_8CBE0BD1BED30936AB03C0B02B")
    self notify(var_0 + "_encstr_A64C0EC67748780D6AD3F79BDF4359B0");
}

use_anywhere_but_here(var_0) {
  if(!scripts\cp\utility::isteleportenabled()) {
    self.consumables["_encstr_A7011211786BF78B527BAA3998DFEB3759153AFA"].on = 0;
    return 0;
  }

  if(istrue(self.is_in_pap)) {
    self.consumables["_encstr_A7011211786BF78B527BAA3998DFEB3759153AFA"].on = 0;
    return 0;
  }

  var_1 = level.active_player_respawn_locs;
  var_1 = scripts\engine\utility::array_remove_duplicates(var_1);

  foreach(var_3 in level.active_player_respawn_locs) {
    var_4 = [[level.get_spawn_volume_func]]();

    foreach(var_6 in var_4) {
      if(ispointinvolume(var_3.origin, var_6))
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  if(var_1.size < 1)
    var_1 = level.active_player_respawn_locs;

  var_9 = self[[level.get_respawn_loc_rated]](level.players, var_1);

  if(!isDefined(var_9)) {
    self.consumables["_encstr_A7011211786BF78B527BAA3998DFEB3759153AFA"].on = 0;
    return 0;
  }

  scripts\cp\cp_interaction::refresh_interaction();
  scripts\cp\cp_powers::power_enablepower();
  self forceusehintoff();
  self setOrigin(var_9.origin);
  self setplayerangles(var_9.angles);
  self notify("_encstr_9BC817E32FA825712498A84D22167713B0F780570ACAEA59F7");
  scripts\cp\utility::notify_used_consumable("_encstr_A7011211786BF78B527BAA3998DFEB3759153AFA");
  self.abh_used = gettime();
  return 1;
}

jumptoanywherebutherespawns(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.players[0] endon("_encstr_AD75063D571AE108");
  level.players[0] endon("_encstr_8CBE0BD1BED30936AB03C0B02B");

  foreach(var_2 in level.active_player_respawn_locs) {
    level.players[0] scripts\cp\cp_interaction::refresh_interaction();
    level.players[0] scripts\cp\cp_powers::power_enablepower();
    level.players[0] forceusehintoff();
    level.players[0] setOrigin(var_2.origin);
    level.players[0] setplayerangles(var_2.angles);
    wait 2;
  }
}

use_headshot_reload(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0 + "_encstr_A70608A76C4C78BDDF03");
  self.headshot_reload_time = gettime();
}

headshot_reload_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!scripts\cp\utility::is_consumable_active("_encstr_8F3010BBD79A41EBE8C7D091AB3DC09F223F"))
    return 0;

  if(!scripts\engine\utility::isbulletdamage(var_3))
    return 0;

  if(!scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1))
    return 0;

  var_9 = self getcurrentweapon();
  var_10 = self getweaponammostock(var_9);
  var_11 = weaponclipsize(var_9);
  var_12 = self getweaponammoclip(var_9);
  var_13 = var_11 - var_12;

  if(var_10 >= var_13)
    self setweaponammostock(var_9, var_10 - var_13);
  else {
    var_11 = var_10;
    self setweaponammostock(var_9, 0);
  }

  var_14 = var_11;
  var_15 = min(var_12 + var_14, var_11);
  self setweaponammoclip(var_9, int(var_15));

  if(self isdualwielding()) {
    var_12 = self getweaponammoclip(var_9, "_encstr_A5AD056A019C63");
    var_15 = min(var_12 + var_14, var_11);
    self setweaponammoclip(var_9, int(var_15), "_encstr_A5AD056A019C63");
  }
}

use_grenade_cooldown(var_0) {
  self.power_cooldowns = 1;
  scripts\cp\cp_powers::power_adjustcharges(1, "_encstr_BA7F0830B3A7859B60B0");
  var_1 = getarraykeys(self.powers);

  foreach(var_3 in var_1)
  self.powers[var_3].cooldownratemod = 1;
}

turn_off_grenade_cooldown(var_0) {
  self.power_cooldowns = 0;
}

write_consumable_used(var_0, var_1) {
  if(!isDefined(var_0.consumables)) {
    return;
  }
  var_2 = 0;

  foreach(var_6, var_4 in var_0.consumables_pre_irish_luck_usage) {
    var_5 = get_consumable_loot_id(var_6);
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_1, "_encstr_A2B70A6C2C9391DC559B9523", var_2, "_encstr_A78C088DBDEDA3D79411", int(var_5));
    setclientmatchdata("_encstr_8BB007E03658CBCAE4", var_1, "_encstr_A2B70A6C2C9391DC559B9523", var_2, "_encstr_916812DCBAD6D7DB33EBE85AD62BDCEB5D37ACC8", var_4.times_used);
    var_2++;
  }
}

get_consumable_loot_id(var_0) {
  return tablelookup("_encstr_AC022E3369B788A087D3B00317BB01B845D54B241DF4F03BCA58903BEBD048B2B740DFDDA3104A612753471B9E8F6B6C", 1, var_0, 0);
}

set_consumable(var_0) {
  return self[[level.consumables[var_0].set]](var_0);
}

unset_consumable(var_0) {
  self[[level.consumables[var_0].unset]](var_0);
}