/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\coop_super.gsc
***********************************************/

init_super() {
  var_0 = spawnStruct();
  level.superglobals = var_0;
  var_0.staticsuperdata = [];
  var_0.superweapons = [];
  var_0.superearnratemultiplier = 1.0;
  var_0.supersbyid = [];
  var_0.supersbyoffhand = [];
  var_0.pointeventdata = [];
  level.superglobals.staticsuperdata["_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA"] = spawnStruct();
  level.superglobals.staticsuperdata["_encstr_995B109BAB0756E47DCA5B837D914EEDB995"] = spawnStruct();
  level.superglobals.staticsuperdata["_encstr_995B109BAB0756E47DCA5B837D914EEDB995"].id = 1;
  level.superglobals.staticsuperdata["_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA"].id = 11;
}

give_player_super(var_0) {
  var_1 = get_super_from_playerdata();

  if(!isDefined(var_1))
    var_1 = "_encstr_857B0AAB18E80D9999C7E55C";

  if(isDefined(self.super) && var_1 == self.super) {
    return;
  }
  hasselfrevivetoken();
  self.super = var_1;
  thread update_super_icon(var_1);

  switch (self.super) {
    case "_encstr_87980B9DC7BACD79E5D719B07E":
      thread scripts\cp\classes\cp_class_progression::give_medic_class();
      thread give_team_auto_revive();
      break;
    case "_encstr_857B0AAB18E80D9999C7E55C":
      thread scripts\cp\classes\cp_class_progression::give_tank_class();
      thread give_team_armor_buff();
      break;
    case "_encstr_A2390DCE2D323B06892F40D81FAC3B":
      thread scripts\cp\classes\cp_class_progression::give_assault_class();
      thread give_team_stopping_power();
      break;
    case "_encstr_B4D61039F68DB2AFC8AC6B7B63A58EA57BDC":
      thread scripts\cp\classes\cp_class_progression::give_crusader_class();
      thread give_thermite_launcher();
      break;
    case "_encstr_8B290C93058CC8486A2725E99F33":
      thread scripts\cp\classes\cp_class_progression::give_hunter_class();
      thread scriptable_carriable_use();
      break;
    case "_encstr_AB5C0E833A7B7539E7D67F7BCECFA046":
      thread scripts\cp\classes\cp_class_progression::give_engineer_class();
      thread giv_emp_drone();
      break;
  }

  thread init_super_for_player("_encstr_BEB611F03B72BB3B07E435BCF9772051117388");
}

hasselfrevivetoken() {
  if(isDefined(self.super)) {
    switch (self.super) {
      case "_encstr_87980B9DC7BACD79E5D719B07E":
        thread scripts\cp\classes\cp_class_progression::_id_12BDE();
        break;
      case "_encstr_857B0AAB18E80D9999C7E55C":
        thread scripts\cp\classes\cp_class_progression::_id_12BF8();
        break;
      case "_encstr_A2390DCE2D323B06892F40D81FAC3B":
        thread scripts\cp\classes\cp_class_progression::_id_12BC2();
        break;
      case "_encstr_B4D61039F68DB2AFC8AC6B7B63A58EA57BDC":
        thread scripts\cp\classes\cp_class_progression::_id_12BC8();
        break;
      case "_encstr_8B290C93058CC8486A2725E99F33":
        thread scripts\cp\classes\cp_class_progression::_id_12BD5();
        break;
      case "_encstr_AB5C0E833A7B7539E7D67F7BCECFA046":
        thread scripts\cp\classes\cp_class_progression::_id_12BCA();
        break;
    }
  }
}

script_end() {
  hasselfrevivetoken();

  if(isDefined(self.super)) {
    switch (self.super) {
      case "_encstr_87980B9DC7BACD79E5D719B07E":
        thread scripts\cp\classes\cp_class_progression::give_medic_class();
        break;
      case "_encstr_857B0AAB18E80D9999C7E55C":
        thread scripts\cp\classes\cp_class_progression::give_tank_class();
        break;
      case "_encstr_A2390DCE2D323B06892F40D81FAC3B":
        thread scripts\cp\classes\cp_class_progression::give_assault_class();
        break;
      case "_encstr_B4D61039F68DB2AFC8AC6B7B63A58EA57BDC":
        thread scripts\cp\classes\cp_class_progression::give_crusader_class();
        break;
      case "_encstr_8B290C93058CC8486A2725E99F33":
        thread scripts\cp\classes\cp_class_progression::give_hunter_class();
        break;
      case "_encstr_AB5C0E833A7B7539E7D67F7BCECFA046":
        thread scripts\cp\classes\cp_class_progression::give_engineer_class();
        break;
    }
  }
}

debug_set_super() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = getDvar("_encstr_9381137EAB0326378BDBC8780125E5B9EB428B7D05", "_encstr_B40101");

    if(var_0 != "_encstr_B40101") {
      if(self.class != var_0) {
        hasselfrevivetoken();
        self setweaponammoclip("_encstr_BEB611F03B72BB3B07E435BCF9772051117388", 1);

        switch (var_0) {
          case "_encstr_87980B9DC7BACD79E5D719B07E":
            thread scripts\cp\classes\cp_class_progression::give_medic_class();
            thread give_team_auto_revive();
            break;
          case "_encstr_857B0AAB18E80D9999C7E55C":
            thread scripts\cp\classes\cp_class_progression::give_tank_class();
            thread give_team_armor_buff();
            break;
          case "_encstr_A2390DCE2D323B06892F40D81FAC3B":
            thread scripts\cp\classes\cp_class_progression::give_assault_class();
            thread give_team_stopping_power();
            break;
          case "_encstr_B4D61039F68DB2AFC8AC6B7B63A58EA57BDC":
            thread scripts\cp\classes\cp_class_progression::give_crusader_class();
            thread give_thermite_launcher();
            break;
          case "_encstr_8B290C93058CC8486A2725E99F33":
            thread scripts\cp\classes\cp_class_progression::give_hunter_class();
            thread scriptable_carriable_use();
            break;
          case "_encstr_AB5C0E833A7B7539E7D67F7BCECFA046":
            thread scripts\cp\classes\cp_class_progression::give_engineer_class();
            thread giv_emp_drone();
            break;
        }
      }
    }

    wait 0.5;
  }
}

test_player_data_set() {
  var_0 = ["_encstr_A6C7065BAC91D28D", "_encstr_8DEF05BDE933E0", "_encstr_88CC09377EA33BA181ED2E", "_encstr_AB3508737F830710ACDB", "_encstr_A12707B8AB65E9A9C3", "_encstr_8CFF09D56D88EC030D69EB"];
  var_1 = 0;
  wait 10;

  for(;;) {
    var_2 = get_super_from_playerdata();
    var_1++;

    if(var_1 >= var_0.size)
      var_1 = 0;

    wait 1;
  }
}

update_super_icon(var_0) {
  _id_130A6(var_0);
  self setclientomnvar("_encstr_957E138DC1BE8DDE8532DEEA47BE8DD00BE69DCAC8", 0);
  wait 2;
  self setclientomnvar("_encstr_957E138DC1BE8DDE8532DEEA47BE8DD00BE69DCAC8", 1);
}

debug_give_super(var_0) {
  give_player_super(var_0);
}

get_super_from_playerdata() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_835A0FF94ACBEA830262CB0B129627E341");
  return var_0;
}

_id_130A6(var_0) {
  var_1 = int(tablelookup("_encstr_A12B1878A34F31B9A1D7F38D2D6ACB1B6F33E0F85FCB60574BFB", 1, var_0, 0));
  self setclientomnvar("_encstr_AA7016F347D6E9E01DA98CC073EF4ABBE9685A095867224A", var_1);
}

init_super_for_player(var_0) {
  give_super_weapon(var_0);
  thread scriptable_door_freeze_open(var_0);
  watch_for_super_button(var_0);
}

_id_14476(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9BB0122BB9C8F56EBA07B2C97D770BD1D80D5693");

  for(;;) {
    var_1 = self getammocount(var_0);

    if(var_1 == 0)
      self setweaponammoclip(var_0, 1);

    wait 0.1;
  }
}

give_super_weapon(var_0) {
  self giveweapon(var_0);
  self assignweaponoffhandspecial(var_0);
  self.specialoffhandgrenade = var_0;
  self setweaponammoclip(var_0, 1);
}

scriptable_door_freeze_open(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
    scripts\engine\utility::flag_init("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  self setweaponammoclip(var_0, 1);
}

watch_for_super_button(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_9BB0122BB9C8F56EBA07B2C97D770BD1D80D5693");
  self endon("_encstr_9BB0122BB9C8F56EBA07B2C97D770BD1D80D5693");
  self.super_ready = 0;
  thread recharge_super(var_0);
  thread _id_14476(var_0);
  self setclientomnvar("_encstr_8A931182A5CE507A8A2C73E892B7CB8853CD20", 0);
  self setclientomnvar("_encstr_A9400F1B83FA9BEAC159C9D727B21619BC", 0);
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  if(scripts\engine\utility::flag_exist("_encstr_9B31229FF1395365333F6BB17105BBF0B330895827A7B31183373713104BA747A4296FB1"))
    scripts\engine\utility::flag_wait("_encstr_9B31229FF1395365333F6BB17105BBF0B330895827A7B31183373713104BA747A4296FB1");

  for(;;) {
    self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_1);

    if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
      scripts\cp\utility::hint_prompt("_encstr_B4A20FD89B7B855ECF171BC3311EB07A88", 1, 2);
      self setweaponammoclip(var_0, 1);
      continue;
    }

    var_2 = var_1;

    if(issameweapon(var_1))
      var_2 = createheadicon(var_1);

    if(var_2 == var_0) {
      var_3 = 0;

      if(!self.super_ready)
        var_3 = 1;
      else if(istrue(self.inlaststand))
        var_3 = 1;
      else if(istrue(self.disable_super))
        var_3 = 1;
      else if(istrue(level._id_12B46))
        var_3 = 1;
      else if(istrue(self.interrogating))
        var_3 = 1;
      else if(scripts\cp\cp_weapon::_id_124AD(self))
        var_3 = 1;
      else if(!istrue(self isonground()))
        var_3 = 1;

      if(isDefined(self.currentturret))
        var_3 = little_bird_mg_init(self);

      if(!_id_13977())
        var_3 = 1;

      if(isDefined(level.generate_grenade_types_via_dvar) && ![[level.generate_grenade_types_via_dvar]](self))
        var_3 = 1;

      if(!var_3)
        thread fire_super(var_0);
      else
        scripts\cp\utility::hint_prompt("_encstr_B4A20FD89B7B855ECF171BC3311EB07A88", 1, 2);
    }

    self setweaponammoclip(var_0, 1);
  }
}

fire_super(var_0) {
  self.super_ready = 0;
  self setclientomnvar("_encstr_A9400F1B83FA9BEAC159C9D727B21619BC", 0);
  thread display_super_fired_splash();
  run_super_loop(var_0);
}

_id_13977() {
  if(self.class == "_encstr_A6C7065BAC91D28D") {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2 == self) {
        continue;
      }
      if(scripts\cp\cp_laststand::player_in_laststand(var_2))
        var_0 = 1;
    }

    return var_0;
  }

  return 1;
}

recharge_super(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9BB0122BB9C8F56EBA07B2C97D770BD1D80D5693");
  var_1 = 120;
  var_2 = getdvarint("_encstr_83430FAA838DBEBFBBF1F70809B4ECF7F8", 0);

  if(var_2)
    var_1 = var_2;

  if(istrue(self._id_12D7D)) {
    if(!isDefined(self.super_progress))
      self.super_progress = 997;
    else if(self.super_progress > 996)
      self.super_progress = 997;

    self._id_12D7D = undefined;
  } else
    self.super_progress = 997;

  var_3 = gettime();
  var_4 = var_3;

  for(;;) {
    var_2 = getdvarint("_encstr_83430FAA838DBEBFBBF1F70809B4ECF7F8", 0);

    if(var_2)
      var_1 = var_2;

    var_5 = 0;
    var_6 = gettime();

    if(istrue(self.super_activated))
      var_5 = 1;
    else if(istrue(self.inlaststand))
      var_5 = 1;
    else if(istrue(self.super_ready))
      var_5 = 1;
    else if(istrue(self.disable_super))
      var_5 = 1;

    if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3") && !scripts\engine\utility::flag("_encstr_A2D20FE4880D52A426C867576878654BD3"))
      var_5 = 1;

    if(var_5) {
      var_4 = var_6;
      waitframe();
      continue;
    }

    var_7 = var_6 - var_4;
    var_8 = var_7 / (var_1 * 1000) * 1000;
    var_8 = var_8 * scripts\cp\perks\cp_perks::get_perk("_encstr_A70F123AFB9BF1921E6B70E95DB963A6F083BE13");
    increase_super_progress(var_8);
    var_9 = self.super_progress / 1000;

    if(var_9 > 0.998)
      var_9 = 1.0;

    self setclientomnvar("_encstr_8A931182A5CE507A8A2C73E892B7CB8853CD20", var_9);
    var_4 = var_6;

    if(var_9 >= 1) {
      self.super_ready = 1;
      self setclientomnvar("_encstr_A9400F1B83FA9BEAC159C9D727B21619BC", 1);
      display_super_ready_splash();
    }

    waitframe();
  }
}

display_super_ready_splash() {
  if(!istrue(self._id_13975)) {
    self._id_13975 = 1;
    return;
  }

  if(!isDefined(self.class))
    self.class = "_encstr_8DEF05BDE933E0";

  if(self usinggamepad()) {
    var_0 = "_encstr_834B0DDCAEE02BE4FA9CB2B35ACECA";

    switch (self.class) {
      case "_encstr_A6C7065BAC91D28D":
        var_0 = "_encstr_964310CAE2875B633BAA8A313AC72B737B97";
        break;
      case "_encstr_8DEF05BDE933E0":
        var_0 = "_encstr_91140F8D0EEB37EAC195C97D584EADF639";
        break;
      case "_encstr_88CC09377EA33BA181ED2E":
        var_0 = "_encstr_B8A9116F6B591618C8E78B260E8C404E4387C5";
        break;
      case "_encstr_AB3508737F830710ACDB":
        var_0 = "_encstr_85E20E3638EB6EAB1C59C9BE855BD67B";
        break;
      case "_encstr_A12707B8AB65E9A9C3":
        var_0 = "_encstr_8BC40E038199BABF57D95B7120276B74";
        break;
      case "_encstr_8CFF09D56D88EC030D69EB":
        var_0 = "_encstr_970B0D6C38FA6EAB0E5927BECADA83";
    }
  } else {
    var_0 = "_encstr_A67214EE101F0B837222E879ABCF4D8063AD78529ABF";

    switch (self.class) {
      case "_encstr_A6C7065BAC91D28D":
        var_0 = "_encstr_A67214EE101F0B837222E879ABCF4D8063AD78529ABF";
        break;
      case "_encstr_8DEF05BDE933E0":
        var_0 = "_encstr_8CB713360EF5DCAE83959CD70B93DA7B39AF6D98B5";
        break;
      case "_encstr_88CC09377EA33BA181ED2E":
        var_0 = "_encstr_BAD415B1DBA76E78D2AD2507D3BD303653222BBEF2BBA9";
        break;
      case "_encstr_AB3508737F830710ACDB":
        var_0 = "_encstr_9BC012EBBF6E4F2399584B91508B1D87C6AA726D";
        break;
      case "_encstr_A12707B8AB65E9A9C3":
        var_0 = "_encstr_97011287E9A833757859723170D8BA0AAF771B37";
        break;
      case "_encstr_8CFF09D56D88EC030D69EB":
        var_0 = "_encstr_913111D80EFAB95D0759E4BE95DA83EBDA13AD";
    }
  }

  var_1 = self getentitynumber();
  setomnvar("_encstr_8DEC153DE1F7E149CEAB3851B36527792BAFC6BD41A36A", var_1);
  thread scripts\cp\cp_hud_message::showsplash(var_0, undefined, self);
}

display_super_fired_splash() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = "_encstr_B22212B9ABC1CA39D74E56ECB49DCAF5AB6E958C";

  switch (self.class) {
    case "_encstr_A6C7065BAC91D28D":
      var_0 = "_encstr_9B07158D837DDCAB38CA9C7DE495EC96B3597DD5B9CA19";
      break;
    case "_encstr_8DEF05BDE933E0":
      var_0 = "_encstr_910E14F740F9B09DE34A5BE6123359984A97534FFD9F";
      break;
    case "_encstr_88CC09377EA33BA181ED2E":
      var_0 = "_encstr_8D5216B2E3A782389AAB1B28372CDD28435A2ABFD3B3A949";
      break;
    case "_encstr_AB3508737F830710ACDB":
      var_0 = "_encstr_8E79106E5D1CCAE4AF85B6B5EDFAAE6E2B46";
      break;
    case "_encstr_A12707B8AB65E9A9C3":
      var_0 = "_encstr_B88C1319730FD6C07A05BDEF2566A092675B93419A";
      break;
    case "_encstr_8CFF09D56D88EC030D69EB":
      var_0 = "_encstr_AF9C1507FF1F1783015A7E3FCBB0DD0B42FFD993881F43";
  }

  var_1 = self getentitynumber();
  setomnvar("_encstr_970C156B277136E8F14AF34EB2D7787DFB972BD5CF1B8D", var_1);

  if(self.class == "_encstr_A6C7065BAC91D28D" || self.class == "_encstr_8DEF05BDE933E0" || self.class == "_encstr_AB3508737F830710ACDB") {
    setomnvar("_encstr_AA641D6C077DA32B855BBEBD9C5ACA73A3AC23AF9BEAC1B239D7CC5A4ECAC8", var_1);
    wait 6;
    setomnvar("_encstr_AF521D6C83F58ECAC2B5FAF62796B2E68E9523D7DCAB07ACC97DB273235946", var_1);
  } else {
    self setclientomnvar("_encstr_834C0FD80EBE9BEA835939FA992DE45619", 1);
    wait 6;
    self setclientomnvar("_encstr_834C0FD80EBE9BEA835939FA992DE45619", 0);
  }
}

increase_super_progress(var_0) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      if(isDefined(self.super_progress_scalar))
        var_0 = var_0 * self.super_progress_scalar;

      self.super_progress = self.super_progress + var_0;

      if(self.super_progress > 1000)
        self.super_progress = 1000;
    }
  }
}

decrease_super_progress(var_0) {
  if(!istrue(self.super_activated)) {
    if(!self.super_ready) {
      self.super_progress = self.super_progress - var_0;

      if(self.super_progress <= 0)
        self.super_progress = 0;
    }
  }
}

drain_super_meter(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AFD916567346FADCEAC156C9FAADB2A3954EFA560B271B2F");
  thread set_progress_to_zero_on_death();
  self.super_meter_draining = 1;
  var_1 = self getentitynumber();
  var_2 = gettime();
  var_3 = var_2;
  var_4 = 1.0;

  for(;;) {
    var_5 = gettime();
    var_6 = var_5 - var_3;
    var_7 = var_6 / (var_0 * 1000);
    var_4 = var_4 - var_7;

    if(var_4 < 0)
      var_4 = 0;

    self setclientomnvar("_encstr_8A931182A5CE507A8A2C73E892B7CB8853CD20", var_4);
    var_3 = var_5;
    waitframe();

    if(var_4 <= 0) {
      self.super_progress = 0;
      self notify("_encstr_9BD90EAD2BD156E4F5234E16D2B92B32");
      break;
    }
  }

  switch (self.class) {
    case "_encstr_8CFF09D56D88EC030D69EB":
    case "_encstr_A6C7065BAC91D28D":
    case "_encstr_8DEF05BDE933E0":
    case "_encstr_AB3508737F830710ACDB":
      setomnvar("_encstr_8BE5193B772166B8813A831EE267A8AD0B47AD93DB8A3F80D15509", var_1);
      break;
  }

  self.super_meter_draining = 0;
}

set_progress_to_zero_on_death() {
  self endon("_encstr_9BD90EAD2BD156E4F5234E16D2B92B32");
  self waittill("_encstr_AD75063D571AE108");
  self.super_progress = 0;
  self setclientomnvar("_encstr_8A931182A5CE507A8A2C73E892B7CB8853CD20", self.super_progress);
  self setclientomnvar("_encstr_834C0FD80EBE9BEA835939FA992DE45619", 0);
}

end_super_meter_progress_early() {
  self notify("_encstr_AFD916567346FADCEAC156C9FAADB2A3954EFA560B271B2F");
  self.super_progress = 0;
  self setclientomnvar("_encstr_8A931182A5CE507A8A2C73E892B7CB8853CD20", self.super_progress);
  self.super_meter_draining = 0;
}

run_super_loop(var_0) {
  if(isDefined(self.super_activate_func))
    self[[self.super_activate_func]]();

  while(istrue(self.super_activated))
    wait 0.1;
}

scriptable_carriable_use() {
  self.super_activate_func = ::at_mine_movingplatform_update;
}

give_instant_revive() {
  self.super_activate_func = ::activate_instant_revive;
}

give_team_armor_buff() {
  self.super_activate_func = ::activate_team_armor_buff;
  self.super_progress_scalar = 0.25;
}

give_thermite_launcher() {
  self.super_activate_func = ::activate_thermite_launcher;
  self.super_progress_scalar = 0.5;
}

give_auto_revive_crate() {
  self.super_activate_func = ::activate_auto_revive_crate;
}

give_team_auto_revive() {
  self.super_activate_func = ::activate_team_auto_revive;
  self.super_progress_scalar = 0.25;
}

give_team_stopping_power() {
  self.super_activate_func = ::activate_team_stopping_power;
}

giv_emp_drone() {
  if(isDefined(level.assassinationtimewarning))
    self.super_activate_func = level.assassinationtimewarning;
  else
    self.super_activate_func = ::activate_emp_drone;
}

activate_thermite_launcher() {
  self.super_activated = 1;
  self.gl_proj_override = "_encstr_8D7609A4F337C2C9C2BDB7";

  if(scripts\cp\cp_weapon::_id_124AD(self)) {
    scripts\cp\cp_weapon::minigamefinishcount(self);
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

    if(istrue(self.inlaststand)) {
      self.super_activated = 0;
      return;
    }
  }

  scripts\cp\crafting_system::givegrenadelauncher();
  thread drain_super_meter(1);
  scripts\cp\cp_analytics::_id_119BE(self, "_encstr_A742128DCA528B28FBE16517340B60A6FFC0174B");
  self setclientomnvar("_encstr_B8761B4DAC0119E08D2BB0981BA55E6F5AD6C6D6894BE7CB753319B00B", gettime());
  var_0 = self getentitynumber();
  var_1 = "_encstr_8D5216B2E3A782389AAB1B28372CDD28435A2ABFD3B3A949";

  foreach(var_3 in level.players)
  var_3 scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);

  while(istrue(self.has_gl))
    self waittill("_encstr_82670F7715C9CBB7A829F397FF6F4BB541");

  setomnvar("_encstr_8BE5193B772166B8813A831EE267A8AD0B47AD93DB8A3F80D15509", var_0);
  self setclientomnvar("_encstr_AD141C5DD2F5A3A1B29CAD96A356FA361BB0E6B9BE0EDEBB95C9D7BD9933", gettime());
  self.gl_proj_override = undefined;
  self.super_activated = 0;
}

remove_launcher_after_timeout(var_0) {
  self endon("_encstr_82670F7715C9CBB7A829F397FF6F4BB541");
  wait(var_0);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_weapon_pickup(1);
  var_1 = "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0";
  self takeweapon(var_1);
  self switchtoweapon(self.last_weapon);
  self.has_gl = undefined;
  self notify("_encstr_82670F7715C9CBB7A829F397FF6F4BB541");
}

team_unlimited_ammo() {
  foreach(var_1 in level.players) {
    var_1.has_infinite_ammo = 1;
    var_2 = ammo_round_up();
    var_1 thread unlimited_ammo(var_2);
  }
}

at_mine_movingplatform_update() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.super_activated = 1;
  thread x1ops4();
  var_0 = scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper();

  if(var_0) {
    var_1 = scripts\engine\utility::_id_143AE("_encstr_B869140FA0C127DBAF831F5D91C653E2439B55D98254", "_encstr_991711DE233BC532C7956AE87EBBFF97A2ED94", "_encstr_A5510A30AA778D28B3C97D51");

    if(var_1 == "_encstr_B869140FA0C127DBAF831F5D91C653E2439B55D98254") {
      var_2 = "_encstr_B88C1319730FD6C07A05BDEF2566A092675B93419A";

      foreach(var_4 in level.players)
      var_4 scripts\cp\cp_hud_message::showsplash(var_2, undefined, self);

      scripts\cp\cp_analytics::_id_119BE(self, "_encstr_83430CAA83B7FBA311D932E045A5");
      thread drain_super_meter(1);
      _id_14356();
      return;
    }

    self.super_activated = 0;
    return;
  } else
    self.super_activated = 0;
}

x1ops4() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_A30D18C8C3284D80CB429792D7F1A392B8AF3ACA27D7D3A3DD08", var_0);
  self._id_12F15 = var_0;
}

_id_14356() {
  var_0 = self getentitynumber();
  thread _id_143C5(5);
  _id_143C4();

  while(isDefined(self._id_12F15))
    waitframe();

  setomnvar("_encstr_8BE5193B772166B8813A831EE267A8AD0B47AD93DB8A3F80D15509", var_0);
  self.super_activated = 0;
}

_id_143C4() {
  self endon("_encstr_87B81463D67FB82DE9B3CDEF8312E0F8012D2978FBCC");

  while(!isDefined(self._id_12F15))
    wait 0.1;

  self notify("_encstr_87B81463D67FB82DE9B3CDEF8312E0F8012D2978FBCC");
}

_id_143C5(var_0) {
  self endon("_encstr_87B81463D67FB82DE9B3CDEF8312E0F8012D2978FBCC");
  wait(var_0);
  self notify("_encstr_87B81463D67FB82DE9B3CDEF8312E0F8012D2978FBCC");
}

superusefinished(var_0, var_1, var_2, var_3) {
  self notify("_encstr_BE3D16D745322B1E5F4B7BA1F1635B908CBB6963FC51106E");

  if(istrue(var_0))
    self notify("_encstr_991711DE233BC532C7956AE87EBBFF97A2ED94");
  else
    self notify("_encstr_B869140FA0C127DBAF831F5D91C653E2439B55D98254");

  self notify("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
}

activate_mark_enemies() {
  self.super_activated = 1;
  self.marked_enemies = 1;
  thread drain_super_meter(1);
  thread scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper();
  self.super_activated = 0;
}

deactivate_mark_enemies(var_0) {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::_id_143B9(var_0, "_encstr_81C210CC7B4E8D2B7DB2378CBEB9AEC159C9");
  self.marked_enemies = 0;
}

mark_enemies(var_0) {
  var_1 = 2;
  var_2 = 2;
  var_3 = 3000;
  var_4 = var_3 * var_3;
  var_5 = gettime();

  for(var_6 = var_5 + var_0 * 1000; var_5 < var_6; var_5 = gettime()) {
    var_7 = [];

    foreach(var_9 in level.agentarray) {
      if(isalive(var_9) && isDefined(var_9.team))
        var_7[var_7.size] = var_9;
    }

    var_7 = scripts\engine\utility::array_combine(var_7, level.players);
    var_7 = sortbydistance(var_7, self.origin);
    self setscriptablepartstate("_encstr_A1DB152B3B2332B355668955DFBDF1E8EF17D825B0EFE7", "_encstr_930B07BB1B6B3854FF");

    for(var_11 = 0; var_11 < var_7.size; var_11++) {
      if(!isDefined(var_7[var_11])) {
        continue;
      }
      if(!isalive(var_7[var_11])) {
        continue;
      }
      if(distancesquared(var_7[var_11].origin, self.origin) > var_4) {
        continue;
      }
      if(self.team != var_7[var_11].team) {
        var_7[var_11] hudoutlineenable("_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");
        waitframe();
      }
    }

    wait(var_1);

    if(var_2 > 0) {
      var_7 = [];

      foreach(var_9 in level.agentarray) {
        if(isalive(var_9) && isDefined(var_9.team))
          var_7[var_7.size] = var_9;
      }

      var_7 = scripts\engine\utility::array_combine(var_7, level.players);
      var_7 = sortbydistance(var_7, self.origin);

      for(var_11 = 0; var_11 < var_7.size; var_11++) {
        if(!isDefined(var_7[var_11])) {
          continue;
        }
        if(!isalive(var_7[var_11])) {
          continue;
        }
        if(self.team != var_7[var_11].team) {
          var_7[var_11] hudoutlinedisable();
          waitframe();
        }
      }

      self setscriptablepartstate("_encstr_A1DB152B3B2332B355668955DFBDF1E8EF17D825B0EFE7", "_encstr_A7A408B9CA5D1D4E2C63");
      self notify("_encstr_A25A12A873EDD9D6F72976E23FFFB84BD50A8020");
      wait(var_2);
    }
  }

  var_7 = [];

  foreach(var_9 in level.agentarray) {
    if(isalive(var_9) && isDefined(var_9.team))
      var_7[var_7.size] = var_9;
  }

  var_7 = scripts\engine\utility::array_combine(var_7, level.players);

  foreach(var_17 in var_7) {
    if(self.team != var_17.team) {
      self notify("_encstr_A25A12A873EDD9D6F72976E23FFFB84BD50A8020");
      var_17 hudoutlinedisable();
      var_17 notify("_encstr_862215BF811798E0A17999767F10B2EC4FD53332281909");
    }
  }

  self setscriptablepartstate("_encstr_A1DB152B3B2332B355668955DFBDF1E8EF17D825B0EFE7", "_encstr_A7A408B9CA5D1D4E2C63");
}

ammo_round_up() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = [];

  foreach(var_2 in self.weaponlist)
  var_0[createheadicon(var_2)] = self getammocount(var_2);

  return var_0;
}

unlimited_ammo(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81A8147B3DE8C32913802A72B003DB2F2130F1EDD9B0");

  if(!isDefined(self.weaponlist))
    self.weaponlist = self getweaponslistprimaries();

  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_infinite_ammo)) {
    var_1 = 0;

    foreach(var_3 in self.weaponlist) {
      var_4 = weaponclipsize(var_3);

      if(var_3 == self getcurrentweapon() && weapon_no_unlimited_check(var_3)) {
        var_1 = 1;

        if(var_4 == 1) {
          var_5 = self getweaponammostock(var_3);
          var_5++;
          self setweaponammostock(var_3, var_5);
        } else
          self setweaponammoclip(var_3, weaponclipsize(var_3), "_encstr_A5AD056A019C63");
      }

      if(var_3 == self getcurrentweapon() && weapon_no_unlimited_check(var_3)) {
        var_1 = 1;
        self setweaponammoclip(var_3, weaponclipsize(var_3), "_encstr_8253060E2B5FE330");
      }

      if(var_1 == 0)
        ammo_round_up();
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

deactivate_infinite_ammo(var_0) {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::_id_143B9(var_0, "_encstr_81C210CC7B4E8D2B7DB2378CBEB9AEC159C9");

  foreach(var_3 in level.players) {
    var_3.has_infinite_ammo = undefined;
    var_3 scripts\cp\utility::enable_infinite_ammo(0);
  }
}

activate_auto_revive_crate(var_0) {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.super_activated = 1;
  var_1 = scripts\cp\crafting_system::giveadrenalinecrate();

  if(!istrue(var_1))
    return 0;

  thread drain_super_meter(1);
  self.super_activated = 0;
}

activate_team_auto_revive(var_0) {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.super_activated = 1;
  var_1 = "_encstr_9B07158D837DDCAB38CA9C7DE495EC96B3597DD5B9CA19";
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_4)) {
      if(isDefined(var_4.last_stand_state) && var_4.last_stand_state == "_encstr_8FE20AD2903BB77B0E68ADA4") {
        continue;
      }
      var_4 thread team_instant_revive();
      var_4 scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);
      scripts\cp\cp_laststand::record_revive_success(self, var_4);
      var_2 = 1;
    }
  }

  if(var_2) {
    scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);
    scripts\cp\cp_analytics::_id_119BE(self, "_encstr_A65711E8592C6B400BAEE8BD5A4EB2B32D672B");
    drain_super_meter(1);
  }

  self.super_activated = 0;
}

team_instant_revive() {
  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    if(!isDefined(self.dogtag)) {
      self._id_140AC = 1;
      self giveandfireoffhand("_encstr_8D2D0E6140B635206963A79B6B4F1163");

      if(isDefined(self.reviveiconent)) {
        scripts\cp\cp_laststand::set_revive_icon_color(self.reviveiconent);
        self.reviveent makeunusable();
      }

      wait 3;
      scripts\cp\cp_laststand::instant_revive(self);
      self._id_140AC = undefined;
    }
  }
}

activate_instant_revive(var_0) {
  self.has_instant_revive = 1;
  self.old_revive_time_scalar = self.perk_data["_encstr_8C5B1339CAECB49DACD71D96B62BFAB98DB08D859C"];
  self.perk_data["_encstr_8C5B1339CAECB49DACD71D96B62BFAB98DB08D859C"] = 0;
  thread aoe_instant_revive(15);
  thread drain_super_meter(1);
  deactivate_instant_revive(15);
  self.super_activated = 0;
  var_1 = "_encstr_9B07158D837DDCAB38CA9C7DE495EC96B3597DD5B9CA19";

  foreach(var_3 in level.players)
  var_3 scripts\cp\cp_hud_message::showsplash(var_1, undefined, self);
}

deactivate_instant_revive(var_0) {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::_id_143B9(var_0, "_encstr_81C210CC7B4E8D2B7DB2378CBEB9AEC159C9");
  self notify("_encstr_B2EE14B3205F620758581B14E78093E1CD306B6A5813");
  self.has_instant_revive = undefined;
  self.perk_data["_encstr_8C5B1339CAECB49DACD71D96B62BFAB98DB08D859C"] = self.old_revive_time_scalar;
}

aoe_instant_revive(var_0) {
  self endon("_encstr_B2EE14B3205F620758581B14E78093E1CD306B6A5813");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 100;
  var_2 = var_1 * var_1;
  var_3 = gettime() + var_0 * 1000;

  while(gettime() < var_3) {
    foreach(var_5 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_5)) {
        if(distancesquared(self.origin, var_5.origin) < var_2) {
          var_5 scripts\cp\cp_laststand::instant_revive(var_5);

          if(isDefined(var_5.dogtag))
            var_5.dogtag delete();
        }
      }
    }

    wait 0.1;
  }
}

activate_team_armor_buff() {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.super_activated = 1;
  turn_on_team_armor_buff();
  scripts\cp\cp_analytics::_id_119BE(self, "_encstr_86020B2BD0D16D06CB364DC51E");
  thread deactivate_team_armor_buff(20);
  drain_super_meter(1);
  self.super_activated = 0;
}

turn_on_team_armor_buff() {
  var_0 = 100;
  var_1 = getdvarint("_encstr_B22F0EB812BA9701FB55887E0FEF4981", 0);

  if(var_1)
    var_0 = var_1;

  var_2 = "_encstr_910E14F740F9B09DE34A5BE6123359984A97534FFD9F";

  foreach(var_4 in level.players) {
    if(on_the_same_team(self, var_4) && isalive(var_4)) {
      var_4.has_team_armor = 1;
      scripts\cp\cp_armor::givearmor(var_4, var_0, 1);
      var_4.old_armor_scalar = var_4 scripts\cp\perks\cp_perks::get_perk("_encstr_93E02467088B9231A670DFD76099E579711061DAE12B6B756BC1D7A3E870CA2117BE7655DF75");
      var_4 scripts\cp\perks\cp_perks::set_perk("_encstr_93E02467088B9231A670DFD76099E579711061DAE12B6B756BC1D7A3E870CA2117BE7655DF75", var_4.old_armor_scalar * 1.5);
      var_4 scripts\cp\cp_hud_message::showsplash(var_2, undefined, self);
    }
  }

  setomnvar("_encstr_812A1A63948FD8EE0A5F0D4F77C2BF805BE14BB8BB1D1830E3072B31", 1);
}

on_the_same_team(var_0, var_1) {
  if(isDefined(var_0.team_number) && isDefined(var_1.team_number))
    return var_0.team_number == var_1.team_number;
  else
    return 1;
}

remove_team_armor_buff() {
  foreach(var_1 in level.players) {
    if(on_the_same_team(self, var_1)) {
      var_1.has_team_armor = undefined;
      var_1 scripts\cp\perks\cp_perks::set_perk("_encstr_93E02467088B9231A670DFD76099E579711061DAE12B6B756BC1D7A3E870CA2117BE7655DF75", var_1.old_armor_scalar);
    }
  }
}

deactivate_team_armor_buff(var_0) {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self getentitynumber();
  var_2 = scripts\engine\utility::_id_143B9(var_0, "_encstr_81C210CC7B4E8D2B7DB2378CBEB9AEC159C9");
  setomnvar("_encstr_8BE5193B772166B8813A831EE267A8AD0B47AD93DB8A3F80D15509", var_1);
  setomnvar("_encstr_812A1A63948FD8EE0A5F0D4F77C2BF805BE14BB8BB1D1830E3072B31", 0);
  remove_team_armor_buff();
}

activate_team_stopping_power() {
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.super_activated = 1;
  scripts\cp\cp_analytics::_id_119BE(self, "_encstr_BE52141BC7E9B316F3E0F059D189220930F3FF78E8B2");
  var_0 = "_encstr_AF38133733014E50705F43FE46455888B98F8FB31B";

  foreach(var_2 in level.players) {
    var_2 scr_br_collection_findpath();
    var_2 scripts\cp\cp_hud_message::showsplash(var_0, undefined, self);
  }

  drain_super_meter(1);
  setomnvar("_encstr_A9FE170B8909D061673A2ED1722F26085108B7B72DAAD9B843", gettime());
  self.super_activated = 0;
}

scr_br_collection_findpath() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  var_1 = weaponclipsize(var_0);
  self setweaponammoclip(var_0, var_1);
  thread _id_14442(var_0, var_1);
}

_id_14442(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread _id_12BE5();
  thread stoppingpower_watchhcrweaponchange(var_0);
  thread stoppingpower_watchhcrweaponfire(var_0, var_1);
  self waittill("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  scripts\cp\utility::takeperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
}

_id_12BE5() {
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp\utility::takeperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
}

stoppingpower_watchhcrweaponchange(var_0) {
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_839C17FFD9982B5868D0CF1AE84095C3780F0B3F5BBEF023D9");
  self.gavehcr = 0;

  while(self hasweapon(var_0)) {
    if(self getcurrentweapon() == var_0) {
      if(!self.gavehcr) {
        scripts\cp\utility::giveperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
        self.gavehcr = 1;
      }
    } else if(self.gavehcr) {
      scripts\cp\utility::takeperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
      self.gavehcr = 0;
    }

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }

  self setclientomnvar("_encstr_A31C18EA4BD7856BDAEDBED81B586EDCEBE07BDD2B937DDB3399", gettime());
  self notify("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
}

stoppingpower_watchhcrweaponfire(var_0, var_1) {
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_839C17FFD9982B5868D0CF1AE84095C3780F0B3F5BBEF023D9");
  self.rounds = var_1;
  thread _id_138F1(var_0, var_1);

  while(self hasweapon(var_0)) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_2);

    if(var_2 == var_0) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  self setclientomnvar("_encstr_A31C18EA4BD7856BDAEDBED81B586EDCEBE07BDD2B937DDB3399", gettime());
  self notify("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
}

_id_138F1(var_0, var_1) {
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_839C17FFD9982B5868D0CF1AE84095C3780F0B3F5BBEF023D9");
  self.rounds = var_1;

  while(self hasweapon(var_0)) {
    self waittill("_encstr_93BF0D5AE0F9EF8178850919A5A897");
    self.rounds--;

    if(self.rounds <= 0) {
      break;
    }
  }

  self setclientomnvar("_encstr_A31C18EA4BD7856BDAEDBED81B586EDCEBE07BDD2B937DDB3399", gettime());
  self notify("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
}

remove_team_stopping_power(var_0) {
  level notify("_encstr_829E1969DCFEA020D30F6373CF8BFDA890F2D0C0C76FC0E01B177D");
  level endon("_encstr_829E1969DCFEA020D30F6373CF8BFDA890F2D0C0C76FC0E01B177D");
  wait(var_0);
  setomnvar("_encstr_A31C18EA4BD7856BDAEDBED81B586EDCEBE07BDD2B937DDB3399", gettime());

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("_encstr_A31C18EA4BD7856BDAEDBED81B586EDCEBE07BDD2B937DDB3399", gettime());
    var_2 scripts\cp\utility::takeperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
  }
}

activate_emp_drone() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.super_activated = 1;
  thread x1ops5();
  var_0 = scripts\cp_mp\killstreaks\emp_drone::empdrone_beginsuper();

  if(var_0) {
    monitormounted();
    _id_14357();
  } else
    self.super_activated = 0;
}

monitormounted() {
  var_0 = "_encstr_AF9C1507FF1F1783015A7E3FCBB0DD0B42FFD993881F43";

  foreach(var_2 in level.players)
  var_2 scripts\cp\cp_hud_message::showsplash(var_0, undefined, self);

  scripts\cp\cp_analytics::_id_119BE(self, "_encstr_AFD30A3531888833D318530B");
  thread drain_super_meter(1);
}

x1ops5() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_A30D18C8C3284D80CB429792D7F1A392B8AF3ACA27D7D3A3DD08", var_0);
  self.monitorhotfoot = var_0;
  var_0 thread monitoringimpact();
  var_0 thread getcrateusetime();
}

_id_14357() {
  thread _id_143E5(5);
  _id_143E4();

  while(isDefined(self.monitorhotfoot))
    wait 0.1;

  self.super_activated = 0;
}

_id_143E4() {
  self endon("_encstr_A7E812A80870C7B2B6FD4323C8E3205545BF7DA3");

  while(!isDefined(self.monitorhotfoot))
    wait 0.1;

  self notify("_encstr_A7E812A80870C7B2B6FD4323C8E3205545BF7DA3");
}

_id_143E5(var_0) {
  self endon("_encstr_A7E812A80870C7B2B6FD4323C8E3205545BF7DA3");
  wait(var_0);
  self notify("_encstr_A7E812A80870C7B2B6FD4323C8E3205545BF7DA3");
}

monitoringimpact() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_88F611F7438B194B4B6F889AF045C340C13991");

  for(;;) {
    var_0 = prewaitandspawnclient();

    foreach(var_2 in var_0) {
      if(isDefined(var_2)) {
        if(var_2 == self) {
          continue;
        }
        if(isDefined(var_2.chopper)) {
          continue;
        }
        if(isDefined(var_2) && var_2 scripts\cp_mp\emp_debuff::can_be_empd()) {
          var_3 = distancesquared(self.origin, var_2.origin);

          if(var_3 > 250000) {
            continue;
          }
          _id_1292B();
          return;
        }
      }
    }

    waitframe();
  }
}

prewaitandspawnclient() {
  var_0 = scripts\cp\utility::getvehiclearray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.team) && var_3.team == "_encstr_8E8405EA382B2A")
      var_1[var_1.size] = var_3;
  }

  var_5 = getEntArray("_encstr_97710C6B2DCD1BAF3AD54E4E598E", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_7 in var_5) {
    if(isDefined(var_7.team) && var_7.team == "_encstr_8E8405EA382B2A")
      var_1[var_1.size] = var_7;
  }

  foreach(var_10 in level.spawned_enemies) {
    if(istrue(isDefined(var_10.unittype) && var_10.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B"))
      var_1[var_1.size] = var_10;
  }

  return var_1;
}

_id_1292B() {
  self.owner notify("_encstr_95B5131F1A41293BD62D75CF50947090E898F3635B");
  var_0 = "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18";
  var_1 = prewaitandspawnclient();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3.vehiclename) && isDefined(level.vehicle.instances[var_3.vehiclename])) {
      if(isDefined(level.vehicle.instances[var_3.vehiclename][var_3 getentitynumber()])) {} else
        var_3 dodamage(1, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0);

      continue;
    }

    var_3 dodamage(1, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0);
  }
}

getcrateusetime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_88F611F7438B194B4B6F889AF045C340C13991");
  var_0 = 500;

  for(;;) {
    var_1 = self.origin;
    var_2 = anglesToForward(self.angles);
    var_2 = vectorNormalize(var_2);
    var_3 = rotatevector((0, 30, 0), self.angles);
    var_4 = var_1 + var_3;
    var_5 = rotatevector((0, -30, 0), self.angles);
    var_6 = var_1 + var_5;
    var_7 = prewaitandspawnclient();
    getcrossbowimpactfunc(var_1, var_1 + var_2 * var_0, var_7, "_encstr_8A1804CA1061");
    getcrossbowimpactfunc(var_4, var_4 + var_2 * var_0, var_7, "_encstr_A5AD056A019C63");
    getcrossbowimpactfunc(var_6, var_6 + var_2 * var_0, var_7, "_encstr_8253060E2B5FE330");
    waitframe();
  }
}

getcrossbowimpactfunc(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, self);

  if(isDefined(var_4)) {
    if(var_4["_encstr_A53009A25003666B9818C6"] == 1) {
      return;
    }
    if(isDefined(var_4["_encstr_850E077B0BF30318B9"])) {
      if(scripts\engine\utility::array_contains(var_2, var_4["_encstr_850E077B0BF30318B9"])) {
        _id_1292B();
        return;
      }
    }

    if(var_4["_encstr_A53009A25003666B9818C6"] < 0.2) {
      if(var_3 != "_encstr_8A1804CA1061")
        wait 0.25;

      _id_1292B();
      return;
    } else {}
  }
}

little_bird_mg_init(var_0) {
  if(isDefined(var_0.class)) {
    switch (var_0.class) {
      case "_encstr_A6C7065BAC91D28D":
      case "_encstr_8DEF05BDE933E0":
      case "_encstr_AB3508737F830710ACDB":
        return 0;
      case "_encstr_AB49096BB878DFEB03FED7":
      case "_encstr_8CFF09D56D88EC030D69EB":
      case "_encstr_A12707B8AB65E9A9C3":
        var_0.disable_super = 1;
        return 1;
    }
  }
}

mousetraps(var_0) {
  var_0.disable_super = undefined;
}