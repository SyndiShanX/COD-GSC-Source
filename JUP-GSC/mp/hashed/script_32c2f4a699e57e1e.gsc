/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_32c2f4a699e57e1e.gsc
*************************************************/

#using script_32c2f4a699e57e1e;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace namespace_8fc65ee803ed7309;

function function_a7874c90845471f3() {
  level._effect["vfx_arc_pickup"] = loadfx("vfx/jup/modes/vfx_arc_pickup");
  level._effect["vfx_arc_pickup_large"] = loadfx("vfx/jup/modes/vfx_arc_pickup_large");
  level._effect["vfx_arc_force_field_pickup"] = loadfx("vfx/jup/modes/vfx_arc_shield_orb_01_pickup");
  level._effect["arcade_force_field_on"] = loadfx("vfx/jup/modes/vfx_arc_shield_orb_01");
  level._effect["arcade_force_field_damaged"] = loadfx("vfx/jup/modes/vfx_arc_shield_orb_02");
  level._effect["arcade_force_field_break"] = loadfx("vfx/jup/modes/vfx_arc_shield_orb_break");
  level scripts\common\callbacks::add("player_death", &function_e85d7e674952bd0a);
  level scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  function_598e165aac396689();
  function_895e50f16e9a6d47();
  function_279d8fc211e373f5();
  level.var_2ceb2474be1c597e = &function_c2c75133895ae5b0;

  if(getdvarint(@ "hash_83c726316ff07864", 0) == 1) {
    level thread scripts\cp_mp\killstreaks\uav::function_6394127938ed8257(5);
  }

  scripts\cp_mp\utility\audio_utility::function_f1aed36ab4598ea("jup_mode_shared_vortex");
  thread function_dbe27ed7dba3f0bd();

  if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "limbo") {
    function_6fe662f22a144740();
    return;
  }

  function_f705d78f8780628d();
}

function function_9cc85147da15a703(params) {
  self waittill("loadout_class_selected");
  namespace_dfe80adf32f5c14a::onplayerspawned();
}

function function_f705d78f8780628d() {
  setomnvar("ui_arcade_unlimitedgrenade_timer_total", 20);
  setomnvar("ui_arcade_unlimitedammo_timer_total", 15);
  setomnvar("ui_arcade_aoe_timer_total", 40);
  setomnvar("ui_limbo_movement_mod_timer_total", getdvarint(@ "hash_560d21de3f7a5b9", 30));
}

function function_6fe662f22a144740() {
  setomnvar("ui_arcade_unlimitedgrenade_timer_total", 120);
  setomnvar("ui_arcade_unlimitedammo_timer_total", 120);
  setomnvar("ui_arcade_aoe_timer_total", 120);
  setomnvar("ui_limbo_movement_mod_timer_total", getdvarint(@ "hash_560d21de3f7a5b9", 120));
}

function onplayerspawned() {
  if(isDefined(self.var_808d06ddfc93a4e4) && self.var_808d06ddfc93a4e4) {
    thread scripts\mp\equipment\battlerage::function_739a5f064c7debdf();
  } else if(self getscriptablepartstate("battleRageVfx") == "vfx_start") {
    scripts\mp\equipment\battlerage::function_f009283993c81afd();
  }

  function_5ebff6f27060953c();
  function_c7b1bf955226c91a();
  self.num_powerup = 0;
  self.falldamageprotection = 1;
  thread function_9623701142aa39aa();
}

function function_9623701142aa39aa() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  dropping = 0;

  if(isagent(self) || isbot(self)) {
    return;
  }

  self notifyonplayercommand("vortexDrop", "+crouch");
  self notifyonplayercommand("vortexDrop", "+movedown");
  self notifyonplayercommand("vortexDrop", "+togglecrouch");
  self notifyonplayercommand("vortexDrop", "+stance");
  var_2d4845b74a252345 = gettime();

  while(true) {
    self waittill("vortexDrop");
    heightvector = (self.origin[0], self.origin[1], self.origin[2] - 50);
    var_4d5656223026940d = sighttracepassed(self.origin, heightvector, 0, self);

    if(!dropping && !self jumpbuttonPressed() && !self isonground() && var_4d5656223026940d) {
      dropping = 1;
      accelscalar = 1;
      var_2d4845b74a252345 = gettime();
    }

    while(dropping) {
      if(!self isonground() || gettime() >= var_2d4845b74a252345 + 750) {
        currentvel = self getvelocity();
        zvel = max(currentvel[2] - 50 * accelscalar, -1800);
        newvel = (currentvel[0] * 0.98, currentvel[1] * 0.98, zvel);
        self setvelocity(newvel);
        accelscalar += 0.1;
      } else {
        dropping = 0;
      }

      waitframe();
    }

    waitframe();
  }
}

function function_5ebff6f27060953c() {
  if(!scripts\mp\utility\perk::_hasperk("specialty_assault_gloves")) {
    scripts\mp\utility\perk::giveperk("specialty_assault_gloves");
  }
}

function function_4ab14e281240f204() {
  self.num_powerup = 0;
  self.arcade_unlimited_ammo = 0;
  self.var_640464235432d2b6 = 0;
  self.herodrop = 0;
  self.arcade_force_field = 0;
  self.limbo_movement_mod = 0;
}

function function_c7b1bf955226c91a() {
  self setclientomnvar("ui_arcade_unlimitedgrenade_active", 0);
  self setclientomnvar("ui_arcade_unlimitedammo_active", 0);
  self setclientomnvar("ui_arcade_forcefield_active", 0);
  self setclientomnvar("ui_arcade_aoe_active", 0);
  self setclientomnvar("ui_limbo_movement_mod_active", 0);
}

function function_e85d7e674952bd0a(params) {
  params.victim function_4ab14e281240f204();

  if(params.victim != params.attacker) {
    if(cointoss()) {
      function_c8806b1647107ca3(params, 1);
    }
  }
}

function function_6089f3a6495c3e4() {
  level waittill("prematch_started");

  if(isDefined(level.weaponmapdata)) {
    weaponlist = level.weaponmapdata;

    foreach(weapon in level.weaponmapdata) {
      if(issubstr(weapon.assetname, "none")) {
        continue;
      }

      if(issubstr(weapon.assetname, "compound")) {
        continue;
      }

      if(issubstr(weapon.assetname, "balpha27")) {
        continue;
      }

      if(issubstr(weapon.assetname, "kappa98")) {
        continue;
      }

      if(issubstr(weapon.assetname, "spapa12")) {
        continue;
      }

      if(issubstr(weapon.assetname, "me")) {
        continue;
      }

      if(issubstr(weapon.assetname, "la")) {
        continue;
      }

      if(issubstr(weapon.assetname, "goldengun")) {
        level.var_5c6958814641c15d[weapon.assetname] = weapon;
      }

      if(issubstr(weapon.assetname, "raygun")) {
        level.var_5c6958814641c15d[weapon.assetname] = weapon;
      }

      if(issubstr(weapon.assetname, "dg2")) {
        level.var_5c6958814641c15d[weapon.assetname] = weapon;
      }

      if(issubstr(weapon.assetname, "iw")) {}
    }

    return;
  }

  assertmsg("<dev string:x1c>");
}

function function_598e165aac396689() {
  level waittill("prematch_started");
  var_7d8bce723d98d32f = scripts\cp_mp\weapon::buildweapon("jup_jp35_sn_moscar", ["jup_moscar_rec", "jup_jp35_sn_moscar_stock", "jup_jp35_sn_moscar_pgrip", "jup_moscar_bipod", "jup_ammo_rail_std", "jup_moscar_scope", "jup_jp35_sn_moscar_bar_explode", "jup_jp35_sn_moscar_bolt_hvy"], "jup_camo_17c", "none");
  rocket_shotgun = scripts\cp_mp\weapon::buildweapon("jup_cp01_sh_aromeo410", ["jup_ammo_410g_vortex", "jup_cp01_sh_aromeo410_pgrip_tac", "jup_reflex04"], "jup_camo_17c", "none");
  mini_gun = makeweapon("iw9_lm_dblmg_jup_mp", ["ammo_762n_vortex"], undefined, "jup_camo_17c", 0);
  akimbo_shotgun = scripts\cp_mp\weapon::buildweapon("jup_jp14_pi_rsierra12", ["jup_ammo_127_db_arcade", "jup_rsierra12_akimbo", "jup_jp14_pi_rsierra12_bar_hvylong"], "jup_camo_17c", "none");
  sledgehammer = makeweapon("jup_jp23_me_shotel_arcade_mp", ["jup_me_shotel"], undefined, "jup_camo_17c", 0);
  weaponlist = [var_7d8bce723d98d32f, rocket_shotgun, mini_gun, akimbo_shotgun, sledgehammer];

  foreach(weapon in weaponlist) {
    level.var_5f07e2e462ad2fc[weapon.basename] = weapon;
  }
}

function function_6ff713622d20d1dc() {
  if(isDefined(level.var_5f07e2e462ad2fc)) {
    weaponlist = level.var_5f07e2e462ad2fc;
  } else {
    assertmsg("<dev string:x43>");
  }

  key = scripts\engine\utility::random_key(weaponlist);

  if(isDefined(weaponlist[key])) {
    return weaponlist[key];
  }

  return undefined;
}

function function_741a96af5c4dd6ba(loc) {
  if(isDefined(level.var_5f07e2e462ad2fc)) {
    weaponlist = level.var_5f07e2e462ad2fc;
  } else {
    assertmsg("<dev string:x43>");
  }

  switch (loc.weapon) {
    case #"hash_ecc52034dd6175e2":
      return weaponlist["jup_jp35_sn_moscar_mp"];
    case #"hash_bfabc434c59611fa":
      return weaponlist["iw9_lm_dblmg_jup_mp"];
    case #"hash_8b48887639da2db5":
      return weaponlist["jup_cp01_sh_aromeo410_mp"];
    case #"hash_9de6871a978222ba":
      return weaponlist["jup_jp23_me_pdango_arcade_mp"];
    case #"hash_3bacde76155f8ab9":
      return weaponlist["jup_jp14_pi_rsierra12_mp"];
    case #"hash_15a62d6ad8d539c9":
      return weaponlist["jup_jp23_me_shotel_arcade_mp"];
  }
}

function function_7debaa1f7e43dc98() {
  if(isDefined(level.var_5c6958814641c15d)) {
    weaponlist = level.var_5c6958814641c15d;
  } else if(isDefined(level.weaponmapdata)) {
    weaponlist = level.weaponmapdata;
  } else {
    weaponlist = level.weaponlistbundle;
  }

  if(isDefined(weaponlist) && weaponlist.size > 0) {
    newweapon = "";
    data = undefined;

    for(loopcount = 0; true; loopcount++) {
      weapon = random(weaponlist);

      if(isDefined(weapon.rootname)) {
        return weapon.rootname;
      }

      if(isDefined(weapon.assetname)) {
        return weapon.assetname;
      }

      if(!issubstr(weapon, "equip")) {
        rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
      } else {
        rootname = weapon;
      }

      if(loopcount > weaponlist.size) {
        level.selectedweapons[rootname] = 1;
        newweapon = weapon;

        for(i = 0; i < level.allweapons.size; i++) {
          if(level.allweapons[weapon] == newweapon) {
            break;
          }
        }

        break;
      }
    }

    return newweapon;
  }

  assertmsg("<dev string:x74>");
  return "none";
}

function function_be66b2f924406155(weapon, loc) {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");

  while(true) {
    waitframe();
    self waittill("trigger", player, droppeditem);

    if(isDefined(self.sfxloop)) {
      self.sfxloop stoploopsound();
    }

    player playsoundtoplayer("jup_arcade_weapon_pickup", player);
    player playsoundtoteam("jup_arcade_weapon_pickup_ally", player.team, player);
    player playsoundtoteam("jup_arcade_weapon_pickup_enemy", scripts\mp\utility\game::getotherteam(player.team)[0], player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }

    if(!scripts\mp\gameobjects::proxtriggerlos(player)) {
      continue;
    }

    player function_815824a2e8c69c86();
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon, undefined, undefined, 0);
    player scripts\cp_mp\utility\inventory_utility::_switchtoweapon(weapon);

    if(isDefined(loc)) {
      loc notify("start_weapon_respawn_timer");
      loc notify("hide_fx");
    }

    if(isDefined(self.sfxloop)) {
      self.sfxloop delete();
    }

    self makeunusable();
    self delete();
  }
}

function function_44533f21c13295c6(item) {
  level endon("game_ended");
  self endon("deleted");
  trigger = spawn("trigger_radius", self.origin, 0, 32, 32);
  trigger enablelinkTo();
  trigger linkTo(self);
  self.trigger = trigger;
  trigger endon("death");

  while(true) {
    trigger waittill("trigger", player);

    if(isDefined(self.sfxloop)) {
      self.sfxloop stoploopsound();
    }

    player playsoundtoplayer("jup_arcade_powerup_pickup", player);
    player playsoundtoteam("jup_arcade_powerup_pickup_ally", player.team, player);
    player playsoundtoteam("jup_arcade_powerup_pickup_enemy", scripts\mp\utility\game::getotherteam(player.team)[0], player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }

    player thread apply_powerup(item);

    if(isDefined(self.sfxloop)) {
      self.sfxloop delete();
    }

    self notify("delete_fx");
    self makeunusable();
    self delete();
    break;
  }
}

function function_f2ba3615b3d61f31(var_1fe32bf2f1360168) {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  start_time = gettime();
  current_time = 0;

  while(true) {
    waitframe();
    current_time = function_c89ed1840c8d0f0f(gettime() - start_time);

    if(current_time >= 10) {
      if(isDefined(self.sfxloop)) {
        self.sfxloop stoploopsound();
        self.sfxloop delete();
      }

      self makeunusable();
      self delete();
    }
  }
}

function function_815824a2e8c69c86() {
  objweapon = self getcurrentweapon();
  item = self dropitem(objweapon);

  if(!isDefined(item)) {
    return 0;
  }

  item sethintdisplayrange(96);
  item setuserange(96);
  item.owner = self;
  item.targetname = "dropped_weapon";
  item.objweapon = objweapon;
  item thread scripts\mp\weapons::watchpickup(self);
  item thread scripts\mp\weapons::deletepickupafterawhile();
}

function giveweapon_vortex(objweapon) {
  assert(isweapon(objweapon));
  var_aaa00e27a60773a1 = objweapon getnoaltweapon();
  currentweapon = self getcurrentweapon();
  currentweapons = self getweaponslistprimaries();

  if(self hasweapon(objweapon)) {
    ammoinclip = self getweaponammoclip(objweapon);

    if(ammoinclip > 0) {
      self dropitem(objweapon);
      inventory_utility::_giveweapon(var_aaa00e27a60773a1);
    } else if(!issubstr(currentweapon.basename, objweapon.basename)) {
      inventory_utility::_takeweapon(objweapon);
      inventory_utility::_giveweapon(var_aaa00e27a60773a1);
    }

    var_3bcedee676d43cf1 = self getweaponammoclip(currentweapon) == 0;
    var_8a1ef5886931af59 = issubstr(currentweapon.basename, "iw9_me_fists_mp");

    if(var_8a1ef5886931af59 || var_3bcedee676d43cf1) {
      inventory_utility::_switchtoweapon(var_aaa00e27a60773a1);
    }

    self setweaponammoclip(var_aaa00e27a60773a1, var_aaa00e27a60773a1.maxammo);
    return;
  }
}

function function_f67cc6b0134a0ce6(params, death_drop) {
  if(death_drop) {
    loc = params.victim;
  } else {
    loc = params.origin;
  }

  weaponoffset = (0, 0, 36);
  targetposworld = loc.origin + weaponoffset;
  var_485ed3db03228352 = (loc.angles[0], loc.angles[1], loc.angles[2]);
  var_a49f3378e7b03e7b = (0, -5, 0);
  var_51a87a65a1955ba9 = function_7debaa1f7e43dc98();

  if(isDefined(var_51a87a65a1955ba9)) {
    weapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(var_51a87a65a1955ba9);

    if(!isweapon(weapon)) {
      assertmsg("<dev string:x8b>");
      return;
    }
  } else {
    assertmsg("<dev string:xc8>");
    return;
  }

  weapon_pickup = function_c26e1057f3dfbc52(weapon, targetposworld, var_485ed3db03228352);
  var_ce61d73cfdee619d = weapon_pickup localtoworldcoords(var_a49f3378e7b03e7b);
  weapon_pickup.origin = var_ce61d73cfdee619d;
  var_5ce5bf640ea164d = (0, 0.5, 0);
  targetposworld = weapon_pickup localtoworldcoords(var_5ce5bf640ea164d);
  var_d993a04208646bdc = 0.2;
  weapon_pickup moveTo(targetposworld, var_d993a04208646bdc);
  weapon_pickup hudoutlineenable("outline_nodepth_green");
  weapon_pickup makeusable();
  weapon_pickup sethinttag("tag_origin");
  weapon_pickup setuseholdduration("duration_short");
  playsoundatpos(targetposworld, "jup_arcade_weapon_drop");
  weapon_pickup.sfxloop = spawn("script_model", targetposworld);
  weapon_pickup.sfxloop playLoopSound("jup_arcade_weapon_lp");
  weapon_pickup thread function_f2ba3615b3d61f31();
  weapon_pickup thread function_be66b2f924406155(weapon);
}

function function_3e1c8628245deac0(loc, var_7c4244375acf3b9c) {
  weaponoffset = (0, 0, 26);
  targetposworld = loc.origin + weaponoffset;
  var_485ed3db03228352 = loc.angles + (0, 0, 90);
  var_d993a04208646bdc = 0.2;
  weapon = function_741a96af5c4dd6ba(loc);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:xfa>");
    return;
  }

  if(weapon.basename == "jup_cp01_sh_aromeo410_mp" || weapon.basename == "jup_jp35_sn_moscar_mp") {
    var_485ed3db03228352 = (loc.angles[0], loc.angles[1], 0);
  }

  weapon_pickup = function_c26e1057f3dfbc52(weapon, targetposworld, var_485ed3db03228352);
  weapon_pickup moveTo(targetposworld, var_d993a04208646bdc);
  weapon_pickup makeusable();
  weapon_pickup sethinttag("tag_origin");
  weapon_pickup setuseholdduration("duration_short");
  weapon_pickup hudoutlineenable("outline_nodepth_green");
  weapon_pickup thread function_be66b2f924406155(weapon, loc);
  playsoundatpos(targetposworld, "jup_arcade_weapon_drop");

  if(!isDefined(loc.sfxloop)) {
    loc.sfxloop = spawn("script_model", targetposworld);
    loc.sfxloop playLoopSound("jup_arcade_weapon_lp");
  }

  if(var_7c4244375acf3b9c) {
    level.var_d0809b7599d6c0c3 = spawnfx(level._effect["vfx_arc_pickup"], loc.origin + (0, 0, 23));
    triggerfx(level.var_d0809b7599d6c0c3);
  }

  loc thread function_2644b5fbe745b794(loc);
  loc thread function_86f5a789d29a8a07(level._effect["vfx_arc_pickup_large"], "hide_fx");
}

function function_c8806b1647107ca3(params, death_drop) {
  if(death_drop) {
    loc = params.victim;
  } else {
    loc = params.origin;
  }

  if(level.gametype == "conf") {
    var_7cb9203b925ed49d = (0, 0, 6);
  } else {
    var_7cb9203b925ed49d = (0, 0, 26);
  }

  targetposworld = loc.origin + var_7cb9203b925ed49d;
  var_485ed3db03228352 = loc.angles;
  var_a49f3378e7b03e7b = (0, -5, 0);
  item = spawn("script_model", targetposworld);
  powerup_type = function_7ef0bb4ab06721b0();

  switch (powerup_type) {
    case #"hash_57ebf8ef67187ec7":
      item setModel("jup_accessory_arcade_pickups_ammo_02");
      break;
    case #"hash_ac736f279bf91dc5":
      item setModel("jup_accessory_arcade_pickups_grenades_02");
      break;
    case #"hash_2c9395bfba7d8880":
      item setModel("jup_accessory_arcade_pickups_shoes_02");
      break;
    case #"hash_d2503de74003e4a":
      item thread spawn_fx(getfx("vfx_arc_force_field_pickup"), "delete_fx");
      break;
    default:
      item setModel("military_dogtags_iw9_blue");
      break;
  }

  var_ce61d73cfdee619d = item localtoworldcoords(var_a49f3378e7b03e7b);
  item.origin = var_ce61d73cfdee619d;
  item.angles = var_485ed3db03228352;
  var_5ce5bf640ea164d = (0, 0.5, 0);
  targetposworld = item localtoworldcoords(var_5ce5bf640ea164d);
  var_d993a04208646bdc = 0.2;
  item moveTo(targetposworld, var_d993a04208646bdc);
  item makeusable();
  item hudoutlineenable("outline_nodepth_green");
  playsoundatpos(targetposworld, "jup_arcade_powerup_drop");
  item.sfxloop = spawn("script_model", targetposworld);
  item.sfxloop playLoopSound("jup_arcade_powerup_lp");
  item thread function_44533f21c13295c6(powerup_type);
}

function function_7ef0bb4ab06721b0() {
  powerup_list = ["unlimited_grenade", "unlimited_ammo", "aoe_drop_damage", "force_field_2"];
  key = scripts\engine\utility::random_key(powerup_list);

  if(isDefined(powerup_list[key])) {
    return powerup_list[key];
  }
}

function apply_powerup(powerup_type) {
  switch (powerup_type) {
    case #"hash_ac736f279bf91dc5":
      if(istrue(self.var_640464235432d2b6)) {
        function_fb2570ba1a04c8bb();
        break;
      } else {
        thread scripts\mp\hud_message::showsplash("arcade_unlimited_frag");
      }

      thread function_8148efb2a1061864();
      thread scripts\mp\utility\points::doscoreevent(#"hash_b87016086051cc4b");
      break;
    case #"hash_57ebf8ef67187ec7":
      if(istrue(self.arcade_unlimited_ammo)) {
        function_567a45cd61388c8d();
        break;
      } else {
        thread scripts\mp\hud_message::showsplash("arcade_unlimited_ammo");
      }

      thread function_abcfd180845925a8();
      thread scripts\mp\utility\points::doscoreevent(#"hash_af8957155e6b75a9");
      break;
    case #"hash_d2503de74003e4a":
      if(istrue(self.arcade_force_field)) {
        function_94b35d3e9aa2913e();
        break;
      } else {
        thread scripts\mp\hud_message::showsplash("arcade_force_field");
      }

      thread function_8054d43148c452e7();
      thread scripts\mp\utility\points::doscoreevent(#"hash_c544807020d8c68d");
      break;
    case #"hash_2c9395bfba7d8880":
      if(istrue(self.var_574a51d64266f7ef)) {
        function_4ce17ec115a8255a();
        break;
      } else {
        thread scripts\mp\hud_message::showsplash("arcade_aoe_drop_damage");
      }

      thread function_b32ac99fdccbb521();
      thread scripts\mp\utility\points::doscoreevent(#"hash_7100ba37fd40103a");
      break;
    case #"hash_3155348f209a4ee3":
      if(istrue(self.limbo_movement_mod)) {
        function_834394412daf5049();
        break;
      } else {
        thread scripts\mp\hud_message::showsplash("limbo_movement_mod");
      }

      thread function_d3cd68df003affbc();
      thread scripts\mp\utility\points::doscoreevent(#"hash_764b8d65d703e1ba");
      break;
    default:
      return;
  }
}

function powerup_timer(duration) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_med_box_effect_end", int(duration));
  waittill_any_timeout_2(duration, "death_or_disconnect");
  self setclientomnvar("ui_med_box_effect_end", 0);
}

function spawn_fx(fx, var_937555ef05034cb9) {
  self endon("deleted");
  temp = spawn_tag_origin();
  temp linkTo(self);
  fx = spawnfx(fx, temp.origin + (0, 0, 18));
  triggerfx(fx);
  self waittill(var_937555ef05034cb9);
  fx delete();
  temp delete();
}

function function_86f5a789d29a8a07(fx, var_937555ef05034cb9) {
  level endon("game_ended");
  self endon("deleted");
  spawned_fx = spawnfx(fx, self.origin + (0, 0, 23));

  while(true) {
    waitframe();
    triggerfx(spawned_fx);
    self waittill(var_937555ef05034cb9);
    spawned_fx hide();

    if(isDefined(self.sfxloop)) {
      self.sfxloop stoploopsound();
      self.sfxloop playLoopSound("jup_arcade_weapon_away_lp");
    }

    wait getdvarint(@ "hash_39748089d763d432", 45);

    if(isDefined(self.sfxloop)) {
      self.sfxloop stoploopsound();
      self.sfxloop playLoopSound("jup_arcade_weapon_lp");
    }
  }
}

function function_8148efb2a1061864() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(getdvarint(@ "hash_859d55e52e5fac05", 0) == 1) {
    return;
  }

  if(!isDefined(self.num_powerup)) {
    self.num_powerup = 0;
  }

  self.var_640464235432d2b6 = 1;
  self.num_powerup += 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  self setclientomnvar("ui_arcade_unlimitedgrenade_active", 1);
  replace_equip = undefined;

  if(!scripts\cp_mp\equipment::hasequipment("equip_frag")) {
    equipment_ref = scripts\cp_mp\equipment::getcurrentequipment("primary");
    start_ammo = scripts\cp_mp\equipment::getequipmentstartammo(equipment_ref);
    replace_equip = 1;
    scripts\cp_mp\equipment::giveequipment("equip_frag", "primary");
  }

  var_6925b4f069d7f95c = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "limbo" ? 120 : 20;
  self.var_552a2c635b9400e = gettime();
  self.var_5dd13a81fc4a3995 = 0;

  while(true) {
    wait 0.2;

    if(!scripts\cp_mp\equipment::hasequipment("equip_frag")) {
      equipment_ref = scripts\cp_mp\equipment::getcurrentequipment("primary");
      start_ammo = scripts\cp_mp\equipment::getequipmentstartammo(equipment_ref);
      replace_equip = 1;
      scripts\cp_mp\equipment::giveequipment("equip_frag", "primary");
    }

    self.var_5dd13a81fc4a3995 = function_c89ed1840c8d0f0f(gettime() - self.var_552a2c635b9400e);
    self setclientomnvar("ui_arcade_unlimitedgrenade_progress", self.var_5dd13a81fc4a3995);

    if(self.var_5dd13a81fc4a3995 >= var_6925b4f069d7f95c) {
      self playlocalsound("jup_arcade_powerup_expire");

      if(isDefined(replace_equip)) {
        scripts\cp_mp\equipment::giveequipment(equipment_ref, "primary");
        scripts\cp_mp\equipment::setequipmentammo(equipment_ref, start_ammo);
      }

      scripts\mp\equipment::decrementequipmentslotammo("primary");
      self.var_640464235432d2b6 = 0;
      self.num_powerup -= 1;
      self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
      self setclientomnvar("ui_arcade_unlimitedgrenade_active", 0);
      return;
    }

    scripts\mp\equipment::incrementequipmentslotammo("primary", 2);
  }
}

function function_fb2570ba1a04c8bb() {
  self.var_552a2c635b9400e = gettime();
  self.var_5dd13a81fc4a3995 = 0;
  self.var_5dd13a81fc4a3995 = function_c89ed1840c8d0f0f(gettime() - self.var_552a2c635b9400e);
  self setclientomnvar("ui_arcade_unlimitedgrenade_progress", self.var_5dd13a81fc4a3995);
}

function function_abcfd180845925a8() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(getdvarint(@ "hash_d1dda7a87c3c7b51", 0) == 1) {
    return;
  }

  weapons = self.equippedweapons;
  var_c27741a1537152da = 0;

  foreach(weap in weapons) {
    if(scripts\mp\utility\weapon::isgamemodeweapon(weap)) {
      var_c27741a1537152da = 1;
    }
  }

  if(var_c27741a1537152da) {
    foreach(weap in weapons) {
      if(!scripts\mp\utility\weapon::isgamemodeweapon(weap)) {
        self givestartammo(weap);
      }
    }

    return;
  }

  self.arcade_unlimited_ammo = 1;

  if(!isDefined(self.num_powerup)) {
    self.num_powerup = 0;
  }

  self.num_powerup += 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  self setclientomnvar("ui_arcade_unlimitedammo_active", 1);
  isakimbo = scripts\cp_mp\weapon::isakimbo(self.currentprimaryweapon);

  if(isakimbo) {
    thread scripts\mp\utility\weapon::function_1f1487da79807a91(0.2, 1, 1);
  } else {
    thread scripts\mp\utility\weapon::infiniteammothread(0.5, undefined, 1, 1);
  }

  var_bf4dcc703a8fef58 = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "limbo" ? 120 : 15;
  self.var_2bbcdde6a60e2104 = gettime();
  self.var_fc2f90eac16d656b = 0;

  while(true) {
    waitframe();
    self.var_fc2f90eac16d656b = function_c89ed1840c8d0f0f(gettime() - self.var_2bbcdde6a60e2104);
    self setclientomnvar("ui_arcade_unlimitedammo_progress", self.var_fc2f90eac16d656b);

    if(scripts\cp_mp\weapon::isakimbo(self.currentprimaryweapon) && !isakimbo) {
      scripts\mp\utility\weapon::stopinfiniteammothread();
      thread scripts\mp\utility\weapon::function_1f1487da79807a91(0.2, 1, 1);
      isakimbo = 1;
    } else if(isakimbo) {
      scripts\mp\utility\weapon::function_c513faaa06a681b1();
      thread scripts\mp\utility\weapon::infiniteammothread(0.5, undefined, 1, 1);
      isakimbo = 0;
    }

    if(self.var_fc2f90eac16d656b >= var_bf4dcc703a8fef58) {
      break;
    }
  }

  thread scripts\mp\utility\weapon::function_c513faaa06a681b1();
  thread scripts\mp\utility\weapon::stopinfiniteammothread();
  self playlocalsound("jup_arcade_powerup_expire");
  self.arcade_unlimited_ammo = 0;
  self.num_powerup -= 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  self setclientomnvar("ui_arcade_unlimitedammo_active", 0);
}

function function_567a45cd61388c8d() {
  self.var_2bbcdde6a60e2104 = gettime();
  self.var_fc2f90eac16d656b = 0;
  self.var_fc2f90eac16d656b = function_c89ed1840c8d0f0f(gettime() - self.var_2bbcdde6a60e2104);
  self setclientomnvar("ui_arcade_unlimitedammo_progress", self.var_fc2f90eac16d656b);
}

function function_d3cd68df003affbc() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(getdvarint(@ "hash_46780e6823572c2d", 0) == 1) {
    return;
  }

  self.limbo_movement_mod = 1;

  if(!isDefined(self.num_powerup)) {
    self.num_powerup = 0;
  }

  self.num_powerup += 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  self setclientomnvar("ui_limbo_movement_mod_active", 1);
  giveperk("specialty_purgatory_movement_adjustment");
  var_d261770d3fb18645 = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "limbo" ? 120 : 30;
  var_d261770d3fb18645 = getdvarint(@ "hash_560d21de3f7a5b9", var_d261770d3fb18645);
  self.var_7774bb485886c100 = gettime();
  self.var_563b3c04bc840057 = 0;

  while(true) {
    waitframe();
    self.var_563b3c04bc840057 = function_c89ed1840c8d0f0f(gettime() - self.var_7774bb485886c100);
    self setclientomnvar("ui_limbo_movement_mod_progress", self.var_563b3c04bc840057);

    if(self.var_563b3c04bc840057 >= var_d261770d3fb18645) {
      break;
    }
  }

  removeperk("specialty_purgatory_movement_adjustment");
  self playlocalsound("jup_arcade_powerup_expire");
  self.limbo_movement_mod = 0;
  self.num_powerup -= 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  self setclientomnvar("ui_limbo_movement_mod_active", 0);
}

function function_834394412daf5049() {
  self.var_7774bb485886c100 = gettime();
  self.var_563b3c04bc840057 = 0;
  self.var_563b3c04bc840057 = function_c89ed1840c8d0f0f(gettime() - self.var_7774bb485886c100);
  self setclientomnvar("ui_limbo_movement_mod_progress", self.var_563b3c04bc840057);
}

function function_c2c75133895ae5b0(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1) {
  if(istrue(victim.force_field)) {
    victim.var_63f51c740c492976 -= idamage;

    if(victim.var_63f51c740c492976 <= 150) {
      victim notify("force_field_damaged");
    }

    if(victim.var_63f51c740c492976 <= 0) {
      victim notify("force_field_break");
    }

    return true;
  }

  return false;
}

function function_8054d43148c452e7() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(getdvarint(@ "hash_fb37c5044f49385f", 0) == 1) {
    return;
  }

  if(!isDefined(self.num_powerup)) {
    self.num_powerup = 0;
  }

  self.arcade_force_field = 1;
  self.num_powerup += 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  callback::callback("force_field_deploy");
  self waittill("shield_deployed");
  self setclientomnvar("ui_arcade_forcefield_active", 1);
  self waittill("mutation_shield_broken");
  self.arcade_force_field = 0;
  self.num_powerup -= 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  self setclientomnvar("ui_arcade_forcefield_active", 0);
  self notify("mutation_shield_use_ended");
}

function function_94b35d3e9aa2913e() {
  if(!(isDefined(self.var_c0520e995eb8892b) && isDefined(self) && isDefined(self.var_c0520e995eb8892b.var_53c5195bccb1f90b))) {
    return;
  }

  var_4e32ba8da52b0408 = isDefined(self.var_c0520e995eb8892b.maxhealth) ? self.var_c0520e995eb8892b.maxhealth : 1600;
  self.var_c0520e995eb8892b.var_53c5195bccb1f90b.health = getdvarint(@ "hash_e414deda6e7cb6a4", var_4e32ba8da52b0408);
  self.var_c0520e995eb8892b.var_53c5195bccb1f90b setscriptablepartstate("shield_base", "shield_undamaged");

  if(isDefined(self.var_c0520e995eb8892b.var_53c5195bccb1f90b.health)) {
    self setclientomnvar("ui_arcade_forcefield_progress", self.var_c0520e995eb8892b.var_53c5195bccb1f90b.health);
  }
}

function function_b32ac99fdccbb521() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("aoe_drop_end");

  if(getdvarint(@ "hash_a608897998bad970", 0) == 1) {
    return;
  }

  if(!isDefined(self.num_powerup)) {
    self.num_powerup = 0;
  }

  self.var_574a51d64266f7ef = 1;
  self.num_powerup += 1;
  self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
  self setclientomnvar("ui_arcade_aoe_active", 1);
  self.herodrop = 0;
  thread function_82fdd0fd50b928ef();
  thread function_398c001c0b4dcb6b();

  while(true) {
    thread function_656db5d67b419da6();
    self waittill("perform_hero_drop");

    if(!istrue(self.herodrop)) {
      self.herodrop = 1;
      self radiusdamage(self.origin, getdvarint(@ "hash_ae406bf2f4aabf9", 200), getdvarint(@ "hash_661f8d7c55950697", 300), getdvarint(@ "hash_66437b7c55bd59b9", 200), self, "MOD_CRUSH");
      thread function_2958889bef16d9f9();
    }

    waitframe();
  }
}

function function_4ce17ec115a8255a() {
  self.var_6131b0c985626499 = gettime();
  self.var_dc054294da71c2ee = 0;
  self.var_dc054294da71c2ee = function_c89ed1840c8d0f0f(gettime() - self.var_6131b0c985626499);
  self setclientomnvar("ui_arcade_aoe_progress", self.var_dc054294da71c2ee);
}

function function_398c001c0b4dcb6b(var_1fe32bf2f1360168) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("aoe_drop_end");
  var_ad6132d0229b49d2 = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "limbo" ? 120 : 40;
  self.var_94ce998fe7616744 = 0;
  self.var_6131b0c985626499 = gettime();
  self.var_dc054294da71c2ee = 0;

  while(true) {
    waitframe();
    self.var_dc054294da71c2ee = function_c89ed1840c8d0f0f(gettime() - self.var_6131b0c985626499);
    self setclientomnvar("ui_arcade_aoe_progress", self.var_dc054294da71c2ee);

    if(self.var_dc054294da71c2ee >= var_ad6132d0229b49d2) {
      self.var_574a51d64266f7ef = 0;
      self.num_powerup -= 1;
      self setclientomnvar("ui_arcade_num_powerup", self.num_powerup);
      self setclientomnvar("ui_arcade_aoe_active", 0);
      self notify("aoe_drop_end");
      return;
    }
  }
}

function function_82fdd0fd50b928ef() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("aoe_drop_end");
  var_9bc2a942f1267afb = 0;

  while(true) {
    if(self function_c36cfe1c6acaef46() || self isjumping()) {
      if(!var_9bc2a942f1267afb) {
        var_9bc2a942f1267afb = 1;
      }

      if(self isonground() && var_9bc2a942f1267afb) {
        self notify("perform_hero_drop");
        var_9bc2a942f1267afb = 0;

        while(self function_c36cfe1c6acaef46() || self isjumping()) {
          wait 0.1;
        }
      }
    } else if(self isparachuting() || self isinfreefall()) {
      var_9bc2a942f1267afb = 0;
    } else if(var_9bc2a942f1267afb) {
      self notify("perform_hero_drop");
      var_9bc2a942f1267afb = 0;
    }

    waitframe();
  }
}

function function_2958889bef16d9f9() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("aoe_drop_end");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
  self.herodrop = 0;
}

function function_656db5d67b419da6() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("aoe_drop_end");
  self endon("perform_hero_drop");
  droploop = 0;
  var_87bd779b6eb7ebb5 = 0.5;
  delaycounter = var_87bd779b6eb7ebb5;
  var_29c3e7e659ebd38c = getdvarint(@ "bg_falldamageminheight");

  if(!isDefined(var_29c3e7e659ebd38c)) {
    var_29c3e7e659ebd38c = 225;
  }

  while(true) {
    if(function_6cb185c663af8b9b()) {
      delaycounter -= level.framedurationseconds;

      if(delaycounter <= 0) {
        delaycounter = 0;

        if(!istrue(droploop)) {
          var_c2d7296c1d69dc0f = scripts\engine\trace::ray_trace_passed(self.origin, self.origin - (0, 0, var_29c3e7e659ebd38c), self);

          if(istrue(var_c2d7296c1d69dc0f)) {
            droploop = 1;
            self setscriptablepartstate("heroDiveVfx", "falling", 0);
          }
        }
      }
    } else if(istrue(droploop) && !istrue(self.herodrop)) {
      droploop = 0;
      delaycounter = var_87bd779b6eb7ebb5;
      self setscriptablepartstate("heroDiveVfx", "off", 0);
    }

    waitframe();
  }
}

function function_6cb185c663af8b9b() {
  if(self ismantling()) {
    return false;
  }

  if(self isonladder()) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  if(!self isonground()) {
    if(self isparachuting()) {
      return false;
    }

    if(self isswimming()) {
      return false;
    }

    return true;
  }

  return false;
}

function function_eead174f423bccd() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("end_minigun_heal");
  self notify("force_regeneration");

  while(true) {
    self waittill("damage");
    wait 0.4;
    self notify("force_regeneration");
  }
}

function function_5fe942e59dd07717(eattacker, victim, objweapon, smeansofdeath, vpoint, idamage) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(eattacker)) {
    return;
  }

  if(!isDefined(victim)) {
    return;
  }

  if(!isDefined(objweapon)) {
    return;
  }

  if(!isDefined(smeansofdeath)) {
    return;
  }

  if(!isDefined(vpoint)) {
    return;
  }

  if(!isDefined(idamage)) {
    return;
  }

  if(idamage <= 10) {
    return;
  }

  if(!isDefined(self.var_61ae70864936719b)) {
    self.var_61ae70864936719b = gettime();
  } else if(gettime() - self.var_61ae70864936719b < 200) {
    return;
  }

  self.var_61ae70864936719b = gettime();
  damagedirection = self.origin - vpoint;
  var_b86cb86a5373dd82 = length(damagedirection);
  currentdirection = vectorNormalize(self getvelocity());
  var_e1db688daec5271b = vectorNormalize(damagedirection);
  var_e1db688daec5271b = (var_e1db688daec5271b[0], var_e1db688daec5271b[1], var_e1db688daec5271b[2] + 2);
  var_413aef656640a98c = currentdirection + var_e1db688daec5271b;
  magnitude = 250;

  if(!isenemyteam(self.team, eattacker.team)) {
    if(self == eattacker) {
      magnitude = 450;
    } else {
      return;
    }
  }

  if(smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
    if(var_b86cb86a5373dd82 >= 65) {
      magnitude -= var_b86cb86a5373dd82 * 2;
    }

    if(self isonground() == 0) {
      magnitude = clamp(magnitude, 80, 210);
    } else {
      magnitude = clamp(magnitude, 150, 370);
    }

    newvel = var_413aef656640a98c * magnitude;

    if(sighttracepassed(self getEye(), self getEye() + (0, 0, 20), 0, self)) {
      self setOrigin(self.origin + (0, 0, 20));
    }

    self setvelocity(newvel);
  }
}

function function_178a29a2b09ae82a(idamage, victim) {
  var_6f17073f208628d6 = int(max(idamage * 0.5, 4));

  if(!isreallyalive(victim)) {
    var_6f17073f208628d6 += 20;
  }

  self.health = int(min(self.maxhealth, self.health + var_6f17073f208628d6));
}

function function_a87a61b0dd6925c0(victim, attacker, vdir, magnitude) {
  level endon("game_ended");
  playFX(getfx("claymore_explode"), victim.origin);
  playsoundatpos(victim.origin, "jup_arcade_explosion_small_trans");
}

function function_2644b5fbe745b794(loc) {
  level endon("game_ended");
  self waittill("start_weapon_respawn_timer");
  wait getdvarint(@ "hash_39748089d763d432", 45);
  function_3e1c8628245deac0(loc, 0);
}

function function_279d8fc211e373f5() {
  wait 1;
  var_e5a665eed4c0e985 = 1;

  if(isDefined(level.var_10dad53daaf5e4e2)) {
    function_3e1c8628245deac0(level.var_10dad53daaf5e4e2, var_e5a665eed4c0e985);
  }

  if(isDefined(level.var_10dad43daaf5e2af)) {
    function_3e1c8628245deac0(level.var_10dad43daaf5e2af, var_e5a665eed4c0e985);
  }

  if(isDefined(level.var_10dad33daaf5e07c)) {
    function_3e1c8628245deac0(level.var_10dad33daaf5e07c, var_e5a665eed4c0e985);
  }

  if(isDefined(level.var_10dad23daaf5de49)) {
    function_3e1c8628245deac0(level.var_10dad23daaf5de49, var_e5a665eed4c0e985);
  }

  if(isDefined(level.var_10dad13daaf5dc16)) {
    function_3e1c8628245deac0(level.var_10dad13daaf5dc16, var_e5a665eed4c0e985);
  } else if(!isDefined(level.var_10dad53daaf5e4e2) && !isDefined(level.var_10dad43daaf5e2af) && !isDefined(level.var_10dad33daaf5e07c) && !isDefined(level.var_10dad23daaf5de49) && !isDefined(level.var_10dad13daaf5dc16)) {
    assertmsg("<dev string:x125>");
  }

  if(getdvarint(@ "hash_c467be0fbaae98a1", 0) != 0) {
    locs = getStructArray("weapon_pickup", "targetname");
    assertex(locs.size > 0, "<dev string:x171>");

    if(level.mapname == "mp_shoothouse2") {
      foreach(loc in locs) {
        if(is_equal(loc.script_label, "pball")) {
          function_3e1c8628245deac0(loc, var_e5a665eed4c0e985);
        }
      }

      return;
    }

    foreach(loc in locs) {
      if(loc.script_label == "1" || loc.script_label == "2" || loc.script_label == "3" || loc.script_label == "4" || loc.script_label == "5") {
        function_3e1c8628245deac0(loc, var_e5a665eed4c0e985);
      }
    }
  }
}

function function_8f9b90b445d7b2a9(location, location_type) {
  pickup = spawnStruct();
  pickup.origin = location;
  pickup.angles = (0, 0, 0);
  pickup.location_type = location_type;

  if(issubstr(location_type, "CQB")) {
    pickup.weapon = "sledgehammer";
  } else if(issubstr(location_type, "mosh")) {
    pickup.weapon = "mini";
  } else if(issubstr(location_type, "LLOS")) {
    pickup.weapon = "mors";
  } else if(issubstr(location_type, "MRC")) {
    pickup.weapon = "rocket";
  } else if(issubstr(location_type, "CRC")) {
    pickup.weapon = "akimbo_shotgun";
  }

  return pickup;
}

function function_895e50f16e9a6d47() {
  switch (level.mapname) {
    case #"hash_a5be4fb53ac34e83":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((1794, -16.5, 137.5), "LLOS");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((1930.5, 2609.5, 386), "LLOS");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((260.5, 1591, 178.5), "mosh");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((1997.5, 1271, 254.5), "MRC");
      break;
    case #"hash_81b84d832a53ee33":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-810.5, -540, 144), "CQB");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((-296.5, -278.5, 33.5), "mosh");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((579.5, -226, 7), "CRC");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((860, 773.5, 222.5), "MRC");
      break;
    case #"hash_e6a174b4b94d42d6":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((1074.5, 42, 199), "LLOS");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((-1148.5, 1013, 184.5), "MRC");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((-126.5, 1151, 149), "CRC");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((59.5, 282, 311), "mosh");
      break;
    case #"hash_2838565b98a82148":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((99.5, -23.5, 3034.5), "mosh");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((231.5, 546, 2776), "LLOS");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((38, -441.5, 2648), "CQB");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((-23, -842.5, 2974.5), "MRC");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((-246.5, 2046.5, 3414.5), "LLOS");
      break;
    case #"hash_9a4205d24fea1256":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-452.5, 91.5, 239.5), "LLOS");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((679, 195, 149), "CQB");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((119.5, 81, 33.5), "MRC");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((1154, 1013.5, 57.5), "CRC");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((-577, -1018, 226), "mosh");
      break;
    case #"hash_6efdf2384031a0e1":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-69, -1226.5, 201), "LLOS");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((-57.5, -124.5, 192), "mosh");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((276, 986, -47), "CRC");
      break;
    case #"hash_80b390c2840f0506":
    case #"hash_f5c1537d785c2cef":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-116.5, 727, -227.5), "mosh");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((898, 1192.5, -19), "MRC");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((1603, 1628, -158.5), "LLOS");
      break;
    case #"hash_b0aeb2ff7f22592":
    case #"hash_ad99098120fb98f2":
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((-1427, 2180, 6.5), "mosh");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((-726, 1682, 7), "LLOS");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((-793, 2357, 156), "CQB");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((-479, 1372, 114), "CRC");
      break;
    case #"hash_579f6b5a4a65f88":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((184, -601.5, 88), "MRC");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((-1002, -1183.5, 118.5), "mosh");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((1498.5, -605.5, -1), "CQB");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((-531.5, -146.5, 223), "LLOS");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((866.5, -1031.5, 272), "LLOS");
      break;
    case #"hash_6e4e36c6d34838da":
    case #"hash_a04339acb8b74a02":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-313.5, -1889, -6.5), "LLOS");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((-455.5, 846.5, 80), "CQB");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((-483.5, -642.5, 0), "MRC");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((-631.5, -949, 136), "mosh");
      break;
    case #"hash_3b9b3e57c88e6a79":
    case #"hash_ec6458d5e8ae9861":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((903.5, 1047, 279), "LLOS");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((244.5, 2246.5, 391), "mosh");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((1126, 217, 358), "MRC");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((-1145.5, 2707, 463.5), "CQB");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((-288.5, 1159.5, 334), "CRC");
      break;
    case #"hash_747a4e7f49a356a3":
    case #"hash_e8b15773cda6d9a8":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((703.5, 1058, 523.5), "MRC");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((1027, 762, 254), "mosh");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((647.5, 1028.5, 49.5), "CRC");
      break;
    case #"hash_1b3ccf154e387057":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((680, -1208, 0), "LLOS");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((680, -1308, 0), "CQB");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((680, -1408, 0), "MRC");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((680, -1508, 0), "CRC");
      level.var_10dad13daaf5dc16 = function_8f9b90b445d7b2a9((680, -1608, 0), "mosh");
      break;
    case #"hash_b6297edddd56f9ee":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-80.5, 73, 56), "CRC");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((215, -503, 136), "MRC");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((-15.5, 432.5, 56), "CQB");
      break;
    case #"hash_112c236a88ee77a3":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-80.5, 73, 56), "CRC");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((215, -503, 136), "mosh");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((-15.5, 432.5, 56), "CQB");
      break;
    case #"hash_93c9beb46291136b":
    case #"hash_f51375e2fabe967b":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((17.5, 297, 160), "mosh");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((3.5, -437.5, 160), "CRC");
      break;
    case #"hash_d06a9a7f14a4bde2":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-40.5, -890.5, 164), "LLOS");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((229.5, -396, 80.5), "CQB");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((256, 217.5, 80), "CRC");
      break;
    case #"hash_2487674f91147771":
    case #"hash_f5c583562ccacd09":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((2052, 4344.5, 306), "mosh");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((782, 4106.5, 184), "MRC");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((1247, 5360, 192), "CRC");
      level.var_10dad23daaf5de49 = function_8f9b90b445d7b2a9((2429, 5886, 193), "LLOS");
      break;
    case #"hash_7b1307337e588abe":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((-479, -229, -192), "CRC");
      break;
    case #"hash_a962d340d0d9951a":
      level.var_10dad53daaf5e4e2 = function_8f9b90b445d7b2a9((22, 386, 207), "mosh");
      level.var_10dad43daaf5e2af = function_8f9b90b445d7b2a9((-941, 375, 275), "CRC");
      level.var_10dad33daaf5e07c = function_8f9b90b445d7b2a9((636, 78, 301), "LLOS");
      break;
    default:
      assertmsg("<dev string:x1e2>");
      break;
  }
}

function function_dbe27ed7dba3f0bd() {
  level waittill("game_ended");
  wait 3;
  scripts\cp_mp\utility\audio_utility::function_f4e0ff5cb899686d("jup_mode_shared_vortex");
}