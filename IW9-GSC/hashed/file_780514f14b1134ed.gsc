/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_780514f14b1134ed.gsc
***********************************************/

_id_957D3897064478FF() {
  if(getdvarint("dvar_34E612D2826005B8", 0))
    level._id_CAE12707E51C9673 = 1;

  level.interaction_trigger_properties_func = ::_id_B0AA58B1601B13CD;
  _id_26A7947DDFDFA1D4();
}

_id_26A7947DDFDFA1D4() {
  level._id_DD1B9D6AEC9585D7 = [];
  _id_CB89110314447B2F = 1;

  if(isDefined(level._id_DE59FBA05067A924))
    table = level._id_DE59FBA05067A924;
  else
    table = "cp/incursion_interaction_cards.csv";

  for(;;) {
    id = tablelookupbyrow(table, _id_CB89110314447B2F, 1);

    if(id == "") {
      break;
    }

    omnvar = int(tablelookupbyrow(table, _id_CB89110314447B2F, 0));
    ref = tablelookupbyrow(table, _id_CB89110314447B2F, 1);
    name = tablelookupbyrow(table, _id_CB89110314447B2F, 2);
    _id_815D41728A6F1F3C = tablelookupbyrow(table, _id_CB89110314447B2F, 3);
    icon = tablelookupbyrow(table, _id_CB89110314447B2F, 4);
    type = tablelookupbyrow(table, _id_CB89110314447B2F, 5);
    _id_88884B6777DA9BB1 = tablelookupbyrow(table, _id_CB89110314447B2F, 6);
    scriptable = tablelookupbyrow(table, _id_CB89110314447B2F, 8);
    struct = spawnStruct();
    struct.omnvar = omnvar;
    struct.ref = ref;
    struct.name = name;
    struct._id_815D41728A6F1F3C = _id_815D41728A6F1F3C;
    struct.icon = icon;
    struct.type = type;

    if(scriptable != "")
      struct.scriptable = scriptable;

    if(_id_88884B6777DA9BB1 != "")
      struct._id_88884B6777DA9BB1 = int(_id_88884B6777DA9BB1);
    else
      struct._id_88884B6777DA9BB1 = 0;

    level._id_DD1B9D6AEC9585D7[id] = struct;
    _id_CB89110314447B2F++;
  }

  scripts\engine\utility::flag_set("buy_stations_initialized");
}

_id_2C4DA055F354E414() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("buy_stations_initialized");
  level.interaction_hintstrings["interact_equipmentbuy"] = &"CP_WEAPON_BUY/PURCHASE";
  level.interaction_hintstrings["interact_weaponbuy"] = &"CP_WEAPON_BUY/PURCHASE";
  level.interaction_hintstrings["interact_upgradebuy"] = &"CP_WEAPON_BUY/PURCHASE";
  level.interaction_hintstrings["interact_perkbuy"] = &"CP_WEAPON_BUY/PURCHASE";
  level.interaction_hintstrings["interact_respawnbuy"] = &"CP_WEAPON_BUY/PURCHASE";
  level.interaction_hintstrings["interact_killstreakbuy"] = &"CP_WEAPON_BUY/PURCHASE";
  level.interaction_hintstrings["interact_skiptimerbuy"] = &"CP_WEAPON_BUY/PURCHASE";
  _id_71332A5B74214116::registerinteraction("interact_perkbuy", undefined, ::_id_52810C46CB49DC3C, ::_id_22D4DBFE8C0A69D2);
  _id_71332A5B74214116::registerinteraction("interact_equipmentbuy", undefined, ::_id_52810C46CB49DC3C, ::_id_22D4DBFE8C0A69D2);
  _id_71332A5B74214116::registerinteraction("interact_weaponbuy", undefined, ::_id_52810C46CB49DC3C, ::_id_22D4DBFE8C0A69D2);
  _id_71332A5B74214116::registerinteraction("interact_respawnbuy", undefined, ::_id_52810C46CB49DC3C, ::_id_22D4DBFE8C0A69D2);
  _id_71332A5B74214116::registerinteraction("interact_killstreakbuy", undefined, ::_id_52810C46CB49DC3C, ::_id_22D4DBFE8C0A69D2);
  _id_71332A5B74214116::registerinteraction("interact_upgradebuy", undefined, ::_id_52810C46CB49DC3C, ::_id_22D4DBFE8C0A69D2);
  _id_71332A5B74214116::registerinteraction("interact_skiptimerbuy", ::_id_FCD615FEEF7E2E28, ::_id_52810C46CB49DC3C, ::_id_22D4DBFE8C0A69D2);
}

_id_4D53102050B02DE5(_id_16037153C1704C7E) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_16037153C1704C7E.size; _id_AC0E594AC96AA3A8++)
    _id_16037153C1704C7E[_id_AC0E594AC96AA3A8]._id_9C791A7A7FC6C7B5 = "armor_satchel";

  thread _id_22D4DBFE8C0A69D2(_id_16037153C1704C7E);
}

_id_22D4DBFE8C0A69D2(interactions) {
  foreach(item in interactions) {
    item._id_EAECDF56E917C0A5 = 1;

    if(isDefined(item.disabled) && item.disabled == "true") {
      continue;
    }
    if(isDefined(item.perk)) {
      switch (item.perk) {
        case "perk_pack_double":
          item.cost = _id_BA0EF3640498C7A4("dvar_7C8031276F931C9D", 1000);
          break;
        case "perk_pack_medic":
          item.cost = _id_BA0EF3640498C7A4("dvar_EE1AB6B7EFB0D21A", 1000);
          break;
        case "perk_pack_mule":
          item.cost = _id_BA0EF3640498C7A4("dvar_C92A1E5590157831", 1000);
          break;
        case "perk_pack_buff":
          item.cost = _id_BA0EF3640498C7A4("dvar_CF211C4DAC473CF1", 1000);
          break;
        case "recon_drone":
          item.cost = _id_BA0EF3640498C7A4("dvar_2DCCB50B405FD552", 800);
          break;
        case "perk_pack_speedy":
          item.cost = _id_BA0EF3640498C7A4("dvar_1DA0785590840686", 1000);
          break;
        case "perk_pack_ammo_buff":
          item.cost = _id_BA0EF3640498C7A4("dvar_86854A9B1D965BDE", 2000);
          break;
        case "perk_pack_armor_buff":
          item.cost = _id_BA0EF3640498C7A4("dvar_7126EDA128806E19", 2000);
          break;
      }

      if(isDefined(item.cost)) {} else {}
    } else if(isDefined(item.equipment)) {
      switch (item.equipment) {
        case "self_revive":
          item.cost = _id_BA0EF3640498C7A4("dvar_8385C6A8129C7444", 1500);
          break;
        case "halligan":
          item.cost = _id_BA0EF3640498C7A4("dvar_530E5069B17BE412", 1200);
          break;
        case "gasmask":
          item.cost = _id_BA0EF3640498C7A4("dvar_AEC2601058428AE4", 1200);
          break;
        case "ammo":
          item.cost = _id_BA0EF3640498C7A4("dvar_7544988E0D94455C", 550);
          break;
        case "equip_hb_sensor":
          item.cost = _id_BA0EF3640498C7A4("dvar_427DB7A1C3522827", 750);
          break;
        case "equip_nvgs":
          item.cost = _id_BA0EF3640498C7A4("dvar_2E9F6CE7C7E48348", 750);
          break;
        case "equip_ascender":
          item.cost = _id_BA0EF3640498C7A4("dvar_9F8C34037CB4B65B", 1500);
          break;
        case "c4_inc_breach":
          item.cost = _id_BA0EF3640498C7A4("dvar_0F19FCBF0CCC7487", 750);
          break;
        case "power_c4":
          item.cost = _id_BA0EF3640498C7A4("dvar_101E627A379573CD", 750);
          break;
        case "armor":
          item.cost = _id_BA0EF3640498C7A4("dvar_3E7EA61EA3AF2121", 500);
          break;
        case "power_semtex":
          item.cost = _id_BA0EF3640498C7A4("dvar_D7D940E38CD83A8E", 500);
          break;
        case "power_molotov":
          item.cost = _id_BA0EF3640498C7A4("dvar_64FCB0C3ADDD2B40", 500);
          break;
        case "power_snapshotGrenade":
          item.cost = _id_BA0EF3640498C7A4("dvar_ABF4807E6C181846", 350);
          break;
        case "power_frag":
          item.cost = _id_BA0EF3640498C7A4("dvar_245E95A069B3F89A", 300);
          break;
      }

      if(isDefined(item.cost)) {} else {}
    } else if(isDefined(item.weapon)) {
      switch (item.weapon) {
        case "iw9_me_riotshield_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_450B9B800A7A02AB", 1000);
          break;
        case "iw8_ar_mike4_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_5A900C2F98052DA2", 1000);
          break;
        case "iw8_ar_akilo47_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_C270C8941D472623", 750);
          break;
        case "iw8_sn_alpha50_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_F9ADE60A540A81A9", 750);
          break;
        case "iw8_ar_falima_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_EEF65C92FB670544", 750);
          break;
        case "iw8_lm_kilo121_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_BEFE2A883ECE7A0D", 750);
          break;
        case "iw8_la_rpapa7_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_E89CF3D85D95ED8B", 1000);
          break;
        case "iw8_la_mike32_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_2FE25EAB534B04E3", 1500);
          break;
        case "iw8_sm_uzulu_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_A009279F623BFF39", 750);
          break;
        case "iw8_sm_mpapa7_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_4BD0A5B4731903D8", 750);
          break;
        case "iw8_sn_kilo98_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_873CEF9905DE5B58", 500);
          break;
        case "iw8_knife_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_8AEC55112239F771", 250);
          break;
        case "iw8_sh_romeo870_mp":
          item.cost = _id_BA0EF3640498C7A4("dvar_FBF797FB08EC95AD", 500);
          break;
      }

      if(isDefined(item.cost)) {} else {}

      if(item.weapon == "weapon_upgrade") {
        item.weapon = undefined;
        item.weapon_upgrade = 1;
        item.cost = _id_BA0EF3640498C7A4("dvar_C0D42F4F9CFCD65C", 2000);
      }
    } else if(isDefined(item.respawn)) {
      item.cost = _id_BA0EF3640498C7A4("dvar_C3B99916141BEA7A", 500);
      level._id_93B4908CF59EEA60 = 1;
      level._id_C7B3E3C08938A826 = _id_BA0EF3640498C7A4("dvar_8619BD1BEE300E68", 500);

      if(isDefined(item.cost)) {} else {}
    } else if(isDefined(item._id_F406BE343AB9CC93)) {
      switch (item._id_F406BE343AB9CC93) {
        case "precision_airstrike":
          item.cost = _id_BA0EF3640498C7A4("dvar_615D8307CFE8D21F", 1000);
          break;
        case "hover_jet":
          item.cost = _id_BA0EF3640498C7A4("dvar_FCDCAEAAA8F40528", 2000);
          break;
        case "sentry_gun":
          item.cost = _id_BA0EF3640498C7A4("dvar_C512CB98DF6838E4", 2500);
          break;
        case "cruise_missile":
          item.cost = _id_BA0EF3640498C7A4("dvar_AEC4305396812F6E", 1000);
          break;
        case "delta_squad":
          item.cost = _id_BA0EF3640498C7A4("dvar_214EEA2DCCBDB445", 1500);
          break;
        case "cover":
          item.cost = _id_BA0EF3640498C7A4("dvar_CF6AAFAE0B534221", 500);
          break;
        case "munitions_crate":
          item.cost = _id_BA0EF3640498C7A4("dvar_6797AE4558040E50", 500);
          break;
        case "juggernaut":
          item.cost = _id_BA0EF3640498C7A4("dvar_20024F5C0CB47DEA", 8000);
          break;
        case "cluster_spike":
          item.cost = _id_BA0EF3640498C7A4("dvar_42DA2C8440D67ED1", 500);
          break;
        case "auto_drone":
          item.cost = _id_BA0EF3640498C7A4("dvar_12ECACECFDF96460", 3000);
          break;
        default:
          item.cost = _id_BA0EF3640498C7A4("dvar_615D8307CFE8D21F", 1000);
          break;
      }
    } else if(isDefined(item._id_5C1D52079171649F))
      item.cost = _id_50EE6BA26A6F5FB0() * -1;

    _id_88884B6777DA9BB1 = _id_38079528F491FC0A(item);

    if(_id_88884B6777DA9BB1 > 0)
      item.cost = _id_88884B6777DA9BB1;

    level thread _id_F4C0B1158E535932(item);
  }
}

_id_BA0EF3640498C7A4(dvar, value) {
  setdvarifuninitialized(dvar, value);
  return getdvarint(dvar, value);
}

_id_E8C95A48F269C285(item, location, angle, offset) {
  _id_0A6A64A370E44B4E(item);

  if(!isDefined(offset))
    offset = 0;

  if(isDefined(item.scriptable)) {
    if(!isDefined(level._id_34D128DFF9D4AFE4))
      level._id_34D128DFF9D4AFE4 = [];

    index = level._id_34D128DFF9D4AFE4.size + 1;

    if(isDefined(angle))
      scriptable = spawnscriptable(item.scriptable, location + (0, 0, 30 + offset), angle);
    else
      scriptable = spawnscriptable(item.scriptable, location + (0, 0, 30 + offset));

    struct = spawnStruct();
    level._id_34D128DFF9D4AFE4[index] = struct;
    level._id_34D128DFF9D4AFE4[index].scriptable = scriptable;
  }
}

_id_F4C0B1158E535932(item) {
  crate = getEnt(item.target, "targetname");

  if(!isDefined(crate)) {
    return;
  }
  if(!isDefined(level._id_CCDD82907B113C40))
    level._id_CCDD82907B113C40 = [];

  struct = spawnStruct();
  struct.entnum = crate getentitynumber();
  struct._id_9226858A27AFACED = 0;
  level._id_CCDD82907B113C40[struct.entnum] = struct;

  if(getdvarint("dvar_FC2D09F2088A8838", 0) > 0)
    _id_E8C95A48F269C285(item, crate.origin, crate.angles);

  crate makeusable();
  crate sethinttag("tag_hint");
  crate setCursorHint("HINT_BUTTON");
  crate setuserange(4);
  crate sethintdisplayrange(512);
  crate disconnectPaths();
  crate.open = 0;
  item.crate = crate;
  crate.entnum = crate getentitynumber();
  crate._id_9226858A27AFACED = 0;

  if(!isDefined(item.cost))
    item.cost = 500;
  else
    int(item.cost);

  _id_9C9AD1DF28CABB0D = _id_4149E569A4716705(item);

  if(isDefined(_id_9C9AD1DF28CABB0D))
    item.headicon = _id_9C9AD1DF28CABB0D;

  _id_0C504E7C3CABAF5C = crate.angles + (0, 90, 0);
  crate._id_5D7B679A4E3DE14E = anglesToForward(_id_0C504E7C3CABAF5C) * 20 + crate.origin + (0, 0, 5);
  crate._id_8946C3E2E95DA2F8 = crate scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, item.headicon, undefined, 0, 1000, 1, 0, 0, 0, undefined, 0);

  if(isDefined(item.respawn)) {
    level._id_E4A74151CFC1435B = crate._id_5D7B679A4E3DE14E;
    crate._id_4638BD102E0BDBCF = 1;
  }

  level._id_CCDD82907B113C40[crate.entnum] = spawnStruct();
  level._id_CCDD82907B113C40[crate.entnum]._id_0A86F5D2BA9AFBF9 = crate;
  crate thread _id_7D378614C1FE7036();
}

_id_52810C46CB49DC3C(interaction, player) {
  if(_id_3EF2C8C3CB09E89A(interaction, player)) {
    success = _id_641BD92FD632BD6F(interaction, player);

    if(istrue(success)) {
      level notify("equipment_purchase", interaction, player);
      _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);

      switch (interaction.equipment) {
        case "equip_nvgs":
        case "c4_inc_breach":
        case "halligan":
        case "gasmask":
          _id_FC79A58E298E9B3B = _id_5EB0895FEB95298F(interaction.equipment);
          interaction.crate _id_F602321789A77BCF(player, _id_FC79A58E298E9B3B);
          break;
        case "equip_ascender":
          _id_57225AD900C21F66();
          break;
      }

      return;
    }
  } else if(_id_D5B20AA6CB2E8476(interaction, player)) {
    _id_7B3BFE986BEEA7A5(interaction, player);
    level notify("perk_purchase", interaction, player);
    _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);
    player _id_71332A5B74214116::refresh_interaction();
  } else if(_id_CF7D1F0844EED192(interaction, player)) {
    _id_35EADBB570B03D90(interaction, player);
    _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);
    interaction.cost = interaction.cost + level._id_C7B3E3C08938A826;
  } else if(_id_BF7B1FFC34739604(interaction, player)) {
    success = _id_273FB0D15016020F(interaction, player);

    if(success) {
      _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);
      return;
    }
  } else if(_id_37290C81D526D45D(interaction, player)) {
    success = _id_727920812C62A6D0(interaction, player);

    if(success) {
      _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);
      return;
    }

    player.interaction_trigger setHintString(&"CP_WEAPON_BUY/NO_UPGRADE");
    return;
  } else if(_id_7375371E6C29AC4E(interaction, player)) {
    success = _id_7F71B91E1BF42C4B(interaction, player);

    if(success)
      _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);

    interaction.cost = _id_50EE6BA26A6F5FB0() * -1;
  } else if(_id_9C6994751A0EDB4A(interaction, player)) {
    _id_D782CB9464D2BD59(interaction, player);

    if(getdvarint("dvar_F46B969BED694CB8", 0))
      _id_71332A5B74214116::remove_from_current_interaction_list(interaction);
  }
}

_id_5EB0895FEB95298F(_id_019CD48B2DAF2547) {
  switch (_id_019CD48B2DAF2547) {
    case "gasmask":
      return "brloot_equip_gasmask";
    case "halligan":
      return "cploot_equip_halligan";
    case "c4_inc_breach":
      return "cploot_equip_c4_inc_breach";
    case "equip_nvgs":
      return "cploot_equip_nvgs";
    default:
      return _id_019CD48B2DAF2547;
  }
}

_id_B0AA58B1601B13CD(trig, interaction, hintstring) {
  if(!istrue(interaction._id_EAECDF56E917C0A5)) {
    return;
  }
  if(interaction.script_noteworthy == "cash_bag") {
    amount = 1500;
    self.interaction_trigger sethintstringparams(int(amount));
    _id_B29F34759512E29D(interaction);
    return;
  }

  if(isDefined(interaction._id_5C1D52079171649F)) {
    amount = _id_50EE6BA26A6F5FB0();
    self.interaction_trigger sethintstringparams(int(amount));
    _id_B29F34759512E29D(interaction);
    return;
  }

  if(isDefined(interaction.weapon)) {
    objweapon = _id_2669878CF5A1B6BC::buildweapon(interaction.weapon, [], "none", "none", -1);
    _id_27E046998BAC14DC = 0;
    _id_BC002676438672C9 = self getweaponslistall();

    foreach(weapon in _id_BC002676438672C9) {
      if(issubstr(weapon.basename, interaction.weapon))
        _id_27E046998BAC14DC = 1;
    }

    if(self hasweapon(objweapon) || _id_27E046998BAC14DC) {
      self setclientomnvar("ui_cp_interaction_cost", 400);

      if(!_id_71332A5B74214116::can_purchase_interaction(interaction, 400))
        self.interaction_trigger setHintString(&"CP_WEAPON_BUY/PURCHASE_AMMO_NO_MONEY");
      else
        self.interaction_trigger setHintString(&"CP_WEAPON_BUY/PURCHASE_AMMO");

      weapon_name = _id_76F4BC26492030FF(interaction);
      _id_B29F34759512E29D(interaction);
      return;
    }
  }

  if(isDefined(interaction.perk)) {
    _id_624D00AB6F97A3DF = _id_76F4BC26492030FF(interaction);

    if(_id_4C99D5F08C48ED71::_id_8F03ACC557E2B610(interaction.perk))
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/PERK_PACK_REMOVE");
    else if(interaction.perk != "recon_drone" && interaction.perk != "perk_pack_double" && _id_4C99D5F08C48ED71::_id_F82E41138806E225())
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/REPLACE");
  }

  _id_BDD0A817CBD4A7CB = _id_76F4BC26492030FF(interaction);
  cost = int(level.interactions[interaction.script_noteworthy].cost);

  if(isDefined(interaction.cost))
    cost = int(interaction.cost);

  self setclientomnvar("ui_cp_interaction_cost", cost);

  if(!_id_71332A5B74214116::can_purchase_interaction(interaction, cost))
    self.interaction_trigger setHintString(&"CP_WEAPON_BUY/NO_PURCHASE");
  else {}

  if(isDefined(interaction.equipment) && interaction.equipment == "ammo") {
    _id_88B230F00C4A879C = 0;
    _id_FC926ACE38663F0F = 1;

    foreach(weapon in self.weaponlist) {
      if(weapon.basename != "iw9_me_fists_mp") {
        _id_7FC9076882EE98FF = weaponclipsize(weapon);
        _id_D7732D0238EAE9FF = scripts\cp\utility::_id_ED18A118C6FA5C4F(weapon);
        clip_ammo = self getweaponammoclip(weapon);
        stock_ammo = self getweaponammostock(weapon);

        if(clip_ammo < _id_7FC9076882EE98FF || stock_ammo < _id_D7732D0238EAE9FF)
          _id_88B230F00C4A879C = 1;

        _id_FC926ACE38663F0F = 0;
      }
    }

    if(!_id_88B230F00C4A879C)
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/AMMO_FULL");

    if(_id_FC926ACE38663F0F)
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/AMMO_NO_WEAPON");
  } else if(isDefined(interaction.equipment) && interaction.equipment == "self_revive") {
    if(istrue(self.has_auto_revive))
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/ALREADY_EQUIPPED");
  } else if(isDefined(interaction.equipment) && interaction.equipment == "halligan") {
    if(istrue(self._id_1FD57894D3F63B70))
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/ALREADY_EQUIPPED");
  } else if(isDefined(interaction.equipment) && interaction.equipment == "armor") {
    if(!_id_E5E0E7F1B9395A63())
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/ALREADY_EQUIPPED");
  } else if(isDefined(interaction.equipment) && interaction.equipment == "gasmask") {
    if(isDefined(self.gasmaskhealth) && self.gasmaskhealth > 0)
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/ALREADY_EQUIPPED");
  } else if(isDefined(interaction.equipment) && interaction.equipment == "c4_inc_breach") {
    if(isDefined(self._id_ECDAD53F119BE384) && self._id_ECDAD53F119BE384 > 0)
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/ALREADY_EQUIPPED");
  } else if(isDefined(interaction._id_F406BE343AB9CC93) && interaction._id_F406BE343AB9CC93 == "delta_squad") {
    _id_6E06A04FE60334CA = _id_5CB623572B271C34::_id_5C6C98E7D15B8D4A(self);

    if(isDefined(_id_6E06A04FE60334CA) && _id_6E06A04FE60334CA.size > 2 || !isDefined(level._id_F78FB7634E3797C4))
      self.interaction_trigger setHintString(level._id_9C3AA643B7642FB1);
    else if(_id_71332A5B74214116::can_purchase_interaction(interaction, cost))
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/PURCHASE");
  } else if(isDefined(interaction.respawn)) {
    _id_7BADD061F9CA39AB = 0;

    foreach(player in level.players) {
      if(isDefined(player._id_2A376311C6E39314))
        _id_7BADD061F9CA39AB = _id_7BADD061F9CA39AB + 1;
    }

    if(_id_7BADD061F9CA39AB == 0)
      self.interaction_trigger setHintString(&"CP_WEAPON_BUY/RESPAWN_NOT_AVAILABLE");
  } else if(_id_71332A5B74214116::can_purchase_interaction(interaction, cost))
    self.interaction_trigger setHintString(&"CP_WEAPON_BUY/PURCHASE");

  _id_B29F34759512E29D(interaction);
}

_id_B29F34759512E29D(interaction, _id_EFE526BF6A23D275) {
  _id_BBDF2E80B131B44F = 30;

  if(isDefined(interaction._id_10653A9B07EE3ECE))
    _id_BBDF2E80B131B44F = interaction._id_10653A9B07EE3ECE;

  pos = interaction.origin + (0, 0, _id_BBDF2E80B131B44F);

  if(isDefined(interaction.crate))
    pos = interaction.crate gettagorigin("tag_hint");

  self.interaction_trigger.origin = pos;
  self.interaction_trigger setCursorHint("HINT_BUTTON");
  self.interaction_trigger setuserange(100);
  self.interaction_trigger sethintdisplayrange(512);
}

_id_E5C72EB75BED9EB9(interaction) {
  ref = "";
  mapname = getDvar("ui_mapname");

  if(isDefined(interaction.weapon) && isDefined(interaction.attachments))
    ref = interaction.weapon + "_" + mapname;
  else if(isDefined(interaction.weapon_upgrade))
    ref = "weapon_upgrade";
  else if(isDefined(interaction._id_5C1D52079171649F))
    ref = "skiptimer";
  else if(isDefined(interaction.weapon))
    ref = interaction.weapon;
  else if(isDefined(interaction.equipment) && isDefined(interaction.attachments))
    ref = interaction.equipment + "_" + mapname;
  else if(isDefined(interaction.equipment))
    ref = interaction.equipment;
  else if(isDefined(interaction.perk))
    ref = interaction.perk;
  else if(isDefined(interaction.respawn))
    ref = interaction.respawn;
  else if(isDefined(interaction._id_F406BE343AB9CC93))
    ref = interaction._id_F406BE343AB9CC93;
  else if(isDefined(interaction._id_2E37E8FCFD187B4E))
    ref = interaction._id_2E37E8FCFD187B4E;
  else if(isDefined(interaction._id_9C791A7A7FC6C7B5))
    ref = interaction._id_9C791A7A7FC6C7B5;

  return ref;
}

_id_76F4BC26492030FF(interaction) {
  ref = _id_E5C72EB75BED9EB9(interaction);

  if(ref != "" && isDefined(level._id_DD1B9D6AEC9585D7[ref].name))
    return level._id_DD1B9D6AEC9585D7[ref].name;
}

_id_38079528F491FC0A(interaction) {
  ref = _id_E5C72EB75BED9EB9(interaction);

  if(ref != "" && isDefined(level._id_DD1B9D6AEC9585D7[ref]._id_88884B6777DA9BB1))
    return level._id_DD1B9D6AEC9585D7[ref]._id_88884B6777DA9BB1;

  return 0;
}

_id_4149E569A4716705(interaction) {
  ref = _id_E5C72EB75BED9EB9(interaction);
  icon = tablelookupistring("cp/incursion_interaction_cards.csv", 1, ref, 4);

  if(isDefined(icon)) {
    if(isDefined(level._id_DD1B9D6AEC9585D7[ref]))
      return level._id_DD1B9D6AEC9585D7[ref].icon;
  }
}

_id_0A6A64A370E44B4E(item) {
  ref = _id_E5C72EB75BED9EB9(item);

  if(isDefined(ref)) {
    scriptablename = tablelookup("cp/incursion_interaction_cards.csv", 1, ref, 8);

    if(scriptablename != "")
      item.scriptable = scriptablename;
  }
}

_id_3EF2C8C3CB09E89A(interaction, player) {
  return isDefined(interaction.equipment);
}

_id_273FB0D15016020F(interaction, player) {
  _id_6E1EC6F2C0EE6B2C = undefined;
  _id_B8BA56B9EDD59CB7 = player getplayerdata("cp", "inventorySlots", "totalSlots");

  if(_id_B8BA56B9EDD59CB7 < 4)
    _id_6E1EC6F2C0EE6B2C = _id_B8BA56B9EDD59CB7;
  else
    _id_6E1EC6F2C0EE6B2C = player.dpad_selection_index - 1;

  _id_C64B92D56EC838B3 = scripts\cp\loot_system::get_empty_munition_slot(player);

  if(isDefined(_id_C64B92D56EC838B3))
    _id_6E1EC6F2C0EE6B2C = _id_C64B92D56EC838B3;
  else {
    player scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
    return 0;
  }

  if(interaction._id_F406BE343AB9CC93 == "precision_airstrike") {
    player scripts\cp\loot_system::try_give_munition_to_slot("precision_airstrike", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "hover_jet") {
    player scripts\cp\loot_system::try_give_munition_to_slot("hover_jet", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "sentry_gun") {
    player scripts\cp\loot_system::try_give_munition_to_slot("sentry", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "cruise_missile") {
    player scripts\cp\loot_system::try_give_munition_to_slot("cruise_missile", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "cover") {
    player scripts\cp\loot_system::try_give_munition_to_slot("deployable_cover", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "munitions_crate") {
    player scripts\cp\loot_system::try_give_munition_to_slot("munitions_crate", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "juggernaut") {
    player scripts\cp\loot_system::try_give_munition_to_slot("juggernaut", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "cluster_spike") {
    player scripts\cp\loot_system::try_give_munition_to_slot("cluster_spike", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "auto_drone") {
    player scripts\cp\loot_system::try_give_munition_to_slot("auto_drone", _id_6E1EC6F2C0EE6B2C);
    return 1;
  } else if(interaction._id_F406BE343AB9CC93 == "delta_squad") {
    _id_30C5DCD8B800B7C5 = _id_5CB623572B271C34::_id_110F112431C654DC();
    _id_6E06A04FE60334CA = _id_5CB623572B271C34::_id_5C6C98E7D15B8D4A(player);

    if(_id_30C5DCD8B800B7C5 > 12 || isDefined(_id_6E06A04FE60334CA) && _id_6E06A04FE60334CA.size > 2) {
      player.interaction_trigger setHintString(level._id_9C3AA643B7642FB1);
      player thread scripts\cp\cp_hud_message::tutorialprint(level._id_9C3AA643B7642FB1, 2);
      return 0;
    } else if(!isDefined(level._id_F78FB7634E3797C4)) {
      player.interaction_trigger setHintString(level._id_9C3AA643B7642FB1);
      player thread scripts\cp\cp_hud_message::tutorialprint(level._id_9C3AA643B7642FB1, 2);
      return 0;
    }

    player thread scripts\cp\cp_hud_message::tutorialprint(level._id_87DBB8D8D744C95F, 3);
    player scripts\cp\utility::playsoundtoplayer_safe("buystation_deltasquad_buy", player);
    level notify("deploy_delta_squad", player);
    return 1;
  }
}

_id_7F71B91E1BF42C4B(interaction, player) {
  if(isDefined(level._id_E9922F45DB5AE222)) {
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_WEAPON_BUY/SKIPTIMER_DISPLAY", 5);
    amount = _id_50EE6BA26A6F5FB0();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      level.players[_id_AC0E594AC96AA3A8] _id_3BCAA2CBAF54ABDD::give_player_currency(amount);
      level.players[_id_AC0E594AC96AA3A8] thread _id_293BC33BD79CABD1::killeventtextpopup("stat_532C064CAF1E3CA6");
    }

    return 1;
  } else
    return 0;
}

_id_50EE6BA26A6F5FB0() {
  if(!isDefined(level._id_E9922F45DB5AE222))
    return 0;

  amount = level._id_E9922F45DB5AE222 * 25;
  return amount;
}

_id_FCD615FEEF7E2E28(_id_DF071553D0996FF9, player) {
  _id_DF071553D0996FF9.cost = _id_50EE6BA26A6F5FB0() * -1;
}

_id_641BD92FD632BD6F(interaction, player) {
  if(isDefined(interaction.crate)) {
    if(interaction.equipment == "armor") {
      if(!player _id_E5E0E7F1B9395A63())
        return 0;
    }

    if(!interaction.crate.open) {
      interaction.crate setscriptablepartstate("body", "opening");
      interaction.crate.open = 1;
    }
  }

  if(interaction.equipment == "gasmask") {} else if(interaction.equipment == "halligan") {} else if(interaction.equipment == "c4_inc_breach") {} else if(interaction.equipment == "self_revive")
    player thread scripts\cp\utility::_id_042B1F4ECAC37172();
  else if(interaction.equipment == "ammo") {
    foreach(weapon in player.weaponlist) {
      clip_ammo = weaponclipsize(weapon);
      player setweaponammoclip(weapon, clip_ammo);
      player _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }
  } else if(interaction.equipment == "armor")
    player _id_2D0D93AD3713479C();
  else if(interaction.equipment == "equip_hb_sensor") {
    player _id_7EF95BBA57DC4B82::giveequipment(interaction.equipment, "secondary");
    player _id_7EF95BBA57DC4B82::setequipmentammo(interaction.equipment, 1);
  } else if(interaction.equipment == "equip_nvgs") {} else if(interaction.equipment == "equip_ascender") {} else if(interaction.equipment == "power_c4") {
    player _id_7EF95BBA57DC4B82::giveequipment(interaction.equipment, "primary");
    player _id_7EF95BBA57DC4B82::setequipmentammo(interaction.equipment, 1);
  } else if(interaction.equipment == "power_snapshotGrenade") {
    player _id_7EF95BBA57DC4B82::giveequipment(interaction.equipment, "secondary");
    player _id_7EF95BBA57DC4B82::setequipmentammo(interaction.equipment, 2);
  } else if(interaction.equipment == "power_smokeGrenade") {
    player _id_7EF95BBA57DC4B82::giveequipment(interaction.equipment, "secondary");
    player _id_7EF95BBA57DC4B82::setequipmentammo(interaction.equipment, 2);
  } else {
    _id_940EBB321300CD65 = 4;
    _id_34D1187370A405EE = player _id_4C99D5F08C48ED71::_id_E5EA666722BE9CD0(_id_940EBB321300CD65);
    player _id_7EF95BBA57DC4B82::giveequipment(interaction.equipment, "primary");
    player _id_7EF95BBA57DC4B82::setequipmentammo(interaction.equipment, _id_34D1187370A405EE);
  }

  if(isDefined(interaction.crate)) {
    switch (interaction.equipment) {
      case "equip_nvgs":
      case "c4_inc_breach":
      case "halligan":
      case "gasmask":
        interaction.crate thread _id_2B76AB15FA611578();
        break;
      default:
        interaction.crate thread _id_410D04B49EDF89EA();
        break;
    }
  }

  return 1;
}

_id_D5B20AA6CB2E8476(interaction, player) {
  return isDefined(interaction.perk);
}

_id_7B3BFE986BEEA7A5(interaction, player) {
  if(!interaction.crate.open) {
    interaction.crate setscriptablepartstate("body", "opening");
    interaction.crate.open = 1;
  }

  if(interaction.perk == "recon_drone")
    player _id_56EF8D52FE1B48A1::give_player_super("role_hunter");
  else if(interaction.perk == "perk_pack_double")
    player _id_4C99D5F08C48ED71::_id_ED49C972DAEB7575();
  else
    player _id_4C99D5F08C48ED71::_id_9DFBC3169C4FB507(interaction.perk, 3);

  if(getdvarint("dvar_ED807F6518ECC61B", 0)) {
    interaction.crate hudoutlineenable("outline_depth_red");
    interaction.crate makeunusable();
    _id_71332A5B74214116::remove_from_current_interaction_list(interaction);
  } else
    interaction.crate thread _id_410D04B49EDF89EA();
}

_id_9C6994751A0EDB4A(interaction, player) {
  return isDefined(interaction.weapon);
}

_id_37290C81D526D45D(interaction, player) {
  return isDefined(interaction.weapon_upgrade);
}

_id_7375371E6C29AC4E(interaction, player) {
  return isDefined(interaction._id_5C1D52079171649F);
}

_id_D782CB9464D2BD59(interaction, player) {
  _id_27E046998BAC14DC = 0;
  _id_BC002676438672C9 = player getweaponslistprimaries();
  _id_E1247B4AF7DA12D7 = 0;
  _id_22C6A14F888BF75F = 0;
  _id_388F7437F9B4BA85 = 0;

  foreach(weapon in _id_BC002676438672C9) {
    if(issubstr(weapon.basename, interaction.weapon))
      _id_27E046998BAC14DC = 1;

    if(issubstr(weapon.basename, "fists"))
      _id_E1247B4AF7DA12D7 = 1;

    if(issubstr(weapon.basename, "golf"))
      _id_22C6A14F888BF75F = 1;

    if(weapon.inventorytype == "primary")
      _id_388F7437F9B4BA85 = _id_388F7437F9B4BA85 + 1;
  }

  if(_id_27E046998BAC14DC) {
    foreach(weapon in _id_BC002676438672C9) {
      if(issubstr(weapon.basename, interaction.weapon)) {
        player scripts\cp\utility::_id_AD3CE5E1679DF13D(weapon);
        player setweaponammoclip(weapon, weaponclipsize(weapon));
      }
    }

    _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player, 500);
    player playlocalsound("weap_ammo_pickup");

    if(!interaction.crate.open) {
      interaction.crate setscriptablepartstate("body", "opening");
      interaction.crate.open = 1;
    }

    interaction.crate thread _id_410D04B49EDF89EA();
    return;
  } else {
    _id_71332A5B74214116::_id_9A2E153E21F32208(interaction, player);

    if(!interaction.crate.open) {
      interaction.crate setscriptablepartstate("body", "opening");
      interaction.crate.open = 1;
    }

    attachments = [];

    if(isDefined(interaction.attachments) && interaction.attachments != "none")
      attachments = strtok(interaction.attachments, ",");

    weapon = player getcurrentweapon();
    _id_968444D674116D0C = getweaponattachments(weapon);
    _id_A0EF3A9F0FD71AC6 = undefined;

    if(istrue(level._id_6CE96C8DB53281FC))
      _id_A0EF3A9F0FD71AC6 = 1;

    objweapon = _id_2669878CF5A1B6BC::buildweapon(interaction.weapon, attachments, "none", "none", -1, undefined, undefined, undefined, _id_A0EF3A9F0FD71AC6);

    if(istrue(level._id_CAE12707E51C9673)) {
      _id_7D8CC1E4CB3F1EB5 = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      _id_E3096551FB86B1BC = [];
      _id_B9967B96C5F062FF = [];

      foreach(_id_7312A46FA51227E3 in _id_968444D674116D0C) {
        if(objweapon canuseattachment(_id_7312A46FA51227E3)) {
          _id_E3096551FB86B1BC[_id_E3096551FB86B1BC.size] = _id_7312A46FA51227E3;
          continue;
        }

        _id_B9967B96C5F062FF[_id_B9967B96C5F062FF.size] = _id_7312A46FA51227E3;
      }

      if(_id_B9967B96C5F062FF.size > 0) {
        foreach(attachment in _id_B9967B96C5F062FF) {
          _id_607D8B932B767CD1 = _id_2669878CF5A1B6BC::attachmentmap_tocategory(attachment);

          if(!isDefined(_id_607D8B932B767CD1)) {
            continue;
          }
          _id_657695DB432D3E9A = _id_26056147292BC4C0::_id_5FBCC7FC1266B377(_id_607D8B932B767CD1);
          _id_7168E79CE30860C5 = undefined;

          foreach(_id_7F79693E538D5735 in _id_657695DB432D3E9A) {
            if(issubstr(_id_607D8B932B767CD1, _id_7F79693E538D5735))
              _id_7168E79CE30860C5 = _id_7F79693E538D5735;
          }

          if(isDefined(_id_7168E79CE30860C5)) {
            foreach(key, value in level.weaponattachments[_id_7D8CC1E4CB3F1EB5]) {
              if(issubstr(key, _id_7168E79CE30860C5)) {
                _id_E3096551FB86B1BC[_id_E3096551FB86B1BC.size] = key;
                break;
              }
            }
          }
        }
      }

      _id_D1B4B4DEC0598B11 = scripts\engine\utility::array_combine_unique(attachments, _id_E3096551FB86B1BC);
      objweapon = _id_2669878CF5A1B6BC::buildweapon(interaction.weapon, _id_D1B4B4DEC0598B11, "none", "none", -1);
    }

    player giveweapon(objweapon);
    player switchtoweaponimmediate(objweapon);

    if(_id_BC002676438672C9.size > 1) {
      if(!player scripts\cp\utility::_hasperk("specialty_extra_weapon") || player scripts\cp\utility::_hasperk("specialty_extra_weapon") && _id_388F7437F9B4BA85 == 3) {
        if(_id_E1247B4AF7DA12D7)
          player takeweapon("iw9_me_fists_mp");
        else
          player scripts\cp\cp_weapons::drop_weapon_scripted(1, 180);
      }
    }

    player scripts\cp\utility::_id_AD3CE5E1679DF13D(objweapon);
    player scripts\cp\cp_weapons::_id_7987D9595236215F(objweapon);
    level notify("weapon_purchase", interaction, player);

    if(!getdvarint("dvar_363FB7BA365DFF13", 0))
      interaction.crate thread _id_410D04B49EDF89EA();
  }
}

_id_410D04B49EDF89EA() {
  level endon("game_ended");
  wait 1.5;
  self setscriptablepartstate("body", "closed");
  self.open = 0;
}

_id_2B76AB15FA611578() {
  level endon("game_ended");
  self waittill("crate_usable");
  self setscriptablepartstate("body", "closed");
  self.open = 0;
}

_id_BF7B1FFC34739604(interaction, player) {
  return isDefined(interaction._id_F406BE343AB9CC93);
}

_id_CF7D1F0844EED192(interaction, player) {
  return isDefined(interaction.respawn);
}

_id_31A6778FA9C7CACB(interaction) {
  _id_60F7CB484EC61F6C = spawnStruct();
  _id_60F7CB484EC61F6C.origin = interaction.origin;
  _id_60F7CB484EC61F6C.angles = interaction.angles;
  return _id_60F7CB484EC61F6C;
}

_id_35EADBB570B03D90(interaction, _id_F98106561011CF6C) {
  _id_8DDE7F512F478C1B = _id_31A6778FA9C7CACB(interaction);
  _id_545748C95D3C31E7 = undefined;

  foreach(player in level.players) {
    if(_id_F98106561011CF6C != player) {
      player._id_8DDE7F512F478C1B = _id_8DDE7F512F478C1B;
      player notify("revive_success");
      _id_545748C95D3C31E7 = 1;
    }
  }

  if(istrue(_id_545748C95D3C31E7)) {
    foreach(player in level.players) {
      player thread scripts\cp\cp_hud_message::showsplash("cp_used_respawn", undefined, _id_F98106561011CF6C);

      if(isDefined(player.corpse)) {
        player.corpse delete();
        player.corpse = undefined;
      }
    }

    _id_0AFB7E332AEE4BF2::_id_D6EBED99DC9008C2();
  }
}

_id_5F3A1AD41FB75140() {
  self._id_1FD57894D3F63B70 = 1;
  self._id_46BAEBC8956D9D41 = scripts\cp\utility::set_carry_item(self, "halligan");
}

_id_E5E0E7F1B9395A63() {
  if(_id_07C40FA80892A721::_id_79E0AB2AA0304A2C())
    return 0;

  return 1;
}

_id_2D0D93AD3713479C(_id_7EF92A583424AF15) {
  if(isDefined(_id_7EF92A583424AF15) && isint(_id_7EF92A583424AF15))
    _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_7EF92A583424AF15);
  else
    _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(5);

  self playlocalsound("weap_ammo_pickup");
}

_id_57225AD900C21F66() {
  foreach(player in level.players) {
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_INCURSION/ASCENDER_REWARD", 4);
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ascender");
  }
}

_id_F602321789A77BCF(player, ref, param3, param4) {
  _id_F376C1E66F42F294 = 2;
  _id_118F9DFA916F373B = 0;
  self._id_9226858A27AFACED = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F376C1E66F42F294; _id_AC0E594AC96AA3A8++) {
    if(_id_F376C1E66F42F294 < 5)
      _id_118F9DFA916F373B = 3;

    drop_type = ref;
    _id_06FE80416B4BE165 = _id_66122A002AFF5D57::getitemdroporiginandangles(_id_AC0E594AC96AA3A8 + _id_118F9DFA916F373B, self.origin, self.angles);
    item = _id_66122A002AFF5D57::spawnpickup(drop_type, _id_06FE80416B4BE165, undefined, 1);
    self._id_9226858A27AFACED = self._id_9226858A27AFACED + 1;
    item._id_946234CE1B1416FF = self getentitynumber();
  }
}

_id_727920812C62A6D0(interaction, player) {
  level endon("game_ended");
  player endon("disconnect");
  weapons = player getweaponslistprimaries();
  _id_80DAEE44B2F7948E = 2;
  weapon = undefined;
  _id_3384211CA508ED2F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weapons.size; _id_AC0E594AC96AA3A8++) {
    name = weapons[_id_AC0E594AC96AA3A8].basename;

    if(issubstr(name, "ks_")) {
      continue;
    }
    if(weapons[_id_AC0E594AC96AA3A8].isalternate) {
      continue;
    }
    _id_3384211CA508ED2F[_id_3384211CA508ED2F.size] = weapons[_id_AC0E594AC96AA3A8];
  }

  if(_id_3384211CA508ED2F.size >= _id_80DAEE44B2F7948E) {
    _id_0B30A1E974D02FDA = player getcurrentprimaryweapon();

    if(isDefined(player.last_valid_weapon))
      _id_0B30A1E974D02FDA = player.last_valid_weapon;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3384211CA508ED2F.size; _id_AC0E594AC96AA3A8++) {
      name = weapons[_id_AC0E594AC96AA3A8].basename;

      if(issubstr(name, "fist")) {
        _id_0B30A1E974D02FDA = weapons[_id_AC0E594AC96AA3A8];
        break;
      }
    }

    weapon_name = _id_2669878CF5A1B6BC::getweaponrootname(_id_0B30A1E974D02FDA);
    weapon = _id_0FB7EC9668F25FEA(weapon_name);

    if(isDefined(weapon)) {
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_0B30A1E974D02FDA);
      player scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon);
      player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weapon);
      return 1;
    }
  }

  return 0;
}

_id_0FB7EC9668F25FEA(_id_0B30A1E974D02FDA) {
  weapon_name = _id_0B30A1E974D02FDA;

  if(scripts\cp\utility::weaponhasvariants(weapon_name))
    weapon_obj = _id_2669878CF5A1B6BC::buildweapon_blueprint(weapon_name, "none", "none", randomint(11));
  else
    weapon_obj = undefined;

  return weapon_obj;
}

_id_7D378614C1FE7036() {
  level endon("game_ended");
  self endon("interaction_monitor_early_endon");
  self endon("death");
  crate = self;

  if(isDefined(level._id_37BFBB27CF46666C)) {
    level._id_37BFBB27CF46666C[level._id_37BFBB27CF46666C.size] = self;
    return;
  }

  level._id_37BFBB27CF46666C = [];
  level._id_37BFBB27CF46666C[level._id_37BFBB27CF46666C.size] = self;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_37BFBB27CF46666C.size; _id_AC0E594AC96AA3A8++) {
      foreach(player in level.players) {
        if(istrue(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_703B3B072DEA5230)) {
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_8946C3E2E95DA2F8, player);
          continue;
        } else if(!istrue(player.spectating)) {
          dist = distancesquared(player.origin, level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8].origin);

          if(istrue(level._id_B51ADB1C7AB7788C) && istrue(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_4638BD102E0BDBCF) && isDefined(level._id_50AC7F8D5B660A9C)) {
            scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_8946C3E2E95DA2F8, player);

            if(dist < squared(100)) {
              if(!istrue(player._id_054AB6DD6BC537EB)) {
                scripts\cp\cp_objectives::objective_playermask_hidefrom(level._id_50AC7F8D5B660A9C, player);
                player._id_054AB6DD6BC537EB = 1;
              }
            } else if(istrue(player._id_054AB6DD6BC537EB)) {
              scripts\cp\cp_objectives::objective_playermask_addshowplayer(level._id_50AC7F8D5B660A9C, player);
              player._id_054AB6DD6BC537EB = undefined;
            }

            continue;
          }

          if(dist > squared(512)) {
            scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_8946C3E2E95DA2F8, player);
            continue;
          } else {
            if(dist < squared(100)) {
              level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8] disableplayeruse(player);
              scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_8946C3E2E95DA2F8, player);
              continue;
            }

            if(!isDefined(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_9226858A27AFACED) || isDefined(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_9226858A27AFACED) && level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_9226858A27AFACED <= 0) {
              level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8] enableplayeruse(player);
              scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(level._id_37BFBB27CF46666C[_id_AC0E594AC96AA3A8]._id_8946C3E2E95DA2F8, player);
            }
          }
        }
      }
    }

    wait 0.1;
  }
}

_id_6B1E54E3FEB9FF45(point, name, icon) {
  objindex = undefined;

  if(isDefined(level.worldobjidpool)) {
    objindex = scripts\cp\cp_objectives::requestworldid(name);
    objective_state(objindex, "current");
    _func_1520141B68C3005E(objindex);
    objective_position(objindex, scripts\engine\utility::drop_to_ground(point, 1500));
    objective_icon(objindex, icon);
    objective_setminimapiconsize(objindex, "icon_regular");
    objective_setshowdistance(objindex, 0);
    objective_setplayintro(objindex, 0);
  }

  return objindex;
}

_id_C1523435D96C5549(objindex, name) {
  if(isDefined(level.worldobjidpool)) {
    objective_delete(objindex);
    scripts\cp\cp_objectives::freeworldid(name);
  }
}

_id_0E4D346D9043BEA4() {
  if(isDefined(level._id_34D128DFF9D4AFE4)) {
    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= level._id_34D128DFF9D4AFE4.size; _id_AC0E594AC96AA3A8++)
      level._id_34D128DFF9D4AFE4[_id_AC0E594AC96AA3A8].scriptable disablescriptableplayeruse(self);
  }
}