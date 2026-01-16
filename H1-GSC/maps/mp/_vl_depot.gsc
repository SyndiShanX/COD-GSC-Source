/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_vl_depot.gsc
********************************/

init_depot() {
  setdepotstate("");
  level.depotscenes = [];
  level.depotscenes[level.depotscenes.size] = "knife";
  level.depotscenes[level.depotscenes.size] = "pistol";
  level.depotscenes[level.depotscenes.size] = "laptop";
  level.depotscenes[level.depotscenes.size] = "smoking";
  level.depotscenes[level.depotscenes.size] = "lackey";
  level.depotstates = [];
  depotaddstate("pause", "idle", "idle", ::depotcanswitchtopause, ::depotswitchingtopause, ::depotpauseended);
  depotaddstate("greetingidle", "greeting_idle", "greetingidle", ::depotcanswitchtogreetingidle, ::depotswitchingtogreetingidle, ::depotgreetingidleended);
  depotaddstate("greetingfirst", "greeting_first", "greetingfirst", ::depotcanswitchtogreetingfirst, ::depotswitchingtogreetingfirst, ::depotgreetingfirstended);
  depotaddstate("greeting", "greeting", "greeting", ::depotcanswitchtogreeting, ::depotswitchingtogreeting, ::depotgreetingended);
  depotaddstate("idle", "idle", "idle", ::depotcanswitchtoidle, ::depotswitchingtoidle, ::depotidleended, ::depotidleinit);
  depotaddstate("fidget", "fidget", "fidget", ::depotcanswitchtofidget, ::depotswitchingtofidget, ::depotfidgetended, ::depotfidgetinit);
  depotaddstate("nag", "nag", "nag", ::depotcanswitchtonag, ::depotswitchingtonag, ::depotnagended, ::depotnaginit);
  depotaddstate("xover", "xover", "xover", ::depotcanswitchtoxover, ::depotswitchingtoxover, ::depotxoverended, ::depotxoverinit);
  depotaddstate("broke", "broke", "broke", ::depotcanswitchtobroke, ::depotswitchingtobroke, ::depotbrokeended, ::depotbrokeinit);
  depotaddstate("creditreminder", "credit_reminder", "creditreminder", ::depotcanswitchtocreditreminder, ::depotswitchingtocreditreminder, ::depotcreditreminderended, ::depotcreditreminderinit);
  depotaddstate("newproduct", "new_product", "newproduct", ::depotcanswitchtonewproduct, ::depotswitchingtonewproduct, ::depotnewproductended);
  depotaddstate("easteregg", "easter_egg", "easteregg", ::depotcanswitchtoeasteregg, ::depotswitchingtoeasteregg, ::depoteastereggended, ::depoteasteregginit);
  depotaddstate("purchase", "purchase", "purchase", ::depotcanswitchtopurchase, ::depotswitchingtopurchase, ::depotpurchaseended, ::depotpurchaseinit);
  depotaddstate("purchasewait", undefined, undefined, ::depotcanswitchtopurchasewait, ::depotswitchingtopurchasewait, ::depotpurchasewaitended);
  depotaddstate("purchaseconfirm", undefined, undefined, ::depotcanswitchtopurchaseconfirm, ::depotswitchingtopurchaseconfirm, ::depotpurchaseconfirmended);
  depotaddstate("purchasefail", undefined, undefined, ::depotcanswitchtopurchasefail, ::depotswitchingtopurchasefail, ::depotpurchasefailended);
  depotaddstate("purchaseidle", undefined, undefined, ::depotcanswitchtopurchaseidle, ::depotswitchingtopurchaseidle, ::depotpurchaseidleended);
  depotaddpropnotetrackfx("h1_prop_cigarette_dark_animated", "start_smoking", "cigarette_smk_vlobby", "tag_fx", 1);
  depotaddpropnotetrackfx("h1_prop_cigarette_dark_animated", "inhale_start", "cigarette_endglow_vlobby", "tag_fx");
  depotaddpropnotetrackfx("h1_prop_cigarette_dark_animated", "flick", "cigarette_ash_vlobby", "tag_fx");
  depotaddpropnotetrackfx("wpn_h1_pst_m1911_npc", "fire_gun", "vlobby_pistol_flash", "tag_flash");
  depotaddpropnotetrackfx("wpn_h1_pst_m1911_npc", "eject", "pistol", "tag_brass");
  depotaddpropnotetrackfx("prop_graves_cellphone", "light_on", "vlobby_cellphone_light", "tag_fx");
  level.depotbrokeattempts = 0;
  level.depoteastereggthreshhold = 40;
  level.inventoryitemrarity = [];
  level.inventoryitemrarity["None"] = 0;
  level.inventoryitemrarity["Reward"] = 1;
  level.inventoryitemrarity["Common"] = 2;
  level.inventoryitemrarity["Rare"] = 3;
  level.inventoryitemrarity["Legendary"] = 4;
  level.inventoryitemrarity["Epic"] = 5;
  level.raritycardfx = [];
  level.raritycardfx[level.inventoryitemrarity["Common"]] = spawnstruct();
  level.raritycardfx[level.inventoryitemrarity["Common"]].fx = "loot_card_trail_common";
  level.raritycardfx[level.inventoryitemrarity["Common"]].rumble = "loot_crate_open_common";
  level.raritycardfx[level.inventoryitemrarity["Common"]].exploder = 106;
  level.raritycardfx[level.inventoryitemrarity["Rare"]] = spawnstruct();
  level.raritycardfx[level.inventoryitemrarity["Rare"]].fx = "loot_card_trail_rare";
  level.raritycardfx[level.inventoryitemrarity["Rare"]].rumble = "loot_crate_open_rare";
  level.raritycardfx[level.inventoryitemrarity["Rare"]].exploder = 109;
  level.raritycardfx[level.inventoryitemrarity["Legendary"]] = spawnstruct();
  level.raritycardfx[level.inventoryitemrarity["Legendary"]].fx = "loot_card_trail_legendary";
  level.raritycardfx[level.inventoryitemrarity["Legendary"]].rumble = "loot_crate_open_legendary";
  level.raritycardfx[level.inventoryitemrarity["Legendary"]].exploder = 112;
  level.raritycardfx[level.inventoryitemrarity["Epic"]] = spawnstruct();
  level.raritycardfx[level.inventoryitemrarity["Epic"]].fx = "loot_card_trail_epic";
  level.raritycardfx[level.inventoryitemrarity["Epic"]].rumble = "loot_crate_open_epic";
  level.raritycardfx[level.inventoryitemrarity["Epic"]].exploder = 115;
  depotscenelightsoff();
}

depotaddstate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(level.depotstates[var_0]))
    level.depotstates[var_0] = spawnstruct();

  level.depotstates[var_0].animname = var_1;
  level.depotstates[var_0].animlabel = var_2;
  level.depotstates[var_0].canswitchtostatefunc = var_3;
  level.depotstates[var_0].switchingtostatefunc = var_4;
  level.depotstates[var_0].stateendedfunc = var_5;
  level.depotstates[var_0].stateinitfunc = var_6;
}

hasvisiteddepot() {
  var_0 = getcacplayerdataforgroup(level.depotcontroller, common_scripts\utility::getstatsgroup_common(), "hasEverVisitedDepot");
  return var_0;
}

sethasvisiteddepot() {
  setplayerdataforgroup(level.depotcontroller, common_scripts\utility::getstatsgroup_common(), "hasEverVisitedDepot", 1);
}

hascrossoverloot() {
  return getdvarint("vlDepotHaveCrossover", 0);
}

hasnewproduct() {
  return getdvarint("vlDepotHasNewProduct", 0);
}

sethasnewproduct() {
  setdynamicdvar("vlDepotHasNewProduct", 0);
}

hasabunduntcurrency() {
  var_0 = _func_305(level.depotcontroller, 4);
  var_1 = _func_305(level.depotcontroller, 2) * 0.0037037;
  var_2 = _func_307("aw_advanced_cp");
  var_3 = _func_307("aw_advanced");
  return var_0 > var_2["amount"] || var_1 > var_3["amount"];
}

playerdepotprocesslui(var_0, var_1) {
  if(var_0 == "depot")
    thread playerenterdepot(var_1);
  else if(var_0 == "leave_depot")
    thread playerleavedepot(var_1);
  else if(var_0 == "depot_return")
    thread playerreturntodepot(var_1);
  else if(var_0 == "depot_state") {
    if(var_1 == "broke")
      level.depotbrokeattempts = level.depotbrokeattempts + 1;

    setdepotstate(var_1);
  } else if(var_0 == "depot_loot_rarities")
    thread depotnotifylootrarities(var_1);
  else if(var_0 == "depot_supply_drop_type") {
    thread depothandlestickerfx(var_1);
    thread depothandlecratemodel(var_1);
  }
}

getdepotstate() {
  return getdvar("vlDepotState");
}

setdepotstate(var_0) {
  var_1 = "";
  setdynamicdvar("vlDepotState", var_0);
}

depothandlestickerfx(var_0) {
  var_1 = getstickerfx(var_0);

  if(isdefined(level.depotcrate.laststickerfx) && level.depotcrate.laststickerfx != var_1)
    stopfxontag(level._effect[level.depotcrate.laststickerfx], level.depotcrate, "TAG_FX_STICKER");

  level.depotcrate.laststickerfx = var_1;
  playfxontag(level._effect[level.depotcrate.laststickerfx], level.depotcrate, "TAG_FX_STICKER");
}

getstickerfx(var_0) {
  var_1 = strtok(var_0, "_");

  if(var_1.size >= 2) {
    var_2 = var_1[0];
    var_3 = var_1[1];

    if(var_2 == "aw") {
      if(var_3 == "basic")
        return "loot_sticker_wolf";
      else
        return "loot_sticker_wolf_rare";
    } else if(var_2 == "ls") {
      if(var_3 == "basic")
        return "loot_sticker_lion";
      else
        return "loot_sticker_lion_rare";
    } else if(var_2 == "ch") {
      if(var_3 == "basic")
        return "loot_sticker_copperhead";
      else
        return "loot_sticker_copperhead_rare";
    } else if(var_2 == "ex" && var_3 == "promo") {
      if(var_1.size >= 3) {
        var_4 = var_1[2];

        if(var_4 == "6" || var_4 == "8")
          return "loot_sticker_wolf_rare";
        else if(var_4 == "9" || var_4 == "10" || var_4 == "11" || var_4 == "12")
          return "loot_sticker_copperhead_rare";
      }

      return "loot_sticker_lion_rare";
    }
  }

  return "loot_sticker_wolf";
}

depothandlecratemodel(var_0) {
  var_1 = getcratemodel(var_0);
  level.depotcrate setmodel(var_1);
}

getcratemodel(var_0) {
  var_1 = strtok(var_0, "_");

  if(var_1.size >= 2) {
    var_2 = var_1[0];
    var_3 = var_1[1];

    if(var_2 == "aw")
      return "h1_supply_drop_crate_a_anim";
    else if(var_2 == "ls") {
      if(var_3 == "promo")
        return "h1_supply_drop_crate_shamrock";

      return "h1_supply_drop_crate_lion_strike";
    } else if(var_2 == "ch") {
      if(var_3 == "promo")
        return "h1_supply_drop_crate_days_of_summer";

      return "h1_supply_drop_crate_copperhead";
    } else if(var_2 == "ex" && var_3 == "promo") {
      if(var_1.size >= 3) {
        var_4 = var_1[2];

        if(var_4 == "6" || var_4 == "8")
          return "h1_supply_drop_crate_a_anim";
        else if(var_4 == "9" || var_4 == "10" || var_4 == "11" || var_4 == "12")
          return "h1_supply_drop_crate_copperhead";
      }

      return "h1_supply_drop_crate_lion_strike";
    }
  }

  return "h1_supply_drop_crate_a_anim";
}

playerdepot_dof() {
  self enablephysicaldepthoffieldscripting();
  var_0 = 3.3;
  var_1 = 80.0;

  if(isdefined(level.depotscene)) {
    switch (level.depotscene) {
      case "knife":
        var_0 = 3.3;
        var_1 = 75.0;
        break;
      case "pistol":
        var_0 = 3.3;
        var_1 = 58.0;
        break;
      case "laptop":
        var_0 = 4.3;
        var_1 = 48.0;
        break;
      case "smoking":
        var_0 = 2.6;
        var_1 = 75.0;
        break;
      case "lackey":
        var_0 = 2.6;
        var_1 = 107.0;
        break;
    }
  }

  self setphysicaldepthoffield(var_0, var_1);
}

playerenterdepot(var_0) {
  self endon("leave_depot");
  setdvar("vlDepotEnabled", 1);

  if(!maps\mp\_utility::is_true(level.in_depot)) {
    while (!getdvarint("vlDepotLoaded", 0) || !getdvarint("virtualLobbyPresentable"))
      wait 0.05;

    level.depotcontroller = var_0;
    var_1 = maps\mp\_vl_base::getfocusfromcontroller(var_0);
    level.vl_focus = var_1;
    var_2 = self;
    depotsetupseasonal();

    if(!maps\mp\_utility::is_true(level.depotinitialized)) {
      var_2 thread maps\mp\_vl_base::playerreloadallavatarmodels();
      maps\mp\mp_vlobby_room_fx::loadprecacheddepoteffects();
      var_2 spawnandinitdepotents();
      level.depotinitialized = 1;
    }

    foreach(var_4 in level.depotstates) {
      if(isdefined(var_4.stateinitfunc))
        self[[var_4.stateinitfunc]]();
    }

    var_6 = level.camparams.camera;
    var_6.depotpos = "dealer";
    var_6.depotsceneent scriptmodelplayanimdeltamotionfrompos("h1_vlobby_armory_scene1_cam_idle", var_6.depotsceneent.scriptednode.origin, var_6.depotsceneent.scriptednode.angles, "scene_node_anim");

    if(_func_306(var_0, "onboarding") > 0) {
      level.depotscene = level.depotscenes[0];
      setdepotstate("greetingidle");
    } else if(hasvisiteddepot()) {
      level.depotscene = level.depotscenes[randomint(level.depotscenes.size)];
      setdepotstate("greeting");
    } else {
      level.depotscene = level.depotscenes[0];
      setdepotstate("greetingfirst");
    }

    foreach(var_8 in level.depotagent.props)
    var_8 show();

    foreach(var_11 in level.depothiddensceneprops[level.depotscene])
    var_11 hide();

    depotscenelightson(level.depotscene);
    maps\mp\_vl_base::playerchangecameramode("depot", 1);
    maps\mp\_vl_base::playersetfovscale(1.0);
    thread playerdepot_dof();
    level.in_depot = 1;
    thread depotanimstatemachine();

    if(level.depotscene != "lackey")
      thread depotlackeyfidgets();

    thread playbobbleanim();
  }
}

playerleavedepot(var_0) {
  self notify("leave_depot");
  level notify("leave_depot");
  setdvar("vlDepotEnabled", 0);

  if(!maps\mp\_utility::is_true(level.in_depot)) {
    if(!maps\mp\_utility::is_true(level.depotinitialized))
      thread maps\mp\_vl_base::playerreloadallavatarmodels();

    return;
  }

  level.depotagent stopsounds();
  level.in_depot = 0;
  maps\mp\_vl_base::playersetlobbyfovscale();
  maps\mp\_vl_base::playerpopcameramode();

  foreach(var_2 in level.depotspecialanimprops) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2)
      var_4 scriptmodelclearanim();

      continue;
    }

    var_2 scriptmodelclearanim();
  }

  level.depotagent.depotsceneent scriptmodelclearanim();
  level.depotlackey.sceneent scriptmodelclearanim();
  level.depotcrate scriptmodelclearanim();
  level.depotcrate scriptmodelplayanimdeltamotionfrompos("h1_vlobby_armory_lootcrate_closed_idle", level.depotcrate.originalorigin, level.depotcrate.originalangles);
  depotscenelightsoff();
  level.depotbrokeattempts = 0;
}

playerreturntodepot(var_0) {
  maps\mp\_vl_base::playersetfovscale(1.0);

  if(getdvar("vlDepotState") == "pause") {
    if(level.camparams.camera.depotpos == "crate")
      setdepotstate("purchaseidle");
    else
      setdepotstate("idle");
  }
}

depotnotifylootrarities(var_0) {
  var_1 = strtok(var_0, ",");
  level.depotlootrarities = [];

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    level.depotlootrarities[var_2] = int(var_1[var_2]);

  level notify("depot_loot_rarities");
}

spawndepotpropent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_1);
  var_5 setmodel(var_0);
  setupdepotpropent(var_5, var_2, var_3, var_4);
  return var_5;
}

setupdepotpropent(var_0, var_1, var_2, var_3) {
  var_0 linktosynchronizedparent(var_1, var_2, (0, 0, 0), (0, 0, 0));

  if(maps\mp\_utility::is_true(var_3))
    var_0 hide();

  if(!isdefined(level.depotpropents))
    level.depotpropents = [];

  level.depotpropents[var_0.model] = var_0;
}

depotinithiddensceneprops() {
  level.depothiddensceneprops = [];

  foreach(var_1 in level.depotscenes)
  level.depothiddensceneprops[var_1] = [];

  level.depothiddensceneprops["knife"][level.depothiddensceneprops["knife"].size] = level.depotagent.props["ashtray"];
  level.depothiddensceneprops["knife"][level.depothiddensceneprops["knife"].size] = level.depotlackey.props["cards"];
  level.depothiddensceneprops["pistol"][level.depothiddensceneprops["pistol"].size] = level.depotagent.props["ashtray"];
  level.depothiddensceneprops["pistol"][level.depothiddensceneprops["pistol"].size] = level.depotagent.props["cig"];
  level.depothiddensceneprops["pistol"][level.depothiddensceneprops["pistol"].size] = level.depotlackey.props["cards"];
  level.depothiddensceneprops["laptop"][level.depothiddensceneprops["laptop"].size] = level.depotagent.props["cloth"];
  level.depothiddensceneprops["laptop"][level.depothiddensceneprops["laptop"].size] = level.depotlackey.props["cards"];
  level.depothiddensceneprops["smoking"][level.depothiddensceneprops["smoking"].size] = level.depotagent.props["cloth"];
  level.depothiddensceneprops["smoking"][level.depothiddensceneprops["smoking"].size] = level.depotlackey.props["cards"];
  level.depothiddensceneprops["lackey"][level.depothiddensceneprops["lackey"].size] = level.depotagent.props["cloth"];
}

depotinitsounds() {
  level.depotagent.sounds = [];
  level.depotagent.propsounds = [];
  level.depotagent.sounds["knife"] = [];
  level.depotagent.sounds["knife"]["fidget"] = [];
  level.depotagent.sounds["knife"]["fidget"][0] = "dpo_knife_fidget_a";
  level.depotagent.sounds["knife"]["fidget"][1] = "dpo_knife_fidget_b";
  level.depotagent.sounds["knife"]["greetingidle"] = "dpo_knife_greeting_idle";
  level.depotagent.sounds["knife"]["greetingfirst"] = "dpo_knife_greeting_first";
  level.depotagent.sounds["knife"]["greeting"] = "dpo_knife_dealer_greeting_1";
  level.depotagent.sounds["knife"]["idle"] = "dpo_knife_dealer_idle_1";
  level.depotagent.sounds["knife"]["nag"] = "dpo_knife_fidget_c";
  level.depotagent.sounds["knife"]["xover"] = "dpo_knife_fidget_d";
  level.depotagent.sounds["knife"]["broke"] = "dpo_knife_fidget_e";
  level.depotagent.sounds["knife"]["creditreminder"] = "dpo_knife_fidget_f";
  level.depotagent.sounds["knife"]["newproduct"] = "dpo_knife_fidget_g_1";
  level.depotagent.sounds["knife"]["purchase"] = "dpo_knife_purchase";
  level.depotagent.sounds["pistol"] = [];
  level.depotagent.sounds["pistol"]["fidget"] = [];
  level.depotagent.sounds["pistol"]["fidget"][0] = "dpo_pistol_fidget_a";
  level.depotagent.sounds["pistol"]["fidget"][1] = "dpo_pistol_fidget_b";
  level.depotagent.sounds["pistol"]["nag"] = "dpo_pistol_fidget_c";
  level.depotagent.sounds["pistol"]["xover"] = "dpo_pistol_fidget_d";
  level.depotagent.sounds["pistol"]["broke"] = "dpo_pistol_fidget_e";
  level.depotagent.sounds["pistol"]["easteregg"] = "dpo_pistol_fidget_f";
  level.depotagent.sounds["pistol"]["creditreminder"] = "dpo_pistol_fidget_g";
  level.depotagent.sounds["pistol"]["newproduct"] = "dpo_pistol_fidget_h";
  level.depotagent.sounds["pistol"]["greeting"] = "dpo_pistol_fidget_greeting";
  level.depotagent.sounds["pistol"]["purchase"] = "dpo_pistol_fidget_purchase";
  level.depotagent.sounds["laptop"] = [];
  level.depotagent.sounds["laptop"]["fidget"] = [];
  level.depotagent.sounds["laptop"]["fidget"][0] = "dpo_laptop_fidget_a_1";
  level.depotagent.sounds["laptop"]["fidget"][1] = "dpo_laptop_fidget_b_1";
  level.depotagent.sounds["laptop"]["nag"] = "dpo_laptop_fidget_c_nag_1";
  level.depotagent.sounds["laptop"]["xover"] = "dpo_laptop_fidget_d_xover_1";
  level.depotagent.sounds["laptop"]["broke"] = "dpo_laptop_fidget_e_broke_1";
  level.depotagent.sounds["laptop"]["easteregg"] = "dpo_laptop_fidget_f_ee_1";
  level.depotagent.sounds["laptop"]["creditreminder"] = "dpo_laptop_fidget_g_crdrem_1";
  level.depotagent.sounds["laptop"]["newproduct"] = "dpo_laptop_fidget_h_newprd_1";
  level.depotagent.sounds["laptop"]["greeting"] = "dpo_laptop_greeting_1";
  level.depotagent.sounds["laptop"]["purchase"] = "dpo_laptop_purchase_1";
  level.depotagent.sounds["laptop"]["idle"] = "dpo_laptop_idle_1";
  level.depotagent.propsounds["laptop"] = [];
  level.depotagent.propsounds["laptop"]["nag"] = [];
  level.depotagent.propsounds["laptop"]["nag"]["phone"] = "dpo_laptop_fidget_c_nag_1_phn";
  level.depotagent.sounds["lackey"] = [];
  level.depotagent.sounds["lackey"]["fidget"] = [];
  level.depotagent.sounds["lackey"]["fidget"][0] = "dpo_lackey_fidget_a";
  level.depotagent.sounds["lackey"]["fidget"][1] = "dpo_lackey_fidget_b";
  level.depotagent.sounds["lackey"]["nag"] = "dpo_lackey_fidget_c_nag";
  level.depotagent.sounds["lackey"]["xover"] = "dpo_lackey_fidget_d_xover";
  level.depotagent.sounds["lackey"]["broke"] = "dpo_lackey_fidget_e_brk";
  level.depotagent.sounds["lackey"]["easteregg"] = "dpo_lackey_fidget_f_ee";
  level.depotagent.sounds["lackey"]["creditreminder"] = "dpo_lackey_fidget_g_crdrem";
  level.depotagent.sounds["lackey"]["newproduct"] = "dpo_lackey_fidget_h_newprd";
  level.depotagent.sounds["lackey"]["purchase"] = "dpo_lackey_purchase";
  level.depotagent.sounds["lackey"]["greeting"] = "dpo_lackey_grtng";
  level.depotagent.sounds["lackey"]["idle"] = "dpo_lackey_idle";
  level.depotagent.sounds["smoking"] = [];
  level.depotagent.sounds["smoking"]["fidget"] = [];
  level.depotagent.sounds["smoking"]["fidget"][0] = "dpo_smoke_fidget_a";
  level.depotagent.sounds["smoking"]["fidget"][1] = "dpo_smoke_fidget_b";
  level.depotagent.sounds["smoking"]["nag"] = "dpo_smoke_fidget_c_nag";
  level.depotagent.sounds["smoking"]["xover"] = "dpo_smoke_fidget_d_xover";
  level.depotagent.sounds["smoking"]["broke"] = "dpo_smoke_fidget_e_broke";
  level.depotagent.sounds["smoking"]["easteregg"] = "dpo_smoke_fidget_f_easteregg";
  level.depotagent.sounds["smoking"]["creditreminder"] = "dpo_smoke_fidget_g_creditreminder";
  level.depotagent.sounds["smoking"]["newproduct"] = "dpo_smoke_fidget_h_newproduct";
  level.depotagent.sounds["smoking"]["greeting"] = "dpo_smoke_greeting";
  level.depotagent.sounds["smoking"]["purchase"] = "dpo_smoke_purchase";
  level.depotagent.sounds["smoking"]["idle"] = "dpo_smoke_idle";
}

spawnandinitdepotents() {
  var_0 = level.camparams.camera;

  if(isdefined(var_0.depotsceneent)) {
    return;
  }
  while (!isdefined(common_scripts\utility::getstruct("characterBM", "targetname")))
    wait 0.05;

  var_1 = common_scripts\utility::getstruct("characterBM", "targetname");
  var_0.depotsceneent = spawn("script_model", var_1.origin);
  var_0.depotsceneent setmodel("genericprop");
  var_0.depotsceneent.scriptednode = var_1;
  level.depotagent = playerspawndepotcharacter(self.class, "vldepot_dealer_animclass", "body_graves_mp", "head_graves_lob");
  level.depotagent.depotsceneent = spawn("script_model", var_1.origin);
  level.depotagent.depotsceneent setmodel("genericprop_x10");
  level.depotagent.depotsceneent.scriptednode = var_1;
  level.depotagent linktosynchronizedparent(level.depotagent.depotsceneent, "j_prop_1", (0, 0, 0), (0, 0, 0));
  level.depotagent.props = [];
  level.depotagent.props["pistol"] = spawndepotpropent("wpn_h1_pst_m1911_npc", var_1.origin, level.depotagent.depotsceneent, "j_prop_2");
  level.depotagent.props["knife"] = spawndepotpropent("wpn_h1_graves_combat_knife_npc", var_1.origin, level.depotagent.depotsceneent, "j_prop_3");
  level.depotagent.props["chair"] = spawndepotpropent("prop_graves_folding_chair", var_1.origin, level.depotagent.depotsceneent, "j_prop_4");
  level.depotagent.props["cig"] = spawndepotpropent("h1_prop_cigarette_dark_animated", var_1.origin, level.depotagent.depotsceneent, "j_prop_5");
  level.depotagent.props["phone"] = spawndepotpropent("prop_graves_cellphone", var_1.origin, level.depotagent.depotsceneent, "j_prop_6");
  level.depotagent.props["ashtray"] = spawndepotpropent("btr_ashtray_metal_01", var_1.origin, level.depotagent.depotsceneent, "j_prop_7");
  level.depotagent.props["whetStone"] = spawndepotpropent("h1_sharpening_stone", var_1.origin, level.depotagent.depotsceneent, "j_prop_8");
  level.depotagent.props["laptop"] = spawndepotpropent("h1_laptop_01_rig", var_1.origin, level.depotagent.depotsceneent, "j_prop_9");
  level.depotagent.props["cloth"] = spawndepotpropent("h1_props_vl_depot_weapon_rag", var_1.origin, level.depotagent.depotsceneent, "j_prop_7");
  level.depotagent.props["cloth"].animstatesuffix = "cloth";
  var_2 = "head_graves_lackey";
  var_3 = "body_graves_lackey";

  if(level.inventory_contentpromo == 1)
    var_2 = "head_graves_lackey_irish";
  else if(level.inventory_contentpromo == 2)
    var_3 = "body_graves_lackey_summertime";

  level.depotlackey = playerspawndepotcharacter(self.class, "vldepot_lackey_animclass", var_3, var_2);
  level.depotlackey.sceneent = spawn("script_model", var_1.origin);
  level.depotlackey.sceneent setmodel("genericprop_x10");
  level.depotlackey.sceneent.scriptednode = var_1;
  level.depotlackey linktosynchronizedparent(level.depotlackey.sceneent, "j_prop_10", (0, 0, 0), (0, 0, 0));
  level.depotlackey.props = [];
  level.depotlackey.props["redtoolbox"] = spawndepotpropent("com_red_toolbox", var_1.origin, level.depotlackey.sceneent, "j_prop_1", 1);
  level.depotlackey.props["firstaid"] = spawndepotpropent("h1_cs_firstaid_kit", var_1.origin, level.depotlackey.sceneent, "j_prop_2", 1);
  level.depotlackey.props["cardboardbox"] = spawndepotpropent("h1_cs_box_cardboard_a_closed", var_1.origin, level.depotlackey.sceneent, "j_prop_3", 1);
  level.depotlackey.props["toolbox"] = spawndepotpropent("h1_fng_toolbox_01", var_1.origin, level.depotlackey.sceneent, "j_prop_4", 1);
  level.depotlackey.props["crate"] = spawndepotpropent("ch_crate48x64", var_1.origin, level.depotlackey.sceneent, "j_prop_5", 1);
  level.depotlackey.props["ammo"] = spawndepotpropent("h1_fng_shell_ammo_crate", var_1.origin, level.depotlackey.sceneent, "j_prop_6", 1);
  level.depotlackey.props["plasticcase"] = spawndepotpropent("com_plasticcase_beige_big", var_1.origin, level.depotlackey.sceneent, "j_prop_7", 1);
  level.depotlackey.props["clipboard"] = spawndepotpropent("com_clipboard_wpaper", var_1.origin, level.depotlackey.sceneent, "j_prop_8", 1);
  level.depotlackey.props["cards"] = spawn("script_model", (0, 0, 0));
  level.depotlackey.props["cards"] setmodel("h1_props_vl_depot_playcards");
  level.depotlackey.props["cards"].animstatesuffix = "cards";
  level.depotlackey.props["cards"].animscenenode = level.depotlackey.sceneent.scriptednode;
  level.depotprop = playerspawndepotcharacter(self.class, "vldepot_props_animclass", "body_graves_lackey", "head_graves_lackey", 0);
  maps\mp\_vl_avatar::hide_avatar(level.depotprop);
  level.depotspecialanimprops = [];
  level.depotspecialanimprops["pistol"] = [];
  level.depotspecialanimprops["pistol"][level.depotspecialanimprops["pistol"].size] = level.depotagent.props["pistol"];
  level.depotspecialanimprops["pistol"][level.depotspecialanimprops["pistol"].size] = level.depotagent.props["cloth"];
  level.depotspecialanimprops["knife"] = level.depotagent.props["cloth"];
  level.depotspecialanimprops["laptop"] = level.depotagent.props["laptop"];
  level.depotspecialanimprops["lackey"] = level.depotlackey.props["cards"];
  var_4 = common_scripts\utility::getstruct("drop_crate", "targetname");
  level.depotcrate = spawn("script_model", var_4.origin);
  level.depotcrate.angles = var_4.angles;
  level.depotcrate setmodel("h1_supply_drop_crate_a_anim");
  level.depotcrate.originalorigin = level.depotcrate.origin;
  level.depotcrate.originalangles = level.depotcrate.angles;
  level.depotlootprop = spawn("script_model", level.depotcrate.origin);
  level.depotlootprop.angles = level.depotcrate.angles;
  level.depotlootprop setmodel("genericprop_x3");
  level.depotlootcards = [];

  for (var_5 = 0; var_5 < 3; var_5++) {
    level.depotlootcards[var_5] = spawn("script_model", (0, 0, 0));
    level.depotlootcards[var_5] setmodel("h1_props_vl_depot_playcards_single_crate");
    level.depotlootcards[var_5] linktosynchronizedparent(level.depotlootprop, "j_prop_" + (var_5 + 1), (0, 0, 0), (0, 0, 0));
    level.depotlootcards[var_5] ghost();
  }

  depotinithiddensceneprops();
  depotinitsounds();
}

playerspawndepotcharacter(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_4))
    var_4 = 1;

  var_5 = maps\mp\gametypes\_class::getloadout(self.pers["team"], var_0);
  var_6 = common_scripts\utility::getstruct("characterBM", "targetname");
  var_7 = maps\mp\_vl_avatar::spawn_an_avatar(self, var_6, var_5.primaryname, self.costume, var_5._id_A7ED, undefined, undefined, var_4, 1, var_2, var_3);
  var_7._id_A7EA = var_5.emblemindex;
  var_7 _meth_8577(var_5._id_A7EC);
  var_7 setanimclass(var_1);
  var_7 scragentsetscripted(1);
  var_7 scragentsetphysicsmode("noclip");
  maps\mp\_vl_avatar::hide_avatar_primary_weapon(var_7);
  return var_7;
}

depotdelaysetstate(var_0, var_1) {
  level endon("depot_state_changed");
  wait(var_1);
  setdepotstate(var_0);
}

depotidleinit() {
  level.depotstates["idle"].statemintime = 10000;
  level.depotstates["idle"].statemaxtime = 15000;
  level.depotstates["idle"].laststatetime = gettime();
  level.depotstates["idle"].idletype = 1;
}

depotfidgetinit() {
  level.depotstates["fidget"].idletype = 1;
}

depotnaginit() {
  level.depotstates["nag"].statemintime = 90000;
  level.depotstates["nag"].statemaxtime = 120000;
  level.depotstates["nag"].laststatetime = gettime();
  level.depotstates["nag"].minidletime = level.depotstates["nag"].statemintime;
  level.depotstates["nag"].idletype = 1;
}

depotxoverinit() {
  level.depotstates["xover"].statemintime = 60000;
  level.depotstates["xover"].statemaxtime = 90000;
  level.depotstates["xover"].laststatetime = gettime();
  level.depotstates["xover"].idletype = 1;
}

depotbrokeinit() {
  level.depotstates["broke"].statemintime = 20000;
  level.depotstates["broke"].statemaxtime = 40000;
  level.depotstates["broke"].laststatetime = gettime() - level.depotstates["broke"].statemaxtime;
  level.depotstates["broke"].idletype = 1;
}

depotcreditreminderinit() {
  level.depotstates["creditreminder"].statemintime = 60000;
  level.depotstates["creditreminder"].statemaxtime = 90000;
  level.depotstates["creditreminder"].laststatetime = gettime();
  level.depotstates["creditreminder"].idletype = 1;
}

depoteasteregginit() {
  level.depotstates["easteregg"].statemintime = 120000;
  level.depotstates["easteregg"].statemaxtime = 240000;
  level.depotstates["easteregg"].laststatetime = gettime() - level.depotstates["easteregg"].statemaxtime;
  level.depotstates["easteregg"].idletype = 1;
}

depotpurchaseinit() {
  if(isdefined(level.depotstates["purchase"].animname))
    level.depotstates["purchase"].origanimname = level.depotstates["purchase"].animname;
}

depotcanswitchtopause(var_0) {
  return 1;
}

depotcanswitchtogreetingidle(var_0) {
  return _func_306(level.depotcontroller, "onboarding") > 0;
}

depotcanswitchtogreetingfirst(var_0) {
  return 1;
}

depotcanswitchtogreeting(var_0) {
  if(var_0 == "")
    return 1;

  return 0;
}

depotcanswitchtoidle(var_0) {
  if(!hasvisiteddepot()) {
    thread depotdelaysetstate("greetingfirst", 0.05);
    return 0;
  }

  return var_0 != "purchaseconfirm" && var_0 != "purchasefail" && var_0 != "purchasewait";
}

depotcanswitchtofidget(var_0) {
  if(var_0 == "idle")
    return 1;

  return 0;
}

depotcanswitchtonag(var_0) {
  if(var_0 == "idle" && isdefined(level.depotidlestarttime) && gettime() - level.depotidlestarttime > level.depotstates["nag"].minidletime && gettime() - level.depotstates["nag"].laststatetime > randomfloatrange(level.depotstates["nag"].statemintime, level.depotstates["nag"].statemaxtime))
    return 1;

  return 0;
}

depotcanswitchtoxover(var_0) {
  return 0;

  if(var_0 == "idle" && gettime() - level.depotstates["xover"].laststatetime > randomfloatrange(level.depotstates["xover"].statemintime, level.depotstates["xover"].statemaxtime))
    return 1;

  return 0;
}

depotcanswitchtobroke(var_0) {
  if(level.depotbrokeattempts > level.depoteastereggthreshhold) {
    thread depotdelaysetstate("easteregg", 0.05);
    return 0;
  }

  if(var_0 == "idle" && gettime() - level.depotstates["broke"].laststatetime > randomfloatrange(level.depotstates["broke"].statemintime, level.depotstates["broke"].statemaxtime))
    return 1;

  return 0;
}

depotcanswitchtocreditreminder(var_0) {
  if(var_0 == "idle" && gettime() - level.depotstates["creditreminder"].laststatetime > randomfloatrange(level.depotstates["creditreminder"].statemintime, level.depotstates["creditreminder"].statemaxtime) && hasabunduntcurrency())
    return 1;

  return 0;
}

depotcanswitchtonewproduct(var_0) {
  if(var_0 == "greeting" && hasnewproduct())
    return 1;

  return 0;
}

depotcanswitchtoeasteregg(var_0) {
  if(var_0 == "idle" && gettime() - level.depotstates["easteregg"].laststatetime > randomfloatrange(level.depotstates["easteregg"].statemintime, level.depotstates["easteregg"].statemaxtime))
    return 1;

  return 0;
}

depotcanswitchtopurchase(var_0) {
  return 1;
}

depotcanswitchtopurchasewait(var_0) {
  return 1;
}

depotcanswitchtopurchaseconfirm(var_0) {
  return 1;
}

depotcanswitchtopurchasefail(var_0) {
  return 1;
}

depotcanswitchtopurchaseidle(var_0) {
  return 1;
}

depotswitchingtopause(var_0) {
  level.depotagent stopsounds();
  level.depotlackey.sceneent scriptmodelclearanim();
}

depotswitchingtogreetingidle(var_0) {}

depotswitchingtogreetingfirst(var_0) {
  sethasvisiteddepot();

  if(level.camparams.camera.depotpos != "dealer")
    thread playertransitiontodealer();
}

depotswitchingtogreeting(var_0) {
  var_1 = level.depotstates["greeting"].animname;
  level.depotstates["greeting"].animname = "greeting";

  if(hascrossoverloot() && level.depotagent hasanimstate("armory_" + level.depotscene + "_greeting_xover"))
    level.depotstates["greeting"].animname = "greeting_xover";
}

depotswitchingtoidle(var_0) {
  if(level.camparams.camera.depotpos != "dealer") {
    thread playertransitiontodealer();
    thread playbobbleanim();
  }

  if(isdefined(level.depotstates[var_0]) && !maps\mp\_utility::is_true(level.depotstates[var_0].idletype))
    level.depotidlestarttime = gettime();
}

depotswitchingtofidget(var_0) {}

depotswitchingtonag(var_0) {}

depotswitchingtoxover(var_0) {}

depotswitchingtobroke(var_0) {}

depotswitchingtocreditreminder(var_0) {}

depotswitchingtonewproduct(var_0) {}

depotswitchingtoeasteregg(var_0) {
  level.depotbrokeattempts = 0;
}

depotswitchingtopurchase(var_0) {
  thread depotopenlootcrate();

  if(level.camparams.camera.depotpos != "crate")
    thread playertransitiontocrate();

  level.depotstates["purchase"].animname = level.depotstates["purchase"].origanimname;

  if(var_0 != "idle")
    level.depotstates["purchase"].animname = undefined;
}

depotswitchingtopurchasewait(var_0) {}

depotswitchingtopurchaseconfirm(var_0) {}

depotswitchingtopurchasefail(var_0) {
  level.depotcrate scriptmodelclearanim();
  level.depotcrate scriptmodelplayanimdeltamotionfrompos("h1_vlobby_armory_lootcrate_closed_idle", level.depotcrate.originalorigin, level.depotcrate.originalangles);
  setdepotstate("purchaseidle");
}

depotswitchingtopurchaseidle(var_0) {}

depotpauseended() {
  foreach(var_1 in level.depotstates) {
    if(isdefined(var_1.stateinitfunc))
      self[[var_1.stateinitfunc]]();
  }
}

depotgreetingidleended() {}

depotgreetingfirstended() {
  if(canswitchstates())
    setdepotstate("idle");
}

depotgreetingended() {
  if(canswitchstates()) {
    if(hasnewproduct())
      setdepotstate("newproduct");
    else
      setdepotstate("idle");
  }
}

canswitchstates() {
  var_0 = getdepotstate();
  return level.depotstatefinished && var_0 != "purchase";
}

depotidleended() {
  var_0 = gettime() - level.depotstates["idle"].laststatetime > randomfloatrange(level.depotstates["idle"].statemintime, level.depotstates["idle"].statemaxtime);

  if(canswitchstates() && var_0) {
    var_1 = [];
    var_1[var_1.size] = "xover";
    var_1[var_1.size] = "creditreminder";
    var_1[var_1.size] = "nag";
    var_1[var_1.size] = "fidget";

    for (var_2 = 0; var_2 < var_1.size; var_2++) {
      if([
          [level.depotstates[var_1[var_2]].canswitchtostatefunc]
        ]("idle")) {
        level.depotstates[var_1[var_2]].nochecknecessary = 1;
        setdepotstate(var_1[var_2]);
        level.depotstates["idle"].laststatetime = gettime();
        break;
      }
    }
  }
}

depotfidgetended() {
  if(canswitchstates())
    setdepotstate("idle");

  level.depotstates["fidget"].laststatetime = gettime();
}

depotnagended() {
  if(canswitchstates())
    setdepotstate("idle");

  level.depotstates["nag"].laststatetime = gettime();
}

depotxoverended() {
  if(canswitchstates())
    setdepotstate("idle");

  level.depotstates["xover"].laststatetime = gettime();
}

depotbrokeended() {
  if(canswitchstates())
    setdepotstate("idle");

  level.depotstates["broke"].laststatetime = gettime();
}

depotcreditreminderended() {
  if(canswitchstates())
    setdepotstate("idle");

  level.depotstates["creditreminder"].laststatetime = gettime();
}

depotnewproductended() {
  sethasnewproduct();

  if(canswitchstates())
    setdepotstate("idle");
}

depoteastereggended() {
  if(canswitchstates())
    setdepotstate("idle");

  level.depotstates["easteregg"].laststatetime = gettime();
}

depotpurchaseended() {}

depotpurchasewaitended() {}

depotpurchaseconfirmended() {}

depotpurchasefailended() {}

depotpurchaseidleended() {}

depotanimstatemachine() {
  self endon("leave_depot");
  level.depotstatefinished = 0;
  var_0 = "";
  var_1 = -1;
  var_2 = "";
  maps\mp\_utility::waittillplayersnextsnapshot(self);

  for (;;) {
    var_3 = getdvar("vlDepotState");
    var_4 = 0;

    if(var_3 != var_0 || level.depotstatefinished && var_3 != "pause" || var_4) {
      if(!isdefined(level.depotstates[var_3])) {
        var_3 = var_0;
        setdepotstate(var_3);
        continue;
      }

      if(var_0 != "") {
        self[[level.depotstates[var_0].stateendedfunc]]();
        var_3 = getdvar("vlDepotState");
      }

      if(maps\mp\_utility::is_true(level.depotstates[var_3].nochecknecessary) || self[[level.depotstates[var_3].canswitchtostatefunc]](var_0)) {
        level notify("depot_state_changed");
        level notify("depot_state_" + var_3);
        level.depotstates[var_3].nochecknecessary = 0;
        self[[level.depotstates[var_3].switchingtostatefunc]](var_0);
        level.depotstatefinished = 0;
        var_0 = var_3;
        var_5 = level.depotstates[var_3].animalias;
        var_1 = depotplayscene(level.depotstates[var_3].animname, var_5, level.depotstates[var_3].animlabel);
      } else
        setdepotstate(var_0);
    }

    wait 0.05;
  }
}

depotshowlackeyprops() {
  if(!maps\mp\_utility::is_true(level.showinglackeyprops)) {
    foreach(var_1 in level.depotlackey.props)
    var_1 show();

    level.showinglackeyprops = 1;
  }
}

depotlackeyfidgets() {
  self endon("leave_depot");
  var_0 = 15000;
  var_1 = 30000;
  var_2 = gettime();
  maps\mp\_vl_avatar::hide_avatar(level.depotlackey);

  for (;;) {
    if(gettime() - var_2 > randomfloatrange(var_0, var_1)) {
      maps\mp\_vl_avatar::show_avatar(level.depotlackey, 0);
      depotshowlackeyprops();
      var_3 = thread agentplaydepotanim(level.depotlackey, "armory_lackey_fidgets");
      sceneplayanim(level.depotlackey.sceneent, level.depotlackey.sceneent.scriptednode, level.depotprop getanimentryname("armory_lackey_fidgets_prop", var_3));
      level.depotlackey maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack("lackey_fidget", "end", "armory_lackey_fidgets", var_3);
      maps\mp\_vl_avatar::hide_avatar(level.depotlackey);
      var_2 = gettime();
      wait(var_0 / 1000);
    }

    wait 0.05;
  }
}

depotplayscene(var_0, var_1, var_2) {
  var_3 = -1;

  if(isdefined(var_0)) {
    var_4 = "armory_" + level.depotscene + "_" + var_0;

    if(level.depotagent hasanimstate(var_4)) {
      var_3 = thread agentplaydepotanim(level.depotagent, var_4, var_1, var_2);

      if(level.depotscene == "lackey") {
        if(level.depotlackey hasanimstate(var_4 + "_lackey") && level.depotlackey getanimentrycount(var_4 + "_lackey") > var_3) {
          maps\mp\_vl_avatar::show_avatar(level.depotlackey, 0);
          thread agentplaydepotanim(level.depotlackey, var_4 + "_lackey", var_3);
        } else
          maps\mp\_vl_avatar::hide_avatar(level.depotlackey);

        if(level.depotprop hasanimstate(var_4 + "_prop_lackey") && level.depotprop getanimentrycount(var_4 + "_prop_lackey") > var_3) {
          depotshowlackeyprops();
          sceneplayanim(level.depotlackey.sceneent, level.depotlackey.sceneent.scriptednode, level.depotprop getanimentryname(var_4 + "_prop_lackey", var_3));
        }
      }

      if(level.depotprop hasanimstate(var_4 + "_prop"))
        sceneplayanim(level.depotagent.depotsceneent, level.depotagent.depotsceneent.scriptednode, level.depotprop getanimentryname(var_4 + "_prop", var_3), 0, 1);

      if(isdefined(level.depotspecialanimprops[level.depotscene])) {
        var_5 = [];

        if(isarray(level.depotspecialanimprops[level.depotscene]))
          var_5 = level.depotspecialanimprops[level.depotscene];
        else
          var_5[0] = level.depotspecialanimprops[level.depotscene];

        foreach(var_7 in var_5) {
          var_7 scriptmodelclearanim();
          var_8 = level.depotscene;

          if(isdefined(var_7.animstatesuffix))
            var_8 = var_7.animstatesuffix;

          if(level.depotprop hasanimstate(var_4 + "_prop_" + var_8) && level.depotprop getanimentrycount(var_4 + "_prop_" + var_8) > var_3) {
            var_7 show();

            if(isdefined(var_7.animscenenode)) {
              var_7 scriptmodelplayanimdeltamotionfrompos(level.depotprop getanimentryname(var_4 + "_prop_" + var_8, var_3), var_7.animscenenode.origin, var_7.animscenenode.angles);
              continue;
            }

            var_7 scriptmodelplayanim(level.depotprop getanimentryname(var_4 + "_prop_" + var_8, var_3));
          }
        }
      }
    }
  }

  return var_3;
}

agentplaydepotsound(var_0, var_1, var_2) {
  if(isdefined(var_0.sounds) && isdefined(var_0.sounds[level.depotscene]) && isdefined(var_0.sounds[level.depotscene][var_1])) {
    if(!isarray(var_0.sounds[level.depotscene][var_1]))
      var_0 playsoundonmovingent(var_0.sounds[level.depotscene][var_1]);
    else if(isdefined(var_0.sounds[level.depotscene][var_1][var_2]))
      var_0 playsoundonmovingent(var_0.sounds[level.depotscene][var_1][var_2]);
  }

  if(isdefined(var_0.propsounds) && isdefined(var_0.propsounds[level.depotscene]) && isdefined(var_0.propsounds[level.depotscene][var_1])) {
    foreach(var_5, var_4 in var_0.propsounds[level.depotscene][var_1])
    var_0.props[var_5] playsoundonmovingent(var_4);
  }
}

agentplaydepotanim(var_0, var_1, var_2, var_3) {
  var_4 = var_0 setanimstate(var_1, var_2, 1.0, 0.0);
  thread agentplaydepotsound(var_0, var_3, var_4);

  if(isdefined(var_3))
    thread agentupdatestateonanimend(var_1, var_4, var_3);

  return var_4;
}

agentupdatestateonanimend(var_0, var_1, var_2) {
  level endon("depot_state_changed");
  level.depotagent maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack(var_2, "end", var_0, var_1);
  level.depotstatefinished = 1;
}

playertransitiontocrate() {
  var_0 = level.camparams.camera;
  var_0.depotpos = "crate";
  self setphysicaldepthoffield(2.2, 72.5);
  self playsound("h1_ui_loot_cam_whoosh");
  sceneplayanim(var_0.depotsceneent, var_0.depotsceneent.scriptednode, "h1_vlobby_armory_scene1_cam_zoomin", 1);
  level.depotagent common_scripts\utility::delaycall(1, ::stopsounds);

  if(var_0.depotpos == "crate")
    sceneplayanim(var_0.depotsceneent, var_0.depotsceneent.scriptednode, "h1_vlobby_armory_scene1_cam_loot_idle");
}

playertransitiontodealer() {
  var_0 = level.camparams.camera;
  var_0.depotpos = "dealer";
  thread playerdepot_dof();
  sceneplayanim(var_0.depotsceneent, var_0.depotsceneent.scriptednode, "h1_vlobby_armory_scene1_cam_zoomout", 1);

  if(var_0.depotpos == "dealer")
    sceneplayanim(var_0.depotsceneent, var_0.depotsceneent.scriptednode, "h1_vlobby_armory_scene1_cam_idle");
}

sceneplayanim(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_2)) {
    if(!isdefined(var_4))
      var_4 = 0;

    if(!var_4) {
      var_0 dontinterpolate();
      var_0 scriptmodelclearanim();
    }

    var_0 scriptmodelplayanimdeltamotionfrompos(var_2, var_1.origin, var_1.angles, "scene_node_anim", var_4);
    var_0 thread scenedepotpropnotetracks();

    if(maps\mp\_utility::is_true(var_3))
      var_0 waittillmatch("scene_node_anim", "end");
  }
}

depotopenlootcrate() {
  level notify("openLootCrate");
  level endon("openLootCrate");

  if(level.camparams.camera.depotpos != "crate")
    level.camparams.camera.depotsceneent waittillmatch("scene_node_anim", "crack_crate");

  level.depotcrate scriptmodelclearanim();
  level.depotcrate scriptmodelplayanimdeltamotionfrompos("h1_vlobby_armory_lootcrate_crack_open", level.depotcrate.originalorigin, level.depotcrate.originalangles, "crate_anim");
  level.depotcrate playsound("h1_ui_loot_box_latch");
  level.depotcrate waittillmatch("crate_anim", "end");
  var_0 = getdvar("vlDepotState");

  if(var_0 != "purchasefail") {
    if(var_0 == "purchase") {
      var_0 = "purchasewait";
      setdepotstate(var_0);
    }

    if(var_0 == "purchasewait") {
      level.depotcrate scriptmodelclearanim();
      level.depotcrate scriptmodelplayanimdeltamotionfrompos("h1_vlobby_armory_lootcrate_crack_idle", level.depotcrate.originalorigin, level.depotcrate.originalangles);
      level.depotcrate playloopsound("h1_ui_lootbox_rattle");

      while (getdvar("vlDepotState") == "purchasewait")
        waitframe();
    }

    level.depotcrate stoploopsound();
    var_0 = getdvar("vlDepotState");

    if(var_0 == "purchaseconfirm") {
      if(!isdefined(level.depotlootrarities))
        level waittill("depot_loot_rarities");

      luinotifyevent(&"supply_drop_play_purchase_vo", 0);
      var_1 = int(level.inventoryitemrarity["Common"]);

      for (var_2 = 0; var_2 < level.depotlootrarities.size && var_2 < level.depotlootcards.size; var_2++) {
        level.depotlootcards[var_2].rarity_fx = level._effect[level.raritycardfx[level.inventoryitemrarity["Common"]].fx];
        playfxontag(level.depotlootcards[var_2].rarity_fx, level.depotlootcards[var_2], "tag_card");
        var_1 = int(max(var_1, level.depotlootrarities[var_2]));
      }

      level.depotlootprop scriptmodelplayanim("h1_vlobby_armory_loot_flyout", "card_anim");

      foreach(var_4 in level.depotlootcards)
      var_4 show();

      level.depotcrate scriptmodelclearanim();
      level.depotcrate scriptmodelplayanimdeltamotionfrompos("h1_vlobby_armory_lootcrate_full_open", level.depotcrate.originalorigin, level.depotcrate.originalangles, "crate_anim");
      level.depotcrate playsound("h1_ui_loot_box_open");
      level.depotcrate waittillmatch("crate_anim", "play_fx");
      thread common_scripts\_exploder::exploder(level.raritycardfx[var_1].exploder);

      if(isdefined(level.raritycardfx[var_1].rumble))
        playrumbleonposition(level.raritycardfx[var_1].rumble, self.origin);

      level.depotlootprop waittillmatch("card_anim", "cards_off_screen");
      luinotifyevent(&"supply_drop_ui", 0);
      level.depotlootrarities = undefined;
      level.depotcrate waittillmatch("crate_anim", "crate_shut");
      level.depotcrate playsound("h1_ui_loot_box_close");
      thread common_scripts\_exploder::exploder(201);
      level.depotcrate waittillmatch("crate_anim", "end");

      foreach(var_4 in level.depotlootcards) {
        var_4 ghost();
        stopfxontag(var_4.rarity_fx, var_4, "tag_card");
      }

      luinotifyevent(&"supply_drop_allow_skip", 0);
    }
  }

  setdepotstate("purchaseidle");
  level.depotcrate scriptmodelplayanimdeltamotionfrompos("h1_vlobby_armory_lootcrate_closed_idle", level.depotcrate.originalorigin, level.depotcrate.originalangles);
}

scenedepotpropnotetracks() {
  self notify("depotPropNotetracks");
  self endon("depotPropNotetracks");

  if(!isdefined(level.depotpropnotetrackfx)) {
    return;
  }
  for (;;) {
    self waittill("scene_node_anim", var_0);

    foreach(var_2 in level.depotpropnotetrackfx) {
      if(var_2.startnotetrack == var_0) {
        thread scenerundepotpropeffect(var_2);
        break;
      }
    }

    if(var_0 == "end")
      return;
  }
}

scenerundepotpropeffect(var_0) {
  var_1 = level.depotpropents[var_0.model];
  playfxontag(common_scripts\utility::getfx(var_0.fxref), var_1, var_0.tagname);

  if(maps\mp\_utility::is_true(var_0.islooping)) {
    waittilldepotpropfxdone(var_1, var_0.stopnotetrack);
    stopfxontag(common_scripts\utility::getfx(var_0.fxref), var_1, var_0.tagname);
  }
}

waittilldepotpropfxdone(var_0, var_1) {
  level endon("leave_depot");

  if(!isdefined(var_1))
    var_1 = "forever";

  self waittillmatch("depot_notetrack", var_1);
}

depotaddpropnotetrackfx(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level.depotpropnotetrackfx))
    level.depotpropnotetrackfx = [];

  var_6 = level.depotpropnotetrackfx.size;
  level.depotpropnotetrackfx[var_6] = spawnstruct();
  level.depotpropnotetrackfx[var_6].model = var_0;
  level.depotpropnotetrackfx[var_6].startnotetrack = var_1;
  level.depotpropnotetrackfx[var_6].stopnotetrack = var_5;
  level.depotpropnotetrackfx[var_6].fxref = var_2;
  level.depotpropnotetrackfx[var_6].tagname = var_3;
  level.depotpropnotetrackfx[var_6].islooping = var_4;
}

depotscenelightsoff() {
  foreach(var_1 in level.depotscenes) {
    var_2 = "light_" + var_1;
    var_3 = getentarray(var_2, "targetname");

    if(var_3.size == 0) {
      continue;
    }
    var_4 = var_3[0];

    if(var_4 getlightintensity() == 0) {
      continue;
    }
    foreach(var_6 in var_3) {
      if(!isdefined(var_6.baseintensity))
        var_6.baseintensity = var_6 getlightintensity();

      var_6 setlightintensity(0);
    }
  }
}

depotscenelightson(var_0) {
  var_1 = "light_" + var_0;
  var_2 = getentarray(var_1, "targetname");

  foreach(var_4 in var_2)
  var_4 setlightintensity(var_4.baseintensity);
}

getcurrencybalance(var_0, var_1) {
  if(var_1 != 2)
    return _func_305(var_0, var_1);
  else
    return _func_305(var_0, var_1) * 0.0037037;
}

depotsetupseasonal() {
  var_0 = getdvarint("inventory_contentPromo", 0);

  if(isdefined(level.inventory_contentpromo)) {
    if(level.inventory_contentpromo == var_0) {
      return;
    }
    foreach(var_2 in level.seasonalents) {
      if(isdefined(var_2))
        var_2 delete();
    }

    var_4 = "head_graves_lackey";
    var_5 = "body_graves_lackey";

    if(isdefined(level.depotlackey) && (level.depotlackey.head != var_4 || level.depotlackey.bodymodel != var_5)) {
      level.depotlackey detach(level.depotlackey.head);
      level.depotlackey setmodel(var_5);
      level.depotlackey attach(var_4);
      level.depotlackey.head = var_4;
      level.depotlackey.bodymodel = var_5;
    }
  }

  level.inventory_contentpromo = var_0;
  var_6 = [];

  if(level.inventory_contentpromo == 1) {
    var_2 = spawn("script_model", (13856.5, 1578, -670));
    var_2.angles = (0, 55.686, 0);
    var_2 setmodel("h1_props_depot_gold_coin_pile_lod0");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13865.5, 1566, -669.5));
    var_2.angles = (0, 211.496, 0);
    var_2 setmodel("h1_props_vl_depot_bobblehead");
    var_6[var_6.size] = var_2;

    if(isdefined(level.depotlackey)) {
      var_7 = "head_graves_lackey_irish";
      level.depotlackey detach(level.depotlackey.head);
      level.depotlackey attach(var_7);
      level.depotlackey.head = var_7;
    }
  }

  if(level.inventory_contentpromo == 2) {
    var_2 = spawn("script_model", (13919.7, 1285.6, -703.5));
    var_2.angles = (71.7996, 61.809, 179.07);
    var_2 setmodel("h1_mp_bog_summer_surfboard_01_blue");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13831.5, 1331.5, -689));
    var_2.angles = (358.324, 214.285, 78.4818);
    var_2 setmodel("h1_mp_bog_summer_bodyboard_orange");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13790.7, 1463.1, -660));
    var_2.angles = (1.99531, 319.334, 1.83047);
    var_2 setmodel("h1_mp_bog_summer_floatie_duck");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13860.7, 1318.6, -690.5));
    var_2.angles = (45.0986, 125.457, -9.40193);
    var_2 setmodel("h1_mp_bog_summer_life_preserver_01");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13861.5, 1559.5, -670));
    var_2.angles = (0, 203, 0);
    var_2 setmodel("h1_mp_bog_summer_margarita_glass_full_depot");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13901.2, 1263.6, -652.5));
    var_2.angles = (0, 180, 0);
    var_2 setmodel("h1_mp_bog_summer_pool_ball_01");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13846.5, 1300.5, -664.5));
    var_2.angles = (0, 180, 0);
    var_2 setmodel("home_towels_01b");
    var_6[var_6.size] = var_2;
    var_2 = spawn("script_model", (13782.2, 1429.1, -661.5));
    var_2.angles = (0, 180, 0);
    var_2 setmodel("h1_mp_bog_summer_umbrella_closed_02_red");
    var_6[var_6.size] = var_2;

    if(isdefined(level.depotlackey)) {
      var_8 = "body_graves_lackey_summertime";
      level.depotlackey setmodel(var_8);
      level.depotlackey.bodymodel = var_8;
    }
  }

  level.seasonalents = var_6;
}

playbobbleanim() {
  if(isdefined(level.bobble)) {
    level.bobble scriptmodelclearanim();
    wait 0.5;
    level.bobble scriptmodelplayanim("h1_vlobby_armory_saa_bobblehead_enter", "bobble_notify");
  }
}