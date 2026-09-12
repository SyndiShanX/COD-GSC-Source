/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\binoculars.gsc
***********************************************/

#using_animtree("");

function teamuseonly() {
  level.get_station_controller_struct = spawnStruct();
  level.get_station_controller_struct.plundertotal = getdvarint("scr_br_carriable_gasoline_explosion_radius", 300);
  level.get_station_controller_struct.plunderstructreplenish = getdvarint("scr_br_carriable_gasoline_explosion_max_dmg", 250);
  level.get_station_controller_struct.plundertimer = getdvarint("scr_br_carriable_gasoline_explosion_min_dmg", 50);
  setdvarifuninitialized("scr_br_carriable_respawn_time", 0);
  setdvarifuninitialized("scr_br_carriable_inactive_delete_time", 300);
  setdvarifuninitialized("scr_br_carriable_spawn_system", 0);
  setdvarifuninitialized("scr_br_carriable_max_entity_cariables", 50);
  setdvarifuninitialized("scr_br_carriable_spawn_chance", 0);
  precachestring(&"MP_BR_INGAME/PICKUP_PROPANE");
  precachestring(&"MP_BR_INGAME/PICKUP_POISON");
  setdvarifuninitialized("carriableFuseTime", 5);
  setdvarifuninitialized("carriableThrowForce", 2250);
  level.get_tier_reward_for_total_time = [];
  level.get_tier_reward_for_total_time["gasoline"] = spawnStruct();
  level.get_tier_reward_for_total_time["gasoline"].weaponname = "gasoline_can_mp";
  level.get_tier_reward_for_total_time["gasoline"].modelname = "offhand_wm_jerrycan_thrown";
  level.get_tier_reward_for_total_time["gasoline"].spawn_guys_at_lz = &"MP_BR_INGAME/PICKUP_PROPANE";
  level.get_tier_reward_for_total_time["gasoline"].leader_charge_dialogue = &get_silencedshot_alias;
  level.get_tier_reward_for_total_time["gasoline"].leader_intro_dialogue = "vfx_propane_exp_main";
  level.get_tier_reward_for_total_time["gasoline"].leaderboard_enabled = "vfx_propane_exp_air";
  level.get_tier_reward_for_total_time["gasoline"].playerzombieaddhudelem = "vfx_carriable_fuse";
  level.get_tier_reward_for_total_time["gasoline"].ref_13711 = "vfx_fire_spout";
  level.get_tier_reward_for_total_time["gasoline"].playerzombiecleanuppowers = "canister_warning";
  level.get_tier_reward_for_total_time["gasoline"].ref_1459B = getcompleteweaponname(level.get_tier_reward_for_total_time["gasoline"].weaponname);
  level.get_tier_reward_for_total_time["gasoline"].playerzombiebacktohuman = "ges_carriable_gasoline_ignite";
  level.get_tier_reward_for_total_time["gasoline"].playerzombiecleanup = "iw8_ges_plyr_carriable_gasoline_ignite";
  level.get_tier_reward_for_total_time["gasoline"].playerzombiecleanupkeybindings = "gasolineCanisterIgnite";
  level.get_tier_reward_for_total_time["gasoline"].playerzombieapplyemp = 1.23;
  level._effect["vfx_br3_rope_fire"] = loadfx("vfx/iw8_br/island/custom/vfx_br3_rope_fire.vfx");
  level._effect["vfx_propane_exp_main"] = loadfx("vfx/iw8_br/equipment/vfx_propane_exp_main");
  level._effect["vfx_propane_exp_air"] = loadfx("vfx/iw8_br/equipment/vfx_propane_exp_air");
  level._effect["vfx_carriable_fuse"] = loadfx("vfx/iw8_br/island/custom/vfx_br3_canister_fuse");
  level._effect["vfx_fire_spout"] = loadfx("vfx/iw8_br/equipment/vfx_fire_spout");
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["carriable_ascender_attach"] = $vm_eq_carriable_gasoline_ascender_attach_plr;
  level.scr_animname["player"]["carriable_ascender_attach"] = "vm_eq_carriable_gasoline_ascender_attach_plr";
  level.scr_eventanim["player"]["carriable_ascender_attach"] = "carriable_ascender_attach";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["carriable_ascender_device_attach"] = % wm_eq_carriable_gasoline_ascender_attach_ascender;
  level.scr_animname["device"]["carriable_ascender_device_attach"] = "wm_eq_carriable_gasoline_ascender_attach_ascender";
  level.scr_eventanim["device"]["carriable_ascender_device_attach"] = "carriable_ascender_device_attach";
  level.ref_1403D = [];
  level.get_target_spotted_alias = [];
  scripts\engine\scriptable::ref_12F5B("br_carriable_pickup", &ref_12F63);
  scripts\engine\scriptable::ref_12F5A(&ref_12F61);
  thread handle_tank_spawning();
}

function ref_13545(var_0, var_1, var_2) {
  if(isDefined(var_0)) {}

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  level.ref_1403D = scripts\engine\utility::array_removeundefined(level.ref_1403D);
  var_3 = getdvarint("scr_br_carriable_max_entity_cariables", 50);

  if(level.ref_1403D.size >= var_3) {
    var_4 = 999999999;
    var_5 = undefined;

    foreach(var_7 in level.ref_1403D) {
      if(istrue(var_7.playerzombiecleanuphud) || var_7 islinked()) {
        continue;
      }

      if(var_7.waittillmatchstarts < var_4) {
        var_4 = var_7.waittillmatchstarts;
        var_5 = var_7;
      }
    }

    if(isDefined(var_5)) {}

    var_5 delete();
  }

  var_9 = spawn("script_model", var_1);
  var_9 setModel(var_0.modelname);
  var_9.angles = var_2;
  var_9.get_teaminquiry_alias = var_0;
  get_station_index_in_active_stations(var_9, var_0);
  level.ref_1403D = scripts\engine\utility::array_add(level.ref_1403D, var_9);
  return var_9;
}

function handle_tank_spawning() {
  foreach(var_1 in level.ref_1403D) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1 islinked()) {
      get_subway_train_hit_damage_multiplier(var_1, 1);
    }

    var_1 delete();
  }

  level.ref_1403D = [];

  switch (getdvarint("scr_br_carriable_spawn_system", 0)) {
    case 0:
      ref_1351F();
      break;
    case 1:
      ref_1351C();
      break;
    case 2:
      ref_1351D();
      break;
    default:
      ref_1351F();
      break;
  }
}

function ref_1351F() {
  var_0 = getentitylessscriptablearrayinradius("scriptable_br_carriable_gasoline", "classname");
  var_1 = var_0;

  if(var_1.size == 0) {
    return;
  }

  var_2 = getdvarfloat("scr_br_carriable_spawn_chance", 0);
  var_3 = floor(var_2 * var_1.size);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_4 < var_3) {
      var_1[var_4] setscriptablepartstate("br_carriable_pickup", "visible");
      continue;
    }

    var_1[var_4] setscriptablepartstate("br_carriable_pickup", "hidden");
  }
}

function ref_1351D() {
  var_0 = getdvarfloat("scr_br_carriable_spawn_chance", 0);
  var_1 = scripts\engine\utility::array_randomize(getentitylessscriptablearrayinradius("scriptable_br_carriable_gasoline", "classname"));

  if(var_1.size > 0) {
    var_2 = floor(var_0 * var_1.size);

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_3 < var_2) {
        var_1[var_3] setscriptablepartstate("br_carriable_pickup", "visible");
        continue;
      }

      var_1[var_3] setscriptablepartstate("br_carriable_pickup", "hidden");
    }

    return;
  }
}

function ref_1351C() {
  var_0 = scripts\engine\utility::array_randomize(getentitylessscriptablearrayinradius("scriptable_br_carriable_gasoline", "classname"));

  if(var_0.size == 0) {
    return;
  }

  var_1 = [];
  GscBinSkip0(0x2e, "agricultural_center", (11086, -12336, 0));
}

function mortar_start() {
  self setscriptablepartstate("br_carriable_pickup", "visible");
}

function ref_12F63(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.gameended)) {
    return;
  }

  if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_3.inlaststand)) {
    return;
  }

  if(var_3 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(isDefined(level.showuseresultsfeedback)) {
      var_3[[level.showuseresultsfeedback]](17);
      return;
    }
  }

  if(!get_sight_dist_for_taccover_check(var_0, var_3)) {
    return;
  }

  if(var_2 == "visible") {
    var_5 = level.get_tier_reward_for_total_time["gasoline"];

    if(var_0.type == "br_carriable_propane") {
      var_5 = level.get_tier_reward_for_total_time["propane"];
    }

    if(var_0.type == "br_carriable_neurotoxin") {
      var_5 = level.get_tier_reward_for_total_time["neurotoxin"];
    }

    var_0 setscriptablepartstate("br_carriable_pickup", "hidden");
    level notify("carriable_kill_callout_" + var_0.origin);
    var_6 = ref_13545(var_5, var_3.origin);
    thread get_stay_at_station_time(var_6);
    thread ref_12C90(level, var_0);
    return;
  }
}

function tv_station_fastrope_two_infil_start_targetname_array_index(var_0) {
  return var_0.type == "br_carriable_gasoline" || var_0.type == "br_carriable_neurotoxin" || var_0.type == "br_carriable_propane";
}

function ref_12F61(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_2) || !tv_station_fastrope_two_infil_start_targetname_array_index(var_2)) {
    return;
  }

  thread ref_12F62(level, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function ref_12F62(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  waittillframeend();
  var_11 = level.get_tier_reward_for_total_time["gasoline"];

  if(var_2.type == "br_carriable_propane") {
    var_11 = level.get_tier_reward_for_total_time["propane"];
  }

  if(var_2.type == "br_carriable_neurotoxin") {
    var_11 = level.get_tier_reward_for_total_time["neurotoxin"];
  }

  level notify("carriable_kill_callout_" + var_2.origin);
  var_12 = ref_13545(var_11, var_2.origin, var_2.angles);
  var_12.owner = var_1;
  var_12.team = var_1.team;
  var_12 thread[[var_11.leader_charge_dialogue]]();
  var_12 makeunusable();
  var_12 hide();

  if(isDefined(level.ref_12074) && isPlayer(var_1) && istrue(var_1.should_take_damage) && isDefined(var_6)) {
    var_13 = 0;

    if(isDefined(var_1.showassassinationtargethud)) {
      var_14 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_6);

      if(scripts\engine\utility::array_contains_key(var_1.showassassinationtargethud, var_14)) {
        var_13 = 1;
      }
    }

    if(var_13) {
      var_12.updateteamplunderscore = 1;
      var_12 thread _luidecision::playericonfilter(var_1, var_12.origin, "nospawn", level.getserverroomspawnpoint.get_ai_within_range);
      thread ref_13580();
    }
  }

  wait 5;

  if(isDefined(var_12)) {
    var_12 delete();
    return;
  }
}

function ref_12C90(var_0, var_1) {
  var_2 = getdvarfloat("scr_br_carriable_respawn_time", 0);

  if(var_2 == 0) {
    return;
  }

  wait var_2;
  var_0 setscriptablepartstate("br_carriable_pickup", "visible");
}

function ref_13518(var_0) {
  var_1 = "gasoline";

  if(var_0.script_noteworthy == "carriable_propane") {
    var_1 = "propane";
  }

  if(var_0.script_noteworthy == "carriable_neurotoxin") {
    var_1 = "neurotoxin";
  }

  var_2 = level.get_tier_reward_for_total_time[var_1];
  var_3 = ref_13545(var_2, var_0.origin);
}

function get_station_index_in_active_stations(var_0) {
  self.start_origin = self.origin;
  self.get_teaminquiry_alias = var_0;

  if(!isDefined(self.script_health)) {
    self.script_health = 16;
  }

  self setHintString(self.get_teaminquiry_alias.spawn_guys_at_lz);
  self sethintdisplayfov(20);
  self setuseholdduration("duration_short");
  self sethintrequiresholding(0);
  self setusefov(20);
  self disablemissilestick();
  get_subway_car_available_to_deploy();
}

function get_subway_train_hit_damage() {
  self.origin = self.start_origin;
  self show();
  get_subway_car_available_to_deploy();
}

function get_subway_car_available_to_deploy() {
  self method_87cd(0);
  self physics_takecontrol(1);
  self physics_registerforcollisioncallback();
  thread get_tag_to_target();
  thread get_swivel_spawnpoint();
  self.waittillmatchstarts = gettime();
  self.team = undefined;

  if(!isDefined(self.playerzombiecleanuphud)) {
    self.playerzombiecleanuphud = 0;
  }

  if(!self.playerzombiecleanuphud) {
    self makeusable();
    thread get_stealth_alert_music_alias();
    thread get_starting_ai_per_site();
  }

  if(self.script_health > 0) {
    self setCanDamage(1);
    self.is_first_time_high_tier = 0;
    self.health = 99999999;
    thread get_sight_dist_for_vehicle_check();
    return;
  }
}

function get_sight_dist_for_vehicle_check() {
  self notify("carriable_damage_wait");
  self endon("death");
  self endon("explode");
  self endon("carriable_damage_wait");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.health = 99999999;

    if(var_0 < 14) {
      continue;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.vehicle)) {
      var_10 = var_1.owner.vehicle vehicle_getvelocity();
      var_11 = sqrt(vectordot(var_10, var_10));

      if(var_11 > 400) {
        self.owner = undefined;
        self.team = undefined;
        thread get_smoke_grenade_start_pos();
        return;
      }

      continue;
    }

    switch (var_4) {
      case "MOD_CRUSH":
      case "MOD_IMPACT":
      case "melee":
      case "MOD_MELEE":
        break;
      default:
        var_12 = isDefined(var_1) && scripts\mp\utility\damage::attackerishittingteam(self, var_1);

        if(!var_12) {
          if(isDefined(var_1)) {
            self.owner = var_1;
            self.team = var_1.team;
          }

          if(isDefined(level.ref_12074) && isPlayer(var_1) && istrue(var_1.should_take_damage) && isDefined(var_9)) {
            var_13 = 0;

            if(isDefined(var_1.showassassinationtargethud)) {
              var_14 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_9);

              if(scripts\engine\utility::array_contains_key(var_1.showassassinationtargethud, var_14)) {
                var_13 = 1;
              }
            }

            if(var_13) {
              self.updateteamplunderscore = 1;
              thread _luidecision::playericonfilter(var_1, self.origin, "nospawn", level.getserverroomspawnpoint.get_ai_within_range);
              thread ref_13580();
            }
          }

          thread get_smoke_grenade_start_pos();
          return;
        }

        break;
    }
  }
}

function ref_13580() {
  level endon("game_ended");
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("tag_origin");
  waitframe();
  var_0.ref_14293 = playFXOnTag(scripts\engine\utility::getfx("vfx_br3_canister_exp_large_chem"), var_0, "tag_origin");
  wait 8;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_br3_canister_exp_large_chem"), var_0, "tag_origin");
  var_0 delete();
}

function get_spaced_out_station_names_on_track(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 endon("death_or_disconnect");
    var_0 endon("drop_object");
  }

  self endon("death");
  self endon("explode");

  if(isDefined(var_1)) {
    wait var_1;
  }

  self.playerzombiecleanuphud = 1;
  self setscriptablepartstate("fuse", "fuse_sfx");
  playFXOnTag(level._effect[self.get_teaminquiry_alias.playerzombieaddhudelem], self, "tag_fx");

  if(isDefined(var_0) && isDefined(self.get_teaminquiry_alias.playerzombiecleanupkeybindings)) {
    var_0 setscriptablepartstate("weaponVFXViewmodel", self.get_teaminquiry_alias.playerzombiecleanupkeybindings, 0);
    var_0 setscriptablepartstate("weaponVFXWorldmodel", self.get_teaminquiry_alias.playerzombiecleanupkeybindings, 0);
    thread kill_lighter_fx();
    return;
  }
}

function kill_lighter_fx() {
  wait 2;

  if(isDefined(self)) {
    self setscriptablepartstate("weaponVFXViewmodel", "neutral", 0);
    self setscriptablepartstate("weaponVFXWorldmodel", "neutral", 0);
    return;
  }
}

function get_spotlight_goal_node(var_0, var_1) {
  self endon("death");
  self endon("explode");
  self endon("pickup");
  self endon("cancel_fuse");

  if(false) {
    thread get_start_ang(var_0);
  }

  if(!istrue(var_0.usingascender) && !istrue(var_0.ref_140AF)) {
    var_0 setclientomnvar("ui_br_gas_can_status", 2);
  }

  var_2 = getdvarfloat("carriableFuseTime", 5);

  if(istrue(var_1)) {
    var_2 += 2.1;
  }

  wait var_2;
  self.owner = var_0;
  self.team = var_0.team;
  thread get_smoke_grenade_start_pos();
}

function get_start_ang(var_0) {
  var_1 = var_0 scripts\mp\hud_util::createprimaryprogressbar();
  var_2 = var_0 scripts\mp\hud_util::createprimaryprogressbartext();
  var_2 settext("FUSE LIT");
  var_3 = getdvarfloat("carriableFuseTime", 5);

  if(var_3 <= 0) {
    var_3 = 1;
  }

  var_1 scripts\mp\hud_util::updatebar(0, 1 / var_3);
  var_0 scripts\engine\utility::ref_143A6("death", "weapon_fired", "drop_object");
  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

function get_spawncount_from_groupnames() {
  self endon("death");
  self endon("explode");

  if(istrue(self.playerzombiecleanuphud)) {
    waitframe();
    get_spaced_out_station_names_on_track(undefined, undefined);
    return;
  }
}

function get_stealth_breaking_guilty_player_name(var_0, var_1) {
  self endon("death_or_disconnect");
  var_2 = getcompleteweaponname(var_0);
  self giveandfireoffhand(var_2);
  scripts\common\utility::allow_fire(0, "carriableGesture");
  wait var_1;
  scripts\common\utility::allow_fire(1, "carriableGesture");

  if(self hasweapon(var_2)) {
    self takeweapon(var_2);
    return;
  }
}

function get_spawn_delay(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  var_1 = self getgestureanimlength(var_0.get_teaminquiry_alias.playerzombiebacktohuman);
  thread get_stealth_breaking_guilty_player_name(var_0.get_teaminquiry_alias.playerzombiecleanup, var_1);

  if(isDefined(var_0.get_teaminquiry_alias.playerzombieapplyemp)) {
    var_2 = var_0.get_teaminquiry_alias.playerzombieapplyemp;
  } else {
    var_2 = var_2;
  }

  thread get_spaced_out_station_names_on_track(var_1, self);
  wait 1.75;
}

function get_specific_truck(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  self endon("weapon_switch_started");
  self endon("carriable_ascend");

  for(;;) {
    self waittill("fuse_attempt_carriable");

    if(self getcurrentweapon() == var_0.get_teaminquiry_alias.ref_1459B && !self attackButtonPressed()) {
      self disableweaponswitch();
      self enableoffhandweapons();
      thread get_spotlight_goal_node(var_0, self);
      get_spawn_delay(var_0);
      self disableoffhandweapons();
      self enableweaponswitch();
      return;
    }
  }
}

function get_smoke_grenade_start_pos(var_0) {
  if(istrue(self.exploded)) {
    return;
  }

  self.exploded = 1;
  level endon("game_ended");
  self notify("explode");
  level notify("carriable_kill_callout_" + self.origin);

  if(istrue(self.playerzombiecleanuphud)) {
    stopFXOnTag(level._effect[self.get_teaminquiry_alias.playerzombieaddhudelem], self, "tag_fx");
  }

  if(isDefined(self.carrier)) {
    thread get_station_track_available_time_stamp((0, 0, -90), self.carrier);
    wait 0.1;
  }

  if(!istrue(self.updateteamplunderscore)) {
    self[[self.get_teaminquiry_alias.leader_charge_dialogue]](var_0);
  }

  self makeunusable();
  self hide();
  self.origin += (0, 0, 10000);
  wait 5;
  self delete();
}

function get_stealth_alert_music_alias() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0) && isalive(var_0) && get_sight_dist_for_taccover_check(var_0)) {
      thread get_stay_at_station_time(var_0);
      return;
    }
  }
}

function get_stay_at_station_time(var_0) {
  self notify("pickup");
  level notify("carriable_kill_callout_" + self.origin);
  var_1 = self getlinkedparent();

  if(isDefined(var_1)) {
    self unlink();
  }

  self physicslaunchserver(self.origin, (0, 0, 0));
  self physicsstopserver();
  self show();
  self hide();
  self linkTo(var_0, "tag_accessory_right", (0, 0, 0), (0, 0, 0));

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  self setotherent(var_0);
  self makeunusable();
  self.carrier = var_0;
  self.owner = var_0;
  self.team = var_0.team;
  var_0 scripts\mp\equipment::allow_equipment(0, "carriable");
  var_0.iscarrying = 1;
  var_0.ref_1286C = var_0 getcurrentweapon();
  var_0 giveweapon(self.get_teaminquiry_alias.ref_1459B);
  var_0 setweaponammoclip(self.get_teaminquiry_alias.ref_1459B, 1);
  var_0 switchtoweapon(self.get_teaminquiry_alias.ref_1459B);
  var_0 thread little_bird_mg_initfx();
  var_0 thread carriable_pickup_ladder_drop_check();
  var_0 scripts\engine\utility::ref_143A9("weapon_change", "weapon_taken", "weapon_switch_invalid", "death_or_disconnect", "on_ladder", "super_use_started");

  if(!isalive(var_0) || var_0 getcurrentweapon() != self.get_teaminquiry_alias.ref_1459B) {
    if(isDefined(var_0)) {
      var_0 enableoffhandweapons();
      var_0 scripts\mp\equipment::allow_equipment(1, "carriable");
      var_0.iscarrying = 0;
      var_0 takeweapon(self.get_teaminquiry_alias.ref_1459B);
      var_0.ref_1286C = undefined;
      var_0 notify("drop_object");
    }

    self.owner = undefined;
    self.carrier = undefined;
    self.team = undefined;
    self setotherent(undefined);
    self unlink();
    self show();
    var_2 = anglesToForward(self.angles) * 40;
    get_station_names_on_track(var_2);
    get_subway_car_available_to_deploy();
    return;
  }

  self method_87cd(1);
  self method_87c8(1);
  var_1.get_search_turret_target_player = self;

  if(!isai(var_1)) {
    var_1 notifyonplayercommand("lethal_attempt_carriable", "+frag");
    var_1 notifyonplayercommand("lethal_attempt_carriable", "+smoke");
    var_1 notifyonplayercommand("fuse_attempt_carriable", "+speed_throw");

    if(!var_1 isconsoleplayer()) {
      var_1 notifyonplayercommand("fuse_attempt_carriable", "+toggleads_throw");
    }
  }

  var_1 disableoffhandweapons();
  var_3 = var_1 scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_3)) {
    if(var_3.staticdata.ref != "super_deadsilence") {
      var_4 = var_3.staticdata.weapon;
      var_5 = var_1 getweaponammoclip(var_4);
      var_1 scripts\common\utility::allow_supers(0, "carriable");
      var_1 setweaponammoclip(var_4, var_5);
    }
  } else {
    var_1 scripts\common\utility::allow_supers(0, "carriable");
  }

  var_1 allowmelee(0);
  var_1 allowsupersprint(0);
  var_1 scripts\common\utility::allow_prone(0, "carriable");
  var_1.b_carriable_prone_disabled = 1;
  var_1 thread get_successful_vehicle_spawns_from_module(var_1);
  var_1 thread get_specific_truck(var_1);
  var_1 thread get_target_located(var_1, self);
  var_1 thread get_target_located(var_1, self);
  var_1 thread get_stealth_broken_music_alias(var_1);
  var_1 thread get_strafe_target_loc(var_1);
  var_1 thread get_smallest_cumulative_damage();
  var_1 setclientomnvar("ui_br_gas_can_status", 1);
}

function ref_140C1(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return false;
    }

    foreach(var_3 in level.get_tier_reward_for_total_time) {
      if(var_3.ref_1459B == var_0) {
        return false;
      }
    }

    var_1 = var_0.basename;
  }

  if(isstring(var_0)) {
    if(var_0 == "none") {
      return false;
    }

    foreach(var_3 in level.get_tier_reward_for_total_time) {
      if(var_3.ref_1459B.basename == var_0) {
        return false;
      }
    }

    var_1 = var_0;
  }

  if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_1)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0)) {
    return false;
  }

  return true;
}

function get_sight_dist_for_taccover_check(var_0) {
  if(!isPlayer(var_0)) {
    return false;
  }

  if(var_0 isonladder()) {
    return false;
  }

  if(!var_0 scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  if(var_0 scripts\mp\supers::issuperinuse()) {
    var_1 = var_0 scripts\mp\supers::getcurrentsuper();

    if(var_1.staticdata.ref != "super_deadsilence") {
      return false;
    }
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  if(istrue(var_0.isreviving)) {
    return false;
  }

  if(var_0 isskydiving()) {
    return false;
  }

  if(istrue(var_0.iszombie)) {
    return false;
  }

  if(istrue(var_0.isjuggernaut)) {
    if(isDefined(level.showuseresultsfeedback)) {
      var_0[[level.showuseresultsfeedback]](16);
      return false;
    }
  }

  if(isDefined(var_0.manuallyjoiningkillstreak) && var_0.manuallyjoiningkillstreak) {
    return false;
  }

  if(istrue(var_0.iscarrying)) {
    if(isDefined(level.showuseresultsfeedback)) {
      var_0[[level.showuseresultsfeedback]](3);
      return false;
    }
  }

  var_2 = var_0 getcurrentweapon();

  if(isDefined(var_2)) {
    if(!ref_140C1(var_2)) {
      var_0 scripts\mp\hud_message::showerrormessage("MP/FIELD_UPGRADE_CANNOT_USE");
      return false;
    }
  }

  var_3 = var_0.changingweapon;

  if(isDefined(var_3) && var_0 isswitchingweapon()) {
    if(!ref_140C1(var_3)) {
      return false;
    }
  }

  if(var_0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    var_3 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

    if(!ref_140C1(var_3)) {
      return false;
    }
  }

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    return false;
  }

  if(istrue(self.playerzombiecleanuphud)) {
    return false;
  }

  if(istrue(var_0.tracking_max_health)) {
    return false;
  }

  return true;
}

function get_successful_vehicle_spawns_from_module(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  var_1 = 0;
  var_2 = getdvarfloat("carriableThrowForce", 2250);

  for(;;) {
    self waittill("grenade_fire", var_3, var_4);

    if(var_4 != var_0.get_teaminquiry_alias.ref_1459B) {
      continue;
    }

    if(isDefined(var_3)) {
      laser_vfx_start_pos(var_3);
    }

    self setweaponammoclip(var_0.get_teaminquiry_alias.ref_1459B, 0);
    break;
  }

  if(self issprintsliding()) {
    var_1 = -12;
    var_2 += 200;
  }

  var_5 = self getplayerangles();
  var_5 += (var_1, 0, 0);
  var_5 = (clamp(var_5[0], -85, 85), var_5[1], var_5[2]);
  var_6 = anglesToForward(var_5);
  thread get_station_track_available_time_stamp(var_0, var_6 * var_2);
}

function laser_vfx_start_pos() {
  self endon("death");
  waitframe();
  self delete();
}

function little_bird_mg_initfx() {
  self endon("disconnect");
  self disableweaponswitch();
  scripts\engine\utility::ref_143A6("weapon_change", "death", "drop_object");

  if(istrue(self.usingascender) || istrue(self.ref_140AF)) {
    return;
  }

  self enableweaponswitch();
}

function carriable_pickup_ladder_drop_check() {
  for(var_0 = 0; var_0 < 20; var_0++) {
    if(self isonladder()) {
      self notify("on_ladder");
    }

    waitframe();
  }
}

function get_target_located(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  thread little_bird_mg_initfx();

  for(;;) {
    self waittill(var_1, var_2);

    if(istrue(self.usingascender)) {
      continue;
    }

    if(var_2 != var_0.get_teaminquiry_alias.ref_1459B) {
      wait 0.34;
      break;
    }
  }

  thread get_subway_train_hit_damage_multiplier(var_0, 0);
}

function get_smallest_cumulative_damage() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    self waittill("lethal_attempt_carriable");
    scripts\mp\hud_message::showerrormessage("MP/FIELD_UPGRADE_CANNOT_USE");
  }
}

function get_strafe_target_loc() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    if(self isskydiving()) {
      break;
    }

    if(scripts\mp\supers::issuperinuse()) {
      var_1 = scripts\mp\supers::getcurrentsuper();

      if(var_1.staticdata.ref != "super_deadsilence") {
        break;
      }
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      break;
    }

    if(self isinexecutionattack() || self isinexecutionvictim()) {
      break;
    }

    waitframe();
  }

  thread get_subway_train_hit_damage_multiplier( < error > );
}

function get_stealth_broken_music_alias(var_0) {
  level endon("game_ended");
  self endon("drop_object");
  self waittill("death_or_disconnect");
  var_1 = self getplayerangles();
  var_1 = (clamp(var_1[0], -85, 85), scripts\engine\utility::absangleclamp180(var_1[1]), 0);
  var_2 = anglesToForward(var_1);
  var_3 = 90;
  thread get_station_track_available_time_stamp(var_0, var_2 * var_3);
}

function get_station_names_on_track(var_0, var_1, var_2) {
  self.origin_prev = undefined;
  var_3 = self;

  if(isDefined(var_1) && !var_1 isonladder()) {
    self.origin = var_1 gettagorigin("j_gun");
    self.angles = var_1 gettagangles("j_gun");
  }

  self dontinterpolate();

  if(istrue(var_2)) {
    self physicslaunchserver(self.origin, var_0 * 1.2);
  } else {
    self physicslaunchserver(self.origin + 10 * anglestoup(self.angles), var_0);
  }

  function_0441(self.origin, self.origin + vectorNormalize(var_0) * 30, 1000);
  thread get_target_group();
}

function get_target_group() {
  self endon("death");
  self endon("pickup");
  self endon("explode");
  var_0 = self.origin;

  for(;;) {
    var_1 = self.origin - var_0;
    var_2 = lengthsquared(var_1);

    if(var_2 > 225) {
      var_1 = vectorNormalize(var_1) * (sqrt(var_2) + 6);
      function_0441(self.origin, self.origin + var_1, 1000);
    }

    var_0 = self.origin;
    waitframe();
  }
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function get_sight_dist_for_laststand_check(var_0) {
  if(isDefined(var_0.equipmentref) && var_0.equipmentref == "equip_tac_cover") {
    return false;
  }

  return true;
}

function get_sight_alias(var_0, var_1) {
  self endon("death");
  self endon("explode");
  self endon("pickup");
  self endon("collision");

  if(var_1 > 1 || var_0[2] < 0.5) {
    wait 2;
  } else {
    wait 0.5;
  }

  if(!self islinked()) {
    var_2 = scripts\engine\trace::ray_trace(self.origin, (self.origin[0], self.origin[1], self.origin[2] - 10), [self]);
    var_3 = var_2["entity"];

    if(isDefined(var_3) && var_3 != self && (nuke_vault_suicidebomber_internal(var_3) || var_3 method_87c7()) && get_sight_dist_for_laststand_check(var_3)) {
      self linkTo(var_3);
      self method_87c9(1);
      self method_87c8(1);
      return;
    }

    return;
  }
}

function get_tag_to_target() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(!self islinked()) {
      thread get_sight_alias(var_5, var_6);
    }
  }
}

function get_station_track_available_time_stamp(var_0, var_1) {
  self.moverdoesnotkill = 1;
  get_subway_train_hit_damage_multiplier(1);
  get_station_names_on_track(var_0, var_1, 1);
  get_subway_car_available_to_deploy();
}

function get_swivel_spawnpoint() {
  self endon("death");
  self endon("pickup");
  var_0 = [["bounce_large_sfx", 20], ["bounce_medium_sfx", 5], ["bounce_small_sfx", 1]];

  while(isDefined(self)) {
    self waittill("collision", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(self islinked()) {
      continue;
    }

    foreach(var_10 in var_0) {
      if(var_7 > var_10[1]) {
        if(self getscriptableparthasstate("sfx", var_10[0])) {
          self setscriptablepartstate("sfx", var_10[0]);
        }

        break;
      }
    }

    wait 0.125;
    self setscriptablepartstate("sfx", "disabled");
  }
}

function get_subway_train_hit_damage_multiplier(var_0, var_1) {
  var_2 = 40;
  var_3 = 11;
  var_4 = 7.1;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self.droptime = gettime();
  self notify("dropped");
  var_5 = (0, 0, 0);
  var_6 = self.carrier;

  if(isDefined(var_6) && var_6.team != "spectator") {
    var_7 = var_6.origin;
    var_5 = var_6.angles;
    var_6 notify("drop_object");
    var_6 setclientomnvar("ui_br_gas_can_status", 0);

    if(var_6 isonladder()) {
      var_7 += anglesToForward((0, var_5[1], 0)) * -5;
    }
  } else {
    var_7 = self.start_origin;
  }

  var_8 = (0, var_6[1], 0);
  var_9 = anglesToForward(var_8);
  var_7 += (0, 0, var_4) + var_5 * var_9;
  self.origin = var_7;
  self.angles = var_6;
  self show();
  var_10 = self getlinkedparent();

  if(isDefined(var_10)) {
    self unlink();
  }

  get_too_far_dist_sq(var_2);
  self dontinterpolate();
  self.ownerteam = "any";

  if(!var_1) {
    var_11 = var_9 * var_3;
    get_station_names_on_track(var_11, var_7);
    get_subway_car_available_to_deploy();
  }

  thread get_spawncount_from_groupnames();
  return true;
}

function get_too_far_dist_sq(var_0) {
  if(isDefined(self.carrier)) {
    self.carrier.iscarrying = undefined;
    self.carrier.get_search_turret_target_player = undefined;
    self setotherent(undefined);
    thread get_total_from_call_count(self.carrier);
    self.carrier scripts\mp\equipment::allow_equipment(1, "carriable");

    if(!isai(self.carrier)) {
      self.carrier notifyonplayercommandremove("lethal_attempt_carriable", "+frag");
      self.carrier notifyonplayercommandremove("lethal_attempt_carriable", "+smoke");
      self.carrier notifyonplayercommandremove("fuse_attempt_carriable", "+speed_throw");

      if(!self.carrier isconsoleplayer()) {
        self.carrier notifyonplayercommandremove("fuse_attempt_carriable", "+toggleads_throw");
      }
    }

    self.carrier enableoffhandweapons();

    if(self.carrier scripts\mp\supers::issuperinuse()) {
      var_1 = self.carrier scripts\mp\supers::getcurrentsuper();

      if(var_1.staticdata.ref != "super_deadsilence") {
        self.carrier scripts\common\utility::allow_supers(1, "carriable");
      }
    } else {
      self.carrier scripts\common\utility::allow_supers(1, "carriable");
    }

    self.carrier allowmelee(1);
    self.carrier allowsupersprint(1);

    if(istrue(self.carrier.b_carriable_prone_disabled)) {
      self.carrier scripts\common\utility::allow_prone(1, "carriable");
      self.carrier.b_carriable_prone_disabled = undefined;
    }

    self.carrier = undefined;
    return;
  }
}

function get_total_from_call_count(var_0) {
  self endon("death_or_disconnect");

  foreach(var_2 in level.get_tier_reward_for_total_time) {
    if(self getcurrentweapon() == var_2.ref_1459B) {
      if(self getweaponammoclip(var_2.ref_1459B) == 0) {
        wait 0.6;

        if(isDefined(self.ref_1286C)) {
          self switchtoweaponimmediate(self.ref_1286C);
        }
      } else {
        if(isDefined(var_0)) {
          wait var_0;
        }

        if(isDefined(self.ref_1286C) && !istrue(self.ref_140AF)) {
          self switchtoweaponimmediate(self.ref_1286C);
        }
      }

      self takeweapon(var_2.ref_1459B);
      break;
    }

    if(self hasweapon(var_2.ref_1459B)) {
      self takeweapon(var_2.ref_1459B);
      break;
    }
  }
}

function isbossheli(var_0, var_1) {
  if(!isDefined(level.ref_1403D)) {
    return;
  }

  var_2 = var_1 * var_1;

  foreach(var_4 in level.ref_1403D) {
    if(isDefined(var_4) && !istrue(var_4.b_fuse_cleanup) && !var_4 islinked() && distance2dsquared(var_4.origin, var_0) > var_2) {
      thread carriable_fuse_cleanup();
    }
  }
}

function carriable_fuse_cleanup() {
  self.b_fuse_cleanup = 1;
  self endon("death");
  self endon("explode");
  self endon("pickup");
  self endon("cancel_fuse");
  thread get_spaced_out_station_names_on_track();
  var_0 = getdvarfloat("carriableFuseTime", 5);
  wait var_0;
  thread get_smoke_grenade_start_pos();
}

function get_starting_ai_per_site() {
  self endon("death");
  self endon("explode");
  self endon("pickup");
  var_0 = getdvarfloat("scr_br_carriable_inactive_delete_time", 300);

  if(var_0 == 0) {
    return;
  }

  wait var_0;
  thread carriable_fuse_cleanup();
}

function get_silencedshot_alias(var_0) {
  var_1 = self.origin + (0, 0, -96);
  var_2 = physicstrace(self.origin, var_1);
  var_3 = var_2 == var_1;
  var_4 = "detonateGround";

  if(var_3) {
    var_4 = "detonateAir";
  }

  waitframe();
  var_5 = easepower("br_carriable_explosion_gasoline", var_2, (0, 0, 0));
  var_5 setscriptablepartstate("carrible_explode_base", var_4);
  thread hanging_crate_think(var_5);
  self radiusdamage(self.origin, level.get_station_controller_struct.plundertotal, level.get_station_controller_struct.plunderstructreplenish, level.get_station_controller_struct.plundertimer, self, "MOD_EXPLOSIVE", "gasoline_can_mp");
}

function get_silo_thrust_spawnpoint() {
  var_0 = 2;
  var_1 = self.origin + (0, 0, -96);
  var_2 = physicstrace(self.origin, var_1);
  var_3 = var_2 == var_1;
  var_4 = "detonateGround";

  if(var_3) {
    var_4 = "detonateAir";
  }

  var_5 = easepower("br_carriable_explosion_propane", self.origin, self.angles);
  var_5 setscriptablepartstate("carrible_explode_base", var_4);
  thread hanging_crate_think(var_5);
  var_6 = spawn("script_origin", self.origin);
  var_6.angles = self.angles;
  var_6.owner = self.owner;
  var_6.team = self.team;
  var_6.script_noteworthy = "fake_molotov";
  var_6.weapon_name = "gas_can_mp";

  if(isPlayer(self.owner)) {
    self radiusdamage(var_6.origin, 250, 400, 1, self.owner, "MOD_EXPLOSIVE", "c4_mp_p");
  } else {
    self radiusdamage(var_6.origin, 250, 400, 1, undefined, "MOD_EXPLOSIVE", "c4_mp_p");
  }

  var_7 = "gas_can_fire_spout";
  var_8 = 3;
  level.get_target_spotted_alias = scripts\engine\utility::array_removedead(level.get_target_spotted_alias);
  var_9 = 0;
  var_10 = relic_steelballs_slide(var_8);

  while(var_9 < var_8) {
    var_11 = magicgrenademanual(var_7, self.origin + var_10[var_9] * 0.02, var_10[var_9], 5);
    level.get_target_spotted_alias = scripts\engine\utility::array_add(level.get_target_spotted_alias, var_11);
    thread played_fulton_crate_anim(var_11);
    var_9++;
  }

  LOC_0000017b:
    if(var_2 != var_1) {
      var_6 scripts\mp\equipment\molotov::molotov_simulate_impact(var_6, var_2, (0, 0, 0), undefined, (0, 0, 0), gettime());
    }
  else if(level.get_target_spotted_alias.size < 12) {
    var_11 = magicgrenademanual(var_7, self.origin + (0, 0, -30), (0, 0, -200), 5);
    level.get_target_spotted_alias = scripts\engine\utility::array_add(level.get_target_spotted_alias, var_11);
    thread played_fulton_crate_anim(var_11);
  }

  thread hanging_crate_think(var_6);
}

function relic_steelballs_slide(var_0) {
  var_1 = [];

  if(var_0 <= 0) {
    return var_1;
  }

  var_2 = 360 / var_0;
  var_3 = randomfloatrange(-1 * var_2, var_2);

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = randomfloatrange(-0.5 * var_2, 0.5 * var_2);
    var_6 = var_4 * var_2 + var_5 + var_3;
    var_7 = vectorNormalize(rotatepointaroundvector((0, 0, 1), (0, 0.7, 0.7), var_6));
    var_8 = randomfloatrange(250, 400);
    var_1 = var_7 * var_8;
  }

  return var_1;
}

function played_fulton_crate_anim(var_0) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", var_1);
  var_0 scripts\mp\equipment\molotov::molotov_simulate_impact(var_0, self.origin, var_0.angles, undefined, (0, 0, 0), gettime());
  level.get_target_spotted_alias = scripts\engine\utility::array_remove(level.get_target_spotted_alias, self);
  self delete();
}

function hanging_crate_think(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  wait var_0;

  if(isDefined(self)) {
    if(isent(self)) {
      self delete();
      return;
    }

    self freescriptable();
    return;
  }
}

function lootleadermarkstrongsize(var_0, var_1, var_2) {
  if(scripts\cp_mp\gasmask::hasgasmask(var_0)) {
    thread ref_11E4E();

    if(isDefined(level.plunderrepositoryrestricted)) {
      var_0[[level.plunderrepositoryrestricted]]("carriable_neurotoxin");
    } else if(!istrue(var_0.gasmaskequipped)) {
      var_0 notify("toggle_gasmask");
    }

    var_0 scripts\cp_mp\gasmask::processdamage(var_2);
    return;
  }

  var_0 dodamage(var_2, var_0.origin, var_1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

  if(var_0 scripts\mp\gametypes\br_public::hasarmor()) {
    var_0 scripts\mp\gametypes\br_public::damagearmor(var_2);
  }

  var_0 scripts\mp\gametypes\br_circle::ref_13E18();
}

function ref_11E4E() {
  var_0 = self;
  var_1 = 1100;

  if(!isDefined(var_0.trackchallengetimers)) {
    var_0.trackchallengetimers = gettime();

    while(!istrue(var_0.gasmaskequipped) || gettime() < var_0.trackchallengetimers + var_1) {
      wait 0.5;
    }

    var_0.trackchallengetimers = undefined;

    if(isDefined(level.plunderrepositories)) {
      var_0[[level.plunderrepositories]]("carriable_neurotoxin");
      return;
    }

    if(istrue(var_0.gasmaskequipped)) {
      var_0 notify("toggle_gasmask");
    }

    return;
  }

  var_0.trackchallengetimers = gettime();
}

function get_surface_point(var_0) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");

  if(level.ascendstructs[var_0.target].dir == 0) {
    get_subway_train_hit_damage_multiplier(self.get_search_turret_target_player, 0);
    scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 1);
    return false;
  }

  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", self.origin, self.angles);
  self.player_rig hide();
  var_1 = spawnStruct();
  var_1.molotov_cleanup_pool = self.get_search_turret_target_player;
  var_1.player = self;
  var_1.tracknonoobplayerlocation = var_0;
  var_1.car_collision = level.ascendstructs[var_0.target];
  self.shouldskiplaststand = 1;
  var_1.car_collision.waittill_player_opens_tac_map = gettime();
  var_2 = scripts\engine\utility::drop_to_ground(var_1.car_collision.origin, 100, -250);
  var_1.canseedangercircleui = spawn("script_model", var_2);
  var_1.canseedangercircleui setModel("tag_origin");
  level.initpostmain++;

  if(self getstance() != "stand") {
    self setstance("stand");
  }

  scripts\common\utility::allow_execution_victim(0);
  scripts\common\utility::allow_usability(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_fire(0);

  if(istrue(self.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
      var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

      if(istrue(var_3)) {
        self disableweaponswitch();
      }
    }
  } else {
    scripts\common\utility::allow_killstreaks(0);
    self disableweaponswitch();
  }

  var_1.canseedangercircleui scripts\cp_mp\ent_manager::registerspawncount(2);
  var_1.car_collision.inuse = 1;
  self.usingascender = 1;
  var_4 = anglesToForward(var_1.car_collision.angles);
  var_5 = anglesToForward(self.angles);
  var_6 = vectordot(var_5, var_4);
  var_7 = 0;

  if(var_6 < 0.5) {
    var_8 = vectorcross(var_5, var_4);

    if(var_8[2] < 0) {
      var_7 = 120;
    } else {
      var_7 = 240;
    }
  }

  var_9 = (0, var_7, 0);
  var_1.canseedangercircleui dontinterpolate();
  var_1.canseedangercircleui.origin = var_2;
  var_1.canseedangercircleui.angles = var_1.car_collision.angles + var_9;
  var_1.cansnapcamera = spawn("script_model", var_1.car_collision.origin);
  var_1.cansnapcamera setModel("misc_wm_ascender_ch3");
  var_1.cansnapcamera hide();
  var_1.cansolospawn = spawn("script_model", var_1.car_collision.origin);
  var_1.cansolospawn setModel("misc_wm_ascender_ch3");
  var_1.cansolospawn hide();
  self setclientomnvar("ui_br_gas_can_status", 0);
  thread ref_1250B();
  thread get_target_retreat_struct();
  self notify("carriable_ascend");
  ref_123D4(var_1);
  var_1.ref_142D4 = var_1.player.player_rig gettagorigin("tag_weapon");
  thread cleanupascenduse();

  if(isDefined(var_1.molotov_cleanup_pool)) {
    thread get_shootable_scriptables();
  }

  return true;
}

function get_shootable_scriptables() {
  if(isDefined(self.player)) {
    self.cansolospawn showtoplayer(self.player);
  }

  carriable_physics_launch_drop();
  var_0 = distance(self.car_collision.ascendstructend.origin, self.car_collision.origin);
  var_1 = var_0 / 200;
  var_2 = scripts\cp_mp\auto_ascender::registered_checkpoint_funcs() * var_1;
  var_3 = scripts\cp_mp\auto_ascender::registereventcallback() * var_1;
  self.canseedangercircleui moveTo(self.car_collision.ascendstructend.origin, var_1, var_2, var_3);
  GscBinSkip4(0x35);
}

function get_showing_bomb_wire_pair_to_player() {
  playFX(scripts\engine\utility::getfx("vfx_br3_rope_fire"), self.canseedangercircleui.origin + (0, 0, 0), anglestoup(self.canseedangercircleui.angles), anglesToForward(self.canseedangercircleui.angles));
  wait 1;

  for(;;) {
    wait randomfloatrange(0.05, 1);

    if(isDefined(self) && isDefined(self.canseedangercircleui)) {
      playFX(scripts\engine\utility::getfx("vfx_br3_rope_fire"), self.canseedangercircleui.origin + (0, 0, randomfloatrange(-70, 0)), anglestoup(self.canseedangercircleui.angles), anglesToForward(self.canseedangercircleui.angles));
    }
  }
}

function carriable_physics_launch_drop() {
  self.molotov_crate_player_at_max_ammo = spawn("script_model", self.ref_142D4);
  self.molotov_crate_player_at_max_ammo.angles = (0, self.molotov_cleanup_pool.angles[1], 0);
  self.molotov_crate_player_at_max_ammo setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_crate_player_at_max_ammo setCanDamage(1);
  self.molotov_crate_player_at_max_ammo.health = 999999;
  self.molotov_crate_player_at_max_ammo.ownerteam = "any";
  self.molotov_crate_player_at_max_ammo.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_crate_player_at_max_ammo.owner = self.molotov_cleanup_pool.owner;
  self.molotov_crate_player_at_max_ammo.playerzombiecleanuphud = 1;
  thread get_sight_dist_for_vehicle_check();
  thread get_spawncount_from_groupnames();
  self.molotov_crate_player_at_max_ammo linkTo(self.canseedangercircleui);
  get_too_far_dist_sq(self.molotov_cleanup_pool);
  self.molotov_cleanup_pool delete();
  thread capsule_contents();
}

function ref_123D4() {
  self.player endon("death_or_disconnect");
  self.player endon("ascender_solo_cancel");
  self.player endon("last_stand_start");
  self.cansnapcamera.animname = "device";
  self.cansnapcamera scripts\common\anim::setanimtree();
  self.cansolospawn.animname = "device";
  self.cansolospawn scripts\common\anim::setanimtree();
  var_0 = rotatevector((-32.415, 0, 0), self.canseedangercircleui.angles);
  var_1 = 0.4;
  self.preascendplayerpos = self.player.origin;
  self.player.player_rig moveTo(scripts\engine\utility::drop_to_ground(self.canseedangercircleui.origin + var_0, 100, -250), var_1, 0.1, 0.1);
  var_2 = vectorNormalize(var_0 * -1);
  self.preascendplayerangles = self.player.angles;
  var_3 = scripts\cp_mp\auto_ascender::vectortoanglessafe(var_2, (0, 0, 1));
  self.player.player_rig rotateTo(var_3, var_1, 0.1, 0.1);

  if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud)) {
    self.molotov_cleanup_pool notify("cancel_fuse");
    wait var_1;
  } else {
    self.player enableoffhandweapons();
    get_spawn_delay(self.player, self.molotov_cleanup_pool);
    self.molotov_cleanup_pool.playerzombiecleanuphud = 1;
    self.player disableoffhandweapons();

    if(isDefined(self.molotov_cleanup_pool)) {
      thread get_spotlight_goal_node(self.molotov_cleanup_pool, self.player);

      if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
        if(self.car_collision.chopperexfil_sfx_before_sh070.health <= 0) {
          return 1;
        }
      } else if(isDefined(self.car_collision.type) && self.car_collision.type == "scriptable_skyhook_placed") {
        if(self.car_collision getscriptablepartstate("skyhook") == "broken") {
          return 1;
        }
      }
    }
  }

  if(!istrue(self.isjuggernaut)) {
    self.player disableoffhandweapons();
  }

  scripted_laser_func(self.player);
  self.cansolospawn show();
  self.cansolospawn hidefromplayer(self.player);
  self.cansnapcamera show();
  self.cansnapcamera showonlytoplayer(self.player);
  self.cansnapcamera linkTo(self.player.player_rig, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  self.cansolospawn linkTo(self.canseedangercircleui, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.player.player_rig linkTo(self.canseedangercircleui, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.player.player_rig showonlytoplayer(self.player);
  var_4 = self.player.player_rig gettagorigin("tag_weapon");
  var_5 = self.player.player_rig gettagangles("tag_weapon");
  self.molotov_clear_fx = spawn("script_model", var_4);
  self.molotov_clear_fx.angles = var_5;
  self.molotov_clear_fx setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_clear_fx showonlytoplayer(self.player);
  self.molotov_clear_fx.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_clear_fx.owner = self.molotov_cleanup_pool.owner;
  self.molotov_clear_fx.playerzombiecleanuphud = 1;
  self.molotov_clear_fx linkTo(self.player.player_rig, "tag_weapon");
  thread get_spawncount_from_groupnames();
  self.canseedangercircleui scripts\common\anim::anim_first_frame_solo(self.player.player_rig, "carriable_ascender_attach");
  self.canseedangercircleui thread scripts\mp\anim::anim_player_solo(self.player, self.player.player_rig, "carriable_ascender_attach");
  self.canseedangercircleui thread scripts\common\anim::anim_single_solo(self.cansolospawn, "carriable_ascender_device_attach");
  var_6 = getanimlength(level.scr_anim["player"]["carriable_ascender_attach"]);
  wait var_6;

  if(isDefined(self.molotov_cleanup_pool)) {
    if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
      if(self.car_collision.chopperexfil_sfx_before_sh070.health <= 0) {
        return;
      }
    } else if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
      if(self.car_collision.chopperexfil_sfx_before_sh070.health <= 0) {
        return;
      }
    } else if(isDefined(self.car_collision.type) && self.car_collision.type == "scriptable_skyhook_placed") {
      if(self.car_collision getscriptablepartstate("skyhook") == "broken") {
        return;
      }
    }
  }

  self.player takeweapon(self.player.currentweapon);
  self.player switchtoweaponimmediate(self.player.ref_1286C);
  self.player notify("ascend_solo_complete");
  self.player notify("drop_object");
}

function ref_1250B() {
  level endon("game_ended");
  self.player endon("ascend_complete");
  self.player endon("ascend_solo_complete");
  self.player endon("ascender_cancel");
  self.player scripts\engine\utility::ref_143A5("death_or_disconnect", "last_stand_start");

  if(isDefined(self.player)) {
    self.player stopanimscriptsceneevent();
  }

  thread cleanupascenduse();
  thread handleteamvisibility();

  if(isDefined(self.molotov_cleanup_pool)) {
    thread get_subway_train_hit_damage_multiplier(self.molotov_cleanup_pool);

    if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud)) {
      thread get_spotlight_goal_node(self.molotov_cleanup_pool);
    }
  }

  if(isDefined(self.player)) {
    self.player notify("ascender_cancel");
    return;
  }
}

function get_target_retreat_struct() {
  level endon("game_ended");
  self.player endon("ascend_complete");
  self.player endon("ascend_solo_complete");
  self.player endon("ascender_cancel");
  self.molotov_cleanup_pool waittill("explode");

  if(isDefined(self.player)) {
    self.player stopanimscriptsceneevent();
  }

  cleanupascenduse();
  handleteamvisibility();

  if(isDefined(self.player)) {
    self.player notify("ascender_cancel");
    return;
  }
}

function capsule_contents() {
  level endon("game_ended");
  self.molotov_crate_player_at_max_ammo waittill("explode");
  self.car_collision.inuse = 0;

  if(isDefined(self.car_collision.ref_134CB) && istrue(self.car_collision.ref_134CB.inuse)) {
    self.car_collision.ref_134CB.inuse = 0;
  }

  handleteamvisibility();
}

function cleanupascenduse() {
  self.car_collision.inuse = 0;

  if(isDefined(self.car_collision.ref_134CB) && istrue(self.car_collision.ref_134CB.inuse)) {
    self.car_collision.ref_134CB.inuse = 0;
  }

  if(isDefined(self.player) && istrue(self.player.usingascender)) {
    self.player.usingascender = 0;
    self.player.waittill_player_opens_scavenger_cache = gettime();
    self.player scripts\common\utility::allow_usability(1);
    self.player.shouldskiplaststand = undefined;
    self.player scripts\common\utility::allow_execution_victim(1);
    self.player scripts\common\utility::allow_melee(1);
    self.player scripts\common\utility::allow_ads(1);
    self.player scripts\common\utility::allow_fire(1);

    if(istrue(self.player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var_0 = self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(var_0)) {
          self.player enableweaponswitch();
        }
      }
    } else if(!istrue(self.player.inlaststand)) {
      self.player enableoffhandweapons();
      self.player enableweaponswitch();
      self.player scripts\common\utility::allow_killstreaks(1);
    } else {
      self.player thread scripts\cp_mp\auto_ascender::watch_for_ashes_achievement();
    }

    self.player.player_rig unlink();
    self.player.get_search_turret_target_player = undefined;
  }

  if(isDefined(self.cansnapcamera)) {
    self.cansnapcamera unlink();
    self.cansnapcamera delete();
    self.cansnapcamera = undefined;
  }

  if(isDefined(self.molotov_clear_fx)) {
    self.molotov_clear_fx delete();
    self.molotov_clear_fx = undefined;
  }

  wait 0.2;

  if(isDefined(self.player)) {
    var_1 = 0.4;
    self.player.player_rig moveTo(self.preascendplayerpos + (0, 0, 75), var_1, 0.1, 0.1);
    self.player.player_rig rotateTo(self.preascendplayerangles, var_1, 0.1, 0.1);
    wait var_1;

    if(!self.player hasweapon("iw8_gunless_infil")) {
      self.player.gunnlessweapon = undefined;
    }

    self.player thread scripts\mp\utility\infilexfil::takegunless();
    self.player notify("remove_rig");
    return;
  }
}

function handleteamvisibility() {
  if(isDefined(self.cansolospawn)) {
    self.cansolospawn unlink();
    self.cansolospawn delete();
  }

  if(isDefined(self.canseedangercircleui)) {
    self.canseedangercircleui scripts\cp_mp\ent_manager::deregisterspawn();
    self.canseedangercircleui delete();
    level.initpostmain--;
    return;
  }
}

function ref_119E2() {
  self.canseedangercircleui endon("death");
  self.canseedangercircleui endon("ascender_solo_loop_done");
  var_0 = "ascender_ext_up_loop";
  var_1 = getanimlength(level.scr_anim["player"][var_0]);

  for(;;) {
    if(!isDefined(self.canseedangercircleui)) {
      break;
    }

    self.canseedangercircleui scripts\common\anim::anim_single_solo(self.cansolospawn, var_0 + "_wm");

    if(!isDefined(var_1) || var_1 == 0) {
      break;
    }

    wait var_1;
  }
}

function scripted_laser_func() {
  self endon("death_or_disconnect");

  if(isDefined(self.gunnlessweapon)) {
    return;
  }

  var_0 = getcompleteweaponname("iw8_gunless_infil");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  if(!scripts\common\utility::is_script_weapon_switch_allowed()) {
    scripts\common\utility::allow_script_weapon_switch(1);
  }

  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    self clearhighpriorityweapon(scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon());
  }

  self switchtoweaponimmediate(var_0);
  self.gunnlessweapon = var_0;
  scripts\common\utility::allow_script_weapon_switch(0);
}

function carriable_useskyhook(var_0) {
  self endon("death_or_disconnect");
  self endon("ascender_solo_cancel");
  self endon("last_stand_start");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("player", self.origin, self.angles);
  self.player_rig hide();
  var_1 = spawnStruct();
  var_1.molotov_cleanup_pool = self.get_search_turret_target_player;
  var_1.player = self;
  var_1.tracknonoobplayerlocation = var_0;
  var_1.car_collision = var_0;
  self.shouldskiplaststand = 1;
  var_1.car_collision.waittill_player_opens_tac_map = gettime();
  var_2 = scripts\engine\utility::drop_to_ground(var_1.car_collision.origin, 100, -250);
  var_1.canseedangercircleui = spawn("script_model", var_2);
  var_1.canseedangercircleui setModel("tag_origin");
  level.initpostmain++;

  if(self getstance() != "stand") {
    self setstance("stand");
  }

  scripts\common\utility::allow_execution_victim(0);
  scripts\common\utility::allow_usability(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_fire(0);

  if(istrue(self.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
      var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

      if(istrue(var_3)) {
        self disableweaponswitch();
      }
    }
  } else {
    scripts\common\utility::allow_killstreaks(0);
    self disableweaponswitch();
  }

  var_1.canseedangercircleui scripts\cp_mp\ent_manager::registerspawncount(2);
  var_1.car_collision.inuse = 1;
  self.usingascender = 1;
  var_4 = anglesToForward(var_1.car_collision.angles);
  var_5 = anglesToForward(self.angles);
  var_6 = vectordot(var_5, var_4);
  var_7 = 0;

  if(var_6 < 0.5) {
    var_8 = vectorcross(var_5, var_4);

    if(var_8[2] < 0) {
      var_7 = 120;
    } else {
      var_7 = 240;
    }
  }

  var_9 = (0, var_7, 0);
  var_1.canseedangercircleui dontinterpolate();
  var_1.canseedangercircleui.origin = var_2;
  var_1.canseedangercircleui.angles = var_1.car_collision.angles + var_9;
  var_1.cansnapcamera = spawn("script_model", var_1.car_collision.origin);
  var_1.cansnapcamera setModel("misc_wm_ascender_ch3");
  var_1.cansnapcamera hide();
  var_1.cansolospawn = spawn("script_model", var_1.car_collision.origin);
  var_1.cansolospawn setModel("misc_wm_ascender_ch3");
  var_1.cansolospawn hide();
  self setclientomnvar("ui_br_gas_can_status", 0);
  thread playerascendskyhookplacedeathlistener();
  thread carriableascendskyhookplacedeathlistener();
  self notify("carriable_ascend");
  var_10 = anglesToForward(self getplayerangles());
  ref_123D4(var_1);
  var_1.ref_142D4 = var_1.player.player_rig gettagorigin("tag_weapon");
  thread cleanupascendskyhookuse();

  if(isDefined(var_1.molotov_cleanup_pool)) {
    if(isDefined(var_1.car_collision.chopperexfil_sfx_before_sh070)) {
      if(var_1.car_collision.chopperexfil_sfx_before_sh070.health <= 0) {
        return true;
      }
    } else if(isDefined(var_1.car_collision.chopperexfil_sfx_before_sh070)) {
      if(var_1.car_collision.chopperexfil_sfx_before_sh070.health <= 0) {
        return true;
      }
    } else if(var_1.car_collision getscriptablepartstate("skyhook") == "broken") {
      return true;
    }
  }

  thread carriable_ascend_skyhook(var_1);
  return true;
}

function carriable_ascend_skyhook(var_0) {
  if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
    self.car_collision.chopperexfil_sfx_before_sh070endon("death");
  } else {
    self.car_collision endon("balloon_destroyed");
  }

  thread balloon_death_watcher();

  if(isDefined(self.player)) {
    self.cansolospawn showtoplayer(self.player);
  }

  self.car_collision.inuse = 1;
  self.player.ref_140AF = 1;
  attach_carriable_to_ascender_skyhook();
  self.player.ref_140AF = undefined;
  var_1 = 2.33333;
  self.canseedangercircleui moveTo(self.car_collision.origin + (0, 0, 3500), var_1, 0.5, 0);
  thread fake_fuse_watcher();
  wait var_1;
  self.car_collision notify("balloon_destroyed_by_carriable");

  if(isDefined(self.molotov_crate_player_at_max_ammo)) {
    thread get_smoke_grenade_start_pos(self.molotov_crate_player_at_max_ammo);

    if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
      self.car_collision.chopperexfil_sfx_before_sh070 dodamage(999999, self.molotov_crate_player_at_max_ammo.origin);
    } else if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
      self.car_collision.chopperexfil_sfx_before_sh070dodamage(self.car_collision.chopperexfil_sfx_before_sh070.health + 1, self.molotov_crate_player_at_max_ammo.origin);
    } else {
      self.car_collision scripts\mp\gametypes\br_skyhook::balloon_placed_destroyed();
    }
  }

  handleteamvisibility();
}

function balloon_death_watcher() {
  self.car_collision endon("balloon_destroyed_by_carriable");

  if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
    self.car_collision.chopperexfil_sfx_before_sh070waittill("death");
  } else {
    self.car_collision waittill("balloon_destroyed");
  }

  self.molotov_crate_player_at_max_ammo setscriptablepartstate("fuse", "fuse_sfx");

  if(isDefined(self.molotov_crate_player_at_max_ammo)) {
    self.molotov_crate_player_at_max_ammo unlink();
    var_0 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
    var_1 = (randomfloatrange(-100, 100), randomfloatrange(-100, 100), randomfloatrange(-100, 100));
    self.molotov_crate_player_at_max_ammo physics_takecontrol(1, self.molotov_crate_player_at_max_ammo.origin + var_0, var_1);
    thread explode_fake_carriable_delayed();
  }

  handleteamvisibility();
}

function explode_fake_carriable_delayed() {
  self.molotov_crate_player_at_max_ammo thread fake_fuse_vfx_refresher();

  while(self.molotov_crate_player_at_max_ammo.f_fuse_timer > 0) {
    self.molotov_crate_player_at_max_ammo.f_fuse_timer -= 0.05;
    wait 0.05;
  }

  if(isDefined(self.molotov_crate_player_at_max_ammo)) {
    thread get_smoke_grenade_start_pos(self.molotov_crate_player_at_max_ammo);
    return;
  }
}

function fake_fuse_watcher() {
  if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
    self.car_collision.chopperexfil_sfx_before_sh070endon("death");
  } else {
    self.car_collision endon("balloon_destroyed");
  }

  self.molotov_crate_player_at_max_ammo.f_fuse_timer = 5;

  for(;;) {
    self.molotov_crate_player_at_max_ammo.f_fuse_timer -= 0.05;
    wait 0.05;
  }
}

function fake_fuse_vfx_refresher() {
  while(isDefined(self)) {
    playFXOnTag(level._effect["vfx_carriable_fuse"], self, "tag_fx");
    wait 1;
  }
}

function attach_carriable_to_ascender_skyhook() {
  self.molotov_crate_player_at_max_ammo = spawn("script_model", self.ref_142D4);
  self.molotov_crate_player_at_max_ammo.angles = (0, self.molotov_cleanup_pool.angles[1], 0);
  self.molotov_crate_player_at_max_ammo setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_crate_player_at_max_ammo setCanDamage(1);
  self.molotov_crate_player_at_max_ammo.health = 999999;
  self.molotov_crate_player_at_max_ammo.ownerteam = "any";
  self.molotov_crate_player_at_max_ammo.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_crate_player_at_max_ammo.owner = self.molotov_cleanup_pool.owner;
  self.molotov_crate_player_at_max_ammo.playerzombiecleanuphud = 1;
  thread get_sight_dist_for_vehicle_check();
  thread get_spawncount_from_groupnames();
  self.molotov_crate_player_at_max_ammo linkTo(self.canseedangercircleui);
  get_too_far_dist_sq(self.molotov_cleanup_pool);
  self.molotov_cleanup_pool delete();
  thread ascendingskyhookdeathlistener();
}

function play_carriable_ascender_skyhook_anim() {
  self.player endon("death_or_disconnect");
  self.player endon("ascender_solo_cancel");
  self.player endon("last_stand_start");
  self.cansnapcamera.animname = "device";
  self.cansnapcamera scripts\common\anim::setanimtree();
  self.cansolospawn.animname = "device";
  self.cansolospawn scripts\common\anim::setanimtree();
  var_0 = rotatevector((-32.415, 0, 0), self.canseedangercircleui.angles);
  var_1 = 0.4;
  self.player.player_rig moveTo(self.canseedangercircleui.origin + var_0, var_1, 0.1, 0.1);
  var_2 = vectorNormalize(var_0 * -1);
  var_3 = scripts\cp_mp\auto_ascender::vectortoanglessafe(var_2, (0, 0, 1));
  self.player.player_rig rotateTo(var_3, var_1, 0.1, 0.1);

  if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud)) {
    self.molotov_cleanup_pool endon("cancel_fuse");
    wait var_1;
  } else {
    get_spawn_delay(self.player, self.molotov_cleanup_pool);
    self.molotov_cleanup_pool.playerzombiecleanuphud = 1;
  }

  if(!istrue(self.isjuggernaut)) {
    self.player disableoffhandweapons();
  }

  scripted_laser_func(self.player);
  self.cansolospawn show();
  self.cansolospawn hidefromplayer(self.player);
  self.cansnapcamera show();
  self.cansnapcamera showonlytoplayer(self.player);
  self.cansnapcamera linkTo(self.player.player_rig, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  self.cansolospawn linkTo(self.canseedangercircleui, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.player.player_rig linkTo(self.canseedangercircleui, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.player.player_rig showonlytoplayer(self.player);
  var_4 = self.player.player_rig gettagorigin("tag_weapon");
  var_5 = self.player.player_rig gettagangles("tag_weapon");
  self.molotov_clear_fx = spawn("script_model", var_4);
  self.molotov_clear_fx.angles = var_5;
  self.molotov_clear_fx setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_clear_fx showonlytoplayer(self.player);
  self.molotov_clear_fx.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_clear_fx.owner = self.molotov_cleanup_pool.owner;
  self.molotov_clear_fx.playerzombiecleanuphud = 1;
  self.molotov_clear_fx linkTo(self.player.player_rig, "tag_weapon");
  thread get_spawncount_from_groupnames();
  self.canseedangercircleui scripts\common\anim::anim_first_frame_solo(self.player.player_rig, "carriable_ascender_attach");
  self.canseedangercircleui thread scripts\mp\anim::anim_player_solo(self.player, self.player.player_rig, "carriable_ascender_attach");
  self.canseedangercircleui thread scripts\common\anim::anim_single_solo(self.cansolospawn, "carriable_ascender_device_attach");
  var_6 = getanimlength(level.scr_anim["player"]["carriable_ascender_attach"]);
  wait var_6;
  self.player takeweapon(self.player.currentweapon);
  self.player switchtoweaponimmediate(self.player.ref_1286C);
  self.player notify("ascend_solo_complete");
  self.player notify("drop_object");
}

function playerascendskyhookplacedeathlistener() {
  level endon("game_ended");
  self.player endon("ascend_complete");
  self.player endon("ascend_solo_complete");
  self.player endon("ascender_cancel");
  self.player scripts\engine\utility::ref_143A5("death_or_disconnect", "last_stand_start");

  if(isDefined(self.player)) {
    self.player stopanimscriptsceneevent();
  }

  thread cleanupascenduse();
  thread handleteamvisibility();

  if(isDefined(self.molotov_cleanup_pool)) {
    thread get_subway_train_hit_damage_multiplier(self.molotov_cleanup_pool);

    if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud)) {
      thread get_spotlight_goal_node(self.molotov_cleanup_pool);
    }
  }

  if(isDefined(self.player)) {
    self.player notify("ascender_cancel");
    return;
  }
}

function carriableascendskyhookplacedeathlistener() {
  level endon("game_ended");
  self.player endon("ascend_complete");
  self.player endon("ascend_solo_complete");
  self.player endon("ascender_cancel");
  self.molotov_cleanup_pool waittill("explode");

  if(isDefined(self.player)) {
    self.player stopanimscriptsceneevent();
  }

  cleanupascenduse();
  handleteamvisibility();

  if(isDefined(self.player)) {
    self.player notify("ascender_cancel");
    return;
  }
}

function ascendingskyhookdeathlistener() {
  level endon("game_ended");
  self.molotov_crate_player_at_max_ammo waittill("explode");
  self.car_collision.inuse = 0;

  if(isDefined(self.car_collision.ref_134CB) && istrue(self.car_collision.ref_134CB.inuse)) {
    self.car_collision.ref_134CB.inuse = 0;
  }

  handleteamvisibility();
}

function cleanupascendskyhookuse() {
  self.car_collision.inuse = undefined;

  if(isDefined(self.player) && istrue(self.player.usingascender)) {
    self.player.usingascender = 0;
    self.player.waittill_player_opens_scavenger_cache = gettime();
    self.player scripts\common\utility::allow_usability(1);
    self.player.shouldskiplaststand = undefined;
    self.player scripts\common\utility::allow_execution_victim(1);
    self.player scripts\common\utility::allow_melee(1);
    self.player scripts\common\utility::allow_ads(1);
    self.player scripts\common\utility::allow_fire(1);

    if(istrue(self.player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var_0 = self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(var_0)) {
          self.player enableweaponswitch();
        }
      }
    } else if(!istrue(self.player.inlaststand)) {
      self.player enableoffhandweapons();
      self.player enableweaponswitch();
      self.player scripts\common\utility::allow_killstreaks(1);
    } else {
      self.player thread scripts\cp_mp\auto_ascender::watch_for_ashes_achievement();
    }

    self.player.player_rig unlink();
    self.player.get_search_turret_target_player = undefined;
  }

  if(isDefined(self.cansnapcamera)) {
    self.cansnapcamera unlink();
    self.cansnapcamera delete();
    self.cansnapcamera = undefined;
  }

  if(isDefined(self.molotov_clear_fx)) {
    self.molotov_clear_fx delete();
    self.molotov_clear_fx = undefined;
  }

  waitframe();

  if(isDefined(self.player)) {
    if(!self.player hasweapon("iw8_gunless_infil")) {
      self.player.gunnlessweapon = undefined;
    }

    self.player thread scripts\mp\utility\infilexfil::takegunless();
    self.player notify("remove_rig");
    return;
  }
}

function cleanupascenderskyhookdevicecarriable() {
  if(isDefined(self.canseedangercircleui)) {
    self.canseedangercircleui scripts\cp_mp\ent_manager::deregisterspawn();
    self.canseedangercircleui delete();
    level.initpostmain--;
    return;
  }
}