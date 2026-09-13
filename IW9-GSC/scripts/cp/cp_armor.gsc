/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_armor.gsc
***********************************************/

show_damage_direction(player, einflictor, attacker, _id_763565CB1EBE7F95, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname) {
  original_health = player.health;
  player finishplayerdamage(einflictor, attacker, 1, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname);
  player.health = original_health;
}

do_damage_to_player_armor(player, einflictor, attacker, _id_763565CB1EBE7F95, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname) {
  if(_id_763565CB1EBE7F95 > 0)
    player show_damage_direction(player, einflictor, attacker, _id_763565CB1EBE7F95, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname);

  _id_763565CB1EBE7F95 = _id_763565CB1EBE7F95 / 10;
  _id_CDC6CC34B279F409 = get_player_armor_amount(player);
  _id_FB6F10D7080ED490 = min(_id_CDC6CC34B279F409, _id_763565CB1EBE7F95);
  _id_7AEBECFC2EE6CF02 = _id_CDC6CC34B279F409 - _id_FB6F10D7080ED490;
  set_armor(player);
  broadcast_armor(player, _id_7AEBECFC2EE6CF02);

  if(isDefined(attacker) && isPlayer(attacker))
    attacker _id_354C862768CFE202::updatehitmarker("cp_hitmarker_armor", 0, _id_763565CB1EBE7F95, 1, 0);

  _id_5BAD2A552DA00704 = int(_id_763565CB1EBE7F95 - _id_FB6F10D7080ED490);

  if(_id_CDC6CC34B279F409 > 0)
    play_armor_sfx(player, attacker, _id_5BAD2A552DA00704);

  return _id_5BAD2A552DA00704;
}

set_armor(player, _id_7AEBECFC2EE6CF02) {
  _id_C791EAD1F39669F4 = 100;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  player.armor = _id_7AEBECFC2EE6CF02 / _id_C791EAD1F39669F4;
}

damage_armored_player(player, einflictor, attacker, _id_763565CB1EBE7F95, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname) {
  if(isDefined(player.perk_data))
    _id_763565CB1EBE7F95 = _id_763565CB1EBE7F95 / 10 / player.perk_data["enemy_damage_to_player_armor_scalar"];
  else
    _id_763565CB1EBE7F95 = _id_763565CB1EBE7F95 / 10;

  _id_CDC6CC34B279F409 = get_player_armor_amount(player);
  _id_FB6F10D7080ED490 = min(_id_CDC6CC34B279F409, _id_763565CB1EBE7F95);
  _id_7AEBECFC2EE6CF02 = _id_CDC6CC34B279F409 - _id_FB6F10D7080ED490;

  if(isDefined(attacker) && isPlayer(attacker))
    attacker _id_354C862768CFE202::updatehitmarker("cp_hitmarker_armor", 0, _id_763565CB1EBE7F95, 1, 0);

  _id_5BAD2A552DA00704 = int(_id_763565CB1EBE7F95 - _id_FB6F10D7080ED490);
  set_armor(player, _id_7AEBECFC2EE6CF02);
  broadcast_armor(player, _id_7AEBECFC2EE6CF02);
  play_armor_sfx(player, attacker, _id_7AEBECFC2EE6CF02);

  if(_id_7AEBECFC2EE6CF02 <= 0)
    remove_player_armor(player);

  return _id_5BAD2A552DA00704;
}

play_impact_fx_on_players(position, player) {
  _id_6A78028DC80D36FE = [];
  _id_6A78028DC80D36FE["x"] = randomfloatrange(0, 1);
  _id_6A78028DC80D36FE["y"] = randomfloatrange(0, 1);
  _id_6A78028DC80D36FE["scale"] = randomfloatrange(0, 1);

  if(!isDefined(player.shoulddisplayhud))
    player.shoulddisplayhud = 1;

  if(!istrue(player.shoulddisplayhud)) {
    return;
  }
  if(player scripts\engine\math::is_point_on_right(position)) {
    player createscreeneffect("right", "fullscreen_armor_right", 0.05, 3.0, _id_6A78028DC80D36FE, 1);
    player createscreeneffect("right", "fullscreen_armor_right_splash", 0.05, 3.0, _id_6A78028DC80D36FE, 1);
  } else {
    player createscreeneffect("left", "fullscreen_armor_left", 0.05, 3.0, _id_6A78028DC80D36FE, 1);
    player createscreeneffect("left", "fullscreen_armor_left_splash", 0.05, 3.0, _id_6A78028DC80D36FE, 1);
  }

  player.shoulddisplayhud = 0;
}

createscreeneffect(_id_A66BA9B157533F5A, shader, _id_187EF7FAE5A4F6F3, _id_D75DFE2C8B34F282, _id_6A78028DC80D36FE, _id_F100EBBBD2F636FC) {
  hud = newclienthudelem(self);
  hud.sort = 12;
  hud.foreground = 0;
  hud.horzalign = "fullscreen";
  hud.vertalign = "fullscreen";
  hud.alpha = 0;
  hud.enablehudlighting = 1;
  x = 0;
  y = 0;
  _id_BA8D59C006AB07C1 = 0;
  _id_BA8D58C006AB058E = 0;
  _id_91180BE623F6B59B = scripts\engine\math::factor_value(0.9, 1.25, _id_6A78028DC80D36FE["scale"]);

  switch (_id_A66BA9B157533F5A) {
    case "left":
      hud.aligny = "top";
      hud.alignx = "left";
      x = -640;
      y = scripts\engine\math::factor_value(-30, 30, _id_6A78028DC80D36FE["y"]);
      _id_BA8D58C006AB058E = y;
      _id_BA8D59C006AB07C1 = scripts\engine\math::factor_value(-55, 0, _id_6A78028DC80D36FE["x"]);
      break;
    case "right":
      hud.aligny = "top";
      hud.alignx = "right";
      x = 1280;
      y = scripts\engine\math::factor_value(-30, 30, _id_6A78028DC80D36FE["y"]);
      _id_BA8D58C006AB058E = y;
      _id_BA8D59C006AB07C1 = scripts\engine\math::factor_value(0, 55, _id_6A78028DC80D36FE["x"]) + 640;
      break;
    case "bottom":
      hud.aligny = "bottom";
      hud.alignx = "left";
      y = 960;
      x = scripts\engine\math::factor_value(-15, 15, _id_6A78028DC80D36FE["x"]);
      _id_BA8D58C006AB058E = scripts\engine\math::factor_value(0, 0, _id_6A78028DC80D36FE["y"]);
      _id_BA8D58C006AB058E = _id_BA8D58C006AB058E + 480;
      break;
  }

  hud.x = x;
  hud.y = y;
  hud setshader(shader, 640, 480);
  thread screeneffectcleanup(hud);
  thread animatescreeneffect(hud, _id_187EF7FAE5A4F6F3, _id_D75DFE2C8B34F282, _id_BA8D59C006AB07C1, _id_BA8D58C006AB058E, _id_91180BE623F6B59B, _id_F100EBBBD2F636FC);
}

animatescreeneffect(hud, _id_187EF7FAE5A4F6F3, _id_D75DFE2C8B34F282, x, y, scale, _id_F100EBBBD2F636FC) {
  scale = 1;
  hud endon("destroySreenEffectOverlay");

  if(!_id_F100EBBBD2F636FC) {
    hud scaleovertime(_id_187EF7FAE5A4F6F3, int(640 * scale), int(480 * scale));
    hud moveovertime(_id_187EF7FAE5A4F6F3);
    hud.x = x;
    hud.y = y;
    _id_187EF7FAE5A4F6F3 = 0.05;
    hud.alpha = 1;
    wait 0.05;
  } else {
    hud scaleovertime(_id_187EF7FAE5A4F6F3, int(640 * scale), int(480 * scale));
    hud.x = x;
    hud.y = y;
    wait 0.15;
    hud fadeovertime(_id_187EF7FAE5A4F6F3);
    hud.alpha = 1;
    wait(_id_187EF7FAE5A4F6F3);
  }

  hud fadeovertime(_id_D75DFE2C8B34F282);
  hud.alpha = 0;
  wait(_id_D75DFE2C8B34F282 + 0.05);
  hud notify("destroySreenEffectOverlay");
}

screeneffectcleanup(hud) {
  hud waittill("destroySreenEffectOverlay");
  self.shoulddisplayhud = 1;
  hud destroy();
}

armor_resistance_to_type(type, objweapon, einflictor, eattacker) {
  if(type == "MOD_FALLING")
    return 0;

  if(type == "MOD_TRIGGER_HURT")
    return 0;

  if(type == "MOD_FIRE" && !istrue(einflictor.ignore_fire_armor_check))
    return 0;

  switch (objweapon.basename) {
    case "white_phosphorus_proj_mp":
    case "gunship_25mm_mp":
    case "gunship_hellfire_mp":
    case "gunship_40mm_mp":
    case "gunship_105mm_mp":
      return 0;
  }

  if(isDefined(eattacker) && istrue(eattacker.armor_piercing))
    return 0;

  return 1;
}

play_armor_sfx(player, attacker, _id_7AEBECFC2EE6CF02) {
  alias = "cp_hit_indication_armor";

  if(_id_7AEBECFC2EE6CF02 < 0)
    alias = "plr_armor_gone";

  if(isPlayer(player))
    player playlocalsound(alias);

  if(isPlayer(attacker))
    attacker playlocalsound(alias);
}

has_armor(player) {
  if(get_player_armor_amount(player) > 0)
    return 1;

  return 0;
}

get_player_armor_amount(player) {
  _id_C791EAD1F39669F4 = 100;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  return int(player.armor * _id_C791EAD1F39669F4);
}

broadcast_armor(player, amount) {
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  armor = int(amount);
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerArmor", armor);
}

update_player_model(_id_AA796102B09BD2A7, player) {
  if(istrue(_id_AA796102B09BD2A7))
    player setcharactermodels("body_mp_western_fireteam_west_ar_1_1_lod1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
  else
    player setcharactermodels("head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
}

setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2, hairmodel) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self.bodymodel = bodymodelname;
  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }

  if(isDefined(hairmodel)) {
    self attach(hairmodel, "", 1);
    self.hairmodel = hairmodel;
  }
}

pick_up_armor_vest(_id_DF071553D0996FF9, player) {
  if(player_have_full_armor(player)) {
    return;
  }
  _id_DF071553D0996FF9.model delete();
  _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
  _id_C791EAD1F39669F4 = 100;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  givearmor(player, _id_C791EAD1F39669F4);
}

givearmor(player, armoramount, _id_CF0A9D02644669AC) {
  if(player_have_full_armor(player)) {
    return;
  }
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  setomnvar("ui_armor_gained", _id_1DAB4A6BAD01C509);
  _id_CF0A9D02644669AC = istrue(_id_CF0A9D02644669AC);

  if(!_id_CF0A9D02644669AC) {
    player _id_3B64EB40368C1450::set("armor", "ads", 0);
    player _id_3B64EB40368C1450::set("armor", "fire", 0);
    player _id_3B64EB40368C1450::set("armor", "melee", 0);
    player cancelreload();

    if(!isDefined(player.carryobject))
      player forceplaygestureviewmodel("ges_vest_replace", undefined, 0.3);
    else
      _id_CF0A9D02644669AC = 1;
  }

  player thread updatearmorvestui();

  if(!_id_CF0A9D02644669AC) {
    wait(player getgestureanimlength("ges_vest_replace"));
    player playlocalsound("plr_armor_salvage");
  }

  player notify("armorUseSuccess");
  broadcast_armor(player, armoramount);

  if(!_id_CF0A9D02644669AC) {
    player stopgestureviewmodel("ges_vest_replace", 0.45);
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("armor");
  }

  player.armorhealth = armoramount;
}

player_have_armor(player) {
  return player.armor > 0;
}

player_have_full_armor(player) {
  _id_C791EAD1F39669F4 = player._id_8790C077C95DB752;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  return int(player.armorhealth * _id_C791EAD1F39669F4) == _id_C791EAD1F39669F4;
}

armor_vest_hint_func(_id_DF071553D0996FF9, player) {
  if(player_have_full_armor(player))
    return &"COOP_CRAFTING/ARMOR_FULL";
  else
    return &"COOP_CRAFTING/ARMOR_TAKE";
}

updatearmorvestmodel() {
  self endon("armorUseSuccess");
  self endon("disconnect");
  self endon("death");
  wait 0.5;
  model = spawn("script_model", self.origin);
  model setModel("loot_armor");
  model notsolid();
  self playerlinktodelta(model);
  scripts\engine\utility::waittill_notify_or_timeout("armorUseCancel", 1.2);
  self unlink();
  model delete();
}

armorbreak(point) {
  self shellshock("armor_gone", 2.5);
  earthquake(0.3, 0.65, point, 5000);
  self viewkick(127, self.origin, 0);
}

updatearmorvestui() {
  self endon("armorUseCancel");
  self endon("armorUseSuccess");
  starttime = gettime();
  _id_EB73C9282CF50F49 = self getgestureanimlength("ges_vest_replace");

  for(;;) {
    _id_FBD43DA47D8CECDF = gettime() - starttime;
    progress = _id_FBD43DA47D8CECDF / (_id_EB73C9282CF50F49 * 1000);
    waitframe();
  }
}

armorinit(player) {
  player.armor = 0;
}

remove_player_armor(player) {
  player.armor = 0;
  player playsoundtoplayer("hit_marker_armor_break_plr", player);
  player setscriptablepartstate("armor_break", "armor_break", 0);
}

can_update_player_armor_model(player) {
  if(isDefined(player.can_update_player_armor_model) && player.can_update_player_armor_model == 0)
    return 0;

  return 1;
}

set_can_update_player_armor_model(player, value) {
  player.can_update_player_armor_model = value;
}