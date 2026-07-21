/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_armor.gsc
***********************************************/

show_damage_direction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = var_0.health;
  var_0 finishplayerdamage(var_1, var_2, 1, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  var_0.health = var_14;
}

do_damage_to_player_armor(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(var_3 > 0)
    var_0 show_damage_direction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

  var_3 = var_3 / 5;
  var_14 = get_player_armor_amount(var_0);
  var_15 = min(var_14, var_3);
  var_16 = var_14 - var_15;
  set_armor(var_0);
  broadcast_armor(var_0, var_16);

  if(isDefined(var_2) && isPlayer(var_2))
    var_2 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_881E139E32D9F90854AF1898AF9DA35FC25A01100A", 0, var_3, 1, 0);

  var_17 = int(var_3 - var_15);

  if(var_14 > 0)
    play_armor_sfx(var_0, var_2, var_17);

  return var_17;
}

set_armor(var_0, var_1) {
  var_2 = 100;
  var_3 = getdvarint("_encstr_B22F0EB812BA9701FB55887E0FEF4981", 0);

  if(var_3)
    var_2 = var_3;

  var_0.armor = var_1 / var_2;
}

damage_armored_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_0.perk_data))
    var_3 = var_3 / 5 / var_0.perk_data["_encstr_93E02467088B9231A670DFD76099E579711061DAE12B6B756BC1D7A3E870CA2117BE7655DF75"];
  else
    var_3 = var_3 / 5;

  var_14 = get_player_armor_amount(var_0);
  var_15 = min(var_14, var_3);
  var_16 = var_14 - var_15;

  if(isDefined(var_2) && isPlayer(var_2))
    var_2 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_881E139E32D9F90854AF1898AF9DA35FC25A01100A", 0, var_3, 1, 0);

  var_17 = int(var_3 - var_15);
  set_armor(var_0, var_16);
  broadcast_armor(var_0, var_16);
  play_armor_sfx(var_0, var_2, var_16);

  if(var_16 <= 0)
    remove_player_armor(var_0);

  return var_17;
}

play_impact_fx_on_players(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_814C02A2"] = randomfloatrange(0, 1);
  var_2["_encstr_AA4C0279"] = randomfloatrange(0, 1);
  var_2["_encstr_B8FB06FF970A2908"] = randomfloatrange(0, 1);

  if(!isDefined(var_1.shoulddisplayhud))
    var_1.shoulddisplayhud = 1;

  if(!istrue(var_1.shoulddisplayhud)) {
    return;
  }
  if(var_1 scripts\engine\math::is_point_on_right(var_0)) {
    var_1 createscreeneffect("_encstr_8253060E2B5FE330", "_encstr_AF2617086B25992BC722E5ED060F516DCD522039F3BC370DF3", 0.05, 3.0, var_2, 1);
    var_1 createscreeneffect("_encstr_8253060E2B5FE330", "_encstr_962F1E33578DD837C6E45956CDD70B9CB6BDC9F5E4A5CEA1A3F5B9C136C2CD43", 0.05, 3.0, var_2, 1);
  } else {
    var_1 createscreeneffect("_encstr_A5AD056A019C63", "_encstr_815716D7E5095B3F161BAFE183CF873BE865C38E49B5E6FB", 0.05, 3.0, var_2, 1);
    var_1 createscreeneffect("_encstr_A5AD056A019C63", "_encstr_ADC31D068B637DA7DE3B2AD240382732D017AAB7212087E3E833734A89067B", 0.05, 3.0, var_2, 1);
  }

  var_1.shoulddisplayhud = 0;
}

createscreeneffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newclienthudelem(self);
  var_6.sort = 12;
  var_6.foreground = 0;
  var_6.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_6.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_6.alpha = 0;
  var_6.enablehudlighting = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = scripts\engine\math::factor_value(0.9, 1.25, var_4["_encstr_B8FB06FF970A2908"]);

  switch (var_0) {
    case "_encstr_A5AD056A019C63":
      var_6.aligny = "_encstr_AC190479FF92";
      var_6.alignx = "_encstr_A5AD056A019C63";
      var_7 = -640;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["_encstr_AA4C0279"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(-55, 0, var_4["_encstr_814C02A2"]);
      break;
    case "_encstr_8253060E2B5FE330":
      var_6.aligny = "_encstr_AC190479FF92";
      var_6.alignx = "_encstr_8253060E2B5FE330";
      var_7 = 1280;
      var_8 = scripts\engine\math::factor_value(-30, 30, var_4["_encstr_AA4C0279"]);
      var_10 = var_8;
      var_9 = scripts\engine\math::factor_value(0, 55, var_4["_encstr_814C02A2"]) + 640;
      break;
    case "_encstr_A146078E65FB5158DD":
      var_6.aligny = "_encstr_A146078E65FB5158DD";
      var_6.alignx = "_encstr_A5AD056A019C63";
      var_8 = 960;
      var_7 = scripts\engine\math::factor_value(-15, 15, var_4["_encstr_814C02A2"]);
      var_10 = scripts\engine\math::factor_value(0, 0, var_4["_encstr_AA4C0279"]);
      var_10 = var_10 + 480;
      break;
  }

  var_6.x = var_7;
  var_6.y = var_8;
  var_6 setshader(var_1, 640, 480);
  thread screeneffectcleanup(var_6);
  thread animatescreeneffect(var_6, var_2, var_3, var_9, var_10, var_11, var_5);
}

animatescreeneffect(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 = 1;
  var_0 endon("_encstr_82A71A087AF2D97B8739EE763DF7A0F31FF288A883050551DB448FEB");

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
    wait(var_1);
  }

  var_0 fadeovertime(var_2);
  var_0.alpha = 0;
  wait(var_2 + 0.05);
  var_0 notify("_encstr_82A71A087AF2D97B8739EE763DF7A0F31FF288A883050551DB448FEB");
}

screeneffectcleanup(var_0) {
  var_0 waittill("_encstr_82A71A087AF2D97B8739EE763DF7A0F31FF288A883050551DB448FEB");
  self.shoulddisplayhud = 1;
  var_0 destroy();
}

armor_resistance_to_type(var_0, var_1, var_2, var_3) {
  if(var_0 == "_encstr_87A10C9D24E997A01F21838F3D34")
    return 0;

  if(var_0 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3")
    return 0;

  if(var_0 == "_encstr_9B0D099AD3887D91252954" && !istrue(var_2.stack_patch_waittill_context_far_patch))
    return 0;

  switch (var_1.basename) {
    case "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9":
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      return 0;
  }

  if(isDefined(var_3) && istrue(var_3.calloutmarkerpingvo_play))
    return 0;

  return 1;
}

play_armor_sfx(var_0, var_1, var_2) {
  var_3 = "_encstr_A24818AF17AF6B6019273858A368A69FEB700F3009FA52A5A8CA";

  if(var_2 < 0)
    var_3 = "_encstr_83D30FEFB41336237A3A8868F1D7C7E8A7";

  if(isPlayer(var_0))
    var_0 playlocalsound(var_3);

  if(isPlayer(var_1))
    var_1 playlocalsound(var_3);
}

has_armor(var_0) {
  if(get_player_armor_amount(var_0) > 0)
    return 1;

  return 0;
}

get_player_armor_amount(var_0) {
  var_1 = 100;
  var_2 = getdvarint("_encstr_B22F0EB812BA9701FB55887E0FEF4981", 0);

  if(var_2)
    var_1 = var_2;

  return int(var_0.armor * var_1);
}

broadcast_armor(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = int(var_1);
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_2, "_encstr_8F7C0CCFEDE203419AE748B877B2", var_3);
}

update_player_model(var_0, var_1) {
  if(istrue(var_0))
    var_1 setcharactermodels("_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042", "_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C");
  else
    var_1 setcharactermodels("_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF", "_encstr_A35F25E38B8F7A675823F1C3B99074A2DE05B7237BAED204706975C113C8BBEB20B39B4F7340DF", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C");
}

setcharactermodels(var_0, var_1, var_2, var_3) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self.bodymodel = var_0;
  self setModel(var_0);
  self setviewmodel(var_2);

  if(isDefined(var_1)) {
    self attach(var_1, "_encstr_B40101", 1);
    self.headmodel = var_1;
  }

  if(isDefined(var_3)) {
    self attach(var_3, "_encstr_B40101", 1);
    self.hairmodel = var_3;
  }
}

pick_up_armor_vest(var_0, var_1) {
  if(player_have_full_armor(var_1)) {
    return;
  }
  var_0.model delete();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_2 = 100;
  var_3 = getdvarint("_encstr_B22F0EB812BA9701FB55887E0FEF4981", 0);

  if(var_3)
    var_2 = var_3;

  givearmor(var_1, var_2);
}

givearmor(var_0, var_1, var_2) {
  if(player_have_full_armor(var_0)) {
    return;
  }
  var_3 = var_0 getentitynumber();
  setomnvar("_encstr_B226102D8BA106ABD1805389693F3F3D9809", var_3);
  var_2 = istrue(var_2);

  if(!var_2) {
    var_0 scripts\common\utility::allow_ads(0, "_encstr_A7B606DA83796F4A");
    var_0 scripts\common\utility::allow_fire(0, "_encstr_A7B606DA83796F4A");
    var_0 scripts\common\utility::allow_melee(0, "_encstr_A7B606DA83796F4A");
    var_0 cancelreload();

    if(!isDefined(var_0.carryobject))
      var_0 forceplaygestureviewmodel("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED", undefined, 0.3);
    else
      var_2 = 1;
  }

  var_0 thread updatearmorvestui();

  if(!var_2) {
    wait(var_0 getgestureanimlength("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED"));
    var_0 playlocalsound("_encstr_878412D89AC2DF49A31DC046D75FB1712BD2E8C8");
  }

  var_0 notify("_encstr_846410491E889F82B3885A3150373E4FA306");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    visionsetpain("_encstr_A2220E0B57101A7187E131FDDADFAB8B");
  else
    visionsetpain("_encstr_AAA90DC8997239892BC76FFDA3E04A");

  broadcast_armor(var_0, var_1);
  var_1 = var_1 / 100;

  if(!var_2) {
    var_0 stopgestureviewmodel("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED", 0.45);
    var_0 scripts\common\utility::allow_ads(1, "_encstr_A7B606DA83796F4A");
    var_0 scripts\common\utility::allow_fire(1, "_encstr_A7B606DA83796F4A");
    var_0 scripts\common\utility::allow_melee(1, "_encstr_A7B606DA83796F4A");
  }

  var_0.armor = var_1;
}

player_have_armor(var_0) {
  return var_0.armor > 0;
}

player_have_full_armor(var_0) {
  var_1 = 100;
  var_2 = getdvarint("_encstr_B22F0EB812BA9701FB55887E0FEF4981", 0);

  if(var_2)
    var_1 = var_2;

  return int(var_0.armor * var_1) == var_1;
}

armor_vest_hint_func(var_0, var_1) {
  if(player_have_full_armor(var_1))
    return &"_encstr_BE4A19A1E97A827D1A920A64A252398E97A04AA93D4AAFC8AA89C4";
  else
    return &"_encstr_95B41987383F51D74E622B07D5B92909EAE195F00F866EC991A31B";
}

updatearmorvestmodel() {
  self endon("_encstr_846410491E889F82B3885A3150373E4FA306");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 setModel("_encstr_A1300B41285A4D09EF139FE033");
  var_0 notsolid();
  self playerlinktodelta(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_888B0FC29CDABD93AACD9534B0B9C659B1", 1.2);
  self unlink();
  var_0 delete();
}

armorbreak(var_0) {
  self shellshock("_encstr_8A040BF2AB51577209376F66DB", 2.5);
  earthquake(0.3, 0.65, var_0, 5000);
  self viewkick(127, self.origin, 0);
}

updatearmorvestui() {
  self endon("_encstr_888B0FC29CDABD93AACD9534B0B9C659B1");
  self endon("_encstr_846410491E889F82B3885A3150373E4FA306");
  var_0 = gettime();
  var_1 = self getgestureanimlength("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED");

  for(;;) {
    var_2 = gettime() - var_0;
    var_3 = var_2 / (var_1 * 1000);
    waitframe();
  }
}

armorinit(var_0) {
  var_0.armor = 0;
}

remove_player_armor(var_0) {
  var_0.armor = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    visionsetpain("_encstr_A2220E0B57101A7187E131FDDADFAB8B", 0);
  else
    visionsetpain("_encstr_9B0E08E058D2B9D7B538", 0);

  var_0 playsoundtoplayer("_encstr_B17B1AC857E3D90A898228DD1389AF5F9E276E5A57DAE1D533C588CA", var_0);
  var_0 setscriptablepartstate("_encstr_82590C8593B5BD93D78993B20B6D", "_encstr_82590C8593B5BD93D78993B20B6D", 0);
}

can_update_player_armor_model(var_0) {
  if(isDefined(var_0.can_update_player_armor_model) && var_0.can_update_player_armor_model == 0)
    return 0;

  return 1;
}

set_can_update_player_armor_model(var_0, var_1) {
  var_0.can_update_player_armor_model = var_1;
}