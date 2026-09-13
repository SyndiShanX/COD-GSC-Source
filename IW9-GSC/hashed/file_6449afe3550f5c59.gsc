/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6449afe3550f5c59.gsc
***********************************************/

main() {
  if(isDefined(level._id_B6F920E6490405E8)) {
    if(!scripts\engine\utility::flag_exist(level._id_B6F920E6490405E8 + "_completed"))
      scripts\engine\utility::flag_init(level._id_B6F920E6490405E8 + "_completed");

    scripts\engine\utility::flag_wait(level._id_B6F920E6490405E8 + "_completed");
  } else {
    if(!scripts\engine\utility::flag_exist("cp_crate_drops_cs_completed"))
      scripts\engine\utility::flag_init("cp_crate_drops_cs_completed");

    scripts\engine\utility::flag_wait("cp_crate_drops_cs_completed");
  }

  level thread _id_1C69A497C8ADA5DE();
}

_id_1C69A497C8ADA5DE() {
  level._id_22AEC2980D9D69FE = [];

  if(!isDefined(level._id_A30BD62E41E58A08))
    level._id_A30BD62E41E58A08 = [];

  _id_71332A5B74214116::registerinteraction("airdrop_station", ::_id_3A6A83D66027F63B, ::_id_CE1E2BCE6AC5526F, ::_id_FB2F1CEAFD02EA64);
  level thread _id_800B0AF8DB75276F();
}

_id_FB2F1CEAFD02EA64(interactions) {
  foreach(item in interactions)
  item thread _id_56150B500D23FC2A();

  if(!isDefined(interactions[0].cost))
    level.interactions[interactions[0].script_noteworthy].cost = 1000;
  else
    level.interactions[interactions[0].script_noteworthy].cost = int(interactions[0].cost);

  level._id_A30BD62E41E58A08["airdrop_station"] = ::_id_3BC1783B0562DEFB;
}

_id_3A6A83D66027F63B(interaction, player) {
  return &"COOP_GAME_PLAY/AIRDROP_STATION";
}

_id_3BC1783B0562DEFB(trig, interaction, hintstring) {
  weapon_name = _id_90A2E531A04DF2AC(interaction);

  if(isDefined(interaction.cost))
    self.interaction_trigger sethintstringparams(weapon_name, int(interaction.cost));
  else
    self.interaction_trigger sethintstringparams(weapon_name, int(level.interactions[interaction.script_noteworthy].cost));
}

_id_90A2E531A04DF2AC(interaction) {
  weapon_name = "";

  if(isDefined(interaction._id_4A27073C378A2C00))
    weapon_name = interaction._id_4A27073C378A2C00;

  switch (weapon_name) {
    case "airstrike":
      return &"KILLSTREAKS/PRECISION_AIRSTRIKE";
    case "cruise_missile":
      return &"KILLSTREAKS/CRUISE_PREDATOR";
    case "cluster_strike":
      return &"KILLSTREAKS/TOMA_STRIKE";
    case "armor_crate":
      return &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
    case "random_item_box":
      return &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
  }

  return weapon_name;
}

_id_CE1E2BCE6AC5526F(interaction, player) {
  if(!player scripts\cp\utility::is_valid_player()) {
    return;
  }
  player _id_9F7B5EF0C797D03D("iw8_ges_plyr_plunder_smoke", 1.867);
  _id_35B2CC4737E1699F = scripts\engine\utility::getStructArray("crate_spawn", "targetname");
  loc = _id_7FC3994F650D9D1A(_id_35B2CC4737E1699F, interaction);
  _id_4E0D9C78FA04CDD4 = spawn("script_model", loc.origin);
  _id_4E0D9C78FA04CDD4 setModel("offhand_wm_grenade_smoke");
  _id_4E0D9C78FA04CDD4.angles = (0, 90, 90);
  fxent = spawn("script_model", loc.origin);
  fxent setModel("ks_crate_marker_mp");
  fxent setscriptablepartstate("smoke", "on", 0);

  if(istrue(interaction._id_4EA123D69D1C0EB9)) {
    _id_71332A5B74214116::remove_from_current_interaction_list(interaction);
    interaction._id_8206B98791E7DC20 setscriptablepartstate("main", "off");
    interaction notify("stop_obj_icon");
  }

  _id_8DFBB6CFF5692B76(interaction, player);
  _id_99FDEF5299E26DA4 = "";

  if(isDefined(loc.script_noteworthy))
    _id_99FDEF5299E26DA4 = loc.script_noteworthy;

  wait 15;
  level notify("drop_requested", _id_99FDEF5299E26DA4, [interaction._id_4A27073C378A2C00], interaction._id_E91C88DE8CB8AFB9);
  wait 1;
  _id_4E0D9C78FA04CDD4 delete();
  fxent delete();
}

_id_9F7B5EF0C797D03D(weaponref, _id_EB5B1F36E255152D) {
  self endon("death_or_disconnect");
  _id_A7408DBFED49F3F9 = makeweapon(weaponref);
  self giveandfireoffhand(_id_A7408DBFED49F3F9);
  wait(_id_EB5B1F36E255152D);

  if(self hasweapon(_id_A7408DBFED49F3F9))
    self takeweapon(_id_A7408DBFED49F3F9);
}

_id_8DFBB6CFF5692B76(_id_DF071553D0996FF9, player) {
  cost = _id_DF071553D0996FF9 _id_71332A5B74214116::interaction_get_cost();
  level notify("interaction", "purchase", level.interactions[_id_DF071553D0996FF9.script_noteworthy], player);
  _id_E42F7EB456B932F2 = level.interactions[_id_DF071553D0996FF9.script_noteworthy].spend_type;
  player thread _id_71332A5B74214116::take_player_money(cost, _id_E42F7EB456B932F2);
}

_id_56150B500D23FC2A() {
  self._id_8206B98791E7DC20 = spawn("script_model", self.origin);
  _id_8BC14603A27FA3E7 = (0, 0, 0);

  if(isDefined(self.angles))
    _id_8BC14603A27FA3E7 = self.angles;

  self._id_8206B98791E7DC20.angles = self.angles;
  self._id_8206B98791E7DC20 setModel("military_hq_crate_01_proxy_cp_spawnable");
  self._id_8206B98791E7DC20 setscriptablepartstate("main", "off");
  self._id_8206B98791E7DC20.interaction = self;
  self.cost = 1000;
  level._id_22AEC2980D9D69FE[level._id_22AEC2980D9D69FE.size] = self;
  _id_71332A5B74214116::remove_from_current_interaction_list(self);
}

_id_800B0AF8DB75276F() {
  level endon("game_ended");

  while(!isDefined(level.players))
    wait 0.1;

  while(level.players.size < 1)
    wait 0.1;

  for(;;) {
    level waittill("trigger_airdrop", _id_9A295712650B6038, _id_9CF4EC5C838B241E);

    if(isDefined(_id_9A295712650B6038)) {
      interaction = _id_60F98C8A87343B13(_id_9CF4EC5C838B241E);
      interaction._id_4A27073C378A2C00 = _id_9A295712650B6038;
      interaction._id_E91C88DE8CB8AFB9 = "incursion_" + _id_9A295712650B6038;
      interaction._id_4EA123D69D1C0EB9 = 1;
      interaction.active = 1;
      interaction._id_8206B98791E7DC20 setscriptablepartstate("main", "on");
      icon = "hud_icon_killstreak_" + _id_9A295712650B6038;
      interaction thread _id_4AD5CA29D93F1F6F(icon);
      _id_71332A5B74214116::add_to_current_interaction_list(interaction);
      continue;
    }

    _id_35B2CC4737E1699F = level._id_22AEC2980D9D69FE;
    _id_2D7E20CDCF2AB3B2 = _id_C52D9C7D3889A4B9(_id_35B2CC4737E1699F);
    _id_2D7E20CDCF2AB3B2._id_4A27073C378A2C00 = "cruise_missile";
    _id_2D7E20CDCF2AB3B2._id_E91C88DE8CB8AFB9 = "incursion_cruise_missile";
    _id_2D7E20CDCF2AB3B2._id_8206B98791E7DC20 setscriptablepartstate("main", "on");
    _id_2D7E20CDCF2AB3B2._id_4EA123D69D1C0EB9 = 1;
    _id_2D7E20CDCF2AB3B2.active = 1;
    icon = "hud_icon_killstreak_cruise_missile";
    _id_2D7E20CDCF2AB3B2 thread _id_4AD5CA29D93F1F6F(icon);
    _id_71332A5B74214116::add_to_current_interaction_list(_id_2D7E20CDCF2AB3B2);
    _id_35B2CC4737E1699F = scripts\engine\utility::array_remove(_id_35B2CC4737E1699F, _id_2D7E20CDCF2AB3B2);
    _id_2D7E20CDCF2AB3B2 = _id_C52D9C7D3889A4B9(_id_35B2CC4737E1699F);
    _id_2D7E20CDCF2AB3B2._id_4A27073C378A2C00 = "airstrike";
    _id_2D7E20CDCF2AB3B2._id_E91C88DE8CB8AFB9 = "incursion_airstrike";
    _id_2D7E20CDCF2AB3B2._id_8206B98791E7DC20 setscriptablepartstate("main", "on");
    _id_2D7E20CDCF2AB3B2._id_4EA123D69D1C0EB9 = 1;
    _id_2D7E20CDCF2AB3B2.active = 1;
    icon = "hud_icon_killstreak_airstrike";
    _id_2D7E20CDCF2AB3B2 thread _id_4AD5CA29D93F1F6F(icon);
    _id_71332A5B74214116::add_to_current_interaction_list(_id_2D7E20CDCF2AB3B2);
  }
}

_id_DED98FC07F2944C8(_id_79231C13F4FAD89D) {
  _id_5F8B983A9CC28FB2 = [];

  foreach(interaction in _id_79231C13F4FAD89D) {
    if(!istrue(interaction.active))
      _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = interaction;
  }

  _id_79231C13F4FAD89D = _id_5F8B983A9CC28FB2;
  _id_8FB1B758C77B28B1 = _id_79231C13F4FAD89D[0];
  _id_3A15EC59F3FC717E = 1000000;

  foreach(_id_9673289A11971119 in _id_79231C13F4FAD89D) {
    dist = 0;

    foreach(player in level.players)
    dist = dist + distance2d(player.origin, _id_9673289A11971119.origin);

    if(dist < _id_3A15EC59F3FC717E) {
      _id_8FB1B758C77B28B1 = _id_9673289A11971119;
      _id_3A15EC59F3FC717E = dist;
    }
  }

  return _id_8FB1B758C77B28B1;
}

_id_C52D9C7D3889A4B9(_id_79231C13F4FAD89D) {
  _id_5F8B983A9CC28FB2 = [];

  foreach(interaction in _id_79231C13F4FAD89D) {
    if(!istrue(interaction.active))
      _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = interaction;
  }

  _id_79231C13F4FAD89D = _id_5F8B983A9CC28FB2;
  _id_3342A2487478D901 = _id_79231C13F4FAD89D[0];
  _id_6ABF4CEA6BF92F0E = 0;

  foreach(_id_9673289A11971119 in _id_79231C13F4FAD89D) {
    dist = undefined;
    player = scripts\engine\utility::getclosest(_id_9673289A11971119.origin, level.players);
    dist = distance2dsquared(player.origin, _id_9673289A11971119.origin);

    if(dist > _id_6ABF4CEA6BF92F0E) {
      _id_3342A2487478D901 = _id_9673289A11971119;
      _id_6ABF4CEA6BF92F0E = dist;
    }
  }

  return _id_3342A2487478D901;
}

_id_7FC3994F650D9D1A(_id_79231C13F4FAD89D, _id_F0849A68CE2ACCFF) {
  loc = scripts\engine\utility::getclosest(_id_F0849A68CE2ACCFF.origin, _id_79231C13F4FAD89D);
  return loc;
}

_id_60F98C8A87343B13(script_parameters) {
  foreach(interaction in level._id_22AEC2980D9D69FE) {
    if(interaction.script_parameters == script_parameters)
      return interaction;
  }

  return undefined;
}

_id_4AD5CA29D93F1F6F(icon) {
  offset = 80;

  if(!isDefined(icon))
    icon = "hud_icon_survival_killstreak_small";

  self.headicon = self._id_8206B98791E7DC20 scripts\cp_mp\entityheadicons::setheadicon_singleimage([], icon, offset, 1, 0, 1, 0, 0, 0, undefined, 1);
  self waittill("stop_obj_icon");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
}

_id_145FC192257F34E8() {
  _id_F961E156FC3BFAC8("incursion_airstrike", undefined, "hud_icon_killstreak_airstrike");
  _id_F961E156FC3BFAC8("incursion_cruise_missile", undefined, "hud_icon_killstreak_cruise_missile");
  _id_F961E156FC3BFAC8("incursion_armor", undefined, "hud_icon_loot_armor", ::_id_62D363D67DCE589B);
}

_id_F961E156FC3BFAC8(_id_E91C88DE8CB8AFB9, hint_string, head_icon, _id_FF4FA73526CABB40, destroyoncapture, onecaptureperplayer) {
  data = spawnStruct();
  data._id_E91C88DE8CB8AFB9 = _id_E91C88DE8CB8AFB9;

  if(!isDefined(hint_string))
    hint_string = &"MP/ESC_CACHE_USE_HINT";

  data.hint_string = hint_string;

  if(!isDefined(head_icon))
    head_icon = "hud_icon_killstreak_airstrike";

  data.head_icon = head_icon;

  if(!isDefined(_id_FF4FA73526CABB40))
    _id_FF4FA73526CABB40 = ::_id_74B0C07BBDBB9242;

  data._id_FF4FA73526CABB40 = _id_FF4FA73526CABB40;
  _id_7FD93655274F3927(data, destroyoncapture, onecaptureperplayer);
}

_id_7FD93655274F3927(data, destroyoncapture, onecaptureperplayer) {
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata(data._id_E91C88DE8CB8AFB9);
  _id_962A30A9BB8C0F09.capturestring = data.hint_string;
  _id_962A30A9BB8C0F09.enemymodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = data.head_icon;
  _id_962A30A9BB8C0F09.usepriority = -10000;
  _id_962A30A9BB8C0F09.timeout = 90;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.activatecallback = scripts\cp\killstreaks\airdrop_cp::cpoperationcrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = data._id_FF4FA73526CABB40;
  _id_962A30A9BB8C0F09.destroyoncapture = istrue(destroyoncapture);
  _id_962A30A9BB8C0F09.onecaptureperplayer = istrue(onecaptureperplayer);
  _id_962A30A9BB8C0F09.halfheight = 55;
  _id_962A30A9BB8C0F09.heliheightoffset = 12000;
}

_id_62D363D67DCE589B(player) {
  if(istrue(player.inlaststand)) {
    return;
  }
  if(!isDefined(self.numuses))
    self.numuses = 0;

  if(!isDefined(self.playersused))
    self.playersused = [];

  if(player.armorqueued >= 5) {
    return;
  }
  self.playersused[self.playersused.size] = player;

  if(isDefined(self.customusefunc)) {
    self thread[[self.customusefunc]](player);
    return;
  }

  player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(5);
  player playlocalsound("weap_ammo_pickup");
  self.numuses++;
  _id_7A29E8BE2CB8D2DE = level.players.size;

  if(self.numuses >= _id_7A29E8BE2CB8D2DE) {
    if(isDefined(self.outlines)) {
      foreach(outline in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](outline, self);
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

_id_74B0C07BBDBB9242(player) {
  if(istrue(player.inlaststand)) {
    return;
  }
  if(!isDefined(self.numuses))
    self.numuses = 0;

  if(!isDefined(self.playersused))
    self.playersused = [];

  self.playersused[self.playersused.size] = player;

  if(isDefined(self.customusefunc)) {
    self thread[[self.customusefunc]](player);
    return;
  }

  player playlocalsound("weap_ammo_pickup");
  _id_03C5C969FF02785D = ["precision_airstrike", "juggernaut", "cruise_missile", "cluster_strike"];

  if(isDefined(self.random_loot_override))
    _id_03C5C969FF02785D = self.random_loot_override;

  _id_33EC29F42729AF36 = scripts\engine\utility::random(_id_03C5C969FF02785D);
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
    return;
  }

  if(_id_33EC29F42729AF36 == "sentry_turret")
    player scripts\cp\loot_system::try_give_munition_to_slot(_id_33EC29F42729AF36, _id_6E1EC6F2C0EE6B2C, "sentry_turret");
  else if(_id_33EC29F42729AF36 == "airstrike")
    player scripts\cp\loot_system::try_give_munition_to_slot(_id_33EC29F42729AF36, _id_6E1EC6F2C0EE6B2C, "precision_airstrike");
  else if(_id_33EC29F42729AF36 == "cluster_strike")
    player scripts\cp\loot_system::try_give_munition_to_slot(_id_33EC29F42729AF36, _id_6E1EC6F2C0EE6B2C, "cluster_strike");
  else
    player scripts\cp\loot_system::try_give_munition_to_slot(_id_33EC29F42729AF36, _id_6E1EC6F2C0EE6B2C);

  self.numuses++;
  _id_7A29E8BE2CB8D2DE = level.players.size;
  _id_7A29E8BE2CB8D2DE = 1;

  if(self.numuses >= _id_7A29E8BE2CB8D2DE) {
    if(isDefined(self.outlines)) {
      foreach(outline in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](outline, self);
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}