/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1a2df709fb4376c3.gsc
***********************************************/

_id_4C788DBD41C27B31() {
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata("hardpoint_crates");
  _id_962A30A9BB8C0F09.capturestring = &"MP/ESC_CACHE_USE_HINT";
  _id_962A30A9BB8C0F09.enemymodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = "hud_icon_head_killstreak_carepackage";
  _id_962A30A9BB8C0F09.usepriority = -10000;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.activatecallback = scripts\cp\killstreaks\airdrop_cp::cpoperationcrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_89661CCC8EB84DE5;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09.onecaptureperplayer = 0;
  _id_962A30A9BB8C0F09.halfheight = 55;
  _id_962A30A9BB8C0F09.heliheightoffset = 12000;
}

_id_01DA53F64473F739() {
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata("hardpoint_crates");
  _id_962A30A9BB8C0F09.capturestring = &"MP/ESC_CACHE_USE_HINT";
  _id_962A30A9BB8C0F09.enemymodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = "hud_icon_head_killstreak_carepackage";
  _id_962A30A9BB8C0F09.usepriority = -10000;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.activatecallback = scripts\cp\killstreaks\airdrop_cp::cpoperationcrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_89661CCC8EB84DE5;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09.onecaptureperplayer = 0;
  _id_962A30A9BB8C0F09.halfheight = 55;
  _id_962A30A9BB8C0F09.heliheightoffset = 12000;
}

_id_89661CCC8EB84DE5(player) {
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

  _id_B0E4447B9140A34E = scripts\engine\utility::getStructArray("hardpoint_airdrop_loot", "targetname");
  _id_B0E4447B9140A34E = scripts\engine\utility::get_array_of_closest(self.origin, _id_B0E4447B9140A34E, undefined, undefined, 200);
  _id_0375A46DD21266CC = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B0E4447B9140A34E.size; _id_AC0E594AC96AA3A8++) {
    loc = _id_B0E4447B9140A34E[_id_AC0E594AC96AA3A8];
    _id_8058E47866D8AC53 = spawn("script_model", loc.origin);
    _id_8058E47866D8AC53.angles = loc.angles;
    _id_8058E47866D8AC53 setModel("military_loot_crate_01_cp_striped");
    num = _id_8058E47866D8AC53 getentitynumber();
    _id_8058E47866D8AC53.targetname = "buy_station_" + num;
    _id_4A97BF4DD0C4CFB3 = spawnStruct();
    _id_4A97BF4DD0C4CFB3.origin = loc.origin + (0, 0, 30);
    _id_4A97BF4DD0C4CFB3.angles = loc.angles;
    _id_EEE1CD3B8A152699 = _id_BEEF9A7D1698B0A1(loc);

    if(!isDefined(_id_EEE1CD3B8A152699)) {} else if(_id_EEE1CD3B8A152699 == "equipment") {
      _id_4A97BF4DD0C4CFB3.script_noteworthy = "interact_equipmentbuy";
      _id_4A97BF4DD0C4CFB3.equipment = loc.script_noteworthy;
    } else if(_id_EEE1CD3B8A152699 == "perk") {
      _id_4A97BF4DD0C4CFB3.script_noteworthy = "interact_perkbuy";
      _id_4A97BF4DD0C4CFB3.perk = loc.perk;
      _id_4A97BF4DD0C4CFB3.headicon = loc.headicon;
      _id_8058E47866D8AC53 setModel("military_loot_crate_01_cp_yellow");
    } else if(_id_EEE1CD3B8A152699 == "killstreak") {
      _id_4A97BF4DD0C4CFB3.script_noteworthy = "interact_killstreakbuy";
      _id_4A97BF4DD0C4CFB3._id_F406BE343AB9CC93 = loc.script_noteworthy;
      _id_4A97BF4DD0C4CFB3.headicon = loc.headicon;
    } else {
      _id_4A97BF4DD0C4CFB3.script_noteworthy = "interact_weaponbuy";
      _id_4A97BF4DD0C4CFB3.weapon = loc.script_noteworthy;
      _id_4A97BF4DD0C4CFB3.headicon = loc.headicon;
      _id_8058E47866D8AC53 setModel("military_loot_crate_01_cp_white");
    }

    if(isDefined(loc.attachments))
      _id_4A97BF4DD0C4CFB3.attachments = loc.attachments;

    _id_4A97BF4DD0C4CFB3.targetname = "interaction";
    _id_4A97BF4DD0C4CFB3.target = _id_8058E47866D8AC53.targetname;
    _id_0375A46DD21266CC[_id_0375A46DD21266CC.size] = _id_4A97BF4DD0C4CFB3;
  }

  _id_780514F14B1134ED::_id_22D4DBFE8C0A69D2(_id_0375A46DD21266CC);

  foreach(struct in _id_0375A46DD21266CC)
  _id_71332A5B74214116::add_to_current_interaction_list(struct);

  self.numuses++;
  maxuses = 1;

  if(self.numuses >= maxuses) {
    if(isDefined(self.outlines)) {}
  }

  foreach(player in level.players)
  player _id_780514F14B1134ED::_id_0E4D346D9043BEA4();
}

_id_BEEF9A7D1698B0A1(loc) {
  if(isDefined(loc.perk))
    return "perk";

  if(isDefined(loc.equipment))
    return "equipment";

  if(isDefined(loc.script_noteworthy)) {
    switch (loc.script_noteworthy) {
      case "halligan":
      case "equip_ascender":
      case "c4_inc_breach":
      case "equip_nvgs":
      case "gasmask":
      case "ammo":
      case "self_revive":
      case "armor":
        return "equipment";
      case "hover_jet":
      case "precision_airstrike":
        return "killstreak";
      case "recon_drone":
        return "perk";
      default:
        return "weapon";
    }
  }

  return undefined;
}

_id_CFC9C471DD3DA7A0() {
  wait 10;
  register_hack_spot_interaction();
  _id_22C6386E9B094F2D = scripts\engine\utility::getStructArray("comp_interact", "targetname");

  foreach(interaction in _id_22C6386E9B094F2D)
  create_final_hack_spot_interaction(interaction, 0);
}

create_final_hack_spot_interaction(_id_03B819B9C304F403, index) {
  interaction = spawnStruct();
  interaction.origin = _id_03B819B9C304F403.origin;
  interaction.targetname = "interaction";
  interaction.script_noteworthy = "hardpoint_airdrop";

  if(isDefined(_id_03B819B9C304F403.script_noteworthy))
    interaction.script_parameters = _id_03B819B9C304F403.script_noteworthy;

  if(isDefined(_id_03B819B9C304F403.radius))
    interaction.radius = _id_03B819B9C304F403.radius;

  interaction.requires_power = 0;
  interaction.spend_type = "null";

  if(isDefined(_id_03B819B9C304F403.target)) {
    model_spot = scripts\engine\utility::getStruct(_id_03B819B9C304F403.target, "targetname");
    interaction.model = spawn("script_model", model_spot.origin);
    interaction.model setModel("device_laptop_01_open");

    if(!isDefined(model_spot.angles))
      _id_8F14D642A91D2DBB = (0, 0, 0);
    else
      _id_8F14D642A91D2DBB = model_spot.angles;

    interaction.model.angles = _id_8F14D642A91D2DBB;
  } else {
    interaction.model = spawn("script_model", _id_03B819B9C304F403.origin);
    interaction.model setModel("tag_origin");
    interaction.model.angles = (0, 0, 0);
  }

  interaction.cost = 0;
  _id_71332A5B74214116::add_to_current_interaction_list(interaction);
  return interaction;
}

register_hack_spot_interaction() {
  _id_71332A5B74214116::registerinteraction("hardpoint_airdrop", ::final_hack_spot_hint, ::final_hack_spot_activate, undefined, 0);
}

final_hack_spot_hint(_id_DF071553D0996FF9, player) {
  return &"CP_STRIKE/RETRIEVE_INTEL";
}

final_hack_spot_activate(_id_DF071553D0996FF9, player) {
  player endon("disconnect");
  radius = 1000;

  if(isDefined(_id_DF071553D0996FF9.radius))
    radius = _id_DF071553D0996FF9.radius;

  _id_4229C104BB77F903 = scripts\engine\utility::getStructArray("hardpoint_airdrop_loot_spot", "targetname");
  _id_E0CBA2B0A5510D09 = scripts\engine\utility::getclosest(_id_DF071553D0996FF9.origin, _id_4229C104BB77F903, radius);
  level thread _id_7592E1A8FDAA737C(_id_DF071553D0996FF9);
  level thread _id_7F3DCDD10D9F4895::dropcarepackage(_id_E0CBA2B0A5510D09, undefined, "hardpoint_crates");
  _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
  player _id_65CA1841764C00CA::_id_7F0C6C1DA2C42B0B();

  if(isDefined(_id_DF071553D0996FF9.script_parameters))
    level notify("hardpoint_airdrop_activated", _id_DF071553D0996FF9.script_parameters);
  else
    level notify("hardpoint_airdrop_activated");
}

_id_7C1537DB88DEAED9(origin, _id_410BB22360073358) {
  radius = 1000;

  if(isDefined(_id_410BB22360073358))
    radius = _id_410BB22360073358;

  _id_4229C104BB77F903 = scripts\engine\utility::getStructArray("hardpoint_airdrop_loot_spot", "targetname");
  _id_E0CBA2B0A5510D09 = scripts\engine\utility::getclosest(origin, _id_4229C104BB77F903, radius);
  level thread _id_7F3DCDD10D9F4895::dropcarepackage(_id_E0CBA2B0A5510D09, undefined, "hardpoint_crates");
}

_id_79CB650E92BAD6CA(origin, _id_410BB22360073358) {
  radius = 1000;

  if(isDefined(_id_410BB22360073358))
    radius = _id_410BB22360073358;

  _id_4229C104BB77F903 = scripts\engine\utility::getStructArray("hardpoint_airdrop_loot_spot", "targetname");
  _id_E0CBA2B0A5510D09 = scripts\engine\utility::getclosest(origin, _id_4229C104BB77F903, radius);
  return _id_E0CBA2B0A5510D09;
}

_id_7592E1A8FDAA737C(_id_DF071553D0996FF9) {
  wait 0.5;
  _id_DF071553D0996FF9.model delete();
}

_id_738392462575F8E9() {
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/FOUND_INTEL");
  wait 1.5;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/SENDING_EQUIP");
}

_id_06652D8F3D9CC153(script_parameters) {
  for(;;) {
    level waittill("hardpoint_airdrop_activated", _id_CE1A5767F9316273);

    if(isDefined(_id_CE1A5767F9316273) && _id_CE1A5767F9316273 == script_parameters) {
      break;
    }
  }
}