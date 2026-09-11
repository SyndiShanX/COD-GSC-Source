/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_armor.gsc
***********************************************/

function show_damage_direction(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  var14 = var0.health;
  var0 finishplayerdamage(var1, var2, 1, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  var0.health = var14;
}

function do_damage_to_player_armor(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(var3 > 0) {
    show_damage_direction(var0, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  }

  var3 /= 5;
  var14 = get_player_armor_amount(var0);
  var15 = min(var14, var3);
  var16 = var14 - var15;
  set_armor(var0);
  broadcast_armor(var0, var16);

  if(isDefined(var2) && isPlayer(var2)) {
    var2 scripts\cp\cp_damagefeedback::updatehitmarker("cp_hitmarker_armor", 0, var3, 1, 0);
  }

  var17 = int(var3 - var15);

  if(var14 > 0) {
    play_armor_sfx(var0, var2, var17);
  }

  return var17;
}

function set_armor(var0, var1) {
  var2 = 100;
  var3 = getdvarint("scr_armor_max", 0);

  if(var3) {
    var2 = var3;
  }

  var0.armor = var1 / var2;
}

function damage_armored_player(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  if(isDefined(var0.perk_data)) {
    var3 = var3 / 5 / var0.perk_data["enemy_damage_to_player_armor_scalar"];
  } else {
    var3 /= 5;
  }

  var14 = get_player_armor_amount(var0);
  var15 = min(var14, var3);
  var16 = var14 - var15;

  if(isDefined(var2) && isPlayer(var2)) {
    var2 scripts\cp\cp_damagefeedback::updatehitmarker("cp_hitmarker_armor", 0, var3, 1, 0);
  }

  var17 = int(var3 - var15);
  set_armor(var0, var16);
  broadcast_armor(var0, var16);
  play_armor_sfx(var0, var2, var16);

  if(var16 <= 0) {
    remove_player_armor(var0);
  }

  return var17;
}

function play_impact_fx_on_players(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, "x", randomfloatrange(0, 1));
}

function createscreeneffect(var0, var1, var2, var3, var4, var5) {
  var6 = newclienthudelem(self);
  var6.sort = 12;
  var6.foreground = 0;
  var6.horzalign = "fullscreen";
  var6.vertalign = "fullscreen";
  var6.alpha = 0;
  var6.enablehudlighting = 1;
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = scripts\engine\math::factor_value(0.9, 1.25, var4["scale"]);

  switch (var0) {
    case "left":
      var6.aligny = "top";
      var6.alignx = "left";
      var7 = -640;
      var8 = scripts\engine\math::factor_value(-30, 30, var4["y"]);
      var10 = var8;
      var9 = scripts\engine\math::factor_value(-55, 0, var4["x"]);
      break;
    case "right":
      var6.aligny = "top";
      var6.alignx = "right";
      var7 = 1280;
      var8 = scripts\engine\math::factor_value(-30, 30, var4["y"]);
      var10 = var8;
      var9 = scripts\engine\math::factor_value(0, 55, var4["x"]) + 640;
      break;
    case "bottom":
      var6.aligny = "bottom";
      var6.alignx = "left";
      var8 = 960;
      var7 = scripts\engine\math::factor_value(-15, 15, var4["x"]);
      var10 = scripts\engine\math::factor_value(0, 0, var4["y"]);
      var10 += 480;
      break;
  }

  var6.x = var7;
  var6.y = var8;
  var6 setshader(var1, 640, 480);
  thread screeneffectcleanup(var6);
  thread animatescreeneffect(var6, var2, var3, var9, var10, var11, var5);
}

function animatescreeneffect(var0, var1, var2, var3, var4, var5, var6) {
  var5 = 1;
  var0 endon("destroySreenEffectOverlay");

  if(!var6) {
    var0 scaleovertime(var1, int(640 * var5), int(480 * var5));
    var0 moveovertime(var1);
    var0.x = var3;
    var0.y = var4;
    var1 = 0.05;
    var0.alpha = 1;
    wait 0.05;
  } else {
    var0 scaleovertime(var1, int(640 * var5), int(480 * var5));
    var0.x = var3;
    var0.y = var4;
    wait 0.15;
    var0 fadeovertime(var1);
    var0.alpha = 1;
    wait var1;
  }

  var0 fadeovertime(var2);
  var0.alpha = 0;
  wait var2 + 0.05;
  var0 notify("destroySreenEffectOverlay");
}

function screeneffectcleanup(var0) {
  var0 waittill("destroySreenEffectOverlay");
  self.shoulddisplayhud = 1;
  var0 destroy();
}

function armor_resistance_to_type(var0, var1, var2, var3) {
  if(var0 == "MOD_FALLING") {
    return false;
  }

  if(var0 == "MOD_TRIGGER_HURT") {
    return false;
  }

  if(var0 == "MOD_FIRE" && !istrue(var2.stack_patch_waittill_context_far_patch)) {
    return false;
  }

  switch (var1.basename) {
    case "white_phosphorus_proj_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
      return false;
  }

  if(isDefined(var3) && istrue(var3.calloutmarkerpingvo_play)) {
    return false;
  }

  return true;
}

function play_armor_sfx(var0, var1, var2) {
  var3 = "cp_hit_indication_armor";

  if(var2 < 0) {
    var3 = "plr_armor_gone";
  }

  if(isPlayer(var0)) {
    var0 playlocalsound(var3);
  }

  if(isPlayer(var1)) {
    var1 playlocalsound(var3);
    return;
  }
}

function has_armor(var0) {
  if(get_player_armor_amount(var0) > 0) {
    return true;
  }

  return false;
}

function get_player_armor_amount(var0) {
  var1 = 100;
  var2 = getdvarint("scr_armor_max", 0);

  if(var2) {
    var1 = var2;
  }

  return int(var0.armor * var1);
}

function broadcast_armor(var0, var1) {
  var2 = var0 getentitynumber();
  var3 = int(var1);
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("EoGPlayer", var2, "playerArmor", var3);
}

function update_player_model(var0, var1) {
  if(istrue(var0)) {
    setcharactermodels(var1, "body_mp_western_fireteam_west_ar_1_1_lod1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
    return;
  }

  setcharactermodels(var1, "head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
}

function setcharactermodels(var0, var1, var2, var3) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self.bodymodel = var0;
  self setModel(var0);
  self setviewmodel(var2);

  if(isDefined(var1)) {
    self attach(var1, "", 1);
    self.headmodel = var1;
  }

  if(isDefined(var3)) {
    self attach(var3, "", 1);
    self.hairmodel = var3;
    return;
  }
}

function pick_up_armor_vest(var0, var1) {
  if(player_have_full_armor(var1)) {
    return;
  }

  var0.model delete();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
  var2 = 100;
  var3 = getdvarint("scr_armor_max", 0);

  if(var3) {
    var2 = var3;
  }

  givearmor(var1, var2);
}

function givearmor(var0, var1, var2) {
  if(player_have_full_armor(var0)) {
    return;
  }

  var3 = var0 getentitynumber();
  setomnvar("ui_armor_gained", var3);
  var2 = istrue(var2);

  if(!var2) {
    var0 scripts\common\utility::allow_ads(0, "armor");
    var0 scripts\common\utility::allow_fire(0, "armor");
    var0 scripts\common\utility::allow_melee(0, "armor");
    var0 cancelreload();

    if(!isDefined(var0.carryobject)) {
      var0 forceplaygestureviewmodel("ges_vest_replace", undefined, 0.3);
    } else {
      var2 = 1;
    }
  }

  thread updatearmorvestui();

  if(!var2) {
    wait var0 getgestureanimlength("ges_vest_replace");
    var0 playlocalsound("plr_armor_salvage");
  }

  var0 notify("armorUseSuccess");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night");
  } else {
    visionsetpain("damage_armor");
  }

  broadcast_armor(var0, var1);
  var1 /= 100;

  if(!var2) {
    var0 stopgestureviewmodel("ges_vest_replace", 0.45);
    var0 scripts\common\utility::allow_ads(1, "armor");
    var0 scripts\common\utility::allow_fire(1, "armor");
    var0 scripts\common\utility::allow_melee(1, "armor");
  }

  var0.armor = var1;
}

function player_have_armor(var0) {
  return var0.armor > 0;
}

function player_have_full_armor(var0) {
  var1 = 100;
  var2 = getdvarint("scr_armor_max", 0);

  if(var2) {
    var1 = var2;
  }

  return int(var0.armor * var1) == var1;
}

function armor_vest_hint_func(var0, var1) {
  if(player_have_full_armor(var1)) {
    return &"COOP_CRAFTING/ARMOR_FULL";
  }

  return &"COOP_CRAFTING/ARMOR_TAKE";
}

function updatearmorvestmodel() {
  self endon("armorUseSuccess");
  self endon("disconnect");
  self endon("death");
  wait 0.5;
  var0 = spawn("script_model", self.origin);
  var0 setModel("loot_armor");
  var0 notsolid();
  self playerlinktodelta(var0);
  scripts\engine\utility::waittill_notify_or_timeout("armorUseCancel", 1.2);
  self unlink();
  var0 delete();
}

function armorbreak(var0) {
  self shellshock("armor_gone", 2.5);
  earthquake(0.3, 0.65, var0, 5000);
  self viewkick(127, self.origin, 0);
}

function updatearmorvestui() {
  self endon("armorUseCancel");
  self endon("armorUseSuccess");
  var0 = gettime();
  var1 = self getgestureanimlength("ges_vest_replace");

  for(;;) {
    var2 = gettime() - var0;
    var3 = var2 / var1 * 1000;
    waitframe();
  }
}

function armorinit(var0) {
  var0.armor = 0;
}

function remove_player_armor(var0) {
  var0.armor = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night", 0);
  } else {
    visionsetpain("pain_mp", 0);
  }

  var0 playsoundtoplayer("hit_marker_3d_armor_break", var0);
  var0 setscriptablepartstate("armor_break", "armor_break", 0);
}

function can_update_player_armor_model(var0) {
  if(isDefined(var0.can_update_player_armor_model) && var0.can_update_player_armor_model == 0) {
    return false;
  }

  return true;
}

function set_can_update_player_armor_model(var0, var1) {
  var0.can_update_player_armor_model = var1;
}