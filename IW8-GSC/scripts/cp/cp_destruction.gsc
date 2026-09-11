/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_destruction.gsc
***********************************************/

function init_damageable_start_door() {
  level.startdoorstruct = scripts\engine\utility::getStruct("damage_starting_door", "script_noteworthy");

  if(!isDefined(level.startdoorstruct)) {
    return;
  }

  var_0 = getEntArray(level.startdoorstruct.target, "targetname");

  foreach(var_2 in var_0) {
    thread watchfordoorenttriggered();
  }

  scripts\cp\cp_objectives::setomnvarbasedonindex(6);
}

function watchfordoorenttriggered() {
  level endon("new_objective_chosen");
  level.startdoorstruct waittill("open_doors", var_0);

  if(self.classname == "script_brushmodel") {
    self connectpaths();
    self notsolid();
  }

  if(var_0 == "Tactical Breaching Hammer") {
    level notify("objective_completed");
    scripts\cp\cp_objectives::clearobjectivetext();
    var_1 = scripts\cp\utility::getinteractionbynoteworthy("damage_door");

    foreach(var_3 in level.players) {
      scripts\cp\cp_objectives::clearobjectivetextforplayer(var_3);
    }

    scripts\cp\cp_objectives::setomnvarbasedonindex(7);
    return;
  }
}

function getanimsdatafromthedestructiontable() {
  var_0 = "cp/zombies/coop_destruction_table.csv";
  level.crafteditemsanimdata = [];

  for(var_1 = 1; var_1 <= 2; var_1++) {
    var_2 = tablelookup(var_0, 0, var_1, 1);
    level.crafteditemsanimdata[var_2] = spawnStruct();
    level.crafteditemsanimdata[var_2].crafteditemindex = var_1;
    level.crafteditemsanimdata[var_2].crafteditem = var_2;
    level.crafteditemsanimdata[var_2].player_scr_anim = getplayeranimfile(var_2);
    level.crafteditemsanimdata[var_2].player_scr_animname = tablelookup(var_0, 0, var_1, 3);
    level.crafteditemsanimdata[var_2].player_scr_eventanim = tablelookup(var_0, 0, var_1, 4);
    level.crafteditemsanimdata[var_2].player_scr_viewmodelanim = tablelookup(var_0, 0, var_1, 5);
    level.crafteditemsanimdata[var_2].obj_scr_anim = getobjanimfile(var_2);
    level.crafteditemsanimdata[var_2].obj_scr_animname = tablelookup(var_0, 0, var_1, 7);
  }

  level.func["scriptModelPlayAnim"] = &scriptmodelplayanim;
}

#using_animtree("");

function getobjanimfile(var_0) {
  switch (var_0) {
    case "Tactical Breaching Hammer":
      return % wm_equip_c4_attach_c4;
    case "Breach Charge":
      return $wm_equip_c4_attach_c4;
  }
}

function getplayeranimfile(var_0) {
  switch (var_0) {
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

function add_destructible_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = spawnStruct();
    add_destructible(var_5, var_4);
    assigninteractteam(var_5, level.teamnamelist);
    thread updatewaitforjoined();

    if(!isDefined(level.destructibles[var_0])) {
      level.destructibles[var_0] = [];
    }

    level.destructibles[var_0][level.destructibles[var_0].size] = var_5;
    process_action(var_5, "init");
  }
}

function pvpve_break_doors() {
  wait 16;

  foreach(var_1 in level.destructibles["destructible_door_double"]) {
    foreach(var_3 in var_1.ents) {
      if(isDefined(var_3.classname)) {
        if(var_3.classname == "script_model" || var_3.classname == "script_origin" || var_3.classname == "script_brushmodel") {
          var_3 delete();
        }
      }
    }
  }

  foreach(var_7 in level.usedestructibleobjects) {
    foreach(var_9 in var_7) {
      var_9 delete();
    }
  }
}

function script_model_anims(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.scr_animtree["planter"] = #animtree;
  level.scr_anim["planter"]["plant"] = % wm_equip_c4_attach;
  level.scr_animname["planter"]["plant"] = "wm_equip_c4_attach";
  level.scr_eventanim["planter"]["plant"] = "equip_c4_attach";
  level.scr_viewmodelanim["planter"]["plant"] = "vm_equip_c4_attach";
  level.scr_animtree["lightswitch"] = #animtree;
  level.scr_anim["lightswitch"]["interact_on"] = var_0;
  level.scr_animname["lightswitch"]["interact_on"] = var_1;
  level.scr_eventanim["lightswitch"]["interact_on"] = var_2;
  level.scr_viewmodelanim["lightswitch"]["interact_on"] = var_3;

  if(isDefined(var_6)) {
    level.scr_animtree[var_6] = #animtree;
    level.scr_anim[var_6]["plant"] = var_4;
    level.scr_animname[var_6]["plant"] = var_5;
  }

  if(var_6 == "c4") {
    level.breachanimlength = getanimlength(level.scr_anim["planter"]["plant"]);
    return;
  }

  level.breachanimlength = getanimlength(level.scr_anim["lightswitch"]["interact_on"]);
}

function create_player_rig(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 predictstreampos(var_0.origin);
  var_4 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_4.player = var_0;
  var_0.player_rig = var_4;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 scripts\common\utility::allow_fire(0);
  var_0 scripts\common\utility::allow_ads(0);

  if(isDefined(var_1) && var_1 == "planter") {
    var_0 playerlinktodelta(var_0.player_rig, "tag_player", 0, 0, 0, 0, 0, 0, 0);
  } else {
    var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  }

  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig) || !isDefined(var_0.origin)) {
    return;
  }

  var_0 unlink();

  if(isDefined(var_0 getdroptofloorposition(var_0.origin))) {
    var_0 setOrigin(var_0 getdroptofloorposition(var_0.origin));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
  var_0 scripts\common\utility::allow_fire(1);
  var_0 scripts\common\utility::allow_ads(1);
  var_0 notify("remove_rig");
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
}

function add_destructible(var_0, var_1) {
  if(!isDefined(var_0.ents)) {
    var_0.ents = [];
  }

  read_properties(var_0, var_1);
  read_actions(var_0, var_1);
  var_0.ents[var_0.ents.size] = var_1;
  var_1.parent = var_0;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");
    var_3 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_5 in var_2) {
        add_destructible(var_0, var_5);
      }
    }

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_8 in var_3) {
        add_destructible(var_0, var_8);
      }

      return;
    }

    return;
  }
}

function read_properties(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self.previewbomb)) {
    self.previewbomb = [];
  }

  if(!isDefined(var_0.classname)) {
    if(isDefined(var_0.script_parameters)) {
      switch (var_0.script_parameters) {
        case "bomb_preview_2":
        case "bomb_preview":
          var_1 = var_0.script_label;
          var_2 = var_0.script_parameters;

          if(isDefined(var_2)) {
            self.previewbomb[var_0.script_parameters] = var_0;
          }

          break;
      }

      return;
    }

    return;
  }

  switch (var_0.classname) {
    case "trigger_use_touch":
      var_3 = var_0.name;

      if(isDefined(var_3)) {
        switch (var_3) {
          case "bomb_trigger_2":
          case "bomb_trigger_1":
            self.use_triggers[var_3] = var_0;
            break;
        }
      }

      break;
    case "script_model":
      var_1 = var_0.script_label;
      var_2 = var_0.script_parameters;

      if(isDefined(var_2)) {
        if(var_0.script_label == self.ents[0].name) {
          self.previewbomb[var_0.script_label] = var_0;
        }
      }

      var_4 = var_0.name;

      if(isDefined(var_4)) {
        self.weapontouse = var_4;
      }

      break;
  }
}

function read_actions(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }

  var_1 = strtok(var_0.script_noteworthy, ",");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "|");

    if(!isDefined(var_4)) {
      return;
    }

    if(var_4.size < 2) {
      return;
    }

    var_3 = var_4[0];

    if(!isDefined(var_0.actions)) {
      var_0.actions = [];
    }

    if(!isDefined(var_0.actions[var_3])) {
      var_0.actions[var_3] = [];
    }

    for(var_5 = 1; var_5 < var_4.size; var_5++) {
      var_0.actions[var_3][var_0.actions[var_3].size] = var_4[var_5];
    }
  }
}

function process_action(var_0) {
  if(!isDefined(self.ents)) {
    return;
  }

  foreach(var_2 in self.ents) {
    if(isDefined(var_2.actions) && isDefined(var_2.actions[var_0])) {
      foreach(var_4 in var_2.actions[var_0]) {
        actionmap(var_2, var_4, self);
      }
    }
  }

  self.state = var_0;
}

function process_action_override(var_0, var_1, var_2) {
  if(!isDefined(self.ents)) {
    return;
  }

  foreach(var_4 in self.ents) {
    if(isDefined(var_4.actions) && isDefined(var_4.actions[var_0])) {
      foreach(var_6 in var_4.actions[var_0]) {
        if(var_6 == var_1) {
          var_6 = var_2;
        }

        actionmap(var_4, var_6, self);
      }
    }
  }

  self.state = var_0;
}

function actionmap(var_0, var_1) {
  switch (var_0) {
    case "onuse":
      if(isDefined(level.actionmapfuncs) && isDefined(level.actionmapfuncs["onuse"])) {
        level[[level.actionmapfuncs["onuse"]]](var_1);
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
      var_2 = self.origin;
      var_3 = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
      var_4 = undefined;
      var_4 = spawnfx(level._effect["breach_explode"], var_2, anglesToForward(var_3) * -1, (0, 0, 1));
      triggerfx(var_4);
      physicsexplosionsphere(var_2, 200, 100, 3);

      foreach(var_6 in level.players) {
        if(distancesquared(var_6.origin, var_2) > 562500) {
          continue;
        }

        var_6 shellshock("bradley_mp_turret", 2);
      }

      earthquake(0.5, 1, var_2, 1000);

      if(soundexists("breach_c4_expl_trans")) {
        playsoundatpos(var_2, "breach_c4_expl_trans");
      }

      waitframe();
      var_4 delete();
      break;
    case "crowbar_break":
      var_2 = self.origin;
      earthquake(0.2, 1, var_2, 1000);

      if(soundexists("breach_c4_expl_trans")) {
        playsoundatpos(var_2, "breach_c4_expl_trans");
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

function breach_hint_func(var_0, var_1) {
  var_2 = "";

  if(isDefined(level.fubar_hint_breach)) {
    return [[level.fubar_hint_breach]](var_0, var_1);
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if((!isDefined(var_1.powers["power_c4"]) || var_1.powers["power_c4"].charges <= 0) && istrue(var_1.has_crowbar)) {
      thread testanimationduringuseduration(var_1, var_0);
      var_1.interaction_trigger sethinticon("hud_icon_door_breach");
      var_1.interaction_trigger sethintrequiresholding(1);
      var_1.interaction_trigger setuseholdduration("duration_long");
      var_1.interaction_trigger sethintdisplayrange(96);
      var_1.interaction_trigger sethintdisplayfov(270);
      var_1.interaction_trigger setuserange(96);
      var_1.interaction_trigger setusefov(270);
      var_2 = &"COOP_CRAFTING/BREACH_CROWBAR_HINT";
    } else if(isDefined(var_1.powers["power_c4"]) || !istrue(var_1.has_crowbar) || istrue(var_1.forcedc4)) {
      var_1.interaction_trigger sethinticon("hud_icon_c4_plant");
      var_2 = &"COOP_CRAFTING/BREACH_HINT";
    }
  } else if((!isDefined(var_1.powers["power_c4"]) || var_1.powers["power_c4"].charges <= 0) && istrue(var_1.has_crowbar)) {
    thread testanimationduringuseduration(var_1, var_0);

    if(!isotherplayersnearpoint(var_0.origin, var_1)) {
      var_1.last_interaction_point = undefined;
      var_1.interaction_trigger sethinticon("hud_icon_loot_helmet");
      var_2 = &"CP_SURIVAL/BARN_BREACH";
      var_1.interaction_trigger sethintstringparams(1);
    } else {
      var_1.last_interaction_point = undefined;
      var_1.interaction_trigger sethinticon("hud_icon_door_breach");
      var_1.interaction_trigger sethintrequiresholding(1);
      var_1.interaction_trigger setuseholdduration("duration_medium");
      var_2 = &"COOP_CRAFTING/BREACH_CROWBAR_HINT";
    }
  } else if(isDefined(var_1.powers["power_c4"]) || istrue(var_1.forcedc4)) {
    var_1.interaction_trigger sethinticon("hud_icon_c4_plant");
    var_2 = &"COOP_CRAFTING/BREACH_HINT";
  }

  return var_2;
}

function testanimationduringuseduration(var_0, var_1) {
  var_1 notify("testAnimationDuringUseDuration");
  var_1 endon("testAnimationDuringUseDuration");
  var_2 = var_1 scripts\engine\utility::waittill_any_ents_return(var_1.interaction_trigger, "trigger_progress");

  if(!isDefined(var_0.script_noteworthy) || var_0.script_noteworthy != "destructible_door_double") {
    return;
  }

  thread plantbreachweapon(var_1, var_0, var_1);
  var_1 endon("set_interaction_point");
  thread earlyexit(var_1);
  var_2 = var_1 scripts\engine\utility::waittill_any_ents_return(var_1.interaction_trigger, "trigger", var_1, "set_interaction_point", var_1, "starting_interaction_search", var_1, "left_early", level, "door_breached");

  if(isDefined(var_2) && var_2 != "left_early") {
    var_1 notify("trigger_success");
  }

  remove_player_rig(var_1);

  if(isDefined(var_1.linktoent)) {
    var_1 unlink();
    var_1.linktoent delete();
    var_1.linktoent = undefined;
  }

  var_1.isbreaching = 0;
  var_1 stopgestureviewmodel("ges_vest_replace");
}

function earlyexit(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("set_interaction_point");
  var_0 endon("trigger_success");

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  var_0 notify("left_early");
}

function initbreachpoint(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "destructible_door_double") {
      add_destructible(var_2, var_2);
      storeothersideobjectreference(var_2);
      thread cleanupthreadforbombobject(var_2);

      foreach(var_4 in var_0) {
        if(var_4 != var_2) {
          if(var_2.target == var_4.target) {
            var_2.opposite_struct = var_4;
            storeothersideobjectreference(var_2.opposite_struct);
          }
        }
      }
    }
  }
}

function breach_use_func(var_0, var_1) {
  if(level.gametype == "cp_survival") {
    level notify("defend_sequence_started");
    scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy(var_0.script_noteworthy);
    return;
  }
}

function isotherplayersnearpoint(var_0, var_1) {
  level endon("game_ended");
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4 != var_1) {
      if(distance(var_4.origin, var_0) <= 96) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

function storeothersideobjectreference(var_0) {
  if(!isDefined(level.usedestructibleobjects)) {
    level.usedestructibleobjects = [];
  }

  level.usedestructibleobjects[level.usedestructibleobjects.size] = var_0;
}

function watchforconnectedplayers() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
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
    var_0 = scripts\engine\utility::ref_143ad("disable_breach_hint", "enable_breach_hint");

    if(!isDefined(var_0)) {
      continue;
    }

    if(!isDefined(level.usedestructibleobjects)) {
      continue;
    }

    switch (var_0) {
      case "disable_breach_hint":
        foreach(var_2 in level.usedestructibleobjects) {
          if(isDefined(var_2) && scripts\engine\utility::array_contains(level.current_interaction_structs, var_2)) {
            var_2.temp_disable_interaction = 1;
            scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
          }
        }

        break;
      case "enable_breach_hint":
        foreach(var_2 in level.usedestructibleobjects) {
          if(isDefined(var_2)) {
            if(isDefined(var_2.temp_disable_interaction) && var_2.temp_disable_interaction == 1) {
              var_2.temp_disable_interaction = 0;
              scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
            }
          }
        }

        break;
    }
  }
}

function cleanupthreadforbombobject(var_0) {
  self waittill("delete_this_thread_for_" + var_0.target);

  switch (var_0.name) {
    case "bomb_preview":
      foreach(var_2 in var_0.ents) {
        if(isDefined(var_2.classname)) {
          if(var_2.classname == "script_model" || var_2.classname == "script_origin" || var_2.classname == "script_brushmodel") {
            var_2 delete();
          }
        }
      }

      break;
    case "bomb_preview_2":
      foreach(var_2 in var_0.ents) {
        if(isDefined(var_2.classname)) {
          if(var_2.classname == "script_model" || var_2.classname == "script_origin" || var_2.classname == "script_brushmodel") {
            var_2 delete();
          }
        }
      }

      break;
  }
}

function getanimdataforexplosive(var_0) {
  foreach(var_2 in level.crafteditemsanimdata) {
    if(var_2.crafteditem == var_0) {
      return var_2;
    }
  }
}

function chooserandomexplosive() {
  var_0 = ["Breach Charge"];
  var_1 = scripts\engine\utility::random(var_0);
  return var_1;
}

function hasrequiredcrafteditemfordestruction(var_0) {
  foreach(var_2 in self.crafteditemslist) {
    if(var_0 == var_2) {
      return true;
    }
  }

  return false;
}

function plantbreachweapon(var_0, var_1, var_2) {
  var_1 endon("left_early");
  var_1 endon("breach_restart");

  if(var_0.script_noteworthy != "destructible_door_double") {
    return;
  }

  if(isDefined(level.fubar_breach_logic)) {
    return self[[level.fubar_breach_logic]](var_0, var_1);
  }

  if(isDefined(level.fubar_breach_logic_plane_combat)) {
    if(!istrue([[level.fubar_breach_logic_plane_combat]](var_0, var_1))) {
      return;
    }
  }

  var_3 = 1;

  if(!level.only_one_player) {
    var_4 = 2;
  } else {
    var_4 = 1;
  }

  if((!isDefined(var_2.powers["power_c4"]) || var_2.powers["power_c4"].charges <= 0) && isDefined(var_3) && istrue(var_2.has_crowbar)) {
    var_5 = 3.3;
    var_6 = 1;
    crowbar_use_activate(var_2, var_1, var_4, var_4, var_5, var_6);
    return 1;
  } else if(!isDefined(var_4.throwinggrenade) && !isDefined(self.plantedbomb)) {
    bomb_use_activate(var_4, var_3);
    return 1;
  }

  return 0;
}

function bomb_use_activate(var_0, var_1) {
  if(isDefined(var_0.forcedc4) && !var_0.forcedc4) {
    var_0 thread scripts\cp\cp_powers::power_adjustcharges(-1, var_0.powers["power_c4"].slot);
  }

  if(istrue(var_0.breaching)) {
    return;
  }

  var_0.breaching = 1;

  if(isPlayer(var_0)) {
    bomb_anim_think(var_1, var_0, var_1);
  }

  thread actionmap(var_1, "onuse");

  if(isPlayer(var_0)) {
    remove_player_rig(var_0);
  }

  thread bomb_planted_think(var_1, var_0);
}

function bomb_anim_think(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  var_1.players_using_breach = -1;

  if(isDefined(var_1.opposite_struct)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1.opposite_struct);
  }

  script_model_anims(%wm_equip_c4_attach, "wm_equip_c4_attach", "equip_c4_attach", "vm_equip_c4_attach", %wm_equip_c4_attach_c4, "wm_equip_c4_attach_c4", "c4");

  if(!isDefined(var_0.interaction_trigger)) {
    return;
  }

  thread watchplayerdeath(var_0);
  var_0.linktoent = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_0.linktoent moveTo(var_1.origin, 0.25, 0.1, 0.1);

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_0.linktoent rotateTo(var_1.angles, 0.25, 0.1, 0.1);
  var_0 setstance("stand");
  wait 0.29;

  if(istrue(self.cancelplant)) {
    return 0;
  }

  var_0 unlink();
  var_0.linktoent delete();
  var_0.linktoent = undefined;
  thread create_player_rig(var_0, "planter");
  var_0 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "plant");
  var_0 setstance("stand");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("offhand_wm_c4");
  var_2.animname = "c4";
  var_2 useanimtree(#animtree);
  self.plantedbomb = var_2;
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "plant");
  wait getanimlength(level.scr_anim["planter"]["plant"]);

  if(istrue(self.cancelplant)) {
    return 0;
  }
}

function bomb_planted_think(var_0, var_1) {
  var_1 endon("stop_bomb_think");

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  var_0.breaching = undefined;

  if(!istrue(var_1.no_fuse)) {
    bomb_fuse_think(var_1);
  }

  process_action("destroyed");
  process_action(var_1, "destroyed");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);

  if(isDefined(var_1.opposite_struct)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1.opposite_struct);
  }

  wait 0.1;

  if(isDefined(self.plantedbomb)) {
    if(isDefined(var_0)) {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 1000, 100, var_0, "MOD_EXPLOSIVE");
    } else {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 1000, 100, undefined, "MOD_EXPLOSIVE");
    }
  }

  level notify("door_breached", self.origin, var_1);

  if(isDefined(self.plantedbomb)) {
    self.plantedbomb delete();
    self.plantedbomb = undefined;
  }

  var_2 = getEntArray("final_breach_collision", "targetname");
  var_3 = scripts\engine\utility::getclosest(var_1.origin, var_2, 100);

  if(isDefined(var_3)) {
    var_3 connectpaths();
    var_3 delete();
  }

  if(isDefined(level.fubar_breach_spawners)) {
    GscBinSkip1(0x74, level.fubar_breach_spawners, self.origin);
  }

  var_1 notify("delete_this_thread_for_" + var_1.target);
}

function bomb_fuse_think(var_0) {
  var_1 = gettime();
  var_2 = int(var_1 + 5000);
  var_3 = var_2 - var_1;

  while(var_3 > 0) {
    var_1 = gettime();
    var_3 = var_2 - var_1;

    if(var_3 < 1500) {
      if(var_3 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          self.plantedbomb playSound("breach_warning_beep_05");
        }
      } else if(var_3 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          self.plantedbomb playSound("breach_warning_beep_04");
        }
      } else if(var_3 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          self.plantedbomb playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        self.plantedbomb playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_3 < 3500) {
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

    if(var_3 < 0) {
      break;
    }
  }
}

function crowbar_use_activate(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(crowbar_breach_try_think(var_0, var_1, var_2, var_3, var_4 - var_5)) {
    thread crowbar_planted_think(var_0, var_1);
    process_action("onuse");
    actionmap("onuse", self);
    self notify("breach_complete");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1.opposite_struct);
    return 1;
  }

  remove_player_rig(var_0);
  var_0.isbreaching = 0;
  return 0;
}

function crowbar_breach_try_think(var_0, var_1, var_2, var_3, var_4) {
  crowbar_anim_think(var_0, var_1, var_2);
  wait var_4;

  if(istrue(self.cancelplant)) {
    return false;
  }

  var_2 = getnumplayersusingthisinteraction(var_1);

  if(var_2 >= var_3) {
    return true;
  }

  return false;
}

function crowbar_anim_think(var_0, var_1, var_2) {
  script_model_anims(%wm_eq_fusebox_turn_on_plr, "wm_eq_fusebox_turn_on_plr", "equip_c4_attach", "vm_eq_fusebox_turn_on_plr", %wm_equip_c4_attach_c4, "wm_equip_c4_attach_c4", "c4");

  if(!(var_1.script_noteworthy == "destructible_door_double")) {
    return;
  }

  thread watchplayerdeath(var_0);
  var_0.linktoent = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_0.isbreaching = 1;
  var_2 = getnumplayersusingthisinteraction(var_1);
  setbreachernum(var_2, var_0, var_1);

  if(!isDefined(var_0.breachernum)) {
    var_0.breachernum = 1;
  }

  if(var_0.breachernum == 1) {
    if(distance(var_0.origin, var_1.origin) > 3) {
      var_0.linktoent moveTo((var_1.origin + var_0.origin) / 2, 0.25, 0.05, 0.05);
    } else {
      var_0.linktoent moveTo(var_1.origin, 0.25, 0.05, 0.05);
    }

    var_3 = getplayerrotationforbreach(var_1, var_0);
    var_0.linktoent rotateTo(var_3, 0.25, 0.05, 0.05);
  } else if(var_0.breachernum == 2) {
    if(distance(var_0.origin, var_1.origin) > 3) {
      var_0.linktoent moveTo((var_1.origin + var_0.origin) / 2, 0.25, 0.05, 0.05);
    } else {
      var_0.linktoent moveTo(var_1.origin, 0.25, 0.05, 0.05);
    }

    var_3 = getplayerrotationforbreach(var_1, var_0);
    var_0.linktoent rotateTo(var_3, 0.25, 0.05, 0.05);
  }

  var_0 setstance("stand");
  wait 0.29;

  if(istrue(self.cancelplant)) {
    return 0;
  }

  if(isDefined(var_0.linktoent)) {
    var_0 unlink();
    var_0.linktoent delete();
    var_0.linktoent = undefined;
  }

  thread create_player_rig(var_0);
  var_4 = 2;
  var_0 forceplaygestureviewmodel("ges_vest_replace");
  wait var_4;

  if(istrue(self.cancelplant)) {
    return 0;
  }

  var_0 forceplaygestureviewmodel("ges_zombies_revive_jock");
  waitframe();

  if(istrue(self.cancelplant)) {
    return 0;
  }

  var_0 forceplaygestureviewmodel("ges_vest_replace");

  if(var_2 == 1) {
    for(var_5 = 0; var_5 < 1; var_5++) {
      wait var_4;

      if(istrue(self.cancelplant)) {
        return 0;
      }

      var_0 forceplaygestureviewmodel("ges_zombies_revive_jock");
      waitframe();

      if(istrue(self.cancelplant)) {
        return 0;
      }

      var_0 forceplaygestureviewmodel("ges_vest_replace");
    }

    return;
  }
}

function crowbar_planted_think(var_0, var_1) {
  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  process_action_override(var_1, "destroyed", "bomb_explosion", "crowbar_break");
  wait 0.1;
  level notify("door_breached", self.origin);
  remove_player_rig(var_0);
  var_1 notify("delete_this_thread_for_" + var_1.target);
}

function getplayerrotationforbreach(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_3 = var_0.opposite_struct.origin - var_1.origin;
  var_4 = (var_2 + var_3) / 2;
  var_5 = vectortoangles(var_4);
  return var_5;
}

function getnumplayersusingthisinteraction(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(istrue(var_3.isbreaching)) {
      if(distance(var_3.origin, var_0.origin) <= 96) {
        var_3.last_interaction_point = var_0;
      }
    }

    if(isDefined(var_3.last_interaction_point) && isDefined(var_3.last_interaction_point.target)) {
      if(var_0.target == var_3.last_interaction_point.target) {
        if(istrue(var_3.isbreaching)) {
          var_1++;
        }
      }
    }
  }

  return var_1;
}

function getplayersusingthisinteraction(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_2++;

    if(isDefined(var_4.last_interaction_point) && isDefined(var_4.last_interaction_point.target)) {
      if(var_0.target == var_4.last_interaction_point.target) {
        if(isDefined(var_4.isbreaching) && var_4.isbreaching) {
          var_1 = var_4;
        }
      }
    }
  }

  return var_1;
}

function setbreachernum(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_0 == 1) {
    var_1.breachernum = var_3;
    return;
  }

  if(var_0 == 2) {
    foreach(var_5 in getplayersusingthisinteraction(var_2)) {
      var_1.breachernum = var_3;
      var_3++;
    }

    return;
  }
}

function usetriggerholdloop(var_0, var_1) {
  while(usetest(var_0, var_1)) {
    var_0.curprogress += 50 * var_0.userate;

    if(var_0.curprogress >= var_0.usetime) {
      return var_1 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

function usetest(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!var_1 useButtonPressed()) {
    return false;
  }

  if(!nullweapon(var_1 getheldoffhand())) {
    return false;
  }

  if(var_1 meleeButtonPressed()) {
    return false;
  }

  if(var_0.curprogress >= var_0.usetime) {
    return false;
  }

  return true;
}

function watchplayerdeath(var_0) {
  self endon("breach_complete");
  var_0 endon("disconnect");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_1 = undefined;

      foreach(var_3 in self.ents) {
        foreach(var_5 in var_3.parent.previewbomb) {
          if(var_5.script_label == "bomb_preview" || var_5.script_label == "bomb_preview_2") {
            var_1 = var_5;
          }
        }
      }

      self.useobjects[var_1.script_label] show();

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
    level waittill("connected", var_0);
    applyinteractteam(var_0);
  }
}

function assigninteractteam(var_0) {
  foreach(var_2 in level.players) {
    applyinteractteam(var_2);
  }
}

function applyinteractteam(var_0) {
  var_0 endon("disconnect");

  if(level.gametype == "cp_pvpve") {
    return;
  }

  var_1 = undefined;

  foreach(var_3 in self.ents) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(!isDefined(var_3.parent.previewbomb)) {
      continue;
    }

    foreach(var_5 in var_3.parent.previewbomb) {
      if(var_5.script_label == "bomb_preview" || var_5.script_label == "bomb_preview_2") {
        var_1 = var_5;
      }
    }
  }

  if(isDefined(self.useobjects)) {
    foreach(var_9 in self.useobjects) {
      var_9 enableplayeruse(var_0);
      var_9 showtoplayer(var_0);
    }

    return;
  }
}

function killtriggerloop(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      if(isPlayer(var_1)) {
        var_1 suicide();
        var_2 = var_1 getcorpseentity();
        var_2 hide(1);
        var_2.permhidden = 1;

        if(var_1.loadoutarchetype == "archetype_scout") {
          playFX(level._effect["reaper_kill_robot"], var_1.origin + (0, 0, 12));
        } else {
          playFX(level._effect["grinder_kill"], var_1.origin + (0, 0, 12));
        }

        continue;
      }

      if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
        if(isDefined(var_1.streakname)) {
          if(var_1.streakname == "minijackal") {
            var_1 notify("minijackal_end");
            continue;
          }

          if(var_1.streakname == "venom") {
            var_1 notify("venom_end", var_1.origin);
          }
        }
      }
    }
  }
}

function droptonavmeshtriggers() {
  wait 1;
  var_0 = spawn("trigger_radius", (256, 800, 16), 0, 256, 500);
  var_0 hide();
  level.droptonavmeshtriggers[level.droptonavmeshtriggers.size] = var_0;
}