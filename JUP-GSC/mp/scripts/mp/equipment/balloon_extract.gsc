/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\balloon_extract.gsc
*******************************************************/

#using script_2d9d24f7c63ac143;
#using script_48614492ef09b23;
#using script_6fc415ff6a905dc1;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\pmc_missions;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#namespace balloon_extract;

function function_9b095d72f2911ec8() {
  game["dialog"]["plunder_extract_fail_fulton"] = "plunder_plunder_extract_fail_fulton";
  level._effect["vfx_fulton_explode"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_fulton_destr.vfx");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("balloon_extract_use", &function_cf1b1f86951a9209);
  level.var_392f3323920e27f8 = getdvarint(@ "hash_780b498909ad7b76", 4) - 1;
  level.var_3b87ef46ee857a23 = [];
}

function function_231a038d18c51203(grenade) {
  self endon("death_or_disconnect");
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto)) {
    function_f4dacbd721b7c845(grenade, stuckto);

    if(!isDefined(grenade.moving_platform)) {
      self playlocalsound("br_pickup_deny");
      scripts\mp\hud_message::showerrormessage("MP/EXTRACT_BALLOON_CANNOT_PLACE");

      if(isDefined(self.super)) {
        function_28c5995798975a53();
      }

      grenade delete();
      return;
    }
  }

  if(!function_7abaca741b57cec(grenade)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::showerrormessage("MP/EXTRACT_BALLOON_BLOCKED");

    if(isDefined(self.super)) {
      function_28c5995798975a53();
    }

    grenade delete();
    return;
  } else if(1 && isDefined(self.balloon)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::showerrormessage("MP/EXTRACT_BALLOON_TOO_MANY");

    if(isDefined(self.super)) {
      function_28c5995798975a53();
    }

    grenade delete();
    return;
  }

  if(isDefined(self.super)) {
    scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  }

  function_91bcbeaba08b3c76(grenade);

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function function_91bcbeaba08b3c76(grenade) {
  balloon = spawn("script_model", grenade.origin);
  balloon setautoboxcalculationusingdobj(1);
  balloon setModel("military_skyhook_far_mp_ballon_extract");
  balloon.angles = grenade.angles * (0, 1, 0);
  balloon.owner = self;
  balloon.team = self.team;

  if(isDefined(grenade.moving_platform)) {
    balloon.moving_platform = grenade.moving_platform;
  }

  self.balloon = balloon;
  balloon function_5b3519ad8f058a26();
}

function function_5b3519ad8f058a26() {
  playsoundatpos(self.origin, "iw9_extraction_balloon_drop");
  thread scripts\mp\gametypes\br::teamsplashbr("br_fulton_device_placed", self.owner, self.team);

  if(isDefined(self.moving_platform)) {
    self linkTo(self.moving_platform);
  }

  thread function_9f3765a323f6212a();
}

function function_9f3765a323f6212a() {
  level endon("game_ended");
  scriptable = self getlinkedscriptableinstance();
  scriptable.noweaponslot = !getdvarint(@ "hash_1d7f857b2cd9dba2", 0);
  self setscriptablepartstate("anims", "opening");
  self setscriptablepartstate("balloon_extract_use", "usable");
  var_c0bc9948aab59ac2 = [];

  foreach(player in level.players) {
    if(player.team == self.team) {
      var_c0bc9948aab59ac2[var_c0bc9948aab59ac2.size] = player;
      player scripts\mp\hud_message::showerrormessage("MP/BALLOON_EXTRACT_TIP");
      continue;
    }

    scriptable disablescriptableplayeruse(player);
  }

  wait function_d55141fe77fa88e8();
  self setscriptablepartstate("anims", "open");
  thread function_26e3ede964cf78d9(var_c0bc9948aab59ac2);
  wait 30;
  self setscriptablepartstate("balloon_extract_use", "unusable");
  self setscriptablepartstate("effects", "neutral");

  foreach(player in scriptable.playeropen) {
    if(isalive(player)) {
      player setclientomnvar("loot_container_open", 0);
    }
  }

  self setscriptablepartstate("anims", "takeoff");
  wait function_529acf4763e6abc7();
  scriptable function_8e5aab643e51aaf9();
  self notify("death");
  self delete();
}

function function_8e5aab643e51aaf9() {
  foreach(player in self.playeropen) {
    if(!isDefined(self.playercontents)) {
      continue;
    }

    println(player getplayerdata(level.var_5d69837cf4db0407, "<dev string:x1c>") + "<dev string:x2d>");
    println(player.name + "<dev string:x57>");
    player namespace_aead94004cf4c147::printinventory();
    var_e1cf43f3ae9d77e7 = function_9e02f22decaaaf1f(self.playercontents[player.guid].contents);
    totalcash = player namespace_512200f0f9e6ebc9::function_e2f4f470c55123b8(var_e1cf43f3ae9d77e7, 1);
    println(player getplayerdata(level.var_5d69837cf4db0407, "<dev string:x1c>") + "<dev string:x88>");

    foreach(item in self.playercontents[player.guid].contents) {
      ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(item["lootID"]);
      var_25978461c6e4f61b = level.br_pickups.var_838863c4848d4c26[ref];
      itemtype = undefined;

      if(isDefined(var_25978461c6e4f61b)) {
        itemtype = level.br_pickups.br_itemtype[var_25978461c6e4f61b];
      }

      if(isDefined(itemtype) && (itemtype == #"valuable" || itemtype == #"dogtag")) {
        continue;
      }

      player namespace_512200f0f9e6ebc9::function_c324d060cde743e3(item["lootID"], item["quantity"]);
    }

    weaponslotid = player scripts\mp\loot::function_d6a3266145bab76d("loot_container_weapon");

    if(istrue(weaponslotid)) {
      player namespace_512200f0f9e6ebc9::function_c324d060cde743e3(weaponslotid, 1);
    }

    println(player.name + "<dev string:xb0>");
    player namespace_aead94004cf4c147::printinventory();
    var_68c58fc50db46dc6 = player getplayerdata(level.var_5d69837cf4db0407, "dmzBankedCash");
    player setplayerdata(level.var_5d69837cf4db0407, "dmzBankedCash", var_68c58fc50db46dc6 + totalcash);
    weaponitem = undefined;

    if(istrue(weaponslotid)) {
      weaponitem = spawnStruct();
      weaponitem.lootid = weaponslotid;
      weaponitem.quantity = 1;
      var_e1cf43f3ae9d77e7[var_e1cf43f3ae9d77e7.size] = weaponitem;
    }

    scripts\mp\pmc_missions::function_b0537ee3a491b4dd(player, var_e1cf43f3ae9d77e7, totalcash);

    if(!istrue(self.noweaponslot)) {
      player setclientomnvar("loot_container_weapon", 0);
    }

    player.ballooncontents = undefined;
  }
}

function function_d55141fe77fa88e8() {
  return [[level.var_74320167a9d0ecac]]("wm_skyhook_ground_open");
}

function function_529acf4763e6abc7() {
  return [[level.var_74320167a9d0ecac]]("wm_skyhook_ground_takeoff");
}

function function_f4dacbd721b7c845(grenade, stuckto) {
  if(isDefined(stuckto.linked_brush)) {
    if(isDefined(stuckto.linked_brush.targetname)) {
      if(stuckto.linked_brush.targetname == "train_wz") {
        grenade.moving_platform = stuckto;
      }
    }

    return;
  }

  if(isDefined(stuckto.targetname) && stuckto.targetname == "train_wz") {
    grenade.moving_platform = stuckto;
  }
}

function function_28c5995798975a53() {
  self setweaponammoclip(self.super.staticdata.weapon, 1);
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  superinfo = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::setsuperisinuse(0);
  scripts\mp\supers::setsuperexpended(0);
  superinfo.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}

function function_7abaca741b57cec(grenade) {
  var_57f6e7d1be00d5f9 = 25;
  planeflyheight = scripts\cp_mp\parachute::getc130height();
  start = grenade.origin + (0, 0, var_57f6e7d1be00d5f9 + 1);
  end = (grenade.origin[0], grenade.origin[1], planeflyheight);
  contents = create_contents(0, 1, 1, 1, 1, 1, 0);
  trc = sphere_trace(start, end, var_57f6e7d1be00d5f9, grenade, contents);
  return trc["fraction"] == 1;
}

function function_9e02f22decaaaf1f(contents) {
  var_1c1dd30a3c77139c = [];

  foreach(key, item in contents) {
    var_1c1dd30a3c77139c[key] = spawnStruct();
    var_1c1dd30a3c77139c[key].lootid = item["lootID"];
    var_1c1dd30a3c77139c[key].quantity = item["quantity"];
    var_1c1dd30a3c77139c[key].index = item["index"];
  }

  return var_1c1dd30a3c77139c;
}

function function_cbca59c109ae17af(itemtype, itemindex) {
  switch (itemtype) {
    case 0:
      return [8395, 5];
    case 1:
      if(itemindex == 2) {
        if(!namespace_aead94004cf4c147::function_efab78b72d131d76(self)) {
          return [0, 0, undefined];
        }

        lootid = self getplayerdata(level.var_5d69837cf4db0407, "dmzWeapon", "lootItemID");
        var_ec22a950f210e39 = namespace_aead94004cf4c147::function_2985254128b1c262(self);
        return [lootid, 1, var_ec22a950f210e39];
      }

      var_ec22a950f210e39 = scripts\mp\gametypes\br_pickups::function_13ecf3644442a3e7(self, itemindex);

      if(!isDefined(var_ec22a950f210e39)) {
        return [0, 0, undefined];
      }

      rootname = scripts\cp_mp\weapon::getweaponrootname(var_ec22a950f210e39);
      variantid = var_ec22a950f210e39.variantid;

      if(!isDefined(var_ec22a950f210e39.variantid)) {
        variantid = 0;
      }

      lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);
      return [lootid, 1, var_ec22a950f210e39];
    case 10:
      lootid = namespace_aead94004cf4c147::getlootidatbackpackindex(itemindex);
      quantity = 1;

      if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(lootid)) {
        quantity = namespace_aead94004cf4c147::function_897b29adb37f06a7(itemindex);
      }

      return [lootid, quantity];
    case 2:
      slot = scripts\mp\equipment::function_4967838290cb31b9(itemindex);

      if(!isDefined(self.equipment[slot])) {
        return [0, 0];
      }

      var_feb782334dd23a66 = array_find(level.br_pickups.br_equipname, self.equipment[slot]);
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
      return [lootid, 1];
    case 3:
      if(!isDefined(self.streakdata.streaks[1])) {
        return [0, 0];
      }

      scriptable = level.br_pickups.var_838863c4848d4c26[self.streakdata.streaks[1].streakname];
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptable);
      return [lootid, 1];
    case 4:
      if(!isDefined(self.equipment["super"])) {
        return [0, 0];
      }

      var_feb782334dd23a66 = array_find(level.br_pickups.br_equipname, self.equipment["super"]);
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_feb782334dd23a66);
      return [lootid, 1];
    default:
      assertmsg("<dev string:xdf>" + itemtype);
      return;
  }
}

function function_26e3ede964cf78d9(players) {
  if(players.size <= 0) {
    level notify("balloon_extract_takeoff");
    return;
  }

  if(!isDefined(level.var_3b87ef46ee857a23)) {
    level.var_3b87ef46ee857a23 = [];
  }

  if(isDefined(level.var_3b87ef46ee857a23[self.team])) {
    level.var_3b87ef46ee857a23[self.team] notify("balloon_extract_countdown_started");
  }

  level.var_3b87ef46ee857a23[self.team] = self;
  self endon("balloon_extract_countdown_started");
  level endon("game_ended");
  currenttime = gettime();
  endtime = currenttime + 30 * 1000;

  while(currenttime < endtime) {
    if(gettime() - currenttime >= 1000) {
      msgvalue = int(max(0, (endtime - gettime()) / 1000));

      foreach(player in players) {
        if(isDefined(player) && isalive(player) && !player scripts\mp\gametypes\br_public::isplayeringulag()) {
          player scripts\mp\hud_message::showerrormessage("MP/BALLOON_EXTRACT_LEAVING_IN", msgvalue);
        }
      }

      currenttime = gettime();
    }

    wait 0.05;
  }

  level.var_3b87ef46ee857a23[self.team] = undefined;
}

function function_6de1128240216723(itemtype, lootid) {
  if(itemtype == 1) {
    return true;
  }

  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(scriptablename == "brloot_durable_loot" || isDefined(level.var_a98214b4bdc952cd) && array_contains(level.var_a98214b4bdc952cd, scriptablename)) {
    return true;
  }

  return false;
}

function function_f71f8470e2fb527c(player) {
  playerbackpacksize = namespace_aead94004cf4c147::getplayerbackpacksize(player);
  var_bb778d2be7708cfc = 0;

  for(i = 0; i < playerbackpacksize; i++) {
    slotlootid = player namespace_aead94004cf4c147::getlootidatbackpackindex(i);

    if(!isDefined(slotlootid)) {
      continue;
    }

    lootname = namespace_aead94004cf4c147::function_91c1be871300a518(slotlootid);

    if(!isDefined(lootname)) {
      continue;
    }

    if(lootname == "brloot_durable_loot") {
      player function_f184ae16fb9720f3(i);
      var_bb778d2be7708cfc = 1;
      return;
    }
  }

  if(var_bb778d2be7708cfc) {
    player namespace_a850435086c88de3::doonactionscoreevent(1, "extractionBalloonDeposit");
  }
}

function function_f184ae16fb9720f3(slotnum) {
  thread namespace_aead94004cf4c147::function_db1dd76061352e5b(slotnum, 1);
  thread scripts\mp\hud_message::showsplash("br_durable_loot_item_extracted");
}