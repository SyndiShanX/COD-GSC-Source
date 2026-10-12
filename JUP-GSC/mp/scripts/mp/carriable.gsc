/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\carriable.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\molotov;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace carriable;

function initcarriables() {
  setdvarifuninitialized(@ "hash_29937c7775cf43e8", 0);
  setdvarifuninitialized(@ "hash_4e50a1220c7fd1b7", 300);
  setdvarifuninitialized(@ "scr_br_carriable_spawn_system", 0);
  setdvarifuninitialized(@ "hash_b52d6fd4249064e5", 50);
  setdvarifuninitialized(@ "scr_br_carriable_spawn_chance", 0);

  if(getdvarint(@ "hash_74cacae425805743", 0) > 0) {
    return;
  }

  precachestring(&"MP_BR_INGAME/PICKUP_PROPANE");
  precachestring(&"MP_BR_INGAME/PICKUP_POISON");
  setdvarifuninitialized(@ "hash_7bba431554c05335", 5);
  setdvarifuninitialized(@ "hash_30e08e7aa2432f46", 500);
  level.carriabletypes = [];
  level.carriabletypes["propane"] = spawnStruct();
  level.carriabletypes["propane"].weaponname = "gas_can_mp";
  level.carriabletypes["propane"].modelname = "offhand_wm_container_gas_tank_01";
  level.carriabletypes["propane"].hinttext = &"MP_BR_INGAME/PICKUP_PROPANE";
  level.carriabletypes["propane"].detonatefunc = &carriable_detonate_propane;
  level.carriabletypes["propane"].detonatesound = "gas_tank_explode";
  level.carriabletypes["propane"].detonatefx = "vfx_propane_exp_main";
  level.carriabletypes["propane"].detonatefxair = "vfx_propane_exp_air";
  level.carriabletypes["propane"].fusefx = "vfx_carriable_fuse";
  level.carriabletypes["propane"].spoutfx = "vfx_fire_spout";
  level.carriabletypes["propane"].fusesound = "canister_warning";
  level.carriabletypes["propane"].weaponref = makeweapon(level.carriabletypes["propane"].weaponname);
  level.carriabletypes["neurotoxin"] = spawnStruct();
  level.carriabletypes["neurotoxin"].weaponname = "gas_can_toxic_mp";
  level.carriabletypes["neurotoxin"].modelname = "offhand_wm_container_gas_tank_02";
  level.carriabletypes["neurotoxin"].hinttext = &"MP_BR_INGAME/PICKUP_POISON";
  level.carriabletypes["neurotoxin"].detonatefunc = &carriable_detonate_neurotoxin;
  level.carriabletypes["neurotoxin"].detonatesound = "neuro_tank_explode";
  level.carriabletypes["neurotoxin"].detonatefx = "vfx_ntoxin_exp_main";
  level.carriabletypes["neurotoxin"].detonatefxair = "vfx_ntoxin_exp_air";
  level.carriabletypes["neurotoxin"].gasfxground = "vfx_ntoxin_ground_gas";
  level.carriabletypes["neurotoxin"].gasfxair = "vfx_ntoxin_air_gas";
  level.carriabletypes["neurotoxin"].fusefx = "vfx_carriable_fuse";
  level.carriabletypes["neurotoxin"].fusesound = "canister_warning";
  level.carriabletypes["neurotoxin"].weaponref = makeweapon(level.carriabletypes["neurotoxin"].weaponname);
  level._effect["flash_bang_explode"] = loadfx("vfx/iw8_mp/equipment/flashbang/vfx_flash_bang");
  level._effect["vfx_propane_exp_main"] = loadfx("vfx/iw8_br/equipment/vfx_propane_exp_main");
  level._effect["vfx_propane_exp_air"] = loadfx("vfx/iw8_br/equipment/vfx_propane_exp_air");
  level._effect["fire_drip_test"] = loadfx("vfx/core/smktrail/smoke_geotrail_rpg");
  level._effect["vfx_carriable_fuse"] = loadfx("vfx/iw8_br/equipment/vfx_canister_fuse");
  level._effect["vfx_fire_spout"] = loadfx("vfx/iw8_br/equipment/vfx_fire_spout");
  level._effect["vfx_lighter_ignite"] = loadfx("vfx/iw8_br/equipment/vfx_lighter_ignite.vfx");
  level._effect["vfx_ntoxin_ground_gas"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_ground_gas");
  level._effect["vfx_ntoxin_air_gas"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_air_gas");
  level._effect["vfx_ntoxin_exp_main"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_exp_main");
  level._effect["vfx_ntoxin_exp_air"] = loadfx("vfx/iw8_br/equipment/vfx_ntoxin_exp_air");
  level.usablecarriables = [];
  level.carriablemagicgrenades = [];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_carriable_pickup", &scriptable_carriable_use);
  scripts\engine\scriptable::scriptable_adddamagedcallback(&scriptable_carriable_damage);
  clean_and_spawn_carriables();
  scripts\mp\gametypes\br_circle::registercirclecallbacks(9, &dangercircletick_carriable);
}

function spawn_entity_carriable(type, origin, angles) {
  if(!isDefined(type)) {
    assertmsg("<dev string:x1c>");
  }

  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  level.usablecarriables = array_removeundefined(level.usablecarriables);
  maxents = getdvarint(@ "hash_b52d6fd4249064e5", 50);

  if(level.usablecarriables.size >= maxents) {
    lastdropedtime = 999999999;
    var_722bda38c9c49989 = undefined;

    foreach(carriable in level.usablecarriables) {
      if(istrue(carriable.fuselit) || carriable islinked()) {
        continue;
      }

      if(carriable.lastdropedtime < lastdropedtime) {
        lastdropedtime = carriable.lastdropedtime;
        var_722bda38c9c49989 = carriable;
      }
    }

    if(!isDefined(var_722bda38c9c49989)) {
      assertmsg("<dev string:x60>");
    }

    var_722bda38c9c49989 delete();
  }

  var_4302fa9bcdb3790 = spawn("script_model", origin);
  var_4302fa9bcdb3790 setModel(type.modelname);
  var_4302fa9bcdb3790.angles = angles;
  var_4302fa9bcdb3790.carriabletype = type;
  var_4302fa9bcdb3790 carriable_init(type);
  level.usablecarriables = array_add(level.usablecarriables, var_4302fa9bcdb3790);
  return var_4302fa9bcdb3790;
}

function clean_and_spawn_carriables() {
  foreach(carriable in level.usablecarriables) {
    if(!isDefined(carriable)) {
      continue;
    }

    if(carriable islinked()) {
      carriable carriable_set_dropped(1);
    }

    carriable delete();
  }

  level.usablecarriables = [];

  switch (getdvarint(@ "scr_br_carriable_spawn_system", 0)) {
    case 0:
      spawn_carriables_from_scriptables_total_percentage();
      break;
    case 1:
      spawn_carriables_from_scriptables_individual_percentage();
      break;
    default:
      assertmsg("<dev string:xa8>");
      spawn_carriables_from_scriptables_total_percentage();
      break;
  }
}

function spawn_carriables_from_scriptables_total_percentage() {
  var_f6765e70dd9ad53f = getentitylessscriptablearray("scriptable_br_carriable_propane", "classname");
  var_187ccfe910b75663 = getentitylessscriptablearray("scriptable_br_carriable_neurotoxin", "classname");
  var_dc44d971ba523f8 = array_randomize(array_combine(var_f6765e70dd9ad53f, var_187ccfe910b75663));

  if(var_dc44d971ba523f8.size == 0) {
    return;
  }

  spawnchance = getdvarfloat(@ "scr_br_carriable_spawn_chance", 0);
  numenabled = floor(spawnchance * var_dc44d971ba523f8.size);

  for(i = 0; i < var_dc44d971ba523f8.size; i++) {
    if(i < numenabled) {
      var_dc44d971ba523f8[i] setscriptablepartstate("br_carriable_pickup", "useable");
      continue;
    }

    var_dc44d971ba523f8[i] setscriptablepartstate("br_carriable_pickup", "disabled");
  }
}

function spawn_carriables_from_scriptables_individual_percentage() {
  spawnchance = getdvarfloat(@ "scr_br_carriable_spawn_chance", 0);
  var_f6765e70dd9ad53f = array_randomize(getentitylessscriptablearray("scriptable_br_carriable_propane", "classname"));
  var_187ccfe910b75663 = array_randomize(getentitylessscriptablearray("scriptable_br_carriable_neurotoxin", "classname"));

  if(var_f6765e70dd9ad53f.size > 0) {
    numenabled = floor(spawnchance * var_f6765e70dd9ad53f.size);

    for(i = 0; i < var_f6765e70dd9ad53f.size; i++) {
      if(i < numenabled) {
        var_f6765e70dd9ad53f[i] setscriptablepartstate("br_carriable_pickup", "useable");
        continue;
      }

      var_f6765e70dd9ad53f[i] setscriptablepartstate("br_carriable_pickup", "disabled");
    }
  }

  if(var_187ccfe910b75663.size > 0) {
    numenabled = floor(spawnchance * var_187ccfe910b75663.size);

    for(i = 0; i < var_187ccfe910b75663.size; i++) {
      if(i < numenabled) {
        var_187ccfe910b75663[i] setscriptablepartstate("br_carriable_pickup", "useable");
        continue;
      }

      var_187ccfe910b75663[i] setscriptablepartstate("br_carriable_pickup", "disabled");
    }
  }
}

function scriptable_carriable_use(instance, part, state, player, bautouse, usestring) {
  assert(part == "<dev string:xd9>");

  if(istrue(level.gameended)) {
    return;
  }

  if(!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand)) {
    return;
  }

  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(isDefined(level.showuseresultsfeedback)) {
      player[[level.showuseresultsfeedback]](17);
      return;
    }
  }

  if(!instance carriable_can_pickup(player)) {
    return;
  }

  if(state == "useable") {
    type = level.carriabletypes["propane"];

    if(instance.classname == "scriptable_br_carriable_neurotoxin") {
      type = level.carriabletypes["neurotoxin"];
    }

    instance setscriptablepartstate("br_carriable_pickup", "disabled");
    level notify("carriable_kill_callout_" + instance.origin);
    var_4302fa9bcdb3790 = spawn_entity_carriable(type, player.origin);
    var_4302fa9bcdb3790 thread carriable_pickup(player);
    level thread respawn_scriptible_carriable_wait(instance, part);
  }
}

function iscarriablescriptable(instance) {
  return instance.type == "br_carriable_neurotoxin" || instance.type == "br_carriable_propane";
}

function scriptable_carriable_damage(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!isDefined(instance) || !iscarriablescriptable(instance)) {
    return;
  }

  level thread scriptable_carriable_damage_internal(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

function scriptable_carriable_damage_internal(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  waittillframeend();
  type = level.carriabletypes["propane"];

  if(instance.type == "br_carriable_neurotoxin") {
    type = level.carriabletypes["neurotoxin"];
  }

  level notify("carriable_kill_callout_" + instance.origin);
  var_60063a1bf733cfd5 = spawn_entity_carriable(type, instance.origin, instance.angles);
  var_60063a1bf733cfd5.owner = eattacker;
  var_60063a1bf733cfd5.team = eattacker.team;
  var_60063a1bf733cfd5 thread[[type.detonatefunc]]();
  var_60063a1bf733cfd5 makeunusable();
  var_60063a1bf733cfd5 hide();
  var_60063a1bf733cfd5.origin = instance.origin + (0, 0, 10000);
  wait 5;
  var_60063a1bf733cfd5 delete();
}

function respawn_scriptible_carriable_wait(instance, part) {
  respawntime = getdvarfloat(@ "hash_29937c7775cf43e8", 0);

  if(respawntime == 0) {
    return;
  }

  wait respawntime;
  instance setscriptablepartstate("br_carriable_pickup", "useable");
}

function spawn_carriable_at_struct(struct) {
  arg = "propane";

  if(struct.script_noteworthy == "carriable_neurotoxin") {
    arg = "neurotoxin";
  }

  type = level.carriabletypes[arg];
  var_4302fa9bcdb3790 = spawn_entity_carriable(type, struct.origin);
}

function function_a1a40eb763fdd549(arg) {
  if(!isDefined(level.usablecarriables)) {
    initcarriables();
  }

  type = level.carriabletypes[arg];

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isbot(player) || isai(player) || player isplayerheadless()) {
      continue;
    }

    var_4302fa9bcdb3790 = spawn_entity_carriable(type, player.origin + (0, 0, 10));
  }
}

function function_a6ec7bb20c89f0e8() {
  if(!isDefined(level.usablecarriables)) {
    initcarriables();
    return;
  }

  clean_and_spawn_carriables();
}

function carriable_init(carriabletype) {
  self.start_origin = self.origin;
  self.carriabletype = carriabletype;

  if(!isDefined(self.script_health)) {
    self.script_health = 16;
  }

  self setnonstick(1);
  carriable_ready();
  self setHintString(self.carriabletype.hinttext);
  self setuseholdduration("duration_short");
  self sethintrequiresholding(1);
}

function carriable_respawn() {
  self.origin = self.start_origin;
  self show();
  carriable_ready();
}

function carriable_ready() {
  self physics_takecontrol(1);
  self physics_registerforcollisioncallback();
  thread carriable_watch_for_physics_collison();
  self.lastdropedtime = gettime();

  if(!isDefined(self.fuselit)) {
    self.fuselit = 0;
  }

  if(!self.fuselit) {
    self makeusable();
    thread carriable_pickup_wait();
    thread carriable_inactive_delete_wait();
  }

  if(self.script_health > 0) {
    self setCanDamage(1);
    self.damage_taken = 0;
    self.health = 99999999;
    thread carriable_damage_wait();
  }
}

function carriable_damage_wait() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  while(true) {
    self waittill("damage", idamage, eattacker, vhitdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon);
    self.health = 99999999;

    if(idamage < 2) {
      thread carriable_lightfuse(eattacker);
      continue;
    }

    switch (smeansofdeath) {
      case #"hash_40a94c5d9e4e265b":
      case #"hash_a5123f4d02745600":
      case #"hash_abb1587cdc6def23":
      case #"hash_b1078ff213fddba6":
        continue;
      default:
        self.owner = eattacker;
        self.team = eattacker.team;
        thread carriable_explode();
        return;
    }
  }
}

function carriable_lightfuse(player) {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  if(istrue(self.fuselit)) {
    return;
  }

  if(false) {
    thread carriable_fuse_ui(player);
  }

  player setclientomnvar("ui_gas_can_status", 2);
  self.fuselit = 1;
  self playsoundonmovingent(self.carriabletype.fusesound);
  playFXOnTag(level._effect[self.carriabletype.fusefx], self, "tag_fx");
  fuse = getdvarfloat(@ "hash_7bba431554c05335", 5);
  wait fuse;
  self.owner = player;
  self.team = player.team;
  thread carriable_explode();
}

function carriable_fuse_ui(player) {
  usebar = player createprimaryprogressbar();
  usebartext = player createprimaryprogressbartext();
  usebartext settext("FUSE LIT");
  fuse = getdvarfloat(@ "hash_7bba431554c05335", 5);

  if(fuse <= 0) {
    fuse = 1;
  }

  usebar updatebar(0, 1 / fuse);
  player waittill_any_3("death", "weapon_fired", "drop_object");
  usebar destroyelem();
  usebartext destroyelem();
}

function carriable_explode() {
  level endon("game_ended");
  self endon("death");
  self notify("explode");
  level notify("carriable_kill_callout_" + self.origin);

  if(istrue(self.fuselit)) {
    stopFXOnTag(level._effect[self.carriabletype.fusefx], self, "tag_fx");
  }

  if(self islinked()) {
    thread carriable_physics_launch_drop((0, 0, -90), self.owner);
    wait 0.1;
  }

  self[[self.carriabletype.detonatefunc]]();
  self makeunusable();
  self hide();
  self.origin += (0, 0, 10000);
  wait 5;
  self delete();
}

function carriable_pickup_wait() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  while(true) {
    self waittill("trigger", player);

    if(isDefined(player) && isalive(player) && carriable_can_pickup(player)) {
      thread carriable_pickup(player);
      return;
    }
  }
}

function carriable_pickup(player) {
  self notify("pickup");
  level notify("carriable_kill_callout_" + self.origin);
  linkedparent = self getlinkedparent();

  if(isDefined(linkedparent)) {
    self unlink();
  }

  player val::set("carriable", "equipment_primary", 0);
  player val::set("carriable", "equipment_secondary", 0);
  self physicslaunchserver(self.origin, (0, 0, 0));
  self physicsstopserver();
  self show();
  self hide(1);
  self linkTo(player, "tag_accessory_right", (0, 0, 0), player.angles);

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  self setCanDamage(0);
  self setotherent(player);
  self makeunusable();
  self.carrier = player;
  self.owner = player;
  player.iscarrying = 1;
  player.prepickupweapon = player getcurrentweapon();
  player giveweapon(self.carriabletype.weaponref);
  player setweaponammoclip(self.carriabletype.weaponref, 1);
  player switchtoweapon(self.carriabletype.weaponref);
  player thread carriable_throw_watch(self);
  player thread carriable_fuse_light_watch(self);
  player thread carriable_weapon_change_watch(self);
  player thread carriable_player_death_watch(self);
  player thread carriable_player_state_drop_watch(self);
  player thread carriable_error_messsage_watch();

  if(!isai(player)) {
    player notifyonplayercommand("lethal_attempt_carriable", "+frag");
    player notifyonplayercommand("lethal_attempt_carriable", "+smoke");
    player notifyonplayercommand("fuse_attempt_carriable", "+speed_throw");

    if(!player isconsoleplayer()) {
      player notifyonplayercommand("fuse_attempt_carriable", "+toggleads_throw");
    }
  }

  player val::set("carriable", "supers", 0);
  player allowmelee(0);
  player allowsupersprint(0);
  player setclientomnvar("ui_gas_can_status", 1);
}

function valid_carriable_pickup_weapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon)) {
      return false;
    }

    foreach(carriabletype in level.carriabletypes) {
      if(carriabletype.weaponref == weapon) {
        return false;
      }
    }

    weaponname = weapon.basename;
  }

  if(isstring(weapon)) {
    if(weapon == "none") {
      return false;
    }

    foreach(carriabletype in level.carriabletypes) {
      if(carriabletype.weaponref.basename == weapon) {
        return false;
      }
    }

    weaponname = weapon;
  }

  if(scripts\mp\utility\killstreak::isremotekillstreakweapon(weaponname)) {
    return false;
  }

  if(iskillstreakweapon(weapon)) {
    return false;
  }

  return true;
}

function carriable_can_pickup(player) {
  if(!isPlayer(player)) {
    return false;
  }

  if(!player val::get("weapon")) {
    return false;
  }

  if(player scripts\mp\supers::issuperinuse()) {
    return false;
  }

  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(istrue(player.inlaststand)) {
    return false;
  }

  if(istrue(player.isreviving)) {
    return false;
  }

  if(player isskydiving()) {
    return false;
  }

  if(istrue(player.isjuggernaut)) {
    if(isDefined(level.showuseresultsfeedback)) {
      player[[level.showuseresultsfeedback]](16);
      return false;
    }
  }

  if(isDefined(player.manuallyjoiningkillstreak) && player.manuallyjoiningkillstreak) {
    return false;
  }

  if(istrue(player.iscarrying)) {
    if(isDefined(level.showuseresultsfeedback)) {
      player[[level.showuseresultsfeedback]](3);
      return false;
    }
  }

  currentweapon = player getcurrentweapon();

  if(isDefined(currentweapon)) {
    if(!valid_carriable_pickup_weapon(currentweapon)) {
      player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
      return false;
    }
  }

  nextweapon = player.changingweapon;

  if(isDefined(nextweapon) && player isswitchingweapon()) {
    if(!valid_carriable_pickup_weapon(nextweapon)) {
      return false;
    }
  }

  if(player isanymonitoredweaponswitchinprogress()) {
    nextweapon = player getcurrentmonitoredweaponswitchweapon();

    if(!valid_carriable_pickup_weapon(nextweapon)) {
      return false;
    }
  }

  if(player isusingremote()) {
    return false;
  }

  if(istrue(self.fuselit)) {
    return false;
  }

  if(istrue(player.insertingarmorplate)) {
    return false;
  }

  return true;
}

function carriable_throw_watch(carriable) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  extra_pitch = 0;
  force = getdvarfloat(@ "hash_30e08e7aa2432f46", 500);
  spawnorigin = undefined;

  while(true) {
    self waittill("grenade_fire", projectile, objweapon);

    if(objweapon != carriable.carriabletype.weaponref) {
      continue;
    }

    if(isDefined(projectile)) {
      spawnorigin = projectile.origin;
      waitframe();
      projectile delete();
    }

    self setweaponammoclip(carriable.carriabletype.weaponref, 0);
    break;
  }

  if(self issprintsliding()) {
    extra_pitch = -12;
    force += 200;
  }

  playerangles = self getplayerangles();
  playerangles += (extra_pitch, 0, 0);
  playerangles = (clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
  dir = anglesToForward(playerangles);
  carriable thread carriable_physics_launch_drop(dir * force, self, spawnorigin);
}

function disable_weapon_swap_until_swap_finished() {
  self disableweaponswitch();
  waittill_any_3("weapon_change", "death_or_disconnect", "drop_object");
  self enableweaponswitch();
}

function carriable_weapon_change_watch(carriable) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  thread disable_weapon_swap_until_swap_finished();

  while(true) {
    self waittill("weapon_change", objweapon);

    if(!isDefined(objweapon)) {
      continue;
    }

    if(objweapon != carriable.carriabletype.weaponref) {
      break;
    }
  }

  carriable thread carriable_set_dropped(0);
}

function carriable_error_messsage_watch() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  while(true) {
    self waittill("lethal_attempt_carriable");
    scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
  }
}

function carriable_player_state_drop_watch(carriable) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  while(true) {
    if(self isskydiving()) {
      break;
    }

    if(scripts\mp\supers::issuperinuse()) {
      break;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      break;
    }

    if(self isinexecutionattack() || self isinexecutionvictim()) {
      break;
    }

    waitframe();
  }

  carriable thread carriable_set_dropped(0);
}

function carriable_fuse_light_watch(carriable) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  while(true) {
    self waittill("fuse_attempt_carriable");

    if(self getcurrentweapon() == carriable.carriabletype.weaponref && !self attackButtonPressed()) {
      fadeouttime = self getgestureanimlength("ges_gas_can_ignite");
      thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_gas_can_ignite", fadeouttime);
      wait fadeouttime;
      carriable thread carriable_lightfuse(self);
      return;
    }
  }
}

function carriable_player_death_watch(carriable) {
  level endon("game_ended");
  self endon("drop_object");
  self waittill("death_or_disconnect");
  playerangles = self getplayerangles();
  playerangles = (clamp(playerangles[0], -85, 85), absangleclamp180(playerangles[1]), 0);
  dir = anglesToForward(playerangles);
  force = 90;
  carriable thread carriable_physics_launch_drop(dir * force, self);
}

function carriable_physics_launch(force, droppingplayer, spawnorigin) {
  self.origin_prev = undefined;
  owner = self;

  if(!isDefined(spawnorigin)) {
    if(isDefined(droppingplayer)) {
      spawnorigin = droppingplayer getEye();
    } else {
      spawnorigin = self.origin;
    }
  }

  if(isDefined(droppingplayer)) {
    var_882333c824d8554b = vectortoangles((force[0], force[1], -45));
    var_882333c824d8554b += (0, 0, -45);
    self.angles = var_882333c824d8554b;
    owner = droppingplayer;
    right = anglestoright(force);
    origin = spawnorigin + (right[0], right[1], 0) * 7;

    if(droppingplayer issprintsliding()) {
      origin += (0, 0, 10);
    }

    startpos = origin;
    delta = vectorNormalize(force) * 80;
    content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
    contentoverride = physics_createcontents(content);
    trace = scripts\engine\trace::sphere_trace(startpos, startpos + delta, 38, droppingplayer, contentoverride);

    if(trace["fraction"] < 1) {
      t = 0.7 * trace["fraction"];
      self.origin = startpos + delta * t;
    } else {
      self.origin = trace["position"];
    }
  }

  self dontinterpolate();
  self physicslaunchserver(self.origin, force);
}

function carriable_watch_for_physics_collison() {
  self endon("death");
  self endon("explode");
  self endon("pickup");

  while(true) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);

    if(!istrue(self.fuselit)) {
      continue;
    }

    if(isDefined(ent) && isDefined(ent.vehiclename)) {
      if(!isDefined(self.owner)) {
        driver = vehicle_occupancy_getdriver(ent);

        if(!isDefined(driver) || !isPlayer(driver)) {
          continue;
        }

        self.owner = driver;
      }

      thread carriable_explode();
      break;
    }
  }
}

function carriable_physics_launch_drop(force, droppingplayer, spawnorigin) {
  self.moverdoesnotkill = 1;
  carriable_set_dropped(1);
  carriable_physics_launch(force, droppingplayer, spawnorigin);
  carriable_ready();
}

function carriable_set_dropped(skip_physics) {
  var_cd8246fc3bc0c25e = 40;
  drop_height_offset = 11;
  var_c0bd1ff563abb64 = 7.1;

  if(!isDefined(skip_physics)) {
    skip_physics = 0;
  }

  self.droptime = gettime();
  self notify("dropped");
  dropangles = (0, 0, 0);
  carrier = self.carrier;

  if(isDefined(carrier) && carrier.team != "spectator") {
    droporigin = carrier.origin;
    dropangles = carrier.angles;
    carrier notify("drop_object");
    carrier setclientomnvar("ui_gas_can_status", 0);
  } else {
    droporigin = self.start_origin;
  }

  angles = (0, dropangles[1], 0);
  forward = anglesToForward(angles);
  droporigin += (0, 0, drop_height_offset) + var_c0bd1ff563abb64 * forward;
  self.origin = droporigin;
  self.angles = dropangles;
  self show();
  linkedparent = self getlinkedparent();

  if(isDefined(linkedparent)) {
    self unlink();
  }

  carrier_cleanup();
  self dontinterpolate();
  self.ownerteam = "any";

  if(!skip_physics) {
    velocity = forward * var_cd8246fc3bc0c25e;
    carriable_physics_launch(velocity);
    carriable_ready();
  }

  return true;
}

function carrier_cleanup() {
  if(isDefined(self.carrier)) {
    self.carrier.iscarrying = 0;
    self setotherent(undefined);
    self.carrier thread carrier_remove_carriable_weapon();
    self.carrier val::reset_all("carriable");

    if(!isai(self.carrier)) {
      self.carrier notifyonplayercommandremove("lethal_attempt_carriable", "+frag");
      self.carrier notifyonplayercommandremove("lethal_attempt_carriable", "+smoke");
      self.carrier notifyonplayercommandremove("fuse_attempt_carriable", "+speed_throw");

      if(!self.carrier isconsoleplayer()) {
        self.carrier notifyonplayercommandremove("fuse_attempt_carriable", "+toggleads_throw");
      }
    }

    self.carrier allowmelee(1);
    self.carrier allowsupersprint(1);
    self.carrier = undefined;
  }
}

function carrier_remove_carriable_weapon() {
  self endon("death_or_disconnect");

  foreach(carriabletype in level.carriabletypes) {
    if(self getcurrentweapon() == carriabletype.weaponref) {
      if(self getweaponammoclip(carriabletype.weaponref) == 0) {
        wait 0.3;
        self switchtoweaponimmediate(self.prepickupweapon);
      } else {
        self switchtoweaponimmediate(self.prepickupweapon);
      }

      self takeweapon(carriabletype.weaponref);
      break;
    }

    if(self hasweapon(carriabletype.weaponref)) {
      self takeweapon(carriabletype.weaponref);
      break;
    }
  }
}

function dangercircletick_carriable(dangercircleorigin, dangercircleradius, thresholdradius) {
  if(!isDefined(level.usablecarriables)) {
    return;
  }

  radiussquared = dangercircleradius * dangercircleradius;

  foreach(carriable in level.usablecarriables) {
    if(isDefined(carriable) && !carriable islinked() && distance2dsquared(carriable.origin, dangercircleorigin) > radiussquared) {
      carriable delete();
    }
  }
}

function carriable_inactive_delete_wait() {
  self endon("death");
  self endon("explode");
  self endon("pickup");
  inactivetime = getdvarfloat(@ "hash_4e50a1220c7fd1b7", 300);

  if(inactivetime == 0) {
    return;
  }

  wait inactivetime;
  self delete();
}

function carriable_detonate_propane() {
  phyexpmagnitude = 2;
  bottom = self.origin + (0, 0, -96);
  end_pos = physicstrace(self.origin, bottom);
  inairdetonation = end_pos == bottom;
  detonatestate = "detonateGround";

  if(inairdetonation) {
    detonatestate = "detonateAir";
  }

  fxscriptable = spawnscriptable("br_carriable_explosion_propane", self.origin, self.angles);
  fxscriptable setscriptablepartstate("carrible_explode_base", detonatestate);
  fxscriptable thread cleanupexplosionleftovers(5);
  burnsource = spawn("script_origin", self.origin);
  burnsource.angles = self.angles;
  burnsource.owner = self.owner;
  burnsource.team = self.team;
  burnsource.script_noteworthy = "fake_molotov";
  burnsource.weapon_name = "gas_can_mp";

  if(isPlayer(self.owner)) {
    self radiusdamage(burnsource.origin, 250, 400, 1, self.owner, "MOD_EXPLOSIVE", "c4_mp");
  } else {
    self radiusdamage(burnsource.origin, 250, 400, 1, undefined, "MOD_EXPLOSIVE", "c4_mp");
  }

  var_6f03a584827203cb = "gas_can_fire_spout";
  var_3643807096870f55 = 3;

  var_3643807096870f55 = getdvarint(@ "hash_2a07d883d78a5551", 3);

  level.carriablemagicgrenades = array_removedead(level.carriablemagicgrenades);
  i = 0;
  vecarray = getfirespoutlaunchvectors(var_3643807096870f55);

  while(i < var_3643807096870f55) {
    if(level.carriablemagicgrenades.size >= 12) {
      break;
    }

    grenade = magicgrenademanual(var_6f03a584827203cb, self.origin + vecarray[i] * 0.02, vecarray[i], 5);
    level.carriablemagicgrenades = array_add(level.carriablemagicgrenades, grenade);
    grenade thread firespoutwatch(burnsource);
    i++;
  }

  if(end_pos != bottom) {
    burnsource scripts\mp\equipment\molotov::molotov_simulate_impact(burnsource, end_pos, (0, 0, 0), undefined, (0, 0, 0), gettime());
  } else if(level.carriablemagicgrenades.size < 12) {
    grenade = magicgrenademanual(var_6f03a584827203cb, self.origin + (0, 0, -30), (0, 0, -200), 5);
    level.carriablemagicgrenades = array_add(level.carriablemagicgrenades, grenade);
    grenade thread firespoutwatch(burnsource);
  }

  burnsource thread cleanupexplosionleftovers(30);
}

function getfirespoutlaunchvectors(numvectors) {
  vecarray = [];

  if(numvectors <= 0) {
    return vecarray;
  }

  var_61c09649126ded45 = 360 / numvectors;
  var_d470a1b4d4afb175 = randomfloatrange(-1 * var_61c09649126ded45, var_61c09649126ded45);

  for(i = 0; i < numvectors; i++) {
    randomoffset = randomfloatrange(-0.5 * var_61c09649126ded45, 0.5 * var_61c09649126ded45);
    angle = i * var_61c09649126ded45 + randomoffset + var_d470a1b4d4afb175;
    dir = vectorNormalize(rotatepointaroundvector((0, 0, 1), (0, 0.7, 0.7), angle));
    power = randomfloatrange(250, 400);
    vecarray[vecarray.size] = dir * power;
  }

  return vecarray;
}

function firespoutwatch(burnsource) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", stuckto);
  burnsource scripts\mp\equipment\molotov::molotov_simulate_impact(burnsource, self.origin, burnsource.angles, undefined, (0, 0, 0), gettime());
  level.carriablemagicgrenades = array_remove(level.carriablemagicgrenades, self);
  self delete();
}

function cleanupexplosionleftovers(waittime) {
  self endon("death");

  if(!isDefined(waittime)) {
    waittime = 5;
  }

  wait waittime;

  if(isDefined(self)) {
    if(isent(self)) {
      self delete();
      return;
    }

    self freescriptable();
  }
}

function carriable_detonate_neurotoxin() {
  phyexpmagnitude = 2;
  bottom = self.origin + (0, 0, -96);
  end_pos = physicstrace(self.origin, bottom);
  inairdetonation = end_pos == bottom;
  gasowner = self.owner;

  if(!isPlayer(gasowner)) {
    gasowner = undefined;
  }

  detonatestate = "detonateGround";

  if(inairdetonation) {
    detonatestate = "detonateAir";
  }

  fxscriptable = spawnscriptable("br_carriable_explosion_neurotoxin", self.origin, self.angles);
  fxscriptable setscriptablepartstate("carrible_explode_base", detonatestate);
  self radiusdamage(self.origin, 150, 250, 1, gasowner, "MOD_EXPLOSIVE");
  thread neurotoxin_damage_loop(fxscriptable, inairdetonation, gasowner);
}

function neurotoxin_damage_loop(fxscriptable, inairdetonation, owner) {
  carriabletype = self.carriabletype;
  centerpoint = self.origin;
  detonatestate = "groundLoop";

  if(inairdetonation) {
    detonatestate = "airLoop";
  }

  fxscriptable setscriptablepartstate("carrible_neurotoxin_loop", detonatestate);
  level add_neurotoxin_damage_area(centerpoint, owner);
  wait float(30);

  if(isDefined(fxscriptable)) {
    fxscriptable setscriptablepartstate("carrible_neurotoxin_loop", "gasEnd");
    fxscriptable thread cleanupexplosionleftovers(5);
  }
}

function add_neurotoxin_damage_area(cloudorigin, owner) {
  if(!isDefined(level.active_neurotoxin_clouds)) {
    level.active_neurotoxin_clouds = [];
  }

  gascloud = spawnStruct();
  gascloud.cloudorigin = cloudorigin;
  gascloud.damageendtime = gettime() + 30000;
  gascloud.owner = owner;
  level.active_neurotoxin_clouds = array_add(level.active_neurotoxin_clouds, gascloud);

  if(level.active_neurotoxin_clouds.size > 1) {
    return;
  }

  level thread neurotoxin_damage_monitor();
}

function neurotoxin_damage_monitor() {
  var_819be75f52a5761d = 250;
  damagetick = 9;

  while(level.active_neurotoxin_clouds.size > 0) {
    var_49b5eb24f5905b4a = [];
    var_eeb0840267726c6d = [];

    foreach(cloud in level.active_neurotoxin_clouds) {
      if(gettime() > cloud.damageendtime) {
        var_49b5eb24f5905b4a[var_49b5eb24f5905b4a.size] = cloud;
        continue;
      }

      sphere(cloud.cloudorigin, var_819be75f52a5761d, (0, 1, 0), 1, 60);

      players = scripts\mp\utility\player::getplayersinradius(cloud.cloudorigin, var_819be75f52a5761d);

      foreach(player in players) {
        player.cloudref = cloud;
      }

      var_eeb0840267726c6d = array_combine_unique(var_eeb0840267726c6d, players);
    }

    foreach(player in var_eeb0840267726c6d) {
      if(!isDefined(player.cloudref)) {
        continue;
      }

      if(player.team == player.cloudref.owner.team && player != player.cloudref.owner) {
        player.cloudref = undefined;
        continue;
      }

      if(scripts\cp_mp\gasmask::hasgasmask(player)) {
        player thread neurotoxin_mask_monitor();

        if(isDefined(level.var_f26b4e7eb9af8155)) {
          player[[level.var_f26b4e7eb9af8155]]("carriable_neurotoxin");
        } else if(!istrue(player.gasmaskequipped)) {
          player notify("toggle_gasmask");
        }

        player scripts\cp_mp\gasmask::processdamage(damagetick);
      } else {
        player dodamage(damagetick, player.origin, player.cloudref.owner, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
        player scripts\cp_mp\armor::damagearmor(damagetick);
        player scripts\mp\gametypes\br_circle::tryplaycoughaudio();
      }

      player.cloudref = undefined;
    }

    if(var_49b5eb24f5905b4a.size > 0) {
      level.active_neurotoxin_clouds = array_remove_array(level.active_neurotoxin_clouds, var_49b5eb24f5905b4a);
    }

    wait 1;
  }
}

function neurotoxin_mask_monitor() {
  player = self;
  var_7e851b02c3682e05 = 1100;

  if(!isDefined(player.inneurotoxintimestamp)) {
    player.inneurotoxintimestamp = gettime();

    while(!istrue(player.gasmaskequipped) || gettime() < player.inneurotoxintimestamp + var_7e851b02c3682e05) {
      wait 0.5;
    }

    player.inneurotoxintimestamp = undefined;

    if(isDefined(level.var_c57ee1e174e42601)) {
      player[[level.var_c57ee1e174e42601]]("carriable_neurotoxin");
      return;
    }

    if(istrue(player.gasmaskequipped)) {
      player notify("toggle_gasmask");
    }

    return;
  }

  player.inneurotoxintimestamp = gettime();
}

function function_a48e852b0f6a3295(args) {
  level notify("<dev string:xf0>");
  level endon("<dev string:xf0>");

  if(!isDefined(args)) {
    return;
  }

  drawdist = float(args);

  if(drawdist == 0) {
    return;
  }

  var_d6e1169355081a8e = drawdist * drawdist;
  var_f6765e70dd9ad53f = getentitylessscriptablearray("<dev string:x109>", "<dev string:x12c>");
  var_187ccfe910b75663 = getentitylessscriptablearray("<dev string:x139>", "<dev string:x12c>");
  var_dc44d971ba523f8 = array_combine(var_f6765e70dd9ad53f, var_187ccfe910b75663, level.var_62e26ec58fa61b3);

  while(true) {
    foreach(carriable in var_dc44d971ba523f8) {
      var_5479151c606b66f8 = distance2dsquared(carriable.origin, level.players[0].origin);

      if(var_5479151c606b66f8 < var_d6e1169355081a8e) {
        if(var_5479151c606b66f8 < 1000000) {
          name = "<dev string:x15f>";

          if(carriable.type == "<dev string:x16a>") {
            name = "<dev string:x185>";
          }

          print3d(carriable.origin + (0, 0, 10), name, (1, 1, 1), 1, 0.95, 62, 1);
          continue;
        }

        print3d(carriable.origin + (0, 0, 0), "<dev string:x193>", (0, 1, 0), 1, 1.9, 62, 1);
      }
    }

    wait 1;
  }
}

# /