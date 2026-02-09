/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_cortex.gsc
*****************************************************/

monitor_cortex_fired() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(!common_scripts\utility::flag_exist("start_ark_encounter") || !common_scripts\utility::flag("start_ark_encounter"))
    wait 1;

  if(self hasweapon("aliencortex_mp")) {
    self takeweapon("aliencortex_mp");
    self enableweaponswitch();
  }

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 != "aliencortex_mp") {
      continue;
    }
    if(!maps\mp\alien\_utility::is_true(level.cortex_fire_allowed)) {
      var_0 delete();
      self setweaponammoclip("aliencortex_mp", 2);
      continue;
    }

    level.cortex_fire_allowed = 0;
    level thread cortex_fire_allowed();
    var_2 = self.angles;
    var_3 = anglesToForward(var_2);
    var_4 = vector_multiply(var_3, 20);
    var_5 = anglestoup(var_2);
    self playFX(level._effect["cortex_blast_sm"], self.origin + (0, 0, 40) + var_4, var_5);
    self playSound("scn_cortex_use_runout");
    level thread cortex_blast();
    var_0 delete();
    self setweaponammoclip("aliencortex_mp", 2);
  }
}

cortex_fire_allowed() {
  wait 5;
  level.cortex_fire_allowed = 1;
}

vector_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

wait_for_player_to_place_cortex() {
  level endon("game_ended");
  self endon("death");
  self endon("last_stand");
  self endon("disconnect");
  level endon("cortex_dropped");
  level endon("cortex_planted");

  while(self usebuttonpressed())
    wait 1;

  var_0 = 6400;

  for(;;) {
    if(self usebuttonpressed() && isDefined(level.cortex_carrier) && level.cortex_carrier == self && self hasweapon("aliencortex_mp") && self isonground()) {
      if(isDefined(level.current_cortex_spot) && distancesquared(self.origin, level.current_cortex_spot.origin) <= var_0) {
        self setweaponammoclip("aliencortex_mp", 0);
        self setweaponammostock("aliencortex_mp", 0);
        drop_cortex(self.origin + (0, 0, 6), (0, 0, 0));
        earthquake(0.15, 0.15, self.origin, 128);
        self setclientomnvar("ui_alien_unlimited_ammo", 0);

        if(!maps\mp\alien\_utility::has_special_weapon())
          self enableweaponswitch();

        restore_last_weapon();
        common_scripts\utility::_enableoffhandweapons();
        turn_off_cortex();
        self forceusehintoff();
        level notify("cortex_plant");
        level thread remove_cortex_from_player(self);
      } else {
        place_cortex(self);
        self.player_action_disabled = undefined;
        turn_on_cortex();
        self forceusehintoff();
        level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_PICKUP_CORTEX");
        level notify("cortex_dropped");
      }
    }

    wait 0.05;
  }
}

remove_cortex_from_player(var_0) {
  self endon("disconnect");
  wait 1;
  var_0 takeweapon("aliencortex_mp");
  var_0.player_action_disabled = undefined;
}

cortex_blast(var_0) {
  wait 0.5;
  var_1 = maps\mp\alien\_spawnlogic::get_alive_agents();
  var_2 = 250000;

  if(var_1.size == 0) {
    return;
  }
  var_3 = undefined;

  if(isDefined(level.cortex_carrier))
    var_3 = level.cortex_carrier;
  else if(isDefined(level.cortex))
    var_3 = level.cortex;
  else if(isDefined(var_0))
    var_3 = var_0;

  var_1 = common_scripts\utility::get_array_of_closest(var_3.origin, var_1);

  foreach(var_5 in var_1) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(distancesquared(var_3.origin, var_5.origin) > var_2) {
      continue;
    }
    if(isDefined(level.cortex_carrier)) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_5.cortex_kill = 1;
      var_5 dodamage(var_5.health + 10000, var_5.origin, var_3, var_3);
      playFX(level._effect["alien_gib"], var_5.origin + (0, 0, 32));
    }

    wait 0.1;
  }
}

place_cortex(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = undefined;
  var_2 = var_0 aiphysicstrace(var_0.origin + (0, 0, 8), var_0.origin - (0, 0, 12), undefined, undefined, 1, 1);

  if(var_2["fraction"] == 1)
    return;
  else
    var_1 = var_2["position"];

  if(!var_0 maps\mp\alien\_utility::has_special_weapon())
    var_0 enableweaponswitch();

  var_0.is_holding_deployable = 0;
  var_0 restore_last_weapon();
  var_0 common_scripts\utility::_enableoffhandweapons();
  var_0 setweaponammoclip("aliencortex_mp", 0);
  var_0 setweaponammostock("aliencortex_mp", 0);
  wait 1;
  var_0 takeweapon("aliencortex_mp");
  drop_cortex(var_1, (0, 0, 0));
  earthquake(0.15, 0.15, var_0.origin, 128);
  var_0 setclientomnvar("ui_alien_unlimited_ammo", 0);
}

restore_last_weapon() {
  if(self.lastweapon != "aliendeployable_crate_marker_mp")
    self switchtoweapon(self.lastweapon);
  else
    self switchtoweapon(self getweaponslistprimaries()[0]);
}

create_cortex(var_0, var_1) {
  var_2 = 1;
  level.cortex_carrier = undefined;

  if(isDefined(level.cortex))
    level.cortex delete();

  level.cortex = spawn("script_model", var_0 + (0, 0, 5));
  level.cortex setModel("dct_alien_container");

  if(var_2)
    level.cortex thread maps\mp\alien\_drill::angles_to_ground(var_0, var_1, (0, 0, 0));
  else
    level.cortex.angles = var_1;

  level notify("cortex_spawned");
}

drop_cortex(var_0, var_1) {
  create_cortex(var_0, var_1);

  if(!isDefined(level.cortex_icon))
    create_cortex_icon();

  level.cortex_icon.x = level.cortex.origin[0];
  level.cortex_icon.y = level.cortex.origin[1];
  level.cortex_icon.z = level.cortex.origin[2] + 52;
  level.cortex_icon.alpha = 0.75;
  create_cortex_use_trigger();
  level.cortex_use_trigger makeunusable();
  level.cortex thread cortex_pickup_listener();
  level thread remove_cortex_player_icon();
  level.cortex_use_trigger.origin = level.cortex.origin + (0, 0, 40);
}

create_cortex_use_trigger() {
  wait 0.5;

  while(!isDefined(level.cortex))
    wait 0.1;

  if(!isDefined(level.cortex_use_trigger)) {
    level.cortex_use_trigger = spawn("script_model", level.cortex.origin + (0, 0, 40));
    level.cortex_use_trigger setModel("tag_origin");
  }
}

create_cortex_icon() {
  level.cortex_icon = newhudelem();
  level.cortex_icon setshader("waypoint_alien_cortex", 14, 14);
  level.cortex_icon.color = (1, 1, 1);
  level.cortex_icon setwaypoint(1, 1);
  level.cortex_icon.sort = 1;
  level.cortex_icon.foreground = 1;
  level.cortex_icon.alpha = 0.75;
  level.cortex_icon.x = level.cortex.origin[0];
  level.cortex_icon.y = level.cortex.origin[1];
  level.cortex_icon.z = level.cortex.origin[2] + 52;
}

set_cortex_player_icon(var_0) {
  var_0 maps\mp\_entityheadicons::setheadicon(var_0.team, "waypoint_alien_cortex", (0, 0, 72), 4, 4, undefined, undefined, undefined, 1, undefined, 0);
}

remove_cortex_player_icon() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.entityheadicons)) {
      foreach(var_4, var_3 in var_1.entityheadicons) {
        if(!isDefined(var_3)) {
          continue;
        }
        var_3 destroy();
      }
    }
  }
}

destroy_cortex_icon() {
  if(isDefined(level.cortex_icon))
    level.cortex_icon destroy();

  level thread remove_cortex_player_icon();
}

turn_off_cortex() {
  maps\mp\alien\_outline_proto::remove_from_drill_preplant_watch_list(level.cortex);

  if(isDefined(level.cortex_use_trigger))
    level.cortex_use_trigger makeunusable();
  else
    level.cortex makeunusable();

  if(isDefined(level.cortex_icon))
    level.cortex_icon.alpha = 0.0;

  level thread remove_cortex_player_icon();
}

turn_on_cortex() {
  maps\mp\alien\_outline_proto::add_to_drill_preplant_watch_list(level.cortex);

  if(isDefined(level.cortex_use_trigger))
    level.cortex_use_trigger makeusable();
  else
    level.cortex makeusable();

  if(isDefined(level.cortex_icon))
    level.cortex_icon.alpha = 0.75;
}

cortex_pickup_listener(var_0) {
  self endon("death");
  level endon("game_ended");
  level endon("cortex_spawned");
  var_1 = level.cortex_use_trigger;

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(!common_scripts\utility::flag("ark_console_event_done")) {
      continue;
    }
    if(!common_scripts\utility::flag("cortex_carryable")) {
      continue;
    }
    if(var_2 maps\mp\alien\_utility::is_holding_deployable()) {
      var_2 maps\mp\_utility::setlowermessage("cant_buy", &"ALIEN_COLLECTIBLES_PLAYER_HOLDING", 3);
      continue;
    }

    if(var_2 getstance() == "prone" || var_2 getstance() == "crouch") {
      var_2 maps\mp\_utility::setlowermessage("change_stance", &"ALIENS_PATCH_CHANGE_STANCE", 3);
      continue;
    }

    if(maps\mp\alien\_utility::is_true(var_2.picking_up_item)) {
      continue;
    }
    if(maps\mp\alien\_utility::is_true(var_2.iscarrying)) {
      continue;
    }
    var_2.is_holding_deployable = 1;
    var_2 common_scripts\utility::_disableusability();
    var_2 thread maps\mp\alien\_drill::delayed_enable_usability();

    if(isPlayer(var_2)) {
      break;
    }
  }

  if(maps\mp\alien\_utility::alien_mode_has("outline"))
    maps\mp\alien\_outline_proto::remove_from_drill_preplant_watch_list(level.cortex);

  level.cortex_use_trigger makeunusable();

  if(isDefined(level.cortex_icon))
    level.cortex_icon.alpha = 0;

  var_2 setclientomnvar("ui_alien_unlimited_ammo", 1);
  level.cortex = undefined;
  level notify("cortex_pickedup", var_2);
  self playSound("extinction_item_pickup");
  level.cortex_carrier = var_2;
  var_2.player_action_disabled = 1;
  level.last_cortex_pickup_origin = common_scripts\utility::drop_to_ground(self.origin, 16, -32);
  level.last_cortex_pickup_angles = self.angles;
  level.cortex_carrier set_cortex_player_icon(level.cortex_carrier);
  var_2 forceusehinton(&"MP_ALIEN_DESCENT_CORTEX_CARRY_HINT");
  var_2 thread drop_cortex_on_death();
  var_2 thread drop_cortex_on_disconnect();
  var_2.lastweapon = var_2 getcurrentweapon();
  var_2 maps\mp\_utility::_giveweapon("aliencortex_mp");
  var_2 switchtoweapon("aliencortex_mp");
  var_2 disableweaponswitch();
  var_2 common_scripts\utility::_disableoffhandweapons();
  var_2 thread wait_for_player_to_place_cortex();
  var_2 notify("kill_spendhint");
  var_2 notify("dpad_cancel");
  self delete();
}

drop_cortex_on_death() {
  level endon("cortex_dropped");
  level endon("cortex_planted");
  level notify("cortex_player_monitor");
  level endon("cortex_player_monitor");
  common_scripts\utility::waittill_either("death", "last_stand");
  self setclientomnvar("ui_alien_unlimited_ammo", 0);
  self takeweapon("aliencortex_mp");
  self enableweaponswitch();
  self switchtoweapon(self.lastweapon);
  self.is_holding_deployable = 0;

  if(isDefined(self.disabledoffhandweapons) && self.disabledoffhandweapons > 0)
    common_scripts\utility::_enableoffhandweapons();

  self forceusehintoff();
  level.cortex_carrier = undefined;
  self.player_action_disabled = undefined;
  level thread remove_cortex_player_icon();

  if(maps\mp\alien\_utility::is_true(self.kill_trigger_event_processed)) {
    var_0 = common_scripts\utility::getclosest(self.origin, common_scripts\utility::getstructarray("respawn_cortex", "targetname"));

    if(!isDefined(var_0.angles))
      var_0.angles = (0, 0, 0);

    drop_cortex(var_0.origin, var_0.angles);
  } else
    drop_cortex(self.origin, (0, 0, 0));

  level.cortex_use_trigger makeusable();
  level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_PICKUP_CORTEX");
  maps\mp\alien\_outline_proto::add_to_drill_preplant_watch_list(level.cortex);
}

drop_cortex_on_disconnect() {
  level endon("cortex_dropped");
  level endon("cortex_planted");
  level notify("cortex_disconnect_monitor");
  level endon("cortex_disconnect_monitor");
  level endon("game_ended");
  self endon("death");
  self endon("last_stand");
  self waittill("disconnect");
  var_0 = level.last_cortex_pickup_origin;
  var_1 = common_scripts\utility::getclosest(var_0, common_scripts\utility::getstructarray("respawn_cortex", "targetname"));

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  playFX(level._effect["alien_teleport"], var_1.origin);
  playFX(level._effect["alien_teleport_dist"], var_1.origin);
  drop_cortex(var_1.origin, var_1.angles);
  maps\mp\alien\_outline_proto::add_to_drill_preplant_watch_list(level.cortex);
  level.cortex_use_trigger makeusable();
  level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_PICKUP_CORTEX");
}