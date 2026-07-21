/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_summerofaction.gsc
***********************************************/

_id_1396C() {
  scripts\mp\flags::gameflaginit("_encstr_811D12412EE567151F4DB94E919A9269AFA20A3F", 0);
  tarmac_techo_start();
  level thread streakmatchlifeid();
  level thread _encstr_AC27347FFB0AD8B75BB398D86BDEE4406555C9E370B740503BBB6EC133AF28A031BB774B375B58444F9366686AA35338D6046DCFA346::init();
  waittillframeend;
  level thread _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::init();
  level thread grenade_trail_modifier();
  level thread _id_13C0F();
  level thread _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::init();
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level thread t();
  level thread tank_turret_get_target_and_fire();
  level thread success_zone_center();
  level thread tank_watchforgameend();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_883F1450CA279389AF06E56B01FFF04387B2D8C8A2BF", ::_id_11CA1);
}

tarmac_techo_start() {
  level._id_12E2E = spawnStruct();
  level._id_12E2E.parachuteoverheadwarningtimeoutms = getdvarfloat("_encstr_88332936A973EF3B68EAAF72E36765A1B1C366BBF84DA1B0CF40FB79805771836B10FF5203AE47F9AABFCD", 15.0);
  level._id_12E2E.spotlight_turret_info = getdvarint("_encstr_A3B72902B14887E3780BBF2F5D157AE479BB3E0BC8907F3BCF2B47175B49F23B88E6F75240081BB1A93B33", 2);
  level.spotlight_movement_think = getdvarint("_encstr_9B95226E6C27FA4B7D37DE857D95C30E8DB76E2DB356EB98F6EE9BAF1DF6EBDC0E85EECD", 5);
}

streakmatchlifeid() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97D311FBD1FDFCADD2C9E888A7D50FD3890F07", ::dangercircletick);
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_13456);
}

tank_watchforgameend() {
  level._id_13457 = spawnStruct();
  level._id_13457._id_1346A = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_kill_watcher_civ;
  level._id_13457.open_any_random_airlock_door = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_low_health;
  level._id_13457._id_12540 = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonatingplayer;
  level._id_13457._id_12650 = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonation_time;
  level._id_13457._id_125D1 = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonation_color_omnvar_value;
  level._id_13457._id_12556 = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonation_code_omnvar_value;
  level._id_13457._id_13738 = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::devspectateenemyteam1;
  level._id_13457._id_1373B = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::devscriptedtests;
  level._id_13457._id_145C2 = _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::devspectateenemyteam2;
}

t() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
}

tank_turret_get_target_and_fire() {
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  var_0 = [];
  var_0[var_0.size] = (37835, 11168, 869);
  var_0[var_0.size] = (37010, -37468, -490);
  var_0[var_0.size] = (11191, 37393, 1989);
  var_0[var_0.size] = (-21516, 56288, 3406);
  var_0[var_0.size] = (-36014, 33788, 1581);
  var_0[var_0.size] = (5811, -4154, -81);
  var_0[var_0.size] = (-18258, -7437, 280);
  var_0[var_0.size] = (39559, 43081, 2389);
  var_0[var_0.size] = (23375, 15266, -121);
  var_0[var_0.size] = (-23164, -24840, -76);

  if(var_0.size) {
    foreach(var_2 in var_0) {
      var_3 = easepower("_encstr_91BA1631E41BBDB747D7B9BD58BEE0DEEEAF8CBDD9A3C2B3", scripts\engine\utility::drop_to_ground(var_2, 0, -100, (0, 0, 1)) + (0, 0, 25));
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_3);
    }
  }
}

success_zone_center() {
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  var_0 = [];
  var_0[var_0.size] = (-23081, -24534, -70);
  var_0[var_0.size] = (37091, -37568, -501);
  var_0[var_0.size] = (6667, -4767, -82);
  var_0[var_0.size] = (37611, 11364, 743);
  var_0[var_0.size] = (39251, 42917, 2382);
  var_0[var_0.size] = (23748, 14291, -222);
  var_0[var_0.size] = (11198, 37448, 1998);
  var_0[var_0.size] = (-21618, 56541, 3381);
  var_0[var_0.size] = (-35763, 33656, 1559);
  var_0[var_0.size] = (-18569, -7431, 247);
  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < level.spotlight_movement_think; var_1++) {
    var_2 = easepower("_encstr_8DCA2045F2657BC0A399087092FB8690BA7DCB2FB78FC3972B7203785BB7A8F815C7", scripts\engine\utility::drop_to_ground(var_0[var_1], 0, -100, (0, 0, 1)) + (0, 0, 25));
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_2);
  }
}

onplayerkilled(var_0) {
  var_1 = var_0.victim;
  var_2 = var_0.attacker;
  var_3 = var_0.objweapon;
  var_4 = var_0.meansofdeath;
  var_5 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_5 == "_encstr_A254085207A6B7334B5A" || var_5 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_5 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_5 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95")
    _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::end_game_tutorial_func(var_0);
  else if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
    if(self.spawnsystem_init <= 0)
      self.attacker thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BED221F65A310F91D52708685BF56EBD9A47F38EF54BD57BBF53F8E80704A6E782EDE1");

    thread _encstr_BE892FF37E20B3A7F9EB480F4347E49013405B170BD24FBFAB2B78C8D210D51020A367CF0285029B86D0F3D0D1C242633B::juggerbear();
  }

  if(isPlayer(var_2) && (isDefined(var_3.equipmentref) && scripts\mp\equipment::isequipmentlethal(var_3.equipmentref) || isDefined(var_4) && isexplosivedamagemod(var_4))) {
    if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_8A843ED101E1281B575290F82A87C11187A82169CF52305CC7C9CBA1E21B08D05A3791E37CFCC8A907E22D881A7F2868F5726F4743E9A278370B993083F7F4C0", 1);
  }

  if(isPlayer(var_2) && var_3.basename == "_encstr_A2C219E404B131BBCD290B06C0FA70CAC79E6CDBE5AD8AE74ED013") {
    if(isDefined(level._id_13457))
      [[level._id_13457.open_any_random_airlock_door]](self);

    if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_BDA735212E397E90870768ED6E6168B892979989AF813CD0C4DC3699D54550EF3BE77D0727E90C18FA79BB9BF1658115B397ED89EFB3CA", 1);
  }

  if(isPlayer(var_2) && (!isDefined(var_2.kills) || var_2.kills == 0)) {
    var_6 = 1;
    var_7 = scripts\mp\utility\player::getteamarray(var_2.team);

    if(var_7.size == 0) {
      return;
    }
    foreach(var_9 in var_7) {
      if(isDefined(var_9.kills) && var_9.kills)
        var_6 = 0;
    }

    if(var_6) {
      if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
        var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_A2F52B818E99DE3027A708600EC1C818A2770517D3E116583FBDF17E37A770502BF6E713E7EAE42846539E7358", 1);
    }
  }
}

_id_13456(var_0, var_1, var_2, var_3, var_4) {
  if(var_0.type == "_encstr_91BA1631E41BBDB747D7B9BD58BEE0DEEEAF8CBDD9A3C2B3") {
    if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6) {
      foreach(var_6 in scripts\mp\utility\teams::getteamdata(var_3.team, "_encstr_9775086022BE1B413B8B"))
      var_6 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_A36B30AC4B3E5FD477F87A42B8638DF711D80C3C8D41CBD111A0B35930BB878FCE3487BA08EBAEE973099AC3508D3B8723A2", 1);
    }
  }
}

dangercircletick(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.shutdownattractionicontrigger) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(distance2dsquared(var_4.origin, var_0) > var_2)
      var_4 _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::shut_down_laser_trap();
  }

  foreach(var_7 in level._id_12819) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(distance2dsquared(var_7.origin, var_0) > var_2)
      var_7 _id_12818();
  }

  foreach(var_10 in level._id_13460.choppers) {
    if(!isDefined(var_10) || var_10.stadiumpuzzleactive) {
      continue;
    }
    if(distance2dsquared(var_10.origin, var_0) > var_2) {
      var_10.lootfunc = undefined;
      var_10 dodamage(5000, var_10.origin);
    }
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D")
    _encstr_BE892FF37E20B3A7F9EB480F4347E49013405B170BD24FBFAB2B78C8D210D51020A367CF0285029B86D0F3D0D1C242633B::dangercircletick(var_0, var_1);
}

activatemusictrigger() {}

_id_13C0F() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level thread _id_13C10();
  level thread _id_13C11();
}

_id_13C10() {
  var_0 = (-196, 836, 3890);

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D")
    var_0 = (20270, -14587, 3731);

  var_1 = scripts\mp\gameobjects::createhintobject(var_0, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_A31722C86EAE2130976FE57FA988816834D0EBECA5AEFF3F1351D923F701F671F9603F0A", undefined, undefined, undefined, 350, 360, 200, 120);
  var_1 thread _id_13C0D();
}

_id_13C0D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = getEnt("_encstr_92DD0DFAC13BEF85C16DE8092717DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss()) {
      if(soundexists("_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51"))
        playsoundatpos(self.origin, "_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51");

      var_0 thread _id_13C0E(var_1);
      self delete();
    } else if(soundexists("_encstr_B63B0FC493FADACABC381619BE19ACB9F2"))
      playsoundatpos(self.origin, "_encstr_B63B0FC493FADACABC381619BE19ACB9F2");

    wait 0.25;
  }
}

_id_13C0E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = incrementpersistentstat(level.players, self.origin, 10000);

  foreach(var_3 in var_1)
  var_3 scripts\mp\hud_message::showsplash("_encstr_839B21C49CFAE6F658BE47F6EE56E47D959D59B9E8EB9D2CAB8DE8BEDE0759DC963776", undefined, var_0);

  var_5 = (-161, 752, 3972);
  var_6 = (-353, 873, 3970);
  var_7 = (-354, 644, 3970);

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_5 = (20330, -14534, 3816);
    var_6 = (20218, -14734, 3816);
    var_7 = (20440, -14734, 3816);
  }

  playsoundatpos(var_5, "_encstr_8E5C12B6F0EB9BBD0BFA7BC859FA1DB7BEA6DB5E");
  playsoundatpos(var_6, "_encstr_8F731C0793F80763F88B3F87F995E964781E7C0DEA49C14AC785FF4F7967");
  playsoundatpos(var_7, "_encstr_91731CE5B84D59F3A7FF1FCF30936E40771F44703B29C3892BB027A0DF2D");
  self rotateYaw(-90, level._id_12E2E.parachuteoverheadwarningtimeoutms, 0.25, 0.25);
  playsoundatpos(self.origin, "_encstr_8DFD1A7F5863AFB227489AD92CE37B54CBA9DFB3A858F78B3957620B");
  wait 0.5;
  self playLoopSound("_encstr_88F31656D9A3BEE6BDB07D46DB7B4ED73B585D63E87D8D07");
  wait(level._id_12E2E.parachuteoverheadwarningtimeoutms - 0.5);
  playsoundatpos(self.origin, "_encstr_AB54198DA37B87B95F97B0E1CB695329A301708FFF723F032CFFA8");
  self stoploopsound();
}

_id_13C11() {
  var_0 = (-73, 449, 3895);
  var_1 = (-73, 337, 3895);
  var_2 = (-73, 233, 3895);
  var_3 = (0, 180, 0);

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0 = (20675.3, -14460, 3726);
    var_1 = (20746.3, -14460, 3726);
    var_2 = (20882.5, -14460, 3726);
    var_3 = (0, 90, 0);
  }

  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_3;
  var_4.itemsdropped = 0;
  var_4._id_13904 = "_encstr_A7751EA710412F33A7C4DF12384DBACD48709F437879431A8F5BA90A1B076274";
  var_5 = scripts\mp\gameobjects::createhintobject(var_4.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AFA31F2DF7EFD7B996B9986B57C6213A1BC3576307C12ADF09AF4FD15B055A115A");
  var_5 thread _id_13C12("_encstr_A1E108317F1CBFDBEAF8", var_4);
  var_6 = spawnStruct();
  var_6.origin = var_1;
  var_6.angles = var_3;
  var_6.itemsdropped = 0;
  var_6._id_13904 = "_encstr_93431F3350E749DBA00B5FBA17A3E3AB7B48C9C955104A7E7D0BA1D8735DF30289";
  var_7 = scripts\mp\gameobjects::createhintobject(var_6.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_A9A31F2E426F7F874ED1018168D5F9B833392DB1FCC7A46BA0290931103F2D4E0A");
  var_7 thread _id_13C12("_encstr_8F310936D7BA63CBE9ABB8", var_6);
  var_8 = spawnStruct();
  var_8.origin = var_2;
  var_8.angles = var_3;
  var_8.itemsdropped = 0;
  var_8._id_13904 = "_encstr_A5CC1D3B8D39A16592B7BB9DFFEB2708DCA3265035634816CAB3D7590FD2F5";
  var_9 = scripts\mp\gameobjects::createhintobject(var_8.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_8CA31F9089BE07C50FE0F95D15D1692F615FDB95F37167098BCDB577E357BDC1DE");
  var_9 thread _id_13C12("_encstr_91810AA76AAF739F3F7A3858", var_8);
}

_id_13C12(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_3 = 0;

    switch (var_0) {
      case "_encstr_A1E108317F1CBFDBEAF8":
        var_3 = var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_AAAF28214BDBD0184307938F236FB0A66F32D9AB92BF1CE09D14E7AD495390EDC75A90318A93401079B9");
        break;
      case "_encstr_8F310936D7BA63CBE9ABB8":
        var_3 = var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_96AF286AC692E00FF38E3B2337C0A2F0578BDA3A1C61AF88D235C60598A34293E861379E0F661F18F012");
        break;
      case "_encstr_91810AA76AAF739F3F7A3858":
        var_3 = var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_damage_pavelow_boss("_encstr_88AF28F02B8C30079319770E6EFA47FBD7F760C8DB67C9CF3AFF608CC6D3B1C36FA388C81FF280B9D132");
        break;
    }

    if(var_3) {
      if(soundexists("_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51"))
        playsoundatpos(self.origin, "_encstr_91FF125EF299BFC9199B58683F5BC0FD725CCE51");

      var_4 = getEnt(var_1._id_13904, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      playsoundatpos(var_4.origin, "_encstr_8E0616854EEBD6899DBAC0A1A2B5BFE81BCF9310BF2359D5");
      var_4 rotateYaw(80, 1.5, 0.5, 0.5);
      wait 1.32;
      var_1 thread _id_13C14(var_0, var_2);
      var_2 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12BFC();
      self delete();
    } else if(soundexists("_encstr_ACA80FED33315369193F78E1B96C1575FB"))
      var_2 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");

    wait 0.25;
  }
}

_id_13C14(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_AB580A05672AE35D5FFF50B8");
  var_3 = _id_13C13(var_0, var_2);
  _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_3, 0);

  if(var_0 == "_encstr_91810AA76AAF739F3F7A3858") {
    var_4 = (15, 0, 0);

    if(level.mapname == "_encstr_8CD508CA98A70FAFC01D")
      var_4 = (0, 15, 0);

    var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_135DF("_encstr_9A3F1133610DE2C03888058B21400C4BEF9793", scripts\engine\utility::drop_to_ground(self.origin + var_4, 0, -200, (0, 0, 1)) + (0, 0, 25), 0);
    var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::risk_flagspawndebugobjicons();
    var_5 _encstr_95383423288639018B079E98F2E8A8D910C93389D36A2397E9ADBF3D201532EB1343165DFF4BD0C93B8A4353F6D89389E865EA9F8363::controlslinked(var_6);
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_5);
  }
}

_id_13C13(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "_encstr_A1E108317F1CBFDBEAF8":
      var_2[0] = "_encstr_8F561BAD4BD0CA7F535F8B2B432D33F71211E7FB582FAD7F0988E307A0";

      if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
        var_2[1] = "_encstr_A2FF1CCAA3D94F2D58BF6A7FD1E8F687FD98238129AB7B22D8576C71FD60";
        var_2[2] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[3] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[4] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
      } else {
        var_2[1] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[2] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[3] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_3 = min(level._id_12E2E.spotlight_turret_info, var_1);

        for(var_4 = 0; var_4 < var_3; var_4++)
          var_2[var_2.size] = "_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537";
      }

      break;
    case "_encstr_8F310936D7BA63CBE9ABB8":
      var_2[0] = "_encstr_AC85165B4058B72A094832ABC7C3337F01A8FFE7F831FF23";

      if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
        var_2[1] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[2] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[3] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[4] = "_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768";
      } else {
        var_2[1] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[2] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[3] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[4] = "_encstr_8EED1705B2A5C0B76359C8B0523BC6D0FA3D8BEF774EA85F03";
      }

      break;
    case "_encstr_91810AA76AAF739F3F7A3858":
      var_2[0] = "_encstr_B48D190EDBF0FF7ABD3FB7A789ED73171881461793A0B492985F17";

      if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A95E0A98B78C2FC6F6AB9B1D") {
        var_2[1] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[2] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
        var_2[3] = "_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F";
      } else {
        var_2[1] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[2] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
        var_2[3] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
      }

      break;
  }

  return var_2;
}

_id_13C15(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::drop_to_ground(var_1, 0) + var_2;

  switch (var_0) {
    case "_encstr_A1E108317F1CBFDBEAF8":
      var_4 = easepower("_encstr_AAAF28214BDBD0184307938F236FB0A66F32D9AB92BF1CE09D14E7AD495390EDC75A90318A93401079B9", var_3);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_4);
      break;
    case "_encstr_8F310936D7BA63CBE9ABB8":
      var_4 = easepower("_encstr_96AF286AC692E00FF38E3B2337C0A2F0578BDA3A1C61AF88D235C60598A34293E861379E0F661F18F012", var_3);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_4);
      break;
    case "_encstr_91810AA76AAF739F3F7A3858":
      var_4 = easepower("_encstr_88AF28F02B8C30079319770E6EFA47FBD7F760C8DB67C9CF3AFF608CC6D3B1C36FA388C81FF280B9D132", var_3);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_4);
      break;
  }
}

wp_loop() {
  var_0 = scripts\engine\utility::get_linked_ents();

  foreach(var_2 in var_0)
  var_2 linkTo(self);
}

activate_additional_ammo_crates() {}

grenade_trail_modifier() {
  waitframe();
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level thread _id_13453();
  level thread _id_13455();
  level thread _id_13452();
}

_id_13453() {
  var_0 = spawnStruct();
  var_0.origin = (9262, 49682, 1050);
  var_0.angles = (0, 90, 0);
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41("_encstr_8DCA2045F2657BC0A399087092FB8690BA7DCB2FB78FC3972B7203785BB7A8F815C7", var_1, var_0.origin, var_0.angles, 0, 0);
}

_id_13455() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = (9083, 49848, 1083.5);
  var_1 = [];
  var_1[0] = (6079, -4232, 0);
  var_1[1] = (39449, 43127, 2473);
  var_1[2] = (-36348, 33833, 1643);
  var_1[3] = (37142, -37391, -422);
  var_1[4] = (37557, 11234, 865);
  var_1[5] = (-21286, 56351, 3495);
  var_1[6] = (-18442, -7252, 316);
  var_1[7] = (-23164, -24840, -76);
  var_1[8] = (23563, 14610, -93);
  var_1[9] = (11140, 37097, 2041);
  var_2 = scripts\mp\gameobjects::createhintobject(var_0, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_96311DDEA57FBA09E5AF28D4FD23F35F3F7127614FD119F1F051FBD1698DB2");

  if(!isDefined(level._id_12819))
    level._id_12819 = [];

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(var_1.size == 0 || isDefined(var_3._id_1281B)) {
      var_3 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
      continue;
    }

    var_2 makeunusable();
    var_3 playlocalsound("_encstr_A20D12EFEB98A25E888905C120708CBAE6134F63");
    var_3.valve_steam_off = 1;
    var_3 thread _id_13454();
    var_1 = scripts\engine\utility::array_randomize(var_1);
    var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_3.team, var_3.squadindex);
    scripts\engine\utility::array_thread(var_4, ::_id_12817, var_1);
    scripts\engine\utility::array_thread(var_4, ::_id_1281A, var_1.size);
    wait 5;
    var_2 makeusable();
  }
}

_id_12817(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_1281B = 1;
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(2, 0, 0, var_3);
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(2000);
    var_4 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(self);
    level._id_12819 = scripts\engine\utility::array_add(level._id_12819, var_4);
    wait 0.5;
  }
}

_id_1281A(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = var_0 * 0.5;
  var_1 = scripts\mp\hud_util::createprimaryprogressbar(undefined, 150);
  var_2 = scripts\mp\hud_util::createprimaryprogressbartext(undefined, 150);
  var_2 settext(&"_encstr_914426BD1B6977B06F56F8CD13A30347276BD9BFD1CF79E94066AC90F17F21081D29F9BF8929747C");
  var_1 scripts\mp\hud_util::updatebar(0, 1 / var_0);

  for(var_3 = 0; var_3 < var_0 && isalive(self) && !level.gameended; var_3 = var_3 + 0.05)
    wait 0.05;

  self.valve_steam_off = 0;
  self playlocalsound("_encstr_877715D5D2BE2DCDE82BB1D7CD381BB0DC1AAFDE83B2CD");
  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

_id_13454() {
  while(self.valve_steam_off == 1) {
    self playlocalsound("_encstr_93461653531F2A5D788F1DF13BC3F9AE07A8C94E957046BF");
    wait 1.5;
  }
}

_id_13452() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = spawnStruct();
  var_0.origin = (9452, 49671, 1208);
  var_1 = scripts\mp\gameobjects::createhintobject(var_0.origin, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_83152052C9A037B0BD015D29F3400CDF59B410813C1B2F87FF173910B9F43953B16A");
  var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
  level notify("_encstr_B6DC19DCDB16F589ED5B260B9CC8B52BCD47BE8DEDAD38D8AC1D59");

  if(!isDefined(level._id_119E7))
    _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::init();

  var_3 = scripts\engine\utility::getStruct("_encstr_8F0917D05A966F380F94DF588BD3E6F97E73D028A2A157D32F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = scripts\engine\utility::getStruct("_encstr_99BD180F53D17FDDFF539B4F0F8BE709A3E3A31F023230128F92", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = scripts\engine\utility::getStruct("_encstr_ABBD18B1A516EBF65D470EDB9B47FA380B470D7DE6BD2395EB91", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = scripts\engine\utility::getStruct("_encstr_A7BD1882F87379170BA5E8FF3EF30F7A9BE8BAD968D7EF77262E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = var_4.origin + (20500, 20500, 8000);
  var_8 = [var_4.origin, var_5.origin, var_6.origin];
  var_1 delete();
  var_9 = _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A18(var_3, undefined, 1, var_8, var_7);
  var_9 thread _encstr_8D682EE66CE4D2838ECDBCAD38BC9D0BDA568E2F3856E6CB139CD7835D136396B1B267ACE6E8EB8EDBBB5939C5766E36::connectedplayercount();
  var_9.intro_driver_logic = _encstr_AC27347FFB0AD8B75BB398D86BDEE4406555C9E370B740503BBB6EC133AF28A031BB774B375B58444F9366686AA35338D6046DCFA346::_id_13450;
  var_9.intro_enemy_respawner = _encstr_AC27347FFB0AD8B75BB398D86BDEE4406555C9E370B740503BBB6EC133AF28A031BB774B375B58444F9366686AA35338D6046DCFA346::_id_13450;
  var_9.lootfunc = _encstr_8D682EE66CE4D2838ECDBCAD38BC9D0BDA568E2F3856E6CB139CD7835D136396B1B267ACE6E8EB8EDBBB5939C5766E36::_id_1344E;
  var_9._id_135B6 = 1;
  var_9.updateteamscoreplacements = 1;
  var_9.usefuncoverride = 1;
  var_9 thread _encstr_AC27347FFB0AD8B75BB398D86BDEE4406555C9E370B740503BBB6EC133AF28A031BB774B375B58444F9366686AA35338D6046DCFA346::_id_13450(var_4.origin);

  if(!isDefined(level._id_13460.choppers))
    level._id_13460.choppers = [];

  level._id_13460.choppers = scripts\engine\utility::array_add(level._id_13460.choppers, var_9);
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 thread scripts\mp\utility\dialog::leaderdialogonplayer(var_2.team + "_encstr_818E1BAF95CD95D62FD7477BB616BE6EE8392DDA2B7D4BDC31F6BAB991");
  var_2 thread crates_delete_early();
  level thread _id_11ECA(var_2.origin, 4000, var_2);
  var_10 = var_2 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A2E60C6BC099B7E1A0A93A398F48", var_2);
  var_11 = anglesToForward(var_2 getplayerangles());
  var_12 = anglesToForward(var_2.angles);
  var_13 = anglestoright(var_2.angles);

  for(var_14 = 0; var_14 < 10; var_14 = var_14 + 0.1) {
    var_15 = randomintrange(2000, 4000);
    var_16 = randomint(360);
    var_17 = var_15 * anglesToForward((0, var_16, 0));
    var_18 = var_2.origin + var_17;
    var_19 = var_2 scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(var_18, 500, var_11, var_12, var_13);
    var_19 = var_2 cratephysicsoncallback(var_18, 500);
    var_2 thread create_animpack(var_10, var_19);
    wait 0.1;
  }

  level notify("_encstr_B6DC19DCDB16F589ED5B260B9CC8B52BCD47BE8DEDAD38D8AC1D59");
}

_id_11CA1(var_0) {
  if(istrue(self.usefuncoverride) && scripts\mp\utility\weapon::unset_jugg_ignoreall_after_notify(var_0.objweapon))
    return getdvarint("_encstr_9616288BD186BF5E586FAB8F2B09A7EB2FA8C273785CEF59B067A7B7ED302CF7DE8DFA3961BF870E406B", 4500);

  return var_0.damage;
}

_id_11ECA(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag() || !var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(var_2) && var_5.team == var_2.team) {
      var_3[var_3.size] = var_5;
      button(var_5, var_2);
      continue;
    }

    if(length2dsquared(var_5.origin - var_0) < var_1 * var_1) {
      button_sequence(var_5);
      var_3[var_3.size] = var_5;
    }
  }

  var_7 = ["_encstr_B4EE153765A669F9F0211A639E6B0963FEEB9B8FB76FE7", "_encstr_A9EE1557B68B1629DCF7FDD9F7DD40A663E03C0997A5DA", "_encstr_B6EE15F2E99ED7F6D073B2BC6FB0BC3F4620DA7AD6D6A2"];
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog(var_7[randomintrange(0, 3)], 1, var_3);
}

button(var_0, var_1) {
  var_0 scripts\mp\hud_message::showsplash("_encstr_A1721D325BB8D34790E35154FF588DD75E51ABDAAD0D6BFB01C94935856894", undefined, var_1);
}

button_sequence(var_0) {
  var_0 scripts\mp\hud_message::showsplash("_encstr_A5181F2BE3F8520ABECD1381A996F5CD0929C0AC606568AB8FD8684A2533A0F2AF");
}

buttonmashcount(var_0) {
  var_0 scripts\mp\hud_message::showsplash("_encstr_A1F02398937D279567AC5836AF897BD631169C46DA59B9D1BE6316BADCD8A1F5AC37CA6B5E");
}

crates_delete_early() {
  var_0 = getmaxobjectivecount(self.origin[0], self.origin[1], 4000);
  level waittill("_encstr_B6DC19DCDB16F589ED5B260B9CC8B52BCD47BE8DEDAD38D8AC1D59");
  var_0 delete();
}

create_animpack(var_0, var_1) {
  var_2 = magicgrenademanual("_encstr_95E70D8EDBDA85F5839CED35F5B683", var_1.sourcepos, var_1.initvelocity, 5);
  var_2 setentityowner(self);
  var_2 setotherent(self);
  var_2.owner = self;
  var_2 setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 0);
  var_2.explodeent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.explodeent setModel("_encstr_8AED1AB69BBE47BD6BB0BEB98E9C4BD6B27DD64B6ECDD2632BEBAD07");
  var_2.explodeent linkTo(var_2);
  var_2.explodeent dontinterpolate();
  var_2.explodeent setentityowner(self);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.sourcepos);
  var_3 linkTo(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (10, 0, 10), (0, 0, 0));
  var_2.killcament = var_3;
  var_2.streakinfo = var_0;
  var_4 = randomint(360);
  var_2.angles = (90, var_4, 0);
  var_2 thread create_badplace_extraction(var_1.preexplpos, var_1.parachutecleanup);
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var_1.initvelocity), gettime(), var_1.initvelocity);
}

cratephysicsoncallback(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = var_0 + (0, 0, 5000);
  var_4 = vectorNormalize(var_0 - (var_3[0], var_3[1], 0));
  var_5 = scripts\cp_mp\killstreaks\toma_strike::_id_13BD6(var_0, var_1, var_4);
  var_6 = (0, 0, -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800));
  var_7 = (var_5.point - 0.5 * var_6 * squared(4) - var_3) / 4;
  var_8 = 3.925 * randomfloatrange(0.95, 1.0);
  var_9 = var_3 + var_7 * var_8 + 0.5 * var_6 * squared(var_8);
  var_2.sourcepos = var_3;
  var_2.num_of_frame_frozen = var_5.num_of_frame_frozen;
  var_2.num_of_subway_cars = var_5.num_of_subway_cars;
  var_2.goalpos = var_5.point;
  var_2.preexplpos = var_9;
  var_2.initvelocity = var_7;
  var_2.parachutecleanup = var_8;
  return var_2;
}

create_badplace_extraction(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
  self.killcament thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_move_killcam(3.675, var_0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self setmissileminimapvisible(0);
  thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_missile_explode(var_0);
}

_id_12818() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();
  level._id_12819 = scripts\engine\utility::array_remove(level._id_12819, self);
}