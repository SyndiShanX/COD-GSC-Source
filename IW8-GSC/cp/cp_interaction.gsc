/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_interaction.gsc
***********************************************/

coop_interaction_pregame() {
  level thread assign_trigger_on_player_spawned();
}

init() {
  if(!scripts\engine\utility::flag_exist("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF"))
    scripts\engine\utility::flag_init("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");

  if(scripts\engine\utility::flag_exist("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B"))
    scripts\engine\utility::flag_wait("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  level.interactions = [];
  level.interaction_hintstrings = [];
  level.all_interaction_structs = scripts\engine\utility::getStructArray("_encstr_81010C2D9BE8B29C0B8D1D2DED37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.current_interaction_structs = level.all_interaction_structs;
  level.weapon_hint_func = ::default_weapon_hint_func;
  level thread interaction_sound_monitor();

  if(isDefined(level.gametype_interaction_func))
    [[level.gametype_interaction_func]]();

  if(isDefined(level.deployable_box_interaction))
    [[level.deployable_box_interaction]]();

  if(isDefined(level.map_interaction_func))
    [[level.map_interaction_func]]();

  if(isDefined(level.weapon_upgrade_interaction))
    [[level.weapon_upgrade_interaction]]();

  if(isDefined(level.init_personal_ent_zones))
    level[[level.init_personal_ent_zones]]();

  foreach(var_1 in level.current_interaction_structs) {
    var_1.in_array = 1;

    if(!isDefined(var_1.angles))
      var_1.angles = (0, 0, 0);

    var_1.targetmodels = [];

    if(!isDefined(var_1.script_parameters))
      var_1.script_parameters = "_encstr_8B1608EC43B8D647A113";

    if(var_1.script_parameters == "_encstr_96430FDBA7DB9BE07BAACA3138450B75FB") {
      var_1.requires_power = 1;
      var_1.powered_on = 0;
      var_1.power_area = get_area_for_power(var_1);
    } else {
      var_1.requires_power = 0;
      var_1.powered_on = 0;
    }

    if(isDefined(level.interactions[var_1.script_noteworthy]) && istrue(level.interactions[var_1.script_noteworthy].is_p_ent))
      scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_1);
  }

  if(getdvarint("_encstr_AA7C194E7782574F6F0C4B88CB98A397AB312B2B273FC0212A68BF", 0) == 0)
    level thread drop_interaction_structs_to_ground();

  var_3 = getarraykeys(level.interactions);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(level.interactions[var_3[var_4]].init_func)) {
      var_5 = scripts\engine\utility::getStructArray(var_3[var_4], "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
      level thread[[level.interactions[var_3[var_4]].init_func]](var_5);
    }
  }

  foreach(var_1 in level.current_interaction_structs) {
    if(isDefined(level.interactions[var_1.script_noteworthy]) && isDefined(level.interactions[var_1.script_noteworthy].useduration))
      var_1.useduration = level.interactions[var_1.script_noteworthy].useduration;
    else
      var_1.useduration = "_encstr_82370F09B522B08D175A6876A32BC8E07B";

    if(isDefined(var_1.script_modelname)) {
      if(isDefined(var_1.target)) {
        var_7 = scripts\engine\utility::getStructArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        foreach(var_9 in var_7) {
          if(!isDefined(var_9.script_noteworthy) || tolower(var_9.script_noteworthy) != "_encstr_87D10ACD8DCA7356CDED19B2" && tolower(var_9.script_noteworthy) != "_encstr_8F4C14B05FB67B130A11060632327903DFC71870D75C")
            thread spawninteractionmodel(var_1, var_9);
        }

        continue;
      }

      if(isDefined(var_1.script_noteworthy) && tolower(var_1.script_noteworthy) != "_encstr_87D10ACD8DCA7356CDED19B2")
        thread spawninteractionmodel(var_1, var_1);
    }
  }

  scripts\engine\utility::flag_set("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");

  foreach(var_13 in level.players) {
    var_14 = var_13 getcurrentweapon();

    if(isDefined(level.wave_num) && isDefined(var_14))
      self.waveswithweapons = [level.wave_num][createheadicon(var_14)];
  }
}

drop_interaction_structs_to_ground() {
  if(!scripts\engine\utility::flag_exist("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5"))
    scripts\engine\utility::flag_init("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5");

  if(!scripts\engine\utility::flag("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5"))
    scripts\engine\utility::flag_wait("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5");

  foreach(var_1 in level.all_interaction_structs) {
    if(isDefined(var_1.groupname) && var_1.groupname == "_encstr_913C0C3CF82177DB8BA813BA23D3") {
      continue;
    }
    var_2 = scripts\engine\utility::drop_to_ground(var_1.origin, 10, -200);
    var_1.origin = var_2 + (0, 0, 1);
  }
}

get_area_for_power(var_0) {
  var_1 = getEntArray("_encstr_A99C0D6E832CBBB9BEECB7D8BA5BB2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin, var_3)) {
      if(isDefined(var_3.basename))
        return var_3.basename;
    }
  }

  return undefined;
}

get_adjacent_volumes_from_volume() {
  if(isDefined(level.adjacent_volumes[self.basename])) {
    var_0 = [];

    foreach(var_2 in level.adjacent_volumes[self.basename])
    var_0[var_0.size] = level.spawn_volume_names[var_2];

    return var_0;
  }

  return [];
}

is_in_adjacent_volume(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_0.adjacent_volumes))
    return 0;

  foreach(var_2 in var_0.adjacent_volumes) {
    if(!var_2.active) {
      continue;
    }
    if(self istouching(var_2))
      return 1;
  }

  return 0;
}

release_interaction_ent(var_0) {
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self.in_use = 0;
  self notify("_encstr_AD111943FE93A0BE074AFB4092E3E068AD5CA7ED9DFDF80F67C2F1");
}

assign_trigger_on_player_spawned() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);
    var_0.interaction_trigger = var_0 get_player_interaction_trigger();

    if(!isDefined(var_0.interaction_trigger))
      iprintlnbold("_encstr_96011293D3108A25A474E8519204C8A755271190");

    reset_interaction_triggers();
    var_0.last_interaction_point = undefined;
    var_0.interaction_trigger makeunusable();
    var_0 thread release_player_interaction_trigger();
    var_0 thread player_interaction_monitor();
    var_0 thread player_interaction_weapon_switch_monitor();
  }
}

player_interaction_weapon_switch_monitor() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_9B250DC319077B65B00FB8B93DD0AF");
    self.last_interaction_point = undefined;
    self.resetguidedinteraction = 1;
    self notify("_encstr_A3F4170B23DF67A10C3EA18B4A76382DAF0A20360A0714D8A6");
  }
}

get_player_interaction_trigger() {
  if(isDefined(self.interaction_trigger))
    return self.interaction_trigger;
  else {
    var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_0.in_use = 1;
    var_0 thread scripts\cp\utility::deleteonplayerdeathdisconnect(self);
    return var_0;
  }
}

release_player_interaction_trigger() {
  var_0 = self.interaction_trigger;
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.in_use = 0;
}

registerinteraction(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(!isDefined(var_5))
    var_5 = "_encstr_82370F09B522B08D175A6876A32BC8E07B";

  var_11 = spawnStruct();
  var_11.script_noteworthy = var_0;
  var_11.hint_func = var_1;
  var_11.spend_type = var_7;
  var_11.tutorial = var_8;
  var_11.activation_func = var_2;
  var_11.enabled = 1;
  var_11.disabledguidedinteractions = 1;
  var_11.cost = 0;
  var_11.requires_power = var_9;
  var_11.init_func = var_3;
  var_11.can_use_override_func = undefined;
  var_11.noactivation = var_4;
  var_11.useduration = var_5;
  var_11.is_p_ent = var_6;
  level.interactions[var_0] = var_11;
  var_12 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  add_interaction_structs_to_interaction_arrays(var_12);

  if(isDefined(var_3)) {
    if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B") && scripts\engine\utility::flag("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B")) {
      level thread[[var_3]](var_12);

      if(istrue(var_6)) {
        foreach(var_11 in var_12)
        scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_11);
      }
    }
  }
}

add_interaction_structs_to_interaction_arrays(var_0) {
  level.current_interaction_structs = scripts\engine\utility::array_combine(level.current_interaction_structs, var_0);
  level.current_interaction_structs = scripts\engine\utility::array_remove_duplicates(level.current_interaction_structs);
}

interactionhasactivation(var_0) {
  return istrue(level.interactions[var_0.script_noteworthy].noactivation);
}

register_interaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  registerinteraction(var_0, var_3, var_4, var_7, var_9, var_10);
}

reset_interaction_triggers() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.interaction_trigger))
      hide_interaction_trigger_from_others(var_1);
  }
}

hide_interaction_trigger_from_others(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      var_0.interaction_trigger enableplayeruse(var_0);
      continue;
    }

    var_0.interaction_trigger disableplayeruse(var_2);
  }
}

wherethehellami(var_0, var_1) {
  for(;;) {
    thread scripts\engine\utility::draw_capsule(var_1.origin, 12, 12, var_1.angles, (1, 1, 0), 0, 1);
    wait 0.05;
  }
}

_id_11E94() {
  return isDefined(self.last_interaction_point);
}

trial_juggernauts_to_spawn(var_0) {
  return self.last_interaction_point != var_0;
}

player_interaction_monitor() {
  self notify("_encstr_82991BC39DB8B81960CF9B2853EB7079BFA47095051120D2E0B35B370B");
  self endon("_encstr_82991BC39DB8B81960CF9B2853EB7079BFA47095051120D2E0B35B370B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  if(scripts\engine\utility::flag_exist("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF"))
    scripts\engine\utility::flag_wait("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");
  else {
    while(!isDefined(level.current_interaction_structs))
      wait 1;
  }

  if(isDefined(level.player_interaction_monitor))
    self thread[[level.player_interaction_monitor]]();
}

flash_inventory() {
  self endon("_encstr_A14C13B3CAE365289317A9DD513AE137B3E2897982");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.next_inventory_flash))
    self.next_inventory_flash = gettime() + 2500;
  else if(gettime() < self.next_inventory_flash) {
    return;
  }
  self.next_inventory_flash = gettime() + 2500;
  wait 1.5;
}

can_use_interaction(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(istrue(self.iscarrying))
    return 0;

  if(istrue(var_0.disabled) || !scripts\cp\utility::areinteractionsenabled() || self isinphase())
    return 0;

  if(istrue(var_0.awaitingpent))
    return 0;

  if(self secondaryoffhandbuttonPressed() || self isthrowinggrenade() || self fragButtonPressed())
    return 0;

  if(!self isonground())
    return 0;

  if(!isDefined(var_0.script_noteworthy)) {
    thread debugremoveinteractionandsendmessage(var_0, "_encstr_8C781FDCB061DAE2B980730FC87097E309D6A3D62571712C23281763CAC974BF79" + var_0.origin + "_encstr_91D92D04917B95B908CDEDA3010D85EC2B088508C5B98D27A507A3BE37DB1DB2EEED27E8A1BC0219AC33B4372B91C5");
    return 0;
  }

  if(!isDefined(level.interactions[var_0.script_noteworthy])) {
    thread debugremoveinteractionandsendmessage(var_0, "_encstr_8C781FDCB061DAE2B980730FC87097E309D6A3D62571712C23281763CAC974BF79" + var_0.origin + "_encstr_BD8A1BD66433A380E982378F9838506B87708D7BC5676AC24B9817E222" + var_0.script_noteworthy + "_encstr_A177321618A7D71650F7441885600FDB7F33DAEA800603BF68DB4C609BE8862FF0E192C2CBD543F6C8114927AD611A2326E34AEB");
    return 0;
  }

  return 1;
}

debugremoveinteractionandsendmessage(var_0, var_1) {}

reset_interaction() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.2;
  self.interaction_trigger makeunusable();
  self.last_interaction_point = undefined;
}

set_interaction_point(var_0, var_1) {
  if(istrue(self.interaction_trigger.disableinteraction)) {
    return;
  }
  self notify("_encstr_8B75165B6F4CC18BA29B9BBDE75A4DC8FF0546B31589803D");
  self.interaction_trigger dontinterpolate();
  self.last_interaction_point = var_0;
  var_2 = self getEye();
  self.interaction_trigger.origin = (var_0.origin[0], var_0.origin[1], var_2[2]);

  if(interactionhasactivation(var_0)) {
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    return;
  }

  if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type))
    level.interactions[var_0.script_noteworthy].spend_type = "_encstr_A3BA05E0735C50";

  var_3 = level.interactions[var_0.script_noteworthy].spend_type;
  var_4 = undefined;

  if(interaction_is_weapon_buy(var_0)) {
    if(!scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
      var_5 = getweaponnamestring(var_0.script_noteworthy);
      var_6 = getweaponcostint(var_0.script_noteworthy);
      self.interaction_trigger sethintstringparams(var_5, var_6);
    }
  } else if(trial_hitmarker(var_0)) {
    var_7 = strtok(var_0.name, "_encstr_BA4C02DF");
    var_8 = int(var_7[1]);
    self.interaction_trigger sethintstringparams(var_8);
  } else if(trial_is_event(var_0)) {
    var_9 = remove_specific_structs(var_0.script_label);

    switch (var_0.script_noteworthy) {
      case "_encstr_A3570BBE6DCFE6D54B5B8050D2":
        self.interaction_trigger sethintstringparams(var_9);
        break;
    }
  } else if(interaction_is_chess_piece(var_0)) {
    var_9 = getalphabetstring(level.currentalphanumericcode[0]);
    var_10 = getalphabetstring(level.currentalphanumericcode[1]);
    var_11 = getnumberstring(level.currentalphanumericcode[2]);

    switch (var_0.script_noteworthy) {
      case "_encstr_BE6D166C342BE637FA07D2CA1B56FADCAC369536E82DDBDC":
        self.interaction_trigger sethintstringparams(var_9);
        break;
      case "_encstr_AF261620BA67A72B3720ED6212C3D137CE623080C27E3383":
        self.interaction_trigger sethintstringparams(var_10);
        break;
      case "_encstr_A730148843631FBB8F2B0B2AD54C2799E5B3EA6E60BA":
        self.interaction_trigger sethintstringparams(var_11);
        break;
    }
  } else if(interaction_is_pvpve_weapon_pickup(var_0)) {
    if(isDefined(level.set_pvpve_weapon_interaction_func))
      [[level.set_pvpve_weapon_interaction_func]](var_0, self);
  } else if(interaction_is_weapon_pickup(var_0))
    set_weapon_interaction_string(var_0, self);
  else if(interaction_is_trap(var_0))
    self.interaction_trigger.origin = (var_0.origin[0], var_0.origin[1], var_2[2] - 15);

  set_interaction_trigger_properties(self.interaction_trigger, var_0);

  if(!isDefined(var_0.suseduration))
    var_0.suseduration = "_encstr_97C20EB5FD43A179CC6AD05152651579";

  if(!isDefined(var_1))
    thread wait_for_interaction_triggered(var_0);

  self.interaction_trigger makeusable();
}

remove_specific_structs(var_0) {
  if(getdvarint("_encstr_AB9017F6A91A17B64FE084E52B888868D04D7893AB8A92B325", 0) != 0) {
    switch (var_0) {
      case "_encstr_994C0238":
        return &"_encstr_A64B30453A6FA197A853F7D767B04719CD804EFC939FD150C02FF5D3CEB98DC9A2AC9414C8C559EFC9079FC7DF917DF1602A";
      case "_encstr_8B4C0248":
        return &"_encstr_B64B30507937D9B0FF49DFE6A04372137FAEB9601374A4E09F51195DBE0379A1023179D4C8289FBF45E5DE3FA73D35CFC9E2";
      case "_encstr_834C02D0":
        return &"_encstr_865327A0F3991AABA1C00ED0E85319B341E0E1188D4180A0604F7AC1182CA8E8720BA58DA68B2F6BBA";
      case "_encstr_A14C02D5":
        return &"_encstr_AF53276882F54A829211FA34F4D428C4A861FA92553A74EB35052D2A7952E4D04A8A6A2AE42AAF0BC8";
      case "_encstr_934C02A2":
        return &"_encstr_BE182DD0A07D250AA444BEA17AA641895161EB52AA3A747DA6A0D2A2979A4A2CD77428551DA8F5C264FAA83DFA0B4C";
      case "_encstr_AB4C02AB":
        return &"_encstr_8E20230D0AEB25145211AFD07A530513150BAF25AA3AA37DD414D28ABC922AA6A2A2EB8562";
      case "_encstr_A74C0257":
        return &"_encstr_BE20236B1F0851CF8C7160DD377D4B3335D9B7A40FBF47DF516043A5D00A2F96D0CFF109CF";
      case "_encstr_8C4C0258":
        return &"_encstr_AD332A1A82EB25502588AF0D7AD414262A2CBE49AA3A74D76A50A551CB88A20513E9ACBE94A205229293744D";
      case "_encstr_9A4C0209":
        return &"_encstr_92672DE7C3985A65BC9DE946D083397CE5E1C96ACD2F89B959D1DE9F6AC5413861D4E9D5FFD8F109D7D191CF57730A";
      case "_encstr_BA4C02CA":
        return &"_encstr_83F72B340AFA94282544AF1AE9D40598A816D7A4AA1DA3FA9A0A69A29722529A41261465F5495450224A39E84D";
    }
  }

  if(getdvarint("_encstr_8DE31A6E369CFA53D5B376FAAD85F4ACBECCD595D8AF07ABA79EB156", 0) != 0) {
    switch (var_0) {
      case "_encstr_994C0238":
        return &"_encstr_9254252789880161519DD9D61499B8186D71CF8B3BDC1807290580AFE551E7615FC70B0F47FBA7";
      case "_encstr_8B4C0248":
        return &"_encstr_B85425269271255531639179671D4FA17808A0DABBA8475EED8FA171FE7BE74FD165B1D581B175";
      case "_encstr_834C02D0":
        return &"_encstr_865327A0F3991AABA1C00ED0E85319B341E0E1188D4180A0604F7AC1182CA8E8720BA58DA68B2F6BBA";
      case "_encstr_A14C02D5":
        return &"_encstr_AF53276882F54A829211FA34F4D428C4A861FA92553A74EB35052D2A7952E4D04A8A6A2AE42AAF0BC8";
      case "_encstr_934C02A2":
        return &"_encstr_AA882706B25105B5D1837199473D6FC11828803A5B88673E8DAF4151DE1A85B7A0C318342601BFA5BB";
      case "_encstr_AB4C02AB":
        return &"_encstr_85B5290E902992E72415910EA7E462A1B1E14F0CDB4F541157D6798DE5762D2AE35791999311DF8556CE13";
      case "_encstr_A74C0257":
        return &"_encstr_B2B5297989B89A1619EDB9E6AFB142D5554021752990488149D758CB9E4711F02F33FC36F43891F251B825";
      case "_encstr_8C4C0258":
        return &"_encstr_8C172907A9A82141B17D393634B998780D11EFABDBFC38674925608F20C9DF40F28703AF5391612641AC2A";
      case "_encstr_9A4C0209":
        return &"_encstr_AF0B245D2267A99FD05BEFDF5FB85FE1D58846F49BA7C9A8C837FDEBC6B10FB9ACD58C6CF0CD";
      case "_encstr_BA4C02CA":
        return &"_encstr_83F72B340AFA94282544AF1AE9D40598A816D7A4AA1DA3FA9A0A69A29722529A41261465F5495450224A39E84D";
    }
  }

  switch (var_0) {
    case "_encstr_994C0238":
      return &"_encstr_8EC11C9F3120A9C9C9F5A1BE8C315080959967235344A09FC1BDE837A839";
    case "_encstr_8B4C0248":
      return &"_encstr_91C11CE9F1215DD5274CA0B66F1F3FD91FD99129D94F3F2EEFB12ABD175B";
    case "_encstr_834C02D0":
      return &"_encstr_ACC11CC57FDF0AE55B7941CFA4A577FB47D9EFA43567C737DCB3B34FAEFE";
    case "_encstr_A14C02D5":
      return &"_encstr_A3C11C340A7D25142588AFD09E531489A82CEB92AA741DF55314B42AE522";
    case "_encstr_934C02A2":
      return &"_encstr_8FC11C8B69315AD7735511D81C594B0509811F1ACB4957E709ED79A0E885";
    case "_encstr_AB4C02AB":
      return &"_encstr_A1C11C86785767B36478B951A00DC9FC97C8308A95CF0D475D30E9799E17";
    case "_encstr_A74C0257":
      return &"_encstr_93C11C669F079981ECE9AFD79944A8C09B33F9ACE5EF74D734B9A3F782FD";
    case "_encstr_8C4C0258":
      return &"_encstr_88C11CF0CF68839E9951BFAB6F911223BD26C9E8F7CC9F41C14382B55761";
    case "_encstr_9A4C0209":
      return &"_encstr_81C11C8682EB490A2522AF689EA60A315161AF9255D1D17D5350968A97A4";
    case "_encstr_BA4C02CA":
      return &"_encstr_87C11C86057D92824A117D1A9EA641315185EB52AAD1E8BE9A0A6951CB94";
  }
}

getalphabetstring(var_0) {
  switch (var_0) {
    case "_encstr_994C0238":
      return &"_encstr_8DC009E6F190B9CDB616A7";
    case "_encstr_8B4C0248":
      return &"_encstr_A5C009E5FFC1B0BDB0A788";
    case "_encstr_834C02D0":
      return &"_encstr_86C009BE92811897B3EE07";
    case "_encstr_A14C02D5":
      return &"_encstr_8BC00923C199756F4E9038";
    case "_encstr_934C02A2":
      return &"_encstr_83C0096882FA62284879A2";
    case "_encstr_AB4C02AB":
      return &"_encstr_9BC009CBAF6EB32EFD0A08";
    case "_encstr_A74C0257":
      return &"_encstr_99C0092ED7BFC049456A07";
    case "_encstr_8C4C0258":
      return &"_encstr_ABC00986057D6250905E24";
    case "_encstr_844C0294":
      return &"_encstr_8FA90CE3495F7D913ACE028FB7AA";
    case "_encstr_AF4C0272":
      return &"_encstr_96570E860AAF130A84972DC952E8128A";
    case "_encstr_B64C0271":
      return &"_encstr_AFAD0D7EA751E4B0BEC7D7DF0BD588";
    case "_encstr_A94C02B4":
      return &"_encstr_B2D80C78BBF72B3FE56F5C8C1D20";
    case "_encstr_A64C0227":
      return &"_encstr_8BBB0C8E604FBCBBAEB6C95929F5";
  }
}

getnumberstring(var_0) {
  switch (var_0) {
    case "_encstr_A34C02BB":
      return &"_encstr_99C0092ED7BFC049456ADE";
    case "_encstr_A74C0222":
      return &"_encstr_ABC00986057D6250905E19";
    case "_encstr_A14C023B":
      return &"_encstr_A7C0093F5FA8F497CD4E92";
    case "_encstr_AC4C024A":
      return &"_encstr_A1C009867857A4B3A6CEE2";
    case "_encstr_B84C027E":
      return &"_encstr_93C009669F0778818DB206";
    case "_encstr_8F4C026A":
      return &"_encstr_A3C009340A7DC41409E51B";
    case "_encstr_914C02DC":
      return &"_encstr_8FC0098B6931DDD7F63897";
    case "_encstr_864C02F9":
      return &"_encstr_91C009E9F12161D50B2713";
  }
}

set_weapon_interaction_string(var_0, var_1) {
  var_2 = get_weapon_name_string(var_0);
  self.interaction_trigger sethintstringparams(var_2);
}

get_weapon_name_string(var_0) {
  switch (var_0.name) {
    case "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B":
      return &"_encstr_B4FD1A4FE190F87749A7F1CBBD0150F4C07F76FB3B38F03F398DA25A";
    case "_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07":
      return &"_encstr_B6611A57D9AE39185733D037BD6819C449BF26417C917FD95F15B1AC";
    case "_encstr_93D811967783AFB9DAEB5BC1C2E0B0D4F5AD83":
      return &"_encstr_8A1F1A1A82F5897AA72AFAD5A21414F4C94D5ED435FAA982A01414A9";
    case "_encstr_B8AB117B772FAF28D569E9630F8F88C4F1A7C1":
      return &"_encstr_A6401A552A1F21E0B803E7CF7F6057F1D67250AF85B7F1A55007C9E5";
    case "_encstr_8E0916834FDAD6A71DB9D05063360B83EFC5970BB39F99E9":
    case "_encstr_AFD81196BB83FADCDA7D0785832C9C817DAD83":
      return &"_encstr_ABC71A340AD762F49EA8AF5D155082A739A6BCD4A97DA0A028282706";
    case "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1":
      return &"_encstr_A6DE193414BE263DF42AF55D8A820A3D93D4BC0525BE53922D15D0";
    case "_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588":
      return &"_encstr_AA8D1B9622C1A9C46773E1A91F41FF77381A280F0A79FB0C190B59AA2E";
    case "_encstr_A14C17702BBAF858D21783EF593D6015DE0149DB523F30906A":
      return &"_encstr_AA8D1B9622C1A9C46773E1A91F41FF77381A280F0A79FB0C190B59AA2E";
    case "_encstr_965111B4EEC1AFB027FACC58B11C860BBE5B1C":
      return &"_encstr_A1E01A67322F2B270879E7293995AABD10BA070F99C66E09F9536849";
    case "_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937":
      return &"_encstr_AB601B0EE0CF3C276D81316988B65114334BB0110527041385584A4AE7";
    case "_encstr_AA511062DBBA97C9E8DF996A9791D207C0F2":
      return &"_encstr_8E8819C87947E5CF04CDBF8F6DEDFB7D3D0976B009EF2A073CD9A7";
    case "_encstr_B8F911CBC79FB0B846F998109C35D27D813771":
      return &"_encstr_84D41A18A997351FF43D4F5F5DDDAB0D4D594691E13F3D7F2C8D2934";
    case "_encstr_8D06112DDDE0EB6EE6BEB5B463BD271CFAD61C":
      return &"_encstr_83E31A86A0EB31F4E9A8EB75A282059E2735E59A72EB2D9498A79370";
    case "_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0":
      return &"_encstr_91DA1B6841FA31A7D38AEBBA2A28419E72D4BCD4C9AF05C441840A6A18";
  }
}

getweaponnamestring(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = scripts\cp\utility::getbaseweaponname(var_0);

  if(!isDefined(var_1))
    return undefined;

  switch (var_1) {
    default:
      if(isDefined(level.custom_weaponnamestring_func)) {
        return [[level.custom_weaponnamestring_func]](var_1, var_0);
        return;
      }

      return &"_encstr_86F8170D41F5966A09FABA15A0149E7235F23A8A9C1594251A";
      return;
  }
}

getweaponcostint(var_0) {
  return int(level.interactions[var_0].cost);
}

set_interaction_trigger_properties(var_0, var_1) {
  var_2 = get_interaction_hintstring(var_1, self);

  if(isDefined(var_2))
    self.interaction_trigger setHintString(var_2);

  if(interaction_is_weapon_buy(var_1)) {
    if(isDefined(var_2) && !isstring(var_2) && var_2 == &"_encstr_9B6D20D0A7F40AF5A4E4512A49A08645A4F4C935E5285525862105A6517D14D435E9") {
      var_3 = scripts\cp\utility::getrawbaseweaponname(var_1.script_noteworthy);
      var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
      var_5 = getweaponnamestring(var_1.script_noteworthy);

      if(var_4 > 1)
        self.interaction_trigger sethintstringparams(int(4500), var_5);
      else
        self.interaction_trigger sethintstringparams(int(0.5 * level.interactions[var_1.script_noteworthy].cost), var_5);
    }
  } else
    self.interaction_trigger setusefov(160);

  self.interaction_trigger setusepriority(1);

  if(isDefined(level.interaction_trigger_properties_func))
    [[level.interaction_trigger_properties_func]](var_0, var_1, var_2);
}

get_interaction_hintstring(var_0, var_1) {
  if(isDefined(level.interactions[var_0.script_noteworthy].hint_func))
    return [[level.interactions[var_0.script_noteworthy].hint_func]](var_0, var_1);

  if(isDefined(var_0.cooling_down))
    return &"_encstr_97F21BA940651956E786E575B2EF9DA95CE859A1BE8EEF6CABF46074B6";

  if(istrue(var_0.requires_power) && !istrue(var_0.powered_on))
    return &"_encstr_8811213D9FC80897B90B9497FAF77BE3FB8D8937A2CB8DF9416C51FDD60699A7BC0956";

  if(interaction_is_weapon_buy(var_0)) {
    if(!scripts\cp\utility::coop_mode_has("_encstr_92BF0A60CAC5390E63854B46"))
      return undefined;
  }

  if(!isDefined(level.interaction_hintstrings[var_0.script_noteworthy]))
    return "_encstr_B40101";

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

wait_for_interaction_triggered(var_0) {
  if(isDefined(level.wait_for_interaction_func))
    self thread[[level.wait_for_interaction_func]](var_0);
}

play_weapon_purchase_vo(var_0, var_1) {
  var_2 = var_0.script_noteworthy;
  var_3 = getweaponbasename(var_2);

  switch (var_3) {
    default:
      break;
  }
}

can_purchase_ammo(var_0) {
  var_1 = self getweaponslistall();
  var_2 = undefined;
  var_3 = undefined;
  var_4 = scripts\cp\utility::getrawbaseweaponname(var_0);

  foreach(var_6 in var_1) {
    var_3 = scripts\cp\utility::getrawbaseweaponname(var_6);

    if(var_3 == var_4) {
      var_2 = var_6;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_8 = self getweaponammostock(var_2);
    var_9 = weaponmaxammo(var_2);
    var_10 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var_11 = int(var_10 * var_9);

    if(var_8 < var_11)
      return 1;
    else if(weaponmaxammo(var_2) == weaponclipsize(var_2) && self getweaponammoclip(var_2) < weaponclipsize(var_2))
      return 1;
    else
      return 0;
  }

  return 1;
}

interaction_post_activate_delay(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(interaction_is_button_mash(var_0)) {
    return;
  }
  if(interaction_is_door_buy(var_0)) {
    return;
  }
  if(interaction_is_atm(var_0)) {
    return;
  }
  if(interaction_is_chess_piece(var_0)) {
    return;
  }
  scripts\cp\utility::allow_player_interactions(0);
  wait 1.5;

  if(!scripts\cp\utility::areinteractionsenabled())
    scripts\cp\utility::allow_player_interactions(1);
}

delayed_trigger_unset() {
  wait 0.25;
  self.triggered = undefined;
}

addtointeractionslistbynoteworthy(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1)
  add_to_current_interaction_list(var_3);
}

removefrominteractionslistbynoteworthy(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1)
  remove_from_current_interaction_list(var_3);
}

remove_from_current_interaction_list(var_0) {
  var_0 notify("_encstr_86C12526DF102A0C2FE94D1BC799EFCB9BA032ADFB64BF73602C45485FFE98B397B8D1FCB0D0AB");
  var_0.in_array = 0;

  if(scripts\engine\utility::array_contains(level.current_interaction_structs, var_0))
    level.current_interaction_structs = scripts\engine\utility::array_remove(level.current_interaction_structs, var_0);

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

add_to_current_interaction_list(var_0) {
  var_0 notify("_encstr_8B2120C167F2D6DBC07E97D0A3C89B369BD1E04879055A88632B39B87AB7BD6AA35B");
  var_0.in_array = 1;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0))
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, var_0);

  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

remove_from_current_interaction_list_for_player(var_0, var_1) {
  var_0 notify("_encstr_A28C3193CA5BBDD9B2FA33C9BDDAAFB157C9E4B2B9A3EBA5DC47599CC28DD14B7B73D7B1D29B1DFACCF6E4BE83D816CB59C9FA" + var_1.name);

  if(!scripts\engine\utility::array_contains(var_1.disabled_interactions, var_0))
    var_1.disabled_interactions = scripts\engine\utility::array_add(var_1.disabled_interactions, var_0);

  scripts\cp\coop_personal_ents::update_special_mode_for_player(var_1);
}

add_to_current_interaction_list_for_player(var_0, var_1) {
  var_0 notify("_encstr_81422C218F49E1F005CEEFB70AEBE13A9B713BD0A382828F378579273ABF09EB63F1118E9A2BF11080C7C2BFEAD0" + var_1.name);

  if(scripts\engine\utility::array_contains(var_1.disabled_interactions, var_0))
    var_1.disabled_interactions = scripts\engine\utility::array_remove(var_1.disabled_interactions, var_0);

  scripts\cp\coop_personal_ents::update_special_mode_for_player(var_1);
}

can_purchase_interaction(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0))
    return 0;

  if(scripts\cp\utility::isnmlactive())
    return 1;

  if(isDefined(var_0.script_location) && var_0.script_location == "_encstr_8E190AB1FC435F5A19F0D2FA")
    return 1;

  if(isDefined(var_1))
    var_4 = var_1;
  else
    var_4 = level.interactions[var_0.script_noteworthy].cost;

  if(interaction_is_weapon_buy(var_0)) {
    var_5 = var_0.script_noteworthy;

    if(var_0.script_parameters == "_encstr_AD0D0879F956D035534B") {
      if(self hasweapon(var_5))
        return 0;

      self.itempicked = var_0.script_noteworthy;
      level.transactionid = randomint(100);
    }

    var_6 = weaponmaxammo(var_0.script_noteworthy);
    var_7 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var_8 = int(var_7 * var_6);
    var_9 = self getweaponammostock(var_5);

    if(var_9 >= var_8)
      return 0;
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_4, var_2))
    return 1;

  return 0;
}

trial_headicon_origin() {
  if(isDefined(self.script_noteworthy) && isDefined(level.interactions[self.script_noteworthy]) && isDefined(level.interactions[self.script_noteworthy].cost))
    return level.interactions[self.script_noteworthy].cost;
  else
    return 0;
}

take_player_money(var_0, var_1) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }
  scripts\cp\cp_persistence::take_player_currency(var_0, 1, var_1);
}

should_interaction_fill_consumable_meter(var_0) {
  if(!isDefined(var_0)) {}

  switch (var_0) {
    case "_encstr_88A6139BB7E3CC576B0E719E697F0A97A883F406B7":
    case "_encstr_AC9A102A7B4018BDA0E56029F28E5F5D6380":
    case "_encstr_961904BF13DA":
      return 0;
    default:
      return 1;
  }
}

getammopurchasestring(var_0, var_1) {
  var_2 = level.interactions[var_0.script_noteworthy].cost;
  var_3 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
  var_4 = var_1 getcurrentweapon();
  var_5 = weaponmaxammo(var_4);
  var_6 = var_1 scripts\cp\perks\cp_prestige::prestige_getminammo();
  var_7 = int(var_6 * var_5);
  var_8 = var_1 getweaponammostock(var_4);
  var_9 = self getweaponslistall();

  foreach(var_11 in var_9) {
    var_12 = scripts\cp\utility::getrawbaseweaponname(var_11);

    if(var_12 == scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy)) {
      var_13 = var_11;
      var_8 = self getweaponammostock(var_13);
      var_5 = weaponmaxammo(var_13);
      var_7 = int(var_6 * var_5);
    }
  }

  if(var_0.script_parameters == "_encstr_AD0D0879F956D035534B")
    return level.interaction_hintstrings[var_0.script_noteworthy];

  switch (var_2) {
    case 250:
      return &"_encstr_A3A421D00A7DD2A6127D2939152A2514861525A7C9A979A892869651A2D47DA0A6533D";
    case 1500:
    case 1250:
    case 1000:
    case 500:
      return &"_encstr_9B6D20D0A7F40AF5A4E4512A49A08645A4F4C935E5285525862105A6517D14D435E9";
    default:
      return &"_encstr_9B6D20D0A7F40AF5A4E4512A49A08645A4F4C935E5285525862105A6517D14D435E9";
  }
}

default_weapon_hint_func(var_0, var_1) {
  if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy))
    return getammopurchasestring(var_0, var_1);

  return undefined;
}

interaction_sound_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_81010C2D9BE8B29C0B8D1D2DED37", var_0, var_1, var_2);

    switch (var_0) {
      case "_encstr_ABDD094B1109F39158BB21":
        if(isDefined(var_2.purchasing_ammo)) {
          if(soundexists("_encstr_97DF0E0EAB9CC643586ECAF5C2D6B5BD"))
            var_2 scripts\cp\utility::playlocalsound_safe("_encstr_97DF0E0EAB9CC643586ECAF5C2D6B5BD");
        } else if(soundexists("_encstr_9B65109803783653479352F9FBADAF2A388D"))
          var_2 scripts\cp\utility::playlocalsound_safe("_encstr_9B65109803783653479352F9FBADAF2A388D");

        break;
      case "_encstr_A36F09E0AEE4C634B06EB2":
        var_3 = get_interaction_sound(var_1, var_2);

        if(isDefined(var_3) && soundexists(var_3))
          var_2 scripts\cp\utility::playlocalsound_safe(var_3);

        break;
      case "_encstr_82011013D3A0A7DBC123AD58912708537DF9":
        var_2 scripts\cp\utility::playlocalsound_safe("_encstr_B6C20E52F5B5623071F8FF0F5829FE0B");
        break;
    }
  }
}

get_interaction_sound(var_0, var_1) {
  var_2 = [];

  switch (var_0.script_noteworthy) {
    case "_encstr_BDA90E36D7BA63CBE507C820DB3CA0AF":
      return undefined;
    case "_encstr_8BF90F08C8309309F9B85B07F270807D78":
      var_2 = ["_encstr_933018BA90C65351804DFCFF65C8E373E50EF3535B969B16F8B3"];
      break;
    case "_encstr_84F70FE04391813F6205E17D11FB5589E8":
    case "_encstr_B4570A0E100E4F3D82C16ACB":
    case "_encstr_AF8C1A58ED0C50469207794B1F4A18E0B9028110964150711BBB4B41":
    case "_encstr_B64E098E39D6221096C8B0":
    case "_encstr_B43A0B93DEB16D59D1D1932C1C":
      var_2 = ["_encstr_A78F1C8EC92C83D736DBCD47C9F6C67D0E58B959D8D707AE9336A12C6EAC"];
      break;
    case "_encstr_87E80D37D84B915A37CEBEC8DEF69C":
    case "_encstr_96ED07232B899CB4DC":
      var_2 = ["_encstr_85C20E5B039BFE081E33F38F4CC5683E"];
      break;
    case "_encstr_8D8F11C077299F314A759F98B6A70371E33E39":
      var_2 = ["_encstr_85C20E5B039BFE081E33F38F4CC5683E"];
      break;
    case "_encstr_939C0C1F586D607F5BA8BFE32D93":
      var_2 = ["_encstr_939C0C1F586D607F5BA8BFE32D93"];
      break;
    case "_encstr_91E90FB08EDA7D772D8E4319E42CBB58D8":
      var_2 = ["_encstr_91E90FB08EDA7D772D8E4319E42CBB58D8"];
      break;
    case "_encstr_813D0DBD3D4A58FB83B150994B8720":
    case "_encstr_970D10673FD3BCA0FECCD34EB2D1D87A8B2B":
    case "_encstr_A2760E5BB29D2DB9EB98163A1DB29CCB":
    case "_encstr_882E0B5B599DA5DCD7A1B22C19":
      var_2 = ["_encstr_8E68108350396FCF6B7875BF3AEBBB544580"];
      break;
    case "_encstr_8D0814AD95912DAED6BE3AB41BADAC3AFA079C969EB2":
    case "_encstr_AB4F136E5B0B1B63BEE89636DA951DBE0EE4A5E92B":
    case "_encstr_A3CC269F80DB1F2297768F0754952AEDDA88CF2BB8809EFAC58417FF4653E2AA410B9B9B58A0C282":
    case "_encstr_8AFE12BA923B5DC078856737ADE510157B79D063":
      var_2 = ["_encstr_9A2A10E34805067BF976AD9F8D802F4C43D8"];
      break;
    case "_encstr_A1D313D8C24ECEACAF3A2D36AD561DEB0793963D59":
      var_2 = ["_encstr_8D1B0D2CC9ADD738BAC9C643C2DCAC"];
      break;
    case "_encstr_8F6F12C2C9D6FAE2AE95CDD17DE6E8B08E5ABD37":
      var_2 = ["_encstr_AD380CDA837AAFCB700586AF2B70"];
      break;
    default:
      var_2 = ["_encstr_AD380CDA837AAFCB700586AF2B70"];
      break;
  }

  if(!var_2.size)
    return undefined;

  return scripts\engine\utility::random(var_2);
}

interaction_post_activate_update(var_0) {
  if(!isDefined(var_0.post_activate_update)) {
    return;
  }
  if(isDefined(level.interaction_post_activate_update_func)) {
    level thread[[level.interaction_post_activate_update_func]](var_0, self);
    return;
  }
}

interaction_is_trap(var_0) {
  return var_0.script_noteworthy == "_encstr_96F50EADEA1F931FFF6A98A083520B89" || var_0.script_noteworthy == "_encstr_ACCE10A3931638EB99B44E56260B93C9CAC6";
}

interaction_is_atm(var_0) {
  return var_0.script_noteworthy == "_encstr_91E90FB08EDA7D772D8E4319E42CBB58D8" || var_0.script_noteworthy == "_encstr_939C0C1F586D607F5BA8BFE32D93";
}

interaction_is_window_entrance(var_0) {
  return var_0.script_noteworthy == "_encstr_BDA90E36D7BA63CBE507C820DB3CA0AF";
}

interaction_is_crafting_station(var_0) {
  return var_0.script_noteworthy == "_encstr_A7D9114F250FDACCF8607F49FB28E133D387F3";
}

interaction_is_grenade_wall_buy(var_0) {
  return var_0.script_noteworthy == "_encstr_A1300F4F28DBC5DB17128FE017A7BC222D" || var_0.script_noteworthy == "_encstr_8D7C09102FE7216D71A66D";
}

interaction_is_pvpve_weapon_pickup(var_0) {
  return var_0.script_noteworthy == "_encstr_8F8E14C18C8BFB9FF7CF3BC19B8D0EC7530A5AAF3568";
}

interaction_is_weapon_pickup(var_0) {
  return var_0.script_noteworthy == "_encstr_97240D972BE8FA57D8FF6A3260ADE3";
}

interaction_is_fortune_teller(var_0) {
  return var_0.script_noteworthy == "_encstr_B8A9117D2F8B1828D4E60B268D81F0C392ABEB";
}

interaction_is_perk(var_0) {
  return isDefined(var_0.perk_type);
}

interaction_waiting_on_power(var_0) {
  return istrue(var_0.requires_power) && !var_0.powered_on;
}

interaction_is_valid(var_0, var_1) {
  if(var_1 isinphase())
    return 0;

  if(isDefined(var_0.triggered))
    return 0;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0))
    return 0;

  if(istrue(var_0.out_of_order)) {
    level notify("_encstr_B43128ABC86BF837D338F1EBCED9A7829B60C1B260E9B713E91EECE9D0804FCD25218A6A7B812FAF03F0", var_1);
    return 0;
  }

  if(istrue(var_0.in_use))
    return 0;

  if(interaction_waiting_on_power(var_0)) {
    level notify("_encstr_925A273350F370BF6BB07973B6513F3A13E8494AE0556ADFA385526DDD3E1F05694863321809E427B8", var_1);

    if(isDefined(var_0.perk_type) && soundexists("_encstr_8345126A858D380FB8D376D884AEEF3FF00F2849"))
      var_1 playlocalsound("_encstr_8345126A858D380FB8D376D884AEEF3FF00F2849");
    else
      var_1 playlocalsound("_encstr_B6C20E52F5B5623071F8FF0F5829FE0B");

    return 0;
  }

  if(isDefined(var_0.cooling_down)) {
    level notify("_encstr_B43128ABC86BF837D338F1EBCED9A7829B60C1B260E9B713E91EECE9D0804FCD25218A6A7B812FAF03F0", var_1);
    return 0;
  }

  if(scripts\engine\utility::array_contains(var_1.disabled_interactions, var_0))
    return 0;

  return 1;
}

trial_hitmarker(var_0) {
  return var_0.script_noteworthy == "_encstr_BA6115EB25BB47D755982A8120BD4BDF739F43644BED63";
}

trial_is_event(var_0) {
  return var_0.script_noteworthy == "_encstr_A3570BBE6DCFE6D54B5B8050D2";
}

interaction_is_chess_piece(var_0) {
  return var_0.script_noteworthy == "_encstr_BE6D166C342BE637FA07D2CA1B56FADCAC369536E82DDBDC" || var_0.script_noteworthy == "_encstr_AF261620BA67A72B3720ED6212C3D137CE623080C27E3383" || var_0.script_noteworthy == "_encstr_A730148843631FBB8F2B0B2AD54C2799E5B3EA6E60BA";
}

interaction_is_weapon_upgrade(var_0) {
  return var_0.script_noteworthy == "_encstr_B2830FBB95C207BD377DAE0ED939B04659";
}

interaction_is_weapon_buy(var_0) {
  if(isDefined(var_0.name))
    return var_0.name == "_encstr_ABDD094B1109F39158BB21";
  else
    return 0;
}

interaction_is_button_mash(var_0) {
  return isDefined(var_0.isbuttonmash) && var_0.isbuttonmash;
}

interaction_is_door_buy(var_0) {
  return var_0.script_noteworthy == "_encstr_9A980B436BDE528332601B5342" || var_0.script_noteworthy == "_encstr_A3980BD1CFC6F2D0FB11FAA372" || var_0.script_noteworthy == "_encstr_A5BD0CD70D63F2CC23F799F3B1D1" || var_0.script_noteworthy == "_encstr_92BD0CF88A4605C827AF6FE63DD2" || var_0.script_noteworthy == "_encstr_BABD0CC89598932D37FA4CD41881" || var_0.script_noteworthy == "_encstr_B2B40C40DA26921C238E6F3A525A" || var_0.script_noteworthy == "_encstr_97C3121FFE4E66778B8AE838C3E63B3E739F4836" || var_0.script_noteworthy == "_encstr_8BF30E67C013B9FF6AEB2C0F75D08FBA" || var_0.script_noteworthy == "_encstr_8D8F11C077299F314A759F98B6A70371E33E39" || var_0.script_noteworthy == "_encstr_A6A70A8EB20B6BBE237BED27";
}

interaction_is_special_door_buy(var_0) {
  return var_0.script_noteworthy == "_encstr_AF8E137BAD0F5046711B4F476B590EA0B9C7C030D7" || var_0.script_noteworthy == "_encstr_8D8F11C077299F314A759F98B6A70371E33E39" || var_0.script_noteworthy == "_encstr_97C3121FFE4E66778B8AE838C3E63B3E739F4836" || var_0.script_noteworthy == "_encstr_8BF30E67C013B9FF6AEB2C0F75D08FBA" || var_0.script_noteworthy == "_encstr_A6A70A8EB20B6BBE237BED27";
}

interaction_is_chi_door(var_0) {
  return var_0.script_noteworthy == "_encstr_9276062250C3D9CA" || var_0.script_noteworthy == "_encstr_BE7606A670302767" || var_0.script_noteworthy == "_encstr_BD7606AB1980191A";
}

interaction_is_ticket_buy(var_0) {
  return var_0.script_noteworthy == "_encstr_AB4F136E5B0B1B63BEE89636DA951DBE0EE4A5E92B" || var_0.script_noteworthy == "_encstr_8D0814AD95912DAED6BE3AB41BADAC3AFA079C969EB2" || var_0.script_noteworthy == "_encstr_A5E21797BA12E3917D6F10782F9E6B13EB691CA6D79AABD925" || var_0.script_noteworthy == "_encstr_B19B14D81BB3E10192690618FB7A79290A1750208F47" || var_0.script_noteworthy == "_encstr_A1D313D8C24ECEACAF3A2D36AD561DEB0793963D59" || var_0.script_noteworthy == "_encstr_8AFE12BA923B5DC078856737ADE510157B79D063" || var_0.script_noteworthy == "_encstr_A3CC269F80DB1F2297768F0754952AEDDA88CF2BB8809EFAC58417FF4653E2AA410B9B9B58A0C282" || var_0.script_noteworthy == "_encstr_AB140BB3EDC6197D3ACACA3AA1";
}

can_use_perk(var_0) {
  if(scripts\cp\utility::has_zombie_perk(var_0.perk_type))
    return 0;
  else if(self.self_revives_purchased >= self.max_self_revive_machine_use && var_0.perk_type == "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863")
    return 0;
  else if(isDefined(self.zombies_perks) && self.zombies_perks.size > 4)
    return 0;

  return 1;
}

interaction_show_fail_reason(var_0, var_1, var_2, var_3) {
  thread interaction_fail_internal(var_0, var_1, var_2, var_3);
}

interaction_fail_internal(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level notify("_encstr_81010C2D9BE8B29C0B8D1D2DED37", "_encstr_82011013D3A0A7DBC123AD58912708537DF9", level.interactions[var_0.script_noteworthy], self);
  self.delay_hint = 1;
  self.interaction_trigger setHintString(var_1);
  wait 1;
  self.delay_hint = undefined;
  set_interaction_trigger_properties(self.interaction_trigger, var_0);
}

interaction_cooldown(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0.script_noteworthy, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4 in var_2) {
    if(var_4.target == var_0.target)
      var_4.cooling_down = 1;
  }

  if(istrue(level.cooldown_override))
    wait 1;
  else
    level scripts\engine\utility::_id_143B9(var_1, "_encstr_8AC613179550E24B3301C269C91807DDF03F876EF7");

  foreach(var_4 in var_2) {
    if(var_4.target == var_0.target)
      var_4.cooling_down = undefined;
  }

  var_8 = 5184;

  foreach(var_10 in level.players) {
    foreach(var_4 in var_2) {
      if(distancesquared(var_10.origin, var_4.origin) >= var_8) {
        continue;
      }
      var_10 refresh_interaction();
    }
  }
}

refresh_interaction() {
  self notify("_encstr_A3F4170B23DF67A10C3EA18B4A76382DAF0A20360A0714D8A6");
  self.last_interaction_point = undefined;

  if(isDefined(self.interaction_trigger))
    self.interaction_trigger setHintString("_encstr_B40101");
}

disable_wall_buy_interactions() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_81010C2D9BE8B29C0B8D1D2DED37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(interaction_is_weapon_buy(var_2) || interaction_is_grenade_wall_buy(var_2) || interaction_is_ticket_buy(var_2) || isDefined(var_2.script_parameters) && var_2.script_parameters == "_encstr_AD0D0879F956D035534B") {
      var_2.disabled = 1;
      continue;
    }
  }
}

spawninteractionmodel(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(isDefined(var_0.script_modelname)) {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);

    if(isDefined(var_1.angles))
      var_2.angles = var_1.angles;

    var_2 setModel(var_0.script_modelname);

    if(isDefined(var_0.targetmodels))
      var_0.targetmodels[var_0.targetmodels.size] = var_2;
  }
}

move_to_closest_interaction(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = -1;
  var_4 = 0;
  var_5 = squared(75);

  for(;;) {
    if(istrue(var_0.inlaststand) || istrue(var_0.siege_activated) || istrue(var_0.flung)) {
      var_1 = undefined;
      update_struct_information(var_0, -1, undefined, undefined);
    } else if(!var_0 scripts\cp\utility::areinteractionsenabled()) {
      var_1 = undefined;
      update_struct_information(var_0, -1, undefined, undefined);
    } else {
      var_6 = [];
      level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
      var_7 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.current_interaction_structs, undefined, 10, 750, 1);

      foreach(var_9 in var_0.disabled_interactions)
      var_7 = scripts\engine\utility::array_remove(var_7, var_9);

      foreach(var_9 in var_7) {
        if(is_permitted_guided_interaction(var_0, var_9, var_1))
          var_6[var_6.size] = var_9;
      }

      if(istrue(var_0.resetguidedinteraction)) {
        var_1 = undefined;
        update_struct_information(var_0, -1, undefined, undefined);
        var_0.resetguidedinteraction = undefined;
        wait 0.05;
        continue;
      }

      var_6 = scripts\engine\utility::array_removeundefined(var_6);
      var_6 = scripts\engine\utility::array_remove_duplicates(var_6);

      if(var_6.size < 1) {
        var_1 = undefined;
        update_struct_information(var_0, -1, undefined, undefined);
        wait 0.05;
        continue;
      }

      var_6 = sortbydistance(var_6, var_0.origin);

      foreach(var_14 in var_6) {
        var_4 = 0;

        if(var_0 adsButtonPressed()) {
          update_struct_information(var_0, -1, undefined, undefined);
          var_1 = undefined;

          while(var_0 adsButtonPressed())
            wait 0.05;
        }

        if(distancesquared(var_0.origin, var_14.origin) <= var_5) {
          update_struct_information(var_0, -1, undefined, undefined);
          var_1 = undefined;
          continue;
        } else if(isDefined(var_1) && var_14 == var_1) {
          break;
        } else {
          var_2 = get_interaction_origin(var_14, var_0);
          var_3 = get_interaction_cost(var_14, var_0);
          var_1 = var_14;
          var_4 = 1;
          break;
        }
      }

      if(var_4)
        update_struct_information(var_0, var_3, var_2, var_1);
    }

    wait 0.1;
  }
}

get_interaction_origin(var_0, var_1) {
  var_2 = (0, 0, 68);
  var_3 = var_0.origin;

  if(interaction_is_weapon_buy(var_0)) {
    if(isDefined(var_0.target)) {
      var_4 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(isDefined(var_4))
        var_3 = var_4.origin;
      else
        var_3 = var_0.origin;
    }
  } else if(!isDefined(var_3))
    var_3 = var_0.origin;

  if(isDefined(level.guided_interaction_offset_func))
    var_2 = [[level.guided_interaction_offset_func]](var_0, var_1);
  else {
    var_5 = get_area_for_power(var_0);

    if(isDefined(var_0.script_noteworthy)) {
      var_6 = var_0.script_noteworthy;

      switch (var_6) {
        case "_encstr_84920FF2D80F8993787738250EC6CB4DED":
        case "_encstr_A22F1DD2BBE6F5932D8383AC93AF3DAD5693D2380759E4CD6CDE0E56D74FDA":
        case "_encstr_BE5F116E381575631CC5D2B76F28F962C5C373":
          var_2 = (0, 0, 12);
          break;
        case "_encstr_AADD0CD7736FE98114B7E6DA6010":
        case "_encstr_ACB50BE2A31A59F9E89911F32A":
          if(var_5 == "_encstr_AA4A0C7344D14FEA4F70A3CAE803")
            var_2 = (0, 0, 12);

          break;
        case "_encstr_8AFE12BA923B5DC078856737ADE510157B79D063":
          var_2 = (0, 0, 20);
          break;
        case "_encstr_9BE60ECAE037819FA070295B806AAF92":
        case "_encstr_8E1D0DB9742BB71A1FC8229A596DD5":
          if(var_5 == "_encstr_88A2051DB7E7C6")
            var_2 = (0, 0, 30);
          else
            var_2 = (0, 0, 56);

          break;
        default:
          var_2 = (0, 0, 56);
      }
    }
  }

  var_7 = scripts\engine\utility::drop_to_ground(var_3, 12) + var_2;
  return var_7;
}

get_interaction_cost(var_0, var_1) {
  var_2 = 1;
  var_3 = 0;

  if(isDefined(level.interactions[var_0.script_noteworthy])) {
    if(isDefined(level.interactions[var_0.script_noteworthy].cost))
      var_3 = int(level.interactions[var_0.script_noteworthy].cost);
    else
      return 0;
  }

  if(interaction_is_weapon_buy(var_0)) {
    if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
      var_4 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
      var_5 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_4);

      if(var_5 > 1)
        var_3 = 4500;
      else {
        var_2 = 0.5;
        var_3 = int(var_3 * var_2);
      }
    } else
      var_3 = int(var_3 * var_2);
  } else if(interaction_is_weapon_upgrade(var_0)) {
    var_6 = var_1 getcurrentweapon();

    if(var_1 scripts\cp\cp_weapon::can_upgrade(var_6)) {
      var_5 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_6);
      var_3 = scripts\engine\utility::ter_op(var_5 > 1, 10000, 5000);
    } else
      var_3 = 0;

    if(istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses))
      var_3 = 0;
  } else if(is_struct_perk_machine(var_0)) {
    if(isDefined(var_0.script_noteworthy) && !var_1 can_use_perk(var_0))
      var_3 = 0;
    else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863")
      var_3 = 500;
    else
      var_3 = get_perk_machine_cost(var_0);
  } else if(interaction_is_fortune_teller(var_0)) {
    if(var_1.card_refills == 1)
      var_3 = level.fortune_visit_cost_2;
    else
      var_3 = level.fortune_visit_cost_1;
  }

  if(var_1 scripts\cp\utility::is_consumable_active("_encstr_96CD13B92B3C1DFAC1D527B186C2DC2BF599279559"))
    var_3 = 0;

  return var_3;
}

is_struct_perk_machine(var_0) {
  if(!isDefined(var_0.script_noteworthy))
    return 0;

  if(var_0.script_noteworthy == "_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB" || var_0.script_noteworthy == "_encstr_B6E3170395B6D0F759E7237BFBA649C93D4AFC0F818925B1C5" || var_0.script_noteworthy == "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863" || var_0.script_noteworthy == "_encstr_848D1118A3F8B40FC151B20AB8A83F61503B8E" || var_0.script_noteworthy == "_encstr_841E1338B24EDABEB516D8862D9B59FA37D6168DB6" || var_0.script_noteworthy == "_encstr_AB671357374BBF8E0DDF4808E756819F53DD4D54CC" || var_0.script_noteworthy == "_encstr_81991360BD43A7D1DBF0C26AA80597BF7991F9FB43" || var_0.script_noteworthy == "_encstr_A33812C9223BBF07CD018FA88C2BC9F7F098158F" || var_0.script_noteworthy == "_encstr_AD721437572BDFEE6D7FE8A847B6617FD27B2030AAE2" || var_0.script_noteworthy == "_encstr_AB10151CB2E45BF5B52CB10D2D73ACBE322B2C91CABCCA" || var_0.script_noteworthy == "_encstr_92D61479FD0AC8203F921178FADBE5B1E658E3CD67B7" || var_0.script_noteworthy == "_encstr_878D112B23DE52BFB0F916DC90C0CD69B243B3")
    return 1;

  return 0;
}

get_perk_machine_cost(var_0) {
  switch (var_0.perk_type) {
    case "_encstr_878D112B23DE52BFB0F916DC90C0CD69B243B3":
    case "_encstr_92D61479FD0AC8203F921178FADBE5B1E658E3CD67B7":
    case "_encstr_AB10151CB2E45BF5B52CB10D2D73ACBE322B2C91CABCCA":
    case "_encstr_AD721437572BDFEE6D7FE8A847B6617FD27B2030AAE2":
    case "_encstr_A33812C9223BBF07CD018FA88C2BC9F7F098158F":
    case "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863":
      return 1500;
    case "_encstr_81991360BD43A7D1DBF0C26AA80597BF7991F9FB43":
      return 3000;
    case "_encstr_AB671357374BBF8E0DDF4808E756819F53DD4D54CC":
      return 2500;
    case "_encstr_841E1338B24EDABEB516D8862D9B59FA37D6168DB6":
    case "_encstr_848D1118A3F8B40FC151B20AB8A83F61503B8E":
    case "_encstr_B6E3170395B6D0F759E7237BFBA649C93D4AFC0F818925B1C5":
    case "_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB":
      return 2000;
  }
}

is_permitted_guided_interaction(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_1))
    return 0;

  var_3 = undefined;

  if(isDefined(var_1.script_noteworthy))
    var_3 = var_1.script_noteworthy;
  else
    return 0;

  if(istrue(var_1.out_of_order) || isDefined(var_1.cooling_down))
    return 0;

  if(istrue(var_1.disabledguidedinteractions))
    return 0;

  if(isDefined(var_1.perk_type) && var_1.perk_type == "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863" && var_0.self_revives_purchased >= var_0.max_self_revive_machine_use)
    return 0;

  if(!scripts\cp\utility::coop_mode_has("_encstr_92BF0A60CAC5390E63854B46")) {
    if(interaction_is_weapon_buy(var_1) || interaction_is_grenade_wall_buy(var_1) || interaction_is_ticket_buy(var_1) || interaction_is_chi_door(var_1) || isDefined(var_1.script_parameters) && var_1.script_parameters == "_encstr_AD0D0879F956D035534B")
      return 0;
  }

  if(interaction_is_fortune_teller(var_1)) {
    if(var_0.card_refills == 2)
      return 0;
  }

  if(var_3 == "_encstr_BDA90E36D7BA63CBE507C820DB3CA0AF" || var_3 == "_encstr_99E90A0CE8AC6B029F212E5A" || var_3 == "_encstr_86AA0CDDF639FA6E3AC2B9C82BAC" || var_3 == "_encstr_BD740AAF03B8971B675312CB" || var_3 == "_encstr_BAF2148DAC9B1D5939BE6E07562C6DAC4EF536B76CDC" || var_3 == "_encstr_96A30F82085D23F3B0477378DB10FCA706" || var_3 == "_encstr_8F6F12C2C9D6FAE2AE95CDD17DE6E8B08E5ABD37" || var_3 == "_encstr_99B5105CEDC16297F52313A96BDFB39B69C3" || var_3 == "_encstr_ABB510DDF3B7070B7707FB812B21E3D0B912" || var_3 == "_encstr_A7B5108A8060178BF0079CAF190892CB8853" || var_3 == "_encstr_AA7B0EC565AFEF57578ACB88D11812CB" || var_3 == "_encstr_85201182907FE26F1916DCFF2E83172EBF706B" || var_3 == "_encstr_8BF90F08C8309309F9B85B07F270807D78" || var_3 == "_encstr_91970C25893A40700BF3E10BEA03" || var_3 == "_encstr_A2B7106C4E0B991D96739DFA38D21BB5D51C" || var_3 == "_encstr_82F20CF33FD9B95323E72B6168F1" || var_3 == "_encstr_A6A70A8EB20B6BBE237BED27" || var_3 == "_encstr_8DAD0A8D798201906B6D0752" || var_3 == "_encstr_8FA50D6D27228141A29E435B879A38" || var_3 == "_encstr_8E5C0C37CA2D637D932B83C25A93" || var_3 == "_encstr_857B0EDB48480499BDC3E2DD345B83D5" || var_3 == "_encstr_A255135617AEAB374B2A2B4BD7A25256CC7050ED2B" || var_3 == "_encstr_B1E70C19B2B5B7E6EBEC9CDEAB07" || var_3 == "_encstr_8E7711E8332E9DD007FBB525D2D75925158B68" || var_3 == "_encstr_BAED10448A4753E1D13A6880F274FF699B03" || var_3 == "_encstr_B82D0E0C224A53BBEF6BE8380BE9F0A9" || var_3 == "_encstr_BE7110EC397BEA07FA27D2EC2B2793582D32" || var_3 == "_encstr_BDCA14D672FAA1C9122758D8CF59A1EBE1DFCE508BC3" || var_3 == "_encstr_8B4310EB20FE6FCB7823869B473892A79D3B" || var_3 == "_encstr_AC1316DF7B18650B6843828A6BDB871A70E353258B48ED5B" || var_3 == "_encstr_91E90FB08EDA7D772D8E4319E42CBB58D8" && isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000 || var_3 == "_encstr_A7D9114F250FDACCF8607F49FB28E133D387F3" && !isDefined(var_0.current_crafting_struct))
    return 0;

  if(isDefined(level.guidedinteractionexclusion)) {
    if(![[level.guidedinteractionexclusion]](var_1, var_0, var_3))
      return 0;
  }

  if(istrue(var_1.requires_power) && !istrue(var_1.powered_on))
    return 0;

  if(isDefined(level.active_volume_check)) {
    if(var_3 == "_encstr_82F20CF33FD9B95323E72B6168F1" || var_3 == "_encstr_B2830FBB95C207BD377DAE0ED939B04659")
      return 1;
    else if(!self[[level.active_volume_check]](var_1.origin))
      return 0;
  }

  var_4 = var_1.origin;

  if(isDefined(level.guidedinteractionendposoverride))
    var_4 = [[level.guidedinteractionendposoverride]](var_0, var_1);

  if(!scripts\engine\utility::within_fov(var_0.origin, var_0.angles, var_4, cos(25)))
    return 0;

  if(interaction_is_door_buy(var_1) || interaction_is_chi_door(var_1)) {
    var_5 = get_spawn_volumes_player_is_in(0, undefined, var_0);

    foreach(var_7 in var_5) {
      var_8 = var_7 get_adjacent_volumes_from_volume();

      foreach(var_10 in var_8) {
        if(ispointinvolume(var_1.origin, var_10))
          return 0;
      }
    }
  }

  var_13 = physics_createcontents(["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4"]);

  if(var_1.script_noteworthy == "_encstr_A3010D4163BA9749D0E049838E8E48")
    var_4 = var_1.origin + (0, 0, 50);

  if(scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_4, [var_0], var_13))
    return 1;
  else
    return 0;
}

update_struct_information(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = -1;

  if(isDefined(var_2) && var_2 != self.origin) {
    wait 0.1;
    self dontinterpolate();
    self.origin = var_2;
    wait 0.1;
  }

  if(isDefined(var_3) && var_3.script_parameters == "_encstr_AD0D0879F956D035534B")
    var_1 = 2;
}

get_spawn_volumes_player_is_in(var_0, var_1, var_2) {
  if(isDefined(level.get_spawn_volume_func))
    return [[level.get_spawn_volume_func]]();

  var_3 = [];
  var_4 = level.spawn_volume_array;

  foreach(var_6 in var_4) {
    if(!var_6.active) {
      continue;
    }
    var_7 = 0;

    if(isDefined(var_1) && !var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(var_2 istouching(var_6))
      var_7 = 1;
    else if(istrue(var_0) && var_2 is_in_adjacent_volume(var_6))
      var_7 = 1;

    if(var_7)
      var_3[var_3.size] = var_6;
  }

  return var_3;
}