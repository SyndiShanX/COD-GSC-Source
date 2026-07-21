/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_munitions.gsc
***********************************************/

init_munitions() {
  level.register_munitions_interaction = ::create_munitions_interaction;
  level.ammoincompatibleweaponslist = ["_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0"];
  read_munition_table();
  setdvarifuninitialized("_encstr_92FA1298139B51E580D192026BE81DF827E9A370", 0);
  level.unlimitedmunitions = getdvarint("_encstr_92FA1298139B51E580D192026BE81DF827E9A370", 0);
}

read_munition_table() {
  level.munitions_table_data = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_842E18F25FFAC10F80357B80A1089F321A09275A52AD6023C32B", var_0, 1);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    level.munitions_table_data[var_1] = spawnStruct();
    level.munitions_table_data[var_1].index = int(tablelookupbyrow("_encstr_842E18F25FFAC10F80357B80A1089F321A09275A52AD6023C32B", var_0, 0));
    level.munitions_table_data[var_1].ref = var_1;
    level.munitions_table_data[var_1].cost = int(tablelookupbyrow("_encstr_842E18F25FFAC10F80357B80A1089F321A09275A52AD6023C32B", var_0, 4));
    level.munitions_table_data[var_1].cooldown = float(tablelookupbyrow("_encstr_842E18F25FFAC10F80357B80A1089F321A09275A52AD6023C32B", var_0, 5));
    var_0++;
  }
}

givemunitionfromluinotify() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.dpad_selection_index = 0;
  var_0 = 3;
  var_1 = 3;

  if(istrue(level.unlimitedmunitions))
    var_1 = 1;

  self setplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD", var_1);

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_2, var_3);

    if(var_2 == "_encstr_9B1615A28F89D229C0A9EFF718DBDF5A7390ECDB63371A") {
      var_4 = 0;

      if(!_id_12474(var_4)) {
        continue;
      }
      if(var_3 >= 0 && var_3 <= 2) {
        var_5 = self.munition_slots[var_3];

        if(isDefined(var_5) && var_5.ref != "_encstr_8BBA05185F8B99" && var_5.ref != "_encstr_8E8A07AFE30F7349A2" && var_5.ref != "_encstr_828A0759AD88584327" && var_5.ref != "_encstr_928A072B57E3DD20C3") {
          if(istrue(can_use_munition(var_3))) {
            if(scripts\cp\cp_weapon::_id_124AD(self)) {
              var_6 = _id_132C9(var_5.ref);

              if(var_6) {
                self.modeusesgroundwarteamoobtriggers = 1;
                scripts\cp\cp_weapon::minigamefinishcount(self);
                self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

                while(scripts\cp\cp_weapon::_id_124AD(self))
                  waitframe();

                self.modeusesgroundwarteamoobtriggers = undefined;

                if(!_id_12474(var_4))
                  continue;
              }
            }

            thread _id_12BDF(var_5.ref, var_3);
            var_7 = scripts\cp\crafting_system::giveitembasedoncraftingstruct(var_5.ref);

            if(var_7) {
              if(triplecheck_jugg_spawned(var_5.ref))
                self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", var_5.ref);

              scripts\cp\cp_analytics::_id_119B6(self, var_5.ref);
            } else
              self notify("_encstr_855F17C995B5DECE597DD6AE37A5E8B4F6CDD7DE9BD7D537AC");
          }
        }
      }
    }
  }
}

_id_12474(var_0) {
  if(istrue(level.disable_munitions)) {
    scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
    return 0;
  }

  if(!isDefined(self.munition_slots)) {
    if(var_0)
      iprintlnbold("_encstr_B8D81E033F8DB7C5BB7338C29343F82039CE23C0346290F3989B9BCE90020702");

    return 0;
  }

  if(self isonladder()) {
    if(var_0)
      iprintlnbold("_encstr_ACAC14BB37B12B4C5921F0CBF22059E90AFF5B603A4D");

    return 0;
  }

  if(istrue(self.spectating)) {
    if(var_0)
      iprintlnbold("_encstr_AB23108F8B095A16A8237FC69B0B7462D017");

    return 0;
  }

  if(isDefined(self.currentpiece)) {
    if(var_0)
      iprintlnbold("_encstr_AFC11A0F0B89DA96A8033A0239F8F471D393C7AF692552969008F78F");

    return 0;
  }

  if(istrue(self.is_fast_traveling)) {
    if(var_0)
      iprintlnbold("_encstr_835417E6956366C52D377D9958E6A37D1D39C2B359C65ACD76");

    return 0;
  }

  if(istrue(self.inlaststand)) {
    if(var_0)
      iprintlnbold("_encstr_88C311F369F153459805AC891758D2C3AFE07A");

    return 0;
  }

  if(istrue(self.trackriotshield_tryback)) {
    if(var_0)
      iprintlnbold("_encstr_ABA21BDC5663CC5CB473E647169BA3BE39593B5A9DACF589D5999959E4");

    return 0;
  }

  if(istrue(self.isreviving)) {
    if(var_0)
      iprintlnbold("_encstr_853C10B2C1080E86EBBF1BDFAD834B4960E9");

    return 0;
  }

  if(isDefined(self.placementmodel)) {
    if(var_0)
      iprintlnbold("_encstr_B8331CF8FDA0EADAA765E9AA9DE8F28878BD1D836B4268F11DF782687A67");

    return 0;
  }

  if(istrue(self.iscarrying)) {
    if(var_0)
      iprintlnbold("_encstr_A3B4100271B8BE367B2FCF3F559E0BF9F099");

    return 0;
  }

  if(isDefined(self.hostagecarried)) {
    if(var_0)
      iprintlnbold("_encstr_A62B1C8AE5813A4E6810BFAB8861FD90738652845DC9164C9160CF3BB039");

    return 0;
  }

  if(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318") {
    if(var_0)
      iprintlnbold("_encstr_A1371BAB5A031AD1E29F797115F3235B09AA8289FFE8A3C74ACDA2140A");

    return 0;
  }

  if(istrue(self.bgivensentry)) {
    if(var_0)
      iprintlnbold("_encstr_8C3C1298521DC5C89B5FAB1C55832F9BC52BE840");

    return 0;
  }

  if(istrue(self.tablet_out)) {
    if(var_0)
      iprintlnbold("_encstr_B6CE1037B28D6671D1C298D8B21D7DF6BAA3");

    return 0;
  }

  if(istrue(self.b_in_vehicle)) {
    if(var_0)
      iprintlnbold("_encstr_BA4912F34BE01F32BE7E0A42468C57D4902F946D");

    scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
    return 0;
  }

  if(istrue(self.waiting_to_spawn)) {
    if(var_0)
      iprintlnbold("_encstr_870D16CD561B3317BB16961D2DCDEC7DE8DEFA6E0EC2EEB9");

    return 0;
  }

  if(self isparachuting()) {
    if(var_0)
      iprintlnbold("_encstr_83EB15FFFB194A08697302564BF093626D211F135793E6");

    return 0;
  }

  if(self isskydiving()) {
    if(var_0)
      iprintlnbold("_encstr_96AA1337B2363380A4374D5BE58CB4EC4BE6ECA094");

    return 0;
  }

  if(isDefined(self.currentturret)) {
    if(var_0)
      iprintlnbold("_encstr_84511BB7C792642A033B233B27E630B5FB732D133BFE3D085E14A8D18F");

    return 0;
  }

  if(istrue(self.respawn_in_progress)) {
    if(var_0)
      iprintlnbold("_encstr_B1461428EA6221E917BEC76B8672F3EDCD52A06863BA");

    return 0;
  }

  if(istrue(self.isjuggernaut)) {
    if(var_0)
      iprintlnbold("_encstr_A1111238F2BD656817CB9A7DB7474915651AB088");

    return 0;
  }

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    if(var_0)
      iprintlnbold("_encstr_AD651DD30DF262FEC9802015839FAD4FEB400E1E6F93207FB871BBE073F9FB");

    scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
    return 0;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    if(var_0)
      iprintlnbold("_encstr_B6E71522B0304162166987A35131EA8340D11AAB89E0E4");

    return 0;
  }

  if(istrue(self.islockedinkidnapanim)) {
    if(var_0)
      iprintlnbold("_encstr_BE3F1AD755351830872B9CE032575DC084A62F7BFC1D78674FD230A8");

    return 0;
  }

  if(self isjumping()) {
    if(var_0)
      iprintlnbold("_encstr_BEAC119BD013733109AE234FD7F3BC3E9FAAD3");

    return 0;
  }

  if(!self isonground()) {
    if(var_0)
      iprintlnbold("_encstr_849E166830B9B35EEB984B8A73E04CFABDDB604BDABA103E");

    return 0;
  }

  if(istrue(self._id_140AE)) {
    if(var_0)
      iprintlnbold("_encstr_96F5112EFD2B51FDFB9BF8C8B21D1DA8676335");

    return 0;
  }

  if(istrue(self.try_to_punish_with_jugg)) {
    if(var_0)
      iprintlnbold("_encstr_A95E14DCB28DCC5C969BD79C9691D2CD767D432B36B4");

    return 0;
  }

  if(istrue(level._id_12B46)) {
    if(var_0)
      iprintlnbold("_encstr_858649F9D96F4460359D0199A41DBA97138248D9669F05208A7423199842F877DBBA63C1EA1B354036551B15C96B4BA84BF391EBA2B3F99A7A422707ED9288C73F6B19B16AEF2FB0D73CCB");

    return 0;
  }

  if(istrue(self.modeusesgroundwarteamoobtriggers)) {
    if(var_0)
      iprintlnbold("_encstr_8D6017C379D88D2B8F298B42B3FF7745D0B96571F57097B740");

    return 0;
  }

  if(istrue(self.super_activated)) {
    if(self.super == "_encstr_8B290C93058CC8486A2725E99F33" || self.super == "_encstr_AB5C0E833A7B7539E7D67F7BCECFA046") {
      if(var_0)
        iprintlnbold("_encstr_8F411BC24F237AEB228772B963948B8B69E6DB8F798329831F1B534BD5");

      return 0;
    }
  }

  if(istrue(self.gascoughinprogress)) {
    if(var_0)
      iprintlnbold("_encstr_ACB316FFEF12E26040138140F799EDBA2AB22067034D9BDB");

    return 0;
  }

  if(istrue(self._id_140AB)) {
    if(var_0)
      iprintlnbold("_encstr_856715EB780BCD63C97DB3D198491AD56B73F21308EF85");

    return 0;
  }

  if(!scripts\common\input_allow::is_input_allowed_internal("_encstr_A1760D221BB8AF4350FB44519F388A")) {
    if(var_0)
      iprintlnbold("_encstr_AD291A6ABBF88FE353AFC24397D7ADC2899A9DDBBF5040109523B2C1");

    scripts\cp\utility::hint_prompt("_encstr_B80815D5956040580435FEB1A015E3935F5B845E2AA57F", 1, 2);
    return 0;
  }

  return 1;
}

_id_132C9(var_0) {
  return 1;
}

_id_12BDF(var_0, var_1) {
  self notify("_encstr_855F17C995B5DECE597DD6AE37A5E8B4F6CDD7DE9BD7D537AC");
  self endon("_encstr_855F17C995B5DECE597DD6AE37A5E8B4F6CDD7DE9BD7D537AC");

  if(istrue(level.unlimitedmunitions)) {
    return;
  }
  thread _id_1301A(var_0, var_1);
  self waittill("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", var_0);
  remove_munition(var_1, var_0);
}

_id_1301A(var_0, var_1) {
  switch (var_0) {
    case "_encstr_88CD07337F8B2B8083":
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
      self waittill("_encstr_862D14866BBF6318C1E0071F2058CEFA5D688B3A45C1");
      break;
    case "_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9":
      self endon("_encstr_88361491F9C0A8106BDFB027C56A9B092052C1F39B9A");
      self endon("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32");
      self waittill("_encstr_AACC12E885C6FAD87B9DAC9CEBCD830BEEE65691");
      break;
    default:
      return;
  }

  self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", var_0);
}

triplecheck_jugg_spawned(var_0) {
  switch (var_0) {
    case "_encstr_886B0D58B2B56F2019B79BDBA305EB":
    case "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD":
    case "_encstr_A937066AFF52FA4F":
    case "_encstr_851904B59B34":
      return 1;
  }

  return 0;
}

mun_test_monitor() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = level.disable_nvg;

  for(;;) {
    var_1 = getDvar("_encstr_86400DE78F23A860658DF6AB774BE0", "_encstr_B40101");

    if(var_1 != "_encstr_B40101") {
      level.disable_nvg = 1;
      scripts\cp\equipment\nvg::removenvg();
    } else {
      level.disable_nvg = var_0;

      if(!istrue(level.disable_nvg))
        scripts\cp\equipment\nvg::runnvg();
    }

    wait 0.1;
  }
}

update_lua_inventory_slot(var_0) {
  self setclientomnvar("_encstr_842919C61CAF5BBA73B4D14B7B37EBE6B2C6EBE68DED47FA5A23C3", var_0);
}

get_selection_index_loop_around(var_0, var_1, var_2) {
  if(var_0 > var_2)
    return var_1;

  if(var_0 < var_1)
    return var_2;

  return var_0;
}

hasmaxammo() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 5);
  wait 0.5;
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A1B40DA227C1C2307019499325CA19", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A7B40D9AA37E57CAF029BA91255842", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_ABB40D5D97470FAB772963705360E2", 0);
  var_0 = 3;
  reset_munitions(self, var_0);
  cargo_truck_mg_enterend();
}

reset_munitions(var_0, var_1) {
  var_0 notify("_encstr_84CF10938793C8DD194713DDAF53AB50569A");
  var_2 = [];
  var_1 = 3;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(isDefined(var_0.munition_slots) && isDefined(var_0.munition_slots[var_3]) && isDefined(var_0.munition_slots[var_3].cooldown_progress))
      var_2[var_3] = var_0.munition_slots[var_3].cooldown_progress;
    else
      var_2[var_3] = undefined;

    var_4 = var_0 scripts\cp\cp_loadout::cac_getloadoutselectedidx();

    if(!isDefined(var_0.munition_slots) || !isDefined(var_0.munition_slots[var_3]))
      var_0.munition_slots[var_3] = spawnStruct();

    var_0.munitions_in_playerdata[var_3] = spawnStruct();

    if(scripts\cp\cp_globallogic::allow_munitions(var_0)) {
      var_0.munition_slots[var_3].ref = var_0 get_munition(var_3);
      var_0.munitions_in_playerdata[var_3].ref = var_0.munition_slots[var_3].ref;
      var_0.munition_slots[var_3].cooldown = level.munitions_table_data[var_0.munition_slots[var_3].ref].cooldown;
      var_0.munition_slots[var_3].can_use = 0;
      var_0.munition_slots[var_3].cooldown_progress = undefined;

      if(isDefined(var_2[var_3]))
        var_0.munition_slots[var_3].cooldown_progress = var_2[var_3];

      if(!istrue(level.unlimitedmunitions)) {
        var_0.munition_slots[var_3].can_use = 0;

        if(!scripts\cp\loot_system::is_empty_or_none(var_3)) {
          var_0 setclientomnvar("_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4", 1);
          var_0 setclientomnvar("_encstr_B1D214B107F5B5BACD96A3D2BDE6D764EB1DD25BB24E", 1);
          var_0 setclientomnvar("_encstr_8DBB14C60EF5DAAEE64B3A4BDBE67D99F51D5ADAB29C", 1);
          var_0.munition_slots[var_3].can_use = 1;
        }
      }
    } else if(!isDefined(var_0.init_munitions)) {
      var_0.munition_slots[var_3].ref = "_encstr_8BBA05185F8B99";
      var_0.munition_slots[var_3].cooldown = level.munitions_table_data[var_0.munition_slots[var_3].ref].cooldown;
      var_0.munition_slots[var_3].can_use = 0;
      var_0.munition_slots[var_3].cooldown_progress = undefined;
    }

    var_5 = undefined;
    var_6 = "_encstr_879417B183BEB5D5DC4B8E2DDEE67DE636ED47EB39953795D1";
    var_7 = undefined;

    switch (var_3) {
      case 0:
        var_5 = "_encstr_A9DA13DE3FB7DA65D850F38F48F01763B9D8635907";
        var_7 = 1;
        break;
      case 1:
        var_5 = "_encstr_BADA13486909553D1B20138458FB97E3081218D11A";
        var_7 = 2;
        break;
      case 2:
        var_5 = "_encstr_B1DA1387E9A8D27588D8F3BC30A0978B997F43FF17";
        var_7 = 3;
        break;
      case 3:
        var_5 = "_encstr_A5DA13361CD7D65D73B4D14BBD9BEB6E367B3A7D68";
        break;
    }

    var_8 = level.munitions_table_data[var_0.munition_slots[var_3].ref].index;

    if(isDefined(var_5) && isDefined(var_8) && isDefined(var_7))
      var_0 setclientomnvar(var_5, var_8);
  }

  if(!isDefined(var_0.init_munitions))
    var_0.init_munitions = 1;

  if(!isDefined(var_0.loadout_changed_flag))
    var_0.loadout_changed_flag = 0;

  if(var_0.loadout_changed_flag == 0)
    var_9 = 1;
  else
    var_9 = 0;

  var_0 setclientomnvar("_encstr_957E138DC1BE8DDE8532DEEA47BE8DD00BE69DCAC8", var_9);
  var_0.loadout_changed_flag = var_9;

  if(istrue(level.unlimitedmunitions)) {
    var_0 thread cooldown_munition("_encstr_97B910170868C1EB63B725115767B3835128", "_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4", var_0, var_0.munition_slots[0].ref, var_0.munition_slots[0].cooldown, 0);
    var_0 thread cooldown_munition("_encstr_9686105BBAB94B8EA57BDCBE23AFAE379523", "_encstr_B1D214B107F5B5BACD96A3D2BDE6D764EB1DD25BB24E", var_0, var_0.munition_slots[1].ref, var_0.munition_slots[1].cooldown, 1);
    var_0 thread cooldown_munition("_encstr_A7EC10C79B58FA1C28B0CD9923C14513A5C1", "_encstr_8DBB14C60EF5DAAEE64B3A4BDBE67D99F51D5ADAB29C", var_0, var_0.munition_slots[2].ref, var_0.munition_slots[2].cooldown, 2);
    var_0 thread cooldown_munition("_encstr_8A7010B6EAE6D2D1D2ED73FAA1D75DE6AC8C", "_encstr_A62B148E6FE78A15A820A3DFF840C7E70F8594855DE5", var_0, var_0.munition_slots[3].ref, var_0.munition_slots[3].cooldown, 3);
  }
}

get_munition(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_85E717C03BD3D3C004378DE721AB2BB9AF42598F821315185A", var_0, "_encstr_978D09FA80F57CF330A07E");
  else
    var_1 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_976D0F6BAEB94B3AB4BDCD6A598EBA38CD", var_0, "_encstr_978D09FA80F57CF330A07E");

  return var_1;
}

get_role_munition(var_0) {
  var_1 = undefined;

  if(getdvarint("_encstr_B41F0C5780D3FF837799EF69FCB3", 0)) {
    switch (self.class) {
      case "_encstr_AB3508737F830710ACDB":
        var_1 = "_encstr_8B2F11706B178D79CB05C8591957405FBCE250";
        break;
      case "_encstr_A6C7065BAC91D28D":
        var_1 = "_encstr_B18B0B578C23412DAE3A487842";
        break;
      case "_encstr_8DEF05BDE933E0":
        var_1 = "_encstr_9B1807D39B48FD93A3";
        break;
      case "_encstr_A12707B8AB65E9A9C3":
        var_1 = "_encstr_8DDA0D2327EDB995D7DC1D4EB4DACA";
        break;
      case "_encstr_8CFF09D56D88EC030D69EB":
        var_1 = "_encstr_A1FA0C2A7D2FE05DC9FB33B71A4B";
        break;
      case "_encstr_88CC09377EA33BA181ED2E":
        var_1 = "_encstr_A9C20C93D2BD8ED737D096951B19";
        break;
      default:
        break;
    }
  } else {
    switch (self.class) {
      case "_encstr_AB3508737F830710ACDB":
        var_1 = "_encstr_A3990BDBEF05B561FA5A488BD8";
        break;
      case "_encstr_A6C7065BAC91D28D":
        var_1 = "_encstr_A7B606DA83796F4A";
        break;
      case "_encstr_8DEF05BDE933E0":
        var_1 = "_encstr_A7B606DA83796F4A";
        break;
      case "_encstr_A12707B8AB65E9A9C3":
        var_1 = "_encstr_A3990BDBEF05B561FA5A488BD8";
        break;
      case "_encstr_8CFF09D56D88EC030D69EB":
        var_1 = "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38";
        break;
      case "_encstr_88CC09377EA33BA181ED2E":
        var_1 = "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38";
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_1)) {} else {}

  return var_1;
}

cooldown_munition(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 endon("_encstr_84CF10938793C8DD194713DDAF53AB50569A");
  var_2 notify(var_0 + "_encstr_87AB0757ED20D2872D");
  var_2 endon(var_0 + "_encstr_87AB0757ED20D2872D");
  var_7 = var_4;
  var_8 = getdvarfloat("_encstr_B694145FDB2A491E175210197A5F4091823383E94192", 1);
  var_4 = var_7 * var_8;
  var_9 = undefined;

  for(;;) {
    var_10 = 0;

    if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3") && !scripts\engine\utility::flag("_encstr_A2D20FE4880D52A426C867576878654BD3"))
      var_10 = 1;

    if(var_10) {
      waitframe();
      continue;
    }

    if(!isDefined(var_2.munition_slots[var_5].cooldown_progress)) {
      var_2.munition_slots[var_5].cooldown_progress = 0;
      var_2 setclientomnvar(var_1, 0);
    }

    if(istrue(var_6)) {
      var_2.munition_slots[var_5].cooldown_progress = var_4;
      var_2 setclientomnvar(var_1, 1);
      var_6 = undefined;
    }

    if(var_2.munition_slots[var_5].cooldown_progress < var_4)
      var_2.munition_slots[var_5].can_use = 0;

    while(var_2.munition_slots[var_5].cooldown_progress <= var_4) {
      var_11 = getdvarfloat("_encstr_B694145FDB2A491E175210197A5F4091823383E94192", 1);

      if(var_11 != var_8) {
        var_8 = var_11;
        var_4 = var_7 * var_8;
      }

      if(istrue(var_2.has_inv_cooldown))
        var_2.munition_slots[var_5].cooldown_progress = var_4 + 1;

      if(var_4 == 0)
        var_12 = 1;
      else
        var_12 = min(var_2.munition_slots[var_5].cooldown_progress / var_4, 1);

      var_2 setclientomnvar(var_1, var_12);

      if(var_12 < 1) {
        var_13 = 0.05;
        var_2.munition_slots[var_5].cooldown_progress = var_2.munition_slots[var_5].cooldown_progress + var_13;
      } else
        break;

      wait 0.05;
    }

    var_2.munition_slots[var_5].can_use = 1;
    var_14 = "_encstr_8A19049A2817" + var_3;

    if(istrue(var_9))
      var_2 thread scripts\cp\cp_hud_message::showsplash(var_14, undefined, self);

    var_9 = 1;
    var_2 waittill(var_0);
    var_2.munition_slots[var_5].cooldown_progress = undefined;
    var_2.munition_slots[var_5].can_use = 0;
    var_2.munition_slots[var_5]._id_134E2 = undefined;
  }
}

remove_munition_from_array(var_0, var_1) {
  for(var_2 = 0; var_2 < self.munition_slots.size; var_2++) {
    if(isDefined(self.munitions_in_playerdata[var_2]) && self.munitions_in_playerdata[var_2].ref == var_1) {
      if(var_2 == var_0)
        self setclientomnvar("_encstr_879417B183BEB5D5DC4B8E2DDEE67DE636ED47EB39953795D1", var_2);

      self.munitions_in_playerdata[var_2] = undefined;
      self.munition_slots[var_0]._id_134E2 = undefined;
      break;
    }
  }
}

_id_11E0C(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_8D390A3813DA6D6BE1AB6828":
    case "_encstr_A31C07E04BD8ADABE0":
      var_1 = 1;
      break;
  }

  if(var_1)
    return 1;

  return 0;
}

can_use_munition(var_0) {
  if(self.munition_slots[var_0].ref == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79" && istrue(self.isjuggernaut))
    return 0;

  if(self.munition_slots[var_0].ref == "_encstr_A937066AFF52FA4F" && istrue(level.gunshipinuse))
    return 0;

  if(self getcurrentweapon().basename == "_encstr_B80E0DD3FF027E48DD5E7582AF27A8")
    return 0;

  if(istrue(self.munition_slots[var_0].can_use))
    return 1;

  return 0;
}

remove_munition(var_0, var_1) {
  remove_munition_from_array(var_0, var_1);
  var_2 = "_encstr_8BBA05185F8B99";

  if(var_0 == 0) {
    var_2 = "_encstr_8E8A07AFE30F7349A2";
    self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A1B40DA227C1C2307019499325CA19", 0);
  } else if(var_0 == 1) {
    var_2 = "_encstr_828A0759AD88584327";
    self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A7B40D9AA37E57CAF029BA91255842", 0);
  } else if(var_0 == 2) {
    var_2 = "_encstr_928A072B57E3DD20C3";
    self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_ABB40D5D97470FAB772963705360E2", 0);
  }

  give_munition_to_slot(var_2, var_0);
  var_3 = "_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4";

  switch (var_0) {
    case 0:
      var_3 = "_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4";
      break;
    case 1:
      var_3 = "_encstr_B1D214B107F5B5BACD96A3D2BDE6D764EB1DD25BB24E";
      break;
    case 2:
      var_3 = "_encstr_8DBB14C60EF5DAAEE64B3A4BDBE67D99F51D5ADAB29C";
      break;
    case 3:
      var_3 = "_encstr_A62B148E6FE78A15A820A3DFF840C7E70F8594855DE5";
      break;
  }

  self setclientomnvar(var_3, 0);
  check_for_empty_munitions();
  assign_highest_full_slot_to_active();
}

check_for_empty_munitions() {
  var_0 = 0;
  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isDefined(self.munition_slots) && isDefined(self.munition_slots[var_2])) {
      if(!scripts\cp\loot_system::is_empty_or_none(var_2))
        var_0 = var_0 + 1;
    }
  }

  self.munition_slots_full = var_0;
  self setclientomnvar("_encstr_BE5C17662019F573DDCBE3DB7F506093CCB7F57011B013F8D1", var_0);
}

assign_highest_full_slot_to_active() {
  var_0 = 0;

  for(var_1 = self.munition_slots.size - 1; var_1 > -1; var_1--) {
    if(!scripts\cp\loot_system::is_empty_or_none(var_1)) {
      self.dpad_selection_index = var_1;
      break;
    } else
      var_0 = var_0 + 1;
  }

  if(var_0 == self.munition_slots.size)
    self.dpad_selection_index = 0;

  update_lua_inventory_slot(self.dpad_selection_index);
}

cargo_truck_mg_enterend() {
  var_0 = 0;

  for(var_1 = 0; var_1 < self.munition_slots.size; var_1++) {
    if(!scripts\cp\loot_system::is_empty_or_none(var_1)) {
      self.dpad_selection_index = var_1;
      break;
    } else
      var_0 = var_0 + 1;
  }

  if(var_0 == self.munition_slots.size)
    self.dpad_selection_index = 0;

  update_lua_inventory_slot(self.dpad_selection_index);
}

has_munition(var_0) {
  foreach(var_2 in self.munition_slots) {
    if(var_2.ref == var_0)
      return 1;
  }

  return 0;
}

give_munition_to_slot(var_0, var_1, var_2) {
  var_3 = update_total_slots(var_1);
  var_4 = self;

  if(!isDefined(var_1))
    var_1 = var_3 - 1;

  if(!isDefined(self.munition_slots) || !isDefined(self.munition_slots[var_1]))
    self.munition_slots[var_1] = spawnStruct();

  self.munition_slots[var_1].ref = var_0;
  self.munition_slots[var_1].cooldown = level.munitions_table_data[self.munition_slots[var_1].ref].cooldown;
  self.munition_slots[var_1].can_use = 1;
  self.munition_slots[var_1].cooldown_progress = 1;

  if(isDefined(var_2)) {
    self.munition_slots[var_1]._id_134E2 = var_2;

    if(isDefined(self.munition_slots[var_1]._id_134E2) && _id_11E0C(self.munition_slots[var_1]._id_134E2)) {
      if(var_1 == 0)
        self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A1B40DA227C1C2307019499325CA19", 1);
      else if(var_1 == 1)
        self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A7B40D9AA37E57CAF029BA91255842", 1);
      else if(var_1 == 2)
        self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_ABB40D5D97470FAB772963705360E2", 1);
    }
  }

  if(var_0 == "_encstr_8BBA05185F8B99") {
    if(isDefined(self.munition_slots[var_1]._id_134E2))
      self.munition_slots[var_1]._id_134E2 = undefined;
  }

  var_3 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");
  var_5 = undefined;
  var_6 = var_4 check_for_gl_proj_override(var_0);

  if(!istrue(self.munition_splash_supress))
    var_6 = "_encstr_8A19049A2817" + var_6;

  var_4 thread scripts\cp\cp_hud_message::showsplash(var_6, undefined, self);

  switch (var_1) {
    case 0:
      var_5 = "_encstr_A9DA13DE3FB7DA65D850F38F48F01763B9D8635907";
      var_4 thread cooldown_munition("_encstr_97B910170868C1EB63B725115767B3835128", "_encstr_8FCD148D38EBD6BAB9A5D1B4DB37BEC47D4796DA59E4", var_4, var_4.munition_slots[0].ref, var_4.munition_slots[0].cooldown, 0, 1);
      break;
    case 1:
      var_5 = "_encstr_BADA13486909553D1B20138458FB97E3081218D11A";
      var_4 thread cooldown_munition("_encstr_9686105BBAB94B8EA57BDCBE23AFAE379523", "_encstr_B1D214B107F5B5BACD96A3D2BDE6D764EB1DD25BB24E", var_4, var_4.munition_slots[1].ref, var_4.munition_slots[1].cooldown, 1, 1);
      break;
    case 2:
      var_5 = "_encstr_B1DA1387E9A8D27588D8F3BC30A0978B997F43FF17";
      var_4 thread cooldown_munition("_encstr_A7EC10C79B58FA1C28B0CD9923C14513A5C1", "_encstr_8DBB14C60EF5DAAEE64B3A4BDBE67D99F51D5ADAB29C", var_4, var_4.munition_slots[2].ref, var_4.munition_slots[2].cooldown, 2, 1);
      break;
    case 3:
      var_5 = "_encstr_A5DA13361CD7D65D73B4D14BBD9BEB6E367B3A7D68";
      var_4 thread cooldown_munition("_encstr_8A7010B6EAE6D2D1D2ED73FAA1D75DE6AC8C", "_encstr_A62B148E6FE78A15A820A3DFF840C7E70F8594855DE5", var_4, var_4.munition_slots[3].ref, var_4.munition_slots[3].cooldown, 3, 1);
      break;
  }

  var_7 = level.munitions_table_data[var_4.munition_slots[var_1].ref].index;

  if(isDefined(var_5) && isDefined(var_7))
    var_4 setclientomnvar(var_5, var_7);

  if(isDefined(var_4.munition_slots_full) && var_4.munition_slots_full == 0)
    var_4 check_for_empty_munitions();
}

update_total_slots(var_0) {
  if(!isDefined(var_0))
    var_0 = 5;

  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");

  if(var_0 >= var_1 && var_1 < 3)
    var_1 = var_1 + 1;

  self setplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD", var_1);
  return var_1;
}

check_for_gl_proj_override(var_0) {
  var_1 = self;

  if(var_0 == "_encstr_8B2F11706B178D79CB05C8591957405FBCE250" && isDefined(var_1.gl_proj_override))
    return var_1.gl_proj_override + "_encstr_886E06BE0EC9B735";

  return var_0;
}

create_munition_change_points(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "_encstr_81010C2D9BE8B29C0B8D1D2DED37";
  var_1.script_noteworthy = "_encstr_8A1D1B6AD06BBF1F33ADCFEB4B59D3879BB9A2C2B0CB725FA995F1EF50";
  var_1.requires_power = 0;
  var_1.spend_type = "_encstr_A3BA05E0735C50";
  var_1.cost = 0;
  var_1.b_cleared_for_drop = 1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

create_airdrop_spawn_structs() {
  wait 50;
  var_0 = scripts\engine\utility::getStructArray("_encstr_8F5E167C3FC7033A6BCB9EEB930BB52FB07647E3B29BCF28", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.struct_array_loadout_locations = [];

  foreach(var_2 in var_0) {
    var_2.b_cleared_for_drop = 1;
    var_2.next_airdrop_time = gettime() + 50000;
    var_2.team = "_encstr_9A8507BA4040188D08";
    var_2.model = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_2.model setModel(var_2.script_modelname);

    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    var_2.model.angles = var_2.angles;
    level.struct_array_loadout_locations = scripts\engine\utility::array_add(level.struct_array_loadout_locations, var_2);
    var_2 thread run_airdrop_spawn_loop();
  }
}

run_airdrop_spawn_loop() {
  for(;;) {
    if(gettime() > self.next_airdrop_time)
      spawn_airdrop_at_point(self);

    waitframe();
  }
}

spawn_airdrop_at_point(var_0) {
  if(!istrue(var_0.b_cleared_for_drop)) {
    var_0.next_airdrop_time = gettime() + 50000;
    return;
  }

  var_0.b_cleared_for_drop = 0;
  var_1 = getrandomnavpoint(var_0.origin, 128);
  scripts\cp\crafting_system::airdrop_new_loadout_near_player(var_0, var_1);
  var_0 waittill("_encstr_B29C1531DADF6068171799E7513F60B5D3016BF81227A6");
  var_0.next_airdrop_time = gettime() + 50000;
  var_0.b_cleared_for_drop = 1;
}

create_munitions_interaction() {
  scripts\cp\cp_interaction::register_interaction("_encstr_8A1D1B6AD06BBF1F33ADCFEB4B59D3879BB9A2C2B0CB725FA995F1EF50", "_encstr_A3BA05E0735C50", undefined, ::loadout_change_hint, ::loadout_change_activate, 0, 0, undefined);
  var_0 = scripts\engine\utility::getStructArray("_encstr_8F5E167C3FC7033A6BCB9EEB930BB52FB07647E3B29BCF28", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0)
  create_munition_change_points(var_2);
}

loadout_change_hint(var_0, var_1) {
  return &"_encstr_85D5248BC0502731077A737EE76B85A7A038F77EAFCD17E8BC58867388DBCD417BEC1704D727";
}

loadout_change_activate(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp\crafting_system::is_player_allowed_to_airdrop(var_1)) {
    if(scripts\cp\crafting_system::should_allow_airdrop()) {
      var_1.loadout_in_progress = 1;
      scripts\cp\crafting_system::airdrop_new_loadout_near_player(var_1);
    } else {}
  } else {}
}

_id_12BE1(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;
  var_4 = 20;

  if(isDefined(var_2))
    var_4 = var_2;

  var_5 = ["_encstr_9A221031C936F67B8EAFB5AEE64BA3A5DE37", "_encstr_87ED182B3028C75A5918E59BF80BA399107867AF7003045357A7", "_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6", "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6", "_encstr_81451C220A596028C3CEF3B70D88C34A2A3D2056A2219C8F1B8873298A92", "_encstr_95381F01A0893F3F8B5F9758752030D850A8F993506B232109ADBF1FE096F287F1", "_encstr_AFC31F4B25894AD71046FDC358C0F4E2D08537B7CDAD9283F02EF5CC13F821EABD", "_encstr_A61020A15B19EF80706627C3CADBA1291F9A816FF8271853D0C141C242D396EB2FA5", "_encstr_97DC21C666B99207E389CF57F8B8D43A67F001FF45E9DA5F6A50FB3B8856BB02FD9DD2", "_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50", "_encstr_824E21061D73FFE8053755F3E8505158F8A0914715D5E6FFA447678D66CF981EC33D93", "_encstr_96131B9AF3897F1D686FB59535B8E3AFA0E8C1E2FBD4E7D73065B19DE9", "_encstr_996D24691BFDB78089C1A8C37370A3C87708E77082E51FE8570A30FD619BE3B3A604A04B073F", "_encstr_975922828B1B27203351024718096D7B9FBD2F1D10375EF92B3B136E7C5F3BB8D3D4A25B", "_encstr_A6851DA2CBB137553027CDDD6DF0DB776820094B5398834CA067E1C321C8A5", "_encstr_856B17FA48010D6F4368ADCD98884BD45F739113E8D5829F7B", "_encstr_99C614C4398DB7B78EEBD6D5375AA3A5DBDCBE5DC23B", "_encstr_B2B91B70AB21D59D248E9A6B2B904B9C7FCD210FFA727B22D913D49F5B"];

  foreach(var_7 in var_5) {
    var_8 = getentitylessscriptablearrayinradius(undefined, undefined, var_0, var_1, var_7);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_11 setscriptablepartstate(var_7, "_encstr_95DF070DD22319CA9B");
      var_9++;

      if(var_9 % var_4)
        wait 0.1;
    }

    wait 0.1;
  }
}

_id_12BE0(var_0) {
  var_1 = ["_encstr_9A221031C936F67B8EAFB5AEE64BA3A5DE37", "_encstr_87ED182B3028C75A5918E59BF80BA399107867AF7003045357A7", "_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6", "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6", "_encstr_81451C220A596028C3CEF3B70D88C34A2A3D2056A2219C8F1B8873298A92", "_encstr_95381F01A0893F3F8B5F9758752030D850A8F993506B232109ADBF1FE096F287F1", "_encstr_AFC31F4B25894AD71046FDC358C0F4E2D08537B7CDAD9283F02EF5CC13F821EABD", "_encstr_A61020A15B19EF80706627C3CADBA1291F9A816FF8271853D0C141C242D396EB2FA5", "_encstr_97DC21C666B99207E389CF57F8B8D43A67F001FF45E9DA5F6A50FB3B8856BB02FD9DD2", "_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50", "_encstr_824E21061D73FFE8053755F3E8505158F8A0914715D5E6FFA447678D66CF981EC33D93", "_encstr_96131B9AF3897F1D686FB59535B8E3AFA0E8C1E2FBD4E7D73065B19DE9", "_encstr_996D24691BFDB78089C1A8C37370A3C87708E77082E51FE8570A30FD619BE3B3A604A04B073F", "_encstr_975922828B1B27203351024718096D7B9FBD2F1D10375EF92B3B136E7C5F3BB8D3D4A25B", "_encstr_A6851DA2CBB137553027CDDD6DF0DB776820094B5398834CA067E1C321C8A5", "_encstr_856B17FA48010D6F4368ADCD98884BD45F739113E8D5829F7B", "_encstr_99C614C4398DB7B78EEBD6D5375AA3A5DBDCBE5DC23B", "_encstr_B2B91B70AB21D59D248E9A6B2B904B9C7FCD210FFA727B22D913D49F5B"];

  if(isDefined(var_0))
    var_1 = var_0;

  foreach(var_3 in var_1) {
    var_4 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, var_3);

    foreach(var_6 in var_4)
    var_6 setscriptablepartstate(var_3, "_encstr_95DF070DD22319CA9B");

    wait 0.1;
  }
}