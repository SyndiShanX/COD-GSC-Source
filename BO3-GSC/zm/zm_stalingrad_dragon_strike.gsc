/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_dragon_strike.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_stalingrad_pap_quest;
#namespace namespace_19e79ea1;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_dragon_strike", & __init__, & __main__, undefined);
}

function __init__() {
  callback::on_spawned( & on_player_spawned);
  zm::register_player_damage_callback( & function_43b5419a);
}

function __main__() {
  level flag::init("dragon_strike_unlocked");
  level flag::init("dragon_strike_acquired");
  clientfield::register("scriptmover", "lockbox_light_1", 12000, 2, "int");
  clientfield::register("scriptmover", "lockbox_light_2", 12000, 2, "int");
  clientfield::register("scriptmover", "lockbox_light_3", 12000, 2, "int");
  clientfield::register("scriptmover", "lockbox_light_4", 12000, 2, "int");
  function_316be9a7();
}

function on_player_spawned() {
  if(!self flag::exists("dragon_strike_lockbox_trigger_used")) {
    self flag::init("dragon_strike_lockbox_trigger_used");
    if(level flag::get("dragon_strike_unlocked")) {
      self flag::set("dragon_strike_lockbox_trigger_used");
    }
  }
  if(!self flag::exists("dragon_strike_lockbox_upgraded_trigger_used")) {
    self flag::init("dragon_strike_lockbox_upgraded_trigger_used");
    if(level flag::get("draconite_available")) {
      self flag::set("dragon_strike_lockbox_upgraded_trigger_used");
    }
  }
}

function function_43b5419a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(isdefined(einflictor) && isdefined(einflictor.item) && einflictor.item == getweapon("launcher_dragon_fire")) {
    return 0;
  }
  return -1;
}

function function_ea7e3000(s_unitrigger, var_df61c394, var_60e07243) {
  self endon("disconnect");
  var_8de3e280 = getent("pavlovs_second_floor", "targetname");
  while (!level flag::get(var_df61c394)) {
    if(!self istouching(var_8de3e280)) {
      self flag::clear(var_60e07243);
      s_unitrigger.var_f30d1f8f.var_f2c16bcc--;
      break;
    }
    wait(0.05);
  }
}

function function_748696f0(b_on, n_tag) {
  str_clientfield = "lockbox_light_" + n_tag;
  if(b_on) {
    self clientfield::set(str_clientfield, 1);
  } else {
    self clientfield::set(str_clientfield, 2);
  }
}

function function_41457bd1() {
  level endon("_zombie_game_over");
  level flag::wait_till("all_players_spawned");
  self.var_f2c16bcc = 0;
  while (self.var_f2c16bcc < 4) {
    var_f2c16bcc = 4 - level.players.size;
    var_29ec90ed = 0;
    foreach(player in level.players) {
      if(player flag::get("dragon_strike_lockbox_trigger_used")) {
        var_f2c16bcc++;
      }
    }
    for (i = 1; i <= self.var_f2c16bcc; i++) {
      self thread function_748696f0(1, i);
      var_29ec90ed++;
    }
    if(self.var_f2c16bcc >= 4) {
      break;
    }
    for (i = var_29ec90ed + 1; i <= 4; i++) {
      self thread function_748696f0(0, i);
    }
    self.var_f2c16bcc = var_f2c16bcc;
    wait(0.05);
  }
  level flag::set("dragon_strike_unlocked");
  for (i = 1; i <= 4; i++) {
    self thread function_748696f0(1, i);
  }
}

function function_8f02cb7e() {
  level endon("_zombie_game_over");
  for (i = 1; i <= 4; i++) {
    self thread function_748696f0(0, i);
  }
  self.var_f2c16bcc = 0;
  while (self.var_f2c16bcc < 4) {
    var_f2c16bcc = 4 - level.players.size;
    var_29ec90ed = 0;
    foreach(player in level.players) {
      if(player flag::get("dragon_strike_lockbox_upgraded_trigger_used")) {
        var_f2c16bcc++;
      }
    }
    for (i = 1; i <= self.var_f2c16bcc; i++) {
      self thread function_748696f0(1, i);
      var_29ec90ed++;
    }
    if(self.var_f2c16bcc >= 4) {
      break;
    }
    for (i = var_29ec90ed + 1; i <= 4; i++) {
      self thread function_748696f0(0, i);
    }
    self.var_f2c16bcc = var_f2c16bcc;
    wait(0.05);
  }
  level flag::set("dragon_stage4_started");
  for (i = 1; i <= 4; i++) {
    self thread function_748696f0(1, i);
  }
}

function function_316be9a7() {
  s_unitrigger = struct::get("dragon_strike_controller");
  s_unitrigger.var_f30d1f8f = spawn("script_model", s_unitrigger.origin);
  s_unitrigger.var_f30d1f8f.angles = s_unitrigger.angles;
  s_unitrigger.var_f30d1f8f setmodel("p7_zm_sta_dragon_strike_console");
  s_unitrigger.var_f30d1f8f.targetname = "dragon_strike_lockbox";
  wait(0.05);
  for (i = 1; i <= 4; i++) {
    s_unitrigger.var_f30d1f8f function_748696f0(0, i);
  }
  s_unitrigger.var_f30d1f8f thread function_41457bd1();
  s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
  s_unitrigger.cursor_hint = "HINT_NOICON";
  s_unitrigger.require_look_at = 0;
  s_unitrigger.radius = 100;
  s_unitrigger.height = 100;
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
  s_unitrigger.prompt_and_visibility_func = & function_10d61b3;
  zm_unitrigger::register_static_unitrigger(s_unitrigger, & function_68299355);
  var_620858e1 = s_unitrigger.var_f30d1f8f gettagorigin("tag_animate");
  var_14dae7af = s_unitrigger.var_f30d1f8f gettagangles("tag_animate");
  s_unitrigger.var_f30d1f8f.var_6306226 = util::spawn_model("tag_origin", var_620858e1, var_14dae7af);
  s_unitrigger.var_f30d1f8f.var_6306226 scene::init("p7_fxanim_zm_stal_dragon_strike_console_bundle", s_unitrigger.var_f30d1f8f.var_6306226);
  s_unitrigger.var_f30d1f8f.var_6306226 thread function_f25c1083();
}

function function_10d61b3(player) {
  if(level flag::get("draconite_available") && player zm_utility::get_player_placeable_mine() != getweapon("launcher_dragon_strike_upgraded")) {
    self sethintstringforplayer(player, & "ZM_STALINGRAD_DRAGON_STRIKE_UPGRADED_PICKUP");
    return true;
  }
  if(level flag::get("dragon_strike_quest_complete") && !level flag::get("draconite_available") && player zm_utility::get_player_placeable_mine() != getweapon("launcher_dragon_strike")) {
    self sethintstringforplayer(player, & "ZM_STALINGRAD_DRAGON_STRIKE_PICKUP");
    return true;
  }
  if(level flag::get("dragon_strike_unlocked") && player zm_utility::get_player_placeable_mine() == getweapon("launcher_dragon_strike") && !level flag::get("dragon_stage3_started") || (level flag::get("dragon_strike_unlocked") && !level flag::get("dragon_strike_quest_complete")) || (level flag::get("draconite_available") && player zm_utility::get_player_placeable_mine() == getweapon("launcher_dragon_strike_upgraded")) || (!level flag::get("draconite_available") && level flag::get("dragon_stage4_started")) || level flag::get("special_round") || level.round_number == level.var_a78effc7 || level flag::get("scenario_active")) {
    self sethintstringforplayer(player, "");
    return false;
  }
  if(level flag::get("dragon_stage3_started") && !player flag::get("dragon_strike_lockbox_upgraded_trigger_used")) {
    self sethintstringforplayer(player, & "ZM_STALINGRAD_DRAGON_STRIKE_UPGRADED_UNLOCK");
    return true;
  }
  if(player flag::get("dragon_strike_lockbox_trigger_used") && !level flag::get("dragon_strike_unlocked") || (player flag::get("dragon_strike_lockbox_upgraded_trigger_used") && !level flag::get("dragon_stage4_started"))) {
    self sethintstringforplayer(player, & "ZM_STALINGRAD_DRAGON_STRIKE_UNLOCK_INCOMPLETE");
    return false;
  }
  if(!player flag::get("dragon_strike_lockbox_trigger_used") && !level flag::get("dragon_strike_unlocked")) {
    self sethintstringforplayer(player, & "ZM_STALINGRAD_DRAGON_STRIKE_UNLOCK");
    return true;
  }
}

function function_68299355() {
  level flag::wait_till("all_players_spawned");
  while (true) {
    self waittill("trigger", e_player);
    e_player clientfield::increment_to_player("interact_rumble");
    e_player playsound("zmb_stalingrad_buttons");
    if(level flag::get("draconite_available") && e_player zm_utility::get_player_placeable_mine() != getweapon("launcher_dragon_strike_upgraded")) {
      e_player playsound("zmb_ds_machine_grab");
      e_player function_8258d71c();
      zm_unitrigger::assess_and_apply_visibility(self.stub.trigger, self.stub, e_player, 0);
    } else {
      if(level flag::get("dragon_strike_quest_complete") && !level flag::get("draconite_available") && e_player zm_utility::get_player_placeable_mine() != getweapon("launcher_dragon_strike")) {
        e_player playsound("zmb_ds_machine_replace");
        e_player function_8258d71c();
        level flag::set("dragon_strike_acquired");
        zm_unitrigger::assess_and_apply_visibility(self.stub.trigger, self.stub, e_player, 0);
      } else {
        if(level flag::get("dragon_stage3_started") && !level flag::get("dragon_stage4_started") && !e_player flag::get("dragon_strike_lockbox_upgraded_trigger_used")) {
          e_player flag::set("dragon_strike_lockbox_upgraded_trigger_used");
          e_player thread function_ea7e3000(self.stub, "dragon_stage4_started", "dragon_strike_lockbox_upgraded_trigger_used");
          e_player playsound("zmb_ds_machine_replace");
          self.stub.var_f30d1f8f.var_f2c16bcc++;
        } else if(!level flag::get("dragon_strike_unlocked") && !e_player flag::get("dragon_strike_lockbox_trigger_used")) {
          e_player flag::set("dragon_strike_lockbox_trigger_used");
          e_player thread function_ea7e3000(self.stub, "dragon_strike_unlocked", "dragon_strike_lockbox_trigger_used");
          self.stub.var_f30d1f8f.var_f2c16bcc++;
        }
      }
    }
  }
}

function function_f25c1083() {
  level flag::wait_till("dragon_strike_quest_complete");
  var_8de3e280 = getent("pavlovs_second_floor", "targetname");
  while (!util::any_player_is_touching(var_8de3e280, "allies")) {
    wait(1);
  }
  self scene::play("p7_fxanim_zm_stal_dragon_strike_console_bundle");
}

function function_8258d71c() {
  if(level flag::get("draconite_available")) {
    var_5a0c399b = getweapon("launcher_dragon_strike_upgraded");
    n_max_ammo = 2;
  } else {
    var_5a0c399b = getweapon("launcher_dragon_strike");
    n_max_ammo = 1;
  }
  self thread zm_placeable_mine::setup_for_player(var_5a0c399b, "hudItems.showDpadRight_DragonStrike");
  self thread function_b8ea3482("zmInventory.widget_dragon_strike");
  self zm_weapons::weapon_give(var_5a0c399b);
  self setweaponammoclip(var_5a0c399b, n_max_ammo);
  self thread zm_equipment::show_hint_text(&"ZM_STALINGRAD_DRAGON_STRIKE_EQUIP");
  self zm_audio::create_and_play_dialog("weapon_pickup", "controller");
}

function function_b8ea3482(str_widget_clientuimodel) {
  self endon("disconnect");
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 1);
  wait(3);
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 0);
}

function function_56059128() {
  level flag::init("dragonstrike_stage_complete");
  level flag::init("dragon_stage1_started");
  level flag::init("dragon_stage3_started");
  level flag::init("dragon_stage4_started");
  level flag::init("draconite_available");
  level thread function_93510b8b();
}

function function_93510b8b() {
  level flag::wait_till("dragon_strike_unlocked");
  level flag::set("dragon_stage1_started");
  zm_spawner::register_zombie_death_event_callback( & function_2e107eef);
  level function_815a155e(20 + (10 * level.players.size));
  zm_spawner::deregister_zombie_death_event_callback( & function_2e107eef);
  level function_e6794c49();
  level thread function_5cb61169();
  level flag::wait_till("dragon_stage3_started");
  s_unitrigger = struct::get("dragon_strike_controller");
  while (true) {
    s_unitrigger.var_f30d1f8f function_8f02cb7e();
    level.var_d4286019 = 1;
    level function_af4562b1();
    zm_spawner::register_zombie_death_event_callback( & function_2e107eef);
    level thread function_815a155e(15 + (5 * level.players.size));
    level thread function_46c8b621();
    level flag::wait_till("lockdown_active");
    level flag::wait_till("lockdown_complete");
    zm_spawner::deregister_zombie_death_event_callback( & function_2e107eef);
    if(level flag::get("dragonstrike_stage_complete")) {
      break;
    } else {
      level flag::clear("dragon_stage4_started");
      foreach(player in level.players) {
        player flag::clear("dragon_strike_lockbox_upgraded_trigger_used");
      }
    }
  }
  level.var_d4286019 = 0;
  level flag::set("draconite_available");
  playsoundatposition("zmb_ee_dragon_success", (0, 0, 0));
}

function function_e6794c49() {
  wait(10);
  playsoundatposition("zmb_drag_strike_lockdown_over", (0, 0, 0));
  iprintlnbold("");
}

function function_af4562b1() {
  var_5a0c399b = getweapon("launcher_dragon_strike");
  foreach(player in level.players) {
    if(player zm_utility::get_player_placeable_mine() === var_5a0c399b) {
      player setweaponammoclip(var_5a0c399b, 1);
    }
  }
}

function function_2e107eef(e_attacker) {
  if(isdefined(self) && self.damageweapon === getweapon("launcher_dragon_fire") && (level flag::get("dragon_stage1_started") || (level flag::get("dragon_stage3_started") && level flag::get("lockdown_active")))) {
    if(isdefined(e_attacker) && isdefined(e_attacker.player)) {
      level notify("hash_d4eb8535");
    }
  }
}

function function_815a155e(var_62a210b7) {
  level notify("hash_2e199c2");
  level endon("hash_2e199c2");
  level flag::clear("dragonstrike_stage_complete");
  level.var_3810a36f = 0;
  while (true) {
    level waittill("hash_d4eb8535");
    level.var_3810a36f++;
    if(level.var_3810a36f >= var_62a210b7) {
      level flag::set("dragonstrike_stage_complete");
      break;
    }
  }
}

function function_5cb61169() {
  level flag::wait_till("all_players_connected");
  var_47295c1 = getentarray("dragonstrike_ee_banner", "targetname");
  level.var_65d93bca = level.players.size;
  var_47295c1 = array::randomize(var_47295c1);
  for (i = level.var_65d93bca; i < var_47295c1.size; i++) {
    var_47295c1[i] delete();
  }
  var_47295c1 = array::remove_undefined(var_47295c1, 0);
  array::thread_all(var_47295c1, & function_75a7ba2d);
}

function function_75a7ba2d() {
  self.takedamage = 1;
  while (true) {
    self waittill("damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags);
    if(weapon === getweapon("launcher_dragon_fire")) {
      break;
    }
  }
  level.var_65d93bca--;
  if(level.var_65d93bca < 1) {
    level flag::set("dragon_stage3_started");
    playsoundatposition("zmb_ee_success", (0, 0, 0));
  } else {
    playsoundatposition("zmb_ee_step_success", (0, 0, 0));
  }
  self delete();
}

function function_46c8b621() {
  var_2b71b5b4 = 3 + level.players.size;
  var_af22dd13 = 2 + level.players.size;
  level thread zm_stalingrad_pap::function_6236d848(18, 4, 20, 5, 22, 6, var_2b71b5b4, level.players.size + 1, 3, var_af22dd13, level.players.size + 1, 2);
}