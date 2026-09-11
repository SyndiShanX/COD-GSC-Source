/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_armor.gsc
***********************************************/

function show_damage_direction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = var_0.health;
  var_0 finishplayerdamage(var_1, var_2, 1, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  var_0.health = var_14;
}

function do_damage_to_player_armor(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(var_3 > 0) {
    show_damage_direction(var_0, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  }

  var_3 /= 5;
  var_14 = get_player_armor_amount(var_0);
  var_15 = min(var_14, var_3);
  var_16 = var_14 - var_15;
  set_armor(var_0);
  broadcast_armor(var_0, var_16);

  if(isDefined(var_2) && isPlayer(var_2)) {
    var_2 scripts\cp\cp_damagefeedback::updatehitmarker("cp_hitmarker_armor", 0, var_3, 1, 0);
  }

  var_17 = int(var_3 - var_15);

  if(var_14 > 0) {
    play_armor_sfx(var_0, var_2, var_17);
  }

  return var_17;
}

function set_armor(var_0, var_1) {
  var_2 = 100;
  var_3 = getdvarint("scr_armor_max", 0);

  if(var_3) {
    var_2 = var_3;
  }

  var_0.armor = var_1 / var_2;
}

function damage_armored_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_0.perk_data)) {
    var_3 = var_3 / 5 / var_0.perk_data["enemy_damage_to_player_armor_scalar"];
  } else {
    var_3 /= 5;
  }

  var_14 = get_player_armor_amount(var_0);
  var_15 = min(var_14, var_3);
  var_16 = var_14 - var_15;

  if(isDefined(var_2) && isPlayer(var_2)) {
    var_2 scripts\cp\cp_damagefeedback::updatehitmarker("cp_hitmarker_armor", 0, var_3, 1, 0);
  }

  var_17 = int(var_3 - var_15);
  set_armor(var_0, var_16);
  broadcast_armor(var_0, var_16);
  play_armor_sfx(var_0, var_2, var_16);

  if(var_16 <= 0) {
    remove_player_armor(var_0);
  }

  return var_17;
}

function play_impact_fx_on_players(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, "x", randomfloatrange(0, 1));
}

function createscreeneffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newclienthudelem(self);
  var_6.sort = 12;
  var_6.foreground = 0;
  var_6.horzalign = "fullscreen";
  var_6.vertalign = "fullscreen";
  var_6.alpha = 0;
  var_6.enablehudlighting = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = scripts\engine\math::factor_value(0.9, 1.25, var_4["scale"]);

  switch (var_0) {
    case "left":
      var_6.aligny = "top";
      var_6.alignx = "left";
      var_7 = -640;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(-55, 0, var_4["x"]);
      break;
    case "right":
      var_6.aligny = "top";
      var_6.alignx = "right";
      var_7 = 1280;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["y"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(0, 55, var_4["x"]) + 640;
      break;
    case "bottom":
      var_6.aligny = "bottom";
      var_6.alignx = "left";
      var_8 = 960;
      var_7 = scripts\engine\math::factor_value(-15, 15, var_4["x"]);
      var_10 = scripts\engine\math::factor_value(0, 0, var_4["y"]);
      var_10 += 480;
      break;
  }

  var_6.x = var_7;
  var_6.y = var_8;
  var_6 setshader(var_1, 640, 480);
  thread screeneffectcleanup(var_6);
  thread animatescreeneffect(var_6, var_2, var_3, var_9, var_10, var_11, var_5);
}

function animatescreeneffect(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 = 1;
  var_0 endon("destroySreenEffectOverlay");

  if(!var_6) {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0 moveovertime(var_1);
    var_0.x = var_3;
    var_0.y = var_4;
    var_1 = 0.05;
    var_0.alpha = 1;
    wait 0.05;
  } else {
    var_0 scaleovertime(var_1, int(640 * var_5), int(480 * var_5));
    var_0.x = var_3;
    var_0.y = var_4;
    wait 0.15;
    var_0 fadeovertime(var_1);
    var_0.alpha = 1;
    wait var_1;
  }

  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait var_2 + 0.05;
  var_0 notify("destroySreenEffectOverlay");
}

function screeneffectcleanup(var_0) {
  var_0 waittill("destroySreenEffectOverlay");
  self.shoulddisplayhud = 1;
  var_0 destroy();
}

function armor_resistance_to_type(var_0, var_1, var_2, var_3) {
  if(var_0 == "MOD_FALLING") {
    return false;
  }

  if(var_0 == "MOD_TRIGGER_HURT") {
    return false;
  }

  if(var_0 == "MOD_FIRE" && !istrue(var_2.stack_patch_waittill_context_far_patch)) {
    return false;
  }

  switch (var_1.basename) {
    case "white_phosphorus_proj_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
      return false;
  }

  if(isDefined(var_3) && istrue(var_3.calloutmarkerpingvo_play)) {
    return false;
  }

  return true;
}

function play_armor_sfx(var_0, var_1, var_2) {
  var_3 = "cp_hit_indication_armor";

  if(var_2 < 0) {
    var_3 = "plr_armor_gone";
  }

  if(isPlayer(var_0)) {
    var_0 playlocalsound(var_3);
  }

  if(isPlayer(var_1)) {
    var_1 playlocalsound(var_3);
    return;
  }
}

function has_armor(var_0) {
  if(get_player_armor_amount(var_0) > 0) {
    return true;
  }

  return false;
}

function get_player_armor_amount(var_0) {
  var_1 = 100;
  var_2 = getdvarint("scr_armor_max", 0);

  if(var_2) {
    var_1 = var_2;
  }

  return int(var_0.armor * var_1);
}

function broadcast_armor(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = int(var_1);
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var_2, "playerArmor", var_3);
}

function update_player_model(var_0, var_1) {
  if(istrue(var_0)) {
    setcharactermodels(var_1, "body_mp_western_fireteam_west_ar_1_1_lod1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
    return;
  }

  setcharactermodels(var_1, "head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
}

function setcharactermodels(var_0, var_1, var_2, var_3) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self.bodymodel = var_0;
  self setModel(var_0);
  self setviewmodel(var_2);

  if(isDefined(var_1)) {
    self attach(var_1, "", 1);
    self.headmodel = var_1;
  }

  if(isDefined(var_3)) {
    self attach(var_3, "", 1);
    self.hairmodel = var_3;
    return;
  }
}

function pick_up_armor_vest(var_0, var_1) {
  if(player_have_full_armor(var_1)) {
    return;
  }

  var_0.model delete();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_2 = 100;
  var_3 = getdvarint("scr_armor_max", 0);

  if(var_3) {
    var_2 = var_3;
  }

  givearmor(var_1, var_2);
}

function givearmor(var_0, var_1, var_2) {
  if(player_have_full_armor(var_0)) {
    return;
  }

  var_3 = var_0 getentitynumber();
  setomnvar("ui_armor_gained", var_3);
  var_2 = istrue(var_2);

  if(!var_2) {
    var_0 scripts\common\utility::allow_ads(0, "armor");
    var_0 scripts\common\utility::allow_fire(0, "armor");
    var_0 scripts\common\utility::allow_melee(0, "armor");
    var_0 cancelreload();

    if(!isDefined(var_0.carryobject)) {
      var_0 forceplaygestureviewmodel("ges_vest_replace", undefined, 0.3);
    } else {
      var_2 = 1;
    }
  }

  thread updatearmorvestui();

  if(!var_2) {
    wait var_0 getgestureanimlength("ges_vest_replace");
    var_0 playlocalsound("plr_armor_salvage");
  }

  var_0 notify("armorUseSuccess");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night");
  } else {
    visionsetpain("damage_armor");
  }

  broadcast_armor(var_0, var_1);
  var_1 /= 100;

  if(!var_2) {
    var_0 stopgestureviewmodel("ges_vest_replace", 0.45);
    var_0 scripts\common\utility::allow_ads(1, "armor");
    var_0 scripts\common\utility::allow_fire(1, "armor");
    var_0 scripts\common\utility::allow_melee(1, "armor");
  }

  var_0.armor = var_1;
}

function player_have_armor(var_0) {
  return var_0.armor > 0;
}

function player_have_full_armor(var_0) {
  var_1 = 100;
  var_2 = getdvarint("scr_armor_max", 0);

  if(var_2) {
    var_1 = var_2;
  }

  return int(var_0.armor * var_1) == var_1;
}

function armor_vest_hint_func(var_0, var_1) {
  if(player_have_full_armor(var_1)) {
    return &"COOP_CRAFTING/ARMOR_FULL";
  }

  return &"COOP_CRAFTING/ARMOR_TAKE";
}

function updatearmorvestmodel() {
  self endon("armorUseSuccess");
  self endon("disconnect");
  self endon("death");
  wait 0.5;
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("loot_armor");
  var_0 notsolid();
  self playerlinktodelta(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("armorUseCancel", 1.2);
  self unlink();
  var_0 delete();
}

function armorbreak(var_0) {
  self shellshock("armor_gone", 2.5);
  earthquake(0.3, 0.65, var_0, 5000);
  self viewkick(127, self.origin, 0);
}

function updatearmorvestui() {
  self endon("armorUseCancel");
  self endon("armorUseSuccess");
  var_0 = gettime();
  var_1 = self getgestureanimlength("ges_vest_replace");

  for(;;) {
    var_2 = gettime() - var_0;
    var_3 = var_2 / var_1 * 1000;
    waitframe();
  }
}

function armorinit(var_0) {
  var_0.armor = 0;
}

function remove_player_armor(var_0) {
  var_0.armor = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night", 0);
  } else {
    visionsetpain("pain_mp", 0);
  }

  var_0 playsoundtoplayer("hit_marker_3d_armor_break", var_0);
  var_0 setscriptablepartstate("armor_break", "armor_break", 0);
}

function can_update_player_armor_model(var_0) {
  if(isDefined(var_0.can_update_player_armor_model) && var_0.can_update_player_armor_model == 0) {
    return false;
  }

  return true;
}

function set_can_update_player_armor_model(var_0, var_1) {
  var_0.can_update_player_armor_model = var_1;
}