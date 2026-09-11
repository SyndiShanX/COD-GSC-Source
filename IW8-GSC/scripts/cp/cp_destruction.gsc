/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_destruction.gsc
***********************************************/

function init_damageable_start_door() {
  level.startdoorstruct = scripts\engine\utility::getStruct("damage_starting_door", "script_noteworthy");

  if(!isDefined(level.startdoorstruct)) {
    return;
  }

  var0 = getEntArray(level.startdoorstruct.target, "targetname");

  foreach(var2 in var0) {
    thread watchfordoorenttriggered();
  }

  scripts\cp\cp_objectives::setomnvarbasedonindex(6);
}

function watchfordoorenttriggered() {
  level endon("new_objective_chosen");
  level.startdoorstruct waittill("open_doors", var0);

  if(self.classname == "script_brushmodel") {
    self connectpaths();
    self notsolid();
  }

  if(var0 == "Tactical Breaching Hammer") {
    level notify("objective_completed");
    scripts\cp\cp_objectives::clearobjectivetext();
    var1 = scripts\cp\utility::getinteractionbynoteworthy("damage_door");

    foreach(var3 in level.players) {
      scripts\cp\cp_objectives::clearobjectivetextforplayer(var3);
    }

    scripts\cp\cp_objectives::setomnvarbasedonindex(7);
    return;
  }
}

function getanimsdatafromthedestructiontable() {
  var0 = "cp/zombies/coop_destruction_table.csv";
  level.crafteditemsanimdata = [];

  for(var1 = 1; var1 <= 2; var1++) {
    var2 = tablelookup(var0, 0, var1, 1);
    level.crafteditemsanimdata[var2] = spawnStruct();
    level.crafteditemsanimdata[var2].crafteditemindex = var1;
    level.crafteditemsanimdata[var2].crafteditem = var2;
    level.crafteditemsanimdata[var2].player_scr_anim = getplayeranimfile(var2);
    level.crafteditemsanimdata[var2].player_scr_animname = tablelookup(var0, 0, var1, 3);
    level.crafteditemsanimdata[var2].player_scr_eventanim = tablelookup(var0, 0, var1, 4);
    level.crafteditemsanimdata[var2].player_scr_viewmodelanim = tablelookup(var0, 0, var1, 5);
    level.crafteditemsanimdata[var2].obj_scr_anim = getobjanimfile(var2);
    level.crafteditemsanimdata[var2].obj_scr_animname = tablelookup(var0, 0, var1, 7);
  }

  level.func["scriptModelPlayAnim"] = &scriptmodelplayanim;
}

#using_animtree("");

function getobjanimfile(var0) {
  switch (var0) {
    case "Tactical Breaching Hammer":
      return % wm_equip_c4_attach_c4;
    case "Breach Charge":
      return $wm_equip_c4_attach_c4;
  }
}

function getplayeranimfile(var0) {
  switch (var0) {
    case "Tactical Breaching Hammer":
      return % wm_equip_c4_attach;
    case "Breach Charge":
      return % wm_equip_c4_attach;
  }
}

function init_destruction() {
  if(!objective_mlgicon()) {
    level._effect["breach_explode"] = loadfx("vfx/core/blank.vfx");
  } else {
    level._effect["breach_explode"] = loadfx("vfx/iw8_mp/breaches/vfx_gen_door_breach_thick.vfx");
  }

  thread getanimsdatafromthedestructiontable();
  scripts\common\anim::initanim();

  if(!isDefined(level.scr_viewmodelanim)) {
    level.scr_viewmodelanim = [];
  }

  if(!isDefined(level.scr_eventanim)) {
    level.scr_eventanim = [];
  }

  anim.callbacks["TeleportEnt"] = &scripts\cp\cp_anim::teleport_entity;
  anim.callbacks["ShouldDoAnim"] = &scripts\cp\cp_anim::should_do_anim;
  anim.callbacks["DoAnimation"] = &scripts\cp\cp_anim::do_animation;
  anim.callbacks["DoFacialAnim"] = &scripts\cp\cp_anim::do_facial_anim;
  level.destructibles = [];
  thread watchforconnectedplayers();
  wait 3;
  thread init_damageable_start_door();
  add_destructible_array("destructible_door_double", "targetname");
}

function add_destructible_array(var0, var1) {
  var2 = getEntArray(var0, var1);

  foreach(var4 in var2) {
    var5 = spawnStruct();
    add_destructible(var5, var4);
    assigninteractteam(var5, level.teamnamelist);
    thread updatewaitforjoined();

    if(!isDefined(level.destructibles[var0])) {
      level.destructibles[var0] = [];
    }

    level.destructibles[var0][level.destructibles[var0].size] = var5;
    process_action(var5, "init");
  }
}

function pvpve_break_doors() {
  wait 16;

  foreach(var1 in level.destructibles["destructible_door_double"]) {
    foreach(var3 in var1.ents) {
      if(isDefined(var3.classname)) {
        if(var3.classname == "script_model" || var3.classname == "script_origin" || var3.classname == "script_brushmodel") {
          var3 delete();
        }
      }
    }
  }

  foreach(var7 in level.usedestructibleobjects) {
    foreach(var9 in var7) {
      var9 delete();
    }
  }
}

function script_model_anims(var0, var1, var2, var3, var4, var5, var6) {
  level.scr_animtree["planter"] = #animtree;
  level.scr_anim["planter"]["plant"] = % wm_equip_c4_attach;
  level.scr_animname["planter"]["plant"] = "wm_equip_c4_attach";
  level.scr_eventanim["planter"]["plant"] = "equip_c4_attach";
  level.scr_viewmodelanim["planter"]["plant"] = "vm_equip_c4_attach";
  level.scr_animtree["lightswitch"] = #animtree;
  level.scr_anim["lightswitch"]["interact_on"] = var0;
  level.scr_animname["lightswitch"]["interact_on"] = var1;
  level.scr_eventanim["lightswitch"]["interact_on"] = var2;
  level.scr_viewmodelanim["lightswitch"]["interact_on"] = var3;

  if(isDefined(var6)) {
    level.scr_animtree[var6] = #animtree;
    level.scr_anim[var6]["plant"] = var4;
    level.scr_animname[var6]["plant"] = var5;
  }

  if(var6 == "c4") {
    level.breachanimlength = getanimlength(level.scr_anim["planter"]["plant"]);
    return;
  }

  level.breachanimlength = getanimlength(level.scr_anim["lightswitch"]["interact_on"]);
}

function create_player_rig(var0, var1, var2, var3) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0 predictstreampos(var0.origin);
  var4 = spawn("script_arms", var0.origin, 0, 0, var0);
  var4.player = var0;
  var0.player_rig = var4;
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0 scripts\common\utility::allow_fire(0);
  var0 scripts\common\utility::allow_ads(0);

  if(isDefined(var1) && var1 == "planter") {
    var0 playerlinktodelta(var0.player_rig, "tag_player", 0, 0, 0, 0, 0, 0, 0);
  } else {
    var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  }

  watch_remove_rig(var0);
  remove_player_rig(var0);
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig) || !isDefined(var0.origin)) {
    return;
  }

  var0 unlink();

  if(isDefined(var0 getdroptofloorposition(var0.origin))) {
    var0 setOrigin(var0 getdroptofloorposition(var0.origin));
  }

  var0.player_rig delete();
  var0.player_rig = undefined;
  var0 scripts\common\utility::allow_fire(1);
  var0 scripts\common\utility::allow_ads(1);
  var0 notify("remove_rig");
}

function watch_remove_rig(var0) {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
}

function add_destructible(var0, var1) {
  if(!isDefined(var0.ents)) {
    var0.ents = [];
  }

  read_properties(var0, var1);
  read_actions(var0, var1);
  var0.ents[var0.ents.size] = var1;
  var1.parent = var0;

  if(isDefined(var1.target)) {
    var2 = getEntArray(var1.target, "targetname");
    var3 = scripts\engine\utility::getStructArray(var1.target, "targetname");

    if(isDefined(var2) && var2.size > 0) {
      foreach(var5 in var2) {
        add_destructible(var0, var5);
      }
    }

    if(isDefined(var3) && var3.size > 0) {
      foreach(var8 in var3) {
        add_destructible(var0, var8);
      }

      return;
    }

    return;
  }
}

function read_properties(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(self.previewbomb)) {
    self.previewbomb = [];
  }

  if(!isDefined(var0.classname)) {
    if(isDefined(var0.script_parameters)) {
      switch (var0.script_parameters) {
        case "bomb_preview_2":
        case "bomb_preview":
          var1 = var0.script_label;
          var2 = var0.script_parameters;

          if(isDefined(var2)) {
            self.previewbomb[var0.script_parameters] = var0;
          }

          break;
      }

      return;
    }

    return;
  }

  switch (var0.classname) {
    case "trigger_use_touch":
      var3 = var0.name;

      if(isDefined(var3)) {
        switch (var3) {
          case "bomb_trigger_2":
          case "bomb_trigger_1":
            self.use_triggers[var3] = var0;
            break;
        }
      }

      break;
    case "script_model":
      var1 = var0.script_label;
      var2 = var0.script_parameters;

      if(isDefined(var2)) {
        if(var0.script_label == self.ents[0].name) {
          self.previewbomb[var0.script_label] = var0;
        }
      }

      var4 = var0.name;

      if(isDefined(var4)) {
        self.weapontouse = var4;
      }

      break;
  }
}

function read_actions(var0) {
  if(!isDefined(var0.script_noteworthy)) {
    return;
  }

  var1 = strtok(var0.script_noteworthy, ",");

  foreach(var3 in var1) {
    var4 = strtok(var3, "|");

    if(!isDefined(var4)) {
      return;
    }

    if(var4.size < 2) {
      return;
    }

    var3 = var4[0];

    if(!isDefined(var0.actions)) {
      var0.actions = [];
    }

    if(!isDefined(var0.actions[var3])) {
      var0.actions[var3] = [];
    }

    for(var5 = 1; var5 < var4.size; var5++) {
      var0.actions[var3][var0.actions[var3].size] = var4[var5];
    }
  }
}

function process_action(var0) {
  if(!isDefined(self.ents)) {
    return;
  }

  foreach(var2 in self.ents) {
    if(isDefined(var2.actions) && isDefined(var2.actions[var0])) {
      foreach(var4 in var2.actions[var0]) {
        actionmap(var2, var4, self);
      }
    }
  }

  self.state = var0;
}

function process_action_override(var0, var1, var2) {
  if(!isDefined(self.ents)) {
    return;
  }

  foreach(var4 in self.ents) {
    if(isDefined(var4.actions) && isDefined(var4.actions[var0])) {
      foreach(var6 in var4.actions[var0]) {
        if(var6 == var1) {
          var6 = var2;
        }

        actionmap(var4, var6, self);
      }
    }
  }

  self.state = var0;
}

function actionmap(var0, var1) {
  switch (var0) {
    case "onuse":
      if(isDefined(level.actionmapfuncs) && isDefined(level.actionmapfuncs["onuse"])) {
        level[[level.actionmapfuncs["onuse"]]](var1);
      }

      break;
    case "show":
      if(isent(self)) {
        self show();
      }

      break;
    case "hide":
      if(isent(self)) {
        self hide();
      }

      break;
    case "solid":
      if(isent(self)) {
        self solid();
      }

      break;
    case "notsolid":
      if(isent(self)) {
        self notsolid();
      }

      break;
    case "disconnectpaths":
      if(isent(self)) {
        self disconnectPaths();
      }

      break;
    case "connectpaths":
      if(isent(self)) {
        self connectpaths();
      }

      break;
    case "bomb_explosion":
      var2 = self.origin;
      var3 = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
      var4 = undefined;
      var4 = spawnfx(level._effect["breach_explode"], var2, anglesToForward(var3) * -1, (0, 0, 1));
      triggerfx(var4);
      physicsexplosionsphere(var2, 200, 100, 3);

      foreach(var6 in level.players) {
        if(distancesquared(var6.origin, var2) > 562500) {
          continue;
        }

        var6 shellshock("bradley_mp_turret", 2);
      }

      earthquake(0.5, 1, var2, 1000);

      if(soundexists("breach_c4_expl_trans")) {
        playsoundatpos(var2, "breach_c4_expl_trans");
      }

      waitframe();
      var4 delete();
      break;
    case "crowbar_break":
      var2 = self.origin;
      earthquake(0.2, 1, var2, 1000);

      if(soundexists("breach_c4_expl_trans")) {
        playsoundatpos(var2, "breach_c4_expl_trans");
      }

      break;
  }
}

function destructible_interactions() {
  if(getdvarint("scr_c130_nobreach", 0) == 0) {
    scripts\cp\cp_interaction::registerinteraction("destructible_door_double", &breach_hint_func, &plantbreachweapon, &initbreachpoint);
    return;
  }
}

function breach_hint_func(var0, var1) {
  var2 = "";

  if(isDefined(level.fubar_hint_breach)) {
    return [[level.fubar_hint_breach]](var0, var1);
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if((!isDefined(var1.powers["power_c4"]) || var1.powers["power_c4"].charges <= 0) && istrue(var1.has_crowbar)) {
      thread testanimationduringuseduration(var1, var0);
      var1.interaction_trigger sethinticon("hud_icon_door_breach");
      var1.interaction_trigger sethintrequiresholding(1);
      var1.interaction_trigger setuseholdduration("duration_long");
      var1.interaction_trigger sethintdisplayrange(96);
      var1.interaction_trigger sethintdisplayfov(270);
      var1.interaction_trigger setuserange(96);
      var1.interaction_trigger setusefov(270);
      var2 = &"COOP_CRAFTING/BREACH_CROWBAR_HINT";
    } else if(isDefined(var1.powers["power_c4"]) || !istrue(var1.has_crowbar) || istrue(var1.forcedc4)) {
      var1.interaction_trigger sethinticon("hud_icon_c4_plant");
      var2 = &"COOP_CRAFTING/BREACH_HINT";
    }
  } else if((!isDefined(var1.powers["power_c4"]) || var1.powers["power_c4"].charges <= 0) && istrue(var1.has_crowbar)) {
    thread testanimationduringuseduration(var1, var0);

    if(!isotherplayersnearpoint(var0.origin, var1)) {
      var1.last_interaction_point = undefined;
      var1.interaction_trigger sethinticon("hud_icon_loot_helmet");
      var2 = &"CP_SURIVAL/BARN_BREACH";
      var1.interaction_trigger sethintstringparams(1);
    } else {
      var1.last_interaction_point = undefined;
      var1.interaction_trigger sethinticon("hud_icon_door_breach");
      var1.interaction_trigger sethintrequiresholding(1);
      var1.interaction_trigger setuseholdduration("duration_medium");
      var2 = &"COOP_CRAFTING/BREACH_CROWBAR_HINT";
    }
  } else if(isDefined(var1.powers["power_c4"]) || istrue(var1.forcedc4)) {
    var1.interaction_trigger sethinticon("hud_icon_c4_plant");
    var2 = &"COOP_CRAFTING/BREACH_HINT";
  }

  return var2;
}

function testanimationduringuseduration(var0, var1) {
  var1 notify("testAnimationDuringUseDuration");
  var1 endon("testAnimationDuringUseDuration");
  var2 = var1 scripts\engine\utility::waittill_any_ents_return(var1.interaction_trigger, "trigger_progress");

  if(!isDefined(var0.script_noteworthy) || var0.script_noteworthy != "destructible_door_double") {
    return;
  }

  thread plantbreachweapon(var1, var0, var1);
  var1 endon("set_interaction_point");
  thread earlyexit(var1);
  var2 = var1 scripts\engine\utility::waittill_any_ents_return(var1.interaction_trigger, "trigger", var1, "set_interaction_point", var1, "starting_interaction_search", var1, "left_early", level, "door_breached");

  if(isDefined(var2) && var2 != "left_early") {
    var1 notify("trigger_success");
  }

  remove_player_rig(var1);

  if(isDefined(var1.linktoent)) {
    var1 unlink();
    var1.linktoent delete();
    var1.linktoent = undefined;
  }

  var1.isbreaching = 0;
  var1 stopgestureviewmodel("ges_vest_replace");
}

function earlyexit(var0) {
  var0 endon("death");
  var0 endon("disconnect");
  var0 endon("set_interaction_point");
  var0 endon("trigger_success");

  while(var0 useButtonPressed()) {
    waitframe();
  }

  var0 notify("left_early");
}

function initbreachpoint(var0) {
  foreach(var2 in var0) {
    if(var2.script_noteworthy == "destructible_door_double") {
      add_destructible(var2, var2);
      storeothersideobjectreference(var2);
      thread cleanupthreadforbombobject(var2);

      foreach(var4 in var0) {
        if(var4 != var2) {
          if(var2.target == var4.target) {
            var2.opposite_struct = var4;
            storeothersideobjectreference(var2.opposite_struct);
          }
        }
      }
    }
  }
}

function breach_use_func(var0, var1) {
  if(level.gametype == "cp_survival") {
    level notify("defend_sequence_started");
    scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy(var0.script_noteworthy);
    return;
  }
}

function isotherplayersnearpoint(var0, var1) {
  level endon("game_ended");
  var2 = 0;

  foreach(var4 in level.players) {
    if(var4 != var1) {
      if(distance(var4.origin, var0) <= 96) {
        var2 = 1;
        break;
      }
    }
  }

  return var2;
}

function storeothersideobjectreference(var0) {
  if(!isDefined(level.usedestructibleobjects)) {
    level.usedestructibleobjects = [];
  }

  level.usedestructibleobjects[level.usedestructibleobjects.size] = var0;
}

function watchforconnectedplayers() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var0);
    thread showandhidebreachobjectsbasedonavailability();
  }
}

function showandhidebreachobjectsbasedonavailability() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self notify("one_instance_of_showhidebreachobjfunc");
  self endon("one_instance_of_showhidebreachobjfunc");

  for(;;) {
    var0 = scripts\engine\utility::ref_143ad("disable_breach_hint", "enable_breach_hint");

    if(!isDefined(var0)) {
      continue;
    }

    if(!isDefined(level.usedestructibleobjects)) {
      continue;
    }

    switch (var0) {
      case "disable_breach_hint":
        foreach(var2 in level.usedestructibleobjects) {
          if(isDefined(var2) && scripts\engine\utility::array_contains(level.current_interaction_structs, var2)) {
            var2.temp_disable_interaction = 1;
            scripts\cp\cp_interaction::remove_from_current_interaction_list(var2);
          }
        }

        break;
      case "enable_breach_hint":
        foreach(var2 in level.usedestructibleobjects) {
          if(isDefined(var2)) {
            if(isDefined(var2.temp_disable_interaction) && var2.temp_disable_interaction == 1) {
              var2.temp_disable_interaction = 0;
              scripts\cp\cp_interaction::add_to_current_interaction_list(var2);
            }
          }
        }

        break;
    }
  }
}

function cleanupthreadforbombobject(var0) {
  self waittill("delete_this_thread_for_" + var0.target);

  switch (var0.name) {
    case "bomb_preview":
      foreach(var2 in var0.ents) {
        if(isDefined(var2.classname)) {
          if(var2.classname == "script_model" || var2.classname == "script_origin" || var2.classname == "script_brushmodel") {
            var2 delete();
          }
        }
      }

      break;
    case "bomb_preview_2":
      foreach(var2 in var0.ents) {
        if(isDefined(var2.classname)) {
          if(var2.classname == "script_model" || var2.classname == "script_origin" || var2.classname == "script_brushmodel") {
            var2 delete();
          }
        }
      }

      break;
  }
}

function getanimdataforexplosive(var0) {
  foreach(var2 in level.crafteditemsanimdata) {
    if(var2.crafteditem == var0) {
      return var2;
    }
  }
}

function chooserandomexplosive() {
  var0 = ["Breach Charge"];
  var1 = scripts\engine\utility::random(var0);
  return var1;
}

function hasrequiredcrafteditemfordestruction(var0) {
  foreach(var2 in self.crafteditemslist) {
    if(var0 == var2) {
      return true;
    }
  }

  return false;
}

function plantbreachweapon(var0, var1, var2) {
  var1 endon("left_early");
  var1 endon("breach_restart");

  if(var0.script_noteworthy != "destructible_door_double") {
    return;
  }

  if(isDefined(level.fubar_breach_logic)) {
    return self[[level.fubar_breach_logic]](var0, var1);
  }

  if(isDefined(level.fubar_breach_logic_plane_combat)) {
    if(!istrue([[level.fubar_breach_logic_plane_combat]](var0, var1))) {
      return;
    }
  }

  var3 = 1;

  if(!level.only_one_player) {
    var4 = 2;
  } else {
    var4 = 1;
  }

  if((!isDefined(var2.powers["power_c4"]) || var2.powers["power_c4"].charges <= 0) && isDefined(var3) && istrue(var2.has_crowbar)) {
    var5 = 3.3;
    var6 = 1;
    crowbar_use_activate(var2, var1, var4, var4, var5, var6);
    return 1;
  } else if(!isDefined(var4.throwinggrenade) && !isDefined(self.plantedbomb)) {
    bomb_use_activate(var4, var3);
    return 1;
  }

  return 0;
}

function bomb_use_activate(var0, var1) {
  if(isDefined(var0.forcedc4) && !var0.forcedc4) {
    var0 thread scripts\cp\cp_powers::power_adjustcharges(-1, var0.powers["power_c4"].slot);
  }

  if(istrue(var0.breaching)) {
    return;
  }

  var0.breaching = 1;

  if(isPlayer(var0)) {
    bomb_anim_think(var1, var0, var1);
  }

  thread actionmap(var1, "onuse");

  if(isPlayer(var0)) {
    remove_player_rig(var0);
  }

  thread bomb_planted_think(var1, var0);
}

function bomb_anim_think(var0, var1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var1);
  var1.players_using_breach = -1;

  if(isDefined(var1.opposite_struct)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var1.opposite_struct);
  }

  script_model_anims(%wm_equip_c4_attach, "wm_equip_c4_attach", "equip_c4_attach", "vm_equip_c4_attach", %wm_equip_c4_attach_c4, "wm_equip_c4_attach_c4", "c4");

  if(!isDefined(var0.interaction_trigger)) {
    return;
  }

  thread watchplayerdeath(var0);
  var0.linktoent = var0 scripts\engine\utility::spawn_tag_origin();
  var0 playerlinktodelta(var0.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var0.linktoent moveTo(var1.origin, 0.25, 0.1, 0.1);

  if(!isDefined(var1.angles)) {
    var1.angles = (0, 0, 0);
  }

  var0.linktoent rotateTo(var1.angles, 0.25, 0.1, 0.1);
  var0 setstance("stand");
  wait 0.29;

  if(istrue(self.cancelplant)) {
    return 0;
  }

  var0 unlink();
  var0.linktoent delete();
  var0.linktoent = undefined;
  thread create_player_rig(var0, "planter");
  var0 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "plant");
  var0 setstance("stand");
  var2 = spawn("script_model", var1.origin);
  var2 setModel("offhand_wm_c4");
  var2.animname = "c4";
  var2 useanimtree(#animtree);
  self.plantedbomb = var2;
  var1 thread scripts\common\anim::anim_single_solo(var2, "plant");
  wait getanimlength(level.scr_anim["planter"]["plant"]);

  if(istrue(self.cancelplant)) {
    return 0;
  }
}

function bomb_planted_think(var0, var1) {
  var1 endon("stop_bomb_think");

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  var0.breaching = undefined;

  if(!istrue(var1.no_fuse)) {
    bomb_fuse_think(var1);
  }

  process_action("destroyed");
  process_action(var1, "destroyed");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var1);

  if(isDefined(var1.opposite_struct)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var1.opposite_struct);
  }

  wait 0.1;

  if(isDefined(self.plantedbomb)) {
    if(isDefined(var0)) {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 1000, 100, var0, "MOD_EXPLOSIVE");
    } else {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 1000, 100, undefined, "MOD_EXPLOSIVE");
    }
  }

  level notify("door_breached", self.origin, var1);

  if(isDefined(self.plantedbomb)) {
    self.plantedbomb delete();
    self.plantedbomb = undefined;
  }

  var2 = getEntArray("final_breach_collision", "targetname");
  var3 = scripts\engine\utility::getclosest(var1.origin, var2, 100);

  if(isDefined(var3)) {
    var3 connectpaths();
    var3 delete();
  }

  if(isDefined(level.fubar_breach_spawners)) {
    GscBinSkip1(0x74, level.fubar_breach_spawners, self.origin);
  }

  var1 notify("delete_this_thread_for_" + var1.target);
}

function bomb_fuse_think(var0) {
  var1 = gettime();
  var2 = int(var1 + 5000);
  var3 = var2 - var1;

  while(var3 > 0) {
    var1 = gettime();
    var3 = var2 - var1;

    if(var3 < 1500) {
      if(var3 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          self.plantedbomb playSound("breach_warning_beep_05");
        }
      } else if(var3 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          self.plantedbomb playSound("breach_warning_beep_04");
        }
      } else if(var3 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          self.plantedbomb playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        self.plantedbomb playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var3 < 3500) {
      if(soundexists("breach_warning_beep_02")) {
        self.plantedbomb playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01")) {
        self.plantedbomb playSound("breach_warning_beep_01");
      }

      wait 1;
    }

    if(var3 < 0) {
      break;
    }
  }
}

function crowbar_use_activate(var0, var1, var2, var3, var4, var5) {
  if(crowbar_breach_try_think(var0, var1, var2, var3, var4 - var5)) {
    thread crowbar_planted_think(var0, var1);
    process_action("onuse");
    actionmap("onuse", self);
    self notify("breach_complete");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var1);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var1.opposite_struct);
    return 1;
  }

  remove_player_rig(var0);
  var0.isbreaching = 0;
  return 0;
}

function crowbar_breach_try_think(var0, var1, var2, var3, var4) {
  crowbar_anim_think(var0, var1, var2);
  wait var4;

  if(istrue(self.cancelplant)) {
    return false;
  }

  var2 = getnumplayersusingthisinteraction(var1);

  if(var2 >= var3) {
    return true;
  }

  return false;
}

function crowbar_anim_think(var0, var1, var2) {
  script_model_anims(%wm_eq_fusebox_turn_on_plr, "wm_eq_fusebox_turn_on_plr", "equip_c4_attach", "vm_eq_fusebox_turn_on_plr", %wm_equip_c4_attach_c4, "wm_equip_c4_attach_c4", "c4");

  if(!(var1.script_noteworthy == "destructible_door_double")) {
    return;
  }

  thread watchplayerdeath(var0);
  var0.linktoent = var0 scripts\engine\utility::spawn_tag_origin();
  var0 playerlinktodelta(var0.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var0.isbreaching = 1;
  var2 = getnumplayersusingthisinteraction(var1);
  setbreachernum(var2, var0, var1);

  if(!isDefined(var0.breachernum)) {
    var0.breachernum = 1;
  }

  if(var0.breachernum == 1) {
    if(distance(var0.origin, var1.origin) > 3) {
      var0.linktoent moveTo((var1.origin + var0.origin) / 2, 0.25, 0.05, 0.05);
    } else {
      var0.linktoent moveTo(var1.origin, 0.25, 0.05, 0.05);
    }

    var3 = getplayerrotationforbreach(var1, var0);
    var0.linktoent rotateTo(var3, 0.25, 0.05, 0.05);
  } else if(var0.breachernum == 2) {
    if(distance(var0.origin, var1.origin) > 3) {
      var0.linktoent moveTo((var1.origin + var0.origin) / 2, 0.25, 0.05, 0.05);
    } else {
      var0.linktoent moveTo(var1.origin, 0.25, 0.05, 0.05);
    }

    var3 = getplayerrotationforbreach(var1, var0);
    var0.linktoent rotateTo(var3, 0.25, 0.05, 0.05);
  }

  var0 setstance("stand");
  wait 0.29;

  if(istrue(self.cancelplant)) {
    return 0;
  }

  if(isDefined(var0.linktoent)) {
    var0 unlink();
    var0.linktoent delete();
    var0.linktoent = undefined;
  }

  thread create_player_rig(var0);
  var4 = 2;
  var0 forceplaygestureviewmodel("ges_vest_replace");
  wait var4;

  if(istrue(self.cancelplant)) {
    return 0;
  }

  var0 forceplaygestureviewmodel("ges_zombies_revive_jock");
  waitframe();

  if(istrue(self.cancelplant)) {
    return 0;
  }

  var0 forceplaygestureviewmodel("ges_vest_replace");

  if(var2 == 1) {
    for(var5 = 0; var5 < 1; var5++) {
      wait var4;

      if(istrue(self.cancelplant)) {
        return 0;
      }

      var0 forceplaygestureviewmodel("ges_zombies_revive_jock");
      waitframe();

      if(istrue(self.cancelplant)) {
        return 0;
      }

      var0 forceplaygestureviewmodel("ges_vest_replace");
    }

    return;
  }
}

function crowbar_planted_think(var0, var1) {
  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  process_action_override(var1, "destroyed", "bomb_explosion", "crowbar_break");
  wait 0.1;
  level notify("door_breached", self.origin);
  remove_player_rig(var0);
  var1 notify("delete_this_thread_for_" + var1.target);
}

function getplayerrotationforbreach(var0, var1) {
  var2 = var0.origin - var1.origin;
  var3 = var0.opposite_struct.origin - var1.origin;
  var4 = (var2 + var3) / 2;
  var5 = vectortoangles(var4);
  return var5;
}

function getnumplayersusingthisinteraction(var0) {
  var1 = 0;

  foreach(var3 in level.players) {
    if(istrue(var3.isbreaching)) {
      if(distance(var3.origin, var0.origin) <= 96) {
        var3.last_interaction_point = var0;
      }
    }

    if(isDefined(var3.last_interaction_point) && isDefined(var3.last_interaction_point.target)) {
      if(var0.target == var3.last_interaction_point.target) {
        if(istrue(var3.isbreaching)) {
          var1++;
        }
      }
    }
  }

  return var1;
}

function getplayersusingthisinteraction(var0) {
  var1 = [];
  var2 = 0;

  foreach(var4 in level.players) {
    var2++;

    if(isDefined(var4.last_interaction_point) && isDefined(var4.last_interaction_point.target)) {
      if(var0.target == var4.last_interaction_point.target) {
        if(isDefined(var4.isbreaching) && var4.isbreaching) {
          var1 = var4;
        }
      }
    }
  }

  return var1;
}

function setbreachernum(var0, var1, var2) {
  var3 = 1;

  if(var0 == 1) {
    var1.breachernum = var3;
    return;
  }

  if(var0 == 2) {
    foreach(var5 in getplayersusingthisinteraction(var2)) {
      var1.breachernum = var3;
      var3++;
    }

    return;
  }
}

function usetriggerholdloop(var0, var1) {
  while(usetest(var0, var1)) {
    var0.curprogress += 50 * var0.userate;

    if(var0.curprogress >= var0.usetime) {
      return var1 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

function usetest(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!var1 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!var1 useButtonPressed()) {
    return false;
  }

  if(!nullweapon(var1 getheldoffhand())) {
    return false;
  }

  if(var1 meleeButtonPressed()) {
    return false;
  }

  if(var0.curprogress >= var0.usetime) {
    return false;
  }

  return true;
}

function watchplayerdeath(var0) {
  self endon("breach_complete");
  var0 endon("disconnect");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var0) || !var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var1 = undefined;

      foreach(var3 in self.ents) {
        foreach(var5 in var3.parent.previewbomb) {
          if(var5.script_label == "bomb_preview" || var5.script_label == "bomb_preview_2") {
            var1 = var5;
          }
        }
      }

      self.useobjects[var1.script_label] show();

      if(isDefined(self.plantedbomb)) {
        self.plantedbomb delete();
        self.plantedbomb = undefined;
      }

      self.cancelplant = 1;
      break;
    }

    waitframe();
  }
}

function updatewaitforjoined() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var0);
    applyinteractteam(var0);
  }
}

function assigninteractteam(var0) {
  foreach(var2 in level.players) {
    applyinteractteam(var2);
  }
}

function applyinteractteam(var0) {
  var0 endon("disconnect");

  if(level.gametype == "cp_pvpve") {
    return;
  }

  var1 = undefined;

  foreach(var3 in self.ents) {
    if(!isDefined(var3)) {
      continue;
    }

    if(!isDefined(var3.parent.previewbomb)) {
      continue;
    }

    foreach(var5 in var3.parent.previewbomb) {
      if(var5.script_label == "bomb_preview" || var5.script_label == "bomb_preview_2") {
        var1 = var5;
      }
    }
  }

  if(isDefined(self.useobjects)) {
    foreach(var9 in self.useobjects) {
      var9 enableplayeruse(var0);
      var9 showtoplayer(var0);
    }

    return;
  }
}

function killtriggerloop(var0) {
  level endon("game_ended");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isDefined(var1)) {
      if(isPlayer(var1)) {
        var1 suicide();
        var2 = var1 getcorpseentity();
        var2 hide(1);
        var2.permhidden = 1;

        if(var1.loadoutarchetype == "archetype_scout") {
          playFX(level._effect["reaper_kill_robot"], var1.origin + (0, 0, 12));
        } else {
          playFX(level._effect["grinder_kill"], var1.origin + (0, 0, 12));
        }

        continue;
      }

      if(isDefined(var1.classname) && var1.classname == "script_vehicle") {
        if(isDefined(var1.streakname)) {
          if(var1.streakname == "minijackal") {
            var1 notify("minijackal_end");
            continue;
          }

          if(var1.streakname == "venom") {
            var1 notify("venom_end", var1.origin);
          }
        }
      }
    }
  }
}

function droptonavmeshtriggers() {
  wait 1;
  var0 = spawn("trigger_radius", (256, 800, 16), 0, 256, 500);
  var0 hide();
  level.droptonavmeshtriggers[level.droptonavmeshtriggers.size] = var0;
}