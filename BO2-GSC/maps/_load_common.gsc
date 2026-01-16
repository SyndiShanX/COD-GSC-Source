/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_load_common.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#include maps\_lights;
#include animscripts\traverse\shared;
#include maps\_createfx;
#include maps\_colors;

autoexec run_gump_functions() {
  while(true) {
    level waittill("gump_loaded");
    str_gump = getdvar(#"_id_3DE7CA0E");

    if(isDefined(level._gump_functions) && isDefined(level._gump_functions[str_gump])) {
      foreach(func_gump in level._gump_functions[str_gump])
      level thread[[func_gump]]();
    }
  }
}

level_notify_listener() {
  while(true) {
    val = getdvar(#"level_notify");

    if(val != "") {
      level notify(val);
      setdvar("level_notify", "");
    }

    wait 0.2;
  }
}

client_notify_listener() {
  while(true) {
    val = getdvar(#"client_notify");

    if(val != "") {
      clientnotify(val);
      setdvar("client_notify", "");
    }

    wait 0.2;
  }
}

save_game_on_notify() {
  while(true) {
    level waittill("save");
    level.checkpoint_time = gettime();
    savegame("debug_save");
  }
}

onfirstplayerready() {
  level waittill("first_player_ready", player);

  println("*********************First player connected to game.");
}

set_early_level() {
  level.early_level = [];
  level.early_level["cuba"] = 1;
  level.early_level["vorkuta"] = 1;
}

setup_simple_primary_lights() {
  flickering_lights = getentarray("generic_flickering", "targetname");
  pulsing_lights = getentarray("generic_pulsing", "targetname");
  double_strobe = getentarray("generic_double_strobe", "targetname");
  fire_flickers = getentarray("fire_flicker", "targetname");
  array_thread(flickering_lights, maps\_lights::generic_flickering);
  array_thread(pulsing_lights, maps\_lights::generic_pulsing);
  array_thread(double_strobe, maps\_lights::generic_double_strobe);
  array_thread(fire_flickers, maps\_lights::fire_flicker);
}

weapon_ammo() {
  ents = getentarray();

  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].classname) && getsubstr(ents[i].classname, 0, 7) == "weapon_") {
      weap = ents[i];
      change_ammo = 0;
      clip = undefined;
      extra = undefined;

      if(isDefined(weap.script_ammo_clip)) {
        clip = weap.script_ammo_clip;
        change_ammo = 1;
      }

      if(isDefined(weap.script_ammo_extra)) {
        extra = weap.script_ammo_extra;
        change_ammo = 1;
      }

      if(change_ammo) {
        if(!isDefined(clip)) {
          assertmsg("weapon: " + weap.classname + " " + weap.origin + " sets script_ammo_extra but not script_ammo_clip");

        }

        if(!isDefined(extra)) {
          assertmsg("weapon: " + weap.classname + " " + weap.origin + " sets script_ammo_clip but not script_ammo_extra");

        }

        weap itemweaponsetammo(clip, extra);
        weap itemweaponsetammo(clip, extra, 1);
      }
    }
  }
}

trigger_group() {
  self thread trigger_group_remove();
  level endon("trigger_group_" + self.script_trigger_group);
  self waittill("trigger");
  level notify("trigger_group_" + self.script_trigger_group, self);
}

trigger_group_remove() {
  level waittill("trigger_group_" + self.script_trigger_group, trigger);

  if(self != trigger)
    self delete();
}

exploder_load(trigger) {
  level endon("killexplodertridgers" + trigger.script_exploder);
  trigger waittill("trigger");

  if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
    if(isDefined(trigger.script_delay))
      wait(trigger.script_delay);
    else
      wait 4;

    level thread exploder_load(trigger);
    return;
  }

  exploder(trigger.script_exploder);
  level notify("killexplodertridgers" + trigger.script_exploder);
}

setup_traversals() {
  potential_traverse_nodes = getallnodes();

  for(i = 0; i < potential_traverse_nodes.size; i++) {
    node = potential_traverse_nodes[i];

    if(node.type == "Begin")
      node animscripts\traverse\shared::init_traverse();
  }
}

badplace_think(badplace) {
  if(!isDefined(level.badplaces))
    level.badplaces = 0;

  level.badplaces++;
  badplace_cylinder("badplace" + level.badplaces, -1, badplace.origin, badplace.radius, 1024);
}

setupexploders() {
  level.exploders = [];
  ents = getentarray("script_brushmodel", "classname");
  smodels = getentarray("script_model", "classname");

  for(i = 0; i < smodels.size; i++)
    ents[ents.size] = smodels[i];

  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_prefab_exploder))
      ents[i].script_exploder = ents[i].script_prefab_exploder;

    if(isDefined(ents[i].script_exploder)) {
      if(ents[i].script_exploder < 10000)
        level.exploders[ents[i].script_exploder] = 1;

      if(ents[i].model == "fx" && (!isDefined(ents[i].targetname) || ents[i].targetname != "exploderchunk")) {
        ents[i] hide();
        continue;
      }

      if(isDefined(ents[i].targetname) && ents[i].targetname == "exploder") {
        ents[i] hide();
        ents[i] notsolid();

        if(isDefined(ents[i].script_disconnectpaths))
          ents[i] connectpaths();

        continue;
      }

      if(isDefined(ents[i].targetname) && ents[i].targetname == "exploderchunk") {
        ents[i] hide();
        ents[i] notsolid();

        if(ents[i] has_spawnflag(1))
          ents[i] connectpaths();
      }
    }
  }

  script_exploders = [];
  potentialexploders = getentarray("script_brushmodel", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder))
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;

    if(isDefined(potentialexploders[i].script_exploder))
      script_exploders[script_exploders.size] = potentialexploders[i];
  }

  println("Server : Potential exploders from brushmodels " + potentialexploders.size);

  potentialexploders = getentarray("script_model", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder))
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;

    if(isDefined(potentialexploders[i].script_exploder))
      script_exploders[script_exploders.size] = potentialexploders[i];
  }

  println("Server : Potential exploders from script_model " + potentialexploders.size);

  potentialexploders = getentarray("item_health", "classname");

  for(i = 0; i < potentialexploders.size; i++) {
    if(isDefined(potentialexploders[i].script_prefab_exploder))
      potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;

    if(isDefined(potentialexploders[i].script_exploder))
      script_exploders[script_exploders.size] = potentialexploders[i];
  }

  println("Server : Potential exploders from item_health " + potentialexploders.size);

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  acceptabletargetnames = [];
  acceptabletargetnames["exploderchunk visible"] = 1;
  acceptabletargetnames["exploderchunk"] = 1;
  acceptabletargetnames["exploder"] = 1;

  for(i = 0; i < script_exploders.size; i++) {
    exploder = script_exploders[i];
    ent = createexploder(exploder.script_fxid);
    ent.v = [];
    ent.v["origin"] = exploder.origin;
    ent.v["angles"] = exploder.angles;
    ent.v["delay"] = exploder.script_delay;
    ent.v["firefx"] = exploder.script_firefx;
    ent.v["firefxdelay"] = exploder.script_firefxdelay;
    ent.v["firefxsound"] = exploder.script_firefxsound;
    ent.v["firefxtimeout"] = exploder.script_firefxtimeout;
    ent.v["earthquake"] = exploder.script_earthquake;
    ent.v["damage"] = exploder.script_damage;
    ent.v["damage_radius"] = exploder.script_radius;
    ent.v["soundalias"] = exploder.script_soundalias;
    ent.v["repeat"] = exploder.script_repeat;
    ent.v["delay_min"] = exploder.script_delay_min;
    ent.v["delay_max"] = exploder.script_delay_max;
    ent.v["target"] = exploder.target;
    ent.v["ender"] = exploder.script_ender;
    ent.v["type"] = "exploder";

    if(!isDefined(exploder.script_fxid))
      ent.v["fxid"] = "No FX";
    else
      ent.v["fxid"] = exploder.script_fxid;

    ent.v["exploder"] = exploder.script_exploder;
    assert(isDefined(exploder.script_exploder), "Exploder at origin " + exploder.origin + " has no script_exploder");

    if(!isDefined(ent.v["delay"]))
      ent.v["delay"] = 0;

    if(isDefined(exploder.target)) {
      e_target = getent(ent.v["target"], "targetname");

      if(!isDefined(e_target))
        e_target = getstruct(ent.v["target"], "targetname");

      org = e_target.origin;
      ent.v["angles"] = vectortoangles(org - ent.v["origin"]);
    }

    if(exploder.classname == "script_brushmodel" || isDefined(exploder.model)) {
      ent.model = exploder;
      ent.model.disconnect_paths = exploder.script_disconnectpaths;
    }

    if(isDefined(exploder.targetname) && isDefined(acceptabletargetnames[exploder.targetname]))
      ent.v["exploder_type"] = exploder.targetname;
    else
      ent.v["exploder_type"] = "normal";

    ent maps\_createfx::post_entity_creation_function();

  }

  level.createfxexploders = [];

  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];

    if(ent.v["type"] != "exploder") {
      continue;
    }
    ent.v["exploder_id"] = getexploderid(ent);

    if(!isDefined(level.createfxexploders[ent.v["exploder"]]))
      level.createfxexploders[ent.v["exploder"]] = [];

    level.createfxexploders[ent.v["exploder"]][level.createfxexploders[ent.v["exploder"]].size] = ent;
  }

  reportexploderids();
}

playerdamagerumble() {
  while(true) {
    self waittill("damage", amount);

    if(isDefined(self.specialdamage)) {
      continue;
    }
    self playrumbleonentity("damage_heavy");
  }
}

map_is_early_in_the_game() {
  if(isDefined(level.testmap))
    return true;

  if(!isDefined(level.early_level[level.script]))
    level.early_level[level.script] = 0;

  return isDefined(level.early_level[level.script]) && level.early_level[level.script];
}

player_throwgrenade_timer() {
  self endon("death");
  self endon("disconnect");
  self.lastgrenadetime = 0;

  while(true) {
    while(!self isthrowinggrenade())
      wait 0.05;

    self.lastgrenadetime = gettime();

    while(self isthrowinggrenade())
      wait 0.05;
  }
}

player_special_death_hint() {
  self endon("disconnect");
  self thread player_throwgrenade_timer();

  if(issplitscreen() || coopgame()) {
    return;
  }
  self waittill("death", attacker, cause, weaponname, inflicter);

  if(cause != "MOD_GAS" && cause != "MOD_GRENADE" && cause != "MOD_GRENADE_SPLASH" && cause != "MOD_SUICIDE" && cause != "MOD_EXPLOSIVE" && cause != "MOD_PROJECTILE" && cause != "MOD_PROJECTILE_SPLASH") {
    return;
  }
  if(level.gameskill >= 2) {
    if(!map_is_early_in_the_game())
      return;
  }

  if(level.script == "panama_2" && isDefined(weaponname) && weaponname == "ac130_vulcan_minigun") {
    setdvar("ui_deadquote", & "PANAMA_AC130_FAILQUOTE");
    return;
  }

  if(cause == "MOD_EXPLOSIVE") {
    if(isDefined(attacker) && (attacker.classname == "script_vehicle" || isDefined(attacker.create_fake_vehicle_damage))) {
      level notify("new_quote_string");
      setdvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
      self thread explosive_vehice_death_indicator_hudelement();
      return;
    }

    if(isDefined(inflicter) && isDefined(inflicter.destructibledef)) {
      if(issubstr(inflicter.destructibledef, "barrel_explosive")) {
        level notify("new_quote_string");
        setdvar("ui_deadquote", "@SCRIPT_EXPLODING_BARREL_DEATH");
        return;
      }

      if(isDefined(inflicter.destructiblecar) && inflicter.destructiblecar) {
        level notify("new_quote_string");
        setdvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
        self thread explosive_vehice_death_indicator_hudelement();
        return;
      }
    }
  }

  if(cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH") {
    if(isDefined(weaponname) && (!isweapondetonationtimed(weaponname) || weapontype(weaponname) != "grenade") || weaponname == "mortar_shell_dpad_sp") {
      return;
    }
    level notify("new_quote_string");

    if(isDefined(weaponname) && weaponname == "titus_explosive_dart_sp") {
      setdvar("ui_deadquote", "@SCRIPT_EXPLOSIVE_FLECHETTE_DEATH");
      thread explosive_dart_death_indicator_hudelement();
    } else if(isDefined(weaponname) && weaponname == "explosive_bolt_sp") {
      setdvar("ui_deadquote", "@SCRIPT_EXPLOSIVE_BOLT_DEATH");
      thread explosive_arrow_death_indicator_hudelement();
    } else {
      setdvar("ui_deadquote", "@SCRIPT_GRENADE_DEATH");
      thread grenade_death_indicator_hudelement();
    }

    return;
  }

  if(cause == "MOD_GAS" && level.script == "monsoon") {
    setdvar("ui_deadquote", "@SCRIPT_EXPLODING_NITROGEN_TANK_DEATH");
    thread explosive_nitrogen_tank_death_indicator_hudelement();
    return;
  }
}

grenade_death_text_hudelement(textline1, textline2) {
  self.failingmission = 1;
  setdvar("ui_deadquote", "");
  wait 0.5;
  fontelem = newhudelem();
  fontelem.elemtype = "font";
  fontelem.font = "default";
  fontelem.fontscale = 1.5;
  fontelem.x = 0;
  fontelem.y = -60;
  fontelem.alignx = "center";
  fontelem.aligny = "middle";
  fontelem.horzalign = "center";
  fontelem.vertalign = "middle";
  fontelem settext(textline1);
  fontelem.foreground = 1;
  fontelem.alpha = 0;
  fontelem fadeovertime(1);
  fontelem.alpha = 1;
  fontelem.hidewheninmenu = 1;

  if(isDefined(textline2)) {
    fontelem = newhudelem();
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = 1.5;
    fontelem.x = 0;
    fontelem.y = -60 + level.fontheight * fontelem.fontscale;
    fontelem.alignx = "center";
    fontelem.aligny = "middle";
    fontelem.horzalign = "center";
    fontelem.vertalign = "middle";
    fontelem settext(textline2);
    fontelem.foreground = 1;
    fontelem.alpha = 0;
    fontelem fadeovertime(1);
    fontelem.alpha = 1;
    fontelem.hidewheninmenu = 1;
  }
}

grenade_death_indicator_hudelement() {
  self endon("disconnect");
  wait 0.5;
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_grenadeicon_256", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

explosive_arrow_death_indicator_hudelement() {
  self endon("disconnect");
  wait 0.5;
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_explosive_arrow_icon", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

explosive_dart_death_indicator_hudelement() {
  self endon("disconnect");
  wait 0.5;
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_monsoon_titus_arrow", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

explosive_nitrogen_tank_death_indicator_hudelement() {
  self endon("disconnect");
  wait 0.5;
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_monsoon_nitrogen_barrel", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

explosive_vehice_death_indicator_hudelement() {
  self endon("disconnect");
  wait 0.5;
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = -10;
  overlayicon setshader("hud_exploding_vehicles", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

grenade_death_indicator_hudelement_cleanup(hudelemicon, hudelempointer) {
  self endon("disconnect");
  self waittill("spawned");
  hudelemicon destroy();
  hudelempointer destroy();
}

special_death_indicator_hudelement(shader, iwidth, iheight, fdelay, x, y) {
  if(!isDefined(fdelay))
    fdelay = 0.5;

  wait(fdelay);
  overlay = newclienthudelem(self);

  if(isDefined(x))
    overlay.x = x;
  else
    overlay.x = 0;

  if(isDefined(y))
    overlay.y = y;
  else
    overlay.y = 40;

  overlay setshader(shader, iwidth, iheight);
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.horzalign = "center";
  overlay.vertalign = "middle";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
  overlay.hidewheninmenu = 1;
  self thread special_death_death_indicator_hudelement_cleanup(overlay);
}

special_death_death_indicator_hudelement_cleanup(overlay) {
  self endon("disconnect");
  self waittill("spawned");
  overlay destroy();
}

waterthink() {
  assert(isDefined(self.target));
  targeted = getent(self.target, "targetname");
  assert(isDefined(targeted));
  waterheight = targeted.origin[2];
  targeted = undefined;
  level.depth_allow_prone = 8;
  level.depth_allow_crouch = 33;
  level.depth_allow_stand = 50;

  for(;;) {
    wait 0.05;
    players = get_players();

    for(i = 0; i < players.size; i++) {
      if(players[i].inwater) {
        players[i] allowprone(1);
        players[i] allowcrouch(1);
        players[i] allowstand(1);
      }
    }

    self waittill("trigger", other);

    if(!isplayer(other)) {
      continue;
    }
    while(true) {
      players = get_players();
      players_in_water_count = 0;

      for(i = 0; i < players.size; i++) {
        if(players[i] istouching(self)) {
          players_in_water_count++;
          players[i].inwater = 1;
          playerorg = players[i] getorigin();
          d = playerorg[2] - waterheight;

          if(d > 0) {
            continue;
          }
          newspeed = int(level.default_run_speed - abs(d * 5));

          if(newspeed < 50)
            newspeed = 50;

          assert(newspeed <= 190);

          if(abs(d) > level.depth_allow_crouch)
            players[i] allowcrouch(0);
          else
            players[i] allowcrouch(1);

          if(abs(d) > level.depth_allow_prone)
            players[i] allowprone(0);
          else
            players[i] allowprone(1);

          continue;
        }

        if(players[i].inwater)
          players[i].inwater = 0;
      }

      if(players_in_water_count == 0) {
        break;
      }

      wait 0.5;
    }

    wait 0.05;
  }
}

massnodeinitfunctions() {
  nodes = getallnodes();
  thread maps\_colors::init_color_grouping(nodes);
}

trigger_unlock(trigger) {
  noteworthy = "not_set";

  if(isDefined(trigger.script_noteworthy))
    noteworthy = trigger.script_noteworthy;

  target_triggers = getentarray(trigger.target, "targetname");
  trigger thread trigger_unlock_death(trigger.target);

  for(;;) {
    array_thread(target_triggers, ::trigger_off);
    trigger waittill("trigger");
    array_thread(target_triggers, ::trigger_on);
    wait_for_an_unlocked_trigger(target_triggers, noteworthy);
    array_notify(target_triggers, "relock");
  }
}

trigger_unlock_death(target) {
  self waittill("death");
  target_triggers = getentarray(target, "targetname");
  array_thread(target_triggers, ::trigger_off);
}

wait_for_an_unlocked_trigger(triggers, noteworthy) {
  level endon("unlocked_trigger_hit" + noteworthy);
  ent = spawnstruct();

  for(i = 0; i < triggers.size; i++)
    triggers[i] thread report_trigger(ent, noteworthy);

  ent waittill("trigger");
  level notify("unlocked_trigger_hit" + noteworthy);
}

report_trigger(ent, noteworthy) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + noteworthy);
  self waittill("trigger");
  ent notify("trigger");
}

get_trigger_look_target() {
  if(isDefined(self.target)) {
    a_potential_targets = getentarray(self.target, "targetname");
    a_targets = [];

    foreach(target in a_potential_targets) {
      if(!isDefined(target.classname) && !isDefined("script_origin") || isDefined(target.classname) && isDefined("script_origin") && target.classname == "script_origin")
        a_targets[a_targets.size] = target;
    }

    a_potential_target_structs = get_struct_array(self.target);
    a_targets = arraycombine(a_targets, a_potential_target_structs, 1, 0);

    if(a_targets.size > 0) {
      assert(a_targets.size == 1, "Look tigger at " + self.origin + " targets multiple origins/structs.");
      e_target = a_targets[0];
    }
  }

  if(!isDefined(e_target))
    e_target = self;

  return e_target;
}

trigger_look(trigger) {
  trigger endon("death");
  e_target = trigger get_trigger_look_target();

  if(isDefined(trigger.script_flag) && !isDefined(level.flag[trigger.script_flag]))
    flag_init(trigger.script_flag, undefined, 1);

  a_parameters = [];

  if(isDefined(trigger.script_parameters))
    a_parameters = strtok(trigger.script_parameters, ",; ");

  b_ads_check = isinarray(a_parameters, "check_ads");

  while(true) {
    trigger waittill("trigger", e_other);

    if(isplayer(e_other)) {
      while(e_other istouching(trigger)) {
        if(e_other is_looking_at(e_target, trigger.script_dot, isDefined(trigger.script_trace) && trigger.script_trace) && (!b_ads_check || !e_other is_ads())) {
          trigger notify("trigger_look");

          if(isDefined(trigger.script_flag))
            flag_set(trigger.script_flag);
        } else if(isDefined(trigger.script_flag))
          flag_clear(trigger.script_flag);

        wait 0.05;
      }

      if(isDefined(trigger.script_flag))
        flag_clear(trigger.script_flag);
    } else {
      assertmsg("Look triggers only support players.");

    }
  }
}

indicate_start(start) {
  hudelem = newhudelem();
  hudelem.alignx = "left";
  hudelem.aligny = "middle";
  hudelem.x = 70;
  hudelem.y = 400;
  hudelem.label = start;
  hudelem.alpha = 0;
  hudelem.fontscale = 3;
  wait 1;
  hudelem fadeovertime(1);
  hudelem.alpha = 1;
  wait 5;
  hudelem fadeovertime(1);
  hudelem.alpha = 0;
  wait 1;
  hudelem destroy();
}

trigger_notify(trigger, msg) {
  trigger endon("death");
  other = trigger trigger_wait();

  if(isDefined(trigger.target)) {
    notify_ent = getent(trigger.target, "targetname");

    if(isDefined(notify_ent))
      notify_ent notify(msg, other);
  }

  level notify(msg, other);
}

flag_set_trigger(trigger, str_flag) {
  trigger endon("death");
  flag = trigger get_trigger_flag(str_flag);

  if(!isDefined(level.flag[flag]))
    flag_init(flag, undefined, 1);

  while(true) {
    trigger trigger_wait();

    if(isDefined(trigger.targetname) && trigger.targetname == "flag_set")
      trigger script_delay();

    flag_set(flag);
  }
}

flag_clear_trigger(trigger, flag_name) {
  trigger endon("death");
  flag = trigger get_trigger_flag(flag_name);

  if(!isDefined(level.flag[flag]))
    flag_init(flag, undefined, 1);

  for(;;) {
    trigger trigger_wait();

    if(isDefined(trigger.targetname) && trigger.targetname == "flag_clear")
      trigger script_delay();

    flag_clear(flag);
  }
}

add_tokens_to_trigger_flags(tokens) {
  for(i = 0; i < tokens.size; i++) {
    flag = tokens[i];

    if(!isDefined(level.trigger_flags[flag]))
      level.trigger_flags[flag] = [];

    level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
  }
}

script_flag_false_trigger(trigger) {
  tokens = create_flags_and_return_tokens(trigger.script_flag_false);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_trigger_based_on_flags();
}

script_flag_true_trigger(trigger) {
  tokens = create_flags_and_return_tokens(trigger.script_flag_true);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_trigger_based_on_flags();
}

wait_for_flag(tokens) {
  for(i = 0; i < tokens.size; i++)
    level endon(tokens[i]);

  level waittill("foreverrr");
}

friendly_respawn_trigger(trigger) {
  spawners = getentarray(trigger.target, "targetname");
  assert(spawners.size == 1, "friendly_respawn_trigger targets multiple spawner with targetname " + trigger.target + ". Should target just 1 spawner.");
  spawner = spawners[0];
  assert(!isDefined(spawner.script_forcecolor), "targeted spawner at " + spawner.origin + " should not have script_forcecolor set!");
  spawners = undefined;
  spawner endon("death");

  for(;;) {
    trigger waittill("trigger");

    if(isDefined(trigger.script_forcecolor))
      level.respawn_spawners_specific[trigger.script_forcecolor] = spawner;
    else
      level.respawn_spawner = spawner;

    flag_set("respawn_friendlies");
    wait 0.5;
  }
}

friendly_respawn_clear(trigger) {
  for(;;) {
    trigger waittill("trigger");
    flag_clear("respawn_friendlies");
    wait 0.5;
  }
}

trigger_ignore(trigger) {
  thread trigger_runs_function_on_touch(trigger, ::set_ignoreme, ::get_ignoreme);
}

trigger_pacifist(trigger) {
  thread trigger_runs_function_on_touch(trigger, ::set_pacifist, ::get_pacifist);
}

trigger_runs_function_on_touch(trigger, set_func, get_func) {
  for(;;) {
    trigger waittill("trigger", other);

    if(!isalive(other)) {
      continue;
    }
    if(other[[get_func]]()) {
      continue;
    }
    other thread touched_trigger_runs_func(trigger, set_func);
  }
}

touched_trigger_runs_func(trigger, set_func) {
  self endon("death");
  self.ignoreme = 1;
  [[set_func]](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(trigger))
    wait 1;

  [[set_func]](0);
}

trigger_turns_off(trigger) {
  trigger trigger_wait();
  trigger trigger_off();

  if(!isDefined(trigger.script_linkto)) {
    return;
  }
  tokens = strtok(trigger.script_linkto, " ");

  for(i = 0; i < tokens.size; i++)
    array_thread(getentarray(tokens[i], "script_linkname"), ::trigger_off);
}

script_gen_dump_checksaved() {
  signatures = getarraykeys(level.script_gen_dump);

  for(i = 0; i < signatures.size; i++) {
    if(!isDefined(level.script_gen_dump2[signatures[i]])) {
      level.script_gen_dump[signatures[i]] = undefined;
      level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "Signature unmatched( removed feature ): " + signatures[i];
    }
  }

}

script_gen_dump() {
  script_gen_dump_checksaved();

  if(!level.script_gen_dump_reasons.size) {
    flag_set("scriptgen_done");
    return;
  }

  firstrun = 0;

  if(level.bscriptgened) {
    println(" ");
    println(" ");
    println(" ");
    println("^2----------------------------------------");
    println("^3Dumping scriptgen dump for these reasons");
    println("^2----------------------------------------");

    for(i = 0; i < level.script_gen_dump_reasons.size; i++) {
      if(issubstr(level.script_gen_dump_reasons[i], "nowrite")) {
        substr = getsubstr(level.script_gen_dump_reasons[i], 15);
        println(i + ". ) " + substr);
        continue;
      }

      println(i + ". ) " + level.script_gen_dump_reasons[i]);

      if(level.script_gen_dump_reasons[i] == "First run")
        firstrun = 1;
    }

    println("^2----------------------------------------");
    println(" ");

    if(firstrun) {
      println("for First Run make sure you delete all of the vehicle precache script calls, createart calls, createfx calls( most commonly placed in maps\\" + level.script + "_fx.gsc ) ");
      println(" ");
      println("replace:");
      println("maps\\_load::main( 1 ); ");
      println(" ");
      println("with( don't forget to add this file to P4 ):");
      println("maps\\scriptgen\\" + level.script + "_scriptgen::main(); ");
      println(" ");
    }

    println("^2----------------------------------------");
    println(" ");
    println("^2/\\/\\/\\");
    println("^2scroll up");
    println("^2/\\/\\/\\");
    println(" ");
  } else
    return;

  filename = "scriptgen/" + level.script + "_scriptgen.gsc";
  csvfilename = "zone_source/" + level.script + ".csv";

  if(level.bscriptgened)
    file = openfile(filename, "write");
  else
    file = 0;

  assert(file != -1, "File not writeable( check it and and restart the map ): " + filename);
  script_gen_dumpprintln(file, "//script generated script do not write your own script here it will go away if you do.");
  script_gen_dumpprintln(file, "main()");
  script_gen_dumpprintln(file, "{");
  script_gen_dumpprintln(file, "");
  script_gen_dumpprintln(file, "\\tlevel.script_gen_dump = []; ");
  script_gen_dumpprintln(file, "");
  signatures = getarraykeys(level.script_gen_dump);

  for(i = 0; i < signatures.size; i++) {
    if(!issubstr(level.script_gen_dump[signatures[i]], "nowrite"))
      script_gen_dumpprintln(file, "\\t" + level.script_gen_dump[signatures[i]]);
  }

  for(i = 0; i < signatures.size; i++) {
    if(!issubstr(level.script_gen_dump[signatures[i]], "nowrite")) {
      script_gen_dumpprintln(file, "\\tlevel.script_gen_dump[" + "\"" + signatures[i] + "\"" + "] = " + "\"" + signatures[i] + "\"" + "; ");
      continue;
    }

    script_gen_dumpprintln(file, "\\tlevel.script_gen_dump[" + "\"" + signatures[i] + "\"" + "] = " + "\"nowrite\"" + "; ");
  }

  script_gen_dumpprintln(file, "");
  keys1 = undefined;
  keys2 = undefined;

  if(isDefined(level.sg_precacheanims))
    keys1 = getarraykeys(level.sg_precacheanims);

  if(isDefined(keys1)) {
    for(i = 0; i < keys1.size; i++)
      script_gen_dumpprintln(file, "\\tanim_precach_" + keys1[i] + "(); ");
  }

  script_gen_dumpprintln(file, "\\tmaps\\_load::main( 1, " + level.bcsvgened + ", 1 ); ");
  script_gen_dumpprintln(file, "}");
  script_gen_dumpprintln(file, "");

  if(isDefined(level.sg_precacheanims))
    keys1 = getarraykeys(level.sg_precacheanims);

  if(isDefined(keys1)) {
    for(i = 0; i < keys1.size; i++) {
      script_gen_dumpprintln(file, "#using_animtree( \"" + keys1[i] + "\" ); ");
      script_gen_dumpprintln(file, "anim_precach_" + keys1[i] + "()");
      script_gen_dumpprintln(file, "{");
      script_gen_dumpprintln(file, "\\tlevel.sg_animtree[\"" + keys1[i] + "\"] = #animtree; ");
      keys2 = getarraykeys(level.sg_precacheanims[keys1[i]]);

      if(isDefined(keys2)) {
        for(j = 0; j < keys2.size; j++)
          script_gen_dumpprintln(file, "\\tlevel.sg_anim[\"" + keys2[j] + "\"] = %" + keys2[j] + "; ");
      }

      script_gen_dumpprintln(file, "}");
      script_gen_dumpprintln(file, "");
    }
  }

  if(level.bscriptgened)
    saved = closefile(file);
  else
    saved = 1;

  if(level.bcsvgened)
    csvfile = openfile(csvfilename, "write");
  else
    csvfile = 0;

  assert(csvfile != -1, "File not writeable( check it and and restart the map ): " + csvfilename);
  signatures = getarraykeys(level.script_gen_dump);

  for(i = 0; i < signatures.size; i++)
    script_gen_csvdumpprintln(csvfile, signatures[i]);

  if(level.bcsvgened)
    csvfilesaved = closefile(csvfile);
  else
    csvfilesaved = 1;

  assert(csvfilesaved == 1, "csv not saved( see above message? ): " + csvfilename);
  assert(saved == 1, "map not saved( see above message? ): " + filename);
  assert(!level.bscriptgened, "SCRIPTGEN generated: follow instructions listed above this error in the console");

  if(level.bscriptgened) {
    assertmsg("SCRIPTGEN updated: Rebuild fast file and run map again");

  }

  flag_set("scriptgen_done");
}

script_gen_csvdumpprintln(file, signature) {
  prefix = undefined;
  writtenprefix = undefined;
  path = "";
  extension = "";

  if(issubstr(signature, "ignore"))
    prefix = "ignore";
  else if(issubstr(signature, "col_map_sp"))
    prefix = "col_map_sp";
  else if(issubstr(signature, "gfx_map"))
    prefix = "gfx_map";
  else if(issubstr(signature, "rawfile"))
    prefix = "rawfile";
  else if(issubstr(signature, "sound"))
    prefix = "sound";
  else if(issubstr(signature, "xmodel"))
    prefix = "xmodel";
  else if(issubstr(signature, "xanim"))
    prefix = "xanim";
  else if(issubstr(signature, "item")) {
    prefix = "item";
    writtenprefix = "weapon";
    path = "sp/";
  } else if(issubstr(signature, "fx"))
    prefix = "fx";
  else if(issubstr(signature, "menu")) {
    prefix = "menu";
    writtenprefix = "menufile";
    path = "ui/scriptmenus/";
    extension = ".menu";
  } else if(issubstr(signature, "rumble")) {
    prefix = "rumble";
    writtenprefix = "rawfile";
    path = "rumble/";
  } else if(issubstr(signature, "shader")) {
    prefix = "shader";
    writtenprefix = "material";
  } else if(issubstr(signature, "shock")) {
    prefix = "shock";
    writtenprefix = "rawfile";
    extension = ".shock";
    path = "shock/";
  } else if(issubstr(signature, "string")) {
    prefix = "string";

    assertmsg("string not yet supported by scriptgen");

  } else if(issubstr(signature, "turret")) {
    prefix = "turret";
    writtenprefix = "weapon";
    path = "sp/";
  } else if(issubstr(signature, "vehicle")) {
    prefix = "vehicle";
    writtenprefix = "rawfile";
    path = "vehicles/";
  }

  if(!isDefined(prefix)) {
    return;
  }
  if(!isDefined(writtenprefix))
    string = prefix + ", " + getsubstr(signature, prefix.size + 1, signature.size);
  else
    string = writtenprefix + ", " + path + getsubstr(signature, prefix.size + 1, signature.size) + extension;

  if(file == -1 || !level.bcsvgened)
    println(string);
  else
    fprintln(file, string);
}

script_gen_dumpprintln(file, string) {
  if(file == -1 || !level.bscriptgened)
    println(string);
  else
    fprintln(file, string);
}

trigger_hint(trigger) {
  assert(isDefined(trigger.script_hint), "Trigger_hint at " + trigger.origin + " has no .script_hint");
  trigger endon("death");

  if(!isDefined(level.displayed_hints))
    level.displayed_hints = [];

  waittillframeend;
  hint = trigger.script_hint;
  assert(isDefined(level.trigger_hint_string[hint]), "Trigger_hint with hint " + hint + " had no hint string assigned to it. Define hint strings with add_hint_string()");
  trigger waittill("trigger", other);
  assert(isplayer(other), "Tried to do a trigger_hint on a non player entity");

  if(isDefined(level.displayed_hints[hint])) {
    return;
  }
  level.displayed_hints[hint] = 1;
  display_hint(hint);
}

throw_grenade_at_player_trigger(trigger) {
  trigger endon("death");
  trigger waittill("trigger");
  throwgrenadeatenemyasap();
}

flag_on_cleared(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag]))
    flag_init(flag, undefined, 1);

  for(;;) {
    trigger waittill("trigger");
    wait 1;

    if(trigger found_toucher()) {
      continue;
    }
    break;
  }

  flag_set(flag);
}

found_toucher() {
  ai = getaiarray("axis");

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isalive(guy)) {
      continue;
    }
    if(guy istouching(self))
      return true;

    wait 0.1;
  }

  ai = getaiarray("axis");

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(guy istouching(self))
      return true;
  }

  return false;
}

trigger_delete_on_touch(trigger) {
  for(;;) {
    trigger waittill("trigger", other);

    if(isDefined(other))
      other delete();
  }
}

flag_set_touching(trigger) {
  flag = trigger get_trigger_flag();

  if(!isDefined(level.flag[flag]))
    flag_init(flag, undefined, 1);

  for(;;) {
    trigger waittill("trigger", other);
    flag_set(flag);

    while(isalive(other) && other istouching(trigger) && isDefined(trigger))
      wait 0.25;

    flag_clear(flag);
  }
}

add_nodes_mins_maxs(nodes) {
  for(index = 0; index < nodes.size; index++) {
    origin = nodes[index].origin;
    level.nodesmins = expandmins(level.nodesmins, origin);
    level.nodesmaxs = expandmaxs(level.nodesmaxs, origin);
  }
}

calculate_map_center() {
  if(!isDefined(level.mapcenter)) {
    level.nodesmins = (0, 0, 0);
    level.nodesmaxs = (0, 0, 0);
    nodes = getallnodes();

    if(isDefined(nodes[0])) {
      level.nodesmins = nodes[0].origin;
      level.nodesmaxs = nodes[0].origin;
    }

    add_nodes_mins_maxs(nodes);
    level.mapcenter = findboxcenter(level.nodesmins, level.nodesmaxs);

    println("map center: ", level.mapcenter);

    setmapcenter(level.mapcenter);
  }
}

setobjectivetextcolors() {
  my_textbrightness_default = "1.0 1.0 1.0";
  my_textbrightness_90 = "0.9 0.9 0.9";
  my_textbrightness_85 = "0.85 0.85 0.85";

  if(level.script == "armada") {
    setsaveddvar("con_typewriterColorBase", my_textbrightness_90);
    return;
  }

  setsaveddvar("con_typewriterColorBase", my_textbrightness_default);
}

get_script_linkto_targets() {
  targets = [];

  if(!isDefined(self.script_linkto))
    return targets;

  tokens = strtok(self.script_linkto, " ");

  for(i = 0; i < tokens.size; i++) {
    token = tokens[i];
    target = getent(token, "script_linkname");

    if(isDefined(target))
      targets[targets.size] = target;
  }

  return targets;
}

delete_link_chain(trigger) {
  trigger waittill("trigger");
  targets = trigger get_script_linkto_targets();
  array_thread(targets, ::delete_links_then_self);
}

delete_links_then_self() {
  targets = get_script_linkto_targets();
  array_thread(targets, ::delete_links_then_self);
  self delete();
}

defer_vision_set_naked(vision, time) {
  if(numremoteclients())
    wait_network_frame();

  self visionsetnaked(vision, time);
}

trigger_fog(trigger) {
  trigger endon("death");
  dofog = 1;

  if(!isDefined(trigger.script_start_dist))
    dofog = 0;

  if(!isDefined(trigger.script_halfway_dist))
    dofog = 0;

  if(!isDefined(trigger.script_halfway_height))
    dofog = 0;

  if(!isDefined(trigger.script_base_height))
    dofog = 0;

  if(!isDefined(trigger.script_color))
    dofog = 0;

  if(!isDefined(trigger.script_color_scale))
    dofog = 0;

  if(!isDefined(trigger.script_transition_time))
    dofog = 0;

  if(!isDefined(trigger.script_sun_color))
    dofog = 0;

  if(!isDefined(trigger.script_sun_direction))
    dofog = 0;

  if(!isDefined(trigger.script_sun_start_ang))
    dofog = 0;

  if(!isDefined(trigger.script_sun_stop_ang))
    dofog = 0;

  if(!isDefined(trigger.script_max_fog_opacity))
    dofog = 0;

  do_sunsamplesize = 0;
  sunsamplesize_time = undefined;

  if(isDefined(trigger.script_sunsample)) {
    do_sunsamplesize = 0;
    trigger.lerping_dvar["sm_sunSampleSizeNear"] = 0;
    sunsamplesize_time = 1;

    if(isDefined(trigger.script_transition_time))
      sunsamplesize_time = trigger.script_sunsample_time;

    if(isDefined(trigger.script_sunsample_time))
      sunsamplesize_time = trigger.script_sunsample_time;
  }

  for(;;) {
    trigger waittill("trigger", other);
    assert(isplayer(other), "Non-player entity touched a trigger_fog.");
    wait 0.05;
    players = get_players();

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(player istouching(trigger)) {
        if(!issplitscreen()) {
          if(dofog && (!isDefined(player.fog_trigger_current) || player.fog_trigger_current != trigger))
            player setvolfog(trigger.script_start_dist, trigger.script_halfway_dist, trigger.script_halfway_height, trigger.script_base_height, trigger.script_color[0], trigger.script_color[1], trigger.script_color[2], trigger.script_color_scale, trigger.script_sun_color[0], trigger.script_sun_color[1], trigger.script_sun_color[2], trigger.script_sun_direction[0], trigger.script_sun_direction[1], trigger.script_sun_direction[2], trigger.script_sun_start_ang, trigger.script_sun_stop_ang, trigger.script_transition_time, trigger.script_max_fog_opacity);
        }

        if(isDefined(trigger.script_vision) && isDefined(trigger.script_vision_time) && (!isDefined(player.fog_trigger_current) || player.fog_trigger_current != trigger))
          player thread defer_vision_set_naked(trigger.script_vision, trigger.script_vision_time);

        player.fog_trigger_current = trigger;
      }
    }

    players = get_players();

    if(players.size > 1) {
      if(do_sunsamplesize) {
        dvar = "sm_sunSampleSizeNear";

        if(!trigger.lerping_dvar[dvar] && getdvar(dvar) != trigger.script_sunsample)
          level thread lerp_trigger_dvar_value(trigger, dvar, trigger.script_sunsample, sunsamplesize_time);
      }
    }
  }
}

lerp_trigger_dvar_value(trigger, dvar, value, time) {
  trigger.lerping_dvar[dvar] = 1;
  steps = time * 20;
  curr_value = getdvarfloat(dvar);
  diff = (curr_value - value) / steps;

  for(i = 0; i < steps; i++) {
    curr_value = curr_value - diff;
    setsaveddvar(dvar, curr_value);
    wait 0.05;
  }

  setsaveddvar(dvar, value);
  trigger.lerping_dvar[dvar] = 0;
}

set_fog_progress(progress) {
  anti_progress = 1 - progress;
  startdist = self.script_start_dist * anti_progress + self.script_start_dist * progress;
  halfwaydist = self.script_halfway_dist * anti_progress + self.script_halfway_dist * progress;
  color = self.script_color * anti_progress + self.script_color * progress;
  setvolfog(startdist, halfwaydist, self.script_halfway_height, self.script_base_height, color[0], color[1], color[2], 0.4);
}

remove_level_first_frame() {
  wait 0.05;
  level.first_frame = undefined;
}

no_crouch_or_prone_think(trigger) {
  for(;;) {
    trigger waittill("trigger", other);

    if(!isplayer(other)) {
      continue;
    }
    while(other istouching(trigger)) {
      other allowprone(0);
      other allowcrouch(0);
      wait 0.05;
    }

    other allowprone(1);
    other allowcrouch(1);
  }
}

no_prone_think(trigger) {
  for(;;) {
    trigger waittill("trigger", other);

    if(!isplayer(other)) {
      continue;
    }
    while(other istouching(trigger)) {
      other allowprone(0);
      wait 0.05;
    }

    other allowprone(1);
  }
}

ascii_logo() {
  println("Call Of Duty 7");
}

check_flag_for_stat_tracking(msg) {
  if(!is_prefix(msg, "aa_")) {
    return;
  }
  [[level.sp_stat_tracking_func]](msg);
}

precache_script_models() {
  if(!isDefined(level.scr_model)) {
    return;
  }
  models = getarraykeys(level.scr_model);

  for(i = 0; i < models.size; i++)
    precachemodel(level.scr_model[models[i]]);
}

player_death_detection() {
  setdvar("player_died_recently", "0");
  thread player_died_recently_degrades();
  level add_wait(::flag_wait, "missionfailed");
  self add_wait(::waittill_msg, "death");
  do_wait_any();
  recently_skill = [];
  recently_skill[0] = 70;
  recently_skill[1] = 30;
  recently_skill[2] = 0;
  recently_skill[3] = 0;
  setdvar("player_died_recently", recently_skill[level.gameskill]);
}

player_died_recently_degrades() {
  for(;;) {
    recent_death_time = getdvarint(#"_id_B93E75EC");

    if(recent_death_time > 0) {
      recent_death_time = recent_death_time - 5;
      setdvar("player_died_recently", recent_death_time);
    }

    wait 5;
  }
}

all_players_connected() {
  while(true) {
    num_con = getnumconnectedplayers();
    num_exp = getnumexpectedplayers();

    println("all_players_connected(): getnumconnectedplayers=", num_con, "getnumexpectedplayers=", num_exp);

    if(num_con == num_exp && num_exp != 0) {
      flag_set("all_players_connected");
      setdvar("all_players_are_connected", "1");
      return;
    }

    wait 0.05;
  }
}

all_players_spawned() {
  flag_wait("all_players_connected");
  waittillframeend;

  while(true) {
    players = get_players();
    count = 0;

    for(i = 0; i < players.size; i++) {
      if(players[i].sessionstate == "playing")
        count++;
    }

    if(count == players.size) {
      break;
    }

    wait 0.05;
  }

  flag_set("all_players_spawned");
}

adjust_placed_weapons() {
  weapons = getentarray("placed_weapon", "targetname");
  flag_wait("all_players_connected");
  players = get_players();
  player_count = players.size;

  for(i = 0; i < weapons.size; i++) {
    if(isDefined(weapons[i].script_player_min) && player_count < weapons[i].script_player_min)
      weapons[i] delete();
  }
}

explodable_volume() {
  self thread explodable_volume_think();
  exploder = getent(self.target, "targetname");

  if(isDefined(exploder) && isDefined(exploder.script_exploder))
    level waittill("exploder" + exploder.script_exploder);
  else
    exploder waittill("exploding");

  self delete();
}

explodable_volume_think() {
  assert(isDefined(self.target), "Explodable Volume must be targeting an exploder or an explodable object.");
  target = getent(self.target, "targetname");
  assert(isDefined(target), "Explodable Volume has an invalid target.");

  if(isDefined(target.remove))
    target = target.remove;

  self._explodable_target = target;

  while(true) {
    self waittill("trigger", ent);
    ent thread explodable_volume_ent_think(self, target);
    wait 0.5;
  }
}

explodable_volume_ent_think(volume, target) {
  if(!isDefined(self._explodable_volumes))
    self._explodable_volumes = [];

  if(isinarray(self._explodable_volumes, volume)) {
    return;
  }
  if(!isDefined(self._explodable_targets))
    self._explodable_targets = [];

  self._explodable_volumes[self._explodable_volumes.size] = volume;
  self._explodable_targets[self._explodable_targets.size] = target;

  while(isalive(self) && isDefined(volume) && self istouching(volume))
    wait 0.5;

  if(isDefined(self)) {
    arrayremovevalue(self._explodable_volumes, volume);
    arrayremovevalue(self._explodable_targets, target);
  }
}

update_script_forcespawn_based_on_flags() {
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    if(spawners[i] has_spawnflag(16))
      spawners[i].script_forcespawn = 1;
  }
}

trigger_once(trig) {
  trig endon("death");

  if(is_look_trigger(trig))
    trig waittill("trigger_look");
  else
    trig waittill("trigger");

  waittillframeend;
  waittillframeend;

  if(isDefined(trig)) {
    println("");
    println("*** trigger debug: deleting trigger with ent#: " + trig getentitynumber() + " at origin: " + trig.origin);
    println("");

    trig delete();
  }
}